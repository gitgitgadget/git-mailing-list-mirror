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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC96C433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715C46146B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhDWVfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDWVfG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37790C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e7so40697027wrs.11
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GcVuyUnMLV4vJ69qzQyl/oUdcMYPtpo6UUPsrVrqH4w=;
        b=bG4txs7wocKdGb/l7mSOI23qIQgAk8d4uvtRm0xtocIcnn8q4m7AuoEK4NztOvrxbY
         PK7Lo/dkuSB4QCjOLrU1CSiMnSU16Nhzt8ZZCfpQzxaISPvNyD23ZsdpqgQjDGdGYpXD
         ZfMGXigY0Iuh5VwyXvvsO7y4L5edJ4amh9bX3E4catPbUzDraF7S6le2oV0Tr0orzCgo
         r2Ik5Iwk7hCQruW7Bk3Z5GPSPmdPDCUDNY6dCh5gaDCxjMngi9teHsLjWnZ7IyBl2gA3
         8koOlJdY6Jl9XsIDW+dEABb0eqSwfcVm30vkYeV2Mc1mG5gM5Y/ZiwMVO0vkYIZaNFki
         q+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GcVuyUnMLV4vJ69qzQyl/oUdcMYPtpo6UUPsrVrqH4w=;
        b=YOcodHmuZvrVCqdsq057PGJWG7uHtE9ZICKDxRg/li5bYBi2IKzs41YRT90vCC4QTi
         TUv+E4ieSJxWbRPeSQCipCkOW/Wc+giUxBvuZ8WDCQaG1OjkR+QJHiEt4x/Du/toS3at
         WZiF37xzZN2/1bUXQklqwDTw2hmzgzxKtj6Ny8a3eyKO6SEDvPGZOm+rpa3y7QA0MH5c
         WeXgYzwYXI3gFVbM1WqwPy1N42lbrY6kvMV6iWI75U8k9laGwUSKd8N5kMP6w2wHIlQb
         VPwQF99tsyiPIMh1xGskodlq6j7so4cknvKAnF9IIT9KS9KfQFRncWg7zukvMZkZeVph
         jxig==
X-Gm-Message-State: AOAM530rhvrK32ajJSamCaAkveHxub/JkOFwBhFo8Kr1N8/E9EhtGZ2E
        bzmsMZlBEJXPJONyStqrPHhRklB3yNY=
X-Google-Smtp-Source: ABdhPJw8oTSJQCv3/cjahtNYhQeNBcr0tV1XVJlWoHHYP8mSJ353vvAI59+dnH/1Q1vTNW5dFhZFPg==
X-Received: by 2002:a05:6000:180b:: with SMTP id m11mr6978655wrh.355.1619213666882;
        Fri, 23 Apr 2021 14:34:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4sm10862926wrx.56.2021.04.23.14.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:26 -0700 (PDT)
Message-Id: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:17 +0000
Subject: [PATCH v2 0/8] Sparse-index: integrate with status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first "payoff" series in the sparse-index work. It makes 'git
status' very fast when a sparse-index is enabled on a repository with
cone-mode sparse-checkout (and a small populated set).

This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
The latter branch is needed because it changes the behavior of 'git add'
around sparse entries, which changes the expectations of a test added in
patch 1.

The approach here is to audit the places where ensure_full_index() pops up
while doing normal commands with pathspecs within the sparse-checkout
definition. Each of these are checked and tested. In the end, the
sparse-index is integrated with these features:

 * git status
 * FS Monitor index extension.

The performance tests in p2000-sparse-operations.sh improve by 95% or more,
even when compared with the full-index cases, not just the sparse-index
cases that previously had extra overhead.

Hopefully this is the first example of how ds/sparse-index-protections has
done the basic work to do these conversions safely, making them look easier
than they seemed when starting this adventure.

Thanks, -Stolee


Updates in V2
=============

 * Based on the feedback, it is clear that 'git add' will require much more
   careful testing and thought. I'm splitting it out of this series and it
   will return with a follow-up.
 * Test cases are improved, both in coverage and organization.
 * The previous "unpack-trees: make sparse aware" patch is split into three
   now.
 * Stale messages based on an old implementation of the "protections" topic
   are now fixed.
 * Performance tests were re-run.

Derrick Stolee (8):
  t1092: add tests for status/add and sparse files
  unpack-trees: preserve cache_bottom
  unpack-trees: compare sparse directories correctly
  unpack-trees: stop recursing into sparse directories
  dir.c: accept a directory as part of cone-mode patterns
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  fsmonitor: test with sparse index

 builtin/commit.c                         |  3 ++
 dir.c                                    | 11 +++++
 read-cache.c                             | 10 +++-
 t/t1092-sparse-checkout-compatibility.sh | 61 ++++++++++++++++++++++--
 t/t7519-status-fsmonitor.sh              | 48 +++++++++++++++++++
 unpack-trees.c                           | 25 ++++++++--
 wt-status.c                              | 14 ++++--
 wt-status.h                              |  1 +
 8 files changed, 161 insertions(+), 12 deletions(-)


base-commit: f723f370c89ad61f4f40aabfd3540b1ce19c00e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v1:

  1:  b2cb5401eff8 !  1:  3bac9edae7d8 t1092: add tests for status/add and sparse files
     @@ Commit message
          Untracked files are fine: adding new files both with 'git add .' and
          'git add folder1/' works just as in a full checkout. This may not be
          entirely desirable, but we are not intending to change behavior at the
     -    moment, only document it.
     +    moment, only document it. A future change could alter the behavior to
     +    be more sensible, and this test could be modified to satisfy the new
     +    expected behavior.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'add, commit, chec
      +	# This "git add folder1/a" is completely ignored
      +	# by the sparse-checkout repos. It causes the
      +	# full repo to have a different staged environment.
     -+	test_must_fail git -C sparse-checkout add folder1/a &&
     -+	test_must_fail git -C sparse-index add folder1/a &&
     ++	#
     ++	# This is not a desirable behavior, but this test
     ++	# ensures that the sparse-index is not the cause
     ++	# of a behavior change.
     ++	test_sparse_match test_must_fail git add folder1/a &&
     ++	test_sparse_match test_must_fail git add --refresh folder1/a &&
      +	git -C full-checkout checkout HEAD -- folder1/a &&
     -+	test_sparse_match git status --porcelain=v2 &&
     ++	test_all_match git status --porcelain=v2 &&
      +
      +	test_all_match git add . &&
      +	test_all_match git status --porcelain=v2 &&
  -:  ------------ >  2:  19344394379d unpack-trees: preserve cache_bottom
  -:  ------------ >  3:  24e71d8c0622 unpack-trees: compare sparse directories correctly
  2:  0a3892d2ec9e !  4:  d3c8948d0a33 unpack-trees: make sparse aware
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    unpack-trees: make sparse aware
     +    unpack-trees: stop recursing into sparse directories
      
     -    As a first step to integrate 'git status' and 'git add' with the sparse
     -    index, we must start integrating unpack_trees() with sparse directory
     -    entries. These changes are currently impossible to trigger because
     -    unpack_trees() calls ensure_full_index() if command_requires_full_index
     -    is true. This is the case for all commands at the moment. As we expand
     -    more commands to be sparse-aware, we might find that more changes are
     -    required to unpack_trees(). The current changes will suffice for
     -    'status' and 'add'.
     +    When walking trees using traverse_trees_recursive() and
     +    unpack_callback(), we must not attempt to walk into a sparse directory
     +    entry. There are no index entries within that directory to compare to
     +    the tree object at that position, so skip over the entries of that tree.
      
     -    unpack_trees() calls the traverse_trees() API using unpack_callback()
     -    to decide if we should recurse into a subtree. We must add new abilities
     -    to skip a subtree if it corresponds to a sparse directory entry.
     -
     -    It is important to be careful about the trailing directory separator
     -    that exists in the sparse directory entries but not in the subtree
     -    paths.
     +    This code is used in many places, so the only way to test it is to start
     +    removing the command_requres_full_index option from one builtin at a
     +    time and carefully test that its use of unpack_trees() behaves correctly
     +    with a sparse-index. Such tests will be added by later changes.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     - ## dir.h ##
     -@@ dir.h: static inline int ce_path_match(struct index_state *istate,
     - 				char *seen)
     - {
     - 	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
     --			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
     -+			      S_ISSPARSEDIR(ce->ce_mode) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
     - }
     - 
     - static inline int dir_path_match(struct index_state *istate,
     -
     - ## preload-index.c ##
     -@@ preload-index.c: static void *preload_thread(void *_data)
     - 			continue;
     - 		if (S_ISGITLINK(ce->ce_mode))
     - 			continue;
     -+		if (S_ISSPARSEDIR(ce->ce_mode))
     -+			continue;
     - 		if (ce_uptodate(ce))
     - 			continue;
     - 		if (ce_skip_worktree(ce))
     -
     - ## read-cache.c ##
     -@@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
     - 		if (ignore_skip_worktree && ce_skip_worktree(ce))
     - 			continue;
     - 
     -+		if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
     -+			continue;
     -+
     - 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
     - 			filtered = 1;
     - 
     -
       ## unpack-trees.c ##
     -@@ unpack-trees.c: static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
     - {
     - 	ce->ce_flags |= CE_UNPACKED;
     - 
     -+	/*
     -+	 * If this is a sparse directory, don't advance cache_bottom.
     -+	 * That will be advanced later using the cache-tree data.
     -+	 */
     -+	if (S_ISSPARSEDIR(ce->ce_mode))
     -+		return;
     -+
     - 	if (o->cache_bottom < o->src_index->cache_nr &&
     - 	    o->src_index->cache[o->cache_bottom] == ce) {
     - 		int bottom = o->cache_bottom;
     -@@ unpack-trees.c: static int do_compare_entry(const struct cache_entry *ce,
     - 	ce_len -= pathlen;
     - 	ce_name = ce->name + pathlen;
     - 
     -+	/* remove directory separator if a sparse directory entry */
     -+	if (S_ISSPARSEDIR(ce->ce_mode))
     -+		ce_len--;
     - 	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
     - }
     - 
     -@@ unpack-trees.c: static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
     - 	if (cmp)
     - 		return cmp;
     - 
     -+	/* If ce is a sparse directory, then allow equality here. */
     -+	if (S_ISSPARSEDIR(ce->ce_mode))
     -+		return 0;
     -+
     - 	/*
     - 	 * Even if the beginning compared identically, the ce should
     - 	 * compare as bigger than a directory leading up to it!
      @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
       	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
       	struct unpack_trees_options *o = info->data;
       	const struct name_entry *p = names;
     -+	unsigned recurse = 1;
     ++	unsigned unpack_tree = 1;
       
       	/* Find first entry with a real name (we could use "mask" too) */
       	while (!p->mode)
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       				src[0] = ce;
      +
      +				if (S_ISSPARSEDIR(ce->ce_mode))
     -+					recurse = 0;
     ++					unpack_tree = 0;
       			}
       			break;
       		}
       	}
       
      -	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
     -+	if (recurse &&
     ++	if (unpack_tree &&
      +	    unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
       		return -1;
       
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       		}
       
      -		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     -+		if (recurse &&
     ++		if (unpack_tree &&
      +		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
       					     names, info) < 0)
       			return -1;
  3:  28ca717e6526 !  5:  fd96b71968b6 dir.c: accept a directory as part of cone-mode patterns
     @@ dir.c: enum pattern_match_result path_matches_pattern_list(
       	strbuf_addch(&parent_pathname, '/');
       	strbuf_add(&parent_pathname, pathname, pathlen);
       
     -+	/* Directory requests should be added as if they are a file */
     -+	if (parent_pathname.len > 1 &&
     ++	/*
     ++	 * Directory entries are matched if and only if a file
     ++	 * contained immediately within them is matched. For the
     ++	 * case of a directory entry, modify the path to create
     ++	 * a fake filename within this directory, allowing us to
     ++	 * use the file-base matching logic in an equivalent way.
     ++	 */
     ++	if (parent_pathname.len > 0 &&
      +	    parent_pathname.buf[parent_pathname.len - 1] == '/')
      +		strbuf_add(&parent_pathname, "-", 1);
      +
  4:  e86f874dd412 =  6:  1f4ba56e7416 status: skip sparse-checkout percentage with sparse-index
  5:  d7d4cad8be0b !  7:  3d09368c0541 status: use sparse-index throughout
     @@ Commit message
          implementation details are already integrated with sparse-checkout, so
          modify command_requires_full_index to be zero for cmd_status().
      
     -    By running the debugger for 'git status -uno' after that change, we find
     -    two instances of ensure_full_index() that were added for extra safety,
     -    but can be removed without issue.
     +    In refresh_index(), we loop through the index entries to refresh their
     +    stat() information. However, sparse directories have no stat()
     +    information to populate. Ignore these entries.
      
     -    In refresh_index(), we loop through the index entries. The
     -    refresh_cache_ent() method copies the sparse directories into the
     -    refreshed index without issue.
     +    This allows 'git status' to no longer expand a sparse index to a full
     +    one. This is further tested by dropping the "-uno" option and adding an
     +    untracked file into the worktree.
      
     -    The loop within run_diff_files() skips things that are in stage 0 and
     -    have skip-worktree enabled, so seems safe to disable ensure_full_index()
     -    here.
     -
     -    This allows some cases of 'git status' to no longer expand a sparse
     -    index to a full one, giving the following performance improvements for
     -    p2000-sparse-checkout-operations.sh:
     +    The performance test p2000-sparse-checkout-operations.sh demonstrates
     +    these improvements:
      
          Test                                  HEAD~1           HEAD
          -----------------------------------------------------------------------------
     -    2000.2: git status (full-index-v3)    0.38(0.36+0.07)  0.37(0.31+0.10) -2.6%
     -    2000.3: git status (full-index-v4)    0.38(0.29+0.12)  0.37(0.30+0.11) -2.6%
     -    2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
     -    2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%
     +    2000.2: git status (full-index-v3)    0.31(0.30+0.05)  0.31(0.29+0.06) +0.0%
     +    2000.3: git status (full-index-v4)    0.31(0.29+0.07)  0.34(0.30+0.08) +9.7%
     +    2000.4: git status (sparse-index-v3)  2.35(2.28+0.10)  0.04(0.04+0.05) -98.3%
     +    2000.5: git status (sparse-index-v4)  2.35(2.24+0.15)  0.05(0.04+0.06) -97.9%
      
          Note that since HEAD~1 was expanding the sparse index by parsing trees,
          it was artificially slower than the full index case. Thus, the 98%
     -    improvement is misleading, and instead we should celebrate the 0.37s to
     -    0.05s improvement of 82%. This is more indicative of the peformance
     +    improvement is misleading, and instead we should celebrate the 0.34s to
     +    0.05s improvement of 85%. This is more indicative of the peformance
          gains we are expecting by using a sparse index.
      
          Note: we are dropping the assignment of core.fsmonitor here. This is not
     @@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
       	trace2_region_enter("index", "refresh", NULL);
      -	/* TODO: audit for interaction with sparse-index. */
      -	ensure_full_index(istate);
     ++
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce, *new_entry;
       		int cache_errno = 0;
     +@@ read-cache.c: int refresh_index(struct index_state *istate, unsigned int flags,
     + 		if (ignore_skip_worktree && ce_skip_worktree(ce))
     + 			continue;
     + 
     ++		/*
     ++		 * If this entry is a sparse directory, then there isn't
     ++		 * any stat() information to update. Ignore the entry.
     ++		 */
     ++		if (S_ISSPARSEDIR(ce->ce_mode))
     ++			continue;
     ++
     + 		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
     + 			filtered = 1;
     + 
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is expanded and converted back' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is e
      +	init_repos &&
      +
      +	rm -f trace2.txt &&
     ++	echo >>sparse-index/untracked.txt &&
       	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
      -		git -C sparse-index -c core.fsmonitor="" status -uno &&
      -	test_region index ensure_full_index trace2.txt
     -+		git -C sparse-index status -uno &&
     ++		git -C sparse-index status &&
      +	test_region ! index ensure_full_index trace2.txt
       '
       
  6:  434306541613 <  -:  ------------ dir: use expand_to_path() for sparse directories
  7:  f1a9ce4ef0e5 <  -:  ------------ add: allow operating on a sparse-only index
  8:  6d7f30f2b90a <  -:  ------------ pathspec: stop calling ensure_full_index
  9:  75199bbe8ca1 <  -:  ------------ t7519: add sparse directories to FS monitor tests
 10:  9d1183ddd280 !  8:  1fd033a6ebb2 fsmonitor: test with sparse index
     @@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds after staging/
       	)
       '
       
     -+test_expect_success 'status succeeds with sparse index' '
     -+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
     ++# Usage:
     ++# check_sparse_index_behavior [!]
     ++# If "!" is supplied, then we verify that we do not call ensure_full_index
     ++# during a call to 'git status'. Otherwise, we verify that we _do_ call it.
     ++check_sparse_index_behavior () {
      +	git status --porcelain=v2 >expect &&
      +	git sparse-checkout init --cone --sparse-index &&
     ++	git sparse-checkout set dir1 dir2 &&
      +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
      +		git status --porcelain=v2 >actual &&
     -+	test_region ! index ensure_full_index trace2.txt &&
     ++	test_region $1 index ensure_full_index trace2.txt &&
      +	test_cmp expect actual &&
      +	rm trace2.txt &&
     ++	git sparse-checkout disable
     ++}
     ++
     ++test_expect_success 'status succeeds with sparse index' '
     ++	git reset --hard &&
     ++
     ++	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
     ++	check_sparse_index_behavior ! &&
      +
      +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
      +		printf "last_update_token\0"
      +	EOF
      +	git config core.fsmonitor .git/hooks/fsmonitor-test &&
     -+	git status --porcelain=v2 >expect &&
     -+	git sparse-checkout init --cone --sparse-index &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     -+		git status --porcelain=v2 >actual &&
     -+	test_region ! index ensure_full_index trace2.txt &&
     -+	test_cmp expect actual &&
     -+	rm trace2.txt &&
     ++	check_sparse_index_behavior ! &&
      +
      +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
      +		printf "last_update_token\0"
      +		printf "dir1/modified\0"
      +	EOF
     -+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
     -+	git status --porcelain=v2 >expect &&
     -+	git sparse-checkout init --cone --sparse-index &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     -+		git status --porcelain=v2 >actual &&
     -+	test_region ! index ensure_full_index trace2.txt &&
     -+	test_cmp expect actual &&
     ++	check_sparse_index_behavior ! &&
      +
     ++	cp -r dir1 dir1a &&
     ++	git add dir1a &&
     ++	git commit -m "add dir1a" &&
     ++
     ++	# This one modifies outside the sparse-checkout definition
     ++	# and hence we expect to expand the sparse-index.
      +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
      +		printf "last_update_token\0"
      +		printf "dir1a/modified\0"
      +	EOF
     -+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
     -+	git status --porcelain=v2 >expect &&
     -+	git sparse-checkout init --cone --sparse-index &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     -+		git status --porcelain=v2 >actual &&
     -+	test_region index ensure_full_index trace2.txt &&
     -+	test_cmp expect actual
     ++	check_sparse_index_behavior
      +'
      +
       test_done

-- 
gitgitgadget
