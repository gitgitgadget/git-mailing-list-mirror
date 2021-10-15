Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9675C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB90610D2
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhJOJca (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhJOJca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:32:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630FC061753
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:30:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b0030da2439b21so2362636wms.0
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtaJrbbJkmQbyokBPgmIuOZipUouNI3AXf3T3NS2Gxw=;
        b=mOAmLwNhzqm1K4WKMrDqM13aEiJG5UJ0ucbqvR20RPE5+otQjNfJCNRN0Ueh+k4kqV
         M0z/S8KsuSf8yLXFE9hSptUtFC5rjJpGlssE14nZEPJdi0RtGjAuM2e/HvSTT3EGuzWa
         KqDFYHGxv2j5fEERYlJz+Ry2BSTdVLuVAKnVxyAISbuYWP78QHJ27pnpO0iMoM13g/2q
         C88Afwb1zSJFeluGltq7s2ntof1IbduDQ9psxknUhD6aDEo/3n/pmICOlaa3iEF1mnNg
         bG0H5xI55HzaoRfnbOsqXr72HG0i7IUHaXaPBEPpoWxKUNyy1Ap/x0p8ZRKBL7xUObAz
         qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtaJrbbJkmQbyokBPgmIuOZipUouNI3AXf3T3NS2Gxw=;
        b=lTghfjNz9RMHKtcQUM7uba2RMVXYiUVgt0KTxj8/T70zIuYygJ99l7Hlg1CGkZg4oP
         x/NQwooos4/CnVjvyB8AeWhvtBKZ26zvJW8KeD8tjyVylwhgWjPIMovDLQdSpILA3UmO
         PPwBycyXaaQ6seM/89Ocl/4rwDAgLAc1TGmjnqaeBTPsgmhExuvQu7ZUsMMnHxS0EeLE
         euuxULpS00pf0zLk6oYzmZAvoRgfBKHJIJMxysJAUMltfR1F34KFWo1CdGa4I14PTkF9
         hf0aGeafASVV7XfYEsailC5R1osXhI5IulgD2LLdPTxVF1JxHfgBIYvcxdHEziyJnGTz
         h4uw==
X-Gm-Message-State: AOAM532AWshzIWyBmUUXb56maRaXUgGpJxBLWSWo6yekhEEzSFk1J7Hi
        Iaf2dDMXveBDrbqGBZenUGgh3/b4xjgl4A==
X-Google-Smtp-Source: ABdhPJyiIw4xM+r1day79XF/uAgb5oOgdr9hHlLrSExcW/LkB0Fqdaoaattyl2DjpCKhRDy8AlOZBg==
X-Received: by 2002:a05:600c:3b88:: with SMTP id n8mr11248611wms.93.1634290221799;
        Fri, 15 Oct 2021 02:30:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k17sm4542735wrq.7.2021.10.15.02.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:30:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] tests: stop using top-level "README" and "COPYING" files
Date:   Fri, 15 Oct 2021 11:30:17 +0200
Message-Id: <patch-v3-2.2-f555ebb7055-20211015T092605Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-0.2-00000000000-20211015T092605Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20211015T092605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 459b8d22e54 (tests: do not borrow from COPYING and README from the
real source, 2015-02-15) tests that used "lib-diff.sh" (called
"diff-lib.sh" then) were made to stop relying on the top-level COPYING
file, but we still had other tests that referenced it.

Let's move them over to use the "COPYING_test_data" utility function
introduced in the preceding commit, and in the case of the one test
that needed the "README" file use a ROT 13 version of that "COPYING"
test data. That test added in afd222967c6 (Extend testing git-mv for
renaming of subdirectories, 2006-07-26) just needs more test data that's not the same as the "COPYING" test data, so a ROT 13 version will do.

This change removes the last references to ../{README,COPYING} in the
test suite.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4022-diff-rewrite.sh           |  6 ++++--
 t/t4023-diff-rename-typechange.sh | 11 ++++++-----
 t/t7001-mv.sh                     |  5 +++--
 t/t7101-reset-empty-subdirs.sh    | 11 ++++++-----
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6d1c3d949c7..1c89050a974 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -3,15 +3,17 @@
 test_description='rewrite diff'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-data.sh
 
 test_expect_success setup '
 
-	cat "$TEST_DIRECTORY"/../COPYING >test &&
+	COPYING_test_data >test.data &&
+	cp test.data test &&
 	git add test &&
 	tr \
 	  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" \
 	  "nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" \
-	  <"$TEST_DIRECTORY"/../COPYING >test &&
+	  <test.data >test &&
 	echo "to be deleted" >test2 &&
 	blob=$(git hash-object test2) &&
 	blob=$(git rev-parse --short $blob) &&
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 8c9823765e6..47d6f35dcc4 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -3,25 +3,26 @@
 test_description='typechange rename detection'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
 
 test_expect_success setup '
 
 	rm -f foo bar &&
-	cat "$TEST_DIRECTORY"/../COPYING >foo &&
+	COPYING_test_data >foo &&
 	test_ln_s_add linklink bar &&
 	git add foo &&
 	git commit -a -m Initial &&
 	git tag one &&
 
 	git rm -f foo bar &&
-	cat "$TEST_DIRECTORY"/../COPYING >bar &&
+	COPYING_test_data >bar &&
 	test_ln_s_add linklink foo &&
 	git add bar &&
 	git commit -a -m Second &&
 	git tag two &&
 
 	git rm -f foo bar &&
-	cat "$TEST_DIRECTORY"/../COPYING >foo &&
+	COPYING_test_data >foo &&
 	git add foo &&
 	git commit -a -m Third &&
 	git tag three &&
@@ -35,7 +36,7 @@ test_expect_success setup '
 	# This is purely for sanity check
 
 	git rm -f foo bar &&
-	cat "$TEST_DIRECTORY"/../COPYING >foo &&
+	COPYING_test_data >foo &&
 	cat "$TEST_DIRECTORY"/../Makefile >bar &&
 	git add foo bar &&
 	git commit -a -m Fifth &&
@@ -43,7 +44,7 @@ test_expect_success setup '
 
 	git rm -f foo bar &&
 	cat "$TEST_DIRECTORY"/../Makefile >foo &&
-	cat "$TEST_DIRECTORY"/../COPYING >bar &&
+	COPYING_test_data >bar &&
 	git add foo bar &&
 	git commit -a -m Sixth &&
 	git tag six
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 25bb9bbb899..963356ba5f9 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -2,10 +2,11 @@
 
 test_description='git mv in subdirs'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-data.sh
 
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
-	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	COPYING_test_data >path0/COPYING &&
 	git add path0/COPYING &&
 	git commit -m add -a
 '
@@ -107,7 +108,7 @@ test_expect_success 'clean up' '
 '
 
 test_expect_success 'adding another file' '
-	cp "$TEST_DIRECTORY"/../README.md path0/README &&
+	COPYING_test_data | tr A-Za-z N-ZA-Mn-za-m >path0/README &&
 	git add path0/README &&
 	git commit -m add2 -a
 '
diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index bfce05ac5de..5530651eea4 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -5,10 +5,11 @@
 
 test_description='git reset should cull empty subdirs'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff-data.sh
 
 test_expect_success 'creating initial files' '
      mkdir path0 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+     COPYING_test_data >path0/COPYING &&
      git add path0/COPYING &&
      git commit -m add -a
 '
@@ -16,10 +17,10 @@ test_expect_success 'creating initial files' '
 test_expect_success 'creating second files' '
      mkdir path1 &&
      mkdir path1/path2 &&
-     cp "$TEST_DIRECTORY"/../COPYING path1/path2/COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING path1/COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING COPYING &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING-TOO &&
+     COPYING_test_data >path1/path2/COPYING &&
+     COPYING_test_data >path1/COPYING &&
+     COPYING_test_data >COPYING &&
+     COPYING_test_data >path0/COPYING-TOO &&
      git add path1/path2/COPYING &&
      git add path1/COPYING &&
      git add COPYING &&
-- 
2.33.1.1338.g20da966911a

