Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288F61F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932134AbeFZHbV (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:31:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52195 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeFZHbT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:19 -0400
Received: by mail-it0-f67.google.com with SMTP id 128-v6so829676itf.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zNyrIeTMQYNBFqRTwC5T3qgUstMcLbUswMX0byC5eVE=;
        b=kI+VcceKPWdTstq6FiyZ6N8I8ErHW/hPTcflF50WJ9MX8LxiD3fZ3EPulb8X7JNOTp
         YDSoxR2nHarUqreaZmCoA3sqkf5lINREsK3059LkXwBFZmjVAOHoiOUDij/M/ab/hxn/
         2rMJMZKRsurv4060BTEHAu6eh7TQ/+p2ZMmfTWLB1J0mlTOLQrsxT9N++AjLBK3X3agI
         6eg92EToUCkR7ZQEnPMnHvw1Y33X0FpbQR9wyQJbv/oOJa6ZswO8H23HVNy6mD+mlrz+
         giYCK3PldDwF+Bxk3QLLfe+NccqR8kFbRtueGD5SuImkxG1VHpyiPCy6KZVIIT7zAADf
         eSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zNyrIeTMQYNBFqRTwC5T3qgUstMcLbUswMX0byC5eVE=;
        b=b7ZMKlu2gVFK190+8KNO/gOr3QClqumgibTmCeAdbfNO1WM6p7mi8j1yaabHDBzVKl
         0vj/vKKR46+E0Lvv0rPYHHBQjMinY9Agh7zg816Ylxmpojfuc1RlrQCa1kBx4hIxZz3Z
         LnWgFQV93Pkq0lWAHUrkOgQvKyNxgFHsi/5EH582qgzdaCaVcUm1idAjRnZ+uXAhBK/8
         luaGz2ZmRa5jJjpmzo/W2nmF4IFADXKk10/P8PVUk16UGrLutJdtq9NUcFx/5N3pxS7Y
         ICkVSua678i+ylqkW+UP/Rs3A4OZJmBt2mDBDYa0URe5e9DB5GgPqGlOj61oxuudsUR2
         V6jQ==
X-Gm-Message-State: APt69E3OW4DLqRWJj15o01d1hIeF97H8s1uF+nauRVUgLvGHzoLnlHTY
        A8y6pdyHp88O59KDe/mCOrIvtQ==
X-Google-Smtp-Source: AAOMgpdVx+4KikIQcgWCX3EltsHcdUKEzWvZ1gAsC0+kqT4vSZJQiEhi8h76tTpH//R2nfj3qnc4iw==
X-Received: by 2002:a24:c054:: with SMTP id u81-v6mr514878itf.94.1529998278423;
        Tue, 26 Jun 2018 00:31:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.31.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:31:17 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 28/29] t9119: fix broken &&-chains in subshells
Date:   Tue, 26 Jun 2018 03:30:00 -0400
Message-Id: <20180626073001.6555-29-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9119-git-svn-info.sh | 120 ++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 88241baee3..8201c3e808 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -22,8 +22,8 @@ esac
 # same value as "svn info" (i.e. the commit timestamp that touched the
 # path most recently); do not expect that field to match.
 test_cmp_info () {
-	sed -e '/^Text Last Updated:/d' "$1" >tmp.expect
-	sed -e '/^Text Last Updated:/d' "$2" >tmp.actual
+	sed -e '/^Text Last Updated:/d' "$1" >tmp.expect &&
+	sed -e '/^Text Last Updated:/d' "$2" >tmp.actual &&
 	test_cmp tmp.expect tmp.actual &&
 	rm -f tmp.expect tmp.actual
 }
@@ -59,24 +59,24 @@ test_expect_success 'setup repository and import' '
 	'
 
 test_expect_success 'info' "
-	(cd svnwc; svn info) > expected.info &&
-	(cd gitwc; git svn info) > actual.info &&
+	(cd svnwc && svn info) > expected.info &&
+	(cd gitwc && git svn info) > actual.info &&
 	test_cmp_info expected.info actual.info
 	"
 
 test_expect_success 'info --url' '
-	test "$(cd gitwc; git svn info --url)" = "$quoted_svnrepo"
+	test "$(cd gitwc && git svn info --url)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info .' "
-	(cd svnwc; svn info .) > expected.info-dot &&
-	(cd gitwc; git svn info .) > actual.info-dot &&
+	(cd svnwc && svn info .) > expected.info-dot &&
+	(cd gitwc && git svn info .) > actual.info-dot &&
 	test_cmp_info expected.info-dot actual.info-dot
 	"
 
 test_expect_success 'info $(pwd)' '
-	(cd svnwc; svn info "$(pwd)") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -85,8 +85,8 @@ test_expect_success 'info $(pwd)' '
 	'
 
 test_expect_success 'info $(pwd)/../___wc' '
-	(cd svnwc; svn info "$(pwd)/../svnwc") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)/../svnwc") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -95,8 +95,8 @@ test_expect_success 'info $(pwd)/../___wc' '
 	'
 
 test_expect_success 'info $(pwd)/../___wc//file' '
-	(cd svnwc; svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -105,56 +105,56 @@ test_expect_success 'info $(pwd)/../___wc//file' '
 	'
 
 test_expect_success 'info --url .' '
-	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
+	test "$(cd gitwc && git svn info --url .)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info file' "
-	(cd svnwc; svn info file) > expected.info-file &&
-	(cd gitwc; git svn info file) > actual.info-file &&
+	(cd svnwc && svn info file) > expected.info-file &&
+	(cd gitwc && git svn info file) > actual.info-file &&
 	test_cmp_info expected.info-file actual.info-file
 	"
 
 test_expect_success 'info --url file' '
-	test "$(cd gitwc; git svn info --url file)" = "$quoted_svnrepo/file"
+	test "$(cd gitwc && git svn info --url file)" = "$quoted_svnrepo/file"
 	'
 
 test_expect_success 'info directory' "
-	(cd svnwc; svn info directory) > expected.info-directory &&
-	(cd gitwc; git svn info directory) > actual.info-directory &&
+	(cd svnwc && svn info directory) > expected.info-directory &&
+	(cd gitwc && git svn info directory) > actual.info-directory &&
 	test_cmp_info expected.info-directory actual.info-directory
 	"
 
 test_expect_success 'info inside directory' "
-	(cd svnwc/directory; svn info) > expected.info-inside-directory &&
-	(cd gitwc/directory; git svn info) > actual.info-inside-directory &&
+	(cd svnwc/directory && svn info) > expected.info-inside-directory &&
+	(cd gitwc/directory && git svn info) > actual.info-inside-directory &&
 	test_cmp_info expected.info-inside-directory actual.info-inside-directory
 	"
 
 test_expect_success 'info --url directory' '
-	test "$(cd gitwc; git svn info --url directory)" = "$quoted_svnrepo/directory"
+	test "$(cd gitwc && git svn info --url directory)" = "$quoted_svnrepo/directory"
 	'
 
 test_expect_success 'info symlink-file' "
-	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
-	(cd gitwc; git svn info symlink-file) > actual.info-symlink-file &&
+	(cd svnwc && svn info symlink-file) > expected.info-symlink-file &&
+	(cd gitwc && git svn info symlink-file) > actual.info-symlink-file &&
 	test_cmp_info expected.info-symlink-file actual.info-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file' '
-	test "$(cd gitwc; git svn info --url symlink-file)" \
+	test "$(cd gitwc && git svn info --url symlink-file)" \
 	     = "$quoted_svnrepo/symlink-file"
 	'
 
 test_expect_success 'info symlink-directory' "
-	(cd svnwc; svn info symlink-directory) \
+	(cd svnwc && svn info symlink-directory) \
 		> expected.info-symlink-directory &&
-	(cd gitwc; git svn info symlink-directory) \
+	(cd gitwc && git svn info symlink-directory) \
 		> actual.info-symlink-directory &&
 	test_cmp_info expected.info-symlink-directory actual.info-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory' '
-	test "$(cd gitwc; git svn info --url symlink-directory)" \
+	test "$(cd gitwc && git svn info --url symlink-directory)" \
 	     = "$quoted_svnrepo/symlink-directory"
 	'
 
@@ -169,13 +169,13 @@ test_expect_success 'info added-file' "
 		cd svnwc &&
 		svn_cmd add added-file > /dev/null
 	) &&
-	(cd svnwc; svn info added-file) > expected.info-added-file &&
-	(cd gitwc; git svn info added-file) > actual.info-added-file &&
+	(cd svnwc && svn info added-file) > expected.info-added-file &&
+	(cd gitwc && git svn info added-file) > actual.info-added-file &&
 	test_cmp_info expected.info-added-file actual.info-added-file
 	"
 
 test_expect_success 'info --url added-file' '
-	test "$(cd gitwc; git svn info --url added-file)" \
+	test "$(cd gitwc && git svn info --url added-file)" \
 	     = "$quoted_svnrepo/added-file"
 	'
 
@@ -190,15 +190,15 @@ test_expect_success 'info added-directory' "
 		cd gitwc &&
 		git add added-directory
 	) &&
-	(cd svnwc; svn info added-directory) \
+	(cd svnwc && svn info added-directory) \
 		> expected.info-added-directory &&
-	(cd gitwc; git svn info added-directory) \
+	(cd gitwc && git svn info added-directory) \
 		> actual.info-added-directory &&
 	test_cmp_info expected.info-added-directory actual.info-added-directory
 	"
 
 test_expect_success 'info --url added-directory' '
-	test "$(cd gitwc; git svn info --url added-directory)" \
+	test "$(cd gitwc && git svn info --url added-directory)" \
 	     = "$quoted_svnrepo/added-directory"
 	'
 
@@ -213,16 +213,16 @@ test_expect_success 'info added-symlink-file' "
 		ln -s added-file added-symlink-file &&
 		svn_cmd add added-symlink-file > /dev/null
 	) &&
-	(cd svnwc; svn info added-symlink-file) \
+	(cd svnwc && svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
-	(cd gitwc; git svn info added-symlink-file) \
+	(cd gitwc && git svn info added-symlink-file) \
 		> actual.info-added-symlink-file &&
 	test_cmp_info expected.info-added-symlink-file \
 		actual.info-added-symlink-file
 	"
 
 test_expect_success 'info --url added-symlink-file' '
-	test "$(cd gitwc; git svn info --url added-symlink-file)" \
+	test "$(cd gitwc && git svn info --url added-symlink-file)" \
 	     = "$quoted_svnrepo/added-symlink-file"
 	'
 
@@ -237,16 +237,16 @@ test_expect_success 'info added-symlink-directory' "
 		ln -s added-directory added-symlink-directory &&
 		svn_cmd add added-symlink-directory > /dev/null
 	) &&
-	(cd svnwc; svn info added-symlink-directory) \
+	(cd svnwc && svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
-	(cd gitwc; git svn info added-symlink-directory) \
+	(cd gitwc && git svn info added-symlink-directory) \
 		> actual.info-added-symlink-directory &&
 	test_cmp_info expected.info-added-symlink-directory \
 		actual.info-added-symlink-directory
 	"
 
 test_expect_success 'info --url added-symlink-directory' '
-	test "$(cd gitwc; git svn info --url added-symlink-directory)" \
+	test "$(cd gitwc && git svn info --url added-symlink-directory)" \
 	     = "$quoted_svnrepo/added-symlink-directory"
 	'
 
@@ -259,13 +259,13 @@ test_expect_success 'info deleted-file' "
 		cd svnwc &&
 		svn_cmd rm --force file > /dev/null
 	) &&
-	(cd svnwc; svn info file) >expected.info-deleted-file &&
-	(cd gitwc; git svn info file) >actual.info-deleted-file &&
+	(cd svnwc && svn info file) >expected.info-deleted-file &&
+	(cd gitwc && git svn info file) >actual.info-deleted-file &&
 	test_cmp_info expected.info-deleted-file actual.info-deleted-file
 	"
 
 test_expect_success 'info --url file (deleted)' '
-	test "$(cd gitwc; git svn info --url file)" \
+	test "$(cd gitwc && git svn info --url file)" \
 	     = "$quoted_svnrepo/file"
 	'
 
@@ -278,13 +278,13 @@ test_expect_success 'info deleted-directory' "
 		cd svnwc &&
 		svn_cmd rm --force directory > /dev/null
 	) &&
-	(cd svnwc; svn info directory) >expected.info-deleted-directory &&
-	(cd gitwc; git svn info directory) >actual.info-deleted-directory &&
+	(cd svnwc && svn info directory) >expected.info-deleted-directory &&
+	(cd gitwc && git svn info directory) >actual.info-deleted-directory &&
 	test_cmp_info expected.info-deleted-directory actual.info-deleted-directory
 	"
 
 test_expect_success 'info --url directory (deleted)' '
-	test "$(cd gitwc; git svn info --url directory)" \
+	test "$(cd gitwc && git svn info --url directory)" \
 	     = "$quoted_svnrepo/directory"
 	'
 
@@ -297,13 +297,13 @@ test_expect_success 'info deleted-symlink-file' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-file > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-file) >expected.info-deleted-symlink-file &&
-	(cd gitwc; git svn info symlink-file) >actual.info-deleted-symlink-file &&
+	(cd svnwc && svn info symlink-file) >expected.info-deleted-symlink-file &&
+	(cd gitwc && git svn info symlink-file) >actual.info-deleted-symlink-file &&
 	test_cmp_info expected.info-deleted-symlink-file actual.info-deleted-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file (deleted)' '
-	test "$(cd gitwc; git svn info --url symlink-file)" \
+	test "$(cd gitwc && git svn info --url symlink-file)" \
 	     = "$quoted_svnrepo/symlink-file"
 	'
 
@@ -316,13 +316,13 @@ test_expect_success 'info deleted-symlink-directory' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-directory > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-directory) >expected.info-deleted-symlink-directory &&
-	(cd gitwc; git svn info symlink-directory) >actual.info-deleted-symlink-directory &&
+	(cd svnwc && svn info symlink-directory) >expected.info-deleted-symlink-directory &&
+	(cd gitwc && git svn info symlink-directory) >actual.info-deleted-symlink-directory &&
 	test_cmp_info expected.info-deleted-symlink-directory actual.info-deleted-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory (deleted)' '
-	test "$(cd gitwc; git svn info --url symlink-directory)" \
+	test "$(cd gitwc && git svn info --url symlink-directory)" \
 	     = "$quoted_svnrepo/symlink-directory"
 	'
 
@@ -331,27 +331,27 @@ test_expect_success 'info --url symlink-directory (deleted)' '
 
 test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git svn info unknown-file) \
+	(cd gitwc && test_must_fail git svn info unknown-file) \
 		 2> actual.info-unknown-file &&
 	grep unknown-file actual.info-unknown-file
 	"
 
 test_expect_success 'info --url unknown-file' '
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git svn info --url unknown-file) \
+	(cd gitwc && test_must_fail git svn info --url unknown-file) \
 		 2> actual.info-url-unknown-file &&
 	grep unknown-file actual.info-url-unknown-file
 	'
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	(cd gitwc; test_must_fail git svn info unknown-directory) \
+	(cd gitwc && test_must_fail git svn info unknown-directory) \
 		 2> actual.info-unknown-directory &&
 	grep unknown-directory actual.info-unknown-directory
 	"
 
 test_expect_success 'info --url unknown-directory' '
-	(cd gitwc; test_must_fail git svn info --url unknown-directory) \
+	(cd gitwc && test_must_fail git svn info --url unknown-directory) \
 		 2> actual.info-url-unknown-directory &&
 	grep unknown-directory actual.info-url-unknown-directory
 	'
@@ -361,13 +361,13 @@ test_expect_success 'info unknown-symlink-file' "
 		cd gitwc &&
 		ln -s unknown-file unknown-symlink-file
 	) &&
-	(cd gitwc; test_must_fail git svn info unknown-symlink-file) \
+	(cd gitwc && test_must_fail git svn info unknown-symlink-file) \
 		 2> actual.info-unknown-symlink-file &&
 	grep unknown-symlink-file actual.info-unknown-symlink-file
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
-	(cd gitwc; test_must_fail git svn info --url unknown-symlink-file) \
+	(cd gitwc && test_must_fail git svn info --url unknown-symlink-file) \
 		 2> actual.info-url-unknown-symlink-file &&
 	grep unknown-symlink-file actual.info-url-unknown-symlink-file
 	'
@@ -377,13 +377,13 @@ test_expect_success 'info unknown-symlink-directory' "
 		cd gitwc &&
 		ln -s unknown-directory unknown-symlink-directory
 	) &&
-	(cd gitwc; test_must_fail git svn info unknown-symlink-directory) \
+	(cd gitwc && test_must_fail git svn info unknown-symlink-directory) \
 		 2> actual.info-unknown-symlink-directory &&
 	grep unknown-symlink-directory actual.info-unknown-symlink-directory
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
-	(cd gitwc; test_must_fail git svn info --url unknown-symlink-directory) \
+	(cd gitwc && test_must_fail git svn info --url unknown-symlink-directory) \
 		 2> actual.info-url-unknown-symlink-directory &&
 	grep unknown-symlink-directory actual.info-url-unknown-symlink-directory
 	'
-- 
2.18.0.419.gfe4b301394

