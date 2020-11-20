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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F988C56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFE12100A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip0voAmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgKTQxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgKTQxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:53:47 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A426C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so10773723wrt.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5L9um2HsOpUj5ErYVGAEt/asMWXqgB4GcsakeEVwtW0=;
        b=Ip0voAmHSeJ7CKsLfDMtwLRUzzr8mg4OJskKq5JCp5fsrpZtmSHh8A3SrzM5TdkXs7
         hXumz8PeeaY5xjpNfq0hq324otH1lg4leS7Fv884lRPurZm8iI9lDANlq7VhpODUkDah
         Ok7PeACegXahX522mq+Icz04fT49CfcV3ZwWczmztRGn/BlmhJ6x9/eDlUMn+PdhpE6r
         Bs/i2Q/rKlbHmOR+TWUy8olypeprrafX24zEZgNx1ghXXBiFDve86OqTeq/XKEuF5d2t
         uIK1EHRAY4FhDH2mPRTOdgliw9EBh8R5kcUYHQnIV9oZcqQydPYpy2g5YUdNrApeO3MV
         L2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5L9um2HsOpUj5ErYVGAEt/asMWXqgB4GcsakeEVwtW0=;
        b=h3GtFecAucNyRofJJObaZ9j22VQPGL/7rZTo8mOSUBsi6gfq3oR2Tl82vwAv1EX93O
         dvNm8j6QI3mL9Wtj3kB9PvQv0ykKa2lecIAgcrqI1EAcjE0jJRIlM85/OC0CdKrFFyvZ
         zI5DwNNsd6NyIwowjGJTuPaR2clv4umEEodQUrZFTU/VZKVL0N6ST84InCeYMpVd9MTz
         GBDes1YXhXIztOfCYvNKvMkJ9Wsq7DS2kdFHfG9UHo97Wa40j8Y650NsK2R9hFZbkTxK
         XZ3LqbMloByqKoCWUgaWbRrgw6anSdXj4MCyZatMA8pKPyaUp3LsSKMmeXNEm7L3WTy2
         N6tQ==
X-Gm-Message-State: AOAM530ivsIRP5TrhiI13EIAEZzxnzXYJeeJJhJN2RpK2Frj1EWvThMU
        Mu0sZEHnRAisWr/Jv5hDfOQcx4mTXcE=
X-Google-Smtp-Source: ABdhPJwMwWN7uK02rlvzgTAWfp+4sg/Fm6EU87/Gg7da2wQQafYITas2d1UjyFlHVfm+oZlsyUnJjQ==
X-Received: by 2002:adf:dccd:: with SMTP id x13mr18204582wrm.394.1605891225539;
        Fri, 20 Nov 2020 08:53:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm5660415wrf.94.2020.11.20.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:53:45 -0800 (PST)
Message-Id: <eb9ebcf0bd8ac946dab7bfd28a44587c5d9caf4f.1605891222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 16:53:41 +0000
Subject: [PATCH 2/3] stash: remove unnecessary process forking
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
was performed.  The merge machinery always staged anything that cleanly
merges, and the above code only runs if there were no conflicts.  Its
purpose is to make it so that when there are no conflicts, all the
changes from the stash are unstaged.  However, that causes brand new
files from the stash to become untracked, so the code above first saves
those files off and then re-adds them afterwards.

We replace the whole series of commands with a simple function that will
unstage files that are not newly added.  This doesn't fix any bugs in
the usage of these commands, it simply matches the existing behavior but
making it an actual builtin that we can then operate on as a whole.  A
subsequent commit will take advantage of this to fix issues with these
commands in sparse-checkouts.

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
 builtin/stash.c           | 96 ++++++++++++++++++++++-----------------
 t/lib-submodule-update.sh | 16 +++----
 2 files changed, 62 insertions(+), 50 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 24ddb1bffa..8117d7647d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -325,33 +325,64 @@ static void add_diff_to_buf(struct diff_queue_struct *q,
 	}
 }
 
-static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
+static void unstage_changes_unless_new(struct object_id *cache_tree)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	const char *c_tree_hex = oid_to_hex(c_tree);
-
 	/*
-	 * diff-index is very similar to diff-tree above, and should be
-	 * converted together with update_index.
+	 * When we enter this function, there has been a clean merge of
+	 * relevant trees, and the merge logic always stages whatever merges
+	 * cleanly.  We want to unstage those changes, unless it corresponds
+	 * to a file that didn't exist as of cache_tree.
 	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-index", "--cached", "--name-only",
-		     "--diff-filter=A", NULL);
-	strvec_push(&cp.args, c_tree_hex);
-	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
-}
 
-static int update_index(struct strbuf *out)
-{
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct diff_options diff_opts;
+	struct lock_file lock = LOCK_INIT;
+	int i;
 
-	/*
-	 * Update-index is very complicated and may need to have a public
-	 * function exposed in order to remove this forking.
-	 */
-	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "update-index", "--add", "--stdin", NULL);
-	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
+	diff_setup(&diff_opts);
+	diff_opts.flags.recursive = 1;
+	diff_opts.detect_rename = 0;
+	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_setup_done(&diff_opts);
+
+	do_diff_cache(cache_tree, &diff_opts);
+	diffcore_std(&diff_opts);
+
+	for (i = 0; i < diff_queued_diff.nr; i++) {
+		struct diff_filepair *p;
+		struct cache_entry *ce;
+		int pos;
+
+		p = diff_queued_diff.queue[i];
+		pos = index_name_pos(&the_index, p->two->path,
+				     strlen(p->two->path));
+		if (pos < 0) {
+			assert(p->one->oid_valid);
+			assert(!p->two->oid_valid);
+			ce = make_cache_entry(&the_index,
+					      p->one->mode,
+					      &p->one->oid,
+					      p->one->path,
+					      0, 0);
+			add_index_entry(&the_index, ce, ADD_CACHE_OK_TO_ADD);
+			continue;
+		}
+		ce = active_cache[pos];
+		if (p->one->oid_valid) {
+			ce = make_cache_entry(&the_index,
+					      p->one->mode,
+					      &p->one->oid,
+					      p->one->path,
+					      0, 0);
+			add_index_entry(&the_index, ce,
+					ADD_CACHE_OK_TO_REPLACE);
+		}
+	}
+	diff_flush(&diff_opts);
+
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
+	if (write_locked_index(&the_index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		die(_("Unable to write index."));
 }
 
 static int restore_untracked(struct object_id *u_tree)
@@ -467,26 +498,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
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
index bd3fa3c6da..4b714e9308 100644
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

