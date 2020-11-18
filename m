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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57000C64E7A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEDDE246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUdo9j2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKRXpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgKRXo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AC2C061A04
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 10so5176145wml.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=srepqrMzHgCKl5pLxTZobMSRrCuNdJsMV1unBJXAd+I=;
        b=AUdo9j2lNUzurGEgkS5uAcQ3V9HJXLuJsBLtikKzbsC34wm591plzgyvFnfAoXds/o
         IZAR20br4kz8j2Gbb1c7RPLVsLW8j6oAI18BcUZnGTTvlw/vXhAUr1r8IHnUdyfzgINA
         d5t5mtb6xvcp/05sy/zmUcHYk/hMG9JPO4xWOCqd5fqp133z+4m5b8p2I21wSM8wHxj9
         oDjQTBoe5foG+7gbZddvAwqH+OQ2fsQQBur4mITEqZOzicnsyFYx/ZBBYuJuiB60v5ZR
         bXjOHFa0xf7u31exZhGzikhf8ca6tPwFoYG0VgD9FVKrspa1jx0AI+imWOgitEPrpqtE
         Tm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=srepqrMzHgCKl5pLxTZobMSRrCuNdJsMV1unBJXAd+I=;
        b=mCYMsPA/g1ItfaZ/llfgxKNI4AiuIwA7lI28c4sWn2K15hs8q/wLibgMhI+gySGlj+
         O84I3e9pKlxt+2DatHcS7vlImPbtTlVwLsYBW9DqToGHYlEjLuiumg9d87YDuDAQrFfa
         M2iBIlpKjrUtOLdXBJYFK2oO4+5Ahw2R1fOavLggUSiQZM+roU7seYgRUy7E/x1Q+fkB
         Dho0s80OKBxiu0r1cDa1WbXGnLtDXjlAKJ2+FgTELs2LIQIbp1ljZd/J2+Lg+vtPS2Zc
         YiwGVVpKe8BwDrA2nWzOi7YpDq1nz8XveodzMofdwIIsnxHvL4Ia533O4VnqjfpZ0SA6
         mDBw==
X-Gm-Message-State: AOAM533Dc+qbO8vKg+75f5dAqRRb9DmmMb+mZ40+MDmovZVd7jcz6Jix
        4iMK1234zeX/Z9M2T8vom+bFMhQ+axo=
X-Google-Smtp-Source: ABdhPJzTt6sSlaFRKschETpj5PJUEoMRifFpIGtWn12fkhiQjargzviTdsMR+3vzvpjaxwZtG4ChgQ==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr1554842wmj.126.1605743095382;
        Wed, 18 Nov 2020 15:44:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm37063849wrb.97.2020.11.18.15.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:54 -0800 (PST)
Message-Id: <090ac6e9a15afa5d76c37e7b9c93a01e6933146c.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:23 +0000
Subject: [PATCH v3 05/28] t3[0-3]*: adjust the references to the default
 branch name "main"
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

Carefully excluding t3040, which sees independent development elsewhere
at the time of writing, we transition above-mentioned tests to the
default branch name `main`. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t3[0-3]*.sh t3206/* &&
	   git checkout HEAD -- t3040\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh                     | 244 +++++++++++++-------------
 t/t3201-branch-contains.sh            |  82 ++++-----
 t/t3202-show-branch-octopus.sh        |   4 +-
 t/t3203-branch-output.sh              |  40 ++---
 t/t3204-branch-name-interpretation.sh |   8 +-
 t/t3205-branch-color.sh               |   8 +-
 t/t3206-range-diff.sh                 |  42 ++---
 t/t3206/history.export                |   2 +-
 t/t3210-pack-refs.sh                  |   6 +-
 t/t3211-peel-ref.sh                   |   6 +-
 t/t3301-notes.sh                      |   6 +-
 t/t3302-notes-index-expensive.sh      |   4 +-
 t/t3303-notes-subtrees.sh             |  10 +-
 t/t3304-notes-mixed.sh                |  10 +-
 t/t3308-notes-merge.sh                |   2 +-
 t/t3320-notes-merge-worktrees.sh      |   6 +-
 16 files changed, 240 insertions(+), 240 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 04b568cf21..56517dd9c3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -5,7 +5,7 @@
 
 test_description='git branch assorted tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -31,7 +31,7 @@ test_expect_success 'branch -h in broken repository' '
 	(
 		cd broken &&
 		git init &&
-		>.git/refs/heads/master &&
+		>.git/refs/heads/main &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
 	test_i18ngrep "[Uu]sage" broken/usage
@@ -45,8 +45,8 @@ test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
 
-test_expect_success 'git branch mb master... should create a branch' '
-	git branch mb master... && test_path_is_file .git/refs/heads/mb
+test_expect_success 'git branch mb main... should create a branch' '
+	git branch mb main... && test_path_is_file .git/refs/heads/mb
 '
 
 test_expect_success 'git branch HEAD should fail' '
@@ -54,7 +54,7 @@ test_expect_success 'git branch HEAD should fail' '
 '
 
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from main
 EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -113,7 +113,7 @@ test_expect_success 'git branch -m n/n n should work' '
 
 test_expect_success 'git branch -m bbb should rename checked out branch' '
 	test_when_finished git branch -D bbb &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b aaa &&
 	git commit --allow-empty -m "a new commit" &&
 	git rev-parse aaa@{0} >expect &&
@@ -127,7 +127,7 @@ test_expect_success 'git branch -m bbb should rename checked out branch' '
 
 test_expect_success 'renaming checked out branch works with d/f conflict' '
 	test_when_finished "git branch -D foo/bar || git branch -D foo" &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b foo &&
 	git branch -m foo/bar &&
 	git symbolic-ref HEAD >actual &&
@@ -188,7 +188,7 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
 		git checkout --orphan lonely &&
 		grep lonely .git/HEAD &&
 		test_path_is_missing .git/refs/head/lonely &&
-		git branch -M master mistress &&
+		git branch -M main mistress &&
 		grep lonely .git/HEAD
 	)
 '
@@ -204,7 +204,7 @@ test_expect_success 'resulting reflog can be shown by log -g' '
 '
 
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
-	git checkout master &&
+	git checkout main &&
 	git worktree add -b baz bazdir &&
 	git worktree add -f bazdir2 baz &&
 	git branch -M baz bam &&
@@ -227,18 +227,18 @@ test_expect_success 'git branch -M baz bam should succeed within a worktree in w
 	git worktree prune
 '
 
-test_expect_success 'git branch -M master should work when master is checked out' '
-	git checkout master &&
-	git branch -M master
+test_expect_success 'git branch -M main should work when main is checked out' '
+	git checkout main &&
+	git branch -M main
 '
 
-test_expect_success 'git branch -M master master should work when master is checked out' '
-	git checkout master &&
-	git branch -M master master
+test_expect_success 'git branch -M main main should work when main is checked out' '
+	git checkout main &&
+	git branch -M main main
 '
 
-test_expect_success 'git branch -M topic topic should work when master is checked out' '
-	git checkout master &&
+test_expect_success 'git branch -M topic topic should work when main is checked out' '
+	git checkout main &&
 	git branch topic &&
 	git branch -M topic topic
 '
@@ -295,8 +295,8 @@ test_expect_success 'bare main worktree has HEAD at branch deleted by secondary
 	git init nonbare &&
 	test_commit -C nonbare x &&
 	git clone --bare nonbare bare &&
-	git -C bare worktree add --detach ../secondary master &&
-	git -C secondary branch -D master
+	git -C bare worktree add --detach ../secondary main &&
+	git -C secondary branch -D main
 '
 
 test_expect_success 'git branch --list -v with --abbrev' '
@@ -348,7 +348,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -391,7 +391,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignore
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -430,8 +430,8 @@ test_expect_success 'config information was renamed, too' '
 '
 
 test_expect_success 'git branch -m correctly renames multiple config sections' '
-	test_when_finished "git checkout master" &&
-	git checkout -b source master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -590,18 +590,18 @@ test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	! grep "$msg$" .git/logs/HEAD
 '
 
-test_expect_success 'git branch -C master should work when master is checked out' '
-	git checkout master &&
-	git branch -C master
+test_expect_success 'git branch -C main should work when main is checked out' '
+	git checkout main &&
+	git branch -C main
 '
 
-test_expect_success 'git branch -C master master should work when master is checked out' '
-	git checkout master &&
-	git branch -C master master
+test_expect_success 'git branch -C main main should work when main is checked out' '
+	git checkout main &&
+	git branch -C main main
 '
 
-test_expect_success 'git branch -C main5 main5 should work when master is checked out' '
-	git checkout master &&
+test_expect_success 'git branch -C main5 main5 should work when main is checked out' '
+	git checkout main &&
 	git branch main5 &&
 	git branch -C main5 main5
 '
@@ -623,8 +623,8 @@ test_expect_success 'git branch -C ab cd should overwrite existing config for cd
 test_expect_success 'git branch -c correctly copies multiple config sections' '
 	FOO=1 &&
 	export FOO &&
-	test_when_finished "git checkout master" &&
-	git checkout -b source2 master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source2 main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -714,10 +714,10 @@ test_expect_success 'deleting a self-referential symref' '
 '
 
 test_expect_success 'renaming a symref is not allowed' '
-	git symbolic-ref refs/heads/topic refs/heads/master &&
+	git symbolic-ref refs/heads/topic refs/heads/main &&
 	test_must_fail git branch -m topic new-topic &&
 	git symbolic-ref refs/heads/topic &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_file .git/refs/heads/main &&
 	test_path_is_missing .git/refs/heads/new-topic
 '
 
@@ -731,27 +731,27 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track my1 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track my1 local/main &&
 	test $(git config branch.my1.remote) = local &&
-	test $(git config branch.my1.merge) = refs/heads/master
+	test $(git config branch.my1.merge) = refs/heads/main
 '
 
 test_expect_success 'test tracking setup (non-wildcard, matching)' '
 	git config remote.local.url . &&
-	git config remote.local.fetch refs/heads/master:refs/remotes/local/master &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track my4 local/master &&
+	git config remote.local.fetch refs/heads/main:refs/remotes/local/main &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track my4 local/main &&
 	test $(git config branch.my4.remote) = local &&
-	test $(git config branch.my4.merge) = refs/heads/master
+	test $(git config branch.my4.merge) = refs/heads/main
 '
 
 test_expect_success 'tracking setup fails on non-matching refspec' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git config remote.local.fetch refs/heads/s:refs/remotes/local/s &&
-	test_must_fail git branch --track my5 local/master &&
+	test_must_fail git branch --track my5 local/main &&
 	test_must_fail git config branch.my5.remote &&
 	test_must_fail git config branch.my5.merge
 '
@@ -760,21 +760,21 @@ test_expect_success 'test tracking setup via config' '
 	git config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch my3 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch my3 local/main &&
 	test $(git config branch.my3.remote) = local &&
-	test $(git config branch.my3.merge) = refs/heads/master
+	test $(git config branch.my3.merge) = refs/heads/main
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' '
 	git config branch.autosetupmerge true &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track my2 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track my2 local/main &&
 	git config branch.autosetupmerge false &&
 	! test "$(git config branch.my2.remote)" = local &&
-	! test "$(git config branch.my2.merge)" = refs/heads/master
+	! test "$(git config branch.my2.merge)" = refs/heads/main
 '
 
 test_expect_success 'no tracking without .fetch entries' '
@@ -839,26 +839,26 @@ test_expect_success 'branch from tag w/--track causes failure' '
 
 test_expect_success '--set-upstream-to fails on multiple branches' '
 	echo "fatal: too many arguments to set new upstream" >expect &&
-	test_must_fail git branch --set-upstream-to master a b c 2>err &&
+	test_must_fail git branch --set-upstream-to main a b c 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout HEAD^{} &&
 	test_when_finished git checkout - &&
-	echo "fatal: could not set upstream of HEAD to master when it does not point to any branch." >expect &&
-	test_must_fail git branch --set-upstream-to master 2>err &&
+	echo "fatal: could not set upstream of HEAD to main when it does not point to any branch." >expect &&
+	test_must_fail git branch --set-upstream-to main 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	echo "fatal: branch '"'"'does-not-exist'"'"' does not exist" >expect &&
-	test_must_fail git branch --set-upstream-to master does-not-exist 2>err &&
+	test_must_fail git branch --set-upstream-to main does-not-exist 2>err &&
 	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing src branch' '
-	test_must_fail git branch --set-upstream-to does-not-exist master 2>err &&
+	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &&
 	test_i18ngrep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
 '
 
@@ -877,20 +877,20 @@ test_expect_success '--set-upstream-to fails on locked config' '
 '
 
 test_expect_success 'use --set-upstream-to modify HEAD' '
-	test_config branch.master.remote foo &&
-	test_config branch.master.merge foo &&
+	test_config branch.main.remote foo &&
+	test_config branch.main.merge foo &&
 	git branch my12 &&
 	git branch --set-upstream-to my12 &&
-	test "$(git config branch.master.remote)" = "." &&
-	test "$(git config branch.master.merge)" = "refs/heads/my12"
+	test "$(git config branch.main.remote)" = "." &&
+	test "$(git config branch.main.merge)" = "refs/heads/my12"
 '
 
 test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
-	git branch --set-upstream-to master my13 &&
+	git branch --set-upstream-to main my13 &&
 	test_when_finished "git branch --unset-upstream my13" &&
 	test "$(git config branch.my13.remote)" = "." &&
-	test "$(git config branch.my13.merge)" = "refs/heads/master"
+	test "$(git config branch.my13.merge)" = "refs/heads/main"
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
@@ -909,14 +909,14 @@ test_expect_success '--unset-upstream should fail if config is locked' '
 
 test_expect_success 'test --unset-upstream on HEAD' '
 	git branch my14 &&
-	test_config branch.master.remote foo &&
-	test_config branch.master.merge foo &&
+	test_config branch.main.remote foo &&
+	test_config branch.main.merge foo &&
 	git branch --set-upstream-to my14 &&
 	git branch --unset-upstream &&
-	test_must_fail git config branch.master.remote &&
-	test_must_fail git config branch.master.merge &&
+	test_must_fail git config branch.main.remote &&
+	test_must_fail git config branch.main.merge &&
 	# fail for a branch without upstream set
-	echo "fatal: Branch '"'"'master'"'"' has no upstream information" >expect &&
+	echo "fatal: Branch '"'"'main'"'"' has no upstream information" >expect &&
 	test_must_fail git branch --unset-upstream 2>err &&
 	test_i18ncmp expect err
 '
@@ -937,14 +937,14 @@ test_expect_success '--unset-upstream should fail on detached HEAD' '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
 	git branch my15 &&
-	git branch --set-upstream-to master my14 &&
+	git branch --set-upstream-to main my14 &&
 	git branch --unset-upstream my14 &&
 	test_must_fail git config branch.my14.remote &&
 	test_must_fail git config branch.my14.merge
 '
 
 test_expect_success 'disabled option --set-upstream fails' '
-	test_must_fail git branch --set-upstream origin/master
+	test_must_fail git branch --set-upstream origin/main
 '
 
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
@@ -959,32 +959,32 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from main
 EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	git checkout -b g/h/i -l master &&
+	git checkout -b g/h/i -l main &&
 	test_path_is_file .git/refs/heads/g/h/i &&
 	test_path_is_file .git/logs/refs/heads/g/h/i &&
 	test_cmp expect .git/logs/refs/heads/g/h/i
 '
 
 test_expect_success 'checkout -b makes reflog by default' '
-	git checkout master &&
+	git checkout main &&
 	git config --unset core.logAllRefUpdates &&
 	git checkout -b alpha &&
 	git rev-parse --verify alpha@{0}
 '
 
 test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout -b beta &&
 	test_must_fail git rev-parse --verify beta@{0}
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
-	git checkout master &&
+	git checkout main &&
 	git checkout -lb gamma &&
 	git config --unset core.logAllRefUpdates &&
 	git rev-parse --verify gamma@{0}
@@ -993,10 +993,10 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
 test_expect_success 'avoid ambiguous track' '
 	git config branch.autosetupmerge true &&
 	git config remote.ambi1.url lalala &&
-	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
+	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/main &&
 	git config remote.ambi2.url lilili &&
-	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
-	test_must_fail git branch all1 master &&
+	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/main &&
+	test_must_fail git branch all1 main &&
 	test -z "$(git config branch.all1.merge)"
 '
 
@@ -1052,10 +1052,10 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase local &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr5 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr5 local/main &&
 	test "$(git config branch.myr5.remote)" = local &&
-	test "$(git config branch.myr5.merge)" = refs/heads/master &&
+	test "$(git config branch.myr5.merge)" = refs/heads/main &&
 	! test "$(git config branch.myr5.rebase)" = true
 '
 
@@ -1063,10 +1063,10 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase never &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr6 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr6 local/main &&
 	test "$(git config branch.myr6.remote)" = local &&
-	test "$(git config branch.myr6.merge)" = refs/heads/master &&
+	test "$(git config branch.myr6.merge)" = refs/heads/main &&
 	! test "$(git config branch.myr6.rebase)" = true
 '
 
@@ -1074,10 +1074,10 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr7 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr7 local/main &&
 	test "$(git config branch.myr7.remote)" = local &&
-	test "$(git config branch.myr7.merge)" = refs/heads/master &&
+	test "$(git config branch.myr7.merge)" = refs/heads/main &&
 	test "$(git config branch.myr7.rebase)" = true
 '
 
@@ -1085,10 +1085,10 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
 	git config branch.autosetuprebase remote &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr8 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr8 local/main &&
 	test "$(git config branch.myr8.remote)" = local &&
-	test "$(git config branch.myr8.merge)" = refs/heads/master &&
+	test "$(git config branch.myr8.merge)" = refs/heads/main &&
 	test "$(git config branch.myr8.rebase)" = true
 '
 
@@ -1096,10 +1096,10 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git config --unset branch.autosetuprebase &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --track myr9 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --track myr9 local/main &&
 	test "$(git config branch.myr9.remote)" = local &&
-	test "$(git config branch.myr9.merge)" = refs/heads/master &&
+	test "$(git config branch.myr9.merge)" = refs/heads/main &&
 	test "z$(git config branch.myr9.rebase)" = z
 '
 
@@ -1117,7 +1117,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
@@ -1127,8 +1127,8 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr12 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr12 local/main &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
 	test "z$(git config branch.myr12.rebase)" = z
@@ -1138,7 +1138,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
@@ -1149,7 +1149,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
@@ -1160,7 +1160,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
@@ -1171,7 +1171,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
@@ -1182,8 +1182,8 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr17 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr17 local/main &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
 	test "z$(git config branch.myr17.rebase)" = z
@@ -1193,8 +1193,8 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr18 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr18 local/main &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
 	test "z$(git config branch.myr18.rebase)" = z
@@ -1204,8 +1204,8 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr19 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr19 local/main &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
 	test "z$(git config branch.myr19.rebase)" = z
@@ -1215,8 +1215,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
-	git branch --no-track myr20 local/master &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
+	git branch --no-track myr20 local/main &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
 	test "z$(git config branch.myr20.rebase)" = z
@@ -1224,7 +1224,7 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
 	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
@@ -1252,18 +1252,18 @@ test_expect_success 'attempt to delete a branch without base and unmerged to HEA
 test_expect_success 'attempt to delete a branch merged to its base' '
 	# we are on my9 which is the initial commit; traditionally
 	# we would not have allowed deleting my8 that is not merged
-	# to my9, but it is set to track master that already has my8
-	git config branch.my8.merge refs/heads/master &&
+	# to my9, but it is set to track main that already has my8
+	git config branch.my8.merge refs/heads/main &&
 	git branch -d my8
 '
 
 test_expect_success 'attempt to delete a branch merged to its base' '
-	git checkout master &&
+	git checkout main &&
 	echo Third >>A &&
 	git commit -m "Third commit" A &&
 	git branch -t my10 my9 &&
 	git branch -f my10 HEAD^ &&
-	# we are on master which is at the third commit, and my10
+	# we are on main which is at the third commit, and my10
 	# is behind us, so traditionally we would have allowed deleting
 	# it; but my10 is set to track my9 that is further behind.
 	test_must_fail git branch -d my10
@@ -1290,7 +1290,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
@@ -1304,18 +1304,18 @@ test_expect_success '--merged catches invalid object names' '
 
 test_expect_success '--list during rebase' '
 	test_when_finished "reset_rebase" &&
-	git checkout master &&
+	git checkout main &&
 	FAKE_LINES="1 edit 2" &&
 	export FAKE_LINES &&
 	set_fake_editor &&
 	git rebase -i HEAD~2 &&
 	git branch --list >actual &&
-	test_i18ngrep "rebasing master" actual
+	test_i18ngrep "rebasing main" actual
 '
 
 test_expect_success '--list during rebase from detached HEAD' '
-	test_when_finished "reset_rebase && git checkout master" &&
-	git checkout master^0 &&
+	test_when_finished "reset_rebase && git checkout main" &&
+	git checkout main^0 &&
 	oid=$(git rev-parse --short HEAD) &&
 	FAKE_LINES="1 edit 2" &&
 	export FAKE_LINES &&
@@ -1351,11 +1351,11 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 		git remote add c ../c &&
 		git config remote.c.fetch "+refs/remotes/*:refs/remotes/*" &&
 		git fetch c &&
-		git branch --track local/a/master remotes/a/master &&
-		test "$(git config branch.local/a/master.remote)" = "c" &&
-		test "$(git config branch.local/a/master.merge)" = "refs/remotes/a/master" &&
+		git branch --track local/a/main remotes/a/main &&
+		test "$(git config branch.local/a/main.remote)" = "c" &&
+		test "$(git config branch.local/a/main.merge)" = "refs/remotes/a/main" &&
 		git rev-parse --verify a >expect &&
-		git rev-parse --verify local/a/master >actual &&
+		git rev-parse --verify local/a/main >actual &&
 		test_cmp expect actual
 	)
 '
@@ -1374,7 +1374,7 @@ test_expect_success 'configured committerdate sort' '
 		test_commit b &&
 		git branch >actual &&
 		cat >expect <<-\EOF &&
-		  master
+		  main
 		  a
 		  c
 		* b
@@ -1392,7 +1392,7 @@ test_expect_success 'option override configured sort' '
 		  a
 		* b
 		  c
-		  master
+		  main
 		EOF
 		test_cmp expect actual
 	)
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 532cdbe9ae..8e626afbb9 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -2,7 +2,7 @@
 
 test_description='branch --contains <commit>, --no-contains <commit> --merged, and --no-merged'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -17,47 +17,47 @@ test_expect_success setup '
 
 	echo 1 >file &&
 	test_tick &&
-	git commit -a -m "second on master" &&
+	git commit -a -m "second on main" &&
 
 	git checkout side &&
 	echo 1 >file &&
 	test_tick &&
 	git commit -a -m "second on side" &&
 
-	git merge master
+	git merge main
 
 '
 
-test_expect_success 'branch --contains=master' '
+test_expect_success 'branch --contains=main' '
 
-	git branch --contains=master >actual &&
+	git branch --contains=main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --contains master' '
+test_expect_success 'branch --contains main' '
 
-	git branch --contains master >actual &&
+	git branch --contains main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --no-contains=master' '
+test_expect_success 'branch --no-contains=main' '
 
-	git branch --no-contains=master >actual &&
+	git branch --no-contains=main >actual &&
 	test_must_be_empty actual
 
 '
 
-test_expect_success 'branch --no-contains master' '
+test_expect_success 'branch --no-contains main' '
 
-	git branch --no-contains master >actual &&
+	git branch --no-contains main >actual &&
 	test_must_be_empty actual
 
 '
@@ -76,7 +76,7 @@ test_expect_success 'branch --no-contains=side' '
 
 	git branch --no-contains=side >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -84,9 +84,9 @@ test_expect_success 'branch --no-contains=side' '
 
 test_expect_success 'branch --contains with pattern implies --list' '
 
-	git branch --contains=master master >actual &&
+	git branch --contains=main main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -94,7 +94,7 @@ test_expect_success 'branch --contains with pattern implies --list' '
 
 test_expect_success 'branch --no-contains with pattern implies --list' '
 
-	git branch --no-contains=master master >actual &&
+	git branch --no-contains=main main >actual &&
 	test_must_be_empty actual
 
 '
@@ -103,7 +103,7 @@ test_expect_success 'side: branch --merged' '
 
 	git branch --merged >actual &&
 	{
-		echo "  master" &&
+		echo "  main" &&
 		echo "* side"
 	} >expect &&
 	test_cmp expect actual
@@ -112,9 +112,9 @@ test_expect_success 'side: branch --merged' '
 
 test_expect_success 'branch --merged with pattern implies --list' '
 
-	git branch --merged=side master >actual &&
+	git branch --merged=side main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -127,18 +127,18 @@ test_expect_success 'side: branch --no-merged' '
 
 '
 
-test_expect_success 'master: branch --merged' '
+test_expect_success 'main: branch --merged' '
 
-	git checkout master &&
+	git checkout main &&
 	git branch --merged >actual &&
 	{
-		echo "* master"
+		echo "* main"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'master: branch --no-merged' '
+test_expect_success 'main: branch --no-merged' '
 
 	git branch --no-merged >actual &&
 	{
@@ -150,22 +150,22 @@ test_expect_success 'master: branch --no-merged' '
 
 test_expect_success 'branch --no-merged with pattern implies --list' '
 
-	git branch --no-merged=master master >actual &&
+	git branch --no-merged=main main >actual &&
 	test_must_be_empty actual
 
 '
 
 test_expect_success 'implicit --list conflicts with modification options' '
 
-	test_must_fail git branch --contains=master -d &&
-	test_must_fail git branch --contains=master -m foo &&
-	test_must_fail git branch --no-contains=master -d &&
-	test_must_fail git branch --no-contains=master -m foo
+	test_must_fail git branch --contains=main -d &&
+	test_must_fail git branch --contains=main -m foo &&
+	test_must_fail git branch --no-contains=main -d &&
+	test_must_fail git branch --no-contains=main -m foo
 
 '
 
 test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
-	test_must_fail git branch --contains master^{tree} &&
+	test_must_fail git branch --contains main^{tree} &&
 	blob=$(git hash-object -w --stdin <<-\EOF
 	Some blob
 	EOF
@@ -175,11 +175,11 @@ test_expect_success 'Assert that --contains only works on commits, not trees & b
 '
 
 test_expect_success 'multiple branch --contains' '
-	git checkout -b side2 master &&
+	git checkout -b side2 main &&
 	>feature &&
 	git add feature &&
 	git commit -m "add feature" &&
-	git checkout -b next master &&
+	git checkout -b next main &&
 	git merge side &&
 	git branch --contains side --contains side2 >actual &&
 	cat >expect <<-\EOF &&
@@ -191,9 +191,9 @@ test_expect_success 'multiple branch --contains' '
 '
 
 test_expect_success 'multiple branch --merged' '
-	git branch --merged next --merged master >actual &&
+	git branch --merged next --merged main >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* next
 	  side
 	EOF
@@ -203,13 +203,13 @@ test_expect_success 'multiple branch --merged' '
 test_expect_success 'multiple branch --no-contains' '
 	git branch --no-contains side --no-contains side2 >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'multiple branch --no-merged' '
-	git branch --no-merged next --no-merged master >actual &&
+	git branch --no-merged next --no-merged main >actual &&
 	cat >expect <<-\EOF &&
 	  side2
 	EOF
@@ -217,7 +217,7 @@ test_expect_success 'multiple branch --no-merged' '
 '
 
 test_expect_success 'branch --contains combined with --no-contains' '
-	git checkout -b seen master &&
+	git checkout -b seen main &&
 	git merge side &&
 	git merge side2 &&
 	git branch --contains side --no-contains side2 >actual &&
@@ -242,17 +242,17 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # that the latter walk does not mess up our flag to see if it was
 # merged).
 #
-# Here "topic" tracks "master" with one extra commit, and "zzz" points to the
-# same tip as master The name "zzz" must come alphabetically after "topic"
+# Here "topic" tracks "main" with one extra commit, and "zzz" points to the
+# same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
-	git branch --track topic master &&
+	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
 	test_commit foo &&
 	git branch --merged topic >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* topic
 	  zzz
 	EOF
diff --git a/t/t3202-show-branch-octopus.sh b/t/t3202-show-branch-octopus.sh
index bbf7129dd8..5cb0126cfe 100755
--- a/t/t3202-show-branch-octopus.sh
+++ b/t/t3202-show-branch-octopus.sh
@@ -2,7 +2,7 @@
 
 test_description='test show-branch with more than 8 heads'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup' '
 
 	for i in $numbers
 	do
-		git checkout -b branch$i master &&
+		git checkout -b branch$i main &&
 		> file$i &&
 		git add file$i &&
 		test_tick &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index a2144dd8e5..a7d2edd988 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='git branch display tests'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -29,7 +29,7 @@ test_expect_success 'make remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
 EOF
 test_expect_success 'git branch shows local branches' '
 	git branch >actual &&
@@ -63,7 +63,7 @@ test_expect_success 'git branch -r shows remote branches' '
 cat >expect <<'EOF'
   branch-one
   branch-two
-* master
+* main
   remotes/origin/HEAD -> origin/branch-one
   remotes/origin/branch-one
   remotes/origin/branch-two
@@ -155,7 +155,7 @@ test_expect_success 'git branch shows detached HEAD properly' '
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout HEAD^0 &&
 	git branch >actual &&
@@ -163,12 +163,12 @@ EOF
 '
 
 test_expect_success 'git branch shows detached HEAD properly after checkout --detach' '
-	git checkout master &&
+	git checkout main &&
 	cat >expect <<EOF &&
 * (HEAD detached at $(git rev-parse --short HEAD^0))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git checkout --detach &&
 	git branch >actual &&
@@ -180,7 +180,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving' '
 * (HEAD detached from $(git rev-parse --short HEAD))
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -192,9 +192,9 @@ test_expect_success 'git branch shows detached HEAD properly from tag' '
 * (HEAD detached at fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
-	git tag fromtag master &&
+	git tag fromtag main &&
 	git checkout fromtag &&
 	git branch >actual &&
 	test_i18ncmp expect actual
@@ -205,7 +205,7 @@ test_expect_success 'git branch shows detached HEAD properly after moving from t
 * (HEAD detached from fromtag)
   branch-one
   branch-two
-  master
+  main
 EOF
 	git reset --hard HEAD^1 &&
 	git branch >actual &&
@@ -217,7 +217,7 @@ test_expect_success 'git branch `--sort` option' '
 	* (HEAD detached from fromtag)
 	  branch-two
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --sort=objectsize >actual &&
 	test_i18ncmp expect actual
@@ -226,7 +226,7 @@ test_expect_success 'git branch `--sort` option' '
 test_expect_success 'git branch --points-at option' '
 	cat >expect <<-\EOF &&
 	  branch-one
-	  master
+	  main
 	EOF
 	git branch --points-at=branch-one >actual &&
 	test_cmp expect actual
@@ -263,14 +263,14 @@ test_expect_success 'sort branches, ignore case' '
 		cat >expected <<-\EOF &&
 		BRANCH-two
 		branch-one
-		master
+		main
 		EOF
 		test_cmp expected actual &&
 		git branch --list -i | awk "{print \$NF}" >actual &&
 		cat >expected <<-\EOF &&
 		branch-one
 		BRANCH-two
-		master
+		main
 		EOF
 		test_cmp expected actual
 	)
@@ -282,7 +282,7 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/ambiguous
 	Refname is refs/heads/branch-one
 	Refname is refs/heads/branch-two
-	Refname is refs/heads/master
+	Refname is refs/heads/main
 	Refname is refs/heads/ref-to-branch
 	Refname is refs/heads/ref-to-remote
 	EOF
@@ -296,7 +296,7 @@ test_expect_success 'worktree colors correct' '
 	  ambiguous<RESET>
 	  branch-one<RESET>
 	+ <CYAN>branch-two<RESET>
-	  master<RESET>
+	  main<RESET>
 	  ref-to-branch<RESET> -> branch-one
 	  ref-to-remote<RESET> -> origin/branch-one
 	EOF
@@ -309,9 +309,9 @@ test_expect_success 'worktree colors correct' '
 '
 
 test_expect_success "set up color tests" '
-	echo "<RED>master<RESET>" >expect.color &&
-	echo "master" >expect.bare &&
-	color_args="--format=%(color:red)%(refname:short) --list master"
+	echo "<RED>main<RESET>" >expect.color &&
+	echo "main" >expect.bare &&
+	color_args="--format=%(color:red)%(refname:short) --list main"
 '
 
 test_expect_success '%(color) omitted without tty' '
@@ -334,7 +334,7 @@ test_expect_success '--color overrides auto-color' '
 
 test_expect_success PREPARE_FOR_MAIN_BRANCH 'verbose output lists worktree path' '
 	one=$(git rev-parse --short HEAD) &&
-	two=$(git rev-parse --short master) &&
+	two=$(git rev-parse --short main) &&
 	cat >expect <<-EOF &&
 	* (HEAD detached from fromtag) $one one
 	  ambiguous                    $one one
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index dd315ebf04..993a6b5eff 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -6,7 +6,7 @@ Branch name arguments are usually names which are taken to be inside of
 refs/heads/, but we interpret some magic syntax like @{-1}, @{upstream}, etc.
 This script aims to check the behavior of those corner cases.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -31,7 +31,7 @@ test_expect_success 'update branch via @{-1}' '
 	git branch previous one &&
 
 	git checkout previous &&
-	git checkout master &&
+	git checkout main &&
 
 	git branch -f @{-1} two &&
 	expect_branch previous two
@@ -61,7 +61,7 @@ test_expect_success 'delete branch via @{-1}' '
 	git branch previous-del &&
 
 	git checkout previous-del &&
-	git checkout master &&
+	git checkout main &&
 
 	git branch -D @{-1} &&
 	expect_deleted previous-del
@@ -101,7 +101,7 @@ test_expect_success 'disallow deleting remote branch via @{-1}' '
 	git update-ref refs/remotes/origin/previous one &&
 
 	git checkout -b origin/previous two &&
-	git checkout master &&
+	git checkout main &&
 
 	test_must_fail git branch -r -D @{-1} &&
 	expect_branch refs/remotes/origin/previous one &&
diff --git a/t/t3205-branch-color.sh b/t/t3205-branch-color.sh
index 8b54a9252b..b905dc4867 100755
--- a/t/t3205-branch-color.sh
+++ b/t/t3205-branch-color.sh
@@ -1,14 +1,14 @@
 #!/bin/sh
 
 test_description='basic branch output coloring'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
 test_expect_success 'set up some sample branches' '
 	test_commit foo &&
-	git update-ref refs/remotes/origin/master HEAD &&
+	git update-ref refs/remotes/origin/main HEAD &&
 	git update-ref refs/heads/other HEAD
 '
 
@@ -22,9 +22,9 @@ test_expect_success 'set up some color config' '
 
 test_expect_success 'regular output shows colors' '
 	cat >expect <<-\EOF &&
-	* <CYAN>master<RESET>
+	* <CYAN>main<RESET>
 	  <BLUE>other<RESET>
-	  <YELLOW>remotes/origin/master<RESET>
+	  <YELLOW>remotes/origin/main<RESET>
 	EOF
 	git branch --color -a >actual.raw &&
 	test_decode_color <actual.raw >actual &&
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 3813ddc85e..ce24b5d735 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -2,7 +2,7 @@
 
 test_description='range-diff tests'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -130,7 +130,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'simple A..B A..C (unmodified)' '
-	git range-diff --no-color master..topic master..unmodified \
+	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -148,13 +148,13 @@ test_expect_success 'simple B...C (unmodified)' '
 '
 
 test_expect_success 'simple A B C (unmodified)' '
-	git range-diff --no-color master topic unmodified >actual &&
+	git range-diff --no-color main topic unmodified >actual &&
 	# same "expect" as above
 	test_cmp expect actual
 '
 
 test_expect_success 'trivial reordering' '
-	git range-diff --no-color master topic reordered >actual &&
+	git range-diff --no-color main topic reordered >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid r1) s/5/A/
 	3:  $(test_oid t3) = 2:  $(test_oid r2) s/11/B/
@@ -165,7 +165,7 @@ test_expect_success 'trivial reordering' '
 '
 
 test_expect_success 'removed a commit' '
-	git range-diff --no-color master topic removed >actual &&
+	git range-diff --no-color main topic removed >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid d1) s/5/A/
 	2:  $(test_oid t2) < -:  $(test_oid __) s/4/A/
@@ -176,7 +176,7 @@ test_expect_success 'removed a commit' '
 '
 
 test_expect_success 'added a commit' '
-	git range-diff --no-color master topic added >actual &&
+	git range-diff --no-color main topic added >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid a1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid a2) s/4/A/
@@ -188,7 +188,7 @@ test_expect_success 'added a commit' '
 '
 
 test_expect_success 'new base, A B C' '
-	git range-diff --no-color master topic rebased >actual &&
+	git range-diff --no-color main topic rebased >actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid b1) s/5/A/
 	2:  $(test_oid t2) = 2:  $(test_oid b2) s/4/A/
@@ -199,7 +199,7 @@ test_expect_success 'new base, A B C' '
 '
 
 test_expect_success 'new base, B...C' '
-	# this syntax includes the commits from master!
+	# this syntax includes the commits from main!
 	git range-diff --no-color topic...rebased >actual &&
 	cat >expect <<-EOF &&
 	-:  $(test_oid __) > 1:  $(test_oid b5) unrelated
@@ -423,7 +423,7 @@ test_expect_success 'file added and later removed' '
 
 test_expect_success 'no commits on one side' '
 	git commit --amend -m "new message" &&
-	git range-diff master HEAD@{1} HEAD
+	git range-diff main HEAD@{1} HEAD
 '
 
 test_expect_success 'changed message' '
@@ -485,11 +485,11 @@ test_expect_success 'dual-coloring' '
 	test_cmp expect actual
 '
 
-for prev in topic master..topic
+for prev in topic main..topic
 do
 	test_expect_success "format-patch --range-diff=$prev" '
 		git format-patch --cover-letter --range-diff=$prev \
-			master..unmodified >actual &&
+			main..unmodified >actual &&
 		test_when_finished "rm 000?-*" &&
 		test_line_count = 5 actual &&
 		test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -514,19 +514,19 @@ test_expect_success 'range-diff overrides diff.noprefix internally' '
 
 test_expect_success 'basic with modified format.pretty with suffix' '
 	git -c format.pretty="format:commit %H%d%n" range-diff \
-		master..topic master..unmodified
+		main..topic main..unmodified
 '
 
 test_expect_success 'basic with modified format.pretty without "commit "' '
 	git -c format.pretty="format:%H%n" range-diff \
-		master..topic master..unmodified
+		main..topic main..unmodified
 '
 
 test_expect_success 'range-diff compares notes by default' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-	git range-diff --no-color master..topic master..unmodified \
+	git range-diff --no-color main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -550,7 +550,7 @@ test_expect_success 'range-diff with --no-notes' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-	git range-diff --no-color --no-notes master..topic master..unmodified \
+	git range-diff --no-color --no-notes main..topic main..unmodified \
 		>actual &&
 	cat >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -568,7 +568,7 @@ test_expect_success 'range-diff with multiple --notes' '
 	git notes --ref=note2 add -m "topic note2" topic &&
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
 	test_when_finished git notes --ref=note2 remove topic unmodified &&
-	git range-diff --no-color --notes=note1 --notes=note2 master..topic master..unmodified \
+	git range-diff --no-color --notes=note1 --notes=note2 main..topic main..unmodified \
 		>actual &&
 	sed s/Z/\ /g >expect <<-EOF &&
 	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
@@ -598,7 +598,7 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -615,7 +615,7 @@ test_expect_success 'format-patch --range-diff with --no-notes' '
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --no-notes --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -632,7 +632,7 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
 	git format-patch --notes --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -661,7 +661,7 @@ test_expect_success 'format-patch --range-diff with format.notes config' '
 	test_when_finished git notes remove topic unmodified &&
 	test_config format.notes true &&
 	git format-patch --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
@@ -692,7 +692,7 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	git notes --ref=note2 add -m "unmodified note2" unmodified &&
 	test_when_finished git notes --ref=note2 remove topic unmodified &&
 	git format-patch --notes=note1 --notes=note2 --cover-letter --range-diff=$prev \
-		master..unmodified >actual &&
+		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count = 5 actual &&
 	test_i18ngrep "^Range-diff:$" 0000-* &&
diff --git a/t/t3206/history.export b/t/t3206/history.export
index 4c808e5b3b..4485adc37b 100644
--- a/t/t3206/history.export
+++ b/t/t3206/history.export
@@ -168,7 +168,7 @@ mark :11
 data 10
 unrelated
 
-commit refs/heads/master
+commit refs/heads/main
 mark :12
 author Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
 committer Thomas Rast <trast@inf.ethz.ch> 1374485127 +0200
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 90eea19564..3b7cdc56ec 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -9,7 +9,7 @@ test_description='git pack-refs should not change the branch semantic
 This test runs git pack-refs and git show-ref and checks that the branch
 semantic is still the same.
 '
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -138,7 +138,7 @@ test_expect_success 'delete ref with dangling packed version' '
 	git commit --allow-empty -m "future garbage" &&
 	git pack-refs --all &&
 	git reset --hard HEAD^ &&
-	git checkout master &&
+	git checkout main &&
 	git reflog expire --expire=all --all &&
 	git prune --expire=all &&
 	git branch -d lamb 2>result &&
@@ -243,7 +243,7 @@ test_expect_success 'retry acquiring packed-refs.lock' '
 
 test_expect_success SYMLINKS 'pack symlinked packed-refs' '
 	# First make sure that symlinking works when reading:
-	git update-ref refs/heads/lossy refs/heads/master &&
+	git update-ref refs/heads/lossy refs/heads/main &&
 	git for-each-ref >all-refs-before &&
 	mv .git/packed-refs .git/my-deviant-packed-refs &&
 	ln -s my-deviant-packed-refs .git/packed-refs &&
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
index f3d9c6b6b6..37b9d26f4b 100755
--- a/t/t3211-peel-ref.sh
+++ b/t/t3211-peel-ref.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 test_description='tests for the peel_ref optimization of packed-refs'
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -22,7 +22,7 @@ print_ref() {
 
 test_expect_success 'set up expected show-ref output' '
 	{
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/main" &&
 		print_ref "refs/outside/foo" &&
 		print_ref "refs/outside/foo^{}" &&
 		print_ref "refs/tags/base" &&
@@ -50,7 +50,7 @@ test_expect_success 'create old-style pack-refs without fully-peeled' '
 	# know we are emulating exactly what an older git would have written.
 	{
 		echo "# pack-refs with: peeled " &&
-		print_ref "refs/heads/master" &&
+		print_ref "refs/heads/main" &&
 		print_ref "refs/outside/foo" &&
 		print_ref "refs/tags/base" &&
 		print_ref "refs/tags/foo" &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 8f43303007..2b685580b6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1295,11 +1295,11 @@ test_expect_success 'git notes copy diagnoses too many or too few parameters' '
 	test_i18ngrep "too many parameters" error
 '
 
-test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
+test_expect_success 'git notes get-ref expands refs/heads/main to refs/notes/refs/heads/main' '
 	test_unconfig core.notesRef &&
 	sane_unset GIT_NOTES_REF &&
-	echo refs/notes/refs/heads/master >expect &&
-	git notes --ref=refs/heads/master get-ref >actual &&
+	echo refs/notes/refs/heads/main >expect &&
+	git notes --ref=refs/heads/main get-ref >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 1564befe00..ef8b63952e 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -5,7 +5,7 @@
 
 test_description='Test commit notes index (expensive!)'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -23,7 +23,7 @@ create_repo () {
 			notemark=$(($mark+1))
 			test_tick &&
 			cat <<-INPUT_END &&
-			commit refs/heads/master
+			commit refs/heads/main
 			mark :$mark
 			committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 			data <<COMMIT
diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 16f3438355..d47ce00f69 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -2,7 +2,7 @@
 
 test_description='Test commit notes organized in subtrees'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -43,7 +43,7 @@ test_expect_success "setup: create $number_of_commits commits" '
 			nr=$(($nr+1)) &&
 			test_tick &&
 			cat <<INPUT_END
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #$nr
@@ -78,7 +78,7 @@ test_sha1_based () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			note_path=$(echo "$sha1" | sed "$1")
 			cat <<INPUT_END &&
@@ -108,7 +108,7 @@ test_same_notes () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			first_note_path=$(echo "$sha1" | sed "$1")
 			second_note_path=$(echo "$sha1" | sed "$2")
@@ -147,7 +147,7 @@ test_concatenated_notes () {
 	(
 		start_note_commit &&
 		nr=$number_of_commits &&
-		git rev-list refs/heads/master |
+		git rev-list refs/heads/main |
 		while read sha1; do
 			first_note_path=$(echo "$sha1" | sed "$1")
 			second_note_path=$(echo "$sha1" | sed "$2")
diff --git a/t/t3304-notes-mixed.sh b/t/t3304-notes-mixed.sh
index 6a7b8e2829..03dfcd3954 100755
--- a/t/t3304-notes-mixed.sh
+++ b/t/t3304-notes-mixed.sh
@@ -2,7 +2,7 @@
 
 test_description='Test notes trees that also contain non-notes'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -39,7 +39,7 @@ test_expect_success "setup: create a couple of commits" '
 
 	test_tick &&
 	cat <<INPUT_END >input &&
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #1
@@ -54,7 +54,7 @@ INPUT_END
 
 	test_tick &&
 	cat <<INPUT_END >>input &&
-commit refs/heads/master
+commit refs/heads/main
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
 commit #2
@@ -71,8 +71,8 @@ INPUT_END
 
 test_expect_success "create a notes tree with both notes and non-notes" '
 
-	commit1=$(git rev-parse refs/heads/master^) &&
-	commit2=$(git rev-parse refs/heads/master) &&
+	commit1=$(git rev-parse refs/heads/main^) &&
+	commit2=$(git rev-parse refs/heads/main) &&
 	test_tick &&
 	cat <<INPUT_END >input &&
 commit refs/notes/commits
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index d69c84c640..202702be1a 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -108,7 +108,7 @@ test_expect_success 'fail to merge into various non-notes refs' '
 	git update-ref refs/notes/dir/foo HEAD &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/dir/" notes merge x &&
-	test_must_fail git -c "core.notesRef=refs/heads/master" notes merge x &&
+	test_must_fail git -c "core.notesRef=refs/heads/main" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/y:" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/y:foo" notes merge x &&
 	test_must_fail git -c "core.notesRef=refs/notes/foo^{bar" notes merge x
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index f86975414c..052516e6c6 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -5,7 +5,7 @@
 
 test_description='Test merging of notes trees in multiple worktrees'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
@@ -39,8 +39,8 @@ test_expect_success 'modify notes ref ourselves (x)' '
 '
 
 test_expect_success 'create some new worktrees' '
-	git worktree add -b newbranch worktree master &&
-	git worktree add -b newbranch2 worktree2 master
+	git worktree add -b newbranch worktree main &&
+	git worktree add -b newbranch2 worktree2 main
 '
 
 test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
-- 
gitgitgadget

