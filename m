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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF8EC1B0D8
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5B3233FD
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbgLQBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731291AbgLQBH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:07:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1F9C0617A7
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v14so4017235wml.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+EyJwZcTSTb4eONAc2wlveK1tquMm6mud1tx0+trD98=;
        b=m1hIaabGJfUzk405JTrRVFJVa/Rol8s+eUdNSaaxrPmrq7VvFkoY0I26YgVarlU2s5
         9Gtmek5SvdEwpLMAm4ac914Tr0kUokYTc/rViB2BhwdX5UiH0ifvCdTj3Xw4tesQWI+o
         Y0DlksMLnMNtNpl9X4M2iFhqJJkSVWyJg86l+1sspon5GtlbyMN3I/0trzzumxqm/Alh
         L1ag/0HCWF3C4xOI4wwCmd+IBGn5gvIqYOdf/+T55Ng2jhKXELpN7wBKsm8WUxQNRvku
         IhnDOu2+j7bGKlbgF/rFYNW7XC9teROzEIpQ0E/JjSJq16x5zMgt2vrnUavKySDHlQRC
         QHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+EyJwZcTSTb4eONAc2wlveK1tquMm6mud1tx0+trD98=;
        b=VgaMuxbkxAtTBJnRP3hmu0o5ToypWnbDrBcSH4T+j0VdMKn9eWUYiXwpNTdiojxymL
         F1LOAY5l2BMYWT4HVcWx7OP9PO4lLN5W/kl5ZtzL67B2bm6/3/lwh3n4wfSjeEhsMLbw
         xdBQLXwEqGJKOIR4TkyPSAE2UOK/U6S53unpOBN95Odw/+BwC+fyiWXIp4iUK/QEWjWu
         MHHJfrsr3aO4H9Pg17OGeR8YzLJSDGVHDSmRqmp3WOlVJylkgGh+zhKzajCiECD4uwzB
         9bYe4p38ud/uJR7rvk+KLWHMomBy1dVKnGtOMOzmn7sp/GpCR/bBcV05wyTO3YShLmDZ
         uUzQ==
X-Gm-Message-State: AOAM532pzc+A9KqXXqQN7QDba1JlgfzAEImAQwte35YTSrInK/bOUcbC
        JK7TriwZtG3+P9KuXKao1Bjwq09HqNI=
X-Google-Smtp-Source: ABdhPJz3naqYA70/jTJvmVDDZC7fCnBswPm9Lw/GlZodTShAoCSgdonfEtt7OF5ZaT6ZpUnWX9z3+g==
X-Received: by 2002:a1c:c308:: with SMTP id t8mr5960395wmf.22.1608167233770;
        Wed, 16 Dec 2020 17:07:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm5733527wrx.93.2020.12.16.17.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:13 -0800 (PST)
Message-Id: <fd58ce9e56c7f832d4c62ac444e69332c8ea7b96.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:01 +0000
Subject: [PATCH 02/11] t3200: finish transitioning to the initial branch name
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 56300ff356b (t3200: prepare for `main` being shorter than `master`,
2020-10-23) and in 66713e84e71 (tests: prepare aligned mentions of the
default branch name, 2020-10-23), we started to prepare t3200 for a new
world where `git init` uses the branch name `main` for the initial
branch.

We do not even have to wait for that new world: we can easily ensure
that that branch name is used, independent of the exact name `git init`
will give the initial branch, so let's do that.

This also lets us remove the `PREPARE_FOR_MAIN_BRANCH` prereq from three
test cases in that script.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh | 265 +++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 132 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a0b832d59e6..3ec3e1d7303 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -12,6 +12,7 @@ test_expect_success 'prepare a trivial repository' '
 	echo Hello >A &&
 	git update-index --add A &&
 	git commit -m "Initial commit." &&
+	git branch -M main &&
 	echo World >>A &&
 	git update-index --add A &&
 	git commit -m "Second commit." &&
@@ -27,8 +28,8 @@ test_expect_success 'branch -h in broken repository' '
 	mkdir broken &&
 	(
 		cd broken &&
-		git init &&
-		>.git/refs/heads/master &&
+		git init -b main &&
+		>.git/refs/heads/main &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
 	test_i18ngrep "[Uu]sage" broken/usage
@@ -42,8 +43,8 @@ test_expect_success 'git branch a/b/c should create a branch' '
 	git branch a/b/c && test_path_is_file .git/refs/heads/a/b/c
 '
 
-test_expect_success 'git branch mb master... should create a branch' '
-	git branch mb master... && test_path_is_file .git/refs/heads/mb
+test_expect_success 'git branch mb main... should create a branch' '
+	git branch mb main... && test_path_is_file .git/refs/heads/mb
 '
 
 test_expect_success 'git branch HEAD should fail' '
@@ -51,7 +52,7 @@ test_expect_success 'git branch HEAD should fail' '
 '
 
 cat >expect <<EOF
-$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$ZERO_OID $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from main
 EOF
 test_expect_success 'git branch --create-reflog d/e/f should create a branch and a log' '
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
@@ -110,7 +111,7 @@ test_expect_success 'git branch -m n/n n should work' '
 
 test_expect_success 'git branch -m bbb should rename checked out branch' '
 	test_when_finished git branch -D bbb &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b aaa &&
 	git commit --allow-empty -m "a new commit" &&
 	git rev-parse aaa@{0} >expect &&
@@ -124,7 +125,7 @@ test_expect_success 'git branch -m bbb should rename checked out branch' '
 
 test_expect_success 'renaming checked out branch works with d/f conflict' '
 	test_when_finished "git branch -D foo/bar || git branch -D foo" &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout -b foo &&
 	git branch -m foo/bar &&
 	git symbolic-ref HEAD >actual &&
@@ -178,14 +179,14 @@ test_expect_success 'git branch -M baz bam should add entries to .git/logs/HEAD'
 '
 
 test_expect_success 'git branch -M should leave orphaned HEAD alone' '
-	git init orphan &&
+	git init -b main orphan &&
 	(
 		cd orphan &&
 		test_commit initial &&
 		git checkout --orphan lonely &&
 		grep lonely .git/HEAD &&
 		test_path_is_missing .git/refs/head/lonely &&
-		git branch -M master mistress &&
+		git branch -M main mistress &&
 		grep lonely .git/HEAD
 	)
 '
@@ -201,7 +202,7 @@ test_expect_success 'resulting reflog can be shown by log -g' '
 '
 
 test_expect_success 'git branch -M baz bam should succeed when baz is checked out as linked working tree' '
-	git checkout master &&
+	git checkout main &&
 	git worktree add -b baz bazdir &&
 	git worktree add -f bazdir2 baz &&
 	git branch -M baz bam &&
@@ -224,18 +225,18 @@ test_expect_success 'git branch -M baz bam should succeed within a worktree in w
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
@@ -289,11 +290,11 @@ test_expect_success 'deleting checked-out branch from repo that is a submodule'
 test_expect_success 'bare main worktree has HEAD at branch deleted by secondary worktree' '
 	test_when_finished "rm -rf nonbare base secondary" &&
 
-	git init nonbare &&
+	git init -b main nonbare &&
 	test_commit -C nonbare x &&
 	git clone --bare nonbare bare &&
-	git -C bare worktree add --detach ../secondary master &&
-	git -C secondary branch -D master
+	git -C bare worktree add --detach ../secondary main &&
+	git -C secondary branch -D main
 '
 
 test_expect_success 'git branch --list -v with --abbrev' '
@@ -321,7 +322,7 @@ test_expect_success 'git branch --list -v with --abbrev' '
 
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch --column' '
+test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
   a/b/c   bam     foo     l     * main    n       o/p     r
@@ -345,7 +346,7 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -358,7 +359,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch with column.*' '
+test_expect_success 'git branch with column.*' '
 	git config column.ui column &&
 	git config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
@@ -375,7 +376,7 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
+test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
@@ -388,7 +389,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignore
   j/k
   l
   m/m
-* master
+* main
   mb
   n
   o/o
@@ -427,8 +428,8 @@ test_expect_success 'config information was renamed, too' '
 '
 
 test_expect_success 'git branch -m correctly renames multiple config sections' '
-	test_when_finished "git checkout master" &&
-	git checkout -b source master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -587,18 +588,18 @@ test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
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
@@ -620,8 +621,8 @@ test_expect_success 'git branch -C ab cd should overwrite existing config for cd
 test_expect_success 'git branch -c correctly copies multiple config sections' '
 	FOO=1 &&
 	export FOO &&
-	test_when_finished "git checkout master" &&
-	git checkout -b source2 master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b source2 main &&
 
 	# Assert that a config file with multiple config sections has
 	# those sections preserved...
@@ -711,10 +712,10 @@ test_expect_success 'deleting a self-referential symref' '
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
 
@@ -728,27 +729,27 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
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
@@ -757,21 +758,21 @@ test_expect_success 'test tracking setup via config' '
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
@@ -836,26 +837,26 @@ test_expect_success 'branch from tag w/--track causes failure' '
 
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
 
@@ -874,20 +875,20 @@ test_expect_success '--set-upstream-to fails on locked config' '
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
@@ -906,14 +907,14 @@ test_expect_success '--unset-upstream should fail if config is locked' '
 
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
@@ -934,14 +935,14 @@ test_expect_success '--unset-upstream should fail on detached HEAD' '
 
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
@@ -956,32 +957,32 @@ test_expect_success '--set-upstream-to notices an error to set branch as own ups
 
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
@@ -990,10 +991,10 @@ test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates
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
 
@@ -1049,10 +1050,10 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
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
 
@@ -1060,10 +1061,10 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
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
 
@@ -1071,10 +1072,10 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
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
 
@@ -1082,10 +1083,10 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
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
 
@@ -1093,10 +1094,10 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
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
 
@@ -1114,7 +1115,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
@@ -1124,8 +1125,8 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
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
@@ -1135,7 +1136,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git config branch.autosetuprebase never &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
@@ -1146,7 +1147,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git config branch.autosetuprebase local &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
@@ -1157,7 +1158,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git config branch.autosetuprebase remote &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
@@ -1168,7 +1169,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git config branch.autosetuprebase always &&
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	(git show-ref -q refs/remotes/local/main || git fetch local) &&
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
@@ -1179,8 +1180,8 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
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
@@ -1190,8 +1191,8 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
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
@@ -1201,8 +1202,8 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
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
@@ -1212,8 +1213,8 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
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
@@ -1221,7 +1222,7 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
 	git config branch.autosetupmerge always &&
-	test_when_finished git checkout master &&
+	test_when_finished git checkout main &&
 	git checkout HEAD^0 &&
 	git branch my11 &&
 	test -z "$(git config branch.my11.remote)" &&
@@ -1249,18 +1250,18 @@ test_expect_success 'attempt to delete a branch without base and unmerged to HEA
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
@@ -1287,7 +1288,7 @@ test_expect_success 'detect typo in branch name when using --edit-description' '
 '
 
 test_expect_success 'refuse --edit-description on unborn branch for now' '
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
 	EOF
@@ -1301,18 +1302,18 @@ test_expect_success '--merged catches invalid object names' '
 
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
@@ -1324,17 +1325,17 @@ test_expect_success '--list during rebase from detached HEAD' '
 
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
-	git init a &&
+	git init -b main a &&
 	(
 		cd a &&
 		test_commit a
 	) &&
-	git init b &&
+	git init -b main b &&
 	(
 		cd b &&
 		test_commit b
 	) &&
-	git init c &&
+	git init -b main c &&
 	(
 		cd c &&
 		test_commit c &&
@@ -1342,23 +1343,23 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 		git remote add b ../b &&
 		git fetch --all
 	) &&
-	git init d &&
+	git init -b main d &&
 	(
 		cd d &&
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
 
 test_expect_success 'configured committerdate sort' '
-	git init sort &&
+	git init -b main sort &&
 	(
 		cd sort &&
 		git config branch.sort committerdate &&
@@ -1371,7 +1372,7 @@ test_expect_success 'configured committerdate sort' '
 		test_commit b &&
 		git branch >actual &&
 		cat >expect <<-\EOF &&
-		  master
+		  main
 		  a
 		  c
 		* b
@@ -1389,7 +1390,7 @@ test_expect_success 'option override configured sort' '
 		  a
 		* b
 		  c
-		  master
+		  main
 		EOF
 		test_cmp expect actual
 	)
-- 
gitgitgadget

