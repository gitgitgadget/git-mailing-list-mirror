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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F5C8300F
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D52221F8
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTiM2Xn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgKQQND (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgKQQM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901EDC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so3760740wmi.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aL21iKmd5v0rxYG5x+Wy4wFwLVWBG3/jRW8wGRlnm6M=;
        b=KTiM2Xn5XzeUuNy0Vol7GiQP10XInu0NjCwvAPMmEcek0w6j9ZhSTsxRWhIFkeD4HS
         mH4ovv6Kcq41C7J7JVlUjWbRjbgeQBCNpiwlKVHjepHHjwlmOIRmF7ivNm0lqcHJxibX
         nG0Rhfgl45+RFzxNxIx1KjO7oME+3GDGr2S1j9Z+JaebyvZWhJBPSLvYp3fwzMsBs/ms
         u7Tpl/t9cbZMYp5NyiAzQn3San8gF71Haubyt322iTbRvF1bLbDI+HtmpNuLkso3KrDh
         1NzuJFgLX/3HTgHvW+ZTV7QTctKZrKJuQ9kJrshUxRYUx7q4wgChYvRhk4/nzTQzO0jn
         6odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aL21iKmd5v0rxYG5x+Wy4wFwLVWBG3/jRW8wGRlnm6M=;
        b=Sebx1Qk2uS19GeZeWAZw/NR2u/K+jJj8fhzjj+1l/hoT/mqtCxJUKr12UTnnfUX688
         TdENwyl3mNQUKfBMCXYXFDdeBj5eGxTjbfvWwVLjc8qMrAqp0DQeUB3cTF3fC+qIcggg
         RfDf/ezLsC5OznIDtDdAGQZnwvsu47lzT4ulKL8pM/x4xFd5u+VxFmm+Dxco9OcgWuc6
         rtONhyvZuBUpCZHElTnQBZGuR+LICCUI4v0pZYv5rIoikSORjpRMxjsiA1/cjUQh1mLg
         z8ZivbzjHyMKNdusRwC8Qs/7PGU/d/PfzFFJ+GiyoxdAw7/rHDH2/z1LR0khBGqI6kA2
         mM1A==
X-Gm-Message-State: AOAM532r4heBJ92qM9ENr+rHPalcfWRp5ieeq4JzxQFvp9FMPT9HUe7A
        Qz7AkJuOnkHfB/5Lf9w4nzIMmh5iVPM=
X-Google-Smtp-Source: ABdhPJwURu91J4xSlFjPUa9dPN6DbZl5aMkIoMPnsw43P/91fqRGtKwIXbDDI4yXVr0PsWm5vPA2MQ==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr443390wmb.34.1605629573868;
        Tue, 17 Nov 2020 08:12:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm27064818wrx.5.2020.11.17.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:53 -0800 (PST)
Message-Id: <cfa29c7f714f8225714e9dc052e37b4402bc9863.1605629549.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:26 +0000
Subject: [PATCH v2 26/27] t99*: adjust the references to the default branch
 name "main"
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

Carefully excluding t9902, which sees independent development elsewhere
at the time of writing, we use `main` as the default branch name in
t9903. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t99*.sh lib-cvs.sh &&
	   git checkout HEAD -- t9902\*)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for all tests (except the ones we specifically excluded for now).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9903-bash-prompt.sh | 114 ++++++++++++++++++++---------------------
 t/test-lib.sh          |   4 +-
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ab5da2cabc..a77daa7419 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup for prompt tests' '
 	echo 3 >file &&
 	git commit -m "third b1" file &&
 	git tag -a -m msg2 t2 &&
-	git checkout -b b2 master &&
+	git checkout -b b2 main &&
 	echo 0 >file &&
 	git commit -m "second b2" file &&
 	echo 00 >file &&
@@ -37,20 +37,20 @@ test_expect_success 'setup for prompt tests' '
 	git commit -m "yet another b2" file &&
 	mkdir ignored_dir &&
 	echo "ignored_dir/" >>.gitignore &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'prompt - branch name' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
-	printf " (master)" >expected &&
-	test_when_finished "git checkout master" &&
+	printf " (main)" >expected &&
+	test_when_finished "git checkout main" &&
 	test_config core.preferSymlinkRefs true &&
-	git checkout master &&
+	git checkout main &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -58,7 +58,7 @@ test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
 test_expect_success 'prompt - unborn branch' '
 	printf " (unborn)" >expected &&
 	git checkout --orphan unborn &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -72,7 +72,7 @@ test_expect_success FUNNYNAMES 'prompt - with newline in path' '
 with
 newline" &&
 	mkdir "$repo_with_newline" &&
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	git init "$repo_with_newline" &&
 	test_when_finished "rm -rf \"$repo_with_newline\"" &&
 	mkdir "$repo_with_newline"/subdir &&
@@ -87,7 +87,7 @@ test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format="%h" --abbrev=13 b1^) >expected &&
 	test_config core.abbrev 13 &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -95,7 +95,7 @@ test_expect_success 'prompt - detached head' '
 test_expect_success 'prompt - describe detached head - contains' '
 	printf " ((t2~1))" >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=contains &&
 		__git_ps1 >"$actual"
@@ -106,7 +106,7 @@ test_expect_success 'prompt - describe detached head - contains' '
 test_expect_success 'prompt - describe detached head - branch' '
 	printf " ((tags/t2~1))" >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=branch &&
 		__git_ps1 >"$actual"
@@ -117,7 +117,7 @@ test_expect_success 'prompt - describe detached head - branch' '
 test_expect_success 'prompt - describe detached head - describe' '
 	printf " ((t1-1-g%s))" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=describe &&
 		__git_ps1 >"$actual"
@@ -128,7 +128,7 @@ test_expect_success 'prompt - describe detached head - describe' '
 test_expect_success 'prompt - describe detached head - default' '
 	printf " ((t2))" >expected &&
 	git checkout --detach b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -152,7 +152,7 @@ test_expect_success 'prompt - deep inside .git directory' '
 '
 
 test_expect_success 'prompt - inside bare repository' '
-	printf " (BARE:master)" >expected &&
+	printf " (BARE:main)" >expected &&
 	git init --bare bare.git &&
 	test_when_finished "rm -rf bare.git" &&
 	(
@@ -172,7 +172,7 @@ test_expect_success 'prompt - interactive rebase' '
 	test_when_finished "rm -f fake_editor.sh" &&
 	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
 	git checkout b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git rebase -i HEAD^ &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -182,7 +182,7 @@ test_expect_success 'prompt - interactive rebase' '
 test_expect_success 'prompt - rebase merge' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --merge b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -192,7 +192,7 @@ test_expect_success 'prompt - rebase merge' '
 test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --apply b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -202,7 +202,7 @@ test_expect_success 'prompt - rebase am' '
 test_expect_success 'prompt - merge' '
 	printf " (b1|MERGING)" >expected &&
 	git checkout b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git merge b2 &&
 	test_when_finished "git reset --hard" &&
 	__git_ps1 >"$actual" &&
@@ -210,7 +210,7 @@ test_expect_success 'prompt - merge' '
 '
 
 test_expect_success 'prompt - cherry-pick' '
-	printf " (master|CHERRY-PICKING)" >expected &&
+	printf " (main|CHERRY-PICKING)" >expected &&
 	test_must_fail git cherry-pick b1 b1^ &&
 	test_when_finished "git cherry-pick --abort" &&
 	__git_ps1 >"$actual" &&
@@ -222,7 +222,7 @@ test_expect_success 'prompt - cherry-pick' '
 '
 
 test_expect_success 'prompt - revert' '
-	printf " (master|REVERTING)" >expected &&
+	printf " (main|REVERTING)" >expected &&
 	test_must_fail git revert b1^ b1 &&
 	test_when_finished "git revert --abort" &&
 	__git_ps1 >"$actual" &&
@@ -234,7 +234,7 @@ test_expect_success 'prompt - revert' '
 '
 
 test_expect_success 'prompt - bisect' '
-	printf " (master|BISECTING)" >expected &&
+	printf " (main|BISECTING)" >expected &&
 	git bisect start &&
 	test_when_finished "git bisect reset" &&
 	__git_ps1 >"$actual" &&
@@ -242,7 +242,7 @@ test_expect_success 'prompt - bisect' '
 '
 
 test_expect_success 'prompt - dirty status indicator - clean' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		__git_ps1 >"$actual"
@@ -251,7 +251,7 @@ test_expect_success 'prompt - dirty status indicator - clean' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty worktree' '
-	printf " (master *)" >expected &&
+	printf " (main *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -262,7 +262,7 @@ test_expect_success 'prompt - dirty status indicator - dirty worktree' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty index' '
-	printf " (master +)" >expected &&
+	printf " (main +)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -274,7 +274,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty index and worktree' '
-	printf " (master *+)" >expected &&
+	printf " (main *+)" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -288,7 +288,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index and worktree'
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - clean' '
 	printf " (orphan #)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	git reset --hard &&
 	(
@@ -300,7 +300,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - clean' '
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - dirty index' '
 	printf " (orphan +)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
@@ -311,7 +311,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - dirty ind
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - dirty index and worktree' '
 	printf " (orphan *+)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	>file &&
 	(
@@ -322,7 +322,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - dirty ind
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
@@ -334,7 +334,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
@@ -346,7 +346,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
@@ -358,7 +358,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable set with c
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
-	printf " (master *)" >expected &&
+	printf " (main *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
@@ -382,7 +382,7 @@ test_expect_success 'prompt - dirty status indicator - not shown inside .git dir
 '
 
 test_expect_success 'prompt - stash status indicator - no stash' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=y &&
 		__git_ps1 >"$actual"
@@ -391,7 +391,7 @@ test_expect_success 'prompt - stash status indicator - no stash' '
 '
 
 test_expect_success 'prompt - stash status indicator - stash' '
-	printf " (master $)" >expected &&
+	printf " (main $)" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -417,7 +417,7 @@ test_expect_success 'prompt - stash status indicator - not shown inside .git dir
 '
 
 test_expect_success 'prompt - untracked files status indicator - no untracked files' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		cd otherrepo &&
@@ -427,7 +427,7 @@ test_expect_success 'prompt - untracked files status indicator - no untracked fi
 '
 
 test_expect_success 'prompt - untracked files status indicator - untracked files' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		__git_ps1 >"$actual"
@@ -436,7 +436,7 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 '
 
 test_expect_success 'prompt - untracked files status indicator - empty untracked dir' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	mkdir otherrepo/untracked-dir &&
 	test_when_finished "rm -rf otherrepo/untracked-dir" &&
 	(
@@ -448,7 +448,7 @@ test_expect_success 'prompt - untracked files status indicator - empty untracked
 '
 
 test_expect_success 'prompt - untracked files status indicator - non-empty untracked dir' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	mkdir otherrepo/untracked-dir &&
 	test_when_finished "rm -rf otherrepo/untracked-dir" &&
 	>otherrepo/untracked-dir/untracked-file &&
@@ -461,7 +461,7 @@ test_expect_success 'prompt - untracked files status indicator - non-empty untra
 '
 
 test_expect_success 'prompt - untracked files status indicator - untracked files outside cwd' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	(
 		mkdir -p ignored_dir &&
 		cd ignored_dir &&
@@ -472,7 +472,7 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
@@ -482,7 +482,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable unset with config enabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
@@ -492,7 +492,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable set with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -502,7 +502,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable set with config enabled' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -522,13 +522,13 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
 '
 
 test_expect_success 'prompt - format string starting with dash' '
-	printf -- "-master" >expected &&
+	printf -- "-main" >expected &&
 	__git_ps1 "-%s" >"$actual" &&
 	test_cmp expected "$actual"
 '
 
 test_expect_success 'prompt - pc mode' '
-	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmain" >expected &&
 	(
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
 		test_must_be_empty "$actual" &&
@@ -538,7 +538,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
@@ -550,7 +550,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 test_expect_success 'prompt - bash color pc mode - detached head' '
 	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" &&
@@ -560,7 +560,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -573,7 +573,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -587,7 +587,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -602,7 +602,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -628,7 +628,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
 '
 
 test_expect_success 'prompt - bash color pc mode - stash status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -642,7 +642,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
 '
 
 test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -653,7 +653,7 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode' '
-	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}main%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -664,7 +664,7 @@ test_expect_success 'prompt - zsh color pc mode' '
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var unset, config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.hideIfPwdIgnored false &&
 	(
 		cd ignored_dir &&
@@ -685,7 +685,7 @@ test_expect_success 'prompt - hide if pwd ignored - env var unset, config disabl
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var unset, config unset' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		cd ignored_dir &&
 		__git_ps1 >"$actual"
@@ -704,7 +704,7 @@ test_expect_success 'prompt - hide if pwd ignored - env var unset, config unset,
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var set, config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.hideIfPwdIgnored false &&
 	(
 		cd ignored_dir &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0ec93a2eec..d39bdf04ce 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,13 +257,13 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-3404|4013|5310|5526|6300|7064|7817)
+3404|4013|5310|5526|6300|7064|7817|9902)
 	# Avoid conflicts with patch series that are cooking at the same time
 	# as the patch series changing the default of `init.defaultBranch`.
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-8]*|9[0-8]*)
+*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

