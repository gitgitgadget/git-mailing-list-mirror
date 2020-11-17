Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0679C8300C
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AE8221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILOVoZer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKQQNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKQQM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B05C0617A6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j7so23733374wrp.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6RYiEmBGMoUAxyfenZ0AhsgiQL7g5whSCNpq/1j2T40=;
        b=ILOVoZerIgC9HhR84jpkcaKTE1zI4P57khuTMGuKwSu0pmN+NZDOntvQDSQzy5l6vu
         Oddke3cIo69lxnEA6AoRA5flG73vEdFaCzjC3SvAbHGidCaII6foK+nHt5a4FpdVHdcI
         pU9y4gnvhHV1JAPFOvE6nS3l2VMR10d6oIp4E0hkYdw0LqqvICwszw8x3Wk3YiLy2e84
         2XyYiWfzG+VQNDAah0Q2C9qw5pi4jyZGhUx99wXproIBCqet4uJrweKZvx/QdIOk7cJS
         TUy2GeSmowrweivEA1WvLT7sGIrToqWhT+TTH+Seeo2UTmmqLAIEYh/rf/BS436CXjwy
         KQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6RYiEmBGMoUAxyfenZ0AhsgiQL7g5whSCNpq/1j2T40=;
        b=iNG7X1ZXibUQF26TewzjYqJaK2TbHtivKrL1IwBysQj2uYE3+JnxmUDZjLbcc2G3WZ
         lmVSpxg129die+EjSle912g7sSqmL71Ft4/NV8ENmkydK+jk30ta9+OYR+lvi//4iXJi
         0TDovpXXKXXDvbPKYoC7dzbETk7AaPUsCM8K1+XIQB1wr3jkOjao7aiEqSAOG/VD/GO4
         uCIeIj4LOgz0f+yAt+VTOLVWzDq9kLC+0KLuSqBN0cRl/aakDFo0Q0wr1MwJ9inVktRK
         OW/H920OqbeGdCAFqNKEylPuGWsU+Hhtwd9c+CPBZSTu7lEWqWXOso4/W/T/Zg9C8JYy
         hJzw==
X-Gm-Message-State: AOAM530bYWQDHCfzY99/+B8cpEZU8zBd0zUwqCKgednWGDw0sAaBb7cZ
        +4hzgjwOzBK6qwJ81VHgU9f6oZhWnSE=
X-Google-Smtp-Source: ABdhPJwGuu4GKcZhsY0ckEXJ3PKmjKRt91GM6ku1rxw+2DNKx4USZFwXMUPojTJa2FaQgVD/EJWQKQ==
X-Received: by 2002:adf:f304:: with SMTP id i4mr271143wro.268.1605629574560;
        Tue, 17 Nov 2020 08:12:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm27716256wrs.46.2020.11.17.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:54 -0800 (PST)
Message-Id: <fc0c1f64631d961a9772600f2accba94b28217fb.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:27 +0000
Subject: [PATCH v2 27/27] tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where
 no longer needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We introduced the `PREPARE_FOR_MAIN_BRANCH` prereq for the sole purpose
of allowing us to perform the non-trivial adjustments regarding the
`master` -> `main` rename before the automatable ones.

Now that the transition is almost complete, we can stop using it in most
instances. The only two exceptions are t5526 and t9902: at the time of
writing, there are other patches in flight that touch these test
scripts, therefore their transition to `main` is postponed to a later
date.

This patch is the result of this command:

	sed -i 's/PREPARE_FOR_MAIN_BRANCH[ ,]//' t/t[0-9]*.sh &&
	git checkout HEAD -- t/t5526\* t/t9902\*

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh              |  4 ++--
 t/t3200-branch.sh                  |  6 +++---
 t/t3201-branch-contains.sh         |  2 +-
 t/t3203-branch-output.sh           |  2 +-
 t/t3205-branch-color.sh            |  2 +-
 t/t5505-remote.sh                  |  8 ++++----
 t/t5510-fetch.sh                   |  4 ++--
 t/t5703-upload-pack-ref-in-want.sh |  2 +-
 t/t6302-for-each-ref-filter.sh     | 12 ++++++------
 9 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3265a8c58e..127efff136 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -585,7 +585,7 @@ test_expect_success 'stdin fails on unbalanced quotes' '
 	grep "fatal: badly quoted argument: \\\"main" err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+test_expect_success 'stdin fails on invalid escape' '
 	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
@@ -704,7 +704,7 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
+test_expect_success 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
 	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 63036e0369..430f5af21b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -321,7 +321,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch --column' '
+test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
@@ -358,7 +358,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch with column.*' '
+test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
@@ -375,7 +375,7 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
+test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 110cfef820..f39ae97264 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -242,7 +242,7 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # Here "topic" tracks "main" with one extra commit, and "zzz" points to the
 # same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
+test_expect_success 'branch --merged with --verbose' '
 	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 727c9d9caa..211eb8357f 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -329,7 +329,7 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
+test_expect_success 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
 	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 9f2fb785d2..2eb619231d 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -28,7 +28,7 @@ test_expect_success 'regular output shows colors' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output shows colors' '
+test_expect_success 'verbose output shows colors' '
 	oid=$(git rev-parse --short HEAD) &&
 	cat >expect <<-EOF &&
 	* <CYAN>main               <RESET> $oid foo
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 540d65aa22..869109a2c6 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -234,7 +234,7 @@ cat >test/expect <<EOF
     main  pushes to another (up to date)
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
+test_expect_success 'show' '
 	(
 		cd test &&
 		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
@@ -285,7 +285,7 @@ cat >test/expect <<EOF
     refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show -n' '
+test_expect_success 'show -n' '
 	mv one one.unreachable &&
 	(
 		cd test &&
@@ -328,7 +328,7 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/multiple HEADs' '
+test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
@@ -1348,7 +1348,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
 		git tag -a -m "Some tag" my-tag main &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 206e3be695..f8bcaeca08 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -942,7 +942,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -957,7 +957,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned outpu
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index bbf03a8f66..fe89ea55b1 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -383,7 +383,7 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
+test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index f5a55c1991..7a45bbf048 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -113,7 +113,7 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
+test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main
 	refname is refs/heads/side    |refs/heads/side
@@ -131,7 +131,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
+test_expect_success 'middle alignment' '
 	cat >expect <<-\EOF &&
 	|  refname is refs/heads/main  |refs/heads/main
 	|  refname is refs/heads/side  |refs/heads/side
@@ -149,7 +149,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'right alignment' '
+test_expect_success 'right alignment' '
 	cat >expect <<-\EOF &&
 	|    refname is refs/heads/main|refs/heads/main
 	|    refname is refs/heads/side|refs/heads/side
@@ -184,7 +184,7 @@ EOF
 test_align_permutations() {
 	while read -r option
 	do
-		test_expect_success PREPARE_FOR_MAIN_BRANCH "align:$option" '
+		test_expect_success "align:$option" '
 			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
 			test_cmp expect actual
 		'
@@ -213,7 +213,7 @@ EOF
 
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
+test_expect_success 'alignment with format quote' "
 	cat >expect <<-\EOF &&
 	|'       '\''main| A U Thor'\''       '|
 	|'       '\''side| A U Thor'\''       '|
@@ -231,7 +231,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
 	test_cmp expect actual
 "
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatting' "
+test_expect_success 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
 	|'           main               '|
 	|'           side               '|
-- 
gitgitgadget
