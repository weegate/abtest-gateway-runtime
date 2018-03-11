#!/bin/bash
#for *www* user

#deploy
cd /home/www/gateway/
if [ -d /home/www/gateway/demo-api-gateway-admin ];then
	git clone -b admin-lua-api git@demordcode.demo.so:global_backend/demo-api-gateway.git demo-api-gateway-admin
else
	git pull origin admin-lua-api
fi

mkdir -p /data/logs/gateway/demo-api-gateway-admin
cd /home/www/gateway/demo-api-gateway-admin/run/

[ ! -s /home/www/gateway/demo-api-gateway-admin/run/logs ] && ln -s /data/logs/gateway/demo-api-gateway-admin /home/www/gateway/demo-api-gateway-admin/run/logs

#run
pid=`cat /home/www/gateway/demo-api-gateway-admin/run/logs/nginx_qa_gateway.pid`
run_pid=`ps -ef | grep $pid | grep -v grep`
if [ "x$run_pid" == "x" ]; then
	/data/openresty/1.11.2.5/nginx/sbin/nginx -p /home/www/gateway/demo-api-gateway-admin/run -c conf/gateway_qa.conf
else
	/data/openresty/1.11.2.5/nginx/sbin/nginx -p /home/www/gateway/demo-api-gateway-admin/run -c conf/gateway_qa.conf -s reload
fi


