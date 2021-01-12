Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79811C07D5A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478AA23122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438135AbhALVh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436879AbhALUTm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228AFC0617B1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 3so3311870wmg.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgDqqsHnnRDTaA/0ja+ZvMf8GdOBArz+IBlJ8/zn0hU=;
        b=peWbWB3Z7l5Xh7WbbaLkP6ex0xBH8RzoW4qJ+A1BLce4QSHH5sypm3/pQ1nKtBfWxo
         mjoSQXc2BDa9MZN/Omb9klsjghpnDU9aydcyCh8Ro0tx17eVZQH3nXtyB1JxP/gyu68F
         QdmP396sW7k/roy3L9AEOyHSYc6ZDlyV2ktGuuXgKSFI0PLU744uEI6/OHWjYhcjGX/4
         fSRe5FbT7c93jribjvk0lQyQxkGUc+Ev7CxnMLEHLw/n7v9PPgeXj7Z3eRPlkTu4asyc
         s+uoDxltF2QJ4ohmh3okc4cGhWgyM7S8kT1D1vWQkPOC1RcZOQdMq0ZVIQev/8rdgCBS
         jHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgDqqsHnnRDTaA/0ja+ZvMf8GdOBArz+IBlJ8/zn0hU=;
        b=TFVz+lR0F7zDAeClCsjXQRgs0dYbaxjJqNv20+Nyq5qWri5BD3k26+57Wrg8GL9CbL
         AQ206JaaT4+vV/pJbAc7FzVYY4Ik3gR5sMQGQT4HLqZeqFmqvM6fmz6MOMvzpvjcdnE/
         +RSsuq8vvU223I2A3Z+IQeONCmi6fFeB0EY/CvnFY/znrverso7gCu+y7NNDFz6KLK9/
         QYAWMH/mU/40lWz1NpQIbS4Mq8mT5RAS2aDYQ+Hhp4o6N7GsOBd1vgJ4uc1qkPZNWK7r
         0tFB77fB5fzJ6N+3m7qxhHzvESEvGByED534eBc2p/4Z0C6so7p39BpmA4UAK6hNg0R3
         gC7g==
X-Gm-Message-State: AOAM5320EiFKN8Juj4znr4PY2/nRd4lCbUoq+e2kPewfYBd8vGw/Mt8Z
        0T8jRZs7sxJDGRF+eGOkiKxfGc8cWIaSbw==
X-Google-Smtp-Source: ABdhPJw5XBrLS+ZaOPG3d0XAE/sgLjVhdTAhE/pMEMKegL8Pck3D7m4Py4PNpibONnrw9G/P4UZyYA==
X-Received: by 2002:a1c:4489:: with SMTP id r131mr936266wma.24.1610482719560;
        Tue, 12 Jan 2021 12:18:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/22] test-lib functions: add an --append option to test_commit
Date:   Tue, 12 Jan 2021 21:17:59 +0100
Message-Id: <20210112201806.13284-16-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --append option to test_commit to append <contents> to the
<file> we're writing to. This simplifies a lot of test setup, as shown
in some of the tests being changed here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh      | 39 +++++++--------------------------------
 t/test-lib-functions.sh | 14 +++++++++++++-
 2 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 2b342d7f7c..5d92880a5a 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -5,14 +5,8 @@ test_description='.mailmap configurations'
 . ./test-lib.sh
 
 test_expect_success 'setup commits and contacts file' '
-	echo one >one &&
-	git add one &&
-	test_tick &&
-	git commit -m initial &&
-	echo two >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick1 <bugs@company.xx>" -m second
+	test_commit initial one one &&
+	test_commit --author "nick1 <bugs@company.xx>" --append second one two
 '
 
 test_expect_success 'check-mailmap no arguments' '
@@ -436,30 +430,11 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 	EOF
 
-	echo three >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick2 <bugs@company.xx>" -m third &&
-
-	echo four >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick2 <nick2@company.xx>" -m fourth &&
-
-	echo five >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "santa <me@company.xx>" -m fifth &&
-
-	echo six >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "claus <me@company.xx>" -m sixth &&
-
-	echo seven >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
+	test_commit --author "nick2 <bugs@company.xx>" --append third one three &&
+	test_commit --author "nick2 <nick2@company.xx>" --append fourth one four &&
+	test_commit --author "santa <me@company.xx>" --append fifth one five &&
+	test_commit --author "claus <me@company.xx>" --append sixth one six &&
+	test_commit --author "CTO <cto@coompany.xx>" --append seventh one seven &&
 
 	cat >expect <<-EOF &&
 	$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> (1):
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 529f6264fe..b0a5d74dc7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -183,6 +183,9 @@ debug () {
 #	Run all git commands in directory <dir>
 #   --notick
 #	Do not call test_tick before making a commit
+#   --append
+#	Use "echo >>" instead of "echo >" when writing "<contents>" to
+#	"<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
 #   --author=<author>
@@ -195,6 +198,7 @@ debug () {
 
 test_commit () {
 	notick= &&
+	append= &&
 	author= &&
 	signoff= &&
 	indir= &&
@@ -204,6 +208,9 @@ test_commit () {
 		--notick)
 			notick=yes
 			;;
+		--append)
+			append=yes
+			;;
 		--author)
 			author="$2"
 			shift
@@ -223,7 +230,12 @@ test_commit () {
 	done &&
 	indir=${indir:+"$indir"/} &&
 	file=${2:-"$1.t"} &&
-	echo "${3-$1}" > "$indir$file" &&
+	if test -n "$append"
+	then
+		echo "${3-$1}" >>"$indir$file"
+	else
+		echo "${3-$1}" >"$indir$file"
+	fi &&
 	git ${indir:+ -C "$indir"} add "$file" &&
 	if test -z "$notick"
 	then
-- 
2.29.2.222.g5d2a92d10f8

