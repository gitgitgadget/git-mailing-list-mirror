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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A8CC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EA461CE5
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhF2CHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhF2CHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:07:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046B7C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v20-20020a05600c2154b02901dcefb16af0so1268882wml.5
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wM/SjSRRMXpPlZnplhV6yM5n2wniRV7skRTQQ4oEyhQ=;
        b=A4R7L/qWkg6bWP0zEPRrtD0nZRKfYKHBqTdwkwsDcvK1fJX0cb3S95+ahv9Co2QkqT
         cAaeo7wtvtK/j9ZU1QwpKM8xsGz+lv4fsFrQOdaib8VgqyfgqIfsYVh7rTIJF4UyZIe4
         x8ZFxb7LOXByoreQBWTM/SHAzRGm5krdtJmKW/fwUABtBLIUPEVvpBrt3IADmmunmUfl
         nJvN5V4mhH51ZKdShyGFusRPaip0YFBJ7I8GhPDdWdP0OhRNa7o8//vEAWWXWLrTwqjG
         JdiuNCSNwKFhhKfWXJQdu9liRaNYfzPuxL/fFLS6iBSI2Yy02t4IT1bULXoerfieO5kQ
         q1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wM/SjSRRMXpPlZnplhV6yM5n2wniRV7skRTQQ4oEyhQ=;
        b=c8y1WiRBLffdyQKrzC1v4TvWYQQ79vPVnapZtq3I3+o1Phu9zom/MDCy9RMeW2zUSz
         HjR9noe5wadviqA+MhDs+t0FKeaVZ2+euYIidI8bXgxrcVB5hkFres7N6B4dbeu2KNij
         3OY0C0zbtCLiGVqByZTq1uMTRKhliZBBkeee9/qsqfHkwXi4m9BYBSl6ftnZbjf8ppqj
         1A5qnnnJrO6L9VVVSMPbOzWRBpbn2iGaj8ERZS/U0s+eTgqtQbUdO77eIyWzcyV9xhYV
         6ogjwrQejb+nm1lz8N2uJR/rUtQDXFJ/kzEJnxdCBSeUZwX4UbF0Teyjh2YCC5YvgUQ2
         GRdQ==
X-Gm-Message-State: AOAM530c8Rbi21EWjw473DusBpLoe7nMTHE2uCoUnhCghojuRUTSZ7lX
        UE4mqIet/0Qoo7/s8lqwKKVTkUWhE9g=
X-Google-Smtp-Source: ABdhPJzE1ChOQFtrZG8cCOYbcJ780O5IBw5Ss8mxD15oxAX1O1rdJCfsiiALVbHuZkvSXTrS94On8Q==
X-Received: by 2002:a1c:2604:: with SMTP id m4mr28567626wmm.131.1624932295077;
        Mon, 28 Jun 2021 19:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5sm16040380wmk.11.2021.06.28.19.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:04:54 -0700 (PDT)
Message-Id: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:04:37 +0000
Subject: [PATCH v7 00/16] Sparse-index: integrate with status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, git@jeffhostetler.com,
        johannes.schindelin@gmx.de,
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


Update in V7 (relative to v5)
=============================

APOLOGIES: As I was working on this cover letter, I was still organizing my
big list of patches, including reordering some into this series. I forgot to
actually include them in my v6 submission, so here is a re-submission.
Please ignore v6.

I'm sorry that this revision took so long. Initially I was blocked on
getting the directory/file conflict figured out (I did), but also my team
was very busy with some things. Eventually, we reached an internal deadline
to make an experimental release available [1] with initial sparse-index
performance boosts. Creating that included some additional review by Jeff
Hostetler and Johannes Schindelin which led to more changes in this version.

The good news is that this series has now created the basis for many Git
commands to integrate with the sparse-index without much additional work.
This effort was unfortunately overloaded on this series because the changes
needed for things like 'git checkout' or 'git add' all intersect with the
changes needed for 'git status'. Might as well get it right the first time.

Because the range-diff is a big difficult to read this time, I'll break the
changes down on a patch-by-patch basis.

 1. sparse-index: skip indexes with unmerged entries
    
    (no change)

 2. sparse-index: include EXTENDED flag when expanding

 * Commit message better describes the purpose of the change.

 3. t1092: replace incorrect 'echo' with 'cat'

 * Typo fix

 4. t1092: expand repository data shape

 * some files are added that surround "folder1/" immediately before and
   after, based on the sorting with the trailing slash. This provides extra
   coverage.

 5. t1092: add tests for status/add and sparse files
    
    (no change)

 6. unpack-trees: preserve cache_bottom
    
    (no change)

 7. unpack-trees: compare sparse directories correctly

 * We were previosly not comparing the path lengths, which causes a problem
   (with later updates) when a sparse directory such as "folder1/0/" gets
   compared to a tree name "folder1".

 8. unpack-trees: rename unpack_nondirectories()

 * This new commit changes the name to make more sense with its new behavior
   that could modify a sparse directory entry. The point of the method is in
   contrast to recursing into trees.

 9. unpack-trees: unpack sparse directory entries

 * THIS is the biggest change from previous versions. There were a few
   things going on that were tricky to get right, especially with the
   directory/file conflict (handled in an update in the following, new
   patch).

 * The changes to create_ce_entry() regarding alloc_len missed a spot that
   was critical to getting the length right in the allocated entry.

 * Use '\0' over 0 to represent the terminating character.

 * We don't need a "sparse_directory" parameter to unpack_nondirectories()
   (which was renamed to unpack_single_entry() by the previous new patch)
   because we can use dirmask to discover if src[0] (or any other value)
   should be a sparse directory entry.

 * Similarly, we don't need to call the method twice from unpack_callback().

 * The 'conflicts' variable is set to match the dirmask in the beginning,
   but it should depend on whether or not we have a sparse directory entry
   instead, and if all trees that have the path have a directory.

 * The implementation of find_cache_entry() uses find_cache_pos() to find an
   insertion position for a path if it doesn't find an exact match. Before,
   we subtracted one to find the sparse directory entry, but there could be
   multiple paths between the sparse directory entry and the insertion
   point, so we need to walk backwards until we find it. This requires many
   paths having the same prefix, so hopefully is a rare case. Some of the
   test data changes were added to cover the need for this logic. This uses
   a helper method, sparse_dir_matches_path, which is also used by
   is_sparse_directory_entry.

 10. unpack-trees: handle dir/file conflict of sparse entries

 * This new logic inside twoway_merge handles the special case for dealing
   with a directory/file conflict during a 'git checkout'. The necessarily
   data and tests are also added here, though the logic will only take
   serious effect when we integrate with 'git checkout' later.

 11. dir.c: accept a directory as part of cone-mode patterns

 * The value slash_pos was previously a pointer within a strbuf, but in some
   cases we add to that strbuf and that could reallocate the pointer, making
   slash_pos be invalid. The replacement is to have slash_pos be an integer
   position within the string, so it is consistent even if the string is
   reallocated for an append.

 12. diff-lib: handle index diffs with sparse dirs

 * As recommended in the previous review, a simple diff_tree_oid() replaces
   the complicated use of read_tree_at() and traverse_trees() in the
   previous version.

 13. status: skip sparse-checkout percentage with sparse-index
     
     (no change)

 14. status: use sparse-index throughout
     
     (no change)

 15. wt-status: expand added sparse directory entries

 * Duplicate 'git status --porcelain=v2' lines are removed from tests.

 * The pathspec is initialized using "= { 0 }" instead of memset().

 16. fsmonitor: integrate with sparse index

 * An extra test_region is added to ensure that the filesystem monitor hook
   is still being called, and we are not simply disabling the feature
   entirely.

Derrick Stolee (16):
  sparse-index: skip indexes with unmerged entries
  sparse-index: include EXTENDED flag when expanding
  t1092: replace incorrect 'echo' with 'cat'
  t1092: expand repository data shape
  t1092: add tests for status/add and sparse files
  unpack-trees: preserve cache_bottom
  unpack-trees: compare sparse directories correctly
  unpack-trees: rename unpack_nondirectories()
  unpack-trees: unpack sparse directory entries
  unpack-trees: handle dir/file conflict of sparse entries
  dir.c: accept a directory as part of cone-mode patterns
  diff-lib: handle index diffs with sparse dirs
  status: skip sparse-checkout percentage with sparse-index
  status: use sparse-index throughout
  wt-status: expand added sparse directory entries
  fsmonitor: integrate with sparse index

 builtin/commit.c                         |   3 +
 diff-lib.c                               |  16 ++
 dir.c                                    |  24 ++-
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++-
 t/t1092-sparse-checkout-compatibility.sh | 181 ++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  49 ++++++
 unpack-trees.c                           | 145 +++++++++++++++---
 wt-status.c                              |  65 +++++++-
 wt-status.h                              |   1 +
 10 files changed, 485 insertions(+), 36 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v6:

  1:  2a4a7256304 =  1:  2a4a7256304 sparse-index: skip indexes with unmerged entries
  2:  f5bae86014d =  2:  f5bae86014d sparse-index: include EXTENDED flag when expanding
  3:  d965669c766 =  3:  d965669c766 t1092: replace incorrect 'echo' with 'cat'
  4:  44a940211b2 !  4:  e10fa11cfdb t1092: expand repository data shape
     @@ Commit message
            one entry and are the first entry of a directory with multiple
            entries.
      
     +    * Add filenames adjacent to a sparse directory entry that sort before
     +      and after the trailing slash.
     +
          Later tests will take advantage of these shapes, but they also deepen
          the tests that already exist.
      
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'setup' '
      +		mkdir deep/deeper1/0/0 &&
      +		touch deep/deeper1/0/1 &&
      +		touch deep/deeper1/0/0/0 &&
     ++		>folder1- &&
     ++		>folder1.x &&
     ++		>folder10 &&
      +		cp -r deep/deeper1/0 folder1 &&
      +		cp -r deep/deeper1/0 folder2 &&
      +		echo >>folder1/0/0/0 &&
  5:  701ac0e8ff6 =  5:  e94ffa07d46 t1092: add tests for status/add and sparse files
  6:  587333f7c61 =  6:  a8dda933567 unpack-trees: preserve cache_bottom
  7:  6fc898ac23e !  7:  e52166f6e4c unpack-trees: compare sparse directories correctly
     @@ Commit message
          Within compare_entry(), it first calls do_compare_entry() to check the
          leading portion of the name. When the input path is a directory name, we
          could match exactly already. Thus, we should return 0 if we have an
     -    exact string match on a sparse directory entry.
     +    exact string match on a sparse directory entry. The final check is a
     +    length comparison between the strings.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ unpack-trees.c: static int compare_entry(const struct cache_entry *ce, const str
      +	 * works when the input name is a directory, since ce->name
      +	 * ends in a directory separator.
      +	 */
     -+	if (S_ISSPARSEDIR(ce->ce_mode))
     ++	if (S_ISSPARSEDIR(ce->ce_mode) &&
     ++	    ce->ce_namelen == traverse_path_len(info, tree_entry_len(n)) + 1)
      +		return 0;
      +
       	/*
  -:  ----------- >  8:  d04b62381b8 unpack-trees: rename unpack_nondirectories()
  8:  b676ef4925b !  9:  237ccf4e43d unpack-trees: unpack sparse directory entries
     @@ Commit message
          might want to perform a merge operation on the entry, such as during
          'git checkout <commit>' which wants to replace a sparse tree entry with
          the tree for that path at the target commit. We extend the logic within
     -    unpack_nondirectories() to create a sparse-directory entry in this case,
     -    and then that is sent to call_unpack_fn(). Since the name becomes
     -    confusing by handling directories, rename it to unpack_single_entry()
     -    since it handles a blob entry or a sparse directory entry without using
     -    traverse_trees_recursive().
     +    unpack_single_entry() to create a sparse-directory entry in this case,
     +    and then that is sent to call_unpack_fn().
      
          There are some subtleties in this process. For instance, we need to
          update find_cache_entry() to allow finding a sparse-directory entry that
          exactly matches a given path. Use the new helper method
     -    sparse_dir_matches_path() for this.
     +    sparse_dir_matches_path() for this. We also need to ignore conflict
     +    markers in the case that the entries correspond to directories and we
     +    already have a sparse directory entry.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
       	return ce;
       }
       
     -@@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse_info *info,
     -  * without actually calling it. If you change the logic here you may need to
     -  * check and change there as well.
     -  */
     --static int unpack_nondirectories(int n, unsigned long mask,
     --				 unsigned long dirmask,
     --				 struct cache_entry **src,
     --				 const struct name_entry *names,
     --				 const struct traverse_info *info)
     -+static int unpack_single_entry(int n, unsigned long mask,
     -+			       unsigned long dirmask,
     -+			       struct cache_entry **src,
     -+			       const struct name_entry *names,
     -+			       const struct traverse_info *info,
     -+			       int sparse_directory)
     - {
     - 	int i;
     +@@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
       	struct unpack_trees_options *o = info->data;
       	unsigned long conflicts = info->df_conflicts | dirmask;
       
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
       	if (mask == dirmask && !src[0])
       		return 0;
       
     -+	/* defer work if our cache entry doesn't match the expectations. */
     -+	if (sparse_directory) {
     -+		if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
     -+			BUG("expected sparse directory entry");
     -+	} else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
     -+		return 0;
     -+	}
     ++	/*
     ++	 * When we have a sparse directory entry for src[0],
     ++	 * then this isn't necessarily a directory-file conflict.
     ++	 */
     ++	if (mask == dirmask && src[0] &&
     ++	    S_ISSPARSEDIR(src[0]->ce_mode))
     ++		conflicts = 0;
      +
       	/*
       	 * Ok, we've filled in up to any potential index entry in src[0],
       	 * now do the rest.
     -@@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
     +@@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
       		 * not stored in the index.  otherwise construct the
       		 * cache entry from the index aware logic.
       		 */
      -		src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
      +		src[i + o->merge] = create_ce_entry(info, names + i, stage,
      +						    &o->result, o->merge,
     -+						    sparse_directory);
     ++						    bit & dirmask);
       	}
       
       	if (o->merge) {
     @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
      +	 * Check for a sparse-directory entry named "path/".
      +	 * Due to the input p->path not having a trailing
      +	 * slash, the negative 'pos' value overshoots the
     -+	 * expected position by one, hence "-2" here.
     ++	 * expected position by at least one, hence "-2" here.
      +	 */
      +	pos = -pos - 2;
      +
      +	if (pos < 0 || pos >= o->src_index->cache_nr)
       		return NULL;
      +
     -+	ce = o->src_index->cache[pos];
     ++	/*
     ++	 * We might have multiple entries between 'pos' and
     ++	 * the actual sparse-directory entry, so start walking
     ++	 * back until finding it or passing where it would be.
     ++	 */
     ++	while (pos >= 0) {
     ++		ce = o->src_index->cache[pos];
     ++
     ++		if (strncmp(ce->name, p->path, p->pathlen))
     ++			return NULL;
      +
     -+	if (!S_ISSPARSEDIR(ce->ce_mode))
     -+		return NULL;
     ++		if (S_ISSPARSEDIR(ce->ce_mode) &&
     ++		    sparse_dir_matches_path(ce, info, p))
     ++			return ce;
      +
     -+	if (sparse_dir_matches_path(ce, info, p))
     -+		return ce;
     ++		pos--;
     ++	}
      +
      +	return NULL;
       }
     @@ unpack-trees.c: static void debug_unpack_callback(int n,
       /*
        * Note that traverse_by_cache_tree() duplicates some logic in this function
        * without actually calling it. If you change the logic here you may need to
     -@@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
     - 		}
     - 	}
     - 
     --	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
     -+	if (unpack_single_entry(n, mask, dirmask, src, names, info, 0) < 0)
     - 		return -1;
     - 
     - 	if (o->merge && src[0]) {
      @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
       			}
       		}
       
      -		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
      -					     names, info) < 0)
     -+		if (is_sparse_directory_entry(src[0], names, info)) {
     -+			if (unpack_single_entry(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
     -+				return -1;
     -+		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     ++		if (!is_sparse_directory_entry(src[0], names, info) &&
     ++		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
      +						    names, info) < 0) {
       			return -1;
      +		}
  -:  ----------- > 10:  9f31c691af6 unpack-trees: handle dir/file conflict of sparse entries
  9:  d693f00d9a2 ! 11:  2a43287c47e dir.c: accept a directory as part of cone-mode patterns
     @@ Commit message
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## dir.c ##
     +@@ dir.c: enum pattern_match_result path_matches_pattern_list(
     + 	struct path_pattern *pattern;
     + 	struct strbuf parent_pathname = STRBUF_INIT;
     + 	int result = NOT_MATCHED;
     +-	const char *slash_pos;
     ++	size_t slash_pos;
     + 
     + 	if (!pl->use_cone_patterns) {
     + 		pattern = last_matching_pattern_from_list(pathname, pathlen, basename,
      @@ dir.c: enum pattern_match_result path_matches_pattern_list(
       	strbuf_addch(&parent_pathname, '/');
       	strbuf_add(&parent_pathname, pathname, pathlen);
     @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      +	 * use the file-base matching logic in an equivalent way.
      +	 */
      +	if (parent_pathname.len > 0 &&
     -+	    parent_pathname.buf[parent_pathname.len - 1] == '/')
     ++	    parent_pathname.buf[parent_pathname.len - 1] == '/') {
     ++		slash_pos = parent_pathname.len - 1;
      +		strbuf_add(&parent_pathname, "-", 1);
     ++	} else {
     ++		const char *slash_ptr = strrchr(parent_pathname.buf, '/');
     ++		slash_pos = slash_ptr ? slash_ptr - parent_pathname.buf : 0;
     ++	}
      +
       	if (hashmap_contains_path(&pl->recursive_hashmap,
       				  &parent_pathname)) {
       		result = MATCHED_RECURSIVE;
     + 		goto done;
     + 	}
     + 
     +-	slash_pos = strrchr(parent_pathname.buf, '/');
     +-
     +-	if (slash_pos == parent_pathname.buf) {
     ++	if (!slash_pos) {
     + 		/* include every file in root */
     + 		result = MATCHED;
     + 		goto done;
     + 	}
     + 
     +-	strbuf_setlen(&parent_pathname, slash_pos - parent_pathname.buf);
     ++	strbuf_setlen(&parent_pathname, slash_pos);
     + 
     + 	if (hashmap_contains_path(&pl->parent_hashmap, &parent_pathname)) {
     + 		result = MATCHED;
 10:  ed11cfc791f ! 12:  f83aa08ff6b diff-lib: handle index diffs with sparse dirs
     @@ Commit message
          identical to before: the lack of a cache entry is the same with a sparse
          index.
      
     -    Use diff_tree_oid() appropriately to appropriately compute the diff.
     +    Use diff_tree_oid() appropriately to compute the diff.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
 11:  48fd25aacbe = 13:  35063ffb8ed status: skip sparse-checkout percentage with sparse-index
 12:  3499105eb67 = 14:  b4033a9bf36 status: use sparse-index throughout
 13:  08225483d69 ! 15:  717a3f49f97 wt-status: expand added sparse directory entries
     @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
      +	struct string_list_item *it;
      +	struct wt_status_change_data *d;
      +	struct wt_status *s = context;
     -+	char *full_name;
     ++	struct strbuf full_name = STRBUF_INIT;
      +
      +	if (S_ISDIR(mode))
      +		return READ_TREE_RECURSIVE;
      +
     -+	full_name = xstrfmt("%s%s", base->buf, path);
     -+	it = string_list_insert(&s->change, full_name);
     ++	strbuf_add(&full_name, base->buf, base->len);
     ++	strbuf_addstr(&full_name, path);
     ++	it = string_list_insert(&s->change, full_name.buf);
      +	d = it->util;
      +	if (!d) {
      +		CALLOC_ARRAY(d, 1);
     @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
      +	d->mode_index = mode;
      +	oidcpy(&d->oid_index, oid);
      +	s->committable = 1;
     ++	strbuf_release(&full_name);
      +	return 0;
      +}
      +
 14:  711e403a63a ! 16:  1d744848ee6 fsmonitor: integrate with sparse index
     @@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds after staging/
      +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
      +		git status --porcelain=v2 >actual &&
      +	test_region $1 index ensure_full_index trace2.txt &&
     ++	test_region fsm_hook query trace2.txt &&
      +	test_cmp expect actual &&
      +	rm trace2.txt &&
      +	git sparse-checkout disable

-- 
gitgitgadget
