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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDAFC8300A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B45D246BC
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7zorZG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKRXpW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgKRXpS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7177EC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so4326538wru.6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UmuawvsJlgLQBYiw9HRsreQIyKdZ2n+YSXjW9TSmJMs=;
        b=S7zorZG5ZIFTG3PYKVkHnMhUxdSWhE1dU+bqcNSDtF9aRAk11zH9PRvhTttpwXYByx
         6lDYGpJJZj3qw2AqPQ1QfaeLcZUaNXbMqIlTH4Eei5NGOloLMR7Ete4n3VjZxHCl/iOy
         1oyxudRQ6uzU2CX/NK0LVdkLuKyPkMectas+adIm3okEBHrs453fr7p8lFc/RvUIWSZO
         ZSovjEkTPvtsp2LzWHmDnpBhIc3j8zMSjSioUawxnWalIH46V8iNW3WhPwRTiBoB+ZLF
         CiXWCYWyJl9Rfp4p6QLEsTftRpBDIaMFIHTYFghqaY0rzsbvfNySsezQpSm8OOXXdo8c
         HVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UmuawvsJlgLQBYiw9HRsreQIyKdZ2n+YSXjW9TSmJMs=;
        b=EFugScDdG6eu9fJfRNDCiBlsPst1L1d1tA8SasPUTU5qatxcY/V6YHIIMFiNRxm36h
         5uDNSj9mc3pAAzsrK63MXfJbNr9z3m5QZt5b9gzdGZSRsuMMp/fsZduSmj7eIWw1ADGI
         r5Yb97w1kndft7KEUQwh5K7VHaL9ngPORXgbJltonXgon8ehxvqturapctFgaXkZq2yY
         d2I37dpAE0ZpCaaccIjRoy1FM1tq5UYZI+fh9yByQvISxXkWC8ghphG0JunDCr948bHa
         6u7NrwNFAY4xiswQ9uRg/xJa2B7fhYJE/gfoot7Qvpftrf78ZHwvQLlAEhE7+6jsAhk1
         FSOg==
X-Gm-Message-State: AOAM533i4HiO7QiU7TUGgqHNibXAzDAEkytDPOH+QiX3mZj5fpuMI6u7
        XVLXfAetvIsvtddVDxBOIYrNmtYtbvo=
X-Google-Smtp-Source: ABdhPJxYmViNlj5dIEg68Rk1KlLORtsrP6LwUM8N/6mcUwXFn5s0ps3jj2MzBq4MuGfRODxiRHeIWA==
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr7334868wro.246.1605743115863;
        Wed, 18 Nov 2020 15:45:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2sm34777546wrm.96.2020.11.18.15.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:15 -0800 (PST)
Message-Id: <bbc17c8ee58b5a772f4a46fbaab21f107ede587e.1605743088.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:45 +0000
Subject: [PATCH v3 27/28] t99*: adjust the references to the default branch
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
        Jonathan Nieder <jrnieder@gmail.com>,
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
 t/t9903-bash-prompt.sh | 116 ++++++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index f5b5935c2c..bbd513bab0 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -5,7 +5,7 @@
 
 test_description='test git-specific bash prompt functions'
 
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./lib-bash.sh
@@ -31,7 +31,7 @@ test_expect_success 'setup for prompt tests' '
 	echo 3 >file &&
 	git commit -m "third b1" file &&
 	git tag -a -m msg2 t2 &&
-	git checkout -b b2 master &&
+	git checkout -b b2 main &&
 	echo 0 >file &&
 	git commit -m "second b2" file &&
 	echo 00 >file &&
@@ -40,20 +40,20 @@ test_expect_success 'setup for prompt tests' '
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
@@ -61,7 +61,7 @@ test_expect_success SYMLINKS 'prompt - branch name - symlink symref' '
 test_expect_success 'prompt - unborn branch' '
 	printf " (unborn)" >expected &&
 	git checkout --orphan unborn &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -75,7 +75,7 @@ test_expect_success FUNNYNAMES 'prompt - with newline in path' '
 with
 newline" &&
 	mkdir "$repo_with_newline" &&
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	git init "$repo_with_newline" &&
 	test_when_finished "rm -rf \"$repo_with_newline\"" &&
 	mkdir "$repo_with_newline"/subdir &&
@@ -90,7 +90,7 @@ test_expect_success 'prompt - detached head' '
 	printf " ((%s...))" $(git log -1 --format="%h" --abbrev=13 b1^) >expected &&
 	test_config core.abbrev 13 &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -98,7 +98,7 @@ test_expect_success 'prompt - detached head' '
 test_expect_success 'prompt - describe detached head - contains' '
 	printf " ((t2~1))" >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=contains &&
 		__git_ps1 >"$actual"
@@ -109,7 +109,7 @@ test_expect_success 'prompt - describe detached head - contains' '
 test_expect_success 'prompt - describe detached head - branch' '
 	printf " ((tags/t2~1))" >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=branch &&
 		__git_ps1 >"$actual"
@@ -120,7 +120,7 @@ test_expect_success 'prompt - describe detached head - branch' '
 test_expect_success 'prompt - describe detached head - describe' '
 	printf " ((t1-1-g%s))" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_DESCRIBE_STYLE=describe &&
 		__git_ps1 >"$actual"
@@ -131,7 +131,7 @@ test_expect_success 'prompt - describe detached head - describe' '
 test_expect_success 'prompt - describe detached head - default' '
 	printf " ((t2))" >expected &&
 	git checkout --detach b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
@@ -155,7 +155,7 @@ test_expect_success 'prompt - deep inside .git directory' '
 '
 
 test_expect_success 'prompt - inside bare repository' '
-	printf " (BARE:master)" >expected &&
+	printf " (BARE:main)" >expected &&
 	git init --bare bare.git &&
 	test_when_finished "rm -rf bare.git" &&
 	(
@@ -175,7 +175,7 @@ test_expect_success 'prompt - interactive rebase' '
 	test_when_finished "rm -f fake_editor.sh" &&
 	test_set_editor "$TRASH_DIRECTORY/fake_editor.sh" &&
 	git checkout b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git rebase -i HEAD^ &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -185,7 +185,7 @@ test_expect_success 'prompt - interactive rebase' '
 test_expect_success 'prompt - rebase merge' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --merge b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -195,7 +195,7 @@ test_expect_success 'prompt - rebase merge' '
 test_expect_success 'prompt - rebase am' '
 	printf " (b2|REBASE 1/3)" >expected &&
 	git checkout b2 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git rebase --apply b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
@@ -205,7 +205,7 @@ test_expect_success 'prompt - rebase am' '
 test_expect_success 'prompt - merge' '
 	printf " (b1|MERGING)" >expected &&
 	git checkout b1 &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	test_must_fail git merge b2 &&
 	test_when_finished "git reset --hard" &&
 	__git_ps1 >"$actual" &&
@@ -213,7 +213,7 @@ test_expect_success 'prompt - merge' '
 '
 
 test_expect_success 'prompt - cherry-pick' '
-	printf " (master|CHERRY-PICKING)" >expected &&
+	printf " (main|CHERRY-PICKING)" >expected &&
 	test_must_fail git cherry-pick b1 b1^ &&
 	test_when_finished "git cherry-pick --abort" &&
 	__git_ps1 >"$actual" &&
@@ -225,7 +225,7 @@ test_expect_success 'prompt - cherry-pick' '
 '
 
 test_expect_success 'prompt - revert' '
-	printf " (master|REVERTING)" >expected &&
+	printf " (main|REVERTING)" >expected &&
 	test_must_fail git revert b1^ b1 &&
 	test_when_finished "git revert --abort" &&
 	__git_ps1 >"$actual" &&
@@ -237,7 +237,7 @@ test_expect_success 'prompt - revert' '
 '
 
 test_expect_success 'prompt - bisect' '
-	printf " (master|BISECTING)" >expected &&
+	printf " (main|BISECTING)" >expected &&
 	git bisect start &&
 	test_when_finished "git bisect reset" &&
 	__git_ps1 >"$actual" &&
@@ -245,7 +245,7 @@ test_expect_success 'prompt - bisect' '
 '
 
 test_expect_success 'prompt - dirty status indicator - clean' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		__git_ps1 >"$actual"
@@ -254,7 +254,7 @@ test_expect_success 'prompt - dirty status indicator - clean' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty worktree' '
-	printf " (master *)" >expected &&
+	printf " (main *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -265,7 +265,7 @@ test_expect_success 'prompt - dirty status indicator - dirty worktree' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty index' '
-	printf " (master +)" >expected &&
+	printf " (main +)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -277,7 +277,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index' '
 '
 
 test_expect_success 'prompt - dirty status indicator - dirty index and worktree' '
-	printf " (master *+)" >expected &&
+	printf " (main *+)" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -291,7 +291,7 @@ test_expect_success 'prompt - dirty status indicator - dirty index and worktree'
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - clean' '
 	printf " (orphan #)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	git reset --hard &&
 	(
@@ -303,7 +303,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - clean' '
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - dirty index' '
 	printf " (orphan +)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
@@ -314,7 +314,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - dirty ind
 
 test_expect_success 'prompt - dirty status indicator - orphan branch - dirty index and worktree' '
 	printf " (orphan *+)" >expected &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	git checkout --orphan orphan &&
 	>file &&
 	(
@@ -325,7 +325,7 @@ test_expect_success 'prompt - dirty status indicator - orphan branch - dirty ind
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable unset with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
@@ -337,7 +337,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable unset with config enabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
@@ -349,7 +349,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable unset with
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable set with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState false &&
@@ -361,7 +361,7 @@ test_expect_success 'prompt - dirty status indicator - shell variable set with c
 '
 
 test_expect_success 'prompt - dirty status indicator - shell variable set with config enabled' '
-	printf " (master *)" >expected &&
+	printf " (main *)" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	test_config bash.showDirtyState true &&
@@ -385,7 +385,7 @@ test_expect_success 'prompt - dirty status indicator - not shown inside .git dir
 '
 
 test_expect_success 'prompt - stash status indicator - no stash' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWSTASHSTATE=y &&
 		__git_ps1 >"$actual"
@@ -394,7 +394,7 @@ test_expect_success 'prompt - stash status indicator - no stash' '
 '
 
 test_expect_success 'prompt - stash status indicator - stash' '
-	printf " (master $)" >expected &&
+	printf " (main $)" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -420,7 +420,7 @@ test_expect_success 'prompt - stash status indicator - not shown inside .git dir
 '
 
 test_expect_success 'prompt - untracked files status indicator - no untracked files' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		cd otherrepo &&
@@ -430,7 +430,7 @@ test_expect_success 'prompt - untracked files status indicator - no untracked fi
 '
 
 test_expect_success 'prompt - untracked files status indicator - untracked files' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		__git_ps1 >"$actual"
@@ -439,7 +439,7 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 '
 
 test_expect_success 'prompt - untracked files status indicator - empty untracked dir' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	mkdir otherrepo/untracked-dir &&
 	test_when_finished "rm -rf otherrepo/untracked-dir" &&
 	(
@@ -451,7 +451,7 @@ test_expect_success 'prompt - untracked files status indicator - empty untracked
 '
 
 test_expect_success 'prompt - untracked files status indicator - non-empty untracked dir' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	mkdir otherrepo/untracked-dir &&
 	test_when_finished "rm -rf otherrepo/untracked-dir" &&
 	>otherrepo/untracked-dir/untracked-file &&
@@ -464,7 +464,7 @@ test_expect_success 'prompt - untracked files status indicator - non-empty untra
 '
 
 test_expect_success 'prompt - untracked files status indicator - untracked files outside cwd' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	(
 		mkdir -p ignored_dir &&
 		cd ignored_dir &&
@@ -475,7 +475,7 @@ test_expect_success 'prompt - untracked files status indicator - untracked files
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable unset with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
@@ -485,7 +485,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable unset with config enabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		sane_unset GIT_PS1_SHOWUNTRACKEDFILES &&
@@ -495,7 +495,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable set with config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.showUntrackedFiles false &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -505,7 +505,7 @@ test_expect_success 'prompt - untracked files status indicator - shell variable
 '
 
 test_expect_success 'prompt - untracked files status indicator - shell variable set with config enabled' '
-	printf " (master %%)" >expected &&
+	printf " (main %%)" >expected &&
 	test_config bash.showUntrackedFiles true &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
@@ -525,13 +525,13 @@ test_expect_success 'prompt - untracked files status indicator - not shown insid
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
@@ -541,7 +541,7 @@ test_expect_success 'prompt - pc mode' '
 '
 
 test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
@@ -553,7 +553,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 test_expect_success 'prompt - bash color pc mode - detached head' '
 	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
 	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
 		__git_ps1 "BEFORE:" ":AFTER" &&
@@ -563,7 +563,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	(
@@ -576,7 +576,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -590,7 +590,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmain" >expected &&
 	echo "dirty index" >file &&
 	test_when_finished "git reset --hard" &&
 	git add -u &&
@@ -605,7 +605,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
 '
 
 test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWDIRTYSTATE=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -631,7 +631,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
 '
 
 test_expect_success 'prompt - bash color pc mode - stash status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
 	echo 2 >file &&
 	git stash &&
 	test_when_finished "git stash drop" &&
@@ -645,7 +645,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
 '
 
 test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
+	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
 	(
 		GIT_PS1_SHOWUNTRACKEDFILES=y &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -656,7 +656,7 @@ test_expect_success 'prompt - bash color pc mode - untracked files status indica
 '
 
 test_expect_success 'prompt - zsh color pc mode' '
-	printf "BEFORE: (%%F{green}master%%f):AFTER" >expected &&
+	printf "BEFORE: (%%F{green}main%%f):AFTER" >expected &&
 	(
 		ZSH_VERSION=5.0.0 &&
 		GIT_PS1_SHOWCOLORHINTS=y &&
@@ -667,7 +667,7 @@ test_expect_success 'prompt - zsh color pc mode' '
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var unset, config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.hideIfPwdIgnored false &&
 	(
 		cd ignored_dir &&
@@ -688,7 +688,7 @@ test_expect_success 'prompt - hide if pwd ignored - env var unset, config disabl
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var unset, config unset' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	(
 		cd ignored_dir &&
 		__git_ps1 >"$actual"
@@ -707,7 +707,7 @@ test_expect_success 'prompt - hide if pwd ignored - env var unset, config unset,
 '
 
 test_expect_success 'prompt - hide if pwd ignored - env var set, config disabled' '
-	printf " (master)" >expected &&
+	printf " (main)" >expected &&
 	test_config bash.hideIfPwdIgnored false &&
 	(
 		cd ignored_dir &&
-- 
gitgitgadget

