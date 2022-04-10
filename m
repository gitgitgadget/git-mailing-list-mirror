Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FDBC433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 11:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiDJLYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiDJLYE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 07:24:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26A6578F
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:21:53 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v20-20020a05600c15d400b0038e9a88aee7so5186976wmf.3
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlv6xtgk3Gn4aKC70WM84GE0zoBobC9PfMvi4ZYh0oI=;
        b=qVMNE9anjOhiQlg7OhCeoPm9mJFTiTqBWfbiSClYzLz9k3JUU2LX0ezyDlJooHfCmF
         RAvjIHdYVhJN27uEd/mYwd2EaDVJfj7uCTcE8nyjKPWVRp+vFyVEjOgR7c8p/n9MMAJ9
         le3sGTinUTYLOB9CYxk1AoZh0/5VlmOHQy1YRDok41VKZTc9NkWUBc9cLHh+nabOiaq+
         ogGMvvXWNdApdXCWeROzzGx5qyTXay1br7rJvR6DuQ+W783PuP2dBCQU0ettw3b1KJRy
         C1QVfYWHp451c6flA/a4C207HTVSHoXNvnylmlTVoiCnUeRlwqUmP3Do8c3zY3iwgb13
         DHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlv6xtgk3Gn4aKC70WM84GE0zoBobC9PfMvi4ZYh0oI=;
        b=cUDCsc3gXXqJ9ZVQ8vbtebKCqhFcihE6et3N29i5BTBuLkaiT9/0FSG+GYy861//h9
         yiI0iWOf39r5k/zF+7p+RnbnVNTalqbsCkcNcq9JLUmAud1Axn14i8DoH61zFB37TBzp
         WOjMFKK/Dj1MrGo+PO7TsivwLj619E99etfI8dSQiXNtZpDzoiLJgFitA3cqJhoQAzLc
         bHGDUZxcl3TgZ8HT4rxFx2ykDsep4iZQROmcNtGddow3PMWGUM+unEho0pMUbi4ugdDh
         YbKLUh7N3T8OqBfudi7r9byc6LepMroyUlsAzHv0gN8ItkF39OpxfY4N9yt4JAjB2pBh
         Cx+A==
X-Gm-Message-State: AOAM531pQYXUKI6FD4G+m+FnSQQFItJRHAzWp/TVN6RCbz/nM7RihIP3
        MX5l1Seq5n9i4PTHJiJTN1rnjbhLONY=
X-Google-Smtp-Source: ABdhPJzxExOuXzQmUqQbnJxV0OqcaBVxymwd1DZ9uD2shKptp3MCMF7AA6OVpZi7Tfl7amQMIQBIGg==
X-Received: by 2002:a05:600c:4f0c:b0:38c:bdf5:2232 with SMTP id l12-20020a05600c4f0c00b0038cbdf52232mr24898107wmq.90.1649589712177;
        Sun, 10 Apr 2022 04:21:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a18:7100:c718:bf46:5915:85be])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0037bdfa1665asm19149452wmj.18.2022.04.10.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 04:21:51 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, mhagger@alum.mit.edu,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [RFC PATCH 2/6] t0066: better test coverage for dir-iterator
Date:   Sun, 10 Apr 2022 14:18:48 +0300
Message-Id: <20220410111852.2097418-3-kioplato@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220410111852.2097418-1-kioplato@gmail.com>
References: <20220410111852.2097418-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dir-iterator is lacking test coverage for some cases:
  * root directory and/or subdirectories w/o perms
  * pedantic runs on directories with cyclical symlinks
  * more thorough tests without sorting expected and actual outputs

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 291 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 291 insertions(+)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index fb20219487..0a98dd54ba 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -5,6 +5,94 @@ test_description='Test the dir-iterator functionality'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'setup -- dir with a single file' '
+	mkdir dir1 &&
+	>dir1/a &&
+
+
+	cat >expected-out <<-EOF
+	[f] (a) [a] ./dir1/a
+	EOF
+'
+test_expect_success 'iteration of dir with a file' '
+	test-tool dir-iterator ./dir1 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
+test_expect_success 'setup -- dir with a single dir' '
+	mkdir -p dir2/a &&
+
+
+	cat >expected-out <<-EOF
+	[d] (a) [a] ./dir2/a
+	EOF
+'
+test_expect_success 'iteration of dir with a single dir' '
+	test-tool dir-iterator ./dir2 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
+test_expect_success POSIXPERM,SANITY 'setup -- dir w/ single dir w/o perms' '
+	mkdir -p dir3/a &&
+	chmod 0 dir3/a &&
+
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir3/a
+	EOF
+	cat >expected-pedantic-out <<-EOF
+	[d] (a) [a] ./dir3/a
+	dir_iterator_advance failure
+	EOF
+'
+test_expect_success POSIXPERM,SANITY 'iteration of dir w/ dir w/o perms' '
+	test-tool dir-iterator ./dir3/ >actual-out &&
+	test_cmp expected-out actual-out
+'
+test_expect_success POSIXPERM,SANITY 'pedantic iteration of dir w/ dir w/o perms' '
+	test_must_fail test-tool dir-iterator --pedantic ./dir3/ >actual-out &&
+	test_cmp expected-pedantic-out actual-out
+'
+
+test_expect_success 'setup -- dir w/ five files' '
+	mkdir dir4 &&
+	>dir4/a &&
+	>dir4/b &&
+	>dir4/c &&
+	>dir4/d &&
+	>dir4/e &&
+
+
+	cat >expected-sorted-out <<-EOF
+	[f] (a) [a] ./dir4/a
+	[f] (b) [b] ./dir4/b
+	[f] (c) [c] ./dir4/c
+	[f] (d) [d] ./dir4/d
+	[f] (e) [e] ./dir4/e
+	EOF
+'
+test_expect_success 'iteration of dir w/ five files' '
+	test-tool dir-iterator ./dir4 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+
+test_expect_success 'setup -- dir w/ dir w/ a file' '
+	mkdir -p dir5/a &&
+	>dir5/a/b &&
+
+
+	cat >expected-out <<-EOF
+	[d] (a) [a] ./dir5/a
+	[f] (a/b) [b] ./dir5/a/b
+	EOF
+'
+test_expect_success 'iteration of dir w/ dir w/ a file' '
+	test-tool dir-iterator ./dir5 >actual-out &&
+	test_cmp expected-out actual-out
+'
+
 test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
 	mkdir -p dir6/a/b/c &&
 	>dir6/a/b/c/d &&
@@ -22,6 +110,149 @@ test_expect_success 'iteration of dir w/ three nested dirs w/ file' '
 	test_cmp expected-out actual-out
 '
 
+test_expect_success POSIXPERM,SANITY \
+'setup -- dir w/ three nested dirs w/ file, second nested dir w/o perms' '
+
+	mkdir -p dir7/a/b/c &&
+	>dir7/a/b/c/d &&
+
+	cat >expected-out <<-EOF &&
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	EOF
+	cat >expected-pedantic-out <<-EOF
+	[d] (a) [a] ./dir7/a
+	[d] (a/b) [b] ./dir7/a/b
+	dir_iterator_advance failure
+	EOF
+'
+test_expect_success POSIXPERM,SANITY \
+'iteration of dir w/ three nested dirs w/ file, second w/o perms' '
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
+	chmod 0 dir7/a/b &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir7 >actual-out &&
+	test_cmp expected-pedantic-out actual-out &&
+
+	chmod 755 dir7/a/b
+'
+
+test_expect_success 'setup -- dir w/ two dirs each w/ file' '
+	mkdir -p dir8/a &&
+	>dir8/a/b &&
+	mkdir dir8/c &&
+	>dir8/c/d &&
+
+
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	EOF
+	cat >expected-out2 <<-EOF
+	[d] (c) [c] ./dir8/c
+	[f] (c/d) [d] ./dir8/c/d
+	[d] (a) [a] ./dir8/a
+	[f] (a/b) [b] ./dir8/a/b
+	EOF
+'
+test_expect_success 'iteration of dir w/ two dirs each w/ file' '
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
+	>dir9/d/e &&
+
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
+	cat >expected-out4 <<-EOF
+	[d] (d) [d] ./dir9/d
+	[f] (d/e) [e] ./dir9/d/e
+	[d] (a) [a] ./dir9/a
+	[f] (a/c) [c] ./dir9/a/c
+	[f] (a/b) [b] ./dir9/a/b
+	EOF
+'
+test_expect_success \
+'iteration of dir w/ three dirs, one w/ two, one w/ one and one w/ none files' '
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
+	>dir10/a/c/d &&
+
+
+	cat >expected-out1 <<-EOF &&
+	[d] (a) [a] ./dir10/a
+	[f] (a/b) [b] ./dir10/a/b
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	EOF
+	cat >expected-out2 <<-EOF
+	[d] (a) [a] ./dir10/a
+	[d] (a/c) [c] ./dir10/a/c
+	[f] (a/c/d) [d] ./dir10/a/c/d
+	[f] (a/b) [b] ./dir10/a/b
+	EOF
+
+'
+test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
+	test-tool dir-iterator ./dir10/ >actual-out &&
+	(
+		test_cmp expected-out1 actual-out ||
+		test_cmp expected-out2 actual-out
+	)
+'
+
 test_expect_success 'setup -- dir w/ complex structure w/o symlinks' '
 	mkdir -p dir11/a/b/c/ &&
 	>dir11/b &&
@@ -53,6 +284,28 @@ test_expect_success 'iteration of dir w/ complex structure w/o symlinks' '
 	test_cmp expected-sorted-out actual-sorted-out
 '
 
+test_expect_success POSIXPERM,SANITY \
+'dir_iterator_advance() should fail on root dir w/o perms' '
+
+	mkdir -p dir12/a &&
+	>dir12/a/b &&
+	chmod 0 dir12 &&
+
+
+	cat >expected-no-permissions-out <<-EOF &&
+	dir_iterator_advance failure
+	EOF
+
+	test_must_fail test-tool dir-iterator ./dir12 >actual-out &&
+	test_cmp expected-no-permissions-out actual-out &&
+
+	test_must_fail test-tool dir-iterator --pedantic ./dir12 >actual-out &&
+	test_cmp expected-no-permissions-out actual-out &&
+
+	chmod 755 dir12 &&
+	rm -rf dir12
+'
+
 test_expect_success 'dir_iterator_begin() should fail upon inexistent paths' '
 	echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-out &&
 
@@ -155,4 +408,42 @@ test_expect_success SYMLINKS \
 	test_cmp expected-follow-sorted-out actual-sorted-out
 '
 
+test_expect_success SYMLINKS 'setup -- dir w/ symlinks w/ cycle' '
+	mkdir -p dir15/a/b &&
+	mkdir -p dir15/a/c &&
+	ln -s ../c dir15/a/b/d &&
+	ln -s ../ dir15/a/b/e &&
+	ln -s ../../ dir15/a/b/f &&
+
+	cat >expected-dont-follow-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir15/a
+	[d] (a/b) [b] ./dir15/a/b
+	[d] (a/c) [c] ./dir15/a/c
+	[s] (a/b/d) [d] ./dir15/a/b/d
+	[s] (a/b/e) [e] ./dir15/a/b/e
+	[s] (a/b/f) [f] ./dir15/a/b/f
+	EOF
+
+	cat >expected-pedantic-follow-tailed-out <<-EOF
+	dir_iterator_advance failure
+	EOF
+'
+test_expect_success SYMLINKS \
+'dont-follow-symlinks of dir w/ symlinks w/ cycle' '
+
+	test-tool dir-iterator ./dir15 >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-dont-follow-sorted-out actual-sorted-out
+'
+test_expect_success SYMLINKS \
+'pedantic follow-symlinks of dir w/ symlinks w/ cycle' '
+
+	test_must_fail test-tool dir-iterator \
+		--pedantic --follow-symlinks ./dir15 >actual-out &&
+	tail -n 1 actual-out >actual-tailed-out &&
+
+	test_cmp expected-pedantic-follow-tailed-out actual-tailed-out
+'
+
 test_done
-- 
2.35.1

