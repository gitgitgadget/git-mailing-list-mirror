Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7045EC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239793AbiEIR6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiEIR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:58:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F762CCD1E
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:54:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bv19so28322241ejb.6
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgu2nu5frVNPOrgrPatkjog1kZZjyDz0nQ8ay2sNRAE=;
        b=PXUMPsWctzNu7Vpc0GOoTe3bbzihJD9CqUt3LYMhXAzE6HLrZuCBMD2uDq6yfU9dEq
         OeKpaSlr9J8BwwT5G4/D76/62R3+g40w56caby5h3iDSCL9SLp/oh0ejcZ9rGW7shzC7
         k18TVLYrGl1+3TsGRJgOT2gup0sNBHEbXyiOdNDO9jw+cahwFChG+59Yi4gMf9Wa6WMl
         /J5WDhbPKeVH9MaB9BRvqAKU913lndHd23+rkQyjstgG56nlPR+JR3KyY6pT7b7JUiTi
         YOoStYLl5sicoJFv0Xef17Z2jspaHNOpCgQ/RWDGdMbiBhAG4xf1+K4e23SxBaTTN1xc
         VRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgu2nu5frVNPOrgrPatkjog1kZZjyDz0nQ8ay2sNRAE=;
        b=pEoHpH42MRXvAn6KqeskMBYhYjGs9m2FKArNr1mSlDL0iWoTZE7ArLPG75TFDAn06j
         EPF3hsF/zhVPQZAZTjxkah4n1uik23JjVomW/IPwOTwUuYXTTDXUorX+XcKPz8mdYdSh
         b9Q+cup6IbFnbhTe8POHikiA7t3qEeSPHtGNMbIRZulS1aD/Ay7j2Cosf2ecWUiIjryE
         PLBxtFO17v8b4gxjUhfSURBnGvbv98G1mFscrFqstiKC57EDv6hBO9bdl/qyc5XdRDTG
         k29mKIoWnanaK2ILDrlFIcueIv440j0ERSjo1I8ZLK7oqfhhovh8wRKDkRhCkg3VTRp7
         2bIQ==
X-Gm-Message-State: AOAM530JSBm/7uUmzwb/IWZFw5l+yB66bsyglWtXSw5Gly6FBheJ+l5t
        PpbkosymmL/E3/I6p+CDL7hjHdt24i8=
X-Google-Smtp-Source: ABdhPJy6Q+I0Jsw0j2ZY8/ypabFp2kLgMYKgplcf91y0qX2ICjsOEpkjWYcTA2wS73Lsp2rzwI1Kqw==
X-Received: by 2002:a17:907:7212:b0:6f4:fdc7:b7f3 with SMTP id dr18-20020a170907721200b006f4fdc7b7f3mr15995409ejc.16.1652118893379;
        Mon, 09 May 2022 10:54:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:54:53 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 01/15] t0066: refactor dir-iterator tests
Date:   Mon,  9 May 2022 20:51:45 +0300
Message-Id: <20220509175159.2948802-2-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Be consistent throughout the dir-iterator tests regarding the order in
which we:
  * create test directories
  * create expected outputs
  * test if actual and expected outputs differ

These changes improve the readability of dir-iterator tests, separating
setup tests as we want to test different iteration schemes over the same
hierarchy. They also simplify the introduction of new tests that cover
current and future iteration schemes by providing a standardized
structure for testing dir-iterator with various directory hierarchies.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 55 +++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 63a1a45cd3..807c43d447 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -5,7 +5,7 @@ test_description='Test the dir-iterator functionality'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-test_expect_success 'setup' '
+test_expect_success 'setup -- dir w/ complex structure' '
 	mkdir -p dir &&
 	mkdir -p dir/a/b/c/ &&
 	>dir/b &&
@@ -13,12 +13,8 @@ test_expect_success 'setup' '
 	mkdir -p dir/d/e/d/ &&
 	>dir/a/b/c/d &&
 	>dir/a/e &&
-	>dir/d/e/d/a &&
-
-	mkdir -p dir2/a/b/c/ &&
-	>dir2/a/b/c/d
+	>dir/d/e/d/a
 '
-
 test_expect_success 'dir-iterator should iterate through all files' '
 	cat >expected-iteration-sorted-output <<-EOF &&
 	[d] (a) [a] ./dir/a
@@ -40,6 +36,10 @@ test_expect_success 'dir-iterator should iterate through all files' '
 	test_cmp expected-iteration-sorted-output actual-iteration-sorted-output
 '
 
+test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
+	mkdir -p dir2/a/b/c &&
+	>dir2/a/b/c/d
+'
 test_expect_success 'dir-iterator should list files in the correct order' '
 	cat >expected-pre-order-output <<-EOF &&
 	[d] (a) [a] ./dir2/a
@@ -54,65 +54,59 @@ test_expect_success 'dir-iterator should list files in the correct order' '
 '
 
 test_expect_success 'begin should fail upon inexistent paths' '
+	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
+
 	test_must_fail test-tool dir-iterator ./inexistent-path \
 		>actual-inexistent-path-output &&
-	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
+
 	test_cmp expected-inexistent-path-output actual-inexistent-path-output
 '
 
 test_expect_success 'begin should fail upon non directory paths' '
-	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
 	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
+
+	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
+
 	test_cmp expected-non-dir-output actual-non-dir-output
 '
 
+test_expect_success POSIXPERM,SANITY 'setup -- dir w/ dir w/o perms w/ file' '
+	mkdir -p dir3/a &&
+	>dir3/a/b
+'
 test_expect_success POSIXPERM,SANITY 'advance should not fail on errors by default' '
 	cat >expected-no-permissions-output <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	EOF
 
-	mkdir -p dir3/a &&
-	>dir3/a/b &&
 	chmod 0 dir3/a &&
 
 	test-tool dir-iterator ./dir3 >actual-no-permissions-output &&
 	test_cmp expected-no-permissions-output actual-no-permissions-output &&
-	chmod 755 dir3/a &&
-	rm -rf dir3
+	chmod 755 dir3/a
 '
-
 test_expect_success POSIXPERM,SANITY 'advance should fail on errors, w/ pedantic flag' '
 	cat >expected-no-permissions-pedantic-output <<-EOF &&
 	[d] (a) [a] ./dir3/a
 	dir_iterator_advance failure
 	EOF
 
-	mkdir -p dir3/a &&
-	>dir3/a/b &&
 	chmod 0 dir3/a &&
 
 	test_must_fail test-tool dir-iterator --pedantic ./dir3 \
 		>actual-no-permissions-pedantic-output &&
 	test_cmp expected-no-permissions-pedantic-output \
 		actual-no-permissions-pedantic-output &&
-	chmod 755 dir3/a &&
-	rm -rf dir3
+	chmod 755 dir3/a
 '
 
-test_expect_success SYMLINKS 'setup dirs with symlinks' '
+test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/o cycle' '
 	mkdir -p dir4/a &&
 	mkdir -p dir4/b/c &&
 	>dir4/a/d &&
 	ln -s d dir4/a/e &&
-	ln -s ../b dir4/a/f &&
-
-	mkdir -p dir5/a/b &&
-	mkdir -p dir5/a/c &&
-	ln -s ../c dir5/a/b/d &&
-	ln -s ../ dir5/a/b/e &&
-	ln -s ../../ dir5/a/b/f
+	ln -s ../b dir4/a/f
 '
-
 test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default' '
 	cat >expected-no-follow-sorted-output <<-EOF &&
 	[d] (a) [a] ./dir4/a
@@ -128,7 +122,6 @@ test_expect_success SYMLINKS 'dir-iterator should not follow symlinks by default
 
 	test_cmp expected-no-follow-sorted-output actual-no-follow-sorted-output
 '
-
 test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag' '
 	cat >expected-follow-sorted-output <<-EOF &&
 	[d] (a) [a] ./dir4/a
@@ -146,4 +139,12 @@ test_expect_success SYMLINKS 'dir-iterator should follow symlinks w/ follow flag
 	test_cmp expected-follow-sorted-output actual-follow-sorted-output
 '
 
+test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
+	mkdir -p dir5/a/b &&
+	mkdir -p dir5/a/c &&
+	ln -s ../c dir5/a/b/d &&
+	ln -s ../ dir5/a/b/e &&
+	ln -s ../../ dir5/a/b/f
+'
+
 test_done
-- 
2.36.1

