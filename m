Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DEC6379F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DCF246E0
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsv6LQyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKRXp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgKRXpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D88C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 1so4758690wme.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QeV62zn+gngDrGF93bMsKoGZhzXpefQhYH+p7gvpzE8=;
        b=bsv6LQyko6iu1dZR+Zcm4rZ+NFQdMojUGmdv5Zl1pAcWHjioa1gjNimAEQoa6kHyWb
         cDdldye5QDA+CY3o6kZB2KXYARnSUh5ZmBWC6lVdPOnL3iizHsqBl0uiuAok8XAqe5eM
         NY7qwFgIc9BZSiLBF/vGrR20+FuFFAdiD2GVU76SnLRvT8l2cqJZwpbBGmLBqNGm2P7T
         lkN0eeSZ4RHiGspJbVpoIU31QrquKHa5yxeJe49WnOZCTMNFpQfGibnUSDk4+XJEZFuX
         NC6O3T5Uu0OywyCToTUSt/bsuwyXZyHuaaEw9LfKNuKUrncwsZS5rSw1WixuVJROyyKD
         w5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QeV62zn+gngDrGF93bMsKoGZhzXpefQhYH+p7gvpzE8=;
        b=tCVQAIYpcqxqDMuxBMgMdUvZRqHFqksg6z7/w5MEPLhpLs2wi1wrVmLpz+mSWsBmV/
         bi1I7We33KE2/tUqbsFCYnlPDMFZUVZJsQi9SklHWQaCSMoHr4jNNTpEjjXnNaC8y2nm
         1/5Avz8DXb7O7HKmj7ANPtyw7aGgdTt3Cu9COsVcLsprkowlu/8OTSinEyH5ptZ/d/hH
         9NwrwJw9S/g0KyAxNiW7qiJgcKDfcGIE9sL1cXB+ZVwU1GNfZNYo6aLXnR+dSoACyl7X
         xEWcKaaaGdCqCGk9JwS004qjAvtbTt7r3BhnAx+Dwf7taEfw1FgoXleWBNJEGbV27XW1
         zt9w==
X-Gm-Message-State: AOAM531SIQD/FAvH6jC8sy/0NGmNUl68Erq53pvTurYkLl+W1OPAQj8q
        n/i0f1JxmizfAQtPJpDeZmdoLQ7kgD0=
X-Google-Smtp-Source: ABdhPJyLvoTNsPiN5IjGNEvVCRHB+CYxVZLDbb4dYSi3KYtX3rn9ZhxYXmU3iK3ovAdJpqN6f5xIqw==
X-Received: by 2002:a1c:e4d4:: with SMTP id b203mr1436123wmh.141.1605743116763;
        Wed, 18 Nov 2020 15:45:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k22sm6344042wmi.34.2020.11.18.15.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:16 -0800 (PST)
Message-Id: <ec9b9cab889e51f367a33edf1870c3a92ff4eba4.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:46 +0000
Subject: [PATCH v3 28/28] tests: drop prereq `PREPARE_FOR_MAIN_BRANCH` where
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
        Jonathan Nieder <jrnieder@gmail.com>,
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
index 1ad0bbbc53..e7cd4917d1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -588,7 +588,7 @@ test_expect_success 'stdin fails on unbalanced quotes' '
 	grep "fatal: badly quoted argument: \\\"main" err
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin fails on invalid escape' '
+test_expect_success 'stdin fails on invalid escape' '
 	echo "create $a \"ma\zn\"" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"ma\\\\zn\\\"" err
@@ -707,7 +707,7 @@ test_expect_success 'stdin succeeds with quoted argument' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'stdin succeeds with escaped character' '
+test_expect_success 'stdin succeeds with escaped character' '
 	git update-ref -d $a &&
 	echo "create $a \"ma\\151n\"" >stdin &&
 	git update-ref --stdin <stdin &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 56517dd9c3..66eed73f83 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -324,7 +324,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch --column' '
+test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
@@ -361,7 +361,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch with column.*' '
+test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
@@ -378,7 +378,7 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
+test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 8e626afbb9..f9f4d20e93 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -245,7 +245,7 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # Here "topic" tracks "main" with one extra commit, and "zzz" points to the
 # same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
+test_expect_success 'branch --merged with --verbose' '
 	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a7d2edd988..eaa37534aa 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -332,7 +332,7 @@ test_expect_success '--color overrides auto-color' '
 	test_cmp expect.color actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
+test_expect_success 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
 	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index b905dc4867..2a09442c2b 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -31,7 +31,7 @@ test_expect_success 'regular output shows colors' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output shows colors' '
+test_expect_success 'verbose output shows colors' '
 	oid=$(git rev-parse --short HEAD) &&
 	cat >expect <<-EOF &&
 	* <CYAN>main               <RESET> $oid foo
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f7e3c9b1e7..59fbb1fa7f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -237,7 +237,7 @@ cat >test/expect <<EOF
     main  pushes to another (up to date)
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show' '
+test_expect_success 'show' '
 	(
 		cd test &&
 		git config --add remote.origin.fetch refs/heads/main:refs/heads/upstream &&
@@ -288,7 +288,7 @@ cat >test/expect <<EOF
     refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'show -n' '
+test_expect_success 'show -n' '
 	mv one one.unreachable &&
 	(
 		cd test &&
@@ -331,7 +331,7 @@ test_expect_success 'set-head --auto' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'set-head --auto has no problem w/multiple HEADs' '
+test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 	(
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
@@ -1351,7 +1351,7 @@ test_expect_success 'unqualified <dst> refspec DWIM and advice' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
+test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
 	(
 		cd two &&
 		git tag -a -m "Some tag" my-tag main &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 35d9a8c279..d9ae7c20ce 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -945,7 +945,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 	)
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	git clone . full-output &&
 	test_commit looooooooooooong-tag &&
 	(
@@ -960,7 +960,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch aligned outpu
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH,C_LOCALE_OUTPUT 'fetch compact output' '
+test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	git clone . compact &&
 	test_commit extraaa &&
 	(
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 0f3e0bf15c..2f4ce6b0fa 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -386,7 +386,7 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'server loses a ref - ref in want' '
+test_expect_success 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index e5833af528..5d682cb31f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -116,7 +116,7 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
+test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main
 	refname is refs/heads/side    |refs/heads/side
@@ -134,7 +134,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
+test_expect_success 'middle alignment' '
 	cat >expect <<-\EOF &&
 	|  refname is refs/heads/main  |refs/heads/main
 	|  refname is refs/heads/side  |refs/heads/side
@@ -152,7 +152,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'right alignment' '
+test_expect_success 'right alignment' '
 	cat >expect <<-\EOF &&
 	|    refname is refs/heads/main|refs/heads/main
 	|    refname is refs/heads/side|refs/heads/side
@@ -187,7 +187,7 @@ EOF
 test_align_permutations() {
 	while read -r option
 	do
-		test_expect_success PREPARE_FOR_MAIN_BRANCH "align:$option" '
+		test_expect_success "align:$option" '
 			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
 			test_cmp expect actual
 		'
@@ -216,7 +216,7 @@ EOF
 
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
+test_expect_success 'alignment with format quote' "
 	cat >expect <<-\EOF &&
 	|'       '\''main| A U Thor'\''       '|
 	|'       '\''side| A U Thor'\''       '|
@@ -234,7 +234,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
 	test_cmp expect actual
 "
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatting' "
+test_expect_success 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
 	|'           main               '|
 	|'           side               '|
-- 
gitgitgadget
