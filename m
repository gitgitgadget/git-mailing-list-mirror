Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8661C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbiEIR7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbiEIR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E482D9EC7
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z19so17201355edx.9
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XXaK4kQi3ZqBNX4SrkpzOMHG1SJ+3aHGzQCBDnT53Uw=;
        b=g312imxpRfnI+1s9C7Z7hFPKit29M24E03GN1yshYnKhQWt0NOhfqYMRkBliDYPqdq
         /pfswYbjuEynwdGsHp+AGT5kn6jOMD5NmWwNNAmgnVfZZmYG5qI9o7vyMcd0UZIwdxey
         XYtUlZ220oujBk/E6gBuc9DWtuYLQRxQDhR28/Dn9qeeMQLfRMMkBXk4A+vpn2NPT831
         u72VRG/ZlxPuOjiEMwK+1krYCBe8/U8p2iJhXtg+7wz5KIzW1fRBNGEeKOP1Tr61v957
         7C5w5WNJEGcjaY6ANNlCju54BbYjxRhSnXHItJlPpQWL+XvMhuYJfpzgx5bL6WzX4EL1
         pCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XXaK4kQi3ZqBNX4SrkpzOMHG1SJ+3aHGzQCBDnT53Uw=;
        b=VdTrD9GZOVQA5qKOiiOl+TfiS4EkNU0ItT4HD0x5R7CAxvvgGWbe4+zz0jooLu0is+
         exdOf8hdypnGUOde9LTT/VrXa3Bq3xgxSEpgNf2sEO/kURMkesI542VO3qK7QadnxdmD
         KD8D7Kqml12YwsNntBKdJsawBfpjX0FDsfP3tgcxLrSr6+6e0XwsSmeC5Szz6dNSfjQz
         YfUxbAhGAOB5lkbS6R+xAgiGvidmVHtU8dHXkDuD/5/jfSumYdQ0LjhurbhE934Vgu++
         0hHBTzL9lG5lQCSa2mhpBvn+RZu/ma+U7p1IdQ2iGyg1ymytEGTo1Hc97P7Id9nnbC8X
         o1+A==
X-Gm-Message-State: AOAM532ENNgh1lkjs+lcWaXJmWggRD62viEz2OqkYSpRB64S7V6ekefH
        /BODe6RmtXqwP77o4mp0/S+1a32VbqM=
X-Google-Smtp-Source: ABdhPJzYjzknZniLjK5KKH0WDd5JksLGhknCgnjTjgKtfLI8Q1JzKemlyY8adtx0ypBkWBL8boHJbQ==
X-Received: by 2002:a05:6402:1d51:b0:41f:cf6c:35a5 with SMTP id dz17-20020a0564021d5100b0041fcf6c35a5mr18863820edb.25.1652118905418;
        Mon, 09 May 2022 10:55:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:05 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 07/15] t0066: better test coverage for dir-iterator
Date:   Mon,  9 May 2022 20:51:51 +0300
Message-Id: <20220509175159.2948802-8-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dir-iterator is lacking test coverage for some cases:
  * root directory and/or subdirectories w/o perms
  * pedantic runs on directories with cyclical symlinks
  * more thorough tests without sorting expected and actual outputs

Improve test coverage by introducing tests that test ELOOP and EACCES
errno and various directory hierarchies that cover most cases.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 290 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 289 insertions(+), 1 deletion(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 61b02423d5..932b1f291c 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -5,6 +5,97 @@ test_description='Test the dir-iterator functionality'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'setup -- dir with a single file' '
+	mkdir dir1 &&
+	>dir1/a
+'
+test_expect_success 'iteration of dir with a file' '
+	cat >expected-out <<-EOF &&
+	[f] (a) [a] ./dir1/a
+	EOF
+
+	test-tool dir-iterator ./dir1 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
+test_expect_success 'setup -- dir with a single dir' '
+	mkdir -p dir6/a
+'
+test_expect_success 'iteration of dir with a single dir' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir6/a
+	EOF
+
+	test-tool dir-iterator ./dir6 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
+test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
+	mkdir -p dir13/a
+'
+test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test-tool dir-iterator ./dir13/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
+test_expect_success POSIXPERM,SANITY 'pedantic iteration of dir w/ dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir13/a
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir13/a &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir13/ >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir13/a
+'
+
+test_expect_success 'setup -- dir w/ five files' '
+	mkdir dir14 &&
+	>dir14/a &&
+	>dir14/b &&
+	>dir14/c &&
+	>dir14/d &&
+	>dir14/e
+'
+test_expect_success 'iteration of dir w/ five files' '
+	cat >expected-sorted-out <<-EOF &&
+	[f] (a) [a] ./dir14/a
+	[f] (b) [b] ./dir14/b
+	[f] (c) [c] ./dir14/c
+	[f] (d) [d] ./dir14/d
+	[f] (e) [e] ./dir14/e
+	EOF
+
+	test-tool dir-iterator ./dir14 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+
+test_expect_success 'setup -- dir w/ dir w/ a file' '
+	mkdir -p dir15/a &&
+	>dir15/a/b
+'
+test_expect_success 'iteration of dir w/ dir w/ a file' '
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir15/a
+	[f] (a/b) [b] ./dir15/a/b
+	EOF
+
+	test-tool dir-iterator ./dir15 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
 test_expect_success 'setup -- dir w/ complex structure' '
 	mkdir -p dir &&
 	mkdir -p dir/a/b/c/ &&
@@ -49,10 +140,178 @@ test_expect_success 'dir-iterator should list files in the correct order' '
 	EOF
 
 	test-tool dir-iterator ./dir2 >actual-out &&
-
 	test_cmp expected-out actual-out
 '
 
+test_expect_success POSIXPERM,SANITY \
+'setup -- dir w/ three nested dirs w/ file, second nested dir w/o perms' '
+
+	mkdir -p dir7/a/b/c &&
+	>dir7/a/b/c/d
+'
+test_expect_success POSIXPERM,SANITY \
+'iteration of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test-tool dir-iterator ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+test_expect_success POSIXPERM,SANITY \
+'pedantic iteration of dir w/ three nested dirs w/ file, second w/o perms' '
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir7/a/b &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir7 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+
+test_expect_success 'setup -- dir w/ two dirs each w/ file' '
+	mkdir -p dir8/a &&
+	>dir8/a/b &&
+	mkdir dir8/c &&
+	>dir8/c/d
+'
+test_expect_success 'iteration of dir w/ two dirs each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	EOF
+
+	test-tool dir-iterator ./dir8 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+
+test_expect_success 'setup -- dir w/ two dirs, one w/ two and one w/ one files' '
+	mkdir -p dir9/a &&
+	>dir9/a/b &&
+	>dir9/a/c &&
+	mkdir dir9/d &&
+	>dir9/d/e
+'
+test_expect_success \
+'iteration of dir w/ two dirs, one w/ two and one w/ one files' '
+
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir9/a
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (a) [a] ./dir9/a
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	EOF
+	cat >expected-out3 <<-EOF &&
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (a) [a] ./dir9/a
+	[f] (a/b) [b] ./dir9/a/b
+	[f] (a/c) [c] ./dir9/a/c
+	EOF
+	cat >expected-out4 <<-EOF &&
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (a) [a] ./dir9/a
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	EOF
+
+	test-tool dir-iterator ./dir9 >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out ||
+		test_cmp expected-out3 actual-out ||
+		test_cmp expected-out4 actual-out
+	)
+'
+
+test_expect_success 'setup -- dir w/ two nested dirs, each w/ file' '
+	mkdir -p dir10/a &&
+	>dir10/a/b &&
+	mkdir dir10/a/c &&
+	>dir10/a/c/d
+'
+test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	EOF
+	cat >expected-out2 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[f] (a/b) [b] ./dir10/a/b
+	EOF
+
+	test-tool dir-iterator ./dir10/ >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+
+test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
+	mkdir -p dir12/a &&
+	>dir12/a/b
+'
+test_expect_success POSIXPERM,SANITY 'iteration of root dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
+test_expect_success POSIXPERM,SANITY 'pedantic iteration of root dir w/o perms' '
+	cat >expected-out <<-EOF &&
+	dir_iterator_advance failure: EACCES
+	EOF
+
+	chmod 0 dir12 &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir12 >actual-out &&
+	test_cmp expected-out actual-out &&
+
+	chmod 755 dir12
+'
+
 test_expect_success 'begin should fail upon inexistent paths' '
 	echo "dir_iterator_begin failure: ENOENT" >expected-out &&
 
@@ -147,5 +406,34 @@ test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
 	ln -s ../ dir5/a/b/e &&
 	ln -s ../../ dir5/a/b/f
 '
+test_expect_success SYMLINKS 'iteration of dir w/ symlinks w/ cycle' '
+
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir5/a
+	[d] (a/b) [b] ./dir5/a/b
+	[d] (a/c) [c] ./dir5/a/c
+	[s] (a/b/d) [d] ./dir5/a/b/d
+	[s] (a/b/e) [e] ./dir5/a/b/e
+	[s] (a/b/f) [f] ./dir5/a/b/f
+	EOF
+
+	test-tool dir-iterator ./dir5 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'pedantic follow-symlinks iteration of dir w/ symlinks w/ cycle' '
+
+	cat >expected-tailed-out <<-EOF &&
+	dir_iterator_advance failure: ELOOP
+	EOF
+
+	test_must_fail test-tool dir-iterator \
+		--pedantic --follow-symlinks ./dir5 >actual-out &&
+	tail -n 1 actual-out >actual-tailed-out &&
+
+	test_cmp expected-tailed-out actual-tailed-out
+'
 
 test_done
-- 
2.36.1

