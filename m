Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11539C4320E
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29861050
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhGaR1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGaR1w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC759C0613D3
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b11so10383128wrx.6
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+9eI3QJnaA9ojY4vp8WbYszLhiAHQHDYAfyuZDfzWVY=;
        b=MzPTZnm0TOIzJXT16OSfS1/D9dOyx1asDsBIiE8QIgCHrEFK9VegQqPDRLcKpwIbUX
         j0Kd5w6Ee4pAPgiV9mOaj0k3iOsYRkzl6Kei1ANqQQ4Tk6/gwZ3bwOZ89Mm2milEHlNs
         ZSoki02ONec0sluYjeHV4PKdwoi7KN2cZ460CtbQR2JD3kDoeASq/Av2EV4kVKdpnuJY
         ESJuMXPNC0N1wT9+KfFX/1a5LKldbrfOh2AsVijXWG2Md11q64G9lxAfk8aScg5hUDMo
         T64rL8SUG2O6tL8TjUtZoK0C35KiBpuuc9zhRUb50s5uD1K+q5R2HZquB2IV7n9tCw7T
         lU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+9eI3QJnaA9ojY4vp8WbYszLhiAHQHDYAfyuZDfzWVY=;
        b=K7IToAGyA2J66Aj2eDVkqsuSFOeO/RJY0y2k0b1ieakWx9VKRTXb+2KnOPxZn9n9AH
         0nVFhji01wsAs9L7AmNfxM22rChLcuKaY+nUZJish0DTBhi+GsC/F3xpsMCd+v15XcKx
         0xUVqizu+v0V39Xy+zQh3SLC3fs5z1XtgR9MWtP2spLIvtgWl4FOwkwS+MqwYxV7Odcx
         h+q0fCzaWegnzANMgoyS1AU+ECkfFKKJVu8DUCfjBlwpoOZ0buI1vogjlR/zqdYzibnj
         5+OzNl7ZGGOetoQ9vtU74DevgMS8vbjAw292Di7UFzYszBgPrVpfxqp6cr+4j9PomEtN
         zlRw==
X-Gm-Message-State: AOAM533NBHVdC7Oa4K8wTX5yqYd1ez04dUbAYcW90pLmLmg66R2E8UYA
        YfcuGAfCLBASzzlXUCBqnCoEi4mc4u0=
X-Google-Smtp-Source: ABdhPJyhKq0PWgGEsD3Sl/AQwtPVnkTQz0Cl2qy1EjxwywfhogzI2Ur6PGkXDWLPfPXT1jQ+b/GO3A==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr9342360wru.118.1627752464345;
        Sat, 31 Jul 2021 10:27:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm5324919wru.67.2021.07.31.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:43 -0700 (PDT)
Message-Id: <7c49aa601d0b0880dde559579a336809d88a1c01.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:34 +0000
Subject: [PATCH v4 5/9] merge-ort: switch our strmaps over to using memory
 pools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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
index 3f425436263..99c75690855 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -539,15 +539,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	void (*strset_clear_func)(struct strset *) =
 		reinitialize ? strset_partial_clear : strset_clear;
 
-	/*
-	 * We marked opti->paths with strdup_strings = 0, so that we
-	 * wouldn't have to make another copy of the fullpath created by
-	 * make_traverse_path from setup_path_info().  But, now that we've
-	 * used it and have no other references to these strings, it is time
-	 * to deallocate them.
-	 */
-	free_strmap_strings(&opti->paths);
-	strmap_clear_func(&opti->paths, 1);
+	if (opti->pool)
+		strmap_clear_func(&opti->paths, 0);
+	else {
+		/*
+		 * We marked opti->paths with strdup_strings = 0, so that
+		 * we wouldn't have to make another copy of the fullpath
+		 * created by make_traverse_path from setup_path_info().
+		 * But, now that we've used it and have no other references
+		 * to these strings, it is time to deallocate them.
+		 */
+		free_strmap_strings(&opti->paths);
+		strmap_clear_func(&opti->paths, 1);
+	}
 
 	/*
 	 * All keys and values in opti->conflicted are a subset of those in
@@ -556,16 +560,19 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 	 */
 	strmap_clear_func(&opti->conflicted, 0);
 
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
@@ -3715,7 +3735,7 @@ static void process_entry(struct merge_options *opt,
 			const char *a_path = NULL, *b_path = NULL;
 			int rename_a = 0, rename_b = 0;
 
-			new_ci = xmalloc(sizeof(*new_ci));
+			new_ci = pool_alloc(opt->priv->pool, sizeof(*new_ci));
 
 			if (S_ISREG(a_mode))
 				rename_a = 1;
@@ -3788,12 +3808,14 @@ static void process_entry(struct merge_options *opt,
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
@@ -4335,6 +4357,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	struct rename_info *renames;
 	int i;
+	struct mem_pool *pool = NULL;
 
 	/* Sanity checks on opt */
 	trace2_region_enter("merge", "sanity checks", opt->repo);
@@ -4406,9 +4429,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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
@@ -4422,7 +4446,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 		 */
 		strintmap_init_with_options(&renames->relevant_sources[i],
 					    -1 /* explicitly invalid */,
-					    NULL, 0);
+					    pool, 0);
 		strmap_init_with_options(&renames->cached_pairs[i],
 					 NULL, 1);
 		strset_init_with_options(&renames->cached_irrelevant[i],
@@ -4432,9 +4456,9 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
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
 
@@ -4447,9 +4471,10 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
 	 * In contrast, conflicted just has a subset of keys from paths, so
 	 * we don't want to free those (it'd be a duplicate free).
 	 */
-	strmap_init_with_options(&opt->priv->paths, NULL, 0);
-	strmap_init_with_options(&opt->priv->conflicted, NULL, 0);
-	string_list_init_nodup(&opt->priv->paths_to_free);
+	strmap_init_with_options(&opt->priv->paths, pool, 0);
+	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
+	if (!opt->priv->pool)
+		string_list_init_nodup(&opt->priv->paths_to_free);
 
 	/*
 	 * keys & strbufs in output will sometimes need to outlive "paths",
-- 
gitgitgadget

