Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D251BC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B0D22087C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmZkyYKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgLAW0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLAW0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:26:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378A3C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:25:23 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id e7so5338656wrv.6
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XDbbmYX3uuFlMSJhgvUkB1rLDlm4m99YsKgEvhR6t6M=;
        b=gmZkyYKDc0s6iZn2T8MMkZ/llOo+uFp2jqR+QL+WusIvgoNdS7bUYYHmHJfBfcqW2v
         xrjCt9lrrVBKbH0R4t20CMI8y2m9dlbNQBZlQEe2eul/ThQG8nPxhI6yZ5BWybbfYAOd
         rkhnn22/YSEmdceA5EL0v69VHqDrlHeSCRGnq43h8NFuqOiAZmpfucmPHzH47PB+fHft
         vsqvs3YsjWuj1pBib4bajYaHPBDE5sVg9tfu8s5botcG6TPKE8IeqQFBocUweCN3yaj2
         xu8you9o1EQknNyJ5PMPUaKkMt4io3FJ1ZghPYOReMTlBT04K5Ex6UcCUMiGFfFAf+XU
         +C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XDbbmYX3uuFlMSJhgvUkB1rLDlm4m99YsKgEvhR6t6M=;
        b=LljkZPmFrYYustLjGUMKAbzerG90+uXMtFg+eNJL0PLq9q7+7qaNdAsP/TYgA8AjWY
         /B9V/dMO7jkU2Dq+X9NZA+su3RqMf62wUcxKfUOs37z3ltWyEfIuJF0iyW34MCH/p26B
         d7V7jLT/LcrBleKT7mK7Xooc5b2ncmgDLD8Sh555sBaa4D9wNR8O2LBystzs1Ejw3azP
         spGBe/gOR/SF/rpDlmhuDYZw7p9hF1XlBcuAFrgTkggH3o9kbdtC/fJtBT222Gsuucht
         Wv/eaWwoBR7pfMrLf7KIM5kSVrUbcwGgdkHr1tdQTnkOvm7pznRJ3qMcEZW72XAPD5nS
         PDOQ==
X-Gm-Message-State: AOAM533LqQ4NgFiyGdMJv7pC8KZYBMoVcFwUjXasHV4ZDZp2PMS85Uvd
        zV4p69GlUHg5i9hpQP//mgyuAHMGXJk=
X-Google-Smtp-Source: ABdhPJzU/AEucugyRjUwL9d5U4OGpbEJpaOGANYJjYGAgVvN9ihscRO8jM2giXsZr9jPuyVuocnzKQ==
X-Received: by 2002:adf:e787:: with SMTP id n7mr6779652wrm.153.1606861521216;
        Tue, 01 Dec 2020 14:25:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c81sm1899066wmd.6.2020.12.01.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:25:20 -0800 (PST)
Message-Id: <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Dec 2020 22:25:15 +0000
Subject: [PATCH v2 0/3] Fix stash apply in sparse checkouts (and a submodule test)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>, chris.torek@gmail.com,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some issues with git stash apply in sparse checkouts, when
the sparsity patterns have changed between when the stash was created and
when the stash is being applied. It also incidentally fixes a submodule
testcase unrelated to sparse checkouts.

Changes since v1:

 * Commit message cleanup, including a couple wording issues highlighted by
   Chris
 * Cleaned up the code a bit and commented it better, to try to make it
   easier for Junio (and others) to follow.

Elijah Newren (3):
  t7012: add a testcase demonstrating stash apply bugs in sparse
    checkouts
  stash: remove unnecessary process forking
  stash: fix stash application in sparse-checkouts

 builtin/stash.c                  | 165 ++++++++++++++++++++++---------
 t/lib-submodule-update.sh        |  16 +--
 t/t7012-skip-worktree-writing.sh |  88 +++++++++++++++++
 3 files changed, 212 insertions(+), 57 deletions(-)


base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-919%2Fnewren%2Fsparse-checkout-fixups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-919/newren/sparse-checkout-fixups-v2
Pull-Request: https://github.com/git/git/pull/919

Range-diff vs v1:

 1:  de4b4d207b ! 1:  2155bbfe20 t7012: add a testcase demonstrating stash apply bugs in sparse checkouts
     @@ Commit message
          t7012: add a testcase demonstrating stash apply bugs in sparse checkouts
      
          Applying stashes in sparse-checkouts, particularly when the patterns
     -    used to define the present paths have changed between when the stash was
     +    used to define the sparseness have changed between when the stash was
          created and when it is applied, has a number of bugs.  The primary
     -    problem is perhaps that stashes can be only partially applied (sometimes
     -    without any warning or error being displayed and with 0 exit status).
     -    In addition, there are cases where partial stash application comes with
     -    non-translated error messages and an early abort.  The first is when
     -    there are files present despite the SKIP_WORKTREE bit being set, in
     -    which case the error message shown is:
     +    problem is that stashes are sometimes only partially applied.  In most
     +    such cases, it does so silently without any warning or error being
     +    displayed and with 0 exit status.
     +
     +    There are, however, a few cases when non-translated error messages are
     +    shown and the stash application aborts early.  The first is when there
     +    are files present despite the SKIP_WORKTREE bit being set, in which case
     +    the error message shown is:
      
              error: Entry 'PATHNAME' not uptodate. Cannot merge.
      
          The other situation is when a stash contains new files to add to the
     -    working tree; in this case, the code aborts early (but after at least
     -    partial stash application) with the following error message being shown:
     +    working tree; in this case, the code aborts early but still has the
     +    stash partially applied, and shows the following error message:
      
              error: NEWFILE: does not exist and --remove not passed
              fatal: Unable to process path NEWFILE
      
     -    Add a test that can trigger all three of these problems that carefully
     -    checks that the working copy and SKIP_WORKTREE bits are as expected
     -    after the stash application...but currently marked as expected to fail.
     +    Add a test that can trigger all three of these problems.  Have it
     +    carefully check that the working copy and SKIP_WORKTREE bits are as
     +    expected after the stash application.  The test is currently marked as
     +    expected to fail, but subsequent commits will implement the fixes and
     +    toggle the expectation.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
 2:  eb9ebcf0bd ! 2:  1fa263cf3c stash: remove unnecessary process forking
     @@ Commit message
          into a library function that does the same thing.  (The read-tree
          --reset was already partially converted over to a library call, but as
          an independent piece.)  Note here that this came after a merge operation
     -    was performed.  The merge machinery always staged anything that cleanly
     -    merges, and the above code only runs if there were no conflicts.  Its
     +    was performed.  The merge machinery always stages anything that cleanly
     +    merges, and the above code only runs if there are no conflicts.  Its
          purpose is to make it so that when there are no conflicts, all the
          changes from the stash are unstaged.  However, that causes brand new
          files from the stash to become untracked, so the code above first saves
     @@ Commit message
          We replace the whole series of commands with a simple function that will
          unstage files that are not newly added.  This doesn't fix any bugs in
          the usage of these commands, it simply matches the existing behavior but
     -    making it an actual builtin that we can then operate on as a whole.  A
     -    subsequent commit will take advantage of this to fix issues with these
     -    commands in sparse-checkouts.
     +    makes it into a single atomic operation that we can then operate on as a
     +    whole.  A subsequent commit will take advantage of this to fix issues
     +    with these commands in sparse-checkouts.
      
          This conversion incidentally fixes t3906.1, because the separate
          update-index process would die with the following error messages:
     @@ builtin/stash.c: static void add_diff_to_buf(struct diff_queue_struct *q,
       }
       
      -static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
     -+static void unstage_changes_unless_new(struct object_id *cache_tree)
     - {
     +-{
      -	struct child_process cp = CHILD_PROCESS_INIT;
      -	const char *c_tree_hex = oid_to_hex(c_tree);
      -
     - 	/*
     +-	/*
      -	 * diff-index is very similar to diff-tree above, and should be
      -	 * converted together with update_index.
     -+	 * When we enter this function, there has been a clean merge of
     -+	 * relevant trees, and the merge logic always stages whatever merges
     -+	 * cleanly.  We want to unstage those changes, unless it corresponds
     -+	 * to a file that didn't exist as of cache_tree.
     - 	 */
     +-	 */
      -	cp.git_cmd = 1;
      -	strvec_pushl(&cp.args, "diff-index", "--cached", "--name-only",
      -		     "--diff-filter=A", NULL);
      -	strvec_push(&cp.args, c_tree_hex);
      -	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
      -}
     - 
     +-
      -static int update_index(struct strbuf *out)
      -{
      -	struct child_process cp = CHILD_PROCESS_INIT;
     -+	struct diff_options diff_opts;
     -+	struct lock_file lock = LOCK_INIT;
     -+	int i;
     - 
     +-
      -	/*
      -	 * Update-index is very complicated and may need to have a public
      -	 * function exposed in order to remove this forking.
     @@ builtin/stash.c: static void add_diff_to_buf(struct diff_queue_struct *q,
      -	cp.git_cmd = 1;
      -	strvec_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
      -	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
     +-}
     +-
     + static int restore_untracked(struct object_id *u_tree)
     + {
     + 	int res;
     +@@ builtin/stash.c: static int restore_untracked(struct object_id *u_tree)
     + 	return res;
     + }
     + 
     ++static void unstage_changes_unless_new(struct object_id *orig_tree)
     ++{
     ++	/*
     ++	 * When we enter this function, there has been a clean merge of
     ++	 * relevant trees, and the merge logic always stages whatever merges
     ++	 * cleanly.  We want to unstage those changes, unless it corresponds
     ++	 * to a file that didn't exist as of orig_tree.
     ++	 */
     ++
     ++	struct diff_options diff_opts;
     ++	struct lock_file lock = LOCK_INIT;
     ++	int i;
     ++
     ++	/*
     ++	 * Step 1: get a difference between orig_tree (which corresponding
     ++	 * to the index before a merge was run) and the current index
     ++	 * (reflecting the changes brought in by the merge).
     ++	 */
      +	diff_setup(&diff_opts);
      +	diff_opts.flags.recursive = 1;
      +	diff_opts.detect_rename = 0;
      +	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
      +	diff_setup_done(&diff_opts);
      +
     -+	do_diff_cache(cache_tree, &diff_opts);
     ++	do_diff_cache(orig_tree, &diff_opts);
      +	diffcore_std(&diff_opts);
      +
     ++	/* Iterate over the paths that changed due to the merge... */
      +	for (i = 0; i < diff_queued_diff.nr; i++) {
      +		struct diff_filepair *p;
      +		struct cache_entry *ce;
      +		int pos;
      +
     ++		/* Look up the path's position in the current index. */
      +		p = diff_queued_diff.queue[i];
      +		pos = index_name_pos(&the_index, p->two->path,
      +				     strlen(p->two->path));
     -+		if (pos < 0) {
     -+			assert(p->one->oid_valid);
     -+			assert(!p->two->oid_valid);
     -+			ce = make_cache_entry(&the_index,
     -+					      p->one->mode,
     -+					      &p->one->oid,
     -+					      p->one->path,
     -+					      0, 0);
     -+			add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD);
     -+			continue;
     -+		}
     -+		ce = active_cache[pos];
     ++
     ++		/*
     ++		 * Step 2: "unstage" changes, as long as they are still tracked
     ++		 */
      +		if (p->one->oid_valid) {
     ++			/*
     ++			 * Path existed in orig_tree; restore index entry
     ++			 * from that tree in order to "unstage" the changes.
     ++			 */
     ++			int option = ADD_CACHE_OK_TO_REPLACE;
     ++			if (pos < 0)
     ++				option = ADD_CACHE_OK_TO_ADD;
     ++
      +			ce = make_cache_entry(&the_index,
      +					      p->one->mode,
      +					      &p->one->oid,
      +					      p->one->path,
      +					      0, 0);
     -+			add_index_entry(&the_index, ce,
     -+					ADD_CACHE_OK_TO_REPLACE);
     ++			add_index_entry(&the_index, ce, option);
      +		}
      +	}
      +	diff_flush(&diff_opts);
      +
     ++	/*
     ++	 * Step 3: write the new index to disk
     ++	 */
      +	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
      +	if (write_locked_index(&the_index, &lock,
      +			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
      +		die(_("Unable to write index."));
     - }
     - 
     - static int restore_untracked(struct object_id *u_tree)
     ++}
     ++
     + static int do_apply_stash(const char *prefix, struct stash_info *info,
     + 			  int index, int quiet)
     + {
      @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
       		if (reset_tree(&index_tree, 0, 0))
       			return -1;
 3:  5143cba704 ! 3:  ccfedc7140 stash: fix stash application in sparse-checkouts
     @@ Commit message
          staged at the end and include more things that should be quasi-merged,
          (2) stash generally wants changes to NOT be staged.  It only provides
          exceptions when (a) some of the changes had conflicts and thus we want
     -    to use staged to denote the clean merges and higher order stages to
     +    to use stages to denote the clean merges and higher order stages to
          mark the conflicts, or (b) if there is a brand new file we don't want
          it to become untracked.
      
     @@ Commit message
              git update-index --add --stdin <"$a"
              rm -f "$a"
      
     -    You might that between the merge that proceeded these commands and these
     -    different commands here, that we have commands from each of the
     -    different types of special sparsity handling listed at the beginning of
     -    this message, and in fact this precisely led to the following buggy
     -    behaviors:
     +    Looking back at the different types of special sparsity handling listed
     +    at the beginning of this message, you may note that we have at least one
     +    of each type covered here: merge, diff-index, and read-tree.  The weird
     +    mix-and-match led to 3 different bugs:
      
          (1) If a path merged cleanly and it didn't match the sparsity patterns,
          the merge backend would know to avoid writing it to the working tree and
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/stash.c ##
     -@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *cache_tree)
     - 	 * When we enter this function, there has been a clean merge of
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
       	 * relevant trees, and the merge logic always stages whatever merges
       	 * cleanly.  We want to unstage those changes, unless it corresponds
     --	 * to a file that didn't exist as of cache_tree.
     -+	 * to a file that didn't exist as of cache_tree.  However, if any
     -+	 * SKIP_WORKTREE path is modified relative to cache_tree, then we
     -+	 * want to clear the SKIP_WORKTREE bit and write it to the worktree
     -+	 * before unstaging.
     + 	 * to a file that didn't exist as of orig_tree.
     ++	 *
     ++	 * However, if any SKIP_WORKTREE path is modified relative to
     ++	 * orig_tree, then we want to clear the SKIP_WORKTREE bit and write
     ++	 * it to the worktree before unstaging.
       	 */
       
      +	struct checkout state = CHECKOUT_INIT;
     @@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *cache_
      +	state.refresh_cache = 1;
      +	state.istate = &the_index;
      +
     - 	diff_setup(&diff_opts);
     - 	diff_opts.flags.recursive = 1;
     - 	diff_opts.detect_rename = 0;
     -@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *cache_tree)
     - 			continue;
     - 		}
     - 		ce = active_cache[pos];
     -+		if (ce_skip_worktree(ce)) {
     + 	/*
     + 	 * Step 1: get a difference between orig_tree (which corresponding
     + 	 * to the index before a merge was run) and the current index
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + 				     strlen(p->two->path));
     + 
     + 		/*
     +-		 * Step 2: "unstage" changes, as long as they are still tracked
     ++		 * Step 2: Place changes in the working tree
     ++		 *
     ++		 * Stash is about restoring changes *to the working tree*.
     ++		 * So if the merge successfully got a new version of some
     ++		 * path, but left it out of the working tree, then clear the
     ++		 * SKIP_WORKTREE bit and write it to the working tree.
     ++		 */
     ++		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
      +			struct stat st;
     ++
     ++			ce = active_cache[pos];
      +			if (!lstat(ce->name, &st)) {
     ++				/* Conflicting path present; relocate it */
      +				struct strbuf new_path = STRBUF_INIT;
      +				int fd;
      +
     @@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *cache_
      +				strbuf_release(&new_path);
      +			}
      +			checkout_entry(ce, &state, NULL, NULL);
     ++			ce->ce_flags &= ~CE_SKIP_WORKTREE;
      +		}
      +
     -+		ce->ce_flags &= ~CE_SKIP_WORKTREE;
     ++		/*
     ++		 * Step 3: "unstage" changes, as long as they are still tracked
     + 		 */
       		if (p->one->oid_valid) {
     - 			ce = make_cache_entry(&the_index,
     - 					      p->one->mode,
     + 			/*
     +@@ builtin/stash.c: static void unstage_changes_unless_new(struct object_id *orig_tree)
     + 	diff_flush(&diff_opts);
     + 
     + 	/*
     +-	 * Step 3: write the new index to disk
     ++	 * Step 4: write the new index to disk
     + 	 */
     + 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
     + 	if (write_locked_index(&the_index, &lock,
      
       ## t/t7012-skip-worktree-writing.sh ##
      @@ t/t7012-skip-worktree-writing.sh: test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '

-- 
gitgitgadget
