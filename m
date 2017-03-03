Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79CB720133
	for <e@80x24.org>; Fri,  3 Mar 2017 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbdCCNsN (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 08:48:13 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35541 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCCNsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 08:48:11 -0500
Received: by mail-pf0-f196.google.com with SMTP id 67so5579764pfg.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 05:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lf7gPyax3+YhzoTH4hJstl4K/5MfAOCNVdlCL6CANt8=;
        b=QRl7Cmg45poyAoLG8NggDPaQh9IL6Q4booWCi3sULT8L0PTZcKlSLpF3+MWCdvm/4j
         CfygIRqbrTbr7Hm4wQYfRwRWKPrdDLdSGw6xO9Jz7H2RdNcjrOiNO0KI7XoIjiyRbeTu
         OZ95KkpRlqiUzrVui0KJ9cb6XnojaVH4zkIcnLXbjmBo/6BH4QV/YdcchMFzdAGFEUof
         ieknej+1eruXovtMak+s2Eh3lWc01JlwMQJEwzbX50DkWoGR5CkdRYmlJ6UYUJB8RrVQ
         6qDgieZGZrR/7Zwp1WPdfG8oD55qHBIgb7+j5TsUozHesInKjXNbU/rTEYakJVa9RL3l
         uwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lf7gPyax3+YhzoTH4hJstl4K/5MfAOCNVdlCL6CANt8=;
        b=QjWqOXIt9jA2bUh0wY6NyF99UDDk42w4fafV6QTMZ4yzVzTGrEl5pGkBEqcdsQzFE9
         BmH1DCcZskmQIPCqh4ic+P6SrNEHp9OEkNytTiM5mmWkJ6OQbuej11uRCndDZ3VaekBg
         DGaow3GPzCmWdFeeHH4Hk6qd851sNKcz1Xn4Cxxgn+NlH7jCw4nJhdNo5GwSvQIiwkFk
         PimRhnxvQ5YXnCgzeJxVI3GbDWXNQOGxDUvij+Lns0/QW+N3hJP4cQBuilw9o4xHE30W
         DKGEMdppklDY+B6zXgvHt9hYy9uGjuARq8RHsVlK6zu63SLs6/+uZXKR1XlhtTFeG07n
         d1eQ==
X-Gm-Message-State: AMke39mK7VzNQpG6jMhkd5cUcXVqZtFsbjoxOtM+7m1BCABs2ztUj/Y0LeyhmuYX5o611g==
X-Received: by 10.98.220.200 with SMTP id c69mr3557903pfl.60.1488548425101;
        Fri, 03 Mar 2017 05:40:25 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id e13sm23815540pgn.38.2017.03.03.05.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2017 05:40:24 -0800 (PST)
Date:   Fri, 3 Mar 2017 05:40:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 2/5] Use -y where possible in test t7610-mergetool
Message-ID: <20170303134022.GA6258@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In these tests, there are many situations where
'echo "" | git mergetool' is used. This replaces all of those
occurrences with 'git mergetool -y' for simplicity and readability.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7610-mergetool.sh | 62 ++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index a9e274add..01c1d44a9 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -131,10 +131,10 @@ test_expect_success 'custom mergetool' '
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_expect_code 1 git merge master >/dev/null 2>&1 &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool file1 file1 ) &&
-	( yes "" | git mergetool file2 "spaced name" >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+	git mergetool -y both >/dev/null 2>&1 &&
+	git mergetool -y file1 file1 &&
+	git mergetool -y file2 "spaced name" >/dev/null 2>&1 &&
+	git mergetool -y subdir/file3 >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
@@ -154,11 +154,11 @@ test_expect_success 'mergetool crlf' '
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
 	test_expect_code 1 git merge master >/dev/null 2>&1 &&
-	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool "spaced name" >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool subdir/file3 >/dev/null 2>&1 ) &&
+	git mergetool file1 >/dev/null 2>&1 &&
+	git mergetool file2 >/dev/null 2>&1 &&
+	git mergetool "spaced name" >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
+	git mergetool subdir/file3 >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
 	( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod >/dev/null 2>&1 ) &&
@@ -177,7 +177,7 @@ test_expect_success 'mergetool in subdir' '
 	(
 		cd subdir &&
 		test_expect_code 1 git merge master >/dev/null 2>&1 &&
-		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
+		git mergetool file3 >/dev/null 2>&1 &&
 		test "$(cat file3)" = "master new sub"
 	)
 '
@@ -189,10 +189,10 @@ test_expect_success 'mergetool on file in parent dir' '
 	(
 		cd subdir &&
 		test_expect_code 1 git merge master >/dev/null 2>&1 &&
-		( yes "" | git mergetool file3 >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../file1 >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 ) &&
-		( yes "" | git mergetool ../both >/dev/null 2>&1 ) &&
+		git mergetool file3 >/dev/null 2>&1 &&
+		git mergetool ../file1 >/dev/null 2>&1 &&
+		git mergetool ../file2 ../spaced\ name >/dev/null 2>&1 &&
+		git mergetool ../both >/dev/null 2>&1 &&
 		( yes "d" | git mergetool ../file11 >/dev/null 2>&1 ) &&
 		( yes "d" | git mergetool ../file12 >/dev/null 2>&1 ) &&
 		( yes "l" | git mergetool ../submod >/dev/null 2>&1 ) &&
@@ -302,7 +302,7 @@ test_expect_success 'mergetool takes partial path' '
 	git submodule update -N &&
 	test_expect_code 1 git merge master &&
 
-	( yes "" | git mergetool subdir ) &&
+	git mergetool subdir &&
 
 	test "$(cat subdir/file3)" = "master new sub"
 '
@@ -370,8 +370,8 @@ test_expect_success 'deleted vs modified submodule' '
 	git checkout -b test$test_count.a test$test_count &&
 	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
 	rmdir submod && mv submod-movedaside submod &&
@@ -387,8 +387,8 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test ! -e submod &&
@@ -401,8 +401,8 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
 	test ! -e submod &&
@@ -417,8 +417,8 @@ test_expect_success 'deleted vs modified submodule' '
 	git submodule update -N &&
 	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test "$(cat submod/bar)" = "master submodule" &&
@@ -441,8 +441,8 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.a branch1 &&
 	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
 	rmdir submod && mv submod-movedaside submod &&
@@ -457,8 +457,8 @@ test_expect_success 'file vs modified submodule' '
 	git checkout -b test$test_count.b test$test_count &&
 	test_expect_code 1 git merge master &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
 	git submodule update -N &&
@@ -473,8 +473,8 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both >/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "r" | git mergetool submod ) &&
 	test -d submod.orig &&
@@ -489,8 +489,8 @@ test_expect_success 'file vs modified submodule' '
 	git submodule update -N &&
 	test_expect_code 1 git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
-	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
-	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
+	git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 &&
+	git mergetool both>/dev/null 2>&1 &&
 	( yes "d" | git mergetool file11 file12 >/dev/null 2>&1 ) &&
 	( yes "l" | git mergetool submod ) &&
 	test "$(cat submod/bar)" = "master submodule" &&
-- 
2.12.0.5.gfbc750a84

