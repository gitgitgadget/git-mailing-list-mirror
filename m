From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 01/12] git-remote-mediawiki: scripts to install, delete and clear a MediaWiki
Date: Thu,  5 Jul 2012 09:36:01 +0200
Message-ID: <1341473772-28023-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmgcF-0000QN-NK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2GEHgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:36:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58595 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555Ab2GEHgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657ZQDR029139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc0-0006Wq-6M; Thu, 05 Jul 2012 09:36:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Smgc0-0007hg-4P; Thu, 05 Jul 2012 09:36:28 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:35:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657ZQDR029139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078530.23701@NsLd6x213iWx5k47TX45tA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201025>

From: Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>

install_wiki.sh allows the user to install a MediaWiki instance in a
single shell command. Like "git instaweb", it configures and launches
lighttpd without requiring root priviledges. To simplify database
management, it uses SQLite, which doesn't require a running daemon, and
allows reseting the database by simply replacing a single file. This
allows install_wiki to also defines a function wiki_reset which clear all
content of the previously created wiki, which will be very useful to run
several indepenant tests on the same wiki.

Note those functionnalities are made to be used from the user command
line in the directory git/contrib/mw-to-git/t/

Signed-off-by: Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>
Signed-off-by: Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>
Signed-off-by: Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/t/.gitignore                     |   2 +
 contrib/mw-to-git/t/install-wiki.sh                |  45 ++++
 contrib/mw-to-git/t/install-wiki/.gitignore        |   1 +
 contrib/mw-to-git/t/install-wiki/LocalSettings.php | 128 +++++++++
 contrib/mw-to-git/t/install-wiki/db_install.php    | 120 +++++++++
 contrib/mw-to-git/t/test-gitmw-lib.sh              | 289 +++++++++++++++++++++
 contrib/mw-to-git/t/test.config                    |  35 +++
 7 files changed, 620 insertions(+)
 create mode 100644 contrib/mw-to-git/t/.gitignore
 create mode 100755 contrib/mw-to-git/t/install-wiki.sh
 create mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 create mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 create mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php
 create mode 100755 contrib/mw-to-git/t/test-gitmw-lib.sh
 create mode 100644 contrib/mw-to-git/t/test.config

diff --git a/contrib/mw-to-git/t/.gitignore b/contrib/mw-to-git/t/.gitignore
new file mode 100644
index 0000000..a060414
--- /dev/null
+++ b/contrib/mw-to-git/t/.gitignore
@@ -0,0 +1,2 @@
+WEB/
+wiki/
diff --git a/contrib/mw-to-git/t/install-wiki.sh b/contrib/mw-to-git/t/install-wiki.sh
new file mode 100755
index 0000000..c6d6fa3
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+# This script installs or deletes a MediaWiki on your computer.
+# It requires a web server with PHP and SQLite running. In addition, if you
+# do not have MediaWiki sources on your computer, the option 'install'
+# downloads them for you.
+# Please set the CONFIGURATION VARIABLES in ./test-gitmw-lib.sh
+
+WIKI_TEST_DIR=$(cd "$(dirname "$0")" && pwd)
+
+if test -z "$WIKI_TEST_DIR"
+then
+	WIKI_TEST_DIR=.
+fi
+
+. "$WIKI_TEST_DIR"/test-gitmw-lib.sh
+usage () {
+	echo "Usage: "
+	echo "	./install-wiki.sh <install | delete | --help>"
+	echo "		install | -i :	Install a wiki on your computer."
+	echo "		delete | -d : Delete the wiki and all its pages and "
+	echo "			content."
+}
+
+
+# Argument: install, delete, --help | -h
+case "$1" in
+	"install" | "-i")
+		wiki_install
+		exit 0
+		;;
+	"delete" | "-d")
+		wiki_delete
+		exit 0
+		;;
+	"--help" | "-h")
+		usage
+		exit 0
+		;;
+	*)
+		echo "Invalid argument: $1"
+		usage
+		exit 1
+		;;
+esac
diff --git a/contrib/mw-to-git/t/install-wiki/.gitignore b/contrib/mw-to-git/t/install-wiki/.gitignore
new file mode 100644
index 0000000..b5a2a44
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki/.gitignore
@@ -0,0 +1 @@
+wikidb.sqlite
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
new file mode 100644
index 0000000..aa72518
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
@@ -0,0 +1,128 @@
+<?php
+# This file was automatically generated by the MediaWiki 1.19.0
+# installer. If you make manual changes, please keep track in case you
+# need to recreate them later.
+#
+# See includes/DefaultSettings.php for all configurable settings
+# and their default values, but don't forget to make changes in _this_
+# file, not there.
+#
+# Further documentation for configuration settings may be found at:
+# http://www.mediawiki.org/wiki/Manual:Configuration_settings
+
+# Protect against web entry
+if ( !defined( 'MEDIAWIKI' ) ) {
+	exit;
+}
+
+## Uncomment this to disable output compression
+# $wgDisableOutputCompression = true;
+
+$wgSitename      = "Git-MediaWiki-Test";
+$wgMetaNamespace = "Git-MediaWiki-Test";
+
+## The URL base path to the directory containing the wiki;
+## defaults for all runtime URL paths are based off of this.
+## For more information on customizing the URLs please see:
+## http://www.mediawiki.org/wiki/Manual:Short_URL
+$wgScriptPath       = "@WG_SCRIPT_PATH@";
+$wgScriptExtension  = ".php";
+
+## The protocol and server name to use in fully-qualified URLs
+$wgServer           = "@WG_SERVER@";
+
+## The relative URL path to the skins directory
+$wgStylePath        = "$wgScriptPath/skins";
+
+## The relative URL path to the logo.  Make sure you change this from the default,
+## or else you'll overwrite your logo when you upgrade!
+$wgLogo             = "$wgStylePath/common/images/wiki.png";
+
+## UPO means: this is also a user preference option
+
+$wgEnableEmail      = true;
+$wgEnableUserEmail  = true; # UPO
+
+$wgEmergencyContact = "apache@localhost";
+$wgPasswordSender   = "apache@localhost";
+
+$wgEnotifUserTalk      = false; # UPO
+$wgEnotifWatchlist     = false; # UPO
+$wgEmailAuthentication = true;
+
+## Database settings
+$wgDBtype           = "sqlite";
+$wgDBserver         = "";
+$wgDBname           = "@WG_SQLITE_DATAFILE@";
+$wgDBuser           = "";
+$wgDBpassword       = "";
+
+# SQLite-specific settings
+$wgSQLiteDataDir    = "@WG_SQLITE_DATADIR@";
+
+
+## Shared memory settings
+$wgMainCacheType    = CACHE_NONE;
+$wgMemCachedServers = array();
+
+## To enable image uploads, make sure the 'images' directory
+## is writable, then set this to true:
+$wgEnableUploads  = false;
+$wgUseImageMagick = true;
+$wgImageMagickConvertCommand ="@CONVERT@";
+
+# InstantCommons allows wiki to use images from http://commons.wikimedia.org
+$wgUseInstantCommons  = false;
+
+## If you use ImageMagick (or any other shell command) on a
+## Linux server, this will need to be set to the name of an
+## available UTF-8 locale
+$wgShellLocale = "en_US.utf8";
+
+## If you want to use image uploads under safe mode,
+## create the directories images/archive, images/thumb and
+## images/temp, and make them all writable. Then uncomment
+## this, if it's not already uncommented:
+#$wgHashedUploadDirectory = false;
+
+## Set $wgCacheDirectory to a writable directory on the web server
+## to make your wiki go slightly faster. The directory should not
+## be publically accessible from the web.
+#$wgCacheDirectory = "$IP/cache";
+
+# Site language code, should be one of the list in ./languages/Names.php
+$wgLanguageCode = "en";
+
+$wgSecretKey = "1c912bfe3519fb70f5dc523ecc698111cd43d81a11c585b3eefb28f29c2699b7";
+#$wgSecretKey = "@SECRETKEY@";
+
+
+# Site upgrade key. Must be set to a string (default provided) to turn on the
+# web installer while LocalSettings.php is in place
+$wgUpgradeKey = "ddae7dc87cd0a645";
+
+## Default skin: you can change the default skin. Use the internal symbolic
+## names, ie 'standard', 'nostalgia', 'cologneblue', 'monobook', 'vector':
+$wgDefaultSkin = "vector";
+
+## For attaching licensing metadata to pages, and displaying an
+## appropriate copyright notice / icon. GNU Free Documentation
+## License and Creative Commons licenses are supported so far.
+$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
+$wgRightsUrl  = "";
+$wgRightsText = "";
+$wgRightsIcon = "";
+
+# Path to the GNU diff3 utility. Used for conflict resolution.
+$wgDiff3 = "/usr/bin/diff3";
+
+# Query string length limit for ResourceLoader. You should only set this if
+# your web server has a query string length limit (then set it to that limit),
+# or if you have suhosin.get.max_value_length set in php.ini (then set it to
+# that value)
+$wgResourceLoaderMaxQueryLength = -1;
+
+
+
+# End of automatically generated settings.
+# Add more configuration options below.
diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contrib/mw-to-git/t/install-wiki/db_install.php
new file mode 100644
index 0000000..0f3f4e0
--- /dev/null
+++ b/contrib/mw-to-git/t/install-wiki/db_install.php
@@ -0,0 +1,120 @@
+<?php
+/**
+ * This script generates a SQLite database for a MediaWiki version 1.19.0
+ * You must specify the login of the admin (argument 1) and its
+ * password (argument 2) and the folder where the database file
+ * is located (absolute path in argument 3).
+ * It is used by the script install-wiki.sh in order to make easy the
+ * installation of a MediaWiki.
+ *
+ * In order to generate a SQLite database file, MediaWiki ask the user
+ * to submit some forms in its web browser. This script simulates this
+ * behavior though the functions <get> and <submit>
+ *
+ */
+$argc = $_SERVER['argc'];
+$argv = $_SERVER['argv'];
+
+$login = $argv[2];
+$pass = $argv[3];
+$tmp = $argv[4];
+$port = $argv[5];
+
+$url = 'http://localhost:'.$port.'/wiki/mw-config/index.php';
+$db_dir = urlencode($tmp);
+$tmp_cookie = tempnam($tmp, "COOKIE_");
+/*
+ * Fetchs a page with cURL.
+ */
+function get($page_name = "") {
+	$curl = curl_init();
+	$page_name_add = "";
+	if ($page_name != "") {
+		$page_name_add = '?page='.$page_name;
+	}
+	$url = $GLOBALS['url'].$page_name_add;
+	$tmp_cookie = $GLOBALS['tmp_cookie'];
+	curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
+	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
+	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
+	curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
+	curl_setopt($curl, CURLOPT_HEADER, true);
+	curl_setopt($curl, CURLOPT_URL, $url);
+
+	$page = curl_exec($curl);
+	if (!$page) {
+		die("Could not get page: $url\n");
+	}
+	curl_close($curl);
+	return $page;
+}
+
+/*
+ * Submits a form with cURL.
+ */
+function submit($page_name, $option = "") {
+	$curl = curl_init();
+	$datapost = 'submit-continue=Continue+%E2%86%92';
+	if ($option != "") {
+		$datapost = $option.'&'.$datapost;
+	}
+	$url = $GLOBALS['url'].'?page='.$page_name;
+	$tmp_cookie = $GLOBALS['tmp_cookie'];
+	curl_setopt($curl, CURLOPT_URL, $url);
+	curl_setopt($curl, CURLOPT_POST, true);
+	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
+	curl_setopt($curl, CURLOPT_POSTFIELDS, $datapost);
+	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
+	curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
+	curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
+
+	$page = curl_exec($curl);
+	if (!$page) {
+		die("Could not get page: $url\n");
+	}
+	curl_close($curl);
+	return "$page";
+}
+
+/*
+ * Here starts this script: simulates the behavior of the user
+ * submitting forms to generates the database file.
+ * Note this simulation was made for the MediaWiki version 1.19.0,
+ * we can't assume it works with other versions.
+ *
+ */
+
+$page = get();
+if (!preg_match('/input type="hidden" value="([0-9]+)" name="LanguageRequestTime"/',
+		$page, $matches)) {
+	echo "Unexpected content for page downloaded:\n";
+	echo "$page";
+	die;
+};
+$timestamp = $matches[1];
+$language = "LanguageRequestTime=$timestamp&uselang=en&ContLang=en";
+$page = submit('Language', $language);
+
+submit('Welcome');
+
+$db_config = 'DBType=sqlite';
+$db_config = $db_config.'&sqlite_wgSQLiteDataDir='.$db_dir;
+$db_config = $db_config.'&sqlite_wgDBname='.$argv[1];
+submit('DBConnect', $db_config);
+
+$wiki_config = 'config_wgSitename=TEST';
+$wiki_config = $wiki_config.'&config__NamespaceType=site-name';
+$wiki_config = $wiki_config.'&config_wgMetaNamespace=MyWiki';
+$wiki_config = $wiki_config.'&config__AdminName='.$login;
+
+$wiki_config = $wiki_config.'&config__AdminPassword='.$pass;
+$wiki_config = $wiki_config.'&config__AdminPassword2='.$pass;
+
+$wiki_config = $wiki_config.'&wiki__configEmail=email%40email.org';
+$wiki_config = $wiki_config.'&config__SkipOptional=skip';
+submit('Name', $wiki_config);
+submit('Install');
+submit('Install');
+
+unlink($tmp_cookie);
+?>
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
new file mode 100755
index 0000000..47341f7
--- /dev/null
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -0,0 +1,289 @@
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+# License: GPL v2 or later
+
+#
+# CONFIGURATION VARIABLES
+# You might want to change these ones
+#
+
+. ./test.config
+
+CURR_DIR=$(pwd)
+TEST_OUTPUT_DIRECTORY=$(pwd)
+TEST_DIRECTORY="$CURR_DIR"/../../../t
+
+export TEST_OUTPUT_DIRECTORY TEST_DIRECTORY CURR_DIR
+
+if test "$LIGHTTPD" = "false" ; then
+	PORT=80
+else
+	WIKI_DIR_INST="$CURR_DIR/$WEB_WWW"
+fi
+
+# ================= Install part =================
+
+error () {
+	echo "$@" >&2
+	exit 1
+}
+
+# config_lighttpd
+#
+# Create the configuration files and the folders necessary to start lighttpd.
+# Overwrite any existing file.
+config_lighttpd () {
+	mkdir -p $WEB
+	mkdir -p $WEB_TMP
+	mkdir -p $WEB_WWW
+	cat > $WEB/lighttpd.conf <<EOF
+	server.document-root = "$CURR_DIR/$WEB_WWW"
+	server.port = $PORT
+	server.pid-file = "$CURR_DIR/$WEB_TMP/pid"
+
+	server.modules = (
+	"mod_rewrite",
+	"mod_redirect",
+	"mod_access",
+	"mod_accesslog",
+	"mod_fastcgi"
+	)
+
+	index-file.names = ("index.php" , "index.html")
+
+	mimetype.assign		    = (
+	".pdf"		=>	"application/pdf",
+	".sig"		=>	"application/pgp-signature",
+	".spl"		=>	"application/futuresplash",
+	".class"	=>	"application/octet-stream",
+	".ps"		=>	"application/postscript",
+	".torrent"	=>	"application/x-bittorrent",
+	".dvi"		=>	"application/x-dvi",
+	".gz"		=>	"application/x-gzip",
+	".pac"		=>	"application/x-ns-proxy-autoconfig",
+	".swf"		=>	"application/x-shockwave-flash",
+	".tar.gz"	=>	"application/x-tgz",
+	".tgz"		=>	"application/x-tgz",
+	".tar"		=>	"application/x-tar",
+	".zip"		=>	"application/zip",
+	".mp3"		=>	"audio/mpeg",
+	".m3u"		=>	"audio/x-mpegurl",
+	".wma"		=>	"audio/x-ms-wma",
+	".wax"		=>	"audio/x-ms-wax",
+	".ogg"		=>	"application/ogg",
+	".wav"		=>	"audio/x-wav",
+	".gif"		=>	"image/gif",
+	".jpg"		=>	"image/jpeg",
+	".jpeg"		=>	"image/jpeg",
+	".png"		=>	"image/png",
+	".xbm"		=>	"image/x-xbitmap",
+	".xpm"		=>	"image/x-xpixmap",
+	".xwd"		=>	"image/x-xwindowdump",
+	".css"		=>	"text/css",
+	".html"		=>	"text/html",
+	".htm"		=>	"text/html",
+	".js"		=>	"text/javascript",
+	".asc"		=>	"text/plain",
+	".c"		=>	"text/plain",
+	".cpp"		=>	"text/plain",
+	".log"		=>	"text/plain",
+	".conf"		=>	"text/plain",
+	".text"		=>	"text/plain",
+	".txt"		=>	"text/plain",
+	".dtd"		=>	"text/xml",
+	".xml"		=>	"text/xml",
+	".mpeg"		=>	"video/mpeg",
+	".mpg"		=>	"video/mpeg",
+	".mov"		=>	"video/quicktime",
+	".qt"		=>	"video/quicktime",
+	".avi"		=>	"video/x-msvideo",
+	".asf"		=>	"video/x-ms-asf",
+	".asx"		=>	"video/x-ms-asf",
+	".wmv"		=>	"video/x-ms-wmv",
+	".bz2"		=>	"application/x-bzip",
+	".tbz"		=>	"application/x-bzip-compressed-tar",
+	".tar.bz2"	=>	"application/x-bzip-compressed-tar",
+	""		=>	"text/plain"
+	)
+
+	fastcgi.server = ( ".php" =>
+	("localhost" =>
+	( "socket" => "$CURR_DIR/$WEB_TMP/php.socket",
+	"bin-path" => "$PHP_DIR/php-cgi -c $CURR_DIR/$WEB/php.ini"
+
+	)
+	)
+	)
+EOF
+
+	cat > $WEB/php.ini <<EOF
+	session.save_path ='$CURR_DIR/$WEB_TMP'
+EOF
+}
+
+# start_lighttpd
+#
+# Start or restart daemon lighttpd. If restart, rewrite configuration files.
+start_lighttpd () {
+	if test -f "$WEB_TMP/pid"; then
+		echo "Instance already running. Restarting..."
+		stop_lighttpd
+	fi
+	config_lighttpd
+	"$LIGHTTPD_DIR"/lighttpd -f "$WEB"/lighttpd.conf
+
+	if test $? -ne 0 ; then
+		echo "Could not execute http deamon lighttpd"
+		exit 1
+	fi
+}
+
+# stop_lighttpd
+#
+# Kill daemon lighttpd and removes files and folders associated.
+stop_lighttpd () {
+	test -f "$WEB_TMP/pid" && kill $(cat "$WEB_TMP/pid")
+	rm -rf "$WEB"
+}
+
+# Create the SQLite database of the MediaWiki. If the database file already
+# exists, it will be deleted.
+# This script should be runned from the directory where $FILES_FOLDER is
+# located.
+create_db () {
+	rm -f "$TMP/$DB_FILE"
+
+	echo "Generating the SQLite database file. It can take some time ..."
+	# Run the php script to generate the SQLite database file
+	# with cURL calls.
+	php "$FILES_FOLDER/$DB_INSTALL_SCRIPT" $(basename "$DB_FILE" .sqlite) \
+		"$WIKI_ADMIN" "$WIKI_PASSW" "$TMP" "$PORT"
+
+	if [ ! -f "$TMP/$DB_FILE" ] ; then
+		error "Can't create database file $TMP/$DB_FILE. Try to run ./install-wiki.sh delete first."
+	fi
+
+	# Copy the generated database file into the directory the
+	# user indicated.
+	cp "$TMP/$DB_FILE" "$FILES_FOLDER" ||
+		error "Unable to copy $TMP/$DB_FILE to $FILES_FOLDER"
+}
+
+# Install a wiki in your web server directory.
+wiki_install () {
+	if test $LIGHTTPD = "true" ; then
+		start_lighttpd
+	fi
+
+	SERVER_ADDR=$SERVER_ADDR:$PORT
+	# In this part, we change directory to $TMP in order to download,
+	# unpack and copy the files of MediaWiki
+	(
+	mkdir -p "$WIKI_DIR_INST/$WIKI_DIR_NAME"
+	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ; then
+		error "Folder $WIKI_DIR_INST/$WIKI_DIR_NAME doesn't exist.
+		Please create it and launch the script again."
+	fi
+
+	# Fetch MediaWiki's archive if not already present in the TMP directory
+	cd "$TMP"
+	if [ ! -f "$MW_VERSION.tar.gz" ] ; then
+		echo "Downloading $MW_VERSION sources ..."
+		wget "http://download.wikimedia.org/mediawiki/1.19/mediawiki-1.19.0.tar.gz" ||
+			error "Unable to download "\
+			"http://download.wikimedia.org/mediawiki/1.19/"\
+			"mediawiki-1.19.0.tar.gz. "\
+			"Please fix your connection and launch the script again."
+		echo "$MW_VERSION.tar.gz downloaded in `pwd`. "\
+			"You can delete it later if you want."
+	else
+		echo "Reusing existing $MW_VERSION.tar.gz downloaded in `pwd`."
+	fi
+	archive_abs_path=$(pwd)/"$MW_VERSION.tar.gz"
+	cd "$WIKI_DIR_INST/$WIKI_DIR_NAME/" ||
+		error "can't cd to $WIKI_DIR_INST/$WIKI_DIR_NAME/"
+	tar xzf "$archive_abs_path" --strip-components=1 ||
+		error "Unable to extract WikiMedia's files from $archive_abs_path to "\
+			"$WIKI_DIR_INST/$WIKI_DIR_NAME"
+	) || exit 1
+
+	create_db
+
+	# Copy the generic LocalSettings.php in the web server's directory
+	# And modify parameters according to the ones set at the top
+	# of this script.
+	# Note that LocalSettings.php is never modified.
+	if [ ! -f "$FILES_FOLDER/LocalSettings.php" ] ; then
+		error "Can't find $FILES_FOLDER/LocalSettings.php " \
+			"in the current folder. "\
+		"Please run the script inside its folder."
+	fi
+	cp "$FILES_FOLDER/LocalSettings.php" \
+		"$FILES_FOLDER/LocalSettings-tmp.php" ||
+		error "Unable to copy $FILES_FOLDER/LocalSettings.php " \
+		"to $FILES_FOLDER/LocalSettings-tmp.php"
+
+	# Parse and set the LocalSettings file of the user according to the
+	# CONFIGURATION VARIABLES section at the beginning of this script
+	file_swap="$FILES_FOLDER/LocalSettings-swap.php"
+	sed "s,@WG_SCRIPT_PATH@,/$WIKI_DIR_NAME," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+	sed "s,@WG_SERVER@,http://$SERVER_ADDR," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+	sed "s,@WG_SQLITE_DATADIR@,$TMP," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+	sed "s,@WG_SQLITE_DATAFILE@,$( basename $DB_FILE .sqlite)," \
+		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
+	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
+
+	mv "$FILES_FOLDER/LocalSettings-tmp.php" \
+		"$WIKI_DIR_INST/$WIKI_DIR_NAME/LocalSettings.php" ||
+		error "Unable to move $FILES_FOLDER/LocalSettings-tmp.php" \
+		"in $WIKI_DIR_INST/$WIKI_DIR_NAME"
+	echo "File $FILES_FOLDER/LocalSettings.php is set in" \
+		" $WIKI_DIR_INST/$WIKI_DIR_NAME"
+
+	echo "Your wiki has been installed. You can check it at
+		http://$SERVER_ADDR/$WIKI_DIR_NAME"
+}
+
+# Reset the database of the wiki and the password of the admin
+#
+# Warning: This function must be called only in a subdirectory of t/ directory
+wiki_reset () {
+	# Copy initial database of the wiki
+	if [ ! -f "../$FILES_FOLDER/$DB_FILE" ] ; then
+		error "Can't find ../$FILES_FOLDER/$DB_FILE in the current folder."
+	fi
+	cp "../$FILES_FOLDER/$DB_FILE" "$TMP" ||
+		error "Can't copy ../$FILES_FOLDER/$DB_FILE in $TMP"
+	echo "File $FILES_FOLDER/$DB_FILE is set in $TMP"
+}
+
+# Delete the wiki created in the web server's directory and all its content
+# saved in the database.
+wiki_delete () {
+	if test $LIGHTTPD = "true"; then
+		stop_lighttpd
+	else
+		# Delete the wiki's directory.
+		rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
+			error "Wiki's directory $WIKI_DIR_INST/" \
+			"$WIKI_DIR_NAME could not be deleted"
+		# Delete the wiki's SQLite database.
+		rm -f "$TMP/$DB_FILE" ||
+			error "Database $TMP/$DB_FILE could not be deleted."
+	fi
+
+	# Delete the wiki's SQLite database
+	rm -f "$TMP/$DB_FILE" || error "Database $TMP/$DB_FILE could not be deleted."
+	rm -f "$FILES_FOLDER/$DB_FILE"
+	rm -rf "$TMP/$MW_VERSION"
+}
diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
new file mode 100644
index 0000000..958b37b
--- /dev/null
+++ b/contrib/mw-to-git/t/test.config
@@ -0,0 +1,35 @@
+# Name of the web server's directory dedicated to the wiki is WIKI_DIR_NAME
+WIKI_DIR_NAME=wiki
+
+# Login and password of the wiki's admin
+WIKI_ADMIN=WikiAdmin
+WIKI_PASSW=AdminPass
+
+# Address of the web server
+SERVER_ADDR=localhost
+
+# SQLite database of the wiki, named DB_FILE, is located in TMP
+TMP=/tmp
+DB_FILE=wikidb.sqlite
+
+# If LIGHTTPD is not set to true, the script will use the defaut
+# web server running in WIKI_DIR_INST.
+WIKI_DIR_INST=/var/www
+
+# If LIGHTTPD is set to true, the script will use Lighttpd to run
+# the wiki.
+LIGHTTPD=true
+
+# The variables below are useful only if LIGHTTPD is set to true.
+PORT=1234
+PHP_DIR=/usr/bin
+LIGHTTPD_DIR=/usr/sbin
+WEB=WEB
+WEB_TMP=$WEB/tmp
+WEB_WWW=$WEB/www
+
+# The variables below are used by the script to install a wiki.
+# You should not modify these unless you are modifying the script itself.
+MW_VERSION=mediawiki-1.19.0
+FILES_FOLDER=install-wiki
+DB_INSTALL_SCRIPT=db_install.php
-- 
1.7.11.1.147.g47a574d
