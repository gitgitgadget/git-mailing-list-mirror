Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 842A3207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdEBWXd (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:33 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33602 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdEBWXb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:31 -0400
Received: by mail-pg0-f42.google.com with SMTP id y4so62825491pge.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wkg8Y4/e9kEF2QuoQbFfGYjJn5XO0vyqdB53aubHm7c=;
        b=JWLggiD3X1mmA5VOum3yk78VQ5cZ3dXMVA/nvjsOuIbMx3MmqD4Wy1/AOgyrRwGj4p
         ilDdxMHhDIzK9nXoEywB8YW+tw75yQy39Hr/L8nAFkbdIRae69718ZEIZ8QfeD/yJYAI
         JwrTHk8g27Fe5z4MRraPTA6Q7AsWTs9OrV756jWvffCQUUr2Rr8KEw1pVM+Ts190sRTk
         lir2MZacDqMPgHjwbC/IH/3ujE29BUNnG0MRHpFKAYAqAbOM6DrfH4W3hbhzFSIA6Y8l
         rd88sB8uvDtH5eQNnQpC1j9rEyoqnd7gdkOQIt/lr4Ak+i64IBjpukOevbdh4Q7e3IiD
         e6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wkg8Y4/e9kEF2QuoQbFfGYjJn5XO0vyqdB53aubHm7c=;
        b=GYK5cKjpnXhX8JXpWz+VhMLWao3h+rXfK26imYbuMjy1AWu/89F8QgK1n6I/Bf61OE
         ybBQCQN3Px57RBX0fvRHHF2XrctZM9ZYW6vyweM3OzQkm5YavVprtzrLI+aOLIY0z3tM
         1dj6vlmCH0kdUjulOa0qWq0V0/9iPG6QyUnSV0EZjiGfJNtTRqtJLr/ZnOv5om88x613
         QMItggqqhY4u73VZ4DHQygJQ04pfWIlV7HHqJZVKlwzv/0oiz6EDQDTWsau1NsMsN9AW
         btrkBHH/8CAMIgT05br7fx0K8Dw5wzpoDyDzM8uHPmJ9PnH30Sk7jWZa3aC40uwvGam4
         Yi1A==
X-Gm-Message-State: AN3rC/4ONwP97hj1qy2srkLI0CBOOJcNutLtIZJbxHwha3mqOAOfdJ/v
        05rbHc66jlXs5V5D
X-Received: by 10.98.4.133 with SMTP id 127mr1386209pfe.54.1493763810300;
        Tue, 02 May 2017 15:23:30 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id n77sm706731pfj.66.2017.05.02.15.23.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/24] cache.h: drop read_cache()
Date:   Tue,  2 May 2017 15:22:59 -0700
Message-Id: <20170502222322.21055-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is produced via coccinelle using this semantic patch:

@@ @@
-read_cache()
+read_index(&the_index)

Additional manual editing:
* drop define in cache.h
* a comment in builtin/check-ignore.c and read-cache.c were
  converted
* builtin/diff.c: fix error message referencing the function.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c                              |  2 +-
 builtin/add.c                        |  4 ++--
 builtin/am.c                         |  2 +-
 builtin/blame.c                      |  4 ++--
 builtin/check-attr.c                 |  2 +-
 builtin/check-ignore.c               |  4 ++--
 builtin/checkout-index.c             |  2 +-
 builtin/clean.c                      |  2 +-
 builtin/commit.c                     |  4 ++--
 builtin/diff-index.c                 |  2 +-
 builtin/diff.c                       |  6 +++---
 builtin/fsck.c                       |  2 +-
 builtin/grep.c                       |  2 +-
 builtin/ls-files.c                   |  2 +-
 builtin/merge-index.c                |  2 +-
 builtin/mv.c                         |  2 +-
 builtin/reset.c                      |  2 +-
 builtin/rev-parse.c                  |  2 +-
 builtin/rm.c                         |  2 +-
 builtin/submodule--helper.c          |  2 +-
 builtin/update-index.c               |  2 +-
 cache.h                              |  1 -
 check-racy.c                         |  2 +-
 diff.c                               |  2 +-
 merge-recursive.c                    |  2 +-
 merge.c                              |  2 +-
 read-cache.c                         |  2 +-
 rerere.c                             |  6 +++---
 revision.c                           |  4 ++--
 sequencer.c                          |  6 +++---
 sha1_name.c                          |  2 +-
 submodule.c                          |  4 ++--
 t/helper/test-dump-cache-tree.c      |  2 +-
 t/helper/test-dump-untracked-cache.c |  2 +-
 t/helper/test-lazy-init-name-hash.c  | 10 +++++-----
 t/helper/test-read-cache.c           |  2 +-
 t/helper/test-scrap-cache-tree.c     |  2 +-
 37 files changed, 52 insertions(+), 53 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26ad..82701d6580 100644
--- a/apply.c
+++ b/apply.c
@@ -3987,7 +3987,7 @@ static int read_apply_cache(struct apply_state *state)
 	if (state->index_file)
 		return read_cache_from(state->index_file);
 	else
-		return read_cache();
+		return read_index(&the_index);
 }
 
 /* This function tries to read the object name from the current index */
diff --git a/builtin/add.c b/builtin/add.c
index 9f53f020d0..ab6d04e8db 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -205,7 +205,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("Could not read the index"));
 
 	init_revisions(&rev, prefix);
@@ -376,7 +376,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	/*
diff --git a/builtin/am.c b/builtin/am.c
index a95dd8b4e6..4405d7307c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1633,7 +1633,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	say(state, stdout, _("Falling back to patching base and 3-way merge..."));
 
 	discard_cache();
-	read_cache();
+	read_index(&the_index);
 
 	/*
 	 * This is not so wrong. Depending on which base we picked, orig_tree
diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e45..59955208fd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_cache();
+	read_index(&the_index);
 	time(&now);
 	commit = alloc_commit_node();
 	commit->object.parsed = 1;
@@ -2395,7 +2395,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 * want to run "diff-index --cached".
 	 */
 	discard_cache();
-	read_cache();
+	read_index(&the_index);
 
 	len = strlen(path);
 	if (!mode) {
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 4d01ca0c8b..9cc3675d62 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -114,7 +114,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
-	if (read_cache() < 0) {
+	if (read_index(&the_index) < 0) {
 		die("invalid cache");
 	}
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 1d73d3ca3d..e526b27151 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -167,8 +167,8 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	if (show_non_matching && !verbose)
 		die(_("--non-matching is only valid with --verbose"));
 
-	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (!no_index && read_cache() < 0)
+	/* read_index() is only necessary so we can watch out for submodules. */
+	if (!no_index && read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	memset(&dir, 0, sizeof(dir));
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 07631d0c9c..676b9419f0 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -185,7 +185,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
-	if (read_cache() < 0) {
+	if (read_index(&the_index) < 0) {
 		die("invalid cache");
 	}
 
diff --git a/builtin/clean.c b/builtin/clean.c
index d861f836a2..9bdefca6dc 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -916,7 +916,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	if (!ignored)
diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da8..7cd08841a1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -465,7 +465,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		exit(1);
 
 	discard_cache();
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("cannot read the index"));
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
@@ -888,7 +888,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct object_id oid;
 		const char *parent = "HEAD";
 
-		if (!active_nr && read_cache() < 0)
+		if (!active_nr && read_index(&the_index) < 0)
 			die(_("Cannot read index"));
 
 		if (amend)
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1af373d002..49fd64d4ce 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -48,7 +48,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
+	} else if (read_index(&the_index) < 0) {
 		perror("read_cache");
 		return -1;
 	}
diff --git a/builtin/diff.c b/builtin/diff.c
index d184aafab9..ed9edb2d0c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -148,8 +148,8 @@ static int builtin_diff_index(struct rev_info *revs,
 			perror("read_cache_preload");
 			return -1;
 		}
-	} else if (read_cache() < 0) {
-		perror("read_cache");
+	} else if (read_index(&the_index) < 0) {
+		perror("read_index");
 		return -1;
 	}
 	return run_diff_index(revs, cached);
@@ -210,7 +210,7 @@ static void refresh_index_quietly(void)
 	if (fd < 0)
 		return;
 	discard_cache();
-	read_cache();
+	read_index(&the_index);
 	refresh_cache(REFRESH_QUIET|REFRESH_UNMERGED);
 	update_index_if_able(&the_index, lock_file);
 }
diff --git a/builtin/fsck.c b/builtin/fsck.c
index b5e13a4556..35e03556cb 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -772,7 +772,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	if (keep_cache_objects) {
 		verify_index_checksum = 1;
-		read_cache();
+		read_index(&the_index);
 		for (i = 0; i < active_nr; i++) {
 			unsigned int mode;
 			struct blob *blob;
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e81..5153dbf262 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -676,7 +676,7 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
 		strbuf_addstr(&name, super_prefix);
 	}
 
-	read_cache();
+	read_index(&the_index);
 
 	for (nr = 0; nr < active_nr; nr++) {
 		const struct cache_entry *ce = active_cache[nr];
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a6c70dbe9e..da4779ec0b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -578,7 +578,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	super_prefix = get_super_prefix();
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index c99443b095..51fb590dfa 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -77,7 +77,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	if (argc < 3)
 		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
-	read_cache();
+	read_index(&the_index);
 
 	i = 1;
 	if (!strcmp(argv[i], "-o")) {
diff --git a/builtin/mv.c b/builtin/mv.c
index 61d20037ad..6fd7a3a9d8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -139,7 +139,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_mv_usage, builtin_mv_options);
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	source = internal_prefix_pathspec(prefix, argv, argc, 0);
diff --git a/builtin/reset.c b/builtin/reset.c
index fc3b906c47..03c5498d6e 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -231,7 +231,7 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	parse_pathspec(pathspec, 0,
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0513330910..0c6352a018 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -868,7 +868,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--shared-index-path")) {
-				if (read_cache() < 0)
+				if (read_index(&the_index) < 0)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
diff --git a/builtin/rm.c b/builtin/rm.c
index fb79dcab18..d0eecbdaac 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -267,7 +267,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	parse_pathspec(&pathspec, 0,
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 566a5b6a6f..1281056312 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -240,7 +240,7 @@ static int module_list_compute(int argc, const char **argv,
 	if (pathspec->nr)
 		ps_matched = xcalloc(pathspec->nr, 1);
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("index file corrupt"));
 
 	for (i = 0; i < active_nr; i++) {
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ebfc09faa0..7a4b914af4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1021,7 +1021,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (newfd < 0)
 		lock_error = errno;
 
-	entries = read_cache();
+	entries = read_index(&the_index);
 	if (entries < 0)
 		die("cache corrupted");
 
diff --git a/cache.h b/cache.h
index e1f0e182ad..9a1ea38a14 100644
--- a/cache.h
+++ b/cache.h
@@ -360,7 +360,6 @@ extern void free_name_hash(struct index_state *istate);
 #define active_cache_changed (the_index.cache_changed)
 #define active_cache_tree (the_index.cache_tree)
 
-#define read_cache() read_index(&the_index)
 #define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
diff --git a/check-racy.c b/check-racy.c
index 24b6542352..f50b21cb06 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -6,7 +6,7 @@ int main(int ac, char **av)
 	int dirty, clean, racy;
 
 	dirty = clean = racy = 0;
-	read_cache();
+	read_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		struct stat st;
diff --git a/diff.c b/diff.c
index 11eef1c85d..05d0312265 100644
--- a/diff.c
+++ b/diff.c
@@ -3497,7 +3497,7 @@ void diff_setup_done(struct diff_options *options)
 			 * when it fails, so we do not have to worry about
 			 * cleaning it up ourselves either.
 			 */
-			read_cache();
+			read_index(&the_index);
 	}
 	if (40 < options->abbrev)
 		options->abbrev = 40; /* full */
diff --git a/merge-recursive.c b/merge-recursive.c
index 62decd51cc..3cfaf33faa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2075,7 +2075,7 @@ int merge_recursive(struct merge_options *o,
 
 	discard_cache();
 	if (!o->call_depth)
-		read_cache();
+		read_index(&the_index);
 
 	o->ancestor = "merged common ancestors";
 	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
diff --git a/merge.c b/merge.c
index 04ee5fc911..748305031e 100644
--- a/merge.c
+++ b/merge.c
@@ -37,7 +37,7 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	argv_array_clear(&args);
 
 	discard_cache();
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die(_("failed to read the cache"));
 	resolve_undo_clear();
 
diff --git a/read-cache.c b/read-cache.c
index b3d0f3c30b..f1bdb006f4 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2506,7 +2506,7 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
  * index_state, dropping any unmerged entries.  Returns true if
  * the index is unmerged.  Callers who want to refuse to work
  * from an unmerged state can call this and check its return value,
- * instead of calling read_cache().
+ * instead of calling read_index().
  */
 int read_index_unmerged(struct index_state *istate)
 {
diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..770b34a5c9 100644
--- a/rerere.c
+++ b/rerere.c
@@ -566,7 +566,7 @@ static int check_one_conflict(int i, int *type)
 static int find_conflict(struct string_list *conflict)
 {
 	int i;
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
 	for (i = 0; i < active_nr;) {
@@ -599,7 +599,7 @@ int rerere_remaining(struct string_list *merge_rr)
 	int i;
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
 	for (i = 0; i < active_nr;) {
@@ -1104,7 +1104,7 @@ int rerere_forget(struct pathspec *pathspec)
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		return error("Could not read index");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
diff --git a/revision.c b/revision.c
index 7ff61ff5f7..bb6250ef02 100644
--- a/revision.c
+++ b/revision.c
@@ -1267,7 +1267,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 {
 	int i;
 
-	read_cache();
+	read_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 		struct blob *blob;
@@ -1408,7 +1408,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	head->object.flags |= SYMMETRIC_LEFT;
 
 	if (!active_nr)
-		read_cache();
+		read_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_stage(ce))
diff --git a/sequencer.c b/sequencer.c
index 10c3b4ff81..b7ec4e3221 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -381,7 +381,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	read_cache();
+	read_index(&the_index);
 	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
@@ -437,7 +437,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 
-	read_cache();
+	read_index(&the_index);
 
 	init_merge_options(&o);
 	o.ancestor = base ? base_label : "(empty tree)";
@@ -1844,7 +1844,7 @@ static int do_exec(const char *command_line)
 	status = run_command_v_opt(child_argv, RUN_USING_SHELL);
 
 	/* force re-reading of the cache */
-	if (discard_cache() < 0 || read_cache() < 0)
+	if (discard_cache() < 0 || read_index(&the_index) < 0)
 		return error(_("could not read index"));
 
 	dirty = require_clean_work_tree("rebase", NULL, 1, 1);
diff --git a/sha1_name.c b/sha1_name.c
index 8eec9f7c1b..38473b1e6d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1552,7 +1552,7 @@ static int get_sha1_with_context_1(const char *name,
 		strlcpy(oc->path, cp, sizeof(oc->path));
 
 		if (!active_cache)
-			read_cache();
+			read_index(&the_index);
 		pos = cache_name_pos(cp, namelen);
 		if (pos < 0)
 			pos = -pos - 1;
diff --git a/submodule.c b/submodule.c
index d3299e29c0..4d77291b11 100644
--- a/submodule.c
+++ b/submodule.c
@@ -177,7 +177,7 @@ void gitmodules_config(void)
 		int pos;
 		strbuf_addstr(&gitmodules_path, work_tree);
 		strbuf_addstr(&gitmodules_path, "/.gitmodules");
-		if (read_cache() < 0)
+		if (read_index(&the_index) < 0)
 			die("index file corrupt");
 		pos = cache_name_pos(".gitmodules", 11);
 		if (pos < 0) { /* .gitmodules not found or isn't merged */
@@ -1151,7 +1151,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	if (!spf.work_tree)
 		goto out;
 
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die("index file corrupt");
 
 	argv_array_push(&spf.args, "fetch");
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 7af116d49e..ed037a52f4 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -59,7 +59,7 @@ int cmd_main(int ac, const char **av)
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
 	setup_git_directory();
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die("unable to read index file");
 	istate = the_index;
 	istate.cache_tree = another;
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index f752532ffb..7832e833af 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -47,7 +47,7 @@ int cmd_main(int ac, const char **av)
 	ignore_untracked_cache_config = 1;
 
 	setup_git_directory();
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die("unable to read index file");
 	uc = the_index.untracked;
 	if (!uc) {
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 6368a89345..bd747dcbcd 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -31,7 +31,7 @@ static void dump_run(void)
 	struct dir_entry *dir;
 	struct cache_entry *ce;
 
-	read_cache();
+	read_index(&the_index);
 	if (single) {
 		test_lazy_init_name_hash(&the_index, 0);
 	} else {
@@ -69,7 +69,7 @@ static uint64_t time_runs(int try_threaded)
 
 	for (i = 0; i < count; i++) {
 		t0 = getnanotime();
-		read_cache();
+		read_index(&the_index);
 		t1 = getnanotime();
 		nr_threads_used = test_lazy_init_name_hash(&the_index, try_threaded);
 		t2 = getnanotime();
@@ -116,7 +116,7 @@ static void analyze_run(void)
 	int i;
 	int nr;
 
-	read_cache();
+	read_index(&the_index);
 	cache_nr_limit = the_index.cache_nr;
 	discard_cache();
 
@@ -131,7 +131,7 @@ static void analyze_run(void)
 			nr = cache_nr_limit;
 
 		for (i = 0; i < count; i++) {
-			read_cache();
+			read_index(&the_index);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1s = getnanotime();
 			test_lazy_init_name_hash(&the_index, 0);
@@ -140,7 +140,7 @@ static void analyze_run(void)
 			the_index.cache_nr = cache_nr_limit;
 			discard_cache();
 
-			read_cache();
+			read_index(&the_index);
 			the_index.cache_nr = nr; /* cheap truncate of index */
 			t1m = getnanotime();
 			nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 48255eef31..b4aa339ddb 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -7,7 +7,7 @@ int cmd_main(int argc, const char **argv)
 		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
 	for (i = 0; i < cnt; i++) {
-		read_cache();
+		read_index(&the_index);
 		discard_cache();
 	}
 	return 0;
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index d2a63bea43..b02a679166 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -9,7 +9,7 @@ int cmd_main(int ac, const char **av)
 {
 	setup_git_directory();
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-	if (read_cache() < 0)
+	if (read_index(&the_index) < 0)
 		die("unable to read index file");
 	active_cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-- 
2.13.0.rc1.39.ga6db8bfa24

