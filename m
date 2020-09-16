Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0277FC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB4C22209
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oszC761+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIPLl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIPKcq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECAFC06121F
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z1so6351570wrt.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHDkqJLZeKQF8yQReUWnWDn8+qnjQHZOEQ3rzOZGjAQ=;
        b=oszC761+yoB6cJvqUY4cK37kF+OLBonZSQI7nt59OFFGs8QLoqYcDCsmpnsBv7vTt8
         YXh5+bxlVY2ox8kmox2HppSuvNXfb7R/dbX52Bc560/y5j608bf4Wy4G1+tQQJDmwZsj
         XPmK506ImE65K9yFwidzOlEB9AFIi8830U1SmDjdJ2eOz1KHJQ40pOAIOYWpDEn0Jilx
         Mm/1K3CqjgqPZ7t8gDfuNQfmTKDtGwYA9FifJ67J2JbWIJz1A2Y2tIsW1EQ3+vymSpsV
         cfgqlmdYhnzGsTWhFMkM8AohT6CQYoVfgY+Zn9Cplz2yOgLI5a6dZOPtYGL490jjjrYH
         oaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHDkqJLZeKQF8yQReUWnWDn8+qnjQHZOEQ3rzOZGjAQ=;
        b=YueATwRBZj05eeJMEYJkdaGGCMapWMmSnwsRbgUxyL77lW4egpdQIZQCFDKVQdAOxf
         bcua4eNiL2mofxyKf098I6jGXbEDa35bnN5LIlc8XdahfWsZ6qDFv+FiTno23Bb6kDhi
         IuKTEzfnP752XS+oYjue5rsSKM06U2yoCgY8XmmpMLNXYzxPshTuPVyEH6Qsiq3VFqTJ
         6N3ENUNLILyMiPbRESbg/WGVKdqrdpk6h36/Edzs6Ga8v0ZlwBlWdknoYbJqEbrnjmS1
         uGvUjEBknaYNacXUMG3eKXAnOw5XhojwWqz6w9TkjeGngz1JWwNoQYZAlxLBiXP/GxAF
         UBNQ==
X-Gm-Message-State: AOAM533u6b20ZVRN/vP65Gfmei2OsDZgqMo+fHE+LW+6hbx8vpXFDDXi
        UEioTV+va1LwrXXt0KNvbNHl4GIdUnl5+NEf
X-Google-Smtp-Source: ABdhPJzzpGFNy/NL6gnGnRF2TVIKWKfFjp5cDTDI8wwW/LlWFn/wwGJIZUVUkQtB/thr7JkATdHgSw==
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr24532816wrm.147.1600252212551;
        Wed, 16 Sep 2020 03:30:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/15] remote-mediawiki tests: use CLI installer
Date:   Wed, 16 Sep 2020 12:29:16 +0200
Message-Id: <20200916102918.29805-14-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the use of screen-scraping in the test environment
installation with simply invoking MediaWiki's command-line
installer.

The old code being deleted here relied on our own hardcoded POST
parameter names & the precise layout of MediaWiki's GUI installer at a
given version. Somewhere between [1] and now this inevitably broke.

As far as I can tell there was never a reason for this screen-scraping
hack, when [1] was introduced it hardcoded MediaWiki 1.19.0, the CLI
installer was introduced in 1.17.0. Perhaps the authors weren't aware
of it, or this code was written for an older version.

This allows us to simply delete our own template version of
LocalSettings.php, it'll instead be provided by the CLI installer.

While we're at it let's fix a few things, these changes weren't
practical to split up (I'd need to fix code I was about to mostly
delete)

  * Use MediaWiki's own defaults where possible, e.g. before we'd name
    the database "wikidb.sqlite", now we'll simply use whatever name
    MediaWiki prefers (currently my_wiki.sqlite) by only supplying the
    directory name the SQLite file will be dropped into, not the full
    path.

  * Put all of our database & download assets into a new "mediawiki/"
    folder. This makes it easier to reason about as the current &
    template "backup" database the tests keep swapping around live
    next to each other.

    This'll also prevent future potential breakage as there isn't a
    single SQLite database. MediaWiki also creates a job queue
    database and a couple of cache databases. In practice it seems we
    got away with not resetting these when we reset the main database,
    but it's the sort of thing that could break in the future (reset,
    main store doesn't have the article, but the cache does).

  * The "delete" function now only deletes the MediaWiki installation
    & database, not the downloaded .tar.gz file. This makes us
    friendlier to a developer on a slow connection.

1. 5ef6ad1785 ("git-remote-mediawiki: scripts to install, delete and
   clear a MediaWiki", 2012-07-06)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/.gitignore                |   2 +-
 contrib/mw-to-git/t/install-wiki/.gitignore   |   1 -
 .../t/install-wiki/LocalSettings.php          | 129 ----------------
 .../mw-to-git/t/install-wiki/db_install.php   | 120 ---------------
 contrib/mw-to-git/t/test-gitmw-lib.sh         | 142 +++++++++---------
 contrib/mw-to-git/t/test.config               |  18 +--
 6 files changed, 78 insertions(+), 334 deletions(-)
 delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php

diff --git a/contrib/mw-to-git/t/.gitignore b/contrib/mw-to-git/t/.gitignore
index a7a40b4964..2b8dc30c6d 100644
--- a/contrib/mw-to-git/t/.gitignore
+++ b/contrib/mw-to-git/t/.gitignore
@@ -1,4 +1,4 @@
 WEB/
-wiki/
+mediawiki/
 trash directory.t*/
 test-results/
diff --git a/contrib/mw-to-git/t/install-wiki/.gitignore b/contrib/mw-to-git/t/install-wiki/.gitignore
deleted file mode 100644
index b5a2a4408c..0000000000
--- a/contrib/mw-to-git/t/install-wiki/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-wikidb.sqlite
diff --git a/contrib/mw-to-git/t/install-wiki/LocalSettings.php b/contrib/mw-to-git/t/install-wiki/LocalSettings.php
deleted file mode 100644
index 745e47e881..0000000000
--- a/contrib/mw-to-git/t/install-wiki/LocalSettings.php
+++ /dev/null
@@ -1,129 +0,0 @@
-<?php
-# This file was automatically generated by the MediaWiki 1.19.0
-# installer. If you make manual changes, please keep track in case you
-# need to recreate them later.
-#
-# See includes/DefaultSettings.php for all configurable settings
-# and their default values, but don't forget to make changes in _this_
-# file, not there.
-#
-# Further documentation for configuration settings may be found at:
-# http://www.mediawiki.org/wiki/Manual:Configuration_settings
-
-# Protect against web entry
-if ( !defined( 'MEDIAWIKI' ) ) {
-	exit;
-}
-
-## Uncomment this to disable output compression
-# $wgDisableOutputCompression = true;
-
-$wgSitename      = "Git-MediaWiki-Test";
-$wgMetaNamespace = "Git-MediaWiki-Test";
-
-## The URL base path to the directory containing the wiki;
-## defaults for all runtime URL paths are based off of this.
-## For more information on customizing the URLs please see:
-## http://www.mediawiki.org/wiki/Manual:Short_URL
-$wgScriptPath       = "@WG_SCRIPT_PATH@";
-$wgScriptExtension  = ".php";
-
-## The protocol and server name to use in fully-qualified URLs
-$wgServer           = "@WG_SERVER@";
-
-## The relative URL path to the skins directory
-$wgStylePath        = "$wgScriptPath/skins";
-
-## The relative URL path to the logo.  Make sure you change this from the default,
-## or else you'll overwrite your logo when you upgrade!
-$wgLogo             = "$wgStylePath/common/images/wiki.png";
-
-## UPO means: this is also a user preference option
-
-$wgEnableEmail      = true;
-$wgEnableUserEmail  = true; # UPO
-
-$wgEmergencyContact = "apache@localhost";
-$wgPasswordSender   = "apache@localhost";
-
-$wgEnotifUserTalk      = false; # UPO
-$wgEnotifWatchlist     = false; # UPO
-$wgEmailAuthentication = true;
-
-## Database settings
-$wgDBtype           = "sqlite";
-$wgDBserver         = "";
-$wgDBname           = "@WG_SQLITE_DATAFILE@";
-$wgDBuser           = "";
-$wgDBpassword       = "";
-
-# SQLite-specific settings
-$wgSQLiteDataDir    = "@WG_SQLITE_DATADIR@";
-
-
-## Shared memory settings
-$wgMainCacheType    = CACHE_NONE;
-$wgMemCachedServers = array();
-
-## To enable image uploads, make sure the 'images' directory
-## is writable, then set this to true:
-$wgEnableUploads  = true;
-$wgUseImageMagick = true;
-$wgImageMagickConvertCommand ="@CONVERT@";
-$wgFileExtensions[] = 'txt';
-
-# InstantCommons allows wiki to use images from http://commons.wikimedia.org
-$wgUseInstantCommons  = false;
-
-## If you use ImageMagick (or any other shell command) on a
-## Linux server, this will need to be set to the name of an
-## available UTF-8 locale
-$wgShellLocale = "en_US.utf8";
-
-## If you want to use image uploads under safe mode,
-## create the directories images/archive, images/thumb and
-## images/temp, and make them all writable. Then uncomment
-## this, if it's not already uncommented:
-#$wgHashedUploadDirectory = false;
-
-## Set $wgCacheDirectory to a writable directory on the web server
-## to make your wiki go slightly faster. The directory should not
-## be publicly accessible from the web.
-#$wgCacheDirectory = "$IP/cache";
-
-# Site language code, should be one of the list in ./languages/Names.php
-$wgLanguageCode = "en";
-
-$wgSecretKey = "1c912bfe3519fb70f5dc523ecc698111cd43d81a11c585b3eefb28f29c2699b7";
-#$wgSecretKey = "@SECRETKEY@";
-
-
-# Site upgrade key. Must be set to a string (default provided) to turn on the
-# web installer while LocalSettings.php is in place
-$wgUpgradeKey = "ddae7dc87cd0a645";
-
-## Default skin: you can change the default skin. Use the internal symbolic
-## names, ie 'standard', 'nostalgia', 'cologneblue', 'monobook', 'vector':
-$wgDefaultSkin = "vector";
-
-## For attaching licensing metadata to pages, and displaying an
-## appropriate copyright notice / icon. GNU Free Documentation
-## License and Creative Commons licenses are supported so far.
-$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
-$wgRightsUrl  = "";
-$wgRightsText = "";
-$wgRightsIcon = "";
-
-# Path to the GNU diff3 utility. Used for conflict resolution.
-$wgDiff3 = "/usr/bin/diff3";
-
-# Query string length limit for ResourceLoader. You should only set this if
-# your web server has a query string length limit (then set it to that limit),
-# or if you have suhosin.get.max_value_length set in php.ini (then set it to
-# that value)
-$wgResourceLoaderMaxQueryLength = -1;
-
-
-
-# End of automatically generated settings.
-# Add more configuration options below.
diff --git a/contrib/mw-to-git/t/install-wiki/db_install.php b/contrib/mw-to-git/t/install-wiki/db_install.php
deleted file mode 100644
index b033849800..0000000000
--- a/contrib/mw-to-git/t/install-wiki/db_install.php
+++ /dev/null
@@ -1,120 +0,0 @@
-<?php
-/**
- * This script generates a SQLite database for a MediaWiki version 1.19.0
- * You must specify the login of the admin (argument 1) and its
- * password (argument 2) and the folder where the database file
- * is located (absolute path in argument 3).
- * It is used by the script install-wiki.sh in order to make easy the
- * installation of a MediaWiki.
- *
- * In order to generate a SQLite database file, MediaWiki ask the user
- * to submit some forms in its web browser. This script simulates this
- * behavior though the functions <get> and <submit>
- *
- */
-$argc = $_SERVER['argc'];
-$argv = $_SERVER['argv'];
-
-$login = $argv[2];
-$pass = $argv[3];
-$tmp = $argv[4];
-$port = $argv[5];
-
-$url = 'http://localhost:'.$port.'/wiki/mw-config/index.php';
-$db_dir = urlencode($tmp);
-$tmp_cookie = tempnam($tmp, "COOKIE_");
-/*
- * Fetches a page with cURL.
- */
-function get($page_name = "") {
-	$curl = curl_init();
-	$page_name_add = "";
-	if ($page_name != "") {
-		$page_name_add = '?page='.$page_name;
-	}
-	$url = $GLOBALS['url'].$page_name_add;
-	$tmp_cookie = $GLOBALS['tmp_cookie'];
-	curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
-	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
-	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
-	curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
-	curl_setopt($curl, CURLOPT_HEADER, true);
-	curl_setopt($curl, CURLOPT_URL, $url);
-
-	$page = curl_exec($curl);
-	if (!$page) {
-		die("Could not get page: $url\n");
-	}
-	curl_close($curl);
-	return $page;
-}
-
-/*
- * Submits a form with cURL.
- */
-function submit($page_name, $option = "") {
-	$curl = curl_init();
-	$datapost = 'submit-continue=Continue+%E2%86%92';
-	if ($option != "") {
-		$datapost = $option.'&'.$datapost;
-	}
-	$url = $GLOBALS['url'].'?page='.$page_name;
-	$tmp_cookie = $GLOBALS['tmp_cookie'];
-	curl_setopt($curl, CURLOPT_URL, $url);
-	curl_setopt($curl, CURLOPT_POST, true);
-	curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);
-	curl_setopt($curl, CURLOPT_POSTFIELDS, $datapost);
-	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
-	curl_setopt($curl, CURLOPT_COOKIEJAR, $tmp_cookie);
-	curl_setopt($curl, CURLOPT_COOKIEFILE, $tmp_cookie);
-
-	$page = curl_exec($curl);
-	if (!$page) {
-		die("Could not get page: $url\n");
-	}
-	curl_close($curl);
-	return "$page";
-}
-
-/*
- * Here starts this script: simulates the behavior of the user
- * submitting forms to generates the database file.
- * Note this simulation was made for the MediaWiki version 1.19.0,
- * we can't assume it works with other versions.
- *
- */
-
-$page = get();
-if (!preg_match('/input type="hidden" value="([0-9]+)" name="LanguageRequestTime"/',
-		$page, $matches)) {
-	echo "Unexpected content for page downloaded:\n";
-	echo "$page";
-	die;
-};
-$timestamp = $matches[1];
-$language = "LanguageRequestTime=$timestamp&uselang=en&ContLang=en";
-$page = submit('Language', $language);
-
-submit('Welcome');
-
-$db_config = 'DBType=sqlite';
-$db_config = $db_config.'&sqlite_wgSQLiteDataDir='.$db_dir;
-$db_config = $db_config.'&sqlite_wgDBname='.$argv[1];
-submit('DBConnect', $db_config);
-
-$wiki_config = 'config_wgSitename=TEST';
-$wiki_config = $wiki_config.'&config__NamespaceType=site-name';
-$wiki_config = $wiki_config.'&config_wgMetaNamespace=MyWiki';
-$wiki_config = $wiki_config.'&config__AdminName='.$login;
-
-$wiki_config = $wiki_config.'&config__AdminPassword='.$pass;
-$wiki_config = $wiki_config.'&config__AdminPassword2='.$pass;
-
-$wiki_config = $wiki_config.'&wiki__configEmail=email%40email.org';
-$wiki_config = $wiki_config.'&config__SkipOptional=skip';
-submit('Name', $wiki_config);
-submit('Install');
-submit('Install');
-
-unlink($tmp_cookie);
-?>
diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index aa04ebfd0f..787a8a3ec0 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -13,7 +13,8 @@
 
 . ./test.config
 
-WIKI_URL=http://"$SERVER_ADDR:$PORT/$WIKI_DIR_NAME"
+WIKI_BASE_URL=http://$SERVER_ADDR:$PORT
+WIKI_URL=$WIKI_BASE_URL/$WIKI_DIR_NAME
 CURR_DIR=$(pwd)
 TEST_OUTPUT_DIRECTORY=$(pwd)
 TEST_DIRECTORY="$CURR_DIR"/../../../t
@@ -291,28 +292,59 @@ stop_lighttpd () {
 	test -f "$WEB_TMP/pid" && kill $(cat "$WEB_TMP/pid")
 }
 
-# Create the SQLite database of the MediaWiki. If the database file already
-# exists, it will be deleted.
-# This script should be runned from the directory where $FILES_FOLDER is
-# located.
-create_db () {
-	rm -f "$TMP/$DB_FILE"
+wiki_delete_db () {
+	rm -rf \
+	   "$FILES_FOLDER_DB"/* || error "Couldn't delete $FILES_FOLDER_DB/"
+}
+
+wiki_delete_db_backup () {
+	rm -rf \
+	   "$FILES_FOLDER_POST_INSTALL_DB"/* || error "Couldn't delete $FILES_FOLDER_POST_INSTALL_DB/"
+}
 
-	echo "Generating the SQLite database file. It can take some time ..."
-	# Run the php script to generate the SQLite database file
-	# with cURL calls.
-	php "$FILES_FOLDER/$DB_INSTALL_SCRIPT" $(basename "$DB_FILE" .sqlite) \
-		"$WIKI_ADMIN" "$WIKI_PASSW" "$TMP" "$PORT"
+# Install MediaWiki using its install.php script. If the database file
+# already exists, it will be deleted.
+install_mediawiki () {
 
-	if ! test -f "$TMP/$DB_FILE"
+	localsettings="$WIKI_DIR_INST/$WIKI_DIR_NAME/LocalSettings.php"
+	if test -f "$localsettings"
 	then
-		error "Can't create database file $TMP/$DB_FILE. Try to run ./install-wiki.sh delete first."
+		error "We already installed the wiki, since $localsettings exists" \
+		      "perhaps you wanted to run 'delete' first?"
 	fi
 
-	# Copy the generated database file into the directory the
-	# user indicated.
-	cp "$TMP/$DB_FILE" "$FILES_FOLDER" ||
-		error "Unable to copy $TMP/$DB_FILE to $FILES_FOLDER"
+	wiki_delete_db
+	wiki_delete_db_backup
+	mkdir \
+		"$FILES_FOLDER_DB/" \
+		"$FILES_FOLDER_POST_INSTALL_DB/"
+
+	install_script="$WIKI_DIR_INST/$WIKI_DIR_NAME/maintenance/install.php"
+	echo "Installing MediaWiki using $install_script. This may take some time ..."
+
+	php "$WIKI_DIR_INST/$WIKI_DIR_NAME/maintenance/install.php" \
+	    --server $WIKI_BASE_URL \
+	    --scriptpath /wiki \
+	    --lang en \
+	    --dbtype sqlite \
+	    --dbpath $PWD/$FILES_FOLDER_DB/ \
+	    --pass "$WIKI_PASSW" \
+	    Git-MediaWiki-Test \
+	    "$WIKI_ADMIN" ||
+		error "Couldn't run $install_script, see errors above. Try to run ./install-wiki.sh delete first."
+	cat <<-'EOF' >>$localsettings
+# Custom settings added by test-gitmw-lib.sh
+#
+# Uploading text files is needed for
+# t9363-mw-to-git-export-import.sh
+$wgEnableUploads = true;
+$wgFileExtensions[] = 'txt';
+EOF
+
+	# Copy the initially generated database file into our backup
+	# folder
+	cp -R "$FILES_FOLDER_DB/"* "$FILES_FOLDER_POST_INSTALL_DB/" ||
+		error "Unable to copy $FILES_FOLDER_DB/* to $FILES_FOLDER_POST_INSTALL_DB/*"
 }
 
 # Install a wiki in your web server directory.
@@ -321,7 +353,6 @@ wiki_install () {
 		start_lighttpd
 	fi
 
-	SERVER_ADDR=$SERVER_ADDR:$PORT
 	# In this part, we change directory to $TMP in order to download,
 	# unpack and copy the files of MediaWiki
 	(
@@ -332,9 +363,10 @@ wiki_install () {
 		Please create it and launch the script again."
 	fi
 
-	# Fetch MediaWiki's archive if not already present in the TMP directory
+	# Fetch MediaWiki's archive if not already present in download directory
+	mkdir -p "$FILES_FOLDER_DOWNLOAD"
 	MW_FILENAME="mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
-	cd "$TMP"
+	cd "$FILES_FOLDER_DOWNLOAD"
 	if ! test -f $MW_FILENAME
 	then
 		echo "Downloading $MW_VERSION_MAJOR.$MW_VERSION_MINOR sources ..."
@@ -355,49 +387,12 @@ wiki_install () {
 		error "Unable to extract WikiMedia's files from $archive_abs_path to "\
 			"$WIKI_DIR_INST/$WIKI_DIR_NAME"
 	) || exit 1
+	echo Extracted in "$WIKI_DIR_INST/$WIKI_DIR_NAME"
 
-	create_db
-
-	# Copy the generic LocalSettings.php in the web server's directory
-	# And modify parameters according to the ones set at the top
-	# of this script.
-	# Note that LocalSettings.php is never modified.
-	if ! test -f "$FILES_FOLDER/LocalSettings.php"
-	then
-		error "Can't find $FILES_FOLDER/LocalSettings.php " \
-			"in the current folder. "\
-		"Please run the script inside its folder."
-	fi
-	cp "$FILES_FOLDER/LocalSettings.php" \
-		"$FILES_FOLDER/LocalSettings-tmp.php" ||
-		error "Unable to copy $FILES_FOLDER/LocalSettings.php " \
-		"to $FILES_FOLDER/LocalSettings-tmp.php"
-
-	# Parse and set the LocalSettings file of the user according to the
-	# CONFIGURATION VARIABLES section at the beginning of this script
-	file_swap="$FILES_FOLDER/LocalSettings-swap.php"
-	sed "s,@WG_SCRIPT_PATH@,/$WIKI_DIR_NAME," \
-		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
-	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
-	sed "s,@WG_SERVER@,http://$SERVER_ADDR," \
-		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
-	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
-	sed "s,@WG_SQLITE_DATADIR@,$TMP," \
-		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
-	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
-	sed "s,@WG_SQLITE_DATAFILE@,$( basename $DB_FILE .sqlite)," \
-		"$FILES_FOLDER/LocalSettings-tmp.php" > "$file_swap"
-	mv "$file_swap" "$FILES_FOLDER/LocalSettings-tmp.php"
-
-	mv "$FILES_FOLDER/LocalSettings-tmp.php" \
-		"$WIKI_DIR_INST/$WIKI_DIR_NAME/LocalSettings.php" ||
-		error "Unable to move $FILES_FOLDER/LocalSettings-tmp.php" \
-		"in $WIKI_DIR_INST/$WIKI_DIR_NAME"
-	echo "File $FILES_FOLDER/LocalSettings.php is set in" \
-		" $WIKI_DIR_INST/$WIKI_DIR_NAME"
+	install_mediawiki
 
 	echo "Your wiki has been installed. You can check it at
-		http://$SERVER_ADDR/$WIKI_DIR_NAME"
+		$WIKI_URL"
 }
 
 # Reset the database of the wiki and the password of the admin
@@ -405,13 +400,18 @@ wiki_install () {
 # Warning: This function must be called only in a subdirectory of t/ directory
 wiki_reset () {
 	# Copy initial database of the wiki
-	if ! test -f "../$FILES_FOLDER/$DB_FILE"
+	if ! test -d "../$FILES_FOLDER_DB"
 	then
-		error "Can't find ../$FILES_FOLDER/$DB_FILE in the current folder."
+		error "No wiki database at ../$FILES_FOLDER_DB, not installed yet?"
 	fi
-	cp "../$FILES_FOLDER/$DB_FILE" "$TMP" ||
-		error "Can't copy ../$FILES_FOLDER/$DB_FILE in $TMP"
-	echo "File $FILES_FOLDER/$DB_FILE is set in $TMP"
+	if ! test -d "../$FILES_FOLDER_POST_INSTALL_DB"
+	then
+		error "No wiki backup database at ../$FILES_FOLDER_POST_INSTALL_DB, failed installation?"
+	fi
+	wiki_delete_db
+	cp -R "../$FILES_FOLDER_POST_INSTALL_DB/"* "../$FILES_FOLDER_DB/" ||
+		error "Can't copy ../$FILES_FOLDER_POST_INSTALL_DB/* to ../$FILES_FOLDER_DB/*"
+	echo "File $FILES_FOLDER_DB/* has been reset"
 }
 
 # Delete the wiki created in the web server's directory and all its content
@@ -425,13 +425,7 @@ wiki_delete () {
 		rm -rf "$WIKI_DIR_INST/$WIKI_DIR_NAME" ||
 			error "Wiki's directory $WIKI_DIR_INST/" \
 			"$WIKI_DIR_NAME could not be deleted"
-		# Delete the wiki's SQLite database.
-		rm -f "$TMP/$DB_FILE" ||
-			error "Database $TMP/$DB_FILE could not be deleted."
 	fi
-
-	# Delete the wiki's SQLite database
-	rm -f "$TMP/$DB_FILE" || error "Database $TMP/$DB_FILE could not be deleted."
-	rm -f "$FILES_FOLDER/$DB_FILE"
-	rm -rf "$TMP/mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
+	wiki_delete_db
+	wiki_delete_db_backup
 }
diff --git a/contrib/mw-to-git/t/test.config b/contrib/mw-to-git/t/test.config
index 3ab56c7165..ed10b3e4a4 100644
--- a/contrib/mw-to-git/t/test.config
+++ b/contrib/mw-to-git/t/test.config
@@ -8,10 +8,6 @@ WIKI_PASSW=AdminPass1
 # Address of the web server
 SERVER_ADDR=localhost
 
-# SQLite database of the wiki, named DB_FILE, is located in TMP
-TMP=/tmp
-DB_FILE=wikidb.sqlite
-
 # If LIGHTTPD is not set to true, the script will use the default
 # web server running in WIKI_DIR_INST.
 WIKI_DIR_INST=/var/www
@@ -28,13 +24,17 @@ WEB=WEB
 WEB_TMP=$WEB/tmp
 WEB_WWW=$WEB/www
 
+# Where our configuration for the wiki is located
+FILES_FOLDER=mediawiki
+FILES_FOLDER_DOWNLOAD=$FILES_FOLDER/download
+FILES_FOLDER_DB=$FILES_FOLDER/db
+FILES_FOLDER_POST_INSTALL_DB=$FILES_FOLDER/post-install-db
+
 # The variables below are used by the script to install a wiki.
 # You should not modify these unless you are modifying the script itself.
-# tested versions: 1.19.X -> 1.21.1
+# tested versions: 1.19.X -> 1.21.1 -> 1.34.2
 #
 # See https://www.mediawiki.org/wiki/Download for what the latest
 # version is.
-MW_VERSION_MAJOR=1.21
-MW_VERSION_MINOR=1
-FILES_FOLDER=install-wiki
-DB_INSTALL_SCRIPT=db_install.php
+MW_VERSION_MAJOR=1.34
+MW_VERSION_MINOR=2
-- 
2.28.0.297.g1956fa8f8d

