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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3020FC8300F
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22D620870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkYb30by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgLAW0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLAW0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:26:06 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB6C0617A6
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:25:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l1so5341765wrb.9
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rVc0WPPpwP15Cm/Gntip41uoVq7VtIBkPszoyu2g6is=;
        b=SkYb30byGT/OGaMqlKDcwu3t4BS6KiHuXTYvSAtwuTSxvhULB2yQYO4Nk9LNQq7ZZx
         521Q9OQNUu5/ieE2bWWBcnAoglb2jmF087wNL1mQWsjfxJk3Zg6azIr6IXKUBjH5nMHU
         lVdz4LSGfm+Pz1sbkjx8X2OLs3hi4n4ocEpUXTpCMGz2Y4EBvoHCPVCH7Ccd9a+6w1vN
         ucl8lH/sfEBAYrNJ4kcCLDAVWpbKoIKpDBxoPtKLu6zM93kavn9XM8hYqFd+q7e4IQc4
         RXujLcauY2iGrfLOs2zCOlFrFvtlqRIUcmNH5Q2sgatC2dVtjvQs+SJZG4dLusuMTSNU
         a4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rVc0WPPpwP15Cm/Gntip41uoVq7VtIBkPszoyu2g6is=;
        b=NZ9gPyIsBqWLcZ4d/3AKUcTyeNQWAs+IaXZumQxy8p/RiwIZtcUPqNQR+HCNb0YT0n
         pGli2UT1lFIinKMc2XIXlK3GQpLXjdHJtln8dMuXa6f8706e2QAmt1UuFuoj01s1S8Xs
         PO2EA5h7D5z+HVL+PJokgphKX6roo+lgG6a5+PLSM4UnCvzLzRCbjgZWmktH/9lhdsaN
         1KBd9JrcUkKjYb6YyqPJJfpVLWKj05b2XXO8ONl8CmXpnThvIVt1I8aus1Z7Wf99Zwrx
         6YVycfJ82DX3bu1Ou//xat33hVhhNEWzA9G+m9hKKYqAaDzWWjXfSnRrjot2ibNKV7n8
         byWg==
X-Gm-Message-State: AOAM533R78FLwSUBc2HgfaFjmgkev4SQPR5tP/5c2i9yDvt90UFaIGH0
        ilxQ5qr6+evbUGAslvwhXQUY3wyVCxA=
X-Google-Smtp-Source: ABdhPJwyab/5/jnRVENPlXSraPG9dnidaxTZpZ97hRdcUWUf3Q9bZcedsLbWDrM/DCaTW8HL4Symjg==
X-Received: by 2002:a5d:5222:: with SMTP id i2mr6991075wra.247.1606861524107;
        Tue, 01 Dec 2020 14:25:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm1394388wrq.38.2020.12.01.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:25:23 -0800 (PST)
Message-Id: <ccfedc7140dbf63ba26a15f93bd3885180b26517.1606861519.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
        <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Dec 2020 22:25:18 +0000
Subject: [PATCH v2 3/3] stash: fix stash application in sparse-checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>, chris.torek@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sparse-checkouts are built on the patterns in the
$GIT_DIR/info/sparse-checkout file, where commands have modified
behavior for paths that do not match those patterns.  The differences in
behavior, as far as the bugs concerned here, fall into three different
categories (with git subcommands that fall into each category listed):

  * commands that only look at files matching the patterns:
      * status
      * diff
      * clean
      * update-index
  * commands that remove files from the working tree that do not match
    the patterns, and restore files that do match them:
      * read-tree
      * switch
      * checkout
      * reset (--hard)
  * commands that omit writing files to the working tree that do not
    match the patterns, unless those files are not clean:
      * merge
      * rebase
      * cherry-pick
      * revert

There are some caveats above, e.g. a plain `git diff` ignores files
outside the sparsity patterns but will show diffs for paths outside the
sparsity patterns when revision arguments are passed.  (Technically,
diff is treating the sparse paths as matching HEAD.)  So, there is some
internal inconsistency among these commands.  There are also additional
commands that should behave differently in the face of sparse-checkouts,
as the sparse-checkout documentation alludes to, but the above is
sufficient for me to explain how `git stash` is affected.

What is relevant here is that logically 'stash' should behave like a
merge; it three-way merges the changes the user had in progress at stash
creation time, the HEAD at the time the stash was created, and the
current HEAD, in order to get the stashed changes applied to the current
branch.  However, this simplistic view doesn't quite work in practice,
because stash tweaks it a bit due to two factors: (1) flags like
--keep-index and --include-untracked (why we used two different verbs,
'keep' and 'include', is a rant for another day) modify what should be
staged at the end and include more things that should be quasi-merged,
(2) stash generally wants changes to NOT be staged.  It only provides
exceptions when (a) some of the changes had conflicts and thus we want
to use stages to denote the clean merges and higher order stages to
mark the conflicts, or (b) if there is a brand new file we don't want
it to become untracked.

stash has traditionally gotten this special behavior by first doing a
merge, and then when it's clean, applying a pipeline of commands to
modify the result.  This series of commands for
unstaging-non-newly-added-files came from the following commands:

    git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
    git read-tree --reset $CTREE
    git update-index --add --stdin <"$a"
    rm -f "$a"

Looking back at the different types of special sparsity handling listed
at the beginning of this message, you may note that we have at least one
of each type covered here: merge, diff-index, and read-tree.  The weird
mix-and-match led to 3 different bugs:

(1) If a path merged cleanly and it didn't match the sparsity patterns,
the merge backend would know to avoid writing it to the working tree and
keep the SKIP_WORKTREE bit, simply only updating it in the index.
Unfortunately, the subsequent commands would essentially undo the
changes in the index and thus simply toss the changes altogether since
there was nothing left in the working tree.  This means the stash is
only partially applied.

(2) If a path existed in the worktree before `git stash apply` despite
having the SKIP_WORKTREE bit set, then the `git read-tree --reset` would
print an error message of the form
      error: Entry 'modified' not uptodate. Cannot merge.
and cause stash to abort early.

(3) If there was a brand new file added by the stash, then the
diff-index command would save that pathname to the temporary file, the
read-tree --reset would remove it from the index, and the update-index
command would barf due to no such file being present in the working
copy; it would print a message of the form:
      error: NEWFILE: does not exist and --remove not passed
      fatal: Unable to process path NEWFILE
and then cause stash to abort early.

Basically, the whole idea of unstage-unless-brand-new requires special
care when you are dealing with a sparse-checkout.  Fix these problems
by applying the following simple rule:

  When we unstage files, if they have the SKIP_WORKTREE bit set,
  clear that bit and write the file out to the working directory.

  (*) If there's already a file present in the way, rename it first.

This fixes all three problems in t7012.13 and allows us to mark it as
passing.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c                  | 50 ++++++++++++++++++++++++++++++--
 t/t7012-skip-worktree-writing.sh |  2 +-
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a5465b565a..84886e84e0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -363,12 +363,23 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	 * relevant trees, and the merge logic always stages whatever merges
 	 * cleanly.  We want to unstage those changes, unless it corresponds
 	 * to a file that didn't exist as of orig_tree.
+	 *
+	 * However, if any SKIP_WORKTREE path is modified relative to
+	 * orig_tree, then we want to clear the SKIP_WORKTREE bit and write
+	 * it to the worktree before unstaging.
 	 */
 
+	struct checkout state = CHECKOUT_INIT;
 	struct diff_options diff_opts;
 	struct lock_file lock = LOCK_INIT;
 	int i;
 
+	/* If any entries have skip_worktree set, we'll have to check 'em out */
+	state.force = 1;
+	state.quiet = 1;
+	state.refresh_cache = 1;
+	state.istate = &the_index;
+
 	/*
 	 * Step 1: get a difference between orig_tree (which corresponding
 	 * to the index before a merge was run) and the current index
@@ -395,7 +406,42 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 				     strlen(p->two->path));
 
 		/*
-		 * Step 2: "unstage" changes, as long as they are still tracked
+		 * Step 2: Place changes in the working tree
+		 *
+		 * Stash is about restoring changes *to the working tree*.
+		 * So if the merge successfully got a new version of some
+		 * path, but left it out of the working tree, then clear the
+		 * SKIP_WORKTREE bit and write it to the working tree.
+		 */
+		if (pos >= 0 && ce_skip_worktree(active_cache[pos])) {
+			struct stat st;
+
+			ce = active_cache[pos];
+			if (!lstat(ce->name, &st)) {
+				/* Conflicting path present; relocate it */
+				struct strbuf new_path = STRBUF_INIT;
+				int fd;
+
+				strbuf_addf(&new_path,
+					    "%s.stash.XXXXXX", ce->name);
+				fd = xmkstemp(new_path.buf);
+				close(fd);
+				printf(_("WARNING: Untracked file in way of "
+					 "tracked file!  Renaming\n "
+					 "           %s -> %s\n"
+					 "         to make room.\n"),
+				       ce->name, new_path.buf);
+				if (rename(ce->name, new_path.buf))
+					die("Failed to move %s to %s\n",
+					    ce->name, new_path.buf);
+				strbuf_release(&new_path);
+			}
+			checkout_entry(ce, &state, NULL, NULL);
+			ce->ce_flags &= ~CE_SKIP_WORKTREE;
+		}
+
+		/*
+		 * Step 3: "unstage" changes, as long as they are still tracked
 		 */
 		if (p->one->oid_valid) {
 			/*
@@ -417,7 +463,7 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 	diff_flush(&diff_opts);
 
 	/*
-	 * Step 3: write the new index to disk
+	 * Step 4: write the new index to disk
 	 */
 	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	if (write_locked_index(&the_index, &lock,
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index a184ee97fb..e5c6a038fb 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -149,7 +149,7 @@ test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
 		--diff-filter=D -- keep-me.t
 '
 
-test_expect_failure 'stash restore in sparse checkout' '
+test_expect_success 'stash restore in sparse checkout' '
 	test_create_repo stash-restore &&
 	(
 		cd stash-restore &&
-- 
gitgitgadget
