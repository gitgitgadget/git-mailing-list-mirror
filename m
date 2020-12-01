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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D8EC71155
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D3320870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdP/bftN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgLAW0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLAW0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:26:05 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4344C0613D6
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:25:24 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id v14so8164065wml.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hod6uIiSDkvsyl5su55lYSYEY+V0tKlVE7mSCnMpxVA=;
        b=NdP/bftNFC4UCPuswy4UlJlZmk7SWdMXUTOefMpeHELSOYj148rICQ7NeUIbcT9C5k
         LBCRn9XWd4AsedvedKjCxvjvkltWQb2J7QrvgB7800Tse6whD1hqBcJlUNZCHXjRpS6w
         53AjS8KbKa0zqOEKWcovzkVxKvMSJma9ROE4y06YOCSpISXdDMhLCzZaKAFUUSvgQAVD
         AMukc8N3JYtmdp7MyqjX9hykwWl3Pv/hjusqCR1c18IBJxVO8jDGyQFbIBN438hYBS1t
         yC8IgRDlGIEQ+vkoTxhYoP8IVHwY39NEX3c7iiPYxh7uqZBqpzT9GvdQ1M56HANv8xCm
         hoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hod6uIiSDkvsyl5su55lYSYEY+V0tKlVE7mSCnMpxVA=;
        b=dLR4lDb1YxDx3CcVWDxbwFK+7NJpElUdKUXdRcfUQZ0+aa0Fm3oRfhraf/tjvpZzmg
         9FnkVgXBCKJ0FPe918DLJmTkBc8NWPbYVgxpu6LvB1p0SJdzFeeg0FKzPUhYvzM4Sbzb
         L7Nx84JgxW5Phd4Dk1diP/K4KlvSao0ST/z0bB+N5kAg3bFOPloYO+CCsBeqb3V8XGXv
         WvUb7kT1fU1KX9wkXZKJkaZKg+eKnSWFsHpbgjdzAzS9t5Oz5qFi5XBv4JhXcmfpkh2m
         5m959FKelG7w6bZ/jBEBl6kYKemDMa8EhrVgefV3mwhLrLregns7CvuY44NkBxPoj7aQ
         xmJw==
X-Gm-Message-State: AOAM531AT7YazVAjD8Y0E8cxs5arSqG8UFHFLkTiZ6ydaemYnItYik4k
        W31UvgRSV2wTdjVA8Pcc4ONNFQRcS5s=
X-Google-Smtp-Source: ABdhPJyCG63IoQrBDqRm1oCCqugujn+mFCSpq5/FCi6V2wjFgd7iyV+KwF7++/Rr0GFjyZn0K6bfEg==
X-Received: by 2002:a7b:c5c6:: with SMTP id n6mr4716653wmk.131.1606861523074;
        Tue, 01 Dec 2020 14:25:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm1495103wrv.81.2020.12.01.14.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:25:22 -0800 (PST)
Message-Id: <1fa263cf3c3d1b0c20ad89e6454a7b903a07f193.1606861519.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
        <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Dec 2020 22:25:17 +0000
Subject: [PATCH v2 2/3] stash: remove unnecessary process forking
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

When stash was converted from shell to a builtin, it merely
transliterated the forking of various git commands from shell to a C
program that would fork the same commands.  Some of those were converted
over to actual library calls, but much of the pipeline-of-commands
design still remains.  Fix some of this by replacing the portion
corresponding to

    git diff-index --cached --name-only --diff-filter=A $CTREE >"$a"
    git read-tree --reset $CTREE
    git update-index --add --stdin <"$a"
    rm -f "$a"

into a library function that does the same thing.  (The read-tree
--reset was already partially converted over to a library call, but as
an independent piece.)  Note here that this came after a merge operation
was performed.  The merge machinery always stages anything that cleanly
merges, and the above code only runs if there are no conflicts.  Its
purpose is to make it so that when there are no conflicts, all the
changes from the stash are unstaged.  However, that causes brand new
files from the stash to become untracked, so the code above first saves
those files off and then re-adds them afterwards.

We replace the whole series of commands with a simple function that will
unstage files that are not newly added.  This doesn't fix any bugs in
the usage of these commands, it simply matches the existing behavior but
makes it into a single atomic operation that we can then operate on as a
whole.  A subsequent commit will take advantage of this to fix issues
with these commands in sparse-checkouts.

This conversion incidentally fixes t3906.1, because the separate
update-index process would die with the following error messages:
    error: uninitialized_sub: is a directory - add files inside instead
    fatal: Unable to process path uninitialized_sub
The unstaging of the directory as a submodule meant it was no longer
tracked, and thus as an uninitialized directory it could not be added
back using `git update-index --add`, thus resulting in this error and
early abort.  Most of the submodule tests in 3906 continue to fail after
this change, this change was just enough to push the first of those
tests to success.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c           | 119 ++++++++++++++++++++++----------------
 t/lib-submodule-update.sh |  16 ++---
 2 files changed, 78 insertions(+), 57 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3f811f3050..a5465b565a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -325,35 +325,6 @@ static void add_diff_to_buf(struct diff_queue_struct *q,
 	}
 }
 
-static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *c_tree_hex = oid_to_hex(c_tree);
-
-	/*
-	 * diff-index is very similar to diff-tree above, and should be
-	 * converted together with update_index.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-index", "--cached", "--name-only",
-		     "--diff-filter=A", NULL);
-	strvec_push(&cp.args, c_tree_hex);
-	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
-}
-
-static int update_index(struct strbuf *out)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	/*
-	 * Update-index is very complicated and may need to have a public
-	 * function exposed in order to remove this forking.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
-	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
-}
-
 static int restore_untracked(struct object_id *u_tree)
 {
 	int res;
@@ -385,6 +356,75 @@ static int restore_untracked(struct object_id *u_tree)
 	return res;
 }
 
+static void unstage_changes_unless_new(struct object_id *orig_tree)
+{
+	/*
+	 * When we enter this function, there has been a clean merge of
+	 * relevant trees, and the merge logic always stages whatever merges
+	 * cleanly.  We want to unstage those changes, unless it corresponds
+	 * to a file that didn't exist as of orig_tree.
+	 */
+
+	struct diff_options diff_opts;
+	struct lock_file lock = LOCK_INIT;
+	int i;
+
+	/*
+	 * Step 1: get a difference between orig_tree (which corresponding
+	 * to the index before a merge was run) and the current index
+	 * (reflecting the changes brought in by the merge).
+	 */
+	diff_setup(&diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.detect_rename = 0;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+
+	do_diff_cache(orig_tree, &diff_opts);
+	diffcore_std(&diff_opts);
+
+	/* Iterate over the paths that changed due to the merge... */
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p;
+		struct cache_entry *ce;
+		int pos;
+
+		/* Look up the path's position in the current index. */
+		p = diff_queued_diff.queue[i];
+		pos = index_name_pos(&the_index, p->two->path,
+				     strlen(p->two->path));
+
+		/*
+		 * Step 2: "unstage" changes, as long as they are still tracked
+		 */
+		if (p->one->oid_valid) {
+			/*
+			 * Path existed in orig_tree; restore index entry
+			 * from that tree in order to "unstage" the changes.
+			 */
+			int option = ADD_CACHE_OK_TO_REPLACE;
+			if (pos < 0)
+				option = ADD_CACHE_OK_TO_ADD;
+
+			ce = make_cache_entry(&the_index,
+					      p->one->mode,
+					      &p->one->oid,
+					      p->one->path,
+					      0, 0);
+			add_index_entry(&the_index, ce, option);
+		}
+	}
+	diff_flush(&diff_opts);
+
+	/*
+	 * Step 3: write the new index to disk
+	 */
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die(_("Unable to write index."));
+}
+
 static int do_apply_stash(const char *prefix, struct stash_info *info,
 			  int index, int quiet)
 {
@@ -467,26 +507,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		if (reset_tree(&index_tree, 0, 0))
 			return -1;
 	} else {
-		struct strbuf out = STRBUF_INIT;
-
-		if (get_newly_staged(&out, &c_tree)) {
-			strbuf_release(&out);
-			return -1;
-		}
-
-		if (reset_tree(&c_tree, 0, 1)) {
-			strbuf_release(&out);
-			return -1;
-		}
-
-		ret = update_index(&out);
-		strbuf_release(&out);
-		if (ret)
-			return -1;
-
-		/* read back the result of update_index() back from the disk */
-		discard_cache();
-		read_cache();
+		unstage_changes_unless_new(&c_tree);
 	}
 
 	if (!quiet) {
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 87a759149f..c6d7aab6df 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -316,14 +316,7 @@ test_submodule_switch_common () {
 	command="$1"
 	######################### Appearing submodule #########################
 	# Switching to a commit letting a submodule appear creates empty dir ...
-	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
-	then
-		# Restoring stash fails to restore submodule index entry
-		RESULT="failure"
-	else
-		RESULT="success"
-	fi
-	test_expect_$RESULT "$command: added submodule creates empty directory" '
+	test_expect_success "$command: added submodule creates empty directory" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
 		(
@@ -337,6 +330,13 @@ test_submodule_switch_common () {
 		)
 	'
 	# ... and doesn't care if it already exists.
+	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
+	then
+		# Restoring stash fails to restore submodule index entry
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
 	test_expect_$RESULT "$command: added submodule leaves existing empty directory alone" '
 		prolog &&
 		reset_work_tree_to no_submodule &&
-- 
gitgitgadget

