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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E47DC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB8E6138B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhHXVwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhHXVwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:52:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF764C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so3223548wml.3
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=wRm8PsJt+1UwT2cUXYX+iGn7UokP3E3TayhZNAP7FfI=;
        b=JqL5lhp4AhmsxhofDcqnkA9mZH5KTSH+soGBdZ6MWhiL28IPHQ/87rkA0lXb+2sVuB
         ofoWuuDtuY6eSGT+nrVI+76hRntzs9HrT1ifQ8LseEPsjb5ENPSY4+xeq7OUQDs8xfbW
         0B9KmiEn9Nfc5JliGHVNtcdClmAtu5VM1qagOkj01HAzNDv3RTnwl/EE2W+Awdomu8Bt
         dXQJIpb3k01bp4KbXVHwwjG2Cl8vu+IRYrVvB93HgDasL5WWLSlzxFmPmjQAcOpxhodQ
         lgQ0MMy09Eb/TzmB1FUvHnVe++rWmY0r36RGljEVDmbDPxCTsO0wid9Ka4gFHKqjuqnQ
         UtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=wRm8PsJt+1UwT2cUXYX+iGn7UokP3E3TayhZNAP7FfI=;
        b=Re+UkE7adYeAlulBWKQaP/a4fe1d1CkfS3EWp7ozeebG7LP9Vjys9DEKj1astOPsfj
         pem4u+w5UZmhbeXqQUQ7SFAm/8Zsn2xr2pbwJZO3VBMewHkBkTozeuFBhlKM6nvmAYlR
         rcoSiSnrIXC4gGC8I3DfCGA2xPKjWYpnFhAziCY3+OdSnDrkqmZMkyKFncQbeUM58vID
         8BtVdys0d4Dr5loST63f/g+1wEWIEjgDE0WbNFCkvvgAByNGuqIChQQaZwbNSr388S4j
         A77ApMxQcStpp1O+4hwSxbA2AfJpfbh3zxgz+K494rUBtee42OyC+ThvLkwWKIpPdiVK
         W3ZQ==
X-Gm-Message-State: AOAM530HbK1BIOVwq94xs0BZEengrwMqg4iYPwlC72LzSvKIim5G9oyY
        1V412G2vr91+/fMejLA2Jf1nYIvcaG4=
X-Google-Smtp-Source: ABdhPJw2yMqPV/vzVp6I/SX18/HLD8ydki2Ks3mjaOQPpBdXRX7it83Ouw8oeXyjL7MeBM/GO4mrOQ==
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr6185932wmq.122.1629841905451;
        Tue, 24 Aug 2021 14:51:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm16273432wrd.50.2021.08.24.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:51:45 -0700 (PDT)
Message-Id: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:51:34 +0000
Subject: [PATCH v4 00/10] Sparse index: delete ignored files outside sparse cone
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UPDATE: I had to base this version on a merge of ds/add-with-sparse-index
and v2.33.0-rc1 because of some changes to dir.h that became important!

We launched an experimental release [1] of the sparse-index feature to our
internal users. We immediately discovered a problem due to the isolated way
in which we tested the sparse index: we were never building the project and
changing our sparse-checkout definition.

[1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp

Users who ran a build in one project and then moved to another still had
build artifacts in their worktree that lived inside the old directories.
Since the files are marked by the .gitignore patterns, these files were not
removed by the 'git sparse-checkout set' command. However, they make the
sparse-index unusable because every 'git status' command needs to expand the
sparse-directory entries in order to see if the files are tracked or not.
This made the first experimental release actually slower for all users
because of this cost.

The solution we shipped to these customers was to change the way our fork
handles these ignored files. Specifically, instead of Git completely
ignoring the files, we changed Git to understand that with cone-mode
sparse-checkout patterns, the users is asking for entire directories to be
removed from the worktree. The link [1] included earlier has this change.

I believe that this is a reasonable expectation, though I recognize that it
might look like breaking the expectations of how .gitignore files work.

Since feedback demonstrated that this is a desired behavior, v2 includes
this behavior for all "cone mode" repositories.

I'm interested in the community's thoughts about this change, as it seems
like one that we should make carefully and intentionally.

While the rewrite of the t7519 test seems unrelated, it is required to avoid
a test failure with this change that deletes files outside of the cone. By
moving the test into repositories not at $TRASH_DIRECTORY, we gain more
control over the repository structure.


Updates in V4
=============

 * Fixed an issue with the split index.

 * The helper methods are used more consistently.

 * The helper method path_in_cone_mode_sparse_checkout() is introduced.

 * Commit messages are edited for clarity.

 * A new config option is added to disable the behavior being added in this
   series.

 * I split the commit that involves cache_tree_update(). I have not yet
   succeeded in creating tests to demonstrate why this is required outside
   of needing it in the Scalar functional tests, which includes a version of
   partial clone. I will continue to investigate recreating this scenario in
   the Git test suite, but I wanted to send this version out to get feedback
   on the things that have changed.


Update in V3
============

 * As promised [2], the helper methods are fixed to work with non-cone-mode
   patterns. A later series will use them to their fullest potential
   (changing git add, git rm, and git mv when interacting with sparse
   entries).

[2]
https://lore.kernel.org/git/bac76c72-955d-1ade-4ecf-778ffc45f297@gmail.com/


Updates in V2
=============

 * This version correctly leaves untracked files alone. If untracked files
   are found, then the directory is left as-is, in case those ignored files
   are important to the user's work resolving those untracked files.

 * This behavior is now enabled by core.sparseCheckoutCone=true.

 * To use a sparse index as an in-memory data structure even when
   index.sparse is disabled, a new patch is included to modify the prototype
   of convert_to_sparse() to include a flags parameter.

 * A few cleanup patches that I was collecting based on feedback from the
   experimental release and intending for my next series were necessary for
   this implementation.

 * Cleaned up the tests (no NEEDSWORK) and the remainders of a previous
   implementation that used run_subcommand().

Thanks, -Stolee

Derrick Stolee (10):
  t7519: rewrite sparse index test
  sparse-index: silently return when not using cone-mode patterns
  sparse-index: silently return when cache tree fails
  sparse-index: use WRITE_TREE_MISSING_OK
  unpack-trees: fix nested sparse-dir search
  sparse-checkout: create helper methods
  attr: be careful about sparse directories
  sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
  sparse-checkout: clear tracked sparse dirs
  sparse-checkout: add config to disable deleting dirs

 Documentation/config/index.txt        |   6 ++
 Documentation/git-sparse-checkout.txt |  10 +++
 attr.c                                |  14 ++++
 builtin/add.c                         |   7 +-
 builtin/sparse-checkout.c             | 101 ++++++++++++++++++++++++++
 dir.c                                 |  52 +++++++++++++
 dir.h                                 |   8 ++
 read-cache.c                          |   4 +-
 sparse-index.c                        |  76 ++++++++++---------
 sparse-index.h                        |   3 +-
 t/t1091-sparse-checkout-builtin.sh    |  63 ++++++++++++++++
 t/t7519-status-fsmonitor.sh           |  38 +++++-----
 unpack-trees.c                        |   7 +-
 13 files changed, 328 insertions(+), 61 deletions(-)


base-commit: 80b8d6c56b8a5f5db1d5c2a0159fd808e8a7fc4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1009%2Fderrickstolee%2Fsparse-index%2Fignored-files-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1009/derrickstolee/sparse-index/ignored-files-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1009

Range-diff vs v3:

  1:  e66106f7a99 !  1:  c407b2cb346 t7519: rewrite sparse index test
     @@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds after staging/
       test_expect_success 'status succeeds with sparse index' '
      -	git reset --hard &&
      +	git clone . full &&
     -+	git clone . sparse &&
     ++	git clone --sparse . sparse &&
      +	git -C sparse sparse-checkout init --cone --sparse-index &&
      +	git -C sparse sparse-checkout set dir1 dir2 &&
       
  2:  fb3ff9108bf !  2:  8660877ba7a sparse-index: silently return when not using cone-mode patterns
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
       {
       	int test_env;
      -	if (istate->split_index || istate->sparse_index ||
     -+
      +	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
       	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
       		return 0;
  3:  37198535268 !  3:  a669740af9a sparse-index: silently return when cache tree fails
     @@ Commit message
          convert_to_sparse(), then we could still recover from this scenario and
          have a sparse index.
      
     -    When constructing the cache-tree extension in convert_to_sparse(), it is
     -    possible that we construct a tree object that is new to the object
     -    database. Without the WRITE_TREE_MISSING_OK flag, this results in an
     -    error that halts our conversion to a sparse index. Add this flag to
     -    remove this limitation.
     -
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## sparse-index.c ##
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
      +	/*
      +	 * Silently return if there is a problem with the cache tree update,
      +	 * which might just be due to a conflict state in some entry.
     -+	 *
     -+	 * This might create new tree objects, so be sure to use
     -+	 * WRITE_TREE_MISSING_OK.
      +	 */
     -+	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
     ++	if (cache_tree_update(istate, 0))
      +		return 0;
       
       	remove_fsmonitor(istate);
  -:  ----------- >  4:  b379b8fc61a sparse-index: use WRITE_TREE_MISSING_OK
  4:  10bcadb284e !  5:  acdded0f762 unpack-trees: fix nested sparse-dir search
     @@ Commit message
          diff that modified files within the sparse directory entry, but we could
          not correctly find the entry.
      
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
     @@ unpack-trees.c: static int sparse_dir_matches_path(const struct cache_entry *ce,
       					    const struct name_entry *p)
       {
      -	struct cache_entry *ce;
     ++	const char *path;
      +	struct cache_entry *ce = NULL;
       	int pos = find_cache_pos(info, p->path, p->pathlen);
       	struct unpack_trees_options *o = info->data;
     -+	struct strbuf full_path = STRBUF_INIT;
       
     - 	if (0 <= pos)
     - 		return o->src_index->cache[pos];
     -@@ unpack-trees.c: static struct cache_entry *find_cache_entry(struct traverse_info *info,
     - 	if (pos < 0 || pos >= o->src_index->cache_nr)
     - 		return NULL;
     - 
     -+	strbuf_addstr(&full_path, info->traverse_path);
     -+	strbuf_add(&full_path, p->path, p->pathlen);
     -+	strbuf_addch(&full_path, '/');
     -+
     - 	/*
     - 	 * Due to lexicographic sorting and sparse directory
     - 	 * entries ending with a trailing slash, our path as a
      @@ unpack-trees.c: static struct cache_entry *find_cache_entry(struct traverse_info *info,
       	while (pos >= 0) {
       		ce = o->src_index->cache[pos];
       
      -		if (strncmp(ce->name, p->path, p->pathlen))
     --			return NULL;
     -+		if (strncmp(ce->name, full_path.buf, full_path.len)) {
     -+			ce = NULL;
     -+			break;
     -+		}
     ++		if (!skip_prefix(ce->name, info->traverse_path, &path) ||
     ++		    strncmp(path, p->path, p->pathlen) ||
     ++		    path[p->pathlen] != '/')
     + 			return NULL;
       
       		if (S_ISSPARSEDIR(ce->ce_mode) &&
     - 		    sparse_dir_matches_path(ce, info, p))
     --			return ce;
     -+			break;
     - 
     - 		pos--;
     - 	}
     - 
     --	return NULL;
     -+	strbuf_release(&full_path);
     -+	return ce;
     - }
     - 
     - static void debug_path(struct traverse_info *info)
  5:  5d28570c82a !  6:  1958751aa0e sparse-checkout: create helper methods
     @@ Commit message
          adopt these helpers. There are just two in builtin/add.c and
          sparse-index.c that can use path_in_sparse_checkout().
      
     +    We add a path_in_cone_mode_sparse_checkout() as well that will only
     +    return false if the path is outside of the sparse-checkout definition
     +    _and_ the sparse-checkout patterns are in cone mode.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/add.c ##
     @@ builtin/add.c: static int refresh(int verbose, const struct pathspec *pathspec)
      -			    (sparse_checkout_enabled &&
      -			     !path_matches_pattern_list(path, strlen(path), NULL,
      -							&dtype, &pl, &the_index))) {
     -+			    (core_apply_sparse_checkout &&
     -+			     path_in_sparse_checkout(path, &the_index) == NOT_MATCHED)) {
     ++			    !path_in_sparse_checkout(path, &the_index)) {
       				string_list_append(&only_match_skip_worktree,
       						   pathspec->items[i].original);
       			} else {
     @@ dir.c: done:
       
      +int init_sparse_checkout_patterns(struct index_state *istate)
      +{
     -+	if (!core_apply_sparse_checkout ||
     -+	    istate->sparse_checkout_patterns)
     ++	if (!core_apply_sparse_checkout)
     ++		return 1;
     ++	if (istate->sparse_checkout_patterns)
      +		return 0;
      +
      +	CALLOC_ARRAY(istate->sparse_checkout_patterns, 1);
     @@ dir.c: done:
      +	return 0;
      +}
      +
     -+int path_in_sparse_checkout(const char *path,
     -+			    struct index_state *istate)
     ++static int path_in_sparse_checkout_1(const char *path,
     ++				     struct index_state *istate,
     ++				     int require_cone_mode)
      +{
      +	const char *base;
      +	int dtype = DT_REG;
     -+	init_sparse_checkout_patterns(istate);
      +
     -+	if (!istate->sparse_checkout_patterns)
     -+		return MATCHED;
     ++	/*
     ++	 * We default to accepting a path if there are no patterns or
     ++	 * they are of the wrong type.
     ++	 */
     ++	if (init_sparse_checkout_patterns(istate) ||
     ++	    (require_cone_mode &&
     ++	     !istate->sparse_checkout_patterns->use_cone_patterns))
     ++		return 1;
      +
      +	base = strrchr(path, '/');
      +	return path_matches_pattern_list(path, strlen(path), base ? base + 1 : path,
     @@ dir.c: done:
      +					 istate->sparse_checkout_patterns,
      +					 istate) > 0;
      +}
     ++
     ++int path_in_sparse_checkout(const char *path,
     ++			    struct index_state *istate)
     ++{
     ++	return path_in_sparse_checkout_1(path, istate, 0);
     ++}
     ++
     ++int path_in_cone_mode_sparse_checkout(const char *path,
     ++				     struct index_state *istate)
     ++{
     ++	return path_in_sparse_checkout_1(path, istate, 1);
     ++}
      +
       static struct path_pattern *last_matching_pattern_from_lists(
       		struct dir_struct *dir, struct index_state *istate,
     @@ dir.h: enum pattern_match_result path_matches_pattern_list(const char *pathname,
      +
      +int path_in_sparse_checkout(const char *path,
      +			    struct index_state *istate);
     ++int path_in_cone_mode_sparse_checkout(const char *path,
     ++				      struct index_state *istate);
      +
       struct dir_entry *dir_add_ignored(struct dir_struct *dir,
       				  struct index_state *istate,
     @@ dir.h: enum pattern_match_result path_matches_pattern_list(const char *pathname,
      
       ## sparse-index.c ##
      @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
     + {
       	int i, can_convert = 1;
       	int start_converted = num_converted;
     - 	enum pattern_match_result match;
     +-	enum pattern_match_result match;
      -	int dtype = DT_UNKNOWN;
       	struct strbuf child_path = STRBUF_INIT;
      -	struct pattern_list *pl = istate->sparse_checkout_patterns;
     @@ sparse-index.c: static int convert_to_sparse_rec(struct index_state *istate,
       	 */
      -	match = path_matches_pattern_list(ct_path, ct_pathlen,
      -					  NULL, &dtype, pl, istate);
     -+	match = path_in_sparse_checkout(ct_path, istate);
     - 	if (match != NOT_MATCHED)
     +-	if (match != NOT_MATCHED)
     ++	if (path_in_sparse_checkout(ct_path, istate))
       		can_convert = 0;
       
     + 	for (i = start; can_convert && i < end; i++) {
      @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
       	if (!istate->repo->settings.sparse_index)
       		return 0;
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
      -		if (get_sparse_checkout_patterns(istate->sparse_checkout_patterns) < 0)
      -			return 0;
      -	}
     -+	if (init_sparse_checkout_patterns(istate) < 0)
     ++	if (init_sparse_checkout_patterns(istate))
      +		return 0;
       
       	/*
  6:  c9e100e68f8 !  7:  e496f3cee66 attr: be careful about sparse directories
     @@ attr.c: static struct attr_stack *read_attr_from_index(struct index_state *istat
       		return NULL;
       
      +	/*
     -+	 * In the case of cone-mode sparse-checkout, getting the
     -+	 * .gitattributes file from a directory is meaningless: all
     -+	 * contained paths will be sparse if the .gitattributes is also
     -+	 * sparse. In the case of a sparse index, it is critical that we
     -+	 * don't go looking for one as it will expand the index.
     ++	 * The .gitattributes file only applies to files within its
     ++	 * parent directory. In the case of cone-mode sparse-checkout,
     ++	 * the .gitattributes file is sparse if and only if all paths
     ++	 * within that directory are also sparse. Thus, don't load the
     ++	 * .gitattributes file since it will not matter.
     ++	 *
     ++	 * In the case of a sparse index, it is critical that we don't go
     ++	 * looking for a .gitattributes file, as the index will expand.
      +	 */
     -+	init_sparse_checkout_patterns(istate);
     -+	if (istate->sparse_checkout_patterns &&
     -+	    istate->sparse_checkout_patterns->use_cone_patterns &&
     -+	    path_in_sparse_checkout(path, istate) == NOT_MATCHED)
     ++	if (!path_in_cone_mode_sparse_checkout(path, istate))
      +		return NULL;
      +
       	buf = read_blob_data_from_index(istate, path, NULL);
  7:  b0ece4b7dcc !  8:  cab9360b1e9 sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    sparse-index: add SPARSE_INDEX_IGNORE_CONFIG flag
     +    sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
      
          The convert_to_sparse() method checks for the GIT_TEST_SPARSE_INDEX
          environment variable or the "index.sparse" config setting before
     @@ Commit message
          index as an in-memory data structure, regardless of whether the on-disk
          format should be sparse.
      
     -    To that end, create the SPARSE_INDEX_IGNORE_CONFIG flag that will skip
     +    To that end, create the SPARSE_INDEX_MEMORY_ONLY flag that will skip
          these config checks when enabled. All current consumers are modified to
          pass '0' in the new 'flags' parameter.
      
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      +int convert_to_sparse(struct index_state *istate, int flags)
       {
       	int test_env;
     +-	if (istate->split_index || istate->sparse_index || !istate->cache_nr ||
     ++	if (istate->sparse_index || !istate->cache_nr ||
     + 	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
     + 		return 0;
       
     -@@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
       	if (!istate->repo)
       		istate->repo = the_repository;
       
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
      -	test_env = git_env_bool("GIT_TEST_SPARSE_INDEX", -1);
      -	if (test_env >= 0)
      -		set_sparse_index_config(istate->repo, test_env);
     -+	if (!(flags & SPARSE_INDEX_IGNORE_CONFIG)) {
     ++	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
     ++		/*
     ++		 * The sparse index is not (yet) integrated with a split index.
     ++		 */
     ++		if (istate->split_index)
     ++			return 0;
      +		/*
      +		 * The GIT_TEST_SPARSE_INDEX environment variable triggers the
      +		 * index.sparse config variable to be on.
     @@ sparse-index.c: int convert_to_sparse(struct index_state *istate)
      +			return 0;
      +	}
       
     - 	if (init_sparse_checkout_patterns(istate) < 0)
     + 	if (init_sparse_checkout_patterns(istate))
       		return 0;
      
       ## sparse-index.h ##
     @@ sparse-index.h
       
       struct index_state;
      -int convert_to_sparse(struct index_state *istate);
     -+#define SPARSE_INDEX_IGNORE_CONFIG (1 << 0)
     ++#define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
      +int convert_to_sparse(struct index_state *istate, int flags);
       
       /*
  8:  febef675f05 !  9:  c19d93ec5d7 sparse-checkout: clear tracked sparse dirs
     @@ Commit message
          the sparse directory. This depends on the indexed version of the file,
          so the sparse directory must be expanded.
      
     +    We must take special care to look for untracked, non-ignored files in
     +    these directories before deleting them. We do not want to delete any
     +    meaningful work that the users were doing in those directories and
     +    perhaps forgot to add and commit before switching sparse-checkout
     +    definitions. Since those untracked files might be code files that
     +    generated ignored build output, also do not delete any ignored files
     +    from these directories in that case. The users can recover their state
     +    by resetting their sparse-checkout definition to include that directory
     +    and continue. Alternatively, they can see the warning that is presented
     +    and delete the directory themselves to regain the performance they
     +    expect.
     +
          By deleting the sparse directories when changing scope (or running 'git
          sparse-checkout reapply') we regain these performance benefits as if the
          repository was in a clean state.
     @@ Documentation/git-sparse-checkout.txt: case-insensitive check. This corrects for
       'git sparse-checkout set' command to reflect the expected cone in the working
       directory.
       
     -+The cone mode sparse-checkout patterns will also remove ignored files that
     -+are not within the sparse-checkout definition. This is important behavior
     -+to preserve the performance of the sparse index, but also matches that
     -+cone mode patterns care about directories, not files. If there exist files
     -+that are untracked and not ignored, then Git will not delete files within
     -+that directory other than the tracked files that are now out of scope.
     -+These files should be removed manually to ensure Git can behave optimally.
     ++When changing the sparse-checkout patterns in cone mode, Git will inspect each
     ++tracked directory that is not within the sparse-checkout cone to see if it
     ++contains any untracked files. If all of those files are ignored due to the
     ++`.gitignore` patterns, then the directory will be deleted. If any of the
     ++untracked files within that directory is not ignored, then no deletions will
     ++occur within that directory and a warning message will appear. If these files
     ++are important, then reset your sparse-checkout definition so they are included,
     ++use `git add` and `git commit` to store them, then remove any remaining files
     ++manually to ensure Git can behave optimally.
      +
       
       SUBMODULES
     @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      +	 */
      +	if (!r || !r->index || !r->worktree)
      +		return;
     -+	init_sparse_checkout_patterns(r->index);
     -+	if (!r->index->sparse_checkout_patterns ||
     ++	if (init_sparse_checkout_patterns(r->index) ||
      +	    !r->index->sparse_checkout_patterns->use_cone_patterns)
      +		return;
      +
     @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      +		 * prevents us from converting to a sparse index, then do
      +		 * not try deleting files.
      +		 */
     -+		if (convert_to_sparse(r->index, SPARSE_INDEX_IGNORE_CONFIG))
     ++		if (convert_to_sparse(r->index, SPARSE_INDEX_MEMORY_ONLY))
      +			return;
      +		was_full = 1;
      +	}
  -:  ----------- > 10:  8d55a6ba2fd sparse-checkout: add config to disable deleting dirs

-- 
gitgitgadget
