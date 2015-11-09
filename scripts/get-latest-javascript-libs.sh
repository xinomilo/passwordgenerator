#!/bin/bash

# ------------------------------------------------------------
# Bash script I run on my web server thats updates jquery
# min lib. Easy enough to follow and customize if need be.
#
# * Be sure to modify JS_LIBS_DIR (Root save path).
#
# 	- jquery.min.js
#
# @author Jon LaBelle, jonlabelle.com
# @date May 8, 2011
#
# @modifier xinomilo
# @date Nov 9, 2015
#
# CRON SCHEDULE (Weekly on Sunday at 1:55 AM)
# 	55 1 * * 0 /etc/cron.d/get-latest-javascript-libs.sh
# ------------------------------------------------------------

CURL_USER_AGENT="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko" # user agent for curl = Windows 7, MS Internet Explorer 11
JS_LIBS_DIR="/path/to/jquery.min.js" # Root save path

function download_file() {
	# curl ops: silent, insecure, redirects, file output
	curl -s -k -l -o $1 -A '$CURL_USER_AGENT' $2;
	echo "`pwd`/$1 - UPDATED!"
}

function unzip_file() {
	# unzip ops: overwrite without prompting, quiet mode
	unzip -o -q $1;
}

function update_jquery() {

	JQUERY_LATEST_MIN_URL="https://code.jquery.com/jquery-latest.min.js"

	cd $JS_LIBS_DIR;
	download_file 	jquery.min.js 	$JQUERY_LATEST_MIN_URL;
}

update_jquery

exit
