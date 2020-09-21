Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5091C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC62145D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jToVsqSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIUKk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgIUKkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FBC0613D1
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b79so12077456wmb.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arNlwz5nmHLOGpi2DcBtjy3OY83QSaEJhcFnYLqyAWA=;
        b=jToVsqSBZX+V+ZyPw1tjpYYiULqEpoP0YV9i3mBpOCAMXMUU9XCXzX9/HdIh5MWrg7
         lGsTQcmTwrM8nrKafSSL52P0Dyjsuku5eXU3qAIseTMerfa8qNKQePLqRo9Fx/BNjxHy
         SHi20ESG8c7tzebXPPZVSh0mq14vdOOju9WSTwVweIpxHE5CNLzN2UdNy59R8CK5JQiL
         tqApRaAQa/0pyK8cgyoE6hZa10AvF5S1BQ7Pl5dL00JFqq3yWrVUpFBld43XEIIwFnvA
         I5L5T9MtHiW93mPDryhTBWekI6cBuiVvd4l9bel1m4dFN3pzB82KJY1WfYFauU+lsf8J
         nMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arNlwz5nmHLOGpi2DcBtjy3OY83QSaEJhcFnYLqyAWA=;
        b=Pje7zEAt2ffz8Y9dvHA1KodlJFNW9PLrfM/m6xS6Dgw5RO4BX6otIWQAvso8TiKf9U
         +gUv2HsO/uRtZ5YkhLjSH/5QHDpY9zt58nmASJTrbkCeh7A+XSe/crLq1nCROdIU3VDX
         QMSduNG9Yldwsu1c44knxWD1CBBg0cjTqlaQdvNLJia6pLwKEQxb+804ieoOLfOWOHNW
         iObd2GmUavoGwVI/Sw/PiTWrojlvumDa/r3xfZbfeX/uYHNXvdjU5yBGtF12w0DLEhCq
         OeAiOIAbTTQRs55rzlgn+5kluTlxSE55oqbIc7tBD+sdJvMsAsI9tqSPg9RNmm/qyeNU
         jYCg==
X-Gm-Message-State: AOAM5339wtWOZ3sWuDm9p6GDEixu4bDwGFmIww9cPwR5Zy4y2zrcXgTF
        IrNmyMP6RcF0ooY8WGPNszrYqRlu1QstoQ==
X-Google-Smtp-Source: ABdhPJytuypQ0tGe6hxd/74kaPmVl+2pop1Q2RZ0wbBt4HJlHITW1vGqyt6x5jv4Il7mG+ARzmAOcQ==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr3584507wmj.24.1600684822105;
        Mon, 21 Sep 2020 03:40:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/18] remote-mediawiki tests: change `[]` to `test`
Date:   Mon, 21 Sep 2020 12:39:49 +0200
Message-Id: <20200921104000.2304-8-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert `[]` to `test` and break if-then into separate lines, both of
which bring the style in line with Git's coding guidelines.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/test-gitmw-lib.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/contrib/mw-to-git/t/test-gitmw-lib.sh b/contrib/mw-to-git/t/test-gitmw-lib.sh
index 3948a00282..a466be8f3f 100755
--- a/contrib/mw-to-git/t/test-gitmw-lib.sh
+++ b/contrib/mw-to-git/t/test-gitmw-lib.sh
@@ -65,7 +65,7 @@ test_check_precond () {
 	GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd "../.." && pwd)
 	PATH="$GIT_EXEC_PATH"'/bin-wrapper:'"$PATH"
 
-	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ];
+	if ! test -d "$WIKI_DIR_INST/$WIKI_DIR_NAME"
 	then
 		skip_all='skipping gateway git-mw tests, no mediawiki found'
 		test_done
@@ -304,7 +304,8 @@ create_db () {
 	php "$FILES_FOLDER/$DB_INSTALL_SCRIPT" $(basename "$DB_FILE" .sqlite) \
 		"$WIKI_ADMIN" "$WIKI_PASSW" "$TMP" "$PORT"
 
-	if [ ! -f "$TMP/$DB_FILE" ] ; then
+	if ! test -f "$TMP/$DB_FILE"
+	then
 		error "Can't create database file $TMP/$DB_FILE. Try to run ./install-wiki.sh delete first."
 	fi
 
@@ -325,7 +326,8 @@ wiki_install () {
 	# unpack and copy the files of MediaWiki
 	(
 	mkdir -p "$WIKI_DIR_INST/$WIKI_DIR_NAME"
-	if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ; then
+	if ! test -d "$WIKI_DIR_INST/$WIKI_DIR_NAME"
+	then
 		error "Folder $WIKI_DIR_INST/$WIKI_DIR_NAME doesn't exist.
 		Please create it and launch the script again."
 	fi
@@ -333,7 +335,8 @@ wiki_install () {
 	# Fetch MediaWiki's archive if not already present in the TMP directory
 	MW_FILENAME="mediawiki-$MW_VERSION_MAJOR.$MW_VERSION_MINOR.tar.gz"
 	cd "$TMP"
-	if [ ! -f $MW_FILENAME ] ; then
+	if ! test -f $MW_FILENAME
+	then
 		echo "Downloading $MW_VERSION_MAJOR.$MW_VERSION_MINOR sources ..."
 		wget "http://download.wikimedia.org/mediawiki/$MW_VERSION_MAJOR/$MW_FILENAME" ||
 			error "Unable to download "\
@@ -359,7 +362,8 @@ wiki_install () {
 	# And modify parameters according to the ones set at the top
 	# of this script.
 	# Note that LocalSettings.php is never modified.
-	if [ ! -f "$FILES_FOLDER/LocalSettings.php" ] ; then
+	if ! test -f "$FILES_FOLDER/LocalSettings.php"
+	then
 		error "Can't find $FILES_FOLDER/LocalSettings.php " \
 			"in the current folder. "\
 		"Please run the script inside its folder."
@@ -401,7 +405,8 @@ wiki_install () {
 # Warning: This function must be called only in a subdirectory of t/ directory
 wiki_reset () {
 	# Copy initial database of the wiki
-	if [ ! -f "../$FILES_FOLDER/$DB_FILE" ] ; then
+	if ! test -f "../$FILES_FOLDER/$DB_FILE"
+	then
 		error "Can't find ../$FILES_FOLDER/$DB_FILE in the current folder."
 	fi
 	cp "../$FILES_FOLDER/$DB_FILE" "$TMP" ||
-- 
2.28.0.297.g1956fa8f8d

