Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E1520370
	for <e@80x24.org>; Thu,  5 Oct 2017 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdJEUck (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:32:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:46047 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdJEUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:32:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id q124so4227096wmb.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5cH2DiorbZaAuyDiFdhcOtNfd1VRK89NJfqaZxgb730=;
        b=USEFZXhVU68CDtCs+LKh2s2N+SYZkXmlzmENpTD6xlqp6I5WsbI/bNfbcjq8eCDmKD
         iaJsI45JQsofnqba1Eng2V7WXtUW936WXIj/qhal6nOnoqOMHt8paU6eRwUscsQT2MJ7
         p7JvjdDUUmCOAvl6Fte/Qbc81SQjUwwN6KkXwSi7q/FiBJ8n3Qz9O+VonQBsna9Uf35c
         G+yRdUjPnLt/tfC+Itpgj4yNUeGM7LYzcj3Yeq8vpf9kAL//zs1NELA84ejRd0sWT0oJ
         JojBOvVsBhKfLxPGm3Oq2kHKGkY3K5F2S3oj/VCzAQ5X87Q+rcdkGG0c2r+eQfE418Zf
         isxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5cH2DiorbZaAuyDiFdhcOtNfd1VRK89NJfqaZxgb730=;
        b=L5m0kTto2jlTcVgelO0FH+I0Eoca3SMfkQMh2iuwQSP/iI7XjPRDhCiGXKvTjRzjGp
         nYGTjFZoiIzESLoTOlaYJXc1ZPq0F2tceShgkQr0LocJUV8A0UyiGEr1624SG5VXCFwe
         uoxHUGdS1j0fXb9KKHbD7FubUKDwmzh0cMnoDZUoFnRHtxFwnc95+ghwc5lDbGAB8Wqz
         /gebwaKj74cI0Ej7fEnXLxbTXgWU1MMv4Wq165jWLRAa5tIUb3gPL0idioQ54MBC9bKD
         6jlAYUA9RQmGevMM7q0rtIaLrXJQ/K2fQer3C364tNIoU+gBaQGFQeqGgvWBif1Q/7HQ
         Y/rA==
X-Gm-Message-State: AMCzsaWxBGiqS9mbn9fv/3nL1zpLWVTfTRnsj9j8REZJedHnJMDVUBxw
        PUKesWWmZmK2Onw5ZI9Sb702fBcq
X-Google-Smtp-Source: AOwi7QCYagYIC9EYgOgkXlUCcpqw57877zCgFXAWhrB7Cxzxye+DT1XUnj+sqdYFIQl9v6B3z/ZNNA==
X-Received: by 10.28.113.212 with SMTP id d81mr275375wmi.152.1507235557165;
        Thu, 05 Oct 2017 13:32:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id i76sm698424wmd.2.2017.10.05.13.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Oct 2017 13:32:36 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/12] treewide: prefer lockfiles on the stack
Date:   Thu,  5 Oct 2017 22:32:04 +0200
Message-Id: <2fdb048f30131b30ea910018719485fc8cff4b11.1507228170.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.2.666.gea220ee40
In-Reply-To: <cover.1507228170.git.martin.agren@gmail.com>
References: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com> <cover.1507228170.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no longer any need to allocate and leak a `struct lock_file`.
The previous patch addressed an instance where we needed a minor tweak
alongside the trivial changes.

Deal with the remaining instances where we allocate and leak a struct
within a single function. Change them to have the `struct lock_file` on
the stack instead.

These instances were identified by running `git grep "^\s*struct
lock_file\s*\*"`.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
v2: Identical.

 builtin/am.c       | 24 +++++++++++-------------
 builtin/checkout.c | 14 ++++++--------
 builtin/clone.c    |  7 +++----
 builtin/diff.c     |  7 +++----
 config.c           | 17 ++++++++---------
 merge-recursive.c  |  6 +++---
 merge.c            |  8 ++++----
 wt-status.c        |  8 ++++----
 8 files changed, 42 insertions(+), 49 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index d7513f537..4e16fd428 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1134,11 +1134,11 @@ static const char *msgnum(const struct am_state *state)
  */
 static void refresh_and_write_cache(void)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock_file = LOCK_INIT;
 
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	refresh_cache(REFRESH_QUIET);
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write index file"));
 }
 
@@ -1946,15 +1946,14 @@ static void am_resolve(struct am_state *state)
  */
 static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 {
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts;
 	struct tree_desc t[2];
 
 	if (parse_tree(head) || parse_tree(remote))
 		return -1;
 
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	refresh_cache(REFRESH_QUIET);
 
@@ -1970,11 +1969,11 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
 	init_tree_desc(&t[1], remote->buffer, remote->size);
 
 	if (unpack_trees(2, t, &opts)) {
-		rollback_lock_file(lock_file);
+		rollback_lock_file(&lock_file);
 		return -1;
 	}
 
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
 	return 0;
@@ -1986,15 +1985,14 @@ static int fast_forward_to(struct tree *head, struct tree *remote, int reset)
  */
 static int merge_tree(struct tree *tree)
 {
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts;
 	struct tree_desc t[1];
 
 	if (parse_tree(tree))
 		return -1;
 
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
@@ -2005,11 +2003,11 @@ static int merge_tree(struct tree *tree)
 	init_tree_desc(&t[0], tree->buffer, tree->size);
 
 	if (unpack_trees(1, t, &opts)) {
-		rollback_lock_file(lock_file);
+		rollback_lock_file(&lock_file);
 		return -1;
 	}
 
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
 	return 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3345a0d16..34c3c5b61 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -247,7 +247,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct object_id rev;
 	struct commit *head;
 	int errs = 0;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
@@ -275,9 +275,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
 
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
@@ -376,7 +374,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	}
 	errs |= finish_delayed_checkout(&state);
 
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
 	read_ref_full("HEAD", 0, rev.hash, NULL);
@@ -472,9 +470,9 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			      int *writeout_error)
 {
 	int ret;
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock_file = LOCK_INIT;
 
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(NULL) < 0)
 		return error(_("index file corrupt"));
 
@@ -591,7 +589,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 	if (!cache_tree_fully_valid(active_cache_tree))
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
 	if (!opts->force && !opts->quiet)
diff --git a/builtin/clone.c b/builtin/clone.c
index dbddd98f8..96a3aaaa1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -706,7 +706,7 @@ static int checkout(int submodule_progress)
 {
 	struct object_id oid;
 	char *head;
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	struct unpack_trees_options opts;
 	struct tree *tree;
 	struct tree_desc t;
@@ -733,8 +733,7 @@ static int checkout(int submodule_progress)
 	/* We need to be in the new work tree for the checkout */
 	setup_work_tree();
 
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	hold_locked_index(lock_file, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
@@ -750,7 +749,7 @@ static int checkout(int submodule_progress)
 	if (unpack_trees(1, &t, &opts) < 0)
 		die(_("unable to checkout working tree"));
 
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
diff --git a/builtin/diff.c b/builtin/diff.c
index 7e3ebcea3..91995965d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -203,17 +203,16 @@ static int builtin_diff_combined(struct rev_info *revs,
 
 static void refresh_index_quietly(void)
 {
-	struct lock_file *lock_file;
+	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
-	lock_file = xcalloc(1, sizeof(struct lock_file));
-	fd = hold_locked_index(lock_file, 0);
+	fd = hold_locked_index(&lock_file, 0);
 	if (fd < 0)
 		return;
 	discard_cache();
 	read_cache();
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
-	update_index_if_able(&the_index, lock_file);
+	update_index_if_able(&the_index, &lock_file);
 }
 
 static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
diff --git a/config.c b/config.c
index 345d78c2b..0e61e863d 100644
--- a/config.c
+++ b/config.c
@@ -2748,7 +2748,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
-	struct lock_file *lock;
+	struct lock_file lock = LOCK_INIT;
 	int out_fd;
 	char buf[1024];
 	FILE *config_file = NULL;
@@ -2762,8 +2762,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	if (!config_filename)
 		config_filename = filename_buf = git_pathdup("config");
 
-	lock = xcalloc(1, sizeof(struct lock_file));
-	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
+	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret = error("could not lock config file %s", config_filename);
 		goto out;
@@ -2782,9 +2781,9 @@ int git_config_rename_section_in_file(const char *config_filename,
 		goto out;
 	}
 
-	if (chmod(get_lock_file_path(lock), st.st_mode & 07777) < 0) {
+	if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
 		ret = error_errno("chmod on %s failed",
-				  get_lock_file_path(lock));
+				  get_lock_file_path(&lock));
 		goto out;
 	}
 
@@ -2805,7 +2804,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 				}
 				store.baselen = strlen(new_name);
 				if (write_section(out_fd, new_name) < 0) {
-					ret = write_error(get_lock_file_path(lock));
+					ret = write_error(get_lock_file_path(&lock));
 					goto out;
 				}
 				/*
@@ -2831,20 +2830,20 @@ int git_config_rename_section_in_file(const char *config_filename,
 			continue;
 		length = strlen(output);
 		if (write_in_full(out_fd, output, length) < 0) {
-			ret = write_error(get_lock_file_path(lock));
+			ret = write_error(get_lock_file_path(&lock));
 			goto out;
 		}
 	}
 	fclose(config_file);
 	config_file = NULL;
 commit_and_out:
-	if (commit_lock_file(lock) < 0)
+	if (commit_lock_file(&lock) < 0)
 		ret = error_errno("could not write config file %s",
 				  config_filename);
 out:
 	if (config_file)
 		fclose(config_file);
-	rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 out_no_rollback:
 	free(filename_buf);
 	return ret;
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d2..24c5c26a6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2162,7 +2162,7 @@ int merge_recursive_generic(struct merge_options *o,
 			    struct commit **result)
 {
 	int clean;
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock = LOCK_INIT;
 	struct commit *head_commit = get_ref(head, o->branch1);
 	struct commit *next_commit = get_ref(merge, o->branch2);
 	struct commit_list *ca = NULL;
@@ -2178,14 +2178,14 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	hold_locked_index(lock, LOCK_DIE_ON_ERROR);
+	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
 	if (clean < 0)
 		return clean;
 
 	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return err(o, _("Unable to write index."));
 
 	return clean ? 0 : 1;
diff --git a/merge.c b/merge.c
index 1d441ad94..a18a452b5 100644
--- a/merge.c
+++ b/merge.c
@@ -53,11 +53,11 @@ int checkout_fast_forward(const struct object_id *head,
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, nr_trees = 0;
 	struct dir_struct dir;
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_cache(REFRESH_QUIET);
 
-	if (hold_locked_index(lock_file, LOCK_REPORT_ON_ERROR) < 0)
+	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
@@ -91,8 +91,8 @@ int checkout_fast_forward(const struct object_id *head,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK)) {
-		rollback_lock_file(lock_file);
+	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK)) {
+		rollback_lock_file(&lock_file);
 		return error(_("unable to write new index file"));
 	}
 	return 0;
diff --git a/wt-status.c b/wt-status.c
index 6f730ee8f..7d88e7ca8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2299,14 +2299,14 @@ int has_uncommitted_changes(int ignore_submodules)
  */
 int require_clean_work_tree(const char *action, const char *hint, int ignore_submodules, int gently)
 {
-	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
+	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
-	fd = hold_locked_index(lock_file, 0);
+	fd = hold_locked_index(&lock_file, 0);
 	refresh_cache(REFRESH_QUIET);
 	if (0 <= fd)
-		update_index_if_able(&the_index, lock_file);
-	rollback_lock_file(lock_file);
+		update_index_if_able(&the_index, &lock_file);
+	rollback_lock_file(&lock_file);
 
 	if (has_unstaged_changes(ignore_submodules)) {
 		/* TRANSLATORS: the action is e.g. "pull with rebase" */
-- 
2.14.2.666.gea220ee40

