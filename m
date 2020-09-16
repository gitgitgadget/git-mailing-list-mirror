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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761CCC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395C02224A
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPOzQYgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgIPMcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CBC061355
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so2429193wmm.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arNlwz5nmHLOGpi2DcBtjy3OY83QSaEJhcFnYLqyAWA=;
        b=XPOzQYgY4enK85j4PBsExMfGQAj1mK+0PHKyN2UGWuqSunFKpvR0lPBPdi56pDR1vq
         oqwD5CYQ+3emZFOmjkF4RborVPbStBi89KEhs9tpFmn2ec81NecpGjUu9q3V3AJB6q/+
         lv6Z3yYQDl1TVhCGyRbt0NpvWpr1AjMdOgCk9Mjjr2jJ87tfVnbGxxJAF6edgCRbQQZj
         seyseEunHfT0DG64ToU3io+5K+6FgqkwAIhouQ0OnO463eNphMYTBsC7Fx2TcH6LSGoO
         j7mp7VrZWolxaVpj3+akR4TpmBkkXY5AFB2yyf4SQhSviMeLtKFYKoOmvb53KHXNfVdG
         5TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arNlwz5nmHLOGpi2DcBtjy3OY83QSaEJhcFnYLqyAWA=;
        b=YFP2vDrD39/Hkk/6s7KBZNA8ItIo72sGOPfb247xOzO3Gdp9WnHgjbowEGL4oSUKHJ
         7qHVt9aEcDGS/CogDsHpvWf4zmO5/DNXTXqBq7H72SdAS/n9Lmbg9aYuv7FQgAQEPfLF
         344LFZWqGdSj9MMgTCcr2BbFySNyQt3iBCBgYaJ7ZF6fHWH/f8c/VUfo257xqusLRQlx
         CtfPQ+oMIHXZTaCHHHc+X01LsbR3sbCZXahy6+rGrGCTFaMlvEeOFpdvhXQJqpzXDptB
         dBQZ8EkzUkcnYdnWoXCEZVkNzORt185NnvsXmSXTW+X6HxsMdngU9xIMaMHcJ1jyoncW
         KwFQ==
X-Gm-Message-State: AOAM531jrP2Q6z62g73IbKlF+LCCpa84LTfWN+XnYkuo9Du3CwvQOynE
        WFHzQbyPPbW55D8hxhQkb3NU5HVD4yI5uxbn
X-Google-Smtp-Source: ABdhPJz+avcqN9Fa4Qf00/+q4tsOfVDxvgmsP/5JuLLmLfkIlBCxGJjxLsDrCFwmoYhF8057nKM0YQ==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr4050800wmg.117.1600252207539;
        Wed, 16 Sep 2020 03:30:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:06 -0700 (PDT)
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
Subject: [PATCH 08/15] remote-mediawiki tests: change `[]` to `test`
Date:   Wed, 16 Sep 2020 12:29:11 +0200
Message-Id: <20200916102918.29805-9-avarab@gmail.com>
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

