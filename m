Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0878C432BE
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E3261042
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhGaR1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhGaR1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BBC06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u15so7903979wmj.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=79mPlSl0L8j92tdA7mfenLswfDU+fHezuJsQabPCa4E=;
        b=WwyxqrWzRWAwBFqjKTHV4/xcDLqb4Km4oLp8HLFbL24jW1onQ5FR7zG4Bxn0ITK1Kv
         uurH4eRt2fiSm8kedCkfn4jVOce2morIbdE9GhX3Fir7xqkjP0if5zTX9v8p4rmpbziI
         ja12LDWzSggvWduWP1d8cSzKIFmUR9tzyGCIgZ6A/WGmj3fMF9ULsKBzC8r8cgEbmMTp
         OsN2eoOyT/ytxxwyE2iCjK8fpmbWIlIj1XSpn419udH2sWo2uy7Zk1eKw+ctWjdQ0BmV
         e1IauN1wrnuihA+Aqha8LD4m7/3Zzhe+o0XSXFYrIsYVWaasCdEIGINdfh5y1OgTAXKi
         xjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=79mPlSl0L8j92tdA7mfenLswfDU+fHezuJsQabPCa4E=;
        b=WmND0iO7UMD0bUAciE6YLn3xYV5iiKZ0aUD3J0NsJ1CG2QORpRwoWWWC7Q9yKNdr/U
         ObLG2jG7FQMi/E+VoFAV691TPZmUvc5mo7T733TXZj8YRDDPiQ/297qAF8Df7dF/yZzM
         6Rpc3v5/f9R5C4iSURqNmGRzihdrET9hqkxnIcwbETnucsHxTSO/zyGGo/7xX3erKAQd
         6VrlctguUWZTup6davZ9ckf2ZVnJU1WgLw/yz92KYqBe24jmRJegb/ORXotRBspTtG6k
         LcWTldRKK5VG0Jszkc4v9K1VgDcKf6qlM0MXLeuup73/4ionF8ejhPLOLJk9FfYkSn8M
         eLpw==
X-Gm-Message-State: AOAM532yh8Q3SXAhdAFySUrTccy2MOQ7p2Eu8LV6iERVFQGMsGM/g5Zb
        f9EqYoeZfWJLB6Pl4uhe3sH6QNC77Yc=
X-Google-Smtp-Source: ABdhPJzTOBLmyMxyqJG4z4bRcObU0sTdQR4bQSzAuJn2UZC+vDi24Frg46KSJsAGUYESCfm1ibheMw==
X-Received: by 2002:a1c:1b55:: with SMTP id b82mr8964175wmb.121.1627752460513;
        Sat, 31 Jul 2021 10:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm5562061wrc.6.2021.07.31.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:39 -0700 (PDT)
Message-Id: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:29 +0000
Subject: [PATCH v4 0/9] Final optimization batch (#15): use memory pools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series textually depends on en/ort-perf-batch-14, but the ideas are
orthogonal to it and orthogonal to previous series. It can be reviewed
independently.

Changes since v1, addressing Eric's feedback:

 * Fixed a comment that became out-of-date in patch 1
 * Swapped commits 2 and 3 so that one can better motivate the other.

Changes since v2, addressing Peff's feedback:

 * Rebased on en/ort-perf-batch-14 (resolving a trivial conflict with the
   new string_list_init_nodup() usage)
 * Added a new preliminary patch renaming str*_func() to str*_clear_func()
 * Added a new final patch that hardcodes that we'll just use memory pools

Changes since v3, as per Peff's feedback:

 * Don't only remove the extra complexity from the USE_MEMORY_POOL #define;
   also remove the original bookkeeping complexity needed to track
   individual frees when not using a memory pool.

=== Basic Optimization idea ===

In this series, I make use of memory pools to get faster allocations and
deallocations for many data structures that tend to all be deallocated at
the same time anyway.

=== Results ===

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28), the
changes in just this series improves the performance as follows:

                     Before Series           After Series
no-renames:      204.2  ms ±  3.0  ms    198.3 ms ±  2.9 ms
mega-renames:      1.076 s ±  0.015 s    661.8 ms ±  5.9 ms
just-one-mega:   364.1  ms ±  7.0  ms    264.6 ms ±  2.5 ms


As a reminder, before any merge-ort/diffcore-rename performance work, the
performance results we started with were:

no-renames-am:      6.940 s ±  0.485 s
no-renames:        18.912 s ±  0.174 s
mega-renames:    5964.031 s ± 10.459 s
just-one-mega:    149.583 s ±  0.751 s


=== Overall Results across all optimization work ===

This is my final prepared optimization series. It might be worth reviewing
how my optimizations fared overall, comparing the original merge-recursive
timings with three things: how much merge-recursive improved (as a
side-effect of optimizing merge-ort), how much improvement we would have
gotten from a hypothetical infinite parallelization of rename detection, and
what I achieved at the end with merge-ort:

                               Timings

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename    merge-ort
                 v2.30.0      current     detection     current
                ----------   ---------   -----------   ---------
no-renames:       18.912 s    18.030 s     11.699 s     198.3 ms
mega-renames:   5964.031 s   361.281 s    203.886 s     661.8 ms
just-one-mega:   149.583 s    11.009 s      7.553 s     264.6 ms

                           Speedup factors

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
no-renames:         1           1.05         1.6           95
mega-renames:       1          16.5         29           9012
just-one-mega:      1          13.6         20            565


And, for partial clone users:

             Factor reduction in number of objects needed

                                          Infinite
                 merge-       merge-     Parallelism
                recursive    recursive    of rename
                 v2.30.0      current     detection    merge-ort
                ----------   ---------   -----------   ---------
mega-renames:       1            1            1          181.3


=== Caveat ===

It may be worth noting, though, that my optimization numbers above for
merge-ort use test-tool fast-rebase. git rebase -s ort on the three
testcases above is 5-20 times slower (taking 3.835s, 6.798s, and 1.235s,
respectively). At this point, any further optimization work should go into
making a faster full-featured rebase by copying the ideas from fast-rebase:
avoid unnecessary process forking, avoid updating the index and working copy
until either the rebase is finished or you hit a conflict (and don't write
rebase metadata to disk until that point either), get rid of the glacially
slow revision walking of the upstream side of history (nuke
can_fast_forward(), make --reapply-cherry-picks the default) or at least
don't revision walk so many times (multiple calls to get_merge_bases in
can_fast_forward() plus a is_linear_history() walk, checking for upstream
cherry-picks, probably more), turn off per-commit hooks that probably should
have never been on anyway, etc.

Elijah Newren (9):
  merge-ort: rename str{map,intmap,set}_func()
  diffcore-rename: use a mem_pool for exact rename detection's hashmap
  merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
  merge-ort: set up a memory pool
  merge-ort: switch our strmaps over to using memory pools
  diffcore-rename, merge-ort: add wrapper functions for filepair
    alloc/dealloc
  merge-ort: store filepairs and filespecs in our mem_pool
  merge-ort: reuse path strings in pool_alloc_filespec
  merge-ort: remove compile-time ability to turn off usage of memory
    pools

 diffcore-rename.c |  68 ++++++++++++++---
 diffcore.h        |   3 +
 merge-ort.c       | 188 +++++++++++++++++++++++++---------------------
 3 files changed, 165 insertions(+), 94 deletions(-)


base-commit: 8b09a900a1f1f00d4deb04f567994ae8f1804b5e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-990%2Fnewren%2Fort-perf-batch-15-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-990/newren/ort-perf-batch-15-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/990

Range-diff vs v3:

  1:  e075d985f26 =  1:  e075d985f26 merge-ort: rename str{map,intmap,set}_func()
  2:  8416afa89fb =  2:  8416afa89fb diffcore-rename: use a mem_pool for exact rename detection's hashmap
  3:  2c0b90eaba5 =  3:  2c0b90eaba5 merge-ort: add pool_alloc, pool_calloc, and pool_strndup wrappers
  4:  6646f6fd1ca =  4:  6646f6fd1ca merge-ort: set up a memory pool
  5:  7c49aa601d0 =  5:  7c49aa601d0 merge-ort: switch our strmaps over to using memory pools
  6:  08cf2498f96 =  6:  08cf2498f96 diffcore-rename, merge-ort: add wrapper functions for filepair alloc/dealloc
  7:  4ffa5af8b57 =  7:  4ffa5af8b57 merge-ort: store filepairs and filespecs in our mem_pool
  8:  1556f0443c3 =  8:  1556f0443c3 merge-ort: reuse path strings in pool_alloc_filespec
  9:  de30dbac25e !  9:  f8cd50794e9 merge-ort: remove compile-time ability to turn off usage of memory pools
     @@ Metadata
       ## Commit message ##
          merge-ort: remove compile-time ability to turn off usage of memory pools
      
     -    Simplify code maintenance a bit by removing the ability to toggle
     -    between usage of memory pools and direct allocations.  This allows us to
     -    also remove and simplify some auxiliary functions.
     +    Simplify code maintenance by removing the ability to toggle between
     +    usage of memory pools and direct allocations.  This allows us to also
     +    remove paths_to_free since it was solely about bookkeeping to make sure
     +    we freed the necessary paths, and allows us to remove some auxiliary
     +    functions.
      
     +    Suggested-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     @@ merge-ort.c
       /*
        * We have many arrays of size 3.  Whenever we have such an array, the
        * indices refer to one of the sides of the three-way merge.  This is so
     +@@ merge-ort.c: struct merge_options_internal {
     + 	 *   * these keys serve to intern all the path strings, which allows
     + 	 *     us to do pointer comparison on directory names instead of
     + 	 *     strcmp; we just have to be careful to use the interned strings.
     +-	 *     (Technically paths_to_free may track some strings that were
     +-	 *      removed from froms paths.)
     + 	 *
     + 	 * The values of paths:
     + 	 *   * either a pointer to a merged_info, or a conflict_info struct
     +@@ merge-ort.c: struct merge_options_internal {
     + 	 * freed together too.  Using a memory pool for these provides a
     + 	 * nice speedup.
     + 	 */
     +-	struct mem_pool internal_pool;
     +-	struct mem_pool *pool; /* NULL, or pointer to internal_pool */
     +-
     +-	/*
     +-	 * paths_to_free: additional list of strings to free
     +-	 *
     +-	 * If keys are removed from "paths", they are added to paths_to_free
     +-	 * to ensure they are later freed.  We avoid free'ing immediately since
     +-	 * other places (e.g. conflict_info.pathnames[]) may still be
     +-	 * referencing these paths.
     +-	 */
     +-	struct string_list paths_to_free;
     ++	struct mem_pool pool;
     + 
     + 	/*
     + 	 * output: special messages and conflict notices for various paths
     +@@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     + 	void (*strset_clear_func)(struct strset *) =
     + 		reinitialize ? strset_partial_clear : strset_clear;
     + 
     +-	if (opti->pool)
     +-		strmap_clear_func(&opti->paths, 0);
     +-	else {
     +-		/*
     +-		 * We marked opti->paths with strdup_strings = 0, so that
     +-		 * we wouldn't have to make another copy of the fullpath
     +-		 * created by make_traverse_path from setup_path_info().
     +-		 * But, now that we've used it and have no other references
     +-		 * to these strings, it is time to deallocate them.
     +-		 */
     +-		free_strmap_strings(&opti->paths);
     +-		strmap_clear_func(&opti->paths, 1);
     +-	}
     ++	strmap_clear_func(&opti->paths, 0);
     + 
     + 	/*
     + 	 * All keys and values in opti->conflicted are a subset of those in
     +@@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
     + 	 */
     + 	strmap_clear_func(&opti->conflicted, 0);
     + 
     +-	if (!opti->pool) {
     +-		/*
     +-		 * opti->paths_to_free is similar to opti->paths; we
     +-		 * created it with strdup_strings = 0 to avoid making
     +-		 * _another_ copy of the fullpath but now that we've used
     +-		 * it and have no other references to these strings, it is
     +-		 * time to deallocate them.  We do so by temporarily
     +-		 * setting strdup_strings to 1.
     +-		 */
     +-		opti->paths_to_free.strdup_strings = 1;
     +-		string_list_clear(&opti->paths_to_free, 0);
     +-		opti->paths_to_free.strdup_strings = 0;
     +-	}
     +-
     + 	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
     + 		discard_index(&opti->attr_index);
     + 
      @@ merge-ort.c: static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
       		strmap_clear(&opti->output, 0);
       	}
       
      -#if USE_MEMORY_POOL
     - 	mem_pool_discard(&opti->internal_pool, 0);
     - 	if (!reinitialize)
     - 		opti->pool = NULL;
     +-	mem_pool_discard(&opti->internal_pool, 0);
     +-	if (!reinitialize)
     +-		opti->pool = NULL;
      -#endif
     ++	mem_pool_discard(&opti->pool, 0);
       
       	/* Clean out callback_data as well. */
       	FREE_AND_NULL(renames->callback_data);
     @@ merge-ort.c: static void path_msg(struct merge_options *opt,
      -		return alloc_filespec(path);
      -
      -	/* Similar to alloc_filespec, but allocate from pool and reuse path */
     -+	assert(pool != NULL);
       	spec = mem_pool_calloc(pool, 1, sizeof(*spec));
       	spec->path = (char*)path; /* spec won't modify it */
       
     @@ merge-ort.c: static struct diff_filepair *pool_diff_queue(struct mem_pool *pool,
      -		return diff_queue(queue, one, two);
      -
      -	/* Same code as diff_queue, except allocate from pool */
     -+	assert(pool != NULL);
       	dp = mem_pool_calloc(pool, 1, sizeof(*dp));
       	dp->one = one;
       	dp->two = two;
     @@ merge-ort.c: static void setup_path_info(struct merge_options *opt,
      -	mi = pool_calloc(opt->priv->pool, 1,
      -			 resolved ? sizeof(struct merged_info) :
      -				    sizeof(struct conflict_info));
     -+	mi = mem_pool_calloc(opt->priv->pool, 1,
     ++	mi = mem_pool_calloc(&opt->priv->pool, 1,
      +			     resolved ? sizeof(struct merged_info) :
      +					sizeof(struct conflict_info));
       	mi->directory_name = current_dir_name;
       	mi->basename_offset = current_dir_name_len;
       	mi->clean = !!resolved;
     +@@ merge-ort.c: static void add_pair(struct merge_options *opt,
     + 		     unsigned dir_rename_mask)
     + {
     + 	struct diff_filespec *one, *two;
     +-	struct mem_pool *pool = opt->priv->pool;
     + 	struct rename_info *renames = &opt->priv->renames;
     + 	int names_idx = is_add ? side : 0;
     + 
     +@@ merge-ort.c: static void add_pair(struct merge_options *opt,
     + 			return;
     + 	}
     + 
     +-	one = pool_alloc_filespec(pool, pathname);
     +-	two = pool_alloc_filespec(pool, pathname);
     ++	one = pool_alloc_filespec(&opt->priv->pool, pathname);
     ++	two = pool_alloc_filespec(&opt->priv->pool, pathname);
     + 	fill_filespec(is_add ? two : one,
     + 		      &names[names_idx].oid, 1, names[names_idx].mode);
     +-	pool_diff_queue(pool, &renames->pairs[side], one, two);
     ++	pool_diff_queue(&opt->priv->pool, &renames->pairs[side], one, two);
     + }
     + 
     + static void collect_rename_info(struct merge_options *opt,
      @@ merge-ort.c: static int collect_merge_info_callback(int n,
       	len = traverse_path_len(info, p->pathlen);
       
       	/* +1 in both of the following lines to include the NUL byte */
      -	fullpath = pool_alloc(opt->priv->pool, len + 1);
     -+	fullpath = mem_pool_alloc(opt->priv->pool, len + 1);
     ++	fullpath = mem_pool_alloc(&opt->priv->pool, len + 1);
       	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
       
       	/*
     +@@ merge-ort.c: static int handle_deferred_entries(struct merge_options *opt,
     + 		copy = renames->deferred[side].possible_trivial_merges;
     + 		strintmap_init_with_options(&renames->deferred[side].possible_trivial_merges,
     + 					    0,
     +-					    opt->priv->pool,
     ++					    &opt->priv->pool,
     + 					    0);
     + 		strintmap_for_each_entry(&copy, &iter, entry) {
     + 			const char *path = entry->key;
      @@ merge-ort.c: static void apply_directory_rename_modifications(struct merge_options *opt,
     + 	VERIFY_CI(ci);
     + 
     + 	/* Find parent directories missing from opt->priv->paths */
     +-	if (opt->priv->pool) {
     +-		cur_path = mem_pool_strdup(opt->priv->pool, new_path);
     +-		free((char*)new_path);
     +-		new_path = (char *)cur_path;
     +-	} else {
     +-		cur_path = new_path;
     +-	}
     ++	cur_path = mem_pool_strdup(&opt->priv->pool, new_path);
     ++	free((char*)new_path);
     ++	new_path = (char *)cur_path;
     + 
     + 	while (1) {
       		/* Find the parent directory of cur_path */
       		char *last_slash = strrchr(cur_path, '/');
       		if (last_slash) {
      -			parent_name = pool_strndup(opt->priv->pool,
      -						   cur_path,
      -						   last_slash - cur_path);
     -+			parent_name = mem_pool_strndup(opt->priv->pool,
     ++			parent_name = mem_pool_strndup(&opt->priv->pool,
      +						       cur_path,
      +						       last_slash - cur_path);
       		} else {
       			parent_name = opt->priv->toplevel_dir;
       			break;
     +@@ merge-ort.c: static void apply_directory_rename_modifications(struct merge_options *opt,
     + 		/* Look it up in opt->priv->paths */
     + 		entry = strmap_get_entry(&opt->priv->paths, parent_name);
     + 		if (entry) {
     +-			if (!opt->priv->pool)
     +-				free((char*)parent_name);
     + 			parent_name = entry->key; /* reuse known pointer */
     + 			break;
     + 		}
     +@@ merge-ort.c: static void apply_directory_rename_modifications(struct merge_options *opt,
     + 		parent_name = cur_dir;
     + 	}
     + 
     +-	if (!opt->priv->pool) {
     +-		/*
     +-		 * We are removing old_path from opt->priv->paths.
     +-		 * old_path also will eventually need to be freed, but it
     +-		 * may still be used by e.g.  ci->pathnames.  So, store it
     +-		 * in another string-list for now.
     +-		 */
     +-		string_list_append(&opt->priv->paths_to_free, old_path);
     +-	}
     +-
     + 	assert(ci->filemask == 2 || ci->filemask == 4);
     + 	assert(ci->dirmask == 0);
     + 	strmap_remove(&opt->priv->paths, old_path, 0);
     +@@ merge-ort.c: static void apply_directory_rename_modifications(struct merge_options *opt,
     + 		new_ci->stages[index].mode = ci->stages[index].mode;
     + 		oidcpy(&new_ci->stages[index].oid, &ci->stages[index].oid);
     + 
     +-		if (!opt->priv->pool)
     +-			free(ci);
     + 		ci = new_ci;
     + 	}
     + 
     +@@ merge-ort.c: static void use_cached_pairs(struct merge_options *opt,
     + {
     + 	struct hashmap_iter iter;
     + 	struct strmap_entry *entry;
     +-	struct mem_pool *pool = opt->priv->pool;
     + 
     + 	/*
     + 	 * Add to side_pairs all entries from renames->cached_pairs[side_index].
     +@@ merge-ort.c: static void use_cached_pairs(struct merge_options *opt,
     + 		const char *new_name = entry->value;
     + 		if (!new_name)
     + 			new_name = old_name;
     +-		if (pool) {
     +-			/*
     +-			 * cached_pairs has _copies* of old_name and new_name,
     +-			 * because it has to persist across merges.  When
     +-			 *   pool != NULL
     +-			 * pool_alloc_filespec() will just re-use the existing
     +-			 * filenames, which will also get re-used by
     +-			 * opt->priv->paths if they become renames, and then
     +-			 * get freed at the end of the merge, leaving the copy
     +-			 * in cached_pairs dangling.  Avoid this by making a
     +-			 * copy here.
     +-			 *
     +-			 * When pool == NULL, pool_alloc_filespec() calls
     +-			 * alloc_filespec(), which makes a copy; we don't want
     +-			 * to add another.
     +-			 */
     +-			old_name = mem_pool_strdup(pool, old_name);
     +-			new_name = mem_pool_strdup(pool, new_name);
     +-		}
     ++
     ++		/*
     ++		 * cached_pairs has *copies* of old_name and new_name,
     ++		 * because it has to persist across merges.  Since
     ++		 * pool_alloc_filespec() will just re-use the existing
     ++		 * filenames, which will also get re-used by
     ++		 * opt->priv->paths if they become renames, and then
     ++		 * get freed at the end of the merge, that would leave
     ++		 * the copy in cached_pairs dangling.  Avoid this by
     ++		 * making a copy here.
     ++		 */
     ++		old_name = mem_pool_strdup(&opt->priv->pool, old_name);
     ++		new_name = mem_pool_strdup(&opt->priv->pool, new_name);
     + 
     + 		/* We don't care about oid/mode, only filenames and status */
     +-		one = pool_alloc_filespec(pool, old_name);
     +-		two = pool_alloc_filespec(pool, new_name);
     +-		pool_diff_queue(pool, pairs, one, two);
     ++		one = pool_alloc_filespec(&opt->priv->pool, old_name);
     ++		two = pool_alloc_filespec(&opt->priv->pool, new_name);
     ++		pool_diff_queue(&opt->priv->pool, pairs, one, two);
     + 		pairs->queue[pairs->nr-1]->status = entry->value ? 'R' : 'D';
     + 	}
     + }
     +@@ merge-ort.c: static int detect_regular_renames(struct merge_options *opt,
     + 	diff_queued_diff = renames->pairs[side_index];
     + 	trace2_region_enter("diff", "diffcore_rename", opt->repo);
     + 	diffcore_rename_extended(&diff_opts,
     +-				 opt->priv->pool,
     ++				 &opt->priv->pool,
     + 				 &renames->relevant_sources[side_index],
     + 				 &renames->dirs_removed[side_index],
     + 				 &renames->dir_rename_count[side_index],
     +@@ merge-ort.c: static int collect_renames(struct merge_options *opt,
     + 
     + 		if (p->status != 'A' && p->status != 'R') {
     + 			possibly_cache_new_pair(renames, p, side_index, NULL);
     +-			pool_diff_free_filepair(opt->priv->pool, p);
     ++			pool_diff_free_filepair(&opt->priv->pool, p);
     + 			continue;
     + 		}
     + 
     +@@ merge-ort.c: static int collect_renames(struct merge_options *opt,
     + 
     + 		possibly_cache_new_pair(renames, p, side_index, new_path);
     + 		if (p->status != 'R' && !new_path) {
     +-			pool_diff_free_filepair(opt->priv->pool, p);
     ++			pool_diff_free_filepair(&opt->priv->pool, p);
     + 			continue;
     + 		}
     + 
     +@@ merge-ort.c: cleanup:
     + 		side_pairs = &renames->pairs[s];
     + 		for (i = 0; i < side_pairs->nr; ++i) {
     + 			struct diff_filepair *p = side_pairs->queue[i];
     +-			pool_diff_free_filepair(opt->priv->pool, p);
     ++			pool_diff_free_filepair(&opt->priv->pool, p);
     + 		}
     + 	}
     + 
     +@@ merge-ort.c: simple_cleanup:
     + 	if (combined.nr) {
     + 		int i;
     + 		for (i = 0; i < combined.nr; i++)
     +-			pool_diff_free_filepair(opt->priv->pool,
     ++			pool_diff_free_filepair(&opt->priv->pool,
     + 						combined.queue[i]);
     + 		free(combined.queue);
     + 	}
      @@ merge-ort.c: static void process_entry(struct merge_options *opt,
       		 * the directory to remain here, so we need to move this
       		 * path to some new location.
       		 */
      -		new_ci = pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
     -+		new_ci = mem_pool_calloc(opt->priv->pool, 1, sizeof(*new_ci));
     ++		new_ci = mem_pool_calloc(&opt->priv->pool, 1, sizeof(*new_ci));
       
       		/* We don't really want new_ci->merged.result copied, but it'll
       		 * be overwritten below so it doesn't matter.  We also don't
     @@ merge-ort.c: static void process_entry(struct merge_options *opt,
       			int rename_a = 0, rename_b = 0;
       
      -			new_ci = pool_alloc(opt->priv->pool, sizeof(*new_ci));
     -+			new_ci = mem_pool_alloc(opt->priv->pool,
     ++			new_ci = mem_pool_alloc(&opt->priv->pool,
      +						sizeof(*new_ci));
       
       			if (S_ISREG(a_mode))
       				rename_a = 1;
     +@@ merge-ort.c: static void process_entry(struct merge_options *opt,
     + 				b_path = path;
     + 			strmap_put(&opt->priv->paths, b_path, new_ci);
     + 
     +-			if (rename_a && rename_b) {
     ++			if (rename_a && rename_b)
     + 				strmap_remove(&opt->priv->paths, path, 0);
     +-				/*
     +-				 * We removed path from opt->priv->paths.  path
     +-				 * will also eventually need to be freed if not
     +-				 * part of a memory pool...but it may still be
     +-				 * used by e.g. ci->pathnames.  So, store it in
     +-				 * another string-list for now in that case.
     +-				 */
     +-				if (!opt->priv->pool)
     +-					string_list_append(&opt->priv->paths_to_free,
     +-							   path);
     +-			}
     + 
     + 			/*
     + 			 * Do special handling for b_path since process_entry()
      @@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
       
       	/* Initialization of various renames fields */
       	renames = &opt->priv->renames;
      -#if USE_MEMORY_POOL
     - 	mem_pool_init(&opt->priv->internal_pool, 0);
     +-	mem_pool_init(&opt->priv->internal_pool, 0);
      -	opt->priv->pool = &opt->priv->internal_pool;
      -#else
      -	opt->priv->pool = NULL;
      -#endif
      -	pool = opt->priv->pool;
     -+	pool = opt->priv->pool = &opt->priv->internal_pool;
     ++	mem_pool_init(&opt->priv->pool, 0);
     ++	pool = &opt->priv->pool;
       	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
       		strintmap_init_with_options(&renames->dirs_removed[i],
       					    NOT_RELEVANT, pool, 0);
     +@@ merge-ort.c: static void merge_start(struct merge_options *opt, struct merge_result *result)
     + 	 * Although we initialize opt->priv->paths with strdup_strings=0,
     + 	 * that's just to avoid making yet another copy of an allocated
     + 	 * string.  Putting the entry into paths means we are taking
     +-	 * ownership, so we will later free it.  paths_to_free is similar.
     ++	 * ownership, so we will later free it.
     + 	 *
     + 	 * In contrast, conflicted just has a subset of keys from paths, so
     + 	 * we don't want to free those (it'd be a duplicate free).
     + 	 */
     + 	strmap_init_with_options(&opt->priv->paths, pool, 0);
     + 	strmap_init_with_options(&opt->priv->conflicted, pool, 0);
     +-	if (!opt->priv->pool)
     +-		string_list_init_nodup(&opt->priv->paths_to_free);
     + 
     + 	/*
     + 	 * keys & strbufs in output will sometimes need to outlive "paths",

-- 
gitgitgadget
