Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B1C64E7D
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAE820825
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 22:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIPVafxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKLWoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 17:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgKLWoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 17:44:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E52C061A48
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:20 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so6860911wme.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GN4G6QsZmljMzgDC6utVTEHBFbyCDOLjec62dMQAoIc=;
        b=JIPVafxHQVYK43eqvSMWnicNFYKOy9YBq1Bj2bk7BFDs6ZxZ4yXolRHwzFefDh0oaR
         kNFvVmhmENQ9XlApk72OdDBuYc6jC+9DLYz/uBO5q0HJONFciObRAgPTm/mq7jpmVwjO
         kW+z5BH693iabwFNEPTQPqEGU5T+5fp/LeodRnkd+Ah1zq+EJgFSkFrkjHsachZdncc4
         mjSsk+DOhBprCB+LSCU0IEE82ZebtB3sI0jqRDNRfaxtn9q0OT103eBgcRF+JwLO2Abj
         Gy/b43rISn6/f3T3vGq9GRG+mvyQPGNK9KEtJzuZBC3rUJ7pJQXSKw8HdlPgRDWChH6a
         /S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GN4G6QsZmljMzgDC6utVTEHBFbyCDOLjec62dMQAoIc=;
        b=omgE0w+PG8LyzyOLJYArmzys7/ySDFQsY2/Q0PUN43sUorUXQN5Mn9DmvoVEUlz6Ij
         XCVyTZfPQpKiookIRQxVMcG3QwtC4WQdzB4iZrkhlSizFeg/Ykjc87KIKNu8RDeIfx/p
         8clKLqIKThRsvRUucS7+i7yu/GOIgzei7OVwJrd5Ti7j7qrz2MTFAldynPSLplPaUPGV
         WoQ4D2J/T9+MPW1kgqk2kH/rsLbQhaCI+//HmtEeqDDvKllTAKvQYz2kFEzKIyJ6NwYr
         rrAcNnINGsIiFQ6ExM+bhYsWG/RVKOYl81hg8GxUICbfNNxpZkrtppYFah9U1Rs0LtXI
         KPTQ==
X-Gm-Message-State: AOAM532jNNl65HhZ1nflmQi4uQaWgK7/XjuTrZjjTx35w3PiLzj0nBfc
        p3RHZbTTXtcmfXvdC9kSdAHTNvRfN+I=
X-Google-Smtp-Source: ABdhPJzIn3AptGRNtXOI8Cmvh7uiSeMvFYV0wbENS+k2sdv00GnilRKR8xVrFCltH6wqm7o7hX9epQ==
X-Received: by 2002:a1c:490b:: with SMTP id w11mr41300wma.101.1605221057568;
        Thu, 12 Nov 2020 14:44:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm3177390wrq.78.2020.11.12.14.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 14:44:17 -0800 (PST)
Message-Id: <07714a8c6543703f099b83860c369896484c7bff.1605221039.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.git.1605221038.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Nov 2020 22:43:51 +0000
Subject: [PATCH 21/28] t7[5-9]*: adjust the references to the default branch
 name "main"
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

Excluding t7817, which is added in an unrelated patch series at the time
of writing, this adjusts t7[5-9]*. This trick was performed via

	$ (cd t &&
	   sed -i -e 's/master/main/g' -e 's/MASTER/MAIN/g' \
		-e 's/Master/Main/g' -- t7[5-9]*.sh)

This allows us to define `GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main`
for those tests.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7501-commit-basic-functionality.sh         |   2 +-
 t/t7502-commit-porcelain.sh                   |  12 +-
 ...3-pre-commit-and-pre-merge-commit-hooks.sh |  42 ++---
 t/t7504-commit-msg-hook.sh                    |  24 +--
 t/t7505-prepare-commit-msg-hook.sh            |  20 +-
 t/t7508-status.sh                             |  58 +++---
 t/t7510-signed-commit.sh                      |   2 +-
 t/t7512-status-help.sh                        |  40 ++--
 t/t7517-per-repo-email.sh                     |  12 +-
 t/t7600-merge.sh                              |  44 ++---
 t/t7606-merge-custom.sh                       |   2 +-
 t/t7608-merge-messages.sh                     |  36 ++--
 t/t7610-mergetool.sh                          | 174 +++++++++---------
 t/t7611-merge-abort.sh                        |   4 +-
 t/t7612-merge-verify-signatures.sh            |   2 +-
 t/t7614-merge-signoff.sh                      |  24 +--
 t/t7701-repack-unpack-unreachable.sh          |   2 +-
 t/t7800-difftool.sh                           |  38 ++--
 t/t7810-grep.sh                               |  28 +--
 t/test-lib.sh                                 |   4 +-
 20 files changed, 285 insertions(+), 285 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 110b4bf459..72c9031934 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -603,7 +603,7 @@ test_expect_success 'same tree (merge and amend merge)' '
 	echo zero >zero &&
 	git add zero &&
 	git commit -m "add zero" &&
-	git checkout master &&
+	git checkout main &&
 
 	git merge -s ours side -m "empty ok" &&
 	git diff HEAD^ HEAD >actual &&
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 14c92e4c25..3956dcc237 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -76,7 +76,7 @@ test_expect_success 'output summary format for merges' '
 
 output_tests_cleanup() {
 	# this is needed for "do not fire editor in the presence of conflicts"
-	git checkout master &&
+	git checkout main &&
 
 	# this is needed for the "partial removal" test to pass
 	git rm file1 &&
@@ -440,7 +440,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	git add g &&
 	git commit -m "add g" &&
 	git branch second &&
-	echo master >g &&
+	echo main >g &&
 	echo g >h &&
 	git add g h &&
 	git commit -m "modify g and add h" &&
@@ -449,7 +449,7 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	git add g &&
 	git commit -m second &&
 	# Must fail due to conflict
-	test_must_fail git cherry-pick -n master &&
+	test_must_fail git cherry-pick -n main &&
 	echo "editor not started" >.git/result &&
 	(
 		GIT_EDITOR="\"$(pwd)/.git/FAKE_EDITOR\"" &&
@@ -478,9 +478,9 @@ git reset -q --hard
 
 test_expect_success 'Hand committing of a redundant merge removes dups' '
 
-	git rev-parse second master >expect &&
-	test_must_fail git merge second master &&
-	git checkout master g &&
+	git rev-parse second main >expect &&
+	test_must_fail git merge second main &&
+	git checkout main g &&
 	EDITOR=: git commit -a &&
 	git cat-file commit HEAD >raw &&
 	sed -n -e "s/^parent //p" -e "/^$/q" raw >actual &&
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..6ac12726d6 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -44,16 +44,16 @@ test_expect_success 'root commit' '
 	git add foo &&
 	git commit -m "make it non-ff" &&
 	git branch side-orig side &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'setup conflicting branches' '
-	test_when_finished "git checkout master" &&
-	git checkout -b conflicting-a master &&
+	test_when_finished "git checkout main" &&
+	git checkout -b conflicting-a main &&
 	echo a >conflicting &&
 	git add conflicting &&
 	git commit -m conflicting-a &&
-	git checkout -b conflicting-b master &&
+	git checkout -b conflicting-b main &&
 	echo b >conflicting &&
 	git add conflicting &&
 	git commit -m conflicting-b
@@ -71,8 +71,8 @@ test_expect_success 'with no hook (merge)' '
 	test_when_finished "rm -f actual_hooks" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge -m "merge master" master &&
-	git checkout master &&
+	git merge -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
@@ -88,8 +88,8 @@ test_expect_success '--no-verify with no hook (merge)' '
 	test_when_finished "rm -f actual_hooks" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge --no-verify -m "merge master" master &&
-	git checkout master &&
+	git merge --no-verify -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
@@ -108,15 +108,15 @@ test_expect_success 'with succeeding hook (merge)' '
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
-	git merge -m "merge master" master &&
-	git checkout master &&
+	git merge -m "merge main" main &&
+	git checkout main &&
 	test_cmp expected_hooks actual_hooks
 '
 
 test_expect_success 'automatic merge fails; both hooks are available' '
 	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	test_when_finished "git checkout master" &&
+	test_when_finished "git checkout main" &&
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
 	cp "$HOOKDIR/success.sample" "$PRECOMMIT" &&
 
@@ -145,8 +145,8 @@ test_expect_success '--no-verify with succeeding hook (merge)' '
 	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge --no-verify -m "merge master" master &&
-	git checkout master &&
+	git merge --no-verify -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
@@ -174,8 +174,8 @@ test_expect_success 'with failing hook (merge)' '
 	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
-	test_must_fail git merge -m "merge master" master &&
-	git checkout master &&
+	test_must_fail git merge -m "merge main" main &&
+	git checkout main &&
 	test_cmp expected_hooks actual_hooks
 '
 
@@ -184,8 +184,8 @@ test_expect_success '--no-verify with failing hook (merge)' '
 	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge --no-verify -m "merge master" master &&
-	git checkout master &&
+	git merge --no-verify -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
@@ -212,8 +212,8 @@ test_expect_success POSIXPERM 'with non-executable hook (merge)' '
 	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge -m "merge master" master &&
-	git checkout master &&
+	git merge -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
@@ -222,8 +222,8 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook (merge)' '
 	cp "$HOOKDIR/non-exec.sample" "$PREMERGE" &&
 	git branch -f side side-orig &&
 	git checkout side &&
-	git merge --no-verify -m "merge master" master &&
-	git checkout master &&
+	git merge --no-verify -m "merge main" main &&
+	git checkout main &&
 	test_path_is_missing actual_hooks
 '
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..2547362a39 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -142,12 +142,12 @@ test_expect_success '--no-verify with failing hook (editor)' '
 test_expect_success 'merge fails with failing hook' '
 
 	test_when_finished "git branch -D newbranch" &&
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout --orphan newbranch &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
-	test_must_fail git merge --allow-unrelated-histories master &&
+	test_must_fail git merge --allow-unrelated-histories main &&
 	commit_msg_is "in-side-branch" # HEAD before merge
 
 '
@@ -155,14 +155,14 @@ test_expect_success 'merge fails with failing hook' '
 test_expect_success 'merge bypasses failing hook with --no-verify' '
 
 	test_when_finished "git branch -D newbranch" &&
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout --orphan newbranch &&
 	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
-	git merge --no-verify --allow-unrelated-histories master &&
-	commit_msg_is "Merge branch '\''master'\'' into newbranch"
+	git merge --no-verify --allow-unrelated-histories main &&
+	commit_msg_is "Merge branch '\''main'\'' into newbranch"
 '
 
 
@@ -248,28 +248,28 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 
 test_expect_success 'hook called in git-merge picks up commit message' '
 	test_when_finished "git branch -D newbranch" &&
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout --orphan newbranch &&
 	git rm -f file &&
 	: >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
-	git merge --allow-unrelated-histories master &&
+	git merge --allow-unrelated-histories main &&
 	commit_msg_is "new message"
 '
 
 test_expect_failure 'merge --continue remembers --no-verify' '
 	test_when_finished "git branch -D newbranch" &&
-	test_when_finished "git checkout -f master" &&
-	git checkout master &&
+	test_when_finished "git checkout -f main" &&
+	git checkout main &&
 	echo a >file2 &&
 	git add file2 &&
-	git commit --no-verify -m "add file2 to master" &&
-	git checkout -b newbranch master^ &&
+	git commit --no-verify -m "add file2 to main" &&
+	git checkout -b newbranch main^ &&
 	echo b >file2 &&
 	git add file2 &&
 	git commit --no-verify file2 -m in-side-branch &&
-	git merge --no-verify -m not-rewritten-by-hook master &&
+	git merge --no-verify -m not-rewritten-by-hook main &&
 	# resolve conflict:
 	echo c >file2 &&
 	git add file2 &&
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 94f85cdf83..20b49629cd 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -15,7 +15,7 @@ test_expect_success 'set up commits for rebasing' '
 	do
 		test_commit rebase-$i c $i
 	done &&
-	git checkout master &&
+	git checkout main &&
 
 	cat >rebase-todo <<-EOF
 	pick $(git rev-parse rebase-a)
@@ -190,7 +190,7 @@ test_expect_success 'with hook (-c)' '
 
 test_expect_success 'with hook (merge)' '
 
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other HEAD@{1} &&
 	echo "more" >>file &&
 	git add file &&
@@ -202,7 +202,7 @@ test_expect_success 'with hook (merge)' '
 
 test_expect_success 'with hook and editor (merge)' '
 
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other HEAD@{1} &&
 	echo "more" >>file &&
 	git add file &&
@@ -218,7 +218,7 @@ test_rebase () {
 	test_expect_$expect C_LOCALE_OUTPUT "with hook (rebase ${mode:--i})" '
 		test_when_finished "\
 			git rebase --abort
-			git checkout -f master
+			git checkout -f main
 			git branch -D tmp" &&
 		git checkout -b tmp rebase-me &&
 		GIT_SEQUENCE_EDITOR="cp rebase-todo" &&
@@ -250,14 +250,14 @@ test_rebase success
 test_have_prereq !REBASE_P || test_rebase success -p
 
 test_expect_success 'with hook (cherry-pick)' '
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other b &&
 	git cherry-pick rebase-1 &&
 	test "$(git log -1 --pretty=format:%s)" = "message (no editor)"
 '
 
 test_expect_success 'with hook and editor (cherry-pick)' '
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other b &&
 	git cherry-pick -e rebase-1 &&
 	test "$(git log -1 --pretty=format:%s)" = merge
@@ -270,7 +270,7 @@ EOF
 
 test_expect_success 'with failing hook' '
 
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	head=$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
@@ -280,7 +280,7 @@ test_expect_success 'with failing hook' '
 
 test_expect_success 'with failing hook (--no-verify)' '
 
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	head=$(git rev-parse HEAD) &&
 	echo "more" >> file &&
 	git add file &&
@@ -290,7 +290,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 
 test_expect_success 'with failing hook (merge)' '
 
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other HEAD@{1} &&
 	echo "more" >> file &&
 	git add file &&
@@ -305,7 +305,7 @@ test_expect_success 'with failing hook (merge)' '
 '
 
 test_expect_success C_LOCALE_OUTPUT 'with failing hook (cherry-pick)' '
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git checkout -B other b &&
 	test_must_fail git cherry-pick rebase-1 2>actual &&
 	test $(grep -c prepare-commit-msg actual) = 1
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 963fed6821..d01aacb66b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -37,11 +37,11 @@ test_expect_success 'create upstream branch' '
 	git checkout -b upstream &&
 	test_commit upstream1 &&
 	test_commit upstream2 &&
-	# leave the first commit on master as root because several
+	# leave the first commit on main as root because several
 	# tests depend on this case; for our upstream we only
 	# care about commit counts anyway, so a totally divergent
 	# history is OK
-	git checkout --orphan master
+	git checkout --orphan main
 '
 
 test_expect_success 'setup' '
@@ -88,7 +88,7 @@ EOF
 
 test_expect_success 'status --column' '
 	cat >expect <<\EOF &&
-# On branch master
+# On branch main
 # Your branch and '\''upstream'\'' have diverged,
 # and have 1 and 2 different commits each, respectively.
 #   (use "git pull" to merge the remote branch into yours)
@@ -119,7 +119,7 @@ test_expect_success 'status --column status.displayCommentPrefix=false' '
 '
 
 cat >expect <<\EOF
-# On branch master
+# On branch main
 # Your branch and 'upstream' have diverged,
 # and have 1 and 2 different commits each, respectively.
 #   (use "git pull" to merge the remote branch into yours)
@@ -193,7 +193,7 @@ test_expect_success 'commit ignores status.displayCommentPrefix=false in COMMIT_
 '
 
 cat >expect <<\EOF
-On branch master
+On branch main
 Your branch and 'upstream' have diverged,
 and have 1 and 2 different commits each, respectively.
 
@@ -266,7 +266,7 @@ test_expect_success 'status with gitignore' '
 	test_cmp expect output &&
 
 	cat >expect <<\EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -331,7 +331,7 @@ test_expect_success 'status with gitignore (nothing untracked)' '
 	test_cmp expect output &&
 
 	cat >expect <<\EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -368,7 +368,7 @@ output*
 EOF
 
 cat >expect <<\EOF
-## master...upstream [ahead 1, behind 2]
+## main...upstream [ahead 1, behind 2]
  M dir1/modified
 A  dir2/added
 ?? dir1/untracked
@@ -401,7 +401,7 @@ test_expect_success 'setup dir3' '
 
 test_expect_success 'status -uno' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -429,7 +429,7 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 
 test_expect_success 'status -uno (advice.statusHints false)' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
 
@@ -463,7 +463,7 @@ test_expect_success 'status -s (status.showUntrackedFiles no)' '
 
 test_expect_success 'status -unormal' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -518,7 +518,7 @@ test_expect_success 'status -s (status.showUntrackedFiles normal)' '
 
 test_expect_success 'status -uall' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -578,7 +578,7 @@ test_expect_success 'status -s (status.showUntrackedFiles all)' '
 
 test_expect_success 'status with relative paths' '
 	cat >expect <<\EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -646,7 +646,7 @@ test_expect_success 'setup unique colors' '
 
 test_expect_success TTY 'status with color.ui' '
 	cat >expect <<\EOF &&
-On branch <GREEN>master<RESET>
+On branch <GREEN>main<RESET>
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -706,7 +706,7 @@ test_expect_success TTY 'status -s with color.status' '
 '
 
 cat >expect <<\EOF
-## <YELLOW>master<RESET>...<CYAN>upstream<RESET> [ahead <YELLOW>1<RESET>, behind <CYAN>2<RESET>]
+## <YELLOW>main<RESET>...<CYAN>upstream<RESET> [ahead <YELLOW>1<RESET>, behind <CYAN>2<RESET>]
  <RED>M<RESET> dir1/modified
 <GREEN>A<RESET>  dir2/added
 <BLUE>??<RESET> dir1/untracked
@@ -757,7 +757,7 @@ test_expect_success 'status --porcelain respects -b' '
 
 	git status --porcelain -b >output &&
 	{
-		echo "## master...upstream [ahead 1, behind 2]" &&
+		echo "## main...upstream [ahead 1, behind 2]" &&
 		cat expect
 	} >tmp &&
 	mv tmp expect &&
@@ -769,7 +769,7 @@ test_expect_success 'status --porcelain respects -b' '
 
 test_expect_success 'status without relative paths' '
 	cat >expect <<\EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -843,7 +843,7 @@ test_expect_success 'status -s without relative paths' '
 
 test_expect_success 'dry-run of partial commit excluding new file in index' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -897,7 +897,7 @@ test_expect_success 'setup status submodule summary' '
 
 test_expect_success 'status submodule summary is disabled by default' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -954,7 +954,7 @@ head=$(cd sm && git rev-parse --short=7 --verify HEAD)
 
 test_expect_success 'status submodule summary' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 1 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1013,7 +1013,7 @@ test_expect_success 'status -s submodule summary' '
 
 test_expect_success 'status submodule summary (clean submodule): commit' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1061,7 +1061,7 @@ test_expect_success 'status -z implies porcelain' '
 
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	cat >expect <<EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1113,7 +1113,7 @@ touch .gitmodules
 
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
 	cat > expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1222,7 +1222,7 @@ test_expect_success '.git/config ignore=dirty suppresses submodules with modifie
 
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
 	cat > expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1279,7 +1279,7 @@ head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --
 
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
 	cat > expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1360,7 +1360,7 @@ test_expect_success ".git/config ignore=dirty doesn't suppress submodule summary
 '
 
 cat > expect << EOF
-; On branch master
+; On branch main
 ; Your branch and 'upstream' have diverged,
 ; and have 2 and 2 different commits each, respectively.
 ;   (use "git pull" to merge the remote branch into yours)
@@ -1408,7 +1408,7 @@ test_expect_success "status (core.commentchar with two chars with submodule summ
 
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
 	cat > expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1434,7 +1434,7 @@ EOF
 
 test_expect_success '.gitmodules ignore=all suppresses unstaged submodule summary' '
 	cat > expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
@@ -1554,7 +1554,7 @@ test_expect_success 'git commit --dry-run will show a staged but ignored submodu
 	git reset HEAD^ &&
 	git add sm &&
 	cat >expect << EOF &&
-On branch master
+On branch main
 Your branch and '\''upstream'\'' have diverged,
 and have 2 and 2 different commits each, respectively.
   (use "git pull" to merge the remote branch into yours)
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 6baaa1ad91..0653fdcd02 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -25,7 +25,7 @@ test_expect_success GPG 'create signed commits' '
 	echo 3 >elif && git add elif &&
 	test_tick && git commit -m "third on side" &&
 
-	git checkout master &&
+	git checkout main &&
 	test_tick && git merge -S side &&
 	git tag merge &&
 
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 29518e0949..29aa9adcfd 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -17,14 +17,14 @@ test_expect_success 'prepare for conflicts' '
 	git config --global advice.statusuoption false &&
 	test_commit init main.txt init &&
 	git branch conflicts &&
-	test_commit on_master main.txt on_master &&
+	test_commit on_main main.txt on_main &&
 	git checkout conflicts &&
 	test_commit on_conflicts main.txt on_conflicts
 '
 
 
 test_expect_success 'status when conflicts unresolved' '
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	cat >expected <<\EOF &&
 On branch conflicts
 You have unmerged paths.
@@ -44,7 +44,7 @@ EOF
 
 test_expect_success 'status when conflicts resolved before commit' '
 	git reset --hard conflicts &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	echo one >main.txt &&
 	git add main.txt &&
 	cat >expected <<\EOF &&
@@ -63,7 +63,7 @@ EOF
 
 
 test_expect_success 'prepare for rebase conflicts' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b rebase_conflicts &&
 	test_commit one_rebase main.txt one &&
 	test_commit two_rebase main.txt two &&
@@ -118,11 +118,11 @@ EOF
 
 
 test_expect_success 'prepare for rebase_i_conflicts' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b rebase_i_conflicts &&
 	test_commit one_unmerge main.txt one_unmerge &&
 	git branch rebase_i_conflicts_second &&
-	test_commit one_master main.txt one_master &&
+	test_commit one_main main.txt one_main &&
 	git checkout rebase_i_conflicts_second &&
 	test_commit one_second main.txt one_second
 '
@@ -182,7 +182,7 @@ EOF
 
 
 test_expect_success 'status when rebasing -i in edit mode' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b rebase_i_edit &&
 	test_commit one_rebase_i main.txt one &&
 	test_commit two_rebase_i main.txt two &&
@@ -212,7 +212,7 @@ EOF
 
 
 test_expect_success 'status when splitting a commit' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b split_commit &&
 	test_commit one_split main.txt one &&
 	test_commit two_split main.txt two &&
@@ -251,7 +251,7 @@ EOF
 
 
 test_expect_success 'status after editing the last commit with --amend during a rebase -i' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b amend_last &&
 	test_commit one_amend main.txt one &&
 	test_commit two_amend main.txt two &&
@@ -284,7 +284,7 @@ EOF
 
 
 test_expect_success 'prepare for several edits' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b several_edits &&
 	test_commit one_edits main.txt one &&
 	test_commit two_edits main.txt two &&
@@ -593,7 +593,7 @@ EOF
 
 
 test_expect_success 'prepare am_session' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b am_session &&
 	test_commit one_am one.txt "one" &&
 	test_commit two_am two.txt "two" &&
@@ -666,7 +666,7 @@ EOF
 
 
 test_expect_success 'status when bisecting' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b bisect &&
 	test_commit one_bisect main.txt one &&
 	test_commit two_bisect main.txt two &&
@@ -689,7 +689,7 @@ EOF
 
 
 test_expect_success 'status when rebase --apply conflicts with statushints disabled' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b statushints_disabled &&
 	test_when_finished "git config --local advice.statushints true" &&
 	git config --local advice.statushints false &&
@@ -714,7 +714,7 @@ EOF
 
 
 test_expect_success 'prepare for cherry-pick conflicts' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b cherry_branch &&
 	test_commit one_cherry main.txt one &&
 	test_commit two_cherries main.txt two &&
@@ -825,7 +825,7 @@ EOF
 '
 
 test_expect_success 'status while reverting commit (conflicts)' '
-	git checkout master &&
+	git checkout main &&
 	echo before >to-revert.txt &&
 	test_commit before to-revert.txt &&
 	echo old >to-revert.txt &&
@@ -835,7 +835,7 @@ test_expect_success 'status while reverting commit (conflicts)' '
 	TO_REVERT=$(git rev-parse --short HEAD^) &&
 	test_must_fail git revert $TO_REVERT &&
 	cat >expected <<EOF &&
-On branch master
+On branch main
 You are currently reverting commit $TO_REVERT.
   (fix conflicts and run "git revert --continue")
   (use "git revert --skip" to skip this patch)
@@ -856,7 +856,7 @@ test_expect_success 'status while reverting commit (conflicts resolved)' '
 	echo reverted >to-revert.txt &&
 	git add to-revert.txt &&
 	cat >expected <<EOF &&
-On branch master
+On branch main
 You are currently reverting commit $TO_REVERT.
   (all conflicts fixed: run "git revert --continue")
   (use "git revert --skip" to skip this patch)
@@ -875,7 +875,7 @@ EOF
 test_expect_success 'status after reverting commit' '
 	git revert --continue &&
 	cat >expected <<\EOF &&
-On branch master
+On branch main
 nothing to commit (use -u to show untracked files)
 EOF
 	git status --untracked-files=no >actual &&
@@ -889,7 +889,7 @@ test_expect_success 'status while reverting after committing conflict resolution
 	echo reverted >to-revert.txt &&
 	git commit -a &&
 	cat >expected <<EOF &&
-On branch master
+On branch main
 Revert currently in progress.
   (run "git revert --continue" to continue)
   (use "git revert --skip" to skip this patch)
@@ -902,7 +902,7 @@ EOF
 '
 
 test_expect_success 'prepare for different number of commits rebased' '
-	git reset --hard master &&
+	git reset --hard main &&
 	git checkout -b several_commits &&
 	test_commit one_commit main.txt one &&
 	test_commit two_commit main.txt two &&
diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
index b2401cec3e..3a7723d16b 100755
--- a/t/t7517-per-repo-email.sh
+++ b/t/t7517-per-repo-email.sh
@@ -47,24 +47,24 @@ test_expect_success 'set up rebase scenarios' '
 
 test_expect_success 'fast-forward rebase does not care about ident' '
 	git checkout -B tmp side-without-commit &&
-	git rebase master
+	git rebase main
 '
 
 test_expect_success 'non-fast-forward rebase refuses to write commits' '
 	test_when_finished "git rebase --abort || true" &&
 	git checkout -B tmp side-with-commit &&
-	test_must_fail git rebase master
+	test_must_fail git rebase main
 '
 
 test_expect_success 'fast-forward rebase does not care about ident (interactive)' '
 	git checkout -B tmp side-without-commit &&
-	git rebase -i master
+	git rebase -i main
 '
 
 test_expect_success 'non-fast-forward rebase refuses to write commits (interactive)' '
 	test_when_finished "git rebase --abort || true" &&
 	git checkout -B tmp side-with-commit &&
-	test_must_fail git rebase -i master
+	test_must_fail git rebase -i main
 '
 
 test_expect_success 'noop interactive rebase does not care about ident' '
@@ -75,14 +75,14 @@ test_expect_success 'noop interactive rebase does not care about ident' '
 test_expect_success REBASE_P \
 	'fast-forward rebase does not care about ident (preserve)' '
 	git checkout -B tmp side-without-commit &&
-	git rebase -p master
+	git rebase -p main
 '
 
 test_expect_success REBASE_P \
 	'non-fast-forward rebase refuses to write commits (preserve)' '
 	test_when_finished "git rebase --abort || true" &&
 	git checkout -B tmp side-with-commit &&
-	test_must_fail git rebase -p master
+	test_must_fail git rebase -p main
 '
 
 test_expect_success 'author.name overrides user.name' '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1c85f75555..6feb8895f3 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -14,9 +14,9 @@ Testing basic merge operations/option parsing.
     ! [c4] c4
      ! [c5] c5
       ! [c6] c6
-       * [master] Merge commit 'c1'
+       * [main] Merge commit 'c1'
 --------
-       - [master] Merge commit 'c1'
+       - [main] Merge commit 'c1'
  +     * [c1] commit 1
       +  [c6] c6
      +   [c5] c5
@@ -203,13 +203,13 @@ test_expect_success 'merge c0 with c1 with --ff-only' '
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge from unborn branch' '
-	git checkout -f master &&
+	git checkout -f main &&
 	test_might_fail git branch -D kid &&
 
 	echo "OBJID HEAD@{0}: initial pull" >reflog.expected &&
 
 	git checkout --orphan kid &&
-	test_when_finished "git checkout -f master" &&
+	test_when_finished "git checkout -f main" &&
 	git rm -fr . &&
 	test_tick &&
 	git merge --ff-only c1 &&
@@ -413,7 +413,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (no-commit in config)' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "--no-commit" &&
+	test_config branch.main.mergeoptions "--no-commit" &&
 	git merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
@@ -427,7 +427,7 @@ test_expect_success 'merge c1 with c2 (log in config)' '
 	git merge --log c2 &&
 	git show -s --pretty=tformat:%s%n%b >expect &&
 
-	test_config branch.master.mergeoptions "--log" &&
+	test_config branch.main.mergeoptions "--log" &&
 	git reset --hard c1 &&
 	git merge c2 &&
 	git show -s --pretty=tformat:%s%n%b >actual &&
@@ -440,7 +440,7 @@ test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
 	git merge c2 &&
 	git show -s --pretty=tformat:%s%n%b >expect &&
 
-	test_config branch.master.mergeoptions "--no-log" &&
+	test_config branch.main.mergeoptions "--no-log" &&
 	test_config merge.log "true" &&
 	git reset --hard c1 &&
 	git merge c2 &&
@@ -451,7 +451,7 @@ test_expect_success 'merge c1 with c2 (log in config gets overridden)' '
 
 test_expect_success 'merge c1 with c2 (squash in config)' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "--squash" &&
+	test_config branch.main.mergeoptions "--squash" &&
 	git merge c2 &&
 	verify_merge file result.1-5 &&
 	verify_head $c1 &&
@@ -463,7 +463,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option -n with --summary' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "-n" &&
+	test_config branch.main.mergeoptions "-n" &&
 	test_tick &&
 	git merge --summary c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -477,7 +477,7 @@ test_expect_success 'override config option -n with --summary' '
 
 test_expect_success 'override config option -n with --stat' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "-n" &&
+	test_config branch.main.mergeoptions "-n" &&
 	test_tick &&
 	git merge --stat c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -493,7 +493,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'override config option --stat' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "--stat" &&
+	test_config branch.main.mergeoptions "--stat" &&
 	test_tick &&
 	git merge -n c2 >diffstat.txt &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -509,7 +509,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --no-commit)' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "--no-commit" &&
+	test_config branch.main.mergeoptions "--no-commit" &&
 	test_tick &&
 	git merge --commit c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -520,7 +520,7 @@ test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 (override --squash)' '
 	git reset --hard c1 &&
-	test_config branch.master.mergeoptions "--squash" &&
+	test_config branch.main.mergeoptions "--squash" &&
 	test_tick &&
 	git merge --no-squash c2 &&
 	verify_merge file result.1-5 msg.1-5 &&
@@ -549,9 +549,9 @@ test_expect_success 'merge c0 with c1 (merge.ff=false)' '
 '
 test_debug 'git log --graph --decorate --oneline --all'
 
-test_expect_success 'combine branch.master.mergeoptions with merge.ff' '
+test_expect_success 'combine branch.main.mergeoptions with merge.ff' '
 	git reset --hard c0 &&
-	test_config branch.master.mergeoptions "--ff" &&
+	test_config branch.main.mergeoptions "--ff" &&
 	test_config merge.ff "false" &&
 	test_tick &&
 	git merge c1 &&
@@ -593,7 +593,7 @@ test_expect_success 'option --no-ff overrides merge.ff=only config' '
 
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
 	git reset --hard c0 &&
-	test_config branch.master.mergeoptions "--no-ff" &&
+	test_config branch.main.mergeoptions "--no-ff" &&
 	git merge --ff c1 &&
 	verify_merge file result.1 &&
 	verify_head $c1
@@ -606,7 +606,7 @@ test_expect_success 'merge log message' '
 	test_must_be_empty msg.act &&
 
 	git reset --hard c0 &&
-	test_config branch.master.mergeoptions "--no-ff" &&
+	test_config branch.main.mergeoptions "--no-ff" &&
 	git merge --no-log c2 &&
 	git show -s --pretty=format:%b HEAD >msg.act &&
 	test_must_be_empty msg.act &&
@@ -950,10 +950,10 @@ test_expect_success 'set up mod-256 conflict scenario' '
 	git add file &&
 	git commit -m base &&
 
-	# one side changes the first line of each to "master"
-	sed s/-1/-master/ file >tmp &&
+	# one side changes the first line of each to "main"
+	sed s/-1/-main/ file >tmp &&
 	mv tmp file &&
-	git commit -am master &&
+	git commit -am main &&
 
 	# and the other to "side"; merging the two will
 	# yield 256 separate conflicts
@@ -965,12 +965,12 @@ test_expect_success 'set up mod-256 conflict scenario' '
 
 test_expect_success 'merge detects mod-256 conflicts (recursive)' '
 	git reset --hard &&
-	test_must_fail git merge -s recursive master
+	test_must_fail git merge -s recursive main
 '
 
 test_expect_success 'merge detects mod-256 conflicts (resolve)' '
 	git reset --hard &&
-	test_must_fail git merge -s resolve master
+	test_must_fail git merge -s resolve main
 '
 
 test_expect_success 'merge nothing into void' '
diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 8e8c4d7246..81fb7c474c 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -4,7 +4,7 @@ test_description="git merge
 
 Testing a custom strategy.
 
-*   (HEAD, master) Merge commit 'c3'
+*   (HEAD, main) Merge commit 'c3'
 |\
 | * (tag: c3) c3
 * | (tag: c1) c1
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 8e7e0a5865..d5e411daf5 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -10,51 +10,51 @@ check_oneline() {
 }
 
 test_expect_success 'merge local branch' '
-	test_commit master-1 &&
+	test_commit main-1 &&
 	git checkout -b local-branch &&
 	test_commit branch-1 &&
-	git checkout master &&
-	test_commit master-2 &&
+	git checkout main &&
+	test_commit main-2 &&
 	git merge local-branch &&
 	check_oneline "Merge branch Qlocal-branchQ"
 '
 
 test_expect_success 'merge octopus branches' '
-	git checkout -b octopus-a master &&
+	git checkout -b octopus-a main &&
 	test_commit octopus-1 &&
-	git checkout -b octopus-b master &&
+	git checkout -b octopus-b main &&
 	test_commit octopus-2 &&
-	git checkout master &&
+	git checkout main &&
 	git merge octopus-a octopus-b &&
 	check_oneline "Merge branches Qoctopus-aQ and Qoctopus-bQ"
 '
 
 test_expect_success 'merge tag' '
-	git checkout -b tag-branch master &&
+	git checkout -b tag-branch main &&
 	test_commit tag-1 &&
-	git checkout master &&
-	test_commit master-3 &&
+	git checkout main &&
+	test_commit main-3 &&
 	git merge tag-1 &&
 	check_oneline "Merge tag Qtag-1Q"
 '
 
 test_expect_success 'ambiguous tag' '
-	git checkout -b ambiguous master &&
+	git checkout -b ambiguous main &&
 	test_commit ambiguous &&
-	git checkout master &&
-	test_commit master-4 &&
+	git checkout main &&
+	test_commit main-4 &&
 	git merge ambiguous &&
 	check_oneline "Merge tag QambiguousQ"
 '
 
 test_expect_success 'remote-tracking branch' '
-	git checkout -b remote master &&
+	git checkout -b remote main &&
 	test_commit remote-1 &&
-	git update-ref refs/remotes/origin/master remote &&
-	git checkout master &&
-	test_commit master-5 &&
-	git merge origin/master &&
-	check_oneline "Merge remote-tracking branch Qorigin/masterQ"
+	git update-ref refs/remotes/origin/main remote &&
+	git checkout main &&
+	test_commit main-5 &&
+	git merge origin/main &&
+	check_oneline "Merge remote-tracking branch Qorigin/mainQ"
 '
 
 test_done
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 70afdd06fa..69ef7f7356 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,19 +10,19 @@ Testing basic merge tool invocation'
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
-# off 'branch1' and then merging in master and checking the results of
+# off 'branch1' and then merging in main and checking the results of
 # running mergetool
 
 test_expect_success 'setup' '
 	test_config rerere.enabled true &&
-	echo master >file1 &&
-	echo master spaced >"spaced name" &&
-	echo master file11 >file11 &&
-	echo master file12 >file12 &&
-	echo master file13 >file13 &&
-	echo master file14 >file14 &&
+	echo main >file1 &&
+	echo main spaced >"spaced name" &&
+	echo main file11 >file11 &&
+	echo main file12 >file12 &&
+	echo main file13 >file13 &&
+	echo main file14 >file14 &&
 	mkdir subdir &&
-	echo master sub >subdir/file3 &&
+	echo main sub >subdir/file3 &&
 	test_create_repo submod &&
 	(
 		cd submod &&
@@ -34,7 +34,7 @@ test_expect_success 'setup' '
 	git add file1 "spaced name" file1[1-4] subdir/file3 .gitmodules submod &&
 	git commit -m "add initial versions" &&
 
-	git checkout -b branch1 master &&
+	git checkout -b branch1 main &&
 	git submodule update -N &&
 	echo branch1 change >file1 &&
 	echo branch1 newfile >file2 &&
@@ -71,39 +71,39 @@ test_expect_success 'setup' '
 	test_write_lines one two 3 >c/c/file.txt &&
 	git commit -a -m"move to c" &&
 
-	git checkout -b stash1 master &&
+	git checkout -b stash1 main &&
 	echo stash1 change file11 >file11 &&
 	git add file11 &&
 	git commit -m "stash1 changes" &&
 
-	git checkout -b stash2 master &&
+	git checkout -b stash2 main &&
 	echo stash2 change file11 >file11 &&
 	git add file11 &&
 	git commit -m "stash2 changes" &&
 
-	git checkout master &&
+	git checkout main &&
 	git submodule update -N &&
-	echo master updated >file1 &&
-	echo master new >file2 &&
-	echo master updated spaced >"spaced name" &&
-	echo master both added >both &&
-	echo master updated file12 >file12 &&
-	echo master updated file14 >file14 &&
-	echo master new sub >subdir/file3 &&
+	echo main updated >file1 &&
+	echo main new >file2 &&
+	echo main updated spaced >"spaced name" &&
+	echo main both added >both &&
+	echo main updated file12 >file12 &&
+	echo main updated file14 >file14 &&
+	echo main new sub >subdir/file3 &&
 	(
 		cd submod &&
-		echo master submodule >bar &&
+		echo main submodule >bar &&
 		git add bar &&
-		git commit -m "Add bar on master" &&
-		git checkout -b submod-master
+		git commit -m "Add bar on main" &&
+		git checkout -b submod-main
 	) &&
 	git add file1 "spaced name" file12 file14 file2 subdir/file3 submod &&
 	git add both &&
 	git rm file11 &&
-	git commit -m "master updates" &&
+	git commit -m "main updates" &&
 
 	git clean -fdx &&
-	git checkout -b order-file-start master &&
+	git checkout -b order-file-start main &&
 	echo start >a &&
 	echo start >b &&
 	git add a b &&
@@ -130,7 +130,7 @@ test_expect_success 'custom mergetool' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	yes "" | git mergetool both &&
 	yes "" | git mergetool file1 file1 &&
 	yes "" | git mergetool file2 "spaced name" &&
@@ -138,11 +138,11 @@ test_expect_success 'custom mergetool' '
 	yes "d" | git mergetool file11 &&
 	yes "d" | git mergetool file12 &&
 	yes "l" | git mergetool submod &&
-	echo "master updated" >expect &&
+	echo "main updated" >expect &&
 	test_cmp expect file1 &&
-	echo "master new" >expect &&
+	echo "main new" >expect &&
 	test_cmp expect file2 &&
-	echo "master new sub" >expect &&
+	echo "main new sub" >expect &&
 	test_cmp expect subdir/file3 &&
 	echo "branch1 submodule" >expect &&
 	test_cmp expect submod/bar &&
@@ -156,7 +156,7 @@ test_expect_success 'gui mergetool' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	yes "" | git mergetool --gui both &&
 	yes "" | git mergetool -g file1 file1 &&
 	yes "" | git mergetool --gui file2 "spaced name" &&
@@ -164,11 +164,11 @@ test_expect_success 'gui mergetool' '
 	yes "d" | git mergetool --gui file11 &&
 	yes "d" | git mergetool --gui file12 &&
 	yes "l" | git mergetool --gui submod &&
-	echo "gui master updated" >expect &&
+	echo "gui main updated" >expect &&
 	test_cmp expect file1 &&
-	echo "gui master new" >expect &&
+	echo "gui main new" >expect &&
 	test_cmp expect file2 &&
-	echo "gui master new sub" >expect &&
+	echo "gui main new sub" >expect &&
 	test_cmp expect subdir/file3 &&
 	echo "branch1 submodule" >expect &&
 	test_cmp expect submod/bar &&
@@ -179,7 +179,7 @@ test_expect_success 'gui mergetool without merge.guitool set falls back to merge
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	yes "" | git mergetool --gui both &&
 	yes "" | git mergetool -g file1 file1 &&
 	yes "" | git mergetool --gui file2 "spaced name" &&
@@ -187,11 +187,11 @@ test_expect_success 'gui mergetool without merge.guitool set falls back to merge
 	yes "d" | git mergetool --gui file11 &&
 	yes "d" | git mergetool --gui file12 &&
 	yes "l" | git mergetool --gui submod &&
-	echo "master updated" >expect &&
+	echo "main updated" >expect &&
 	test_cmp expect file1 &&
-	echo "master new" >expect &&
+	echo "main new" >expect &&
 	test_cmp expect file2 &&
-	echo "master new sub" >expect &&
+	echo "main new sub" >expect &&
 	test_cmp expect subdir/file3 &&
 	echo "branch1 submodule" >expect &&
 	test_cmp expect submod/bar &&
@@ -206,7 +206,7 @@ test_expect_success 'mergetool crlf' '
 	# test_when_finished is LIFO.)
 	test_config core.autocrlf true &&
 	git checkout -b test$test_count branch1 &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	yes "" | git mergetool file1 &&
 	yes "" | git mergetool file2 &&
 	yes "" | git mergetool "spaced name" &&
@@ -215,11 +215,11 @@ test_expect_success 'mergetool crlf' '
 	yes "d" | git mergetool file11 &&
 	yes "d" | git mergetool file12 &&
 	yes "r" | git mergetool submod &&
-	test "$(printf x | cat file1 -)" = "$(printf "master updated\r\nx")" &&
-	test "$(printf x | cat file2 -)" = "$(printf "master new\r\nx")" &&
-	test "$(printf x | cat subdir/file3 -)" = "$(printf "master new sub\r\nx")" &&
+	test "$(printf x | cat file1 -)" = "$(printf "main updated\r\nx")" &&
+	test "$(printf x | cat file2 -)" = "$(printf "main new\r\nx")" &&
+	test "$(printf x | cat subdir/file3 -)" = "$(printf "main new sub\r\nx")" &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git commit -m "branch1 resolved with mergetool - autocrlf"
 '
@@ -230,9 +230,9 @@ test_expect_success 'mergetool in subdir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_must_fail git merge main &&
 		yes "" | git mergetool file3 &&
-		echo "master new sub" >expect &&
+		echo "main new sub" >expect &&
 		test_cmp expect file3
 	)
 '
@@ -243,7 +243,7 @@ test_expect_success 'mergetool on file in parent dir' '
 	git submodule update -N &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_must_fail git merge main &&
 		yes "" | git mergetool file3 &&
 		yes "" | git mergetool ../file1 &&
 		yes "" | git mergetool ../file2 ../spaced\ name &&
@@ -251,9 +251,9 @@ test_expect_success 'mergetool on file in parent dir' '
 		yes "d" | git mergetool ../file11 &&
 		yes "d" | git mergetool ../file12 &&
 		yes "l" | git mergetool ../submod &&
-		echo "master updated" >expect &&
+		echo "main updated" >expect &&
 		test_cmp expect ../file1 &&
-		echo "master new" >expect &&
+		echo "main new" >expect &&
 		test_cmp expect ../file2 &&
 		echo "branch1 submodule" >expect &&
 		test_cmp expect ../submod/bar &&
@@ -265,7 +265,7 @@ test_expect_success 'mergetool skips autoresolved' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "d" | git mergetool file11 &&
 	yes "d" | git mergetool file12 &&
@@ -280,17 +280,17 @@ test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	test_config rerere.enabled false &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_must_fail git merge main &&
 		yes "r" | git mergetool ../submod &&
 		yes "d" "d" | git mergetool --no-prompt &&
-		echo "master updated" >expect &&
+		echo "main updated" >expect &&
 		test_cmp expect ../file1 &&
-		echo "master new" >expect &&
+		echo "main new" >expect &&
 		test_cmp expect ../file2 &&
-		echo "master new sub" >expect &&
+		echo "main new sub" >expect &&
 		test_cmp expect file3 &&
 		( cd .. && git submodule update -N ) &&
-		echo "master submodule" >expect &&
+		echo "main submodule" >expect &&
 		test_cmp expect ../submod/bar &&
 		git commit -m "branch2 resolved by mergetool from subdir"
 	)
@@ -303,17 +303,17 @@ test_expect_success 'mergetool merges all from subdir (rerere enabled)' '
 	rm -rf .git/rr-cache &&
 	(
 		cd subdir &&
-		test_must_fail git merge master &&
+		test_must_fail git merge main &&
 		yes "r" | git mergetool ../submod &&
 		yes "d" "d" | git mergetool --no-prompt &&
-		echo "master updated" >expect &&
+		echo "main updated" >expect &&
 		test_cmp expect ../file1 &&
-		echo "master new" >expect &&
+		echo "main new" >expect &&
 		test_cmp expect ../file2 &&
-		echo "master new sub" >expect &&
+		echo "main new sub" >expect &&
 		test_cmp expect file3 &&
 		( cd .. && git submodule update -N ) &&
-		echo "master submodule" >expect &&
+		echo "main submodule" >expect &&
 		test_cmp expect ../submod/bar &&
 		git commit -m "branch2 resolved by mergetool from subdir"
 	)
@@ -325,7 +325,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	rm -rf .git/rr-cache &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	yes "l" | git mergetool --no-prompt submod &&
 	yes "d" "d" | git mergetool --no-prompt &&
 	git submodule update -N &&
@@ -366,11 +366,11 @@ test_expect_success 'mergetool takes partial path' '
 	test_config rerere.enabled false &&
 	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 
 	yes "" | git mergetool subdir &&
 
-	echo "master new sub" >expect &&
+	echo "main new sub" >expect &&
 	test_cmp expect subdir/file3
 '
 
@@ -434,7 +434,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git rm --cached submod &&
 	git commit -m "Submodule deleted from branch" &&
 	git checkout -b test$test_count.a test$test_count &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
@@ -444,7 +444,7 @@ test_expect_success 'deleted vs modified submodule' '
 	echo "branch1 submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -453,7 +453,7 @@ test_expect_success 'deleted vs modified submodule' '
 	mv submod submod-movedaside &&
 	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
@@ -465,7 +465,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 
 	mv submod-movedaside submod &&
-	git checkout -b test$test_count.c master &&
+	git checkout -b test$test_count.c main &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
@@ -481,7 +481,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 	mv submod.orig submod &&
 
-	git checkout -b test$test_count.d master &&
+	git checkout -b test$test_count.d main &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
@@ -489,10 +489,10 @@ test_expect_success 'deleted vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -509,7 +509,7 @@ test_expect_success 'file vs modified submodule' '
 	git add submod &&
 	git commit -m "Submodule path becomes file" &&
 	git checkout -b test$test_count.a branch1 &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
@@ -519,7 +519,7 @@ test_expect_success 'file vs modified submodule' '
 	echo "branch1 submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -527,7 +527,7 @@ test_expect_success 'file vs modified submodule' '
 
 	mv submod submod-movedaside &&
 	git checkout -b test$test_count.b test$test_count &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
@@ -547,7 +547,7 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test$test_count.c master &&
+	git checkout -b test$test_count.c main &&
 	rmdir submod && mv submod-movedaside submod &&
 	test ! -e submod.orig &&
 	git submodule update -N &&
@@ -573,7 +573,7 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test$test_count.d master &&
+	git checkout -b test$test_count.d main &&
 	rmdir submod && mv submod.orig submod &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
@@ -586,10 +586,10 @@ test_expect_success 'file vs modified submodule' '
 	then
 		yes "d" | git mergetool submod~test19
 	fi &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	output="$(git mergetool --no-prompt)" &&
 	test "$output" = "No files need merging" &&
@@ -672,7 +672,7 @@ test_expect_success 'directory vs modified submodule' '
 	git add submod/file16 &&
 	git commit -m "Submodule path becomes directory" &&
 
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	yes "l" | git mergetool submod &&
 	echo "not a submodule" >expect &&
@@ -680,14 +680,14 @@ test_expect_success 'directory vs modified submodule' '
 	rm -rf submod.orig &&
 
 	git reset --hard &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		yes "r" | git mergetool submod~master &&
+		yes "r" | git mergetool submod~main &&
 		git mv submod submod.orig &&
-		git mv submod~master submod
+		git mv submod~main submod
 	else
 		yes "r" | git mergetool submod
 	fi &&
@@ -698,18 +698,18 @@ test_expect_success 'directory vs modified submodule' '
 	mv submod-movedaside/.git submod &&
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git reset --hard &&
 	rm -rf submod-movedaside &&
 
-	git checkout -b test$test_count.c master &&
+	git checkout -b test$test_count.c main &&
 	git submodule update -N &&
 	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	yes "l" | git mergetool submod &&
 	git submodule update -N &&
-	echo "master submodule" >expect &&
+	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 
 	git reset --hard &&
@@ -721,7 +721,7 @@ test_expect_success 'directory vs modified submodule' '
 	echo "not a submodule" >expect &&
 	test_cmp expect submod/file16 &&
 
-	git reset --hard master &&
+	git reset --hard main &&
 	( cd submod && git clean -f && git reset --hard ) &&
 	git submodule update -N
 '
@@ -729,7 +729,7 @@ test_expect_success 'directory vs modified submodule' '
 test_expect_success 'file with no base' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	test_must_be_empty both
 '
@@ -739,9 +739,9 @@ test_expect_success 'custom commands override built-ins' '
 	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool defaults -- both &&
-	echo master both added >expected &&
+	echo main both added >expected &&
 	test_cmp expected both
 '
 
@@ -751,7 +751,7 @@ test_expect_success 'filenames seen by tools start with ./' '
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	grep ^\./both_LOCAL_ actual
 '
@@ -768,7 +768,7 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-	test_must_fail git merge master &&
+	test_must_fail git merge main &&
 	git mergetool --no-prompt --tool myecho -- both >actual &&
 	! grep ^\./both_LOCAL_ actual &&
 	grep /both_LOCAL_ actual
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index 7c84a518aa..8e95182566 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -7,7 +7,7 @@ Set up repo with conflicting and non-conflicting branches:
 There are three files foo/bar/baz, and the following graph illustrates the
 content of these files in each commit:
 
-# foo/bar/baz --- foo/bar/bazz     <-- master
+# foo/bar/baz --- foo/bar/bazz     <-- main
 #             \
 #              --- foo/barf/bazf   <-- conflict_branch
 #               \
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 	git checkout -b clean_branch HEAD^ &&
 	echo bart > bar &&
 	git commit -a -m "clean" &&
-	git checkout master
+	git checkout main
 '
 
 pre_merge_head="$(git rev-parse HEAD)"
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-signatures.sh
index a426f3a89a..6c52b6ac1e 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -31,7 +31,7 @@ test_expect_success GPG 'create signed commits' '
 	echo 3 >baz && git add baz &&
 	test_tick && git commit -SB7227189 -m "untrusted on side" &&
 
-	git checkout master
+	git checkout main
 '
 
 test_expect_success GPG 'merge unsigned commit with verification' '
diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
index c1b8446f49..1e901224cd 100755
--- a/t/t7614-merge-signoff.sh
+++ b/t/t7614-merge-signoff.sh
@@ -11,17 +11,17 @@ This test runs git merge --signoff and makes sure that it works.
 test_setup() {
 	# Expected commit message after merge --signoff
 	cat >expected-signed <<EOF &&
-Merge branch 'master' into other-branch
+Merge branch 'main' into other-branch
 
 Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
 EOF
 
 	# Expected commit message after merge without --signoff (or with --no-signoff)
 	cat >expected-unsigned <<EOF &&
-Merge branch 'master' into other-branch
+Merge branch 'main' into other-branch
 EOF
 
-	# Initial commit and feature branch to merge master into it.
+	# Initial commit and feature branch to merge main into it.
 	git commit --allow-empty -m "Initial empty commit" &&
 	git checkout -b other-branch &&
 	test_commit other-branch file1 1
@@ -38,30 +38,30 @@ test_expect_success 'setup' '
 
 # Test with --signoff flag
 test_expect_success 'git merge --signoff adds a sign-off line' '
-	git checkout master &&
-	test_commit master-branch-2 file2 2 &&
+	git checkout main &&
+	test_commit main-branch-2 file2 2 &&
 	git checkout other-branch &&
-	git merge master --signoff --no-edit &&
+	git merge main --signoff --no-edit &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	test_cmp expected-signed actual
 '
 
 # Test without --signoff flag
 test_expect_success 'git merge does not add a sign-off line' '
-	git checkout master &&
-	test_commit master-branch-3 file3 3 &&
+	git checkout main &&
+	test_commit main-branch-3 file3 3 &&
 	git checkout other-branch &&
-	git merge master --no-edit &&
+	git merge main --no-edit &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	test_cmp expected-unsigned actual
 '
 
 # Test for --no-signoff flag
 test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
-	git checkout master &&
-	test_commit master-branch-4 file4 4 &&
+	git checkout main &&
+	test_commit main-branch-4 file4 4 &&
 	git checkout other-branch &&
-	git merge master --no-edit --signoff --no-signoff &&
+	git merge main --no-edit --signoff --no-signoff &&
 	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	test_cmp expected-unsigned actual
 '
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 48261ba080..852c81d13e 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -22,7 +22,7 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
 	git commit -a -m more_content &&
 	csha1=$(git rev-parse HEAD^{commit}) &&
 	tsha1=$(git rev-parse HEAD^{tree}) &&
-	git checkout master &&
+	git checkout main &&
 	echo even more content >> file1 &&
 	test_tick &&
 	git commit -a -m even_more_content &&
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a578b35761..31e719e361 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -35,23 +35,23 @@ test_expect_success 'basic usage requires no repo' '
 	test_i18ngrep ^usage: output
 '
 
-# Create a file on master and change it on branch
+# Create a file on main and change it on branch
 test_expect_success 'setup' '
-	echo master >file &&
+	echo main >file &&
 	git add file &&
 	git commit -m "added file" &&
 
-	git checkout -b branch master &&
+	git checkout -b branch main &&
 	echo branch >file &&
 	git commit -a -m "branch changed file" &&
-	git checkout master
+	git checkout main
 '
 
 # Configure a custom difftool.<tool>.cmd and use it
 test_expect_success 'custom commands' '
 	difftool_test_setup &&
 	test_config difftool.test-tool.cmd "cat \"\$REMOTE\"" &&
-	echo master >expect &&
+	echo main >expect &&
 	git difftool --no-prompt branch >actual &&
 	test_cmp expect actual &&
 
@@ -63,7 +63,7 @@ test_expect_success 'custom commands' '
 
 test_expect_success 'custom tool commands override built-ins' '
 	test_config difftool.vimdiff.cmd "cat \"\$REMOTE\"" &&
-	echo master >expect &&
+	echo main >expect &&
 	git difftool --tool vimdiff --no-prompt branch >actual &&
 	test_cmp expect actual
 '
@@ -311,21 +311,21 @@ test_expect_success 'difftool.<tool>.path' '
 
 test_expect_success 'difftool --extcmd=cat' '
 	echo branch >expect &&
-	echo master >>expect &&
+	echo main >>expect &&
 	git difftool --no-prompt --extcmd=cat branch >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'difftool --extcmd cat' '
 	echo branch >expect &&
-	echo master >>expect &&
+	echo main >>expect &&
 	git difftool --no-prompt --extcmd=cat branch >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'difftool -x cat' '
 	echo branch >expect &&
-	echo master >>expect &&
+	echo main >>expect &&
 	git difftool --no-prompt -x cat branch >actual &&
 	test_cmp expect actual
 '
@@ -338,7 +338,7 @@ test_expect_success 'difftool --extcmd echo arg1' '
 '
 
 test_expect_success 'difftool --extcmd cat arg1' '
-	echo master >expect &&
+	echo main >expect &&
 	git difftool --no-prompt \
 		--extcmd sh\ -c\ \"cat\ \$1\" branch >actual &&
 	test_cmp expect actual
@@ -351,7 +351,7 @@ test_expect_success 'difftool --extcmd cat arg2' '
 	test_cmp expect actual
 '
 
-# Create a second file on master and a different version on branch
+# Create a second file on main and a different version on branch
 test_expect_success 'setup with 2 files different' '
 	echo m2 >file2 &&
 	git add file2 &&
@@ -361,7 +361,7 @@ test_expect_success 'setup with 2 files different' '
 	echo br2 >file2 &&
 	git add file2 &&
 	git commit -a -m "branch changed file2" &&
-	git checkout master
+	git checkout main
 '
 
 test_expect_success 'say no to the first file' '
@@ -369,14 +369,14 @@ test_expect_success 'say no to the first file' '
 	git difftool -x cat branch <input >output &&
 	grep m2 output &&
 	grep br2 output &&
-	! grep master output &&
+	! grep main output &&
 	! grep branch output
 '
 
 test_expect_success 'say no to the second file' '
 	(echo && echo n) >input &&
 	git difftool -x cat branch <input >output &&
-	grep master output &&
+	grep main output &&
 	grep branch output &&
 	! grep m2 output &&
 	! grep br2 output
@@ -384,7 +384,7 @@ test_expect_success 'say no to the second file' '
 
 test_expect_success 'ending prompt input with EOF' '
 	git difftool -x cat branch </dev/null >output &&
-	! grep master output &&
+	! grep main output &&
 	! grep branch output &&
 	! grep m2 output &&
 	! grep br2 output
@@ -396,9 +396,9 @@ test_expect_success 'difftool --tool-help' '
 '
 
 test_expect_success 'setup change in subdirectory' '
-	git checkout master &&
+	git checkout main &&
 	mkdir sub &&
-	echo master >sub/sub &&
+	echo main >sub/sub &&
 	git add sub/sub &&
 	git commit -m "added sub/sub" &&
 	git tag v1 &&
@@ -526,7 +526,7 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
 run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
 	test_when_finished git reset --hard &&
 	rm file2 &&
-	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
+	git difftool --dir-diff $symlinks --extcmd ls branch main >output &&
 	grep file2 output
 '
 
@@ -543,7 +543,7 @@ run_dir_diff_test 'difftool --dir-diff with unmerged files' '
 	echo b >>file &&
 	git add file &&
 	git commit -m conflict-b &&
-	git checkout master &&
+	git checkout main &&
 	git merge conflict-a &&
 	test_must_fail git merge conflict-b &&
 	cat >expect <<-EOF &&
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 991d5bd9c0..bee57a4e08 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1206,19 +1206,19 @@ test_expect_success 'grep -e -- -- path' '
 '
 
 test_expect_success 'dashdash disambiguates rev as rev' '
-	test_when_finished "rm -f master" &&
-	echo content >master &&
-	echo master:hello.c >expect &&
-	git grep -l o master -- hello.c >actual &&
+	test_when_finished "rm -f main" &&
+	echo content >main &&
+	echo main:hello.c >expect &&
+	git grep -l o main -- hello.c >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'dashdash disambiguates pathspec as pathspec' '
-	test_when_finished "git rm -f master" &&
-	echo content >master &&
-	git add master &&
-	echo master:content >expect &&
-	git grep o -- master >actual &&
+	test_when_finished "git rm -f main" &&
+	echo content >main &&
+	git add main &&
+	echo main:content >expect &&
+	git grep o -- main >actual &&
 	test_cmp expect actual
 '
 
@@ -1254,15 +1254,15 @@ test_expect_success 'grep --no-index pattern -- path' '
 '
 
 test_expect_success 'grep --no-index complains of revs' '
-	test_must_fail git grep --no-index o master -- 2>err &&
+	test_must_fail git grep --no-index o main -- 2>err &&
 	test_i18ngrep "cannot be used with revs" err
 '
 
 test_expect_success 'grep --no-index prefers paths to revs' '
-	test_when_finished "rm -f master" &&
-	echo content >master &&
-	echo master:content >expect &&
-	git grep --no-index o master >actual &&
+	test_when_finished "rm -f main" &&
+	echo content >main &&
+	echo main:content >expect &&
+	git grep --no-index o main >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 815d7b21fe..2ef51a4f3f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -257,13 +257,13 @@ case "$TRASH_DIRECTORY" in
 esac
 
 case "$TEST_NUMBER" in
-3404|4013|5310|6300|7064)
+3404|4013|5310|6300|7064|7817)
 	# Avoid conflicts with patch series that are cooking at the same time
 	# as the patch series changing the default of `init.defaultBranch`.
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-[0-6]*|7[0-4]*)
+[0-7]*)
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 	;;
-- 
gitgitgadget

