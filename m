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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4ACC11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6902861CA3
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 01:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhF2ByO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 21:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhF2ByN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 21:54:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A656DC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l8so14891206wry.13
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZB3tpGVUpQGuRciLj0T3bXF8aUcQ0cKP4nhqkU61hu0=;
        b=WoETGd48BR/Tc+BPZSEITHaStr0ZBstvtn3kitNNb0fjDg+qup39gQflE+HuB3IlzO
         x1vY4eylPBLk3UoGbbxSvFvi2+SiZzJSmaT/2V1uahd5OjG9Cai7QwRkXVNdGsS0RB1I
         4BCSsKolbiGjlDE5NEGF6GnyGjKrpTDU4pyqqpSYcKS7OByuEwdgey1M1n4ebVSMLBtL
         eogapSx3ECdSsA+45Bo/Uqkr3lViKIORCb9r8F6v3MPK9bQUFUEQJW5XDe1mAwkYcmLT
         DDgNEKbA5+Ey4Hp3q2rgF4Ag70640TJ57bjwIqcRRpyvvch0WLodwEC063vIKtvlRS4p
         k48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZB3tpGVUpQGuRciLj0T3bXF8aUcQ0cKP4nhqkU61hu0=;
        b=gnbaGqTtFsj4FW8OvPbJpAwTlp86XG+Hmv95KtK05baHFyczlAyMINE5J/yJQuUp+M
         I4vH/UgDBw5UaoewHwV3L611KZWU2sCb99L87hjpTXgWdKbx/0YHh1lVyCE41jk8kDng
         ynhwe4rgUgPg/kYpcgQc88H5KAxYDhxhUxmhQeY+kHo71sSC3OBDk7k/Fd/hxK9Lqokx
         IWsPMBgYOd4OKrnnFD0TcklgxV/712q87NcQOK/eSzPzh3VR6yEdqP0dmpau0Gm/2Ioi
         yRkj/jfb9U+adks2niUkT9+frtpvti9cM1fyP8OsFntDurfyWTFj8/pi58Qjq2u7/CCB
         bscw==
X-Gm-Message-State: AOAM533ggee9WCxudsDTGK0/pQbLEkg3ZEynZaNjhJn3gqX12vfpDWux
        y+NB5B11p+ApczwcgETgtjYaYJF8uqE=
X-Google-Smtp-Source: ABdhPJwr77/3jZEnr5SrraTOGwuq0UeKoCcp1kcQVheuPX9lZWa2b8BjO7G7ss94fihelUyJKkQmuQ==
X-Received: by 2002:adf:ba07:: with SMTP id o7mr29967229wrg.160.1624931503953;
        Mon, 28 Jun 2021 18:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm17056746wrq.50.2021.06.28.18.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:51:43 -0700 (PDT)
Message-Id: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 01:51:28 +0000
Subject: [PATCH v6 00/14] Sparse-index: integrate with status
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


Update in V6
============

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
 diff-lib.c                               |  16 +++
 dir.c                                    |  11 ++
 read-cache.c                             |  10 +-
 sparse-index.c                           |  27 +++-
 t/t1092-sparse-checkout-compatibility.sh | 155 ++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh              |  48 +++++++
 unpack-trees.c                           | 130 ++++++++++++++++---
 wt-status.c                              |  63 ++++++++-
 wt-status.h                              |   1 +
 10 files changed, 436 insertions(+), 28 deletions(-)


base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-932%2Fderrickstolee%2Fsparse-index%2Fstatus-and-add-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-932/derrickstolee/sparse-index/status-and-add-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/932

Range-diff vs v5:

  1:  5a2ed3d1d70 =  1:  2a4a7256304 sparse-index: skip indexes with unmerged entries
  2:  8aa41e74947 !  2:  f5bae86014d sparse-index: include EXTENDED flag when expanding
     @@ Commit message
      
          When creating a full index from a sparse one, we create cache entries
          for every blob within a given sparse directory entry. These are
     -    correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
     -    marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
     -    correctly written to disk in the case that the index is not converted
     -    back down to a sparse-index.
     +    correctly marked with the CE_SKIP_WORKTREE flag, but the CE_EXTENDED
     +    flag is not included. The CE_EXTENDED flag would exist if we loaded a
     +    full index from disk with these entries marked with CE_SKIP_WORKTREE, so
     +    we can add the flag here to be consistent. This allows us to directly
     +    compare the flags present in cache entries when testing the sparse-index
     +    feature, but has no significance to its correctness in the user-facing
     +    functionality.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
  3:  b99371c7dd6 !  3:  d965669c766 t1092: replace incorrect 'echo' with 'cat'
     @@ Commit message
          t1092: replace incorrect 'echo' with 'cat'
      
          This fixes the test data shape to be as expected, allowing rename
     -    detection to work properly now that the 'larger-conent' file actually
     +    detection to work properly now that the 'larger-content' file actually
          has meaningful lines.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
  4:  f4dddac1859 =  4:  44a940211b2 t1092: expand repository data shape
  5:  856346b72f7 =  5:  701ac0e8ff6 t1092: add tests for status/add and sparse files
  6:  f3f6223e955 =  6:  587333f7c61 unpack-trees: preserve cache_bottom
  7:  45ae96adf28 =  7:  6fc898ac23e unpack-trees: compare sparse directories correctly
  8:  724194eef9f !  8:  b676ef4925b unpack-trees: unpack sparse directory entries
     @@ Commit message
          'git checkout <commit>' which wants to replace a sparse tree entry with
          the tree for that path at the target commit. We extend the logic within
          unpack_nondirectories() to create a sparse-directory entry in this case,
     -    and then that is sent to call_unpack_fn().
     +    and then that is sent to call_unpack_fn(). Since the name becomes
     +    confusing by handling directories, rename it to unpack_single_entry()
     +    since it handles a blob entry or a sparse directory entry without using
     +    traverse_trees_recursive().
      
          There are some subtleties in this process. For instance, we need to
          update find_cache_entry() to allow finding a sparse-directory entry that
     -    exactly matches a given path.
     +    exactly matches a given path. Use the new helper method
     +    sparse_dir_matches_path() for this.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
      +	size_t alloc_len = is_sparse_directory ? len + 1 : len;
       	struct cache_entry *ce =
       		is_transient ?
     --		make_empty_transient_cache_entry(len) :
     +-		make_empty_transient_cache_entry(len, NULL) :
      -		make_empty_cache_entry(istate, len);
     -+		make_empty_transient_cache_entry(alloc_len) :
     ++		make_empty_transient_cache_entry(alloc_len, NULL) :
      +		make_empty_cache_entry(istate, alloc_len);
       
       	ce->ce_mode = create_ce_mode(n->mode);
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
       
      +	if (is_sparse_directory) {
      +		ce->name[len] = '/';
     -+		ce->name[len + 1] = 0;
     ++		ce->name[len + 1] = '\0';
      +		ce->ce_namelen++;
      +		ce->ce_flags |= CE_SKIP_WORKTREE;
      +	}
     @@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse
       	return ce;
       }
       
     -@@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
     - 				 unsigned long dirmask,
     - 				 struct cache_entry **src,
     - 				 const struct name_entry *names,
     +@@ unpack-trees.c: static struct cache_entry *create_ce_entry(const struct traverse_info *info,
     +  * without actually calling it. If you change the logic here you may need to
     +  * check and change there as well.
     +  */
     +-static int unpack_nondirectories(int n, unsigned long mask,
     +-				 unsigned long dirmask,
     +-				 struct cache_entry **src,
     +-				 const struct name_entry *names,
      -				 const struct traverse_info *info)
     -+				 const struct traverse_info *info,
     -+				 int sparse_directory)
     ++static int unpack_single_entry(int n, unsigned long mask,
     ++			       unsigned long dirmask,
     ++			       struct cache_entry **src,
     ++			       const struct name_entry *names,
     ++			       const struct traverse_info *info,
     ++			       int sparse_directory)
       {
       	int i;
       	struct unpack_trees_options *o = info->data;
     @@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
       	if (mask == dirmask && !src[0])
       		return 0;
       
     -+	/* no-op if our cache entry doesn't match the expectations. */
     ++	/* defer work if our cache entry doesn't match the expectations. */
      +	if (sparse_directory) {
      +		if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
      +			BUG("expected sparse directory entry");
     @@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
       
       	if (o->merge) {
      @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
     + 	return -1;
     + }
     + 
     ++/*
     ++ * Given a sparse directory entry 'ce', compare ce->name to
     ++ * info->name + '/' + p->path + '/' if info->name is non-empty.
     ++ * Compare ce->name to p->path + '/' otherwise. Note that
     ++ * ce->name must end in a trailing '/' because it is a sparse
     ++ * directory entry.
     ++ */
     ++static int sparse_dir_matches_path(const struct cache_entry *ce,
     ++				   struct traverse_info *info,
     ++				   const struct name_entry *p)
     ++{
     ++	assert(S_ISSPARSEDIR(ce->ce_mode));
     ++	assert(ce->name[ce->ce_namelen - 1] == '/');
     ++
     ++	if (info->namelen)
     ++		return ce->ce_namelen == info->namelen + p->pathlen + 2 &&
     ++		       ce->name[info->namelen] == '/' &&
     ++		       !strncmp(ce->name, info->name, info->namelen) &&
     ++		       !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen);
     ++	return ce->ce_namelen == p->pathlen + 1 &&
     ++	       !strncmp(ce->name, p->path, p->pathlen);
     ++}
     ++
       static struct cache_entry *find_cache_entry(struct traverse_info *info,
       					    const struct name_entry *p)
       {
     @@ unpack-trees.c: static int find_cache_pos(struct traverse_info *info,
      +	pos = -pos - 2;
      +
      +	if (pos < 0 || pos >= o->src_index->cache_nr)
     -+		return NULL;
     + 		return NULL;
      +
      +	ce = o->src_index->cache[pos];
      +
      +	if (!S_ISSPARSEDIR(ce->ce_mode))
     - 		return NULL;
     ++		return NULL;
      +
     -+	/*
     -+	 * Compare ce->name to info->name + '/' + p->path + '/'
     -+	 * if info->name is non-empty. Compare ce->name to
     -+	 * p-.path + '/' otherwise.
     -+	 */
     -+	if (info->namelen) {
     -+		if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
     -+		    ce->name[info->namelen] == '/' &&
     -+		    !strncmp(ce->name, info->name, info->namelen) &&
     -+		    !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))
     -+			return ce;
     -+	} else if (ce->ce_namelen == p->pathlen + 1 &&
     -+		   !strncmp(ce->name, p->path, p->pathlen))
     ++	if (sparse_dir_matches_path(ce, info, p))
      +		return ce;
     ++
      +	return NULL;
       }
       
     @@ unpack-trees.c: static void debug_unpack_callback(int n,
      + * sparse-directory entry that matches the given name_entry
      + * from the tree walk at the given traverse_info.
      + */
     -+static int is_sparse_directory_entry(struct cache_entry *ce, struct name_entry *name, struct traverse_info *info)
     ++static int is_sparse_directory_entry(struct cache_entry *ce,
     ++				     struct name_entry *name,
     ++				     struct traverse_info *info)
      +{
     -+	size_t expected_len, name_start;
     -+
      +	if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
      +		return 0;
      +
     -+	if (info->namelen)
     -+		name_start = info->namelen + 1;
     -+	else
     -+		name_start = 0;
     -+	expected_len = name->pathlen + 1 + name_start;
     -+
     -+	if (ce->ce_namelen != expected_len ||
     -+	    strncmp(ce->name, info->name, info->namelen) ||
     -+	    strncmp(ce->name + name_start, name->path, name->pathlen))
     -+		return 0;
     -+
     -+	return 1;
     ++	return sparse_dir_matches_path(ce, info, name);
      +}
      +
       /*
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
       	}
       
      -	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
     -+	if (unpack_nondirectories(n, mask, dirmask, src, names, info, 0) < 0)
     ++	if (unpack_single_entry(n, mask, dirmask, src, names, info, 0) < 0)
       		return -1;
       
       	if (o->merge && src[0]) {
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned l
      -		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
      -					     names, info) < 0)
      +		if (is_sparse_directory_entry(src[0], names, info)) {
     -+			if (unpack_nondirectories(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
     ++			if (unpack_single_entry(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
      +				return -1;
      +		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
      +						    names, info) < 0) {
  9:  b8ff179f43e =  9:  d693f00d9a2 dir.c: accept a directory as part of cone-mode patterns
 10:  b9b97e01129 ! 10:  ed11cfc791f diff-lib: handle index diffs with sparse dirs
     @@ Commit message
          identical to before: the lack of a cache entry is the same with a sparse
          index.
      
     -    In the case where a tree is modified, we need to expand the tree
     -    recursively, and start comparing each contained entry as either an
     -    addition, deletion, or modification. This causes an interesting
     -    recursion that did not exist before.
     +    Use diff_tree_oid() appropriately to appropriately compute the diff.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## diff-lib.c ##
     -@@ diff-lib.c: static int get_stat_data(const struct cache_entry *ce,
     - 	return 0;
     - }
     - 
     -+struct show_new_tree_context {
     -+	struct rev_info *revs;
     -+	unsigned added:1;
     -+};
     -+
     -+static int show_new_file_from_tree(const struct object_id *oid,
     -+				   struct strbuf *base, const char *path,
     -+				   unsigned int mode, void *context)
     -+{
     -+	struct show_new_tree_context *ctx = context;
     -+	struct cache_entry *new_file = make_transient_cache_entry(mode, oid, path, /* stage */ 0);
     -+
     -+	diff_index_show_file(ctx->revs, ctx->added ? "+" : "-", new_file, oid, !is_null_oid(oid), mode, 0);
     -+	discard_cache_entry(new_file);
     -+	return 0;
     -+}
     -+
     -+static void show_directory(struct rev_info *revs,
     -+			   const struct cache_entry *new_dir,
     -+			   int added)
     -+{
     -+	/*
     -+	 * new_dir is a sparse directory entry, so we want to collect all
     -+	 * of the new files within the tree. This requires recursively
     -+	 * expanding the trees.
     -+	 */
     -+	struct show_new_tree_context ctx = { revs, added };
     -+	struct repository *r = revs->repo;
     -+	struct strbuf base = STRBUF_INIT;
     -+	struct pathspec ps;
     -+	struct tree *tree = lookup_tree(r, &new_dir->oid);
     -+
     -+	memset(&ps, 0, sizeof(ps));
     -+	ps.recursive = 1;
     -+	ps.has_wildcard = 1;
     -+	ps.max_depth = -1;
     -+
     -+	strbuf_add(&base, new_dir->name, new_dir->ce_namelen);
     -+	read_tree_at(r, tree, &base, &ps,
     -+			show_new_file_from_tree, &ctx);
     -+}
     -+
     - static void show_new_file(struct rev_info *revs,
     - 			  const struct cache_entry *new_file,
     - 			  int cached, int match_missing)
      @@ diff-lib.c: static void show_new_file(struct rev_info *revs,
     - 	unsigned int mode;
       	unsigned dirty_submodule = 0;
     + 	struct index_state *istate = revs->diffopt.repo->index;
       
      +	if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
     -+		show_directory(revs, new_file, /*added */ 1);
     ++		diff_tree_oid(NULL, &new_file->oid, new_file->name, &revs->diffopt);
      +		return;
      +	}
      +
       	/*
       	 * New file in the index: it might actually be different in
       	 * the working tree.
     -@@ diff-lib.c: static void show_new_file(struct rev_info *revs,
     - 	diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
     - }
     - 
     -+static int show_modified(struct rev_info *revs,
     -+			 const struct cache_entry *old_entry,
     -+			 const struct cache_entry *new_entry,
     -+			 int report_missing,
     -+			 int cached, int match_missing);
     -+
     -+static int compare_within_sparse_dir(int n, unsigned long mask,
     -+				     unsigned long dirmask, struct name_entry *entry,
     -+				     struct traverse_info *info)
     -+{
     -+	struct rev_info *revs = info->data;
     -+	struct object_id *oid0 = &entry[0].oid;
     -+	struct object_id *oid1 = &entry[1].oid;
     -+
     -+	if (oideq(oid0, oid1))
     -+		return mask;
     -+
     -+	/* Directory/file conflicts are handled earlier. */
     -+	if (S_ISDIR(entry[0].mode) && S_ISDIR(entry[1].mode)) {
     -+		struct tree_desc t[2];
     -+		void *buf[2];
     -+		struct traverse_info info_r = { NULL, };
     -+
     -+		info_r.name = xstrfmt("%s%s", info->traverse_path, entry[0].path);
     -+		info_r.namelen = strlen(info_r.name);
     -+		info_r.traverse_path = xstrfmt("%s/", info_r.name);
     -+		info_r.fn = compare_within_sparse_dir;
     -+		info_r.prev = info;
     -+		info_r.mode = entry[0].mode;
     -+		info_r.pathlen = entry[0].pathlen;
     -+		info_r.df_conflicts = 0;
     -+		info_r.data = revs;
     -+
     -+		buf[0] = fill_tree_descriptor(revs->repo, &t[0], oid0);
     -+		buf[1] = fill_tree_descriptor(revs->repo, &t[1], oid1);
     -+
     -+		traverse_trees(NULL, 2, t, &info_r);
     -+
     -+		free((char *)info_r.name);
     -+		free((char *)info_r.traverse_path);
     -+		free(buf[0]);
     -+		free(buf[1]);
     -+	} else {
     -+		char *old_path = NULL, *new_path = NULL;
     -+		struct cache_entry *old_entry = NULL, *new_entry = NULL;
     -+
     -+		if (entry[0].path) {
     -+			old_path = xstrfmt("%s%s", info->traverse_path, entry[0].path);
     -+			old_entry = make_transient_cache_entry(
     -+					entry[0].mode, &entry[0].oid,
     -+					old_path, /* stage */ 0);
     -+			old_entry->ce_flags |= CE_SKIP_WORKTREE;
     -+		}
     -+		if (entry[1].path) {
     -+			new_path = xstrfmt("%s%s", info->traverse_path, entry[1].path);
     -+			new_entry = make_transient_cache_entry(
     -+					entry[1].mode, &entry[1].oid,
     -+					new_path, /* stage */ 0);
     -+			new_entry->ce_flags |= CE_SKIP_WORKTREE;
     -+		}
     -+
     -+		if (entry[0].path && entry[1].path)
     -+			show_modified(revs, old_entry, new_entry, 0, 1, 0);
     -+		else if (entry[0].path)
     -+			diff_index_show_file(revs, revs->prefix,
     -+					     old_entry, &entry[0].oid,
     -+					     0, entry[0].mode, 0);
     -+		else if (entry[1].path)
     -+			show_new_file(revs, new_entry, 1, 0);
     -+
     -+		discard_cache_entry(old_entry);
     -+		discard_cache_entry(new_entry);
     -+		free(old_path);
     -+		free(new_path);
     -+	}
     -+
     -+	return mask;
     -+}
     -+
     -+static void show_modified_sparse_directory(struct rev_info *revs,
     -+			 const struct cache_entry *old_entry,
     -+			 const struct cache_entry *new_entry,
     -+			 int report_missing,
     -+			 int cached, int match_missing)
     -+{
     -+	struct tree_desc t[2];
     -+	void *buf[2];
     -+	struct traverse_info info = { NULL };
     -+	struct strbuf name = STRBUF_INIT;
     -+	struct strbuf parent_path = STRBUF_INIT;
     -+	char *last_dir_sep;
     -+
     -+	if (oideq(&old_entry->oid, &new_entry->oid))
     -+		return;
     -+
     -+	info.fn = compare_within_sparse_dir;
     -+	info.prev = &info;
     -+
     -+	strbuf_add(&name, new_entry->name, new_entry->ce_namelen - 1);
     -+	info.name = name.buf;
     -+	info.namelen = name.len;
     -+
     -+	strbuf_add(&parent_path, new_entry->name, new_entry->ce_namelen - 1);
     -+	if ((last_dir_sep = find_last_dir_sep(parent_path.buf)) > parent_path.buf)
     -+		strbuf_setlen(&parent_path, (last_dir_sep - parent_path.buf) - 1);
     -+	else
     -+		strbuf_setlen(&parent_path, 0);
     -+
     -+	info.pathlen = parent_path.len;
     -+
     -+	if (parent_path.len)
     -+		info.traverse_path = parent_path.buf;
     -+	else
     -+		info.traverse_path = "";
     -+
     -+	info.mode = new_entry->ce_mode;
     -+	info.df_conflicts = 0;
     -+	info.data = revs;
     -+
     -+	buf[0] = fill_tree_descriptor(revs->repo, &t[0], &old_entry->oid);
     -+	buf[1] = fill_tree_descriptor(revs->repo, &t[1], &new_entry->oid);
     -+
     -+	traverse_trees(NULL, 2, t, &info);
     -+
     -+	free(buf[0]);
     -+	free(buf[1]);
     -+	strbuf_release(&name);
     -+	strbuf_release(&parent_path);
     -+}
     -+
     - static int show_modified(struct rev_info *revs,
     - 			 const struct cache_entry *old_entry,
     - 			 const struct cache_entry *new_entry,
      @@ diff-lib.c: static int show_modified(struct rev_info *revs,
     - 	const struct object_id *oid;
       	unsigned dirty_submodule = 0;
     + 	struct index_state *istate = revs->diffopt.repo->index;
       
      +	/*
      +	 * If both are sparse directory entries, then expand the
     @@ diff-lib.c: static int show_modified(struct rev_info *revs,
      +	if (old_entry && new_entry &&
      +	    S_ISSPARSEDIR(old_entry->ce_mode) &&
      +	    S_ISSPARSEDIR(new_entry->ce_mode)) {
     -+		show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
     ++		diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
      +		return 0;
      +	}
      +
     - 	if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
     + 	if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
       			  &dirty_submodule, &revs->diffopt) < 0) {
       		if (report_missing)
 11:  611b9f61fb2 = 11:  48fd25aacbe status: skip sparse-checkout percentage with sparse-index
 12:  0c0a765dde8 = 12:  3499105eb67 status: use sparse-index throughout
 13:  02f2c7b6398 ! 13:  08225483d69 wt-status: expand added sparse directory entries
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	test_sparse_match git reset --mixed HEAD~1 &&
      +	test_sparse_match test-tool read-cache --table --expand &&
      +	test_sparse_match git status --porcelain=v2 &&
     -+	test_sparse_match git status --porcelain=v2 &&
      +
      +	# At this point, sparse-checkouts behave differently
      +	# from the full-checkout.
      +	test_sparse_match git checkout --orphan new-branch &&
      +	test_sparse_match test-tool read-cache --table --expand &&
     -+	test_sparse_match git status --porcelain=v2 &&
      +	test_sparse_match git status --porcelain=v2
      +'
      +
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +
      +	run_on_all touch deep/deeper1/x &&
      +	test_all_match git add . &&
     -+	test_all_match git status --porcelain=v2 &&
      +	test_all_match git status --porcelain=v2
      +'
      +
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      
       ## wt-status.c ##
      @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
     - 	run_diff_index(&rev, 1);
     + 	clear_pathspec(&rev.prune_data);
       }
       
      +static int add_file_to_list(const struct object_id *oid,
     @@ wt-status.c: static void wt_status_collect_changes_initial(struct wt_status *s)
      +			 * tree and marking them with DIFF_STATUS_ADDED.
      +			 */
      +			struct strbuf base = STRBUF_INIT;
     -+			struct pathspec ps;
     ++			struct pathspec ps = { 0 };
      +			struct tree *tree = lookup_tree(istate->repo, &ce->oid);
      +
     -+			memset(&ps, 0, sizeof(ps));
      +			ps.recursive = 1;
      +			ps.has_wildcard = 1;
      +			ps.max_depth = -1;
 14:  46ca150c354 = 14:  711e403a63a fsmonitor: integrate with sparse index

-- 
gitgitgadget
