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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA26C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364FA60FE7
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhGaR2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhGaR1z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4DC0613CF
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h13so2238658wrp.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+mAd0JUlMqph96PBZ0W+GdwMnFsO1xwtoZY87818VeI=;
        b=G6sVwsxqQlD6EfGUncJc5/T/kzHa/zGlBAs3qZjjGnhHDtHYqzFB9WJhkud7cKhibS
         mJJDfzZGpZCYw98gR5WKCq7JbcL9UiYblK2OtefYSvmoWXDdi8umydIZFcPLJY8cNYds
         Dazcd1lt7jvOxM5TFeFa1Tw32czUHj7qjYovWuLgqrpHPP8rUJALoTrGWjhdRxTWns6u
         EnOXRDbacyPCOjLuPQAemUvt1DGO+dpgcA2gj+tGSazidcl0ephFMzIMzRO5c7ngERRT
         OhyhlwAraZ/0U3XDgIGmKQgtgtnQxzNGdbugnpPU27QNODEbMSzBX+RCWN95gPlB+s5a
         uh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+mAd0JUlMqph96PBZ0W+GdwMnFsO1xwtoZY87818VeI=;
        b=h+4dEPhKmu7+5jcMKGRAf2W28Wb2RqEF3fcOR7GKZMWmCuuYeUwcimmkfsl0++RaR0
         M4Iqxaii4Xg+cdJps9u2jWQB5z1dQn2SDEjHPJC/fulTCFPMBFT8W+s49bSnyynpRkcy
         5f2nR9HclzF/ZX884IB0G0K37X09qikaIGTWYVaK/2jaHTUyafd1pXhJdDr///lDl3FF
         xk2WS+gbGhUQ0FRabW57vrnlr7kn/LghKoDVXGXn4E1+1X2BE0sQPHrfwHXS8JC0ZZea
         iHvhtapCXSdfCd24no6xDN8HrLXgs5sVNIYkZb0I2B0y8ZiBbP6prYbXD6r46YrR5i63
         saUw==
X-Gm-Message-State: AOAM532CWAQ6KTSl6DJz7RvM6e/VzMA+Iq6uFbxnAPZ7x/GYALcT++me
        V7g6pso9CJw6ZKw9i9RDLhSHPmeov6Y=
X-Google-Smtp-Source: ABdhPJxS+CDrwVvKZ7t5oWHvpL4MtLaLflzbAYmkPKsfYrHiFS0MCYP2aKKgGz6YDlSnlHKGjccbSw==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr9302987wro.390.1627752467666;
        Sat, 31 Jul 2021 10:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o34sm5211974wms.10.2021.07.31.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:47 -0700 (PDT)
Message-Id: <f8cd50794e9ae8974ef350218a1f205e007f969d.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:38 +0000
Subject: [PATCH v4 9/9] merge-ort: remove compile-time ability to turn off
 usage of memory pools
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Simplify code maintenance by removing the ability to toggle between
usage of memory pools and direct allocations.  This allows us to also
remove paths_to_free since it was solely about bookkeeping to make sure
we freed the necessary paths, and allows us to remove some auxiliary
functions.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 209 ++++++++++++----------------------------------------
 1 file changed, 47 insertions(+), 162 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 86ab8f60121..88ade50f4ed 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -37,8 +37,6 @@
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
 
-#define USE_MEMORY_POOL 1 /* faster, but obscures memory leak hunting */
-
 /*
  * We have many arrays of size 3.  Whenever we have such an array, the
  * indices refer to one of the sides of the three-way merge.  This is so
@@ -305,8 +303,6 @@ struct merge_options_internal {
 	 *   * these keys serve to intern all the path strings, which allows
 	 *     us to do pointer comparison on directory names instead of
 	 *     strcmp; we just have to be careful to use the interned strings.
-	 *     (Technically paths_to_free may track some strings that were
-	 *      removed from froms paths.)
 	 *
 	 * The values of paths:
 	 *   * either a pointer to a merged_info, or a conflict_info struct
@@ -349,18 +345,7 @@ struct merge_options_internal {
 	 * freed together too.  Using a memory pool for these provides a
 	 * nice speedup.
 	 */
-	struct mem_pool internal_pool;
-	struct mem_pool *pool; /* NULL, or pointer to internal_pool */
-
-	/*
-	 * paths_to_free: additional list of strings to free
-	 *
-	 * If keys are removed from "paths", they are added to paths_to_free
-	 * to ensure they are later freed.  We avoid free'ing immediately since
-	 * other places (e.g. conflict_info.pathnames[]) may still be
-	 * referencing these paths.
-	 */
-	struct string_list paths_to_free;
+	struct mem_pool pool;
 
 	/*
 	 * output: special messages and conflict notices for various paths
@@ -539,19 +524,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	void (*strset_clear_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
-	if (opti->pool)
-		strmap_clear_func(&opti->paths, 0);
-	else {
-		/*
-		 * We marked opti->paths with strdup_strings = 0, so that
-		 * we wouldn't have to make another copy of the fullpath
-		 * created by make_traverse_path from setup_path_info().
-		 * But, now that we've used it and have no other references
-		 * to these strings, it is time to deallocate them.
-		 */
-		free_strmap_strings(&opti->paths);
-		strmap_clear_func(&opti->paths, 1);
-	}
+	strmap_clear_func(&opti->paths, 0);
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
@@ -560,20 +533,6 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
 
-	if (!opti->pool) {
-		/*
-		 * opti->paths_to_free is similar to opti->paths; we
-		 * created it with strdup_strings = 0 to avoid making
-		 * _another_ copy of the fullpath but now that we've used
-		 * it and have no other references to these strings, it is
-		 * time to deallocate them.  We do so by temporarily
-		 * setting strdup_strings to 1.
-		 */
-		opti->paths_to_free.strdup_strings = 1;
-		string_list_clear(&opti->paths_to_free, 0);
-		opti->paths_to_free.strdup_strings = 0;
-	}
-
 	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
 
@@ -623,11 +582,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		strmap_clear(&opti->output, 0);
 	}
 
-#if USE_MEMORY_POOL
-	mem_pool_discard(&opti->internal_pool, 0);
-	if (!reinitialize)
-		opti->pool = NULL;
-#endif
+	mem_pool_discard(&opti->pool, 0);
 
 	/* Clean out callback_data as well. */
 	FREE_AND_NULL(renames->callback_data);
@@ -693,12 +648,9 @@ static void path_msg(struct merge_options *opt,
 static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
 						 const char *path)
 {
+	/* Similar to alloc_filespec(), but allocate from pool and reuse path */
 	struct diff_filespec *spec;
 
-	if (!pool)
-		return alloc_filespec(path);
-
-	/* Similar to alloc_filespec, but allocate from pool and reuse path */
 	spec = mem_pool_calloc(pool, 1, sizeof(*spec));
 	spec->path = (char*)path; /* spec won't modify it */
 
@@ -712,12 +664,9 @@ static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
 					     struct diff_filespec *one,
 					     struct diff_filespec *two)
 {
+	/* Same code as diff_queue(), except allocate from pool */
 	struct diff_filepair *dp;
 
-	if (!pool)
-		return diff_queue(queue, one, two);
-
-	/* Same code as diff_queue, except allocate from pool */
 	dp = mem_pool_calloc(pool, 1, sizeof(*dp));
 	dp->one = one;
 	dp->two = two;
@@ -726,27 +675,6 @@ static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
 	return dp;
 }
 
-static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
-{
-	if (!pool)
-		return xcalloc(count, size);
-	return mem_pool_calloc(pool, count, size);
-}
-
-static void *pool_alloc(struct mem_pool *pool, size_t size)
-{
-	if (!pool)
-		return xmalloc(size);
-	return mem_pool_alloc(pool, size);
-}
-
-static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
-{
-	if (!pool)
-		return xstrndup(str, len);
-	return mem_pool_strndup(pool, str, len);
-}
-
 /* add a string to a strbuf, but converting "/" to "_" */
 static void add_flattened_path(struct strbuf *out, const char *s)
 {
@@ -875,9 +803,9 @@ static void setup_path_info(struct merge_options *opt,
 	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
 	assert(resolved == (merged_version != NULL));
 
-	mi = pool_calloc(opt->priv->pool, 1,
-			 resolved ? sizeof(struct merged_info) :
-				    sizeof(struct conflict_info));
+	mi = mem_pool_calloc(&opt->priv->pool, 1,
+			     resolved ? sizeof(struct merged_info) :
+					sizeof(struct conflict_info));
 	mi->directory_name = current_dir_name;
 	mi->basename_offset = current_dir_name_len;
 	mi->clean = !!resolved;
@@ -924,7 +852,6 @@ static void add_pair(struct merge_options *opt,
 		     unsigned dir_rename_mask)
 {
 	struct diff_filespec *one, *two;
-	struct mem_pool *pool = opt->priv->pool;
 	struct rename_info *renames = &opt->priv->renames;
 	int names_idx = is_add ? side : 0;
 
@@ -975,11 +902,11 @@ static void add_pair(struct merge_options *opt,
 			return;
 	}
 
-	one = pool_alloc_filespec(pool, pathname);
-	two = pool_alloc_filespec(pool, pathname);
+	one = pool_alloc_filespec(&opt->priv->pool, pathname);
+	two = pool_alloc_filespec(&opt->priv->pool, pathname);
 	fill_filespec(is_add ? two : one,
 		      &names[names_idx].oid, 1, names[names_idx].mode);
-	pool_diff_queue(pool, &renames->pairs[side], one, two);
+	pool_diff_queue(&opt->priv->pool, &renames->pairs[side], one, two);
 }
 
 static void collect_rename_info(struct merge_options *opt,
@@ -1170,7 +1097,7 @@ static int collect_merge_info_callback(int n,
 	len = traverse_path_len(info, p->pathlen);
 
 	/* +1 in both of the following lines to include the NUL byte */
-	fullpath = pool_alloc(opt->priv->pool, len + 1);
+	fullpath = mem_pool_alloc(&opt->priv->pool, len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
 	/*
@@ -1425,7 +1352,7 @@ static int handle_deferred_entries(struct merge_options *opt,
 		copy = renames->deferred[side].possible_trivial_merges;
 		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
 					    0,
-					    opt->priv->pool,
+					    &opt->priv->pool,
 					    0);
 		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
@@ -2377,21 +2304,17 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	VERIFY_CI(ci);
 
 	/* Find parent directories missing from opt->priv->paths */
-	if (opt->priv->pool) {
-		cur_path = mem_pool_strdup(opt->priv->pool, new_path);
-		free((char*)new_path);
-		new_path = (char *)cur_path;
-	} else {
-		cur_path = new_path;
-	}
+	cur_path = mem_pool_strdup(&opt->priv->pool, new_path);
+	free((char*)new_path);
+	new_path = (char *)cur_path;
 
 	while (1) {
 		/* Find the parent directory of cur_path */
 		char *last_slash = strrchr(cur_path, '/');
 		if (last_slash) {
-			parent_name = pool_strndup(opt->priv->pool,
-						   cur_path,
-						   last_slash - cur_path);
+			parent_name = mem_pool_strndup(&opt->priv->pool,
+						       cur_path,
+						       last_slash - cur_path);
 		} else {
 			parent_name = opt->priv->toplevel_dir;
 			break;
@@ -2400,8 +2323,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		/* Look it up in opt->priv->paths */
 		entry = strmap_get_entry(&opt->priv->paths, parent_name);
 		if (entry) {
-			if (!opt->priv->pool)
-				free((char*)parent_name);
 			parent_name = entry->key; /* reuse known pointer */
 			break;
 		}
@@ -2428,16 +2349,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		parent_name = cur_dir;
 	}
 
-	if (!opt->priv->pool) {
-		/*
-		 * We are removing old_path from opt->priv->paths.
-		 * old_path also will eventually need to be freed, but it
-		 * may still be used by e.g.  ci->pathnames.  So, store it
-		 * in another string-list for now.
-		 */
-		string_list_append(&opt->priv->paths_to_free, old_path);
-	}
-
 	assert(ci->filemask == 2 || ci->filemask == 4);
 	assert(ci->dirmask == 0);
 	strmap_remove(&opt->priv->paths, old_path, 0);
@@ -2471,8 +2382,6 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		new_ci->stages[index].mode = ci->stages[index].mode;
 		oidcpy(&new_ci->stages[index].oid, &ci->stages[index].oid);
 
-		if (!opt->priv->pool)
-			free(ci);
 		ci = new_ci;
 	}
 
@@ -2888,7 +2797,6 @@ static void use_cached_pairs(struct merge_options *opt,
 {
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
-	struct mem_pool *pool = opt->priv->pool;
 
 	/*
 	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
@@ -2900,30 +2808,24 @@ static void use_cached_pairs(struct merge_options *opt,
 		const char *new_name = entry->value;
 		if (!new_name)
 			new_name = old_name;
-		if (pool) {
-			/*
-			 * cached_pairs has _copies* of old_name and new_name,
-			 * because it has to persist across merges.  When
-			 *   pool != NULL
-			 * pool_alloc_filespec() will just re-use the existing
-			 * filenames, which will also get re-used by
-			 * opt->priv->paths if they become renames, and then
-			 * get freed at the end of the merge, leaving the copy
-			 * in cached_pairs dangling.  Avoid this by making a
-			 * copy here.
-			 *
-			 * When pool == NULL, pool_alloc_filespec() calls
-			 * alloc_filespec(), which makes a copy; we don't want
-			 * to add another.
-			 */
-			old_name = mem_pool_strdup(pool, old_name);
-			new_name = mem_pool_strdup(pool, new_name);
-		}
+
+		/*
+		 * cached_pairs has *copies* of old_name and new_name,
+		 * because it has to persist across merges.  Since
+		 * pool_alloc_filespec() will just re-use the existing
+		 * filenames, which will also get re-used by
+		 * opt->priv->paths if they become renames, and then
+		 * get freed at the end of the merge, that would leave
+		 * the copy in cached_pairs dangling.  Avoid this by
+		 * making a copy here.
+		 */
+		old_name = mem_pool_strdup(&opt->priv->pool, old_name);
+		new_name = mem_pool_strdup(&opt->priv->pool, new_name);
 
 		/* We don't care about oid/mode, only filenames and status */
-		one = pool_alloc_filespec(pool, old_name);
-		two = pool_alloc_filespec(pool, new_name);
-		pool_diff_queue(pool, pairs, one, two);
+		one = pool_alloc_filespec(&opt->priv->pool, old_name);
+		two = pool_alloc_filespec(&opt->priv->pool, new_name);
+		pool_diff_queue(&opt->priv->pool, pairs, one, two);
 		pairs->queue[pairs->nr-1]->status = entry->value ? 'R' : 'D';
 	}
 }
@@ -3031,7 +2933,7 @@ static int detect_regular_renames(struct merge_options *opt,
 	diff_queued_diff = renames->pairs[side_index];
 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
 	diffcore_rename_extended(&diff_opts,
-				 opt->priv->pool,
+				 &opt->priv->pool,
 				 &renames->relevant_sources[side_index],
 				 &renames->dirs_removed[side_index],
 				 &renames->dir_rename_count[side_index],
@@ -3082,7 +2984,7 @@ static int collect_renames(struct merge_options *opt,
 
 		if (p->status != 'A' && p->status != 'R') {
 			possibly_cache_new_pair(renames, p, side_index, NULL);
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 			continue;
 		}
 
@@ -3095,7 +2997,7 @@ static int collect_renames(struct merge_options *opt,
 
 		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 			continue;
 		}
 
@@ -3213,7 +3115,7 @@ cleanup:
 		side_pairs = &renames->pairs[s];
 		for (i = 0; i < side_pairs->nr; ++i) {
 			struct diff_filepair *p = side_pairs->queue[i];
-			pool_diff_free_filepair(opt->priv->pool, p);
+			pool_diff_free_filepair(&opt->priv->pool, p);
 		}
 	}
 
@@ -3226,7 +3128,7 @@ simple_cleanup:
 	if (combined.nr) {
 		int i;
 		for (i = 0; i < combined.nr; i++)
-			pool_diff_free_filepair(opt->priv->pool,
+			pool_diff_free_filepair(&opt->priv->pool,
 						combined.queue[i]);
 		free(combined.queue);
 	}
@@ -3701,7 +3603,7 @@ static void process_entry(struct merge_options *opt,
 		 * the directory to remain here, so we need to move this
 		 * path to some new location.
 		 */
-		new_ci = pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
+		new_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*new_ci));
 
 		/* We don't really want new_ci->merged.result copied, but it'll
 		 * be overwritten below so it doesn't matter.  We also don't
@@ -3794,7 +3696,8 @@ static void process_entry(struct merge_options *opt,
 			const char *a_path = NULL, *b_path = NULL;
 			int rename_a = 0, rename_b = 0;
 
-			new_ci = pool_alloc(opt->priv->pool, sizeof(*new_ci));
+			new_ci = mem_pool_alloc(&opt->priv->pool,
+						sizeof(*new_ci));
 
 			if (S_ISREG(a_mode))
 				rename_a = 1;
@@ -3863,19 +3766,8 @@ static void process_entry(struct merge_options *opt,
 				b_path = path;
 			strmap_put(&opt->priv->paths, b_path, new_ci);
 
-			if (rename_a && rename_b) {
+			if (rename_a && rename_b)
 				strmap_remove(&opt->priv->paths, path, 0);
-				/*
-				 * We removed path from opt->priv->paths.  path
-				 * will also eventually need to be freed if not
-				 * part of a memory pool...but it may still be
-				 * used by e.g. ci->pathnames.  So, store it in
-				 * another string-list for now in that case.
-				 */
-				if (!opt->priv->pool)
-					string_list_append(&opt->priv->paths_to_free,
-							   path);
-			}
 
 			/*
 			 * Do special handling for b_path since process_entry()
@@ -4482,13 +4374,8 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 
 	/* Initialization of various renames fields */
 	renames = &opt->priv->renames;
-#if USE_MEMORY_POOL
-	mem_pool_init(&opt->priv->internal_pool, 0);
-	opt->priv->pool = &opt->priv->internal_pool;
-#else
-	opt->priv->pool = NULL;
-#endif
-	pool = opt->priv->pool;
+	mem_pool_init(&opt->priv->pool, 0);
+	pool = &opt->priv->pool;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
 					    NOT_RELEVANT, pool, 0);
@@ -4525,15 +4412,13 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * Although we initialize opt->priv->paths with strdup_strings=0,
 	 * that's just to avoid making yet another copy of an allocated
 	 * string.  Putting the entry into paths means we are taking
-	 * ownership, so we will later free it.  paths_to_free is similar.
+	 * ownership, so we will later free it.
 	 *
 	 * In contrast, conflicted just has a subset of keys from paths, so
 	 * we don't want to free those (it'd be a duplicate free).
 	 */
 	strmap_init_with_options(&opt->priv->paths, pool, 0);
 	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
-	if (!opt->priv->pool)
-		string_list_init_nodup(&opt->priv->paths_to_free);
 
 	/*
 	 * keys & strbufs in output will sometimes need to outlive "paths",
-- 
gitgitgadget
