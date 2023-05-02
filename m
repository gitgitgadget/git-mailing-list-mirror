Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D80C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 06:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjEBG15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 02:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBG1z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 02:27:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D990E49
        for <git@vger.kernel.org>; Mon,  1 May 2023 23:27:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f18dacd392so19118345e9.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 23:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683008872; x=1685600872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Di9I2MqQb0X9AU7+6W43pUK+g2YoFhgvIm6EImPyY9k=;
        b=qlyaXtMkEcuWVeomMYEzqzM8Xm/zREVmqEXIRolEKSI3Gldt/2Qx2SHkkhK1B8B8CW
         s5vcVz6kN1ZexRJSZ3cvmYqwcEze6vHaRph226u0+wbEjywQ72GSPZmqUbCi8pUbipA5
         qaII2h9bz9lOwx2ec/zhRO/oVbLLckgnJwdVmPv4hFM9rxMHUL9P/lr79pibbq3lM1Bm
         eNxhppSvP8dAcBW2s/XxVnp/gYVakflCLdg8Bhcihd7OmPoyqLiJh08xA1zUdRqDzhm8
         zr8CxlT+HJ10UmZNNjJPpuZkltSt5Nis4IBTBIbIFAFe0zFRcx/WrT1YpRi+uNyi2l7E
         6fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683008872; x=1685600872;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di9I2MqQb0X9AU7+6W43pUK+g2YoFhgvIm6EImPyY9k=;
        b=A8cWCgCaWIrRCZ3EcgBzTyiBzcx/GedHkH5c9asdNLLAH718vUfJxPrHL1FSAGAGtj
         z092xgCNNijIHM8PIDTVXJSfKtl7l1bhx0hVHbaapoonKrXpwSKyMFhTC0/5JYKIapeu
         Uf7HhtYHsOYGmwlmmgw4+CWbR+tNxhT1OkQyMKaOZFJNZkYoNpHu9zcZ7JIDvhDvCwIG
         IOLpsHdk8787RdF5j6GUhUTAQKvXv8BTQJPK97ulR40GTKq/qy7UyouNifbbIjYa0aMi
         CzgHCaskTtkO18JdFhFx+3RTt3rlMRUKwgH6trGDWx4x1V5FO+nqclhVEFhrbOGBF6xk
         mvig==
X-Gm-Message-State: AC+VfDzNiKZJxswbnNnmzCXe2uzusjDZlrIXDXnYvH3VIo8Rv/1hhGtT
        u1P9SkAFM78uUzAgNQflcVXU/u5DJg4=
X-Google-Smtp-Source: ACHHUZ5wI8Nb68fjtD3U3mcDCBsOzLXIBtysg8jMtUEUnPLYV6U8cLQhk/2YBzzHpGVISXF2+dBZnA==
X-Received: by 2002:a5d:67d1:0:b0:306:368d:8a1c with SMTP id n17-20020a5d67d1000000b00306368d8a1cmr876962wrw.45.1683008871563;
        Mon, 01 May 2023 23:27:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ef64affec7sm34307245wmg.22.2023.05.01.23.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 23:27:51 -0700 (PDT)
Message-Id: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 May 2023 06:27:49 +0000
Subject: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

When a "git checkout" branch-switch operation runs during a merge, the
in-progress merge metadata is removed. The refusal to maintain the merge
matadata makes sense if the new commit is different to the original commit,
because a merge operation against a different commit could have turned out
differently / maintaining the merge relationship would be misleading. It is
still a difficult-to-understand behavior for new users, however, as they
would expect a switch (to a new or same-commit branch at least) to allow
committing local changes "faithfully", as in the case of regular non-merge
local changes.

"git switch" introduces a little more safety, by refusing to switch if there
is a merge in progress - or a number of other operations such as rebase,
cherry-pick, or "git am". This is less of a nasty surprise than the merge
metadata/state being silently discarded, but is still not very helpful, when
a user has a complex merge resolved, and wishes to commit it to a new branch
for testing.

Change the behavior of "git switch" and "git checkout" to no longer delete
merge metadata, nor prohibit the switch, if a merge is in progress and the
commit being switched to is the same commit the HEAD was previously set to.

Also add a warning when the merge metadata is deleted (in case of a
"git checkout" to another commit) to let the user know the merge state
was lost, and that "git switch" would prevent this.

Also add a warning when the merge metadata is preserved (same commit),
to let the user know the commit message prepared for the merge may still
refer to the previous branch.

Add tests to verify the exception works correctly, and to verify that
--force always wipes out in-progress merge metadata when it is discarding
worktree changes.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: switch: allow same-commit switch during merge if conflicts resolved
    
    RFC V1: proposing a limited-scope change as per mailing discussion
    https://lore.kernel.org/git/CAPMMpoht4FWnv-WuSM3+Z2R4HhwFY+pahJ6zirFU-BD5r34B7Q@mail.gmail.com/T/#t

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1527%2FTaoK%2Ftao-checkout-during-merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1527/TaoK/tao-checkout-during-merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1527

 branch.c           |  7 ++++-
 branch.h           |  6 +++++
 builtin/checkout.c | 64 ++++++++++++++++++++++++++++++++++++++++++----
 t/t2060-switch.sh  | 18 ++++++++++++-
 4 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 5aaf073dce1..8cc7fabe599 100644
--- a/branch.c
+++ b/branch.c
@@ -812,10 +812,15 @@ void remove_merge_branch_state(struct repository *r)
 }
 
 void remove_branch_state(struct repository *r, int verbose)
+{
+	remove_branch_state_except_merge(r, verbose);
+	remove_merge_branch_state(r);
+}
+
+void remove_branch_state_except_merge(struct repository *r, int verbose)
 {
 	sequencer_post_commit_cleanup(r, verbose);
 	unlink(git_path_squash_msg(r));
-	remove_merge_branch_state(r);
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index ef56103c050..c73d98b8766 100644
--- a/branch.h
+++ b/branch.h
@@ -135,6 +135,12 @@ void remove_merge_branch_state(struct repository *r);
  */
 void remove_branch_state(struct repository *r, int verbose);
 
+/*
+ * Remove information about the state of working on the current
+ * branch, *except* merge state.
+ */
+void remove_branch_state_except_merge(struct repository *r, int verbose);
+
 /*
  * Configure local branch "local" as downstream to branch "remote"
  * from remote "origin".  Used by git branch --set-upstream.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 21a4335abb0..cae54af997b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -985,7 +985,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				delete_reflog(old_branch_info->path);
 		}
 	}
-	remove_branch_state(the_repository, !opts->quiet);
+
+	remove_branch_state_except_merge(the_repository, !opts->quiet);
+	if (opts->force || old_branch_info->commit != new_branch_info->commit) {
+		remove_merge_branch_state(the_repository);
+	}
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
@@ -1098,6 +1102,36 @@ static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
 	release_revisions(&revs);
 }
 
+/*
+ * Check whether we're in a merge, and if so warn - about the ongoing merge and surprising merge
+ * message if the merge state will be preserved, and about the destroyed merge state otherwise.
+ */
+static void merging_checkout_warning(const char *name, struct commit *old_commit,
+				      struct commit *new_commit)
+{
+	struct wt_status_state state;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(the_repository, &state, 0);
+
+	if (!state.merge_in_progress)
+	{
+		wt_status_state_free_buffers(&state);
+		return;
+	}
+
+	if (old_commit == new_commit)
+		warning(_("switching while merge-in-progress (without changing commit).\n"
+			  "An auto-generated commit message may still refer to the previous\n"
+			  "branch.\n"));
+	else
+		warning(_("switching to a different commit while while merge-in-progress;\n"
+			  "merge metadata was removed. To avoid accidentally losing merge,\n"
+			  "metadata in this way, please use \"git switch\" instead of\n"
+			  "\"git checkout\".\n"));
+
+	wt_status_state_free_buffers(&state);
+}
+
 static int switch_branches(const struct checkout_opts *opts,
 			   struct branch_info *new_branch_info)
 {
@@ -1153,6 +1187,9 @@ static int switch_branches(const struct checkout_opts *opts,
 	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
 		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
 
+	if (!opts->quiet && !opts->force)
+		merging_checkout_warning(old_branch_info.name, old_branch_info.commit, new_branch_info->commit);
+
 	update_refs_for_switch(opts, &old_branch_info, new_branch_info);
 
 	ret = post_checkout_hook(old_branch_info.commit, new_branch_info->commit, 1);
@@ -1445,15 +1482,31 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 	exit(code);
 }
 
-static void die_if_some_operation_in_progress(void)
+static void die_if_some_incompatible_operation_in_progress(struct commit *new_commit)
 {
+	/*
+	 * Note: partially coordinated logic in related function
+	 * merging_checkout_warning(), checking for merge_in_progress
+	 * and old_commit != new_commit to issue warnings. Issuing those
+	 * warnings here would be simpler to implement, but would make the
+	 * language more complex to account for common situations where the
+	 * switch still won't happen (namely working tree merge failure).
+	 */
+
 	struct wt_status_state state;
+	struct branch_info old_branch_info = { 0 };
+	struct object_id rev;
+	int flag;
 
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(the_repository, &state, 0);
+	memset(&old_branch_info, 0, sizeof(old_branch_info));
+	old_branch_info.path = resolve_refdup("HEAD", 0, &rev, &flag);
+	if (old_branch_info.path)
+		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
 
-	if (state.merge_in_progress)
-		die(_("cannot switch branch while merging\n"
+	if (state.merge_in_progress && old_branch_info.commit != new_commit)
+		die(_("cannot switch to a different commit while merging\n"
 		      "Consider \"git merge --quit\" "
 		      "or \"git worktree add\"."));
 	if (state.am_in_progress)
@@ -1476,6 +1529,7 @@ static void die_if_some_operation_in_progress(void)
 		warning(_("you are switching branch while bisecting"));
 
 	wt_status_state_free_buffers(&state);
+	branch_info_release(&old_branch_info);
 }
 
 static int checkout_branch(struct checkout_opts *opts,
@@ -1536,7 +1590,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		die_expecting_a_branch(new_branch_info);
 
 	if (!opts->can_switch_when_in_progress)
-		die_if_some_operation_in_progress();
+		die_if_some_incompatible_operation_in_progress(new_branch_info->commit);
 
 	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
 	    !opts->ignore_other_worktrees) {
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 5a7caf958c3..9c80d469b6b 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -111,13 +111,29 @@ test_expect_success 'guess and create branch' '
 	test_cmp expected actual
 '
 
-test_expect_success 'not switching when something is in progress' '
+test_expect_success 'not switching to a different commit when something is in progress' '
 	test_when_finished rm -f .git/MERGE_HEAD &&
 	# fake a merge-in-progress
 	cp .git/HEAD .git/MERGE_HEAD &&
 	test_must_fail git switch -d @^
 '
 
+test_expect_success 'switching to same-commit when merge is in progress succeeds' '
+	test_when_finished rm -f .git/MERGE_HEAD &&
+	# fake a merge-in-progress
+	cp .git/HEAD .git/MERGE_HEAD &&
+	git switch -d @ &&
+	# confirm the merge-in-progress is still there
+	test -e .git/MERGE_HEAD
+'
+test_expect_success 'switching with --force removes merge state' '
+	test_when_finished rm -f .git/MERGE_HEAD &&
+	# fake a merge-in-progress
+	cp .git/HEAD .git/MERGE_HEAD &&
+	git switch --force -d @ &&
+	# confirm the merge-in-progress is removed
+	test ! -e .git/MERGE_HEAD
+'
 test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	# default config does not copy tracking info
 	git switch -c foo-no-inherit foo &&

base-commit: 950264636c68591989456e3ba0a5442f93152c1a
-- 
gitgitgadget
