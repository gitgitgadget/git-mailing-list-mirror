Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3782A1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfHQSm0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45226 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfHQSmX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so4788156pfq.12
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6CJBCvJF8oU1RYoVyDBDuuQX5NuYJf05WU2Awmw9v7s=;
        b=nQc3yT5Q+SSKPccT6evg3MJMioNYWoOnoJGzreEzD2N6YECft33R8JGpFu6s35N8cv
         qTVyYLbJPSgUZ9vR29zwNbqzTEvrVyoU8FzVfEiXrszsHN3BTfeqGItCoJY8Kg8JAzxB
         BNkACp8Bgu9zF2Y+wN7EI8iBNUpXvotXyL+nfm3zPCyhbVM8RvHbi2OrxTUcFM4BJyBo
         b/HjTa7kllwIQCwZGwnypdpEn5WdoBAIJ6vK1Dxe4EXtCJ+UEw14/tvykeSezKORFiS2
         nB9wRgw+H+69kRMB8kdebzmLRKD4X/6RBARFkdad5T3i2mhqLDCyqu7fb3uj9C/9w3Yj
         5qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6CJBCvJF8oU1RYoVyDBDuuQX5NuYJf05WU2Awmw9v7s=;
        b=kyHh76btWivJJVLl3VtW8qgbIjq7aM82jPhB2BzqIsNoygbdV2gfY5snfS+to5CrHK
         VR20MleSvlce4IPoii+w9zGukndaAAhHXoXLqUHxbshRIGJ07W4IJPAbz3QGQgcVkn8O
         MknawV7yU6P0iER7MET8WJw5wRXTckITfNbDJdja0bXnPU9mmYSikF15YBnx2vstPn5R
         45yY4osBe8e1jsqMb0/542ldylVJxAgQ4KpGWYj7rzketBLsNyg4igmu6g57H0X89jpR
         Yuvq6+5pbUteFqBBZx3qxpkK5N7Tpm0Ab8tDA0uX27UCM48mW+Q3tI2783XPxLJOo8WX
         fn3Q==
X-Gm-Message-State: APjAAAVZJs1JAeyRWNwJtv8nAVTeTiaL9HvwdSnJ9vBopgOUKyBgpeM/
        +mC5L230UntNLeGSQ2dElCcI7TT2
X-Google-Smtp-Source: APXvYqzEWj0kMO0BhT1+yB+Ha9L4ReWFUFFqhP6yaQVC5mD5aime5Npxb7dj2XXJmbkiLC2kHt/JDw==
X-Received: by 2002:a17:90a:9f46:: with SMTP id q6mr12666822pjv.110.1566067341892;
        Sat, 17 Aug 2019 11:42:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 21/24] merge-recursive: split internal fields into a separate struct
Date:   Sat, 17 Aug 2019 11:41:41 -0700
Message-Id: <20190817184144.32179-22-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_options has several internal fields that should not be set or read
by external callers.  This just complicates the API.  Move them into an
opaque merge_options_internal struct that is defined only in
merge-recursive.c and keep these out of merge-recursive.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 185 ++++++++++++++++++++++++----------------------
 merge-recursive.h |  17 ++---
 2 files changed, 105 insertions(+), 97 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 262db8bebb..c92993e8f0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -29,6 +29,15 @@
 #include "revision.h"
 #include "commit-reach.h"
 
+struct merge_options_internal {
+	int call_depth;
+	int needed_rename_limit;
+	struct hashmap current_file_dir_set;
+	struct string_list df_conflict_file_set;
+	struct unpack_trees_options unpack_opts;
+	struct index_state orig_index;
+};
+
 struct path_hashmap_entry {
 	struct hashmap_entry e;
 	char path[FLEX_ARRAY];
@@ -309,7 +318,8 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 
 static int show(struct merge_options *opt, int v)
 {
-	return (!opt->call_depth && opt->verbosity >= v) || opt->verbosity >= 5;
+	return (!opt->priv->call_depth && opt->verbosity >= v) ||
+		opt->verbosity >= 5;
 }
 
 __attribute__((format (printf, 3, 4)))
@@ -320,7 +330,7 @@ static void output(struct merge_options *opt, int v, const char *fmt, ...)
 	if (!show(opt, v))
 		return;
 
-	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
+	strbuf_addchars(&opt->obuf, ' ', opt->priv->call_depth * 2);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&opt->obuf, fmt, ap);
@@ -335,7 +345,7 @@ static void output_commit_title(struct merge_options *opt, struct commit *commit
 {
 	struct merge_remote_desc *desc;
 
-	strbuf_addchars(&opt->obuf, ' ', opt->call_depth * 2);
+	strbuf_addchars(&opt->obuf, ' ', opt->priv->call_depth * 2);
 	desc = merge_remote_util(commit);
 	if (desc)
 		strbuf_addf(&opt->obuf, "virtual %s\n", desc->name);
@@ -403,43 +413,43 @@ static int unpack_trees_start(struct merge_options *opt,
 	struct tree_desc t[3];
 	struct index_state tmp_index = { NULL };
 
-	memset(&opt->unpack_opts, 0, sizeof(opt->unpack_opts));
-	if (opt->call_depth)
-		opt->unpack_opts.index_only = 1;
+	memset(&opt->priv->unpack_opts, 0, sizeof(opt->priv->unpack_opts));
+	if (opt->priv->call_depth)
+		opt->priv->unpack_opts.index_only = 1;
 	else
-		opt->unpack_opts.update = 1;
-	opt->unpack_opts.merge = 1;
-	opt->unpack_opts.head_idx = 2;
-	opt->unpack_opts.fn = threeway_merge;
-	opt->unpack_opts.src_index = opt->repo->index;
-	opt->unpack_opts.dst_index = &tmp_index;
-	opt->unpack_opts.aggressive = !merge_detect_rename(opt);
-	setup_unpack_trees_porcelain(&opt->unpack_opts, "merge");
+		opt->priv->unpack_opts.update = 1;
+	opt->priv->unpack_opts.merge = 1;
+	opt->priv->unpack_opts.head_idx = 2;
+	opt->priv->unpack_opts.fn = threeway_merge;
+	opt->priv->unpack_opts.src_index = opt->repo->index;
+	opt->priv->unpack_opts.dst_index = &tmp_index;
+	opt->priv->unpack_opts.aggressive = !merge_detect_rename(opt);
+	setup_unpack_trees_porcelain(&opt->priv->unpack_opts, "merge");
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
 	init_tree_desc_from_tree(t+2, merge);
 
-	rc = unpack_trees(3, t, &opt->unpack_opts);
+	rc = unpack_trees(3, t, &opt->priv->unpack_opts);
 	cache_tree_free(&opt->repo->index->cache_tree);
 
 	/*
-	 * Update opt->repo->index to match the new results, AFTER saving a copy
-	 * in opt->orig_index.  Update src_index to point to the saved copy.
-	 * (verify_uptodate() checks src_index, and the original index is
-	 * the one that had the necessary modification timestamps.)
+	 * Update opt->repo->index to match the new results, AFTER saving a
+	 * copy in opt->priv->orig_index.  Update src_index to point to the
+	 * saved copy.  (verify_uptodate() checks src_index, and the original
+	 * index is the one that had the necessary modification timestamps.)
 	 */
-	opt->orig_index = *opt->repo->index;
+	opt->priv->orig_index = *opt->repo->index;
 	*opt->repo->index = tmp_index;
-	opt->unpack_opts.src_index = &opt->orig_index;
+	opt->priv->unpack_opts.src_index = &opt->priv->orig_index;
 
 	return rc;
 }
 
 static void unpack_trees_finish(struct merge_options *opt)
 {
-	discard_index(&opt->orig_index);
-	clear_unpack_trees_porcelain(&opt->unpack_opts);
+	discard_index(&opt->priv->orig_index);
+	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
 }
 
 static int save_files_dirs(const struct object_id *oid,
@@ -454,7 +464,7 @@ static int save_files_dirs(const struct object_id *oid,
 
 	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
 	hashmap_entry_init(entry, path_hash(entry->path));
-	hashmap_add(&opt->current_file_dir_set, entry);
+	hashmap_add(&opt->priv->current_file_dir_set, entry);
 
 	strbuf_setlen(base, baselen);
 	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -585,7 +595,7 @@ static void record_df_conflict_files(struct merge_options *opt,
 	 * If we're merging merge-bases, we don't want to bother with
 	 * any working directory changes.
 	 */
-	if (opt->call_depth)
+	if (opt->priv->call_depth)
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
@@ -597,7 +607,7 @@ static void record_df_conflict_files(struct merge_options *opt,
 	df_sorted_entries.cmp = string_list_df_name_compare;
 	string_list_sort(&df_sorted_entries);
 
-	string_list_clear(&opt->df_conflict_file_set, 1);
+	string_list_clear(&opt->priv->df_conflict_file_set, 1);
 	for (i = 0; i < df_sorted_entries.nr; i++) {
 		const char *path = df_sorted_entries.items[i].string;
 		int len = strlen(path);
@@ -613,7 +623,7 @@ static void record_df_conflict_files(struct merge_options *opt,
 		    len > last_len &&
 		    memcmp(path, last_file, last_len) == 0 &&
 		    path[last_len] == '/') {
-			string_list_insert(&opt->df_conflict_file_set, last_file);
+			string_list_insert(&opt->priv->df_conflict_file_set, last_file);
 		}
 
 		/*
@@ -680,8 +690,8 @@ static void update_entry(struct stage_data *entry,
 static int remove_file(struct merge_options *opt, int clean,
 		       const char *path, int no_wd)
 {
-	int update_cache = opt->call_depth || clean;
-	int update_working_directory = !opt->call_depth && !no_wd;
+	int update_cache = opt->priv->call_depth || clean;
+	int update_working_directory = !opt->priv->call_depth && !no_wd;
 
 	if (update_cache) {
 		if (remove_file_from_index(opt->repo->index, path))
@@ -724,16 +734,16 @@ static char *unique_path(struct merge_options *opt,
 	add_flattened_path(&newpath, branch);
 
 	base_len = newpath.len;
-	while (hashmap_get_from_hash(&opt->current_file_dir_set,
+	while (hashmap_get_from_hash(&opt->priv->current_file_dir_set,
 				     path_hash(newpath.buf), newpath.buf) ||
-	       (!opt->call_depth && file_exists(newpath.buf))) {
+	       (!opt->priv->call_depth && file_exists(newpath.buf))) {
 		strbuf_setlen(&newpath, base_len);
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
 
 	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
 	hashmap_entry_init(entry, path_hash(entry->path));
-	hashmap_add(&opt->current_file_dir_set, entry);
+	hashmap_add(&opt->priv->current_file_dir_set, entry);
 	return strbuf_detach(&newpath, NULL);
 }
 
@@ -775,7 +785,7 @@ static int dir_in_way(struct index_state *istate, const char *path,
 static int was_tracked_and_matches(struct merge_options *opt, const char *path,
 				   const struct diff_filespec *blob)
 {
-	int pos = index_name_pos(&opt->orig_index, path, strlen(path));
+	int pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
 	struct cache_entry *ce;
 
 	if (0 > pos)
@@ -783,7 +793,7 @@ static int was_tracked_and_matches(struct merge_options *opt, const char *path,
 		return 0;
 
 	/* See if the file we were tracking before matches */
-	ce = opt->orig_index.cache[pos];
+	ce = opt->priv->orig_index.cache[pos];
 	return (oid_eq(&ce->oid, &blob->oid) && ce->ce_mode == blob->mode);
 }
 
@@ -792,7 +802,7 @@ static int was_tracked_and_matches(struct merge_options *opt, const char *path,
  */
 static int was_tracked(struct merge_options *opt, const char *path)
 {
-	int pos = index_name_pos(&opt->orig_index, path, strlen(path));
+	int pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
 
 	if (0 <= pos)
 		/* we were tracking this path before the merge */
@@ -849,12 +859,12 @@ static int was_dirty(struct merge_options *opt, const char *path)
 	struct cache_entry *ce;
 	int dirty = 1;
 
-	if (opt->call_depth || !was_tracked(opt, path))
+	if (opt->priv->call_depth || !was_tracked(opt, path))
 		return !dirty;
 
-	ce = index_file_exists(opt->unpack_opts.src_index,
+	ce = index_file_exists(opt->priv->unpack_opts.src_index,
 			       path, strlen(path), ignore_case);
-	dirty = verify_uptodate(ce, &opt->unpack_opts) != 0;
+	dirty = verify_uptodate(ce, &opt->priv->unpack_opts) != 0;
 	return dirty;
 }
 
@@ -864,8 +874,8 @@ static int make_room_for_path(struct merge_options *opt, const char *path)
 	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
-	for (i = 0; i < opt->df_conflict_file_set.nr; i++) {
-		const char *df_path = opt->df_conflict_file_set.items[i].string;
+	for (i = 0; i < opt->priv->df_conflict_file_set.nr; i++) {
+		const char *df_path = opt->priv->df_conflict_file_set.items[i].string;
 		size_t pathlen = strlen(path);
 		size_t df_pathlen = strlen(df_path);
 		if (df_pathlen < pathlen &&
@@ -875,7 +885,7 @@ static int make_room_for_path(struct merge_options *opt, const char *path)
 			       _("Removing %s to make room for subdirectory\n"),
 			       df_path);
 			unlink(df_path);
-			unsorted_string_list_delete_item(&opt->df_conflict_file_set,
+			unsorted_string_list_delete_item(&opt->priv->df_conflict_file_set,
 							 i, 0);
 			break;
 		}
@@ -916,7 +926,7 @@ static int update_file_flags(struct merge_options *opt,
 {
 	int ret = 0;
 
-	if (opt->call_depth)
+	if (opt->priv->call_depth)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -1001,7 +1011,7 @@ static int update_file(struct merge_options *opt,
 		       const char *path)
 {
 	return update_file_flags(opt, contents, path,
-				 opt->call_depth || clean, !opt->call_depth);
+				 opt->priv->call_depth || clean, !opt->priv->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -1030,7 +1040,7 @@ static int merge_3way(struct merge_options *opt,
 	ll_opts.extra_marker_size = extra_marker_size;
 	ll_opts.xdl_opts = opt->xdl_opts;
 
-	if (opt->call_depth) {
+	if (opt->priv->call_depth) {
 		ll_opts.virtual_ancestor = 1;
 		ll_opts.variant = 0;
 	} else {
@@ -1161,7 +1171,7 @@ static int merge_submodule(struct merge_options *opt,
 	struct object_array merges;
 
 	int i;
-	int search = !opt->call_depth;
+	int search = !opt->priv->call_depth;
 
 	/* store a in result in case we fail */
 	oidcpy(result, a);
@@ -1383,7 +1393,7 @@ static int handle_rename_via_dir(struct merge_options *opt,
 			       MERGE_DIRECTORY_RENAMES_CONFLICT);
 	assert(ren->dir_rename_original_dest);
 
-	if (!opt->call_depth && would_lose_untracked(opt, dest->path)) {
+	if (!opt->priv->call_depth && would_lose_untracked(opt, dest->path)) {
 		mark_conflicted = 1;
 		file_path = unique_path(opt, dest->path, ren->branch);
 		output(opt, 1, _("Error: Refusing to lose untracked file at %s; "
@@ -1426,12 +1436,12 @@ static int handle_change_delete(struct merge_options *opt,
 	const char *update_path = path;
 	int ret = 0;
 
-	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0) ||
-	    (!opt->call_depth && would_lose_untracked(opt, path))) {
+	if (dir_in_way(opt->repo->index, path, !opt->priv->call_depth, 0) ||
+	    (!opt->priv->call_depth && would_lose_untracked(opt, path))) {
 		update_path = alt_path = unique_path(opt, path, change_branch);
 	}
 
-	if (opt->call_depth) {
+	if (opt->priv->call_depth) {
 		/*
 		 * We cannot arbitrarily accept either a_sha or b_sha as
 		 * correct; since there is no true "middle point" between
@@ -1506,14 +1516,14 @@ static int handle_rename_delete(struct merge_options *opt,
 				     opt->branch2 : opt->branch1);
 
 	if (handle_change_delete(opt,
-				 opt->call_depth ? orig->path : dest->path,
-				 opt->call_depth ? NULL : orig->path,
+				 opt->priv->call_depth ? orig->path : dest->path,
+				 opt->priv->call_depth ? NULL : orig->path,
 				 orig, dest,
 				 rename_branch, delete_branch,
 				 _("rename"), _("renamed")))
 		return -1;
 
-	if (opt->call_depth)
+	if (opt->priv->call_depth)
 		return remove_file_from_index(opt->repo->index, dest->path);
 	else
 		return update_stages(opt, dest->path, NULL,
@@ -1550,7 +1560,7 @@ static int handle_file_collision(struct merge_options *opt,
 	/*
 	 * In the recursive case, we just opt to undo renames
 	 */
-	if (opt->call_depth && (prev_path1 || prev_path2)) {
+	if (opt->priv->call_depth && (prev_path1 || prev_path2)) {
 		/* Put first file (a->oid, a->mode) in its original spot */
 		if (prev_path1) {
 			if (update_file(opt, 1, a, prev_path1))
@@ -1579,10 +1589,10 @@ static int handle_file_collision(struct merge_options *opt,
 	/* Remove rename sources if rename/add or rename/rename(2to1) */
 	if (prev_path1)
 		remove_file(opt, 1, prev_path1,
-			    opt->call_depth || would_lose_untracked(opt, prev_path1));
+			    opt->priv->call_depth || would_lose_untracked(opt, prev_path1));
 	if (prev_path2)
 		remove_file(opt, 1, prev_path2,
-			    opt->call_depth || would_lose_untracked(opt, prev_path2));
+			    opt->priv->call_depth || would_lose_untracked(opt, prev_path2));
 
 	/*
 	 * Remove the collision path, if it wouldn't cause dirty contents
@@ -1624,12 +1634,12 @@ static int handle_file_collision(struct merge_options *opt,
 	null.mode = 0;
 
 	if (merge_mode_and_contents(opt, &null, a, b, collide_path,
-				    branch1, branch2, opt->call_depth * 2, &mfi))
+				    branch1, branch2, opt->priv->call_depth * 2, &mfi))
 		return -1;
 	mfi.clean &= !alt_path;
 	if (update_file(opt, mfi.clean, &mfi.blob, update_path))
 		return -1;
-	if (!mfi.clean && !opt->call_depth &&
+	if (!mfi.clean && !opt->priv->call_depth &&
 	    update_stages(opt, collide_path, NULL, a, b))
 		return -1;
 	free(alt_path);
@@ -1669,7 +1679,7 @@ static int handle_rename_add(struct merge_options *opt,
 				    &ci->ren1->src_entry->stages[other_stage],
 				    prev_path_desc,
 				    opt->branch1, opt->branch2,
-				    1 + opt->call_depth * 2, &mfi))
+				    1 + opt->priv->call_depth * 2, &mfi))
 		return -1;
 	free(prev_path_desc);
 
@@ -1687,7 +1697,7 @@ static char *find_path_for_conflict(struct merge_options *opt,
 				    const char *branch2)
 {
 	char *new_path = NULL;
-	if (dir_in_way(opt->repo->index, path, !opt->call_depth, 0)) {
+	if (dir_in_way(opt->repo->index, path, !opt->priv->call_depth, 0)) {
 		new_path = unique_path(opt, path, branch1);
 		output(opt, 1, _("%s is a directory in %s adding "
 			       "as %s instead"),
@@ -1718,17 +1728,17 @@ static int handle_rename_rename_1to2(struct merge_options *opt,
 	       "rename \"%s\"->\"%s\" in \"%s\"%s"),
 	       o->path, a->path, ci->ren1->branch,
 	       o->path, b->path, ci->ren2->branch,
-	       opt->call_depth ? _(" (left unresolved)") : "");
+	       opt->priv->call_depth ? _(" (left unresolved)") : "");
 
 	path_desc = xstrfmt("%s and %s, both renamed from %s",
 			    a->path, b->path, o->path);
 	if (merge_mode_and_contents(opt, o, a, b, path_desc,
 				    ci->ren1->branch, ci->ren2->branch,
-				    opt->call_depth * 2, &mfi))
+				    opt->priv->call_depth * 2, &mfi))
 		return -1;
 	free(path_desc);
 
-	if (opt->call_depth) {
+	if (opt->priv->call_depth) {
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
@@ -1843,12 +1853,12 @@ static int handle_rename_rename_2to1(struct merge_options *opt,
 				    &ci->ren1->src_entry->stages[ostage1],
 				    path_side_1_desc,
 				    opt->branch1, opt->branch2,
-				    1 + opt->call_depth * 2, &mfi_c1) ||
+				    1 + opt->priv->call_depth * 2, &mfi_c1) ||
 	    merge_mode_and_contents(opt, b,
 				    &ci->ren2->src_entry->stages[ostage2],
 				    c2, path_side_2_desc,
 				    opt->branch1, opt->branch2,
-				    1 + opt->call_depth * 2, &mfi_c2))
+				    1 + opt->priv->call_depth * 2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
@@ -1889,8 +1899,8 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *opt,
 	diff_setup_done(&opts);
 	diff_tree_oid(&o_tree->object.oid, &tree->object.oid, "", &opts);
 	diffcore_std(&opts);
-	if (opts.needed_rename_limit > opt->needed_rename_limit)
-		opt->needed_rename_limit = opts.needed_rename_limit;
+	if (opts.needed_rename_limit > opt->priv->needed_rename_limit)
+		opt->priv->needed_rename_limit = opts.needed_rename_limit;
 
 	ret = xmalloc(sizeof(*ret));
 	*ret = diff_queued_diff;
@@ -2865,7 +2875,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 	if ((opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) ||
 	    (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_CONFLICT &&
-	     !opt->call_depth)) {
+	     !opt->priv->call_depth)) {
 		dir_re_head = get_directory_renames(head_pairs);
 		dir_re_merge = get_directory_renames(merge_pairs);
 
@@ -3022,13 +3032,13 @@ static int handle_content_merge(struct merge_file_info *mfi,
 		reason = _("add/add");
 
 	assert(o->path && a->path && b->path);
-	if (ci && dir_in_way(opt->repo->index, path, !opt->call_depth,
+	if (ci && dir_in_way(opt->repo->index, path, !opt->priv->call_depth,
 			     S_ISGITLINK(ci->ren1->pair->two->mode)))
 		df_conflict_remains = 1;
 
 	if (merge_mode_and_contents(opt, o, a, b, path,
 				    opt->branch1, opt->branch2,
-				    opt->call_depth * 2, mfi))
+				    opt->priv->call_depth * 2, mfi))
 		return -1;
 
 	/*
@@ -3044,7 +3054,7 @@ static int handle_content_merge(struct merge_file_info *mfi,
 
 		output(opt, 3, _("Skipped %s (merged same as existing)"), path);
 		if (add_cacheinfo(opt, &mfi->blob, path,
-				  0, (!opt->call_depth && !is_dirty), 0))
+				  0, (!opt->priv->call_depth && !is_dirty), 0))
 			return -1;
 		/*
 		 * However, add_cacheinfo() will delete the old cache entry
@@ -3052,8 +3062,8 @@ static int handle_content_merge(struct merge_file_info *mfi,
 		 * flag to avoid making the file appear as if it were
 		 * deleted by the user.
 		 */
-		pos = index_name_pos(&opt->orig_index, path, strlen(path));
-		ce = opt->orig_index.cache[pos];
+		pos = index_name_pos(&opt->priv->orig_index, path, strlen(path));
+		ce = opt->priv->orig_index.cache[pos];
 		if (ce_skip_worktree(ce)) {
 			pos = index_name_pos(opt->repo->index, path, strlen(path));
 			ce = opt->repo->index->cache[pos];
@@ -3074,7 +3084,7 @@ static int handle_content_merge(struct merge_file_info *mfi,
 
 	if (df_conflict_remains || is_dirty) {
 		char *new_path;
-		if (opt->call_depth) {
+		if (opt->priv->call_depth) {
 			remove_file_from_index(opt->repo->index, path);
 		} else {
 			if (!mfi->clean) {
@@ -3333,7 +3343,7 @@ static int process_entry(struct merge_options *opt,
 			conf = _("directory/file");
 		}
 		if (dir_in_way(opt->repo->index, path,
-			       !opt->call_depth && !S_ISGITLINK(a->mode),
+			       !opt->priv->call_depth && !S_ISGITLINK(a->mode),
 			       0)) {
 			char *new_path = unique_path(opt, path, add_branch);
 			clean_merge = 0;
@@ -3342,7 +3352,7 @@ static int process_entry(struct merge_options *opt,
 			       conf, path, other_branch, path, new_path);
 			if (update_file(opt, 0, contents, new_path))
 				clean_merge = -1;
-			else if (opt->call_depth)
+			else if (opt->priv->call_depth)
 				remove_file_from_index(opt->repo->index, path);
 			free(new_path);
 		} else {
@@ -3407,7 +3417,7 @@ static int merge_trees_internal(struct merge_options *opt,
 	code = unpack_trees_start(opt, merge_base, head, merge);
 
 	if (code != 0) {
-		if (show(opt, 4) || opt->call_depth)
+		if (show(opt, 4) || opt->priv->call_depth)
 			err(opt, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
@@ -3426,7 +3436,7 @@ static int merge_trees_internal(struct merge_options *opt,
 		 * opposed to decaring a local hashmap is for convenience
 		 * so that we don't have to pass it to around.
 		 */
-		hashmap_init(&opt->current_file_dir_set, path_hashmap_cmp,
+		hashmap_init(&opt->priv->current_file_dir_set, path_hashmap_cmp,
 			     NULL, 512);
 		get_files_dirs(opt, head);
 		get_files_dirs(opt, merge);
@@ -3463,7 +3473,7 @@ static int merge_trees_internal(struct merge_options *opt,
 		string_list_clear(entries, 1);
 		free(entries);
 
-		hashmap_free(&opt->current_file_dir_set, 1);
+		hashmap_free(&opt->priv->current_file_dir_set, 1);
 
 		if (clean < 0) {
 			unpack_trees_finish(opt);
@@ -3475,7 +3485,7 @@ static int merge_trees_internal(struct merge_options *opt,
 
 	unpack_trees_finish(opt);
 
-	if (opt->call_depth &&
+	if (opt->priv->call_depth &&
 	    !(*result = write_in_core_index_as_tree(opt->repo)))
 		return -1;
 
@@ -3550,7 +3560,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 
 	for (iter = merge_bases; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
-		opt->call_depth++;
+		opt->priv->call_depth++;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -3569,14 +3579,14 @@ static int merge_recursive_internal(struct merge_options *opt,
 			return -1;
 		opt->branch1 = saved_b1;
 		opt->branch2 = saved_b2;
-		opt->call_depth--;
+		opt->priv->call_depth--;
 
 		if (!merged_merge_bases)
 			return err(opt, _("merge returned no commit"));
 	}
 
 	discard_index(opt->repo->index);
-	if (!opt->call_depth)
+	if (!opt->priv->call_depth)
 		repo_read_index(opt->repo);
 
 	opt->ancestor = ancestor_name;
@@ -3592,7 +3602,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 		return clean;
 	}
 
-	if (opt->call_depth) {
+	if (opt->priv->call_depth) {
 		*result = make_virtual_commit(opt->repo, result_tree,
 					      "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
@@ -3612,17 +3622,20 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 		return -1;
 	}
 
+	opt->priv = xcalloc(1, sizeof(*opt->priv));
+	string_list_init(&opt->priv->df_conflict_file_set, 1);
 	return 0;
 }
 
 static void merge_finalize(struct merge_options *opt)
 {
 	flush_output(opt);
-	if (!opt->call_depth && opt->buffer_output < 2)
+	if (!opt->priv->call_depth && opt->buffer_output < 2)
 		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
-				       opt->needed_rename_limit, 0);
+				       opt->priv->needed_rename_limit, 0);
+	FREE_AND_NULL(opt->priv);
 }
 
 int merge_trees(struct merge_options *opt,
@@ -3767,8 +3780,6 @@ void init_merge_options(struct merge_options *opt,
 
 	opt->renormalize = 0;
 
-	string_list_init(&opt->df_conflict_file_set, 1);
-
 	merge_recursive_config(opt);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index 933d6e7642..58a4c5238a 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,13 +1,15 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
-#include "string-list.h"
-#include "unpack-trees.h"
+#include "strbuf.h"
 
 struct commit;
-
+struct commit_list;
+struct object_id;
 struct repository;
+struct tree;
 
+struct merge_options_internal;
 struct merge_options {
 	struct repository *repo;
 
@@ -45,13 +47,8 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned renormalize : 1;
 
-	/* internal fields used by the implementation (do NOT set these) */
-	int call_depth;
-	int needed_rename_limit;
-	struct hashmap current_file_dir_set;
-	struct string_list df_conflict_file_set;
-	struct unpack_trees_options unpack_opts;
-	struct index_state orig_index;
+	/* internal fields used by the implementation */
+	struct merge_options_internal *priv;
 };
 
 void init_merge_options(struct merge_options *opt, struct repository *repo);
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

