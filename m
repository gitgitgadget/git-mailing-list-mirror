Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58BEC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD43E61165
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhJERDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbhJERDW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:03:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72846C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:01:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s15so10433216wrv.11
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iy4Kt8uMCztPKVPNPDBWxa1R8mnUJUdJL2wCRW8neSA=;
        b=e48WVzGol/2jecei/gBmymFM0tkUMSkbcSWAt4WHIw4LRsg+l01Vzsm9EBf2vZWKHG
         eUGKGDM/MU8hZSSOhoeWIxZX/PdVXvX7AbLxpfFt+Z6ISk9+WQ1y9Bx3zfx4lL/kzf9I
         i6emmaKMNZPw4Tc/hFnO+emZE/F/wkJUWATW1mQqf52Rnf1ctfdSJzdHyHjz3UXywc2L
         mF3e2c1F+ZpJeHFlyaLAq1gXTKmu18mTMxohhs/Y8TKQrVEFK+gY1gBW9tWQIb2HIKF0
         naDR8rdR6okNpF3nYsa2GEYMvqoLg5EbcPm9ZqO0D5xTSL0O3x+LFftsa3lRSpMl7dcU
         zBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iy4Kt8uMCztPKVPNPDBWxa1R8mnUJUdJL2wCRW8neSA=;
        b=mHj0sG+twQbUsvdplzX8sRZCckVoMmJ3epQ+Gf2ZfKhCz6P89SZI3jKzXNZNvy+9JJ
         WO3jniWEWTCM4eJVsK/t/+z7dNBrIbeOqVvBq/viVmAuesQKrDkh/t3VNAVVXf7sI4jQ
         v3kcscRVK/dslrMesnRrSe0x9hS7GK1d9mW8IQmniVp3d5Hqoxg6DB45oTMAi9sfY8UX
         cUMnFR59R2DH5z3dX2WmkkHrpM3QvnVj61UAE4HFdYaa+/inbGoCxb/Qy9LoilSd09jv
         khKiozHLFKGAV/CLPOR3QQHoBqJNWIBvf4sdTOsXoperzZHAhjBu6sjzSsD1iU93uY1O
         8MuA==
X-Gm-Message-State: AOAM531lJhSKeTKXLt1Kv31J+LAzq47jMirDkCZ8oSaaBDTxXueFXmCX
        eoOtUTbhArXAJewIcQCCLeNSH4Tnb3k=
X-Google-Smtp-Source: ABdhPJxf99VELcaEpBJ1c8oGQYmHgqO7D4vdFMlrh3QJRGLORc1NNmOAPa6/kzqJRA33GzpqdI94nQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr23267924wrd.194.1633453289753;
        Tue, 05 Oct 2021 10:01:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z79sm2551261wmc.17.2021.10.05.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:01:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] tests: stop using top-level "README" and "COPYING" files
Date:   Tue,  5 Oct 2021 19:01:14 +0200
Message-Id: <patch-v2-2.5-f7cd2f31ccb-20211005T170031Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
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
2.33.0.1441.gbbcdb4c3c66

