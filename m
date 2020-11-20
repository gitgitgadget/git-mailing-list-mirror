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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494AEC63798
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062812225B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqRiA78K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgKTQxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgKTQxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:53:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EEDC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:48 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x13so3278387wmj.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tGBsOn+CLPS2UIQsK+78dUG0cPNCdFdpBpPGhN6swd8=;
        b=PqRiA78KJ40QJCZSCQJZWbnn9Hl8y9UzFOESRJV9MTNHX5GZYiLDavHzjXCvtQQ/cN
         Z3TeN/NsGjKQgZtFyLdEyGir8+uwk2EA+eHK33il7lgLA88zEOfSzek1/FULjmvrPZGM
         9FZ++ZPKA2A4VOGAlxdBbFZSRJIHDZwhSFUWYl/2+ySnfQ7uUfR4KAGiKN3W6474GdG1
         1nSNUHuF4P0zb1bdV7Cd4hOacjCerpkj3i7tNfF29A7L20k8dLkHcL7hxStv6WsxIaj7
         MT4sfoUE9qT7p9YNEmbaK/HdaNyWbia5zRJRSLjVolfHom+HkySwfnObrGNt8MM0ZGyV
         NdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tGBsOn+CLPS2UIQsK+78dUG0cPNCdFdpBpPGhN6swd8=;
        b=RjT9y47JFfDzBzyUfXKrl0/YDYhgWwvgPXTtAnZdVHzzlS4gK8B1fFJhINjSwv6Zgf
         nbzn/DOwAJBW09zAfzCSzcpPcALqbhDZCNoSn2kFA4DbrVz3lw3i85Qa9Chi+ervRA0B
         NZSudP3bapE9bEzj4VyxmsMRKbk/bRJyz0Z4HW45IgXbavYQx+QxEn26ftNI0PuepR+L
         +CgwiWivSwXNV7zfO5B7D4eP2SBNlEMoN0tJ21+WhxZ9ocfrym+v3P6Ly6O8YgbcgKN/
         XbmZYW1vCJjaKEMIxyaIAYRjyGD0/sOv7AYdS09d26MPC+QHxOLtH6ow3jPBSda3gj3r
         kHRA==
X-Gm-Message-State: AOAM530Dr97uPXmHOghWms19L4NraG62AGz/VUUdMNbNBDAyUSpjsk7/
        /KWpI1ywSQxDk75XXubp6QOZpabDlFg=
X-Google-Smtp-Source: ABdhPJxPdzNtSwytIZ9jtvnVge24eP5/hu33VfBQ9Z7gjmK32qh1SU8ak5Tk3ShABB64xPgByMVTJg==
X-Received: by 2002:a1c:40d4:: with SMTP id n203mr11275550wma.102.1605891226547;
        Fri, 20 Nov 2020 08:53:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s202sm5090369wme.39.2020.11.20.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:53:46 -0800 (PST)
Message-Id: <5143cba7047d25137b3d7f8c7811a875c1931aee.1605891222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 16:53:42 +0000
Subject: [PATCH 3/3] stash: fix stash application in sparse-checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
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
to use staged to denote the clean merges and higher order stages to
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

You might that between the merge that proceeded these commands and these
different commands here, that we have commands from each of the
different types of special sparsity handling listed at the beginning of
this message, and in fact this precisely led to the following buggy
behaviors:

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
 builtin/stash.c                  | 36 +++++++++++++++++++++++++++++++-
 t/t7012-skip-worktree-writing.sh |  2 +-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 8117d7647d..0f7e78d315 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -331,13 +331,23 @@ static void unstage_changes_unless_new(struct object_id *cache_tree)
 	 * When we enter this function, there has been a clean merge of
 	 * relevant trees, and the merge logic always stages whatever merges
 	 * cleanly.  We want to unstage those changes, unless it corresponds
-	 * to a file that didn't exist as of cache_tree.
+	 * to a file that didn't exist as of cache_tree.  However, if any
+	 * SKIP_WORKTREE path is modified relative to cache_tree, then we
+	 * want to clear the SKIP_WORKTREE bit and write it to the worktree
+	 * before unstaging.
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
 	diff_setup(&diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
@@ -367,6 +377,30 @@ static void unstage_changes_unless_new(struct object_id *cache_tree)
 			continue;
 		}
 		ce = active_cache[pos];
+		if (ce_skip_worktree(ce)) {
+			struct stat st;
+			if (!lstat(ce->name, &st)) {
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
+		}
+
+		ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		if (p->one->oid_valid) {
 			ce = make_cache_entry(&the_index,
 					      p->one->mode,
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
