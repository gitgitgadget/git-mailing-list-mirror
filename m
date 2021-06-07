Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FA5C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EB7610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGMgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGMgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A20C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 05:34:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so3893847wme.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K/fl5u5rlgBj1Yzadw8gL3Z9/Q1/ehRW1fs7ftgxqA0=;
        b=R/Q4k2+3GW0lPlWq7Fchc5+Ui9Qf7U3MSthp/cFgEI8hD0+o3lK3wo/6VWwzUCj/BA
         ViTfeIC2zks9EdZuB2LWbSATlKVUVXJ6h/wB2bve8GqEzIttOdj/ddtjOednTjzaRise
         ba1DiFtpHw6hU1nuXqY0AkKESWRdjaINLsv1vYd85SGGtYKoktaT4dsd7qHMT52bt0g8
         IHqP0SaKY5qUn16QxwpQCjcTqWmmqWnIXxaA521pxhWSZgDTfG4eajdvvuA4MlQ1XhQE
         0Gx1VJRodoWIYQWttMtfmtjFdeGXk0cZpfnXMtLrzFb3fDZgQRUqKne8yrvqluExNgjd
         Gxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K/fl5u5rlgBj1Yzadw8gL3Z9/Q1/ehRW1fs7ftgxqA0=;
        b=cALowsTwFFZEL7JTU0AVIAgyuY/F4s2JmGGCL6Q3rtt2N1X9P7y0NG2bvtDTiUBHWb
         u7woOugS4GiAX8FpF0w+nOuHXKVu8am1xoJL4dWgvQ1FFHQ1hm0RycEBgTwVfr5jscP8
         aH+PZxHxJJzFeIIgxwN77/Zbalf07xZZqZJryDOiLbg8TaXcUNwpFLyzPY8F3UeAFpG1
         aaIf0w4bFAhZ50yY/2teIpbMWMsw19BM+KXjuH9/cS/c1Ixvwf0N6hold+PfeN3Su0or
         M85STXQV9ApJetOGuKsk0x2BZoXcB/5R5ax5Ixh0anqZfpb2u4WNX0+X9EnHPWt8IgcB
         wViw==
X-Gm-Message-State: AOAM533x99ZnUtwfLORh7k/R7Ehav6GcDJhod5eT7X1UHlIvoI6Hurbv
        dANmhvUYDmgo5l3ir80FjhWaT/RMxic=
X-Google-Smtp-Source: ABdhPJzFCrLzoFXj7hty/IuKP31eP4EgcP6MQ8gLooQtF8ZFpr6aBu2GD1xAH4rS4zvRgHd09YKbTg==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr16741021wmb.118.1623069254405;
        Mon, 07 Jun 2021 05:34:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g186sm7979114wme.6.2021.06.07.05.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:13 -0700 (PDT)
Message-Id: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:33:58 +0000
Subject: [PATCH v5 00/14] Sparse-index: integrate with status
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


Updates in V5
=============

I replaced one patch with a few that are more complicated. The reason is
that I started integrating with git checkout and realized that some of the
changes I was making in unpack-trees.c were incorrect for that situation, so
I might as well do them right here. The tests can't demonstrate the bugs
with the previous case until we integrate with git checkout, which will
follow in another series after this one is submitted.

For testing, I've integrated this series along with extensions that work for
git commit and git checkout into the Scalar functional tests, which test
many scenarios with cone mode sparse-checkout and hence provides good
evidence that this is working correctly.


Updates in V4
=============

 * The previous patch "unpack-trees: stop recursing into sparse directories"
   was confusing, and actually a bit sloppy.
 * It has been replaced with "unpack-trees: be careful around sparse
   directory entries" which takes the sparse-directory checks and raises
   them higher up into unpack_trees.c instead of in diff-lib.c.


Updates in V3
=============

Sorry that this was a long time coming. I got a little side-tracked on other
projects, but I also worked to get the sparse-index feature working against
the Scalar functional tests, which contain many special cases around the
sparse-checkout feature as they were inherited from special cases that arose
in the virtualized environment of VFS for Git. This version contains my
fixes based on that investigation. Most of these were easy to identify and
fix, but I was blocked for a long time struggling with a bug when combining
the sparse-index with the builtin FS Monitor feature, but I've reported my
findings already [1].

[1]
https://lore.kernel.org/git/0b9e54ba-ac27-e537-7bef-1b4448f92352@gmail.com/

 * Updated comments and tests based on the v2 feedback.
 * Expanded the test repository data shape based on the special cases found
   during my investigation.
 * Added several commits that either fix errors in the status code, or fix
   errors in the previous sparse-index series, specifically:
   * When in a conflict state, the cache-tree fails to update. For now, skip
     writing a sparse-index until this can be resolved more carefully.
   * When expanding a sparse-directory entry, we set the CE_SKIP_WORKTREE
     bit but forgot the CE_EXTENDED bit.
   * git status had failures if there was a sparse-directory entry as the
     first entry within a directory.
   * When expanding a directory to report its status, such as when a
     sparse-directory is staged but doesn't exist at HEAD (such as in an
     orphaned commit) we did not previously recurse correctly into
     subdirectories.
   * Be extra careful with the FS Monitor data when expanding or contracting
     an index. This version now abandons all FS Monitor data at these
     conversion points with the expectation that in the future these
     conversions will be rare so the FS Monitor feature can work
     efficiently. Updates in V2

----------------------------------------------------------------------------

 * Based on the feedback, it is clear that 'git add' will require much more
   careful testing and thought. I'm splitting it out of this series and it
   will return with a follow-up.
 * Test cases are improved, both in coverage and organization.
 * The previous "unpack-trees: make sparse aware" patch is split into three
   now.
 * Stale messages based on an old implementation of the "protections" topic
   are now fixed.
 * Performance tests were re-run.

Derrick Stolee (14):
  sparse-index: skip indexes with unmerged entries
  sparse-index: include EXTENDED flag when expanding
  t1092: replace incorrect 'echo' with 'cat'
  t1092: expand repository data shape
  t1092: add tests for status/add and sparse files
  unpack-trees: preserve cache_bottom
  unpack-trees: compare sparse directories correctly
  unpack-trees: unpack sparse directory entries
  dir.c: accept a directory as part of cone-mode patterns
  diff-lib: handle index diffs with sparse dirs
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  wt-status: expand added sparse directory entries
  fsmonitor: integrate with sparse index

 builtin/commit.c                         |   3 +
 diff-lib.c                               | 188 +++++++++++++++++++++++
 dir.c                                    |  11 ++
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++-
 t/t1092-sparse-checkout-compatibility.sh | 158 ++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  48 ++++++
 unpack-trees.c                           | 121 +++++++++++++--
 wt-status.c                              |  64 +++++++-
 wt-status.h                              |   1 +
 10 files changed, 607 insertions(+), 24 deletions(-)


base-commit: f723f370c89ad61f4f40aabfd3540b1ce19c00e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v4:

  1:  5a2ed3d1d701 =  1:  5a2ed3d1d701 sparse-index: skip indexes with unmerged entries
  2:  8aa41e749471 =  2:  8aa41e749471 sparse-index: include EXTENDED flag when expanding
  -:  ------------ >  3:  b99371c7dd61 t1092: replace incorrect 'echo' with 'cat'
  3:  70971b1f9261 !  4:  f4dddac1859e t1092: expand repository data shape
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'setup' '
      +		mkdir deep/deeper1/0/0 &&
      +		touch deep/deeper1/0/1 &&
      +		touch deep/deeper1/0/0/0 &&
     ++		cp -r deep/deeper1/0 folder1 &&
     ++		cp -r deep/deeper1/0 folder2 &&
     ++		echo >>folder1/0/0/0 &&
     ++		echo >>folder2/0/1 &&
       		git add . &&
       		git commit -m "initial commit" &&
       		git checkout -b base &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'setup' '
     + 		mv folder1/a folder2/b &&
     + 		mv folder1/larger-content folder2/edited-content &&
     + 		echo >>folder2/edited-content &&
     ++		echo >>folder2/0/1 &&
     ++		echo stuff >>deep/deeper1/a &&
     + 		git add . &&
     + 		git commit -m "rename folder1/... to folder2/..." &&
     + 
     + 		git checkout -b rename-out-to-in rename-base &&
     + 		mv folder1/a deep/deeper1/b &&
     ++		echo more stuff >>deep/deeper1/a &&
     ++		rm folder2/0/1 &&
     ++		mkdir folder2/0/1 &&
     ++		echo >>folder2/0/1/1 &&
     + 		mv folder1/larger-content deep/deeper1/edited-content &&
     + 		echo >>deep/deeper1/edited-content &&
     + 		git add . &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'setup' '
     + 
     + 		git checkout -b rename-in-to-out rename-base &&
     + 		mv deep/deeper1/a folder1/b &&
     ++		echo >>folder2/0/1 &&
     ++		rm -rf folder1/0/0 &&
     ++		echo >>folder1/0/0 &&
     + 		mv deep/deeper1/larger-content folder1/edited-content &&
     + 		echo >>folder1/edited-content &&
     + 		git add . &&
     +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff --staged' '
     + 	test_all_match git diff --staged
     + '
     + 
     +-test_expect_success 'diff with renames' '
     ++test_expect_success 'diff with renames and conflicts' '
     + 	init_repos &&
     + 
     + 	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
     + 	do
     + 		test_all_match git checkout rename-base &&
     + 		test_all_match git checkout $branch -- .&&
     ++		test_all_match git status --porcelain=v2 &&
     ++		test_all_match git diff --staged --no-renames &&
     ++		test_all_match git diff --staged --find-renames || return 1
     ++	done
     ++'
     ++
     ++test_expect_success 'diff with directory/file conflicts' '
     ++	init_repos &&
     ++
     ++	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
     ++	do
     ++		git -C full-checkout reset --hard &&
     ++		test_sparse_match git reset --hard &&
     ++		test_all_match git checkout $branch &&
     ++		test_all_match git checkout rename-base -- . &&
     ++		test_all_match git status --porcelain=v2 &&
     + 		test_all_match git diff --staged --no-renames &&
     + 		test_all_match git diff --staged --find-renames || return 1
     + 	done
  4:  a80b5a41153f =  5:  856346b72f79 t1092: add tests for status/add and sparse files
  5:  07a45b661c4a =  6:  f3f6223e955f unpack-trees: preserve cache_bottom
  6:  cc4a526e7947 =  7:  45ae96adf285 unpack-trees: compare sparse directories correctly
  7:  e28df7f9395d !  8:  724194eef9f6 unpack-trees: be careful around sparse directory entries
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    unpack-trees: be careful around sparse directory entries
     +    unpack-trees: unpack sparse directory entries
      
     -    The methods traverse_by_cache_tree() and unpack_nondirectories() have
     -    similar behavior in trying to demonstrate the difference between and
     -    index and a tree, with some differences about how they walk the index.
     +    During unpack_callback(), index entries are compared against tree
     +    entries. These are matched according to names and types. One goal is to
     +    decide if we should recurse into subtrees or simply operate on one index
     +    entry.
      
     -    Each of these is expecting every cache entry to correspond to a file
     -    path. We need to skip over the sparse directory entries in the case of a
     -    sparse-index. Those entries are discovered in the portion that looks for
     -    subtrees among the cache entries by scanning the paths for slashes.
     +    In the case of a sparse-directory entry, we do not want to recurse into
     +    that subtree and instead simply compare the trees. In some cases, we
     +    might want to perform a merge operation on the entry, such as during
     +    'git checkout <commit>' which wants to replace a sparse tree entry with
     +    the tree for that path at the target commit. We extend the logic within
     +    unpack_nondirectories() to create a sparse-directory entry in this case,
     +    and then that is sent to call_unpack_fn().
      
     -    Skipping these sparse directory entries will have a measurable effect
     -    when we relax 'git status' to work with sparse-indexes: without this
     -    change these methods would call call_unpack_fn() which in turn calls
     -    oneway_diff() and then shows these sparse directory entries as added or
     -    modified files.
     +    There are some subtleties in this process. For instance, we need to
     +    update find_cache_entry() to allow finding a sparse-directory entry that
     +    exactly matches a given path.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## unpack-trees.c ##
     -@@ unpack-trees.c: static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
     +@@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse_info *info,
     + 	const struct name_entry *n,
     + 	int stage,
     + 	struct index_state *istate,
     +-	int is_transient)
     ++	int is_transient,
     ++	int is_sparse_directory)
     + {
     + 	size_t len = traverse_path_len(info, tree_entry_len(n));
     ++	size_t alloc_len = is_sparse_directory ? len + 1 : len;
     + 	struct cache_entry *ce =
     + 		is_transient ?
     +-		make_empty_transient_cache_entry(len) :
     +-		make_empty_cache_entry(istate, len);
     ++		make_empty_transient_cache_entry(alloc_len) :
     ++		make_empty_cache_entry(istate, alloc_len);
       
     - 		src[0] = o->src_index->cache[pos + i];
     + 	ce->ce_mode = create_ce_mode(n->mode);
     + 	ce->ce_flags = create_ce_flags(stage);
     +@@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse_info *info,
     + 	/* len+1 because the cache_entry allocates space for NUL */
     + 	make_traverse_path(ce->name, len + 1, info, n->path, n->pathlen);
       
     -+		if (S_ISSPARSEDIR(src[0]->ce_mode))
     -+			continue;
     ++	if (is_sparse_directory) {
     ++		ce->name[len] = '/';
     ++		ce->name[len + 1] = 0;
     ++		ce->ce_namelen++;
     ++		ce->ce_flags |= CE_SKIP_WORKTREE;
     ++	}
      +
     - 		len = ce_namelen(src[0]);
     - 		new_ce_len = cache_entry_size(len);
     + 	return ce;
     + }
       
      @@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
     + 				 unsigned long dirmask,
     + 				 struct cache_entry **src,
     + 				 const struct name_entry *names,
     +-				 const struct traverse_info *info)
     ++				 const struct traverse_info *info,
     ++				 int sparse_directory)
     + {
     + 	int i;
     + 	struct unpack_trees_options *o = info->data;
     + 	unsigned long conflicts = info->df_conflicts | dirmask;
     + 
     +-	/* Do we have *only* directories? Nothing to do */
       	if (mask == dirmask && !src[0])
       		return 0;
       
     -+	if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode))
     ++	/* no-op if our cache entry doesn't match the expectations. */
     ++	if (sparse_directory) {
     ++		if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
     ++			BUG("expected sparse directory entry");
     ++	} else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
      +		return 0;
     ++	}
      +
       	/*
       	 * Ok, we've filled in up to any potential index entry in src[0],
       	 * now do the rest.
     +@@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
     + 		 * not stored in the index.  otherwise construct the
     + 		 * cache entry from the index aware logic.
     + 		 */
     +-		src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
     ++		src[i + o->merge] = create_ce_entry(info, names + i, stage,
     ++						    &o->result, o->merge,
     ++						    sparse_directory);
     + 	}
     + 
     + 	if (o->merge) {
     +@@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
     + static struct cache_entry *find_cache_entry(struct traverse_info *info,
     + 					    const struct name_entry *p)
     + {
     ++	struct cache_entry *ce;
     + 	int pos = find_cache_pos(info, p->path, p->pathlen);
     + 	struct unpack_trees_options *o = info->data;
     + 
     + 	if (0 <= pos)
     + 		return o->src_index->cache[pos];
     +-	else
     ++
     ++	/*
     ++	 * Check for a sparse-directory entry named "path/".
     ++	 * Due to the input p->path not having a trailing
     ++	 * slash, the negative 'pos' value overshoots the
     ++	 * expected position by one, hence "-2" here.
     ++	 */
     ++	pos = -pos - 2;
     ++
     ++	if (pos < 0 || pos >= o->src_index->cache_nr)
     ++		return NULL;
     ++
     ++	ce = o->src_index->cache[pos];
     ++
     ++	if (!S_ISSPARSEDIR(ce->ce_mode))
     + 		return NULL;
     ++
     ++	/*
     ++	 * Compare ce->name to info->name + '/' + p->path + '/'
     ++	 * if info->name is non-empty. Compare ce->name to
     ++	 * p-.path + '/' otherwise.
     ++	 */
     ++	if (info->namelen) {
     ++		if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
     ++		    ce->name[info->namelen] == '/' &&
     ++		    !strncmp(ce->name, info->name, info->namelen) &&
     ++		    !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))
     ++			return ce;
     ++	} else if (ce->ce_namelen == p->pathlen + 1 &&
     ++		   !strncmp(ce->name, p->path, p->pathlen))
     ++		return ce;
     ++	return NULL;
     + }
     + 
     + static void debug_path(struct traverse_info *info)
     +@@ unpack-trees.c: static void debug_unpack_callback(int n,
     + 		debug_name_entry(i, names + i);
     + }
     + 
     ++/*
     ++ * Returns true if and only if the given cache_entry is a
     ++ * sparse-directory entry that matches the given name_entry
     ++ * from the tree walk at the given traverse_info.
     ++ */
     ++static int is_sparse_directory_entry(struct cache_entry *ce, struct name_entry *name, struct traverse_info *info)
     ++{
     ++	size_t expected_len, name_start;
     ++
     ++	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
     ++		return 0;
     ++
     ++	if (info->namelen)
     ++		name_start = info->namelen + 1;
     ++	else
     ++		name_start = 0;
     ++	expected_len = name->pathlen + 1 + name_start;
     ++
     ++	if (ce->ce_namelen != expected_len ||
     ++	    strncmp(ce->name, info->name, info->namelen) ||
     ++	    strncmp(ce->name + name_start, name->path, name->pathlen))
     ++		return 0;
     ++
     ++	return 1;
     ++}
     ++
     + /*
     +  * Note that traverse_by_cache_tree() duplicates some logic in this function
     +  * without actually calling it. If you change the logic here you may need to
     +@@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
     + 		}
     + 	}
     + 
     +-	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
     ++	if (unpack_nondirectories(n, mask, dirmask, src, names, info, 0) < 0)
     + 		return -1;
     + 
     + 	if (o->merge && src[0]) {
     +@@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
     + 			}
     + 		}
     + 
     +-		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     +-					     names, info) < 0)
     ++		if (is_sparse_directory_entry(src[0], names, info)) {
     ++			if (unpack_nondirectories(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
     ++				return -1;
     ++		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     ++						    names, info) < 0) {
     + 			return -1;
     ++		}
     ++
     + 		return mask;
     + 	}
     + 
  8:  2cc3a93d4434 =  9:  b8ff179f43e3 dir.c: accept a directory as part of cone-mode patterns
  -:  ------------ > 10:  b9b97e011293 diff-lib: handle index diffs with sparse dirs
  9:  5011feb1aa04 = 11:  611b9f61fb2c status: skip sparse-checkout percentage with sparse-index
 10:  9f2ce5301dc9 = 12:  0c0a765dde80 status: use sparse-index throughout
 11:  24417e095243 ! 13:  02f2c7b63982 wt-status: expand added sparse directory entries
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	init_repos &&
      +
      +	test_all_match git checkout rename-out-to-in &&
     -+	test_all_match git reset --mixed HEAD~1 &&
     ++
     ++	# Sparse checkouts do not agree with full checkouts about
     ++	# how to report a directory/file conflict during a reset.
     ++	# This command would fail with test_all_match because the
     ++	# full checkout reports "T folder1/0/1" while a sparse
     ++	# checkout reports "D folder1/0/1". This matches because
     ++	# the sparse checkouts skip "adding" the other side of
     ++	# the conflict.
     ++	test_sparse_match git reset --mixed HEAD~1 &&
      +	test_sparse_match test-tool read-cache --table --expand &&
     -+	test_all_match git status --porcelain=v2 &&
     -+	test_all_match git status --porcelain=v2 &&
     ++	test_sparse_match git status --porcelain=v2 &&
     ++	test_sparse_match git status --porcelain=v2 &&
      +
      +	# At this point, sparse-checkouts behave differently
      +	# from the full-checkout.
 12:  584d4b559a91 = 14:  46ca150c3548 fsmonitor: integrate with sparse index

-- 
gitgitgadget
