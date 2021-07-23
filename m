Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E270C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8370160E95
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbhGWMOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhGWMOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F3C061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k4so747602wms.3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IxiUchJLeuKXx1JM7gEbS9QVomUXv57OIKU9gV2h40U=;
        b=Tlvu7/bc/N7xCYVz6wz3uKvaLs0F/sC74e8XJXGy9nI5OociYlIvM93d+uo9cOQNAQ
         LyBVzL2lWoWCkOzXCZRc2fozAOwaedBGwXpOpUoLGYpWftrC7DmSt3cjqAazdWf4DBdD
         VEOLLStNmCPm5FR0B7XhevOerGhfa/NbrYPqp12gM5uOOMN0gjL+uv/cBqe47xTbddBp
         iZu2DoBGJbyIPf4TcoLwNgLnumSpEjdGXOTGzEDnB10I3a5h+c+reDD+NS0PRbUn91OZ
         P4xr+tkOf4iUaxuLM0WvTCcRJM1JPPUCdnNfDRRGZG7INhidQqz7sD7w8AdSbf505fZ0
         11XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IxiUchJLeuKXx1JM7gEbS9QVomUXv57OIKU9gV2h40U=;
        b=OBgAFOdiJ1g9hSZSMTafMuvpUYga916b9AT05wgxxZNsC2htL0AD6jYP4y+kNOyyum
         3IadC89zyOZtcpK5i2jKeWbVv2s85KzqUVnoJln2uGm4XyeT97VBx/6R8EQkA1n1/qfm
         bChLrnEoyx3uyXl+CCJrh0gWgkVlo1Gj6EJ1U6upw0MVEOZWhCNSnccS8y54r03YGo29
         KchZ/S26edewrfGEzGDI5CFycqMMynDlkFZLICklbbC2MRf2FSp82SU11XoUIjLmetLI
         kB6bu4+A6DueIQHixyiEdgDwvilRqORaWj0oUVAUs6GYGIh2V/FxRf75TO5bAmgpDXve
         FlaQ==
X-Gm-Message-State: AOAM531Fgd/xsvzV848art4neBaUB3RURdTXRgy48E0vfqaNzWf/7Fop
        P/2UBdSPI8lc7UgbBvjG2w34+vjXR4c=
X-Google-Smtp-Source: ABdhPJxvyx0cSqYvoH6IQ0jOTHWg2eQwwYzdpdORv+dmvwSvFrMf6OovgjG3ITrp4NMHpcJIfOSJ6Q==
X-Received: by 2002:a05:600c:4fc9:: with SMTP id o9mr14080147wmq.135.1627044901369;
        Fri, 23 Jul 2021 05:55:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm5511482wmm.37.2021.07.23.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:55:01 -0700 (PDT)
Message-Id: <8231c8e34cd35cc648f87d31e48b0692dd2fe6cd.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:54 +0000
Subject: [PATCH 4/7] merge-ort: switch our strmaps over to using memory pools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

For all the strmaps (including strintmaps and strsets) whose memory is
unconditionally freed as part of clear_or_reinit_internal_opts(), switch
them over to using our new memory pool.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:      202.5  ms ±  3.2  ms    198.1 ms ±  2.6 ms
    mega-renames:      1.072 s ±  0.012 s    715.8 ms ±  4.0 ms
    just-one-mega:   357.3  ms ±  3.9  ms    276.8 ms ±  4.2 ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 125 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 50 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2bca4b71f2a..5fd2a4ccd35 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -539,15 +539,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	void (*strset_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
-	/*
-	 * We marked opti->paths with strdup_strings = 0, so that we
-	 * wouldn't have to make another copy of the fullpath created by
-	 * make_traverse_path from setup_path_info().  But, now that we've
-	 * used it and have no other references to these strings, it is time
-	 * to deallocate them.
-	 */
-	free_strmap_strings(&opti->paths);
-	strmap_func(&opti->paths, 1);
+	if (opti->pool)
+		strmap_func(&opti->paths, 0);
+	else {
+		/*
+		 * We marked opti->paths with strdup_strings = 0, so that
+		 * we wouldn't have to make another copy of the fullpath
+		 * created by make_traverse_path from setup_path_info().
+		 * But, now that we've used it and have no other references
+		 * to these strings, it is time to deallocate them.
+		 */
+		free_strmap_strings(&opti->paths);
+		strmap_func(&opti->paths, 1);
+	}
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
@@ -556,16 +560,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 */
 	strmap_func(&opti->conflicted, 0);
 
-	/*
-	 * opti->paths_to_free is similar to opti->paths; we created it with
-	 * strdup_strings = 0 to avoid making _another_ copy of the fullpath
-	 * but now that we've used it and have no other references to these
-	 * strings, it is time to deallocate them.  We do so by temporarily
-	 * setting strdup_strings to 1.
-	 */
-	opti->paths_to_free.strdup_strings = 1;
-	string_list_clear(&opti->paths_to_free, 0);
-	opti->paths_to_free.strdup_strings = 0;
+	if (!opti->pool) {
+		/*
+		 * opti->paths_to_free is similar to opti->paths; we
+		 * created it with strdup_strings = 0 to avoid making
+		 * _another_ copy of the fullpath but now that we've used
+		 * it and have no other references to these strings, it is
+		 * time to deallocate them.  We do so by temporarily
+		 * setting strdup_strings to 1.
+		 */
+		opti->paths_to_free.strdup_strings = 1;
+		string_list_clear(&opti->paths_to_free, 0);
+		opti->paths_to_free.strdup_strings = 0;
+	}
 
 	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
 		discard_index(&opti->attr_index);
@@ -683,7 +690,6 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
-MAYBE_UNUSED
 static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 {
 	if (!pool)
@@ -691,7 +697,6 @@ static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
 	return mem_pool_calloc(pool, count, size);
 }
 
-MAYBE_UNUSED
 static void *pool_alloc(struct mem_pool *pool, size_t size)
 {
 	if (!pool)
@@ -699,7 +704,6 @@ static void *pool_alloc(struct mem_pool *pool, size_t size)
 	return mem_pool_alloc(pool, size);
 }
 
-MAYBE_UNUSED
 static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
 {
 	if (!pool)
@@ -835,8 +839,9 @@ static void setup_path_info(struct merge_options *opt,
 	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
 	assert(resolved == (merged_version != NULL));
 
-	mi = xcalloc(1, resolved ? sizeof(struct merged_info) :
-				   sizeof(struct conflict_info));
+	mi = pool_calloc(opt->priv->pool, 1,
+			 resolved ? sizeof(struct merged_info) :
+				    sizeof(struct conflict_info));
 	mi->directory_name = current_dir_name;
 	mi->basename_offset = current_dir_name_len;
 	mi->clean = !!resolved;
@@ -1128,7 +1133,7 @@ static int collect_merge_info_callback(int n,
 	len = traverse_path_len(info, p->pathlen);
 
 	/* +1 in both of the following lines to include the NUL byte */
-	fullpath = xmalloc(len + 1);
+	fullpath = pool_alloc(opt->priv->pool, len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
 	/*
@@ -1383,7 +1388,7 @@ static int handle_deferred_entries(struct merge_options *opt,
 		copy = renames->deferred[side].possible_trivial_merges;
 		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
 					    0,
-					    NULL,
+					    opt->priv->pool,
 					    0);
 		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
@@ -2335,12 +2340,21 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	VERIFY_CI(ci);
 
 	/* Find parent directories missing from opt->priv->paths */
-	cur_path = new_path;
+	if (opt->priv->pool) {
+		cur_path = mem_pool_strdup(opt->priv->pool, new_path);
+		free((char*)new_path);
+		new_path = (char *)cur_path;
+	} else {
+		cur_path = new_path;
+	}
+
 	while (1) {
 		/* Find the parent directory of cur_path */
 		char *last_slash = strrchr(cur_path, '/');
 		if (last_slash) {
-			parent_name = xstrndup(cur_path, last_slash - cur_path);
+			parent_name = pool_strndup(opt->priv->pool,
+						   cur_path,
+						   last_slash - cur_path);
 		} else {
 			parent_name = opt->priv->toplevel_dir;
 			break;
@@ -2349,7 +2363,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		/* Look it up in opt->priv->paths */
 		entry = strmap_get_entry(&opt->priv->paths, parent_name);
 		if (entry) {
-			free((char*)parent_name);
+			if (!opt->priv->pool)
+				free((char*)parent_name);
 			parent_name = entry->key; /* reuse known pointer */
 			break;
 		}
@@ -2376,12 +2391,15 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		parent_name = cur_dir;
 	}
 
-	/*
-	 * We are removing old_path from opt->priv->paths.  old_path also will
-	 * eventually need to be freed, but it may still be used by e.g.
-	 * ci->pathnames.  So, store it in another string-list for now.
-	 */
-	string_list_append(&opt->priv->paths_to_free, old_path);
+	if (!opt->priv->pool) {
+		/*
+		 * We are removing old_path from opt->priv->paths.
+		 * old_path also will eventually need to be freed, but it
+		 * may still be used by e.g.  ci->pathnames.  So, store it
+		 * in another string-list for now.
+		 */
+		string_list_append(&opt->priv->paths_to_free, old_path);
+	}
 
 	assert(ci->filemask == 2 || ci->filemask == 4);
 	assert(ci->dirmask == 0);
@@ -2416,7 +2434,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		new_ci->stages[index].mode = ci->stages[index].mode;
 		oidcpy(&new_ci->stages[index].oid, &ci->stages[index].oid);
 
-		free(ci);
+		if (!opt->priv->pool)
+			free(ci);
 		ci = new_ci;
 	}
 
@@ -3623,7 +3642,8 @@ static void process_entry(struct merge_options *opt,
 		 * the directory to remain here, so we need to move this
 		 * path to some new location.
 		 */
-		CALLOC_ARRAY(new_ci, 1);
+		new_ci = pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
+
 		/* We don't really want new_ci->merged.result copied, but it'll
 		 * be overwritten below so it doesn't matter.  We also don't
 		 * want any directory mode/oid values copied, but we'll zero
@@ -3713,7 +3733,7 @@ static void process_entry(struct merge_options *opt,
 			const char *a_path = NULL, *b_path = NULL;
 			int rename_a = 0, rename_b = 0;
 
-			new_ci = xmalloc(sizeof(*new_ci));
+			new_ci = pool_alloc(opt->priv->pool, sizeof(*new_ci));
 
 			if (S_ISREG(a_mode))
 				rename_a = 1;
@@ -3777,12 +3797,14 @@ static void process_entry(struct merge_options *opt,
 				strmap_remove(&opt->priv->paths, path, 0);
 				/*
 				 * We removed path from opt->priv->paths.  path
-				 * will also eventually need to be freed, but
-				 * it may still be used by e.g.  ci->pathnames.
-				 * So, store it in another string-list for now.
+				 * will also eventually need to be freed if not
+				 * part of a memory pool...but it may still be
+				 * used by e.g. ci->pathnames.  So, store it in
+				 * another string-list for now in that case.
 				 */
-				string_list_append(&opt->priv->paths_to_free,
-						   path);
+				if (!opt->priv->pool)
+					string_list_append(&opt->priv->paths_to_free,
+							   path);
 			}
 
 			/*
@@ -4322,6 +4344,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	struct rename_info *renames;
 	int i;
+	struct mem_pool *pool = NULL;
 
 	/* Sanity checks on opt */
 	trace2_region_enter("merge", "sanity checks", opt->repo);
@@ -4393,9 +4416,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 #else
 	opt->priv->pool = NULL;
 #endif
+	pool = opt->priv->pool;
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->dirs_removed[i],
-					    NOT_RELEVANT, NULL, 0);
+					    NOT_RELEVANT, pool, 0);
 		strmap_init_with_options(&renames->dir_rename_count[i],
 					 NULL, 1);
 		strmap_init_with_options(&renames->dir_renames[i],
@@ -4409,7 +4433,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 		 */
 		strintmap_init_with_options(&renames->relevant_sources[i],
 					    -1 /* explicitly invalid */,
-					    NULL, 0);
+					    pool, 0);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
@@ -4419,9 +4443,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	}
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		strintmap_init_with_options(&renames->deferred[i].possible_trivial_merges,
-					    0, NULL, 0);
+					    0, pool, 0);
 		strset_init_with_options(&renames->deferred[i].target_dirs,
-					 NULL, 1);
+					 pool, 1);
 		renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
 	}
 
@@ -4434,9 +4458,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * In contrast, conflicted just has a subset of keys from paths, so
 	 * we don't want to free those (it'd be a duplicate free).
 	 */
-	strmap_init_with_options(&opt->priv->paths, NULL, 0);
-	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
-	string_list_init(&opt->priv->paths_to_free, 0);
+	strmap_init_with_options(&opt->priv->paths, pool, 0);
+	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
+	if (!opt->priv->pool)
+		string_list_init(&opt->priv->paths_to_free, 0);
 
 	/*
 	 * keys & strbufs in output will sometimes need to outlive "paths",
-- 
gitgitgadget

