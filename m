Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80348C11F64
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DDD61CFF
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhF2CSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhF2CSf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:18:35 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5D0C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:16:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g22so24851971iom.1
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5gvlZ3cL4kf6Hnipz+LpYgX2nOL9+siJqHPAohnz4tU=;
        b=CvKN97f9viD4BT9w7vkJVupDKXWOF2XWgVZ5JfkYyiKBYIqxLZ4VyOTSQ+6PuJMreY
         LH4R4YzEcISZsyBAi880Z116C1eFR55i67ygoTWqR9vNOvsE0HZ1uqLtf4k8fK1vlTrf
         0iL0FPXmGRfjRnlJ8mmRjzGXyoP+EOII+MxRZAXrL+KqORgjYhfcr1eQmCDex26JDFnK
         F6RU+kcTTIrhwqTJ3bFzSI0Fls/5MBdBzDwLxVtSrroWHHCGeNw619OxiS+0EN6ErjDt
         zVXAx/wqnpQgoSfsTZkePPUOU2qkIOTMej7khr3A9nuQGMx1iyn/yfmqVodhWkLP97/w
         QtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5gvlZ3cL4kf6Hnipz+LpYgX2nOL9+siJqHPAohnz4tU=;
        b=Vf7EDkSDBo2f2UAMfNd58K1H7tmj68f5v1PYPu6U1I+xKj6jCBFuRsiG6nsVnLoorM
         wnX1kTjQC58GsxYeCYMSCz9TO5YgftbYShI7Qr23JcnHnBKqNgCQJEnCAMWLTp/YKHsj
         rmIx2q5s1mLE6+djG1a5YB1jWUGJv5Shi8G5qPpWEy8XfK7/WIpK2kHFnZOR/mTnI9ZG
         7lm2mV/0GSEe7RuRUksDUEvd/Z4U6hOtSzqS+wUTI+Sxk+bwSjvldBmhoKXad0MEtVV7
         jYTG0OqZNSELnRHmCEuGEJQQuuB6z/t4Fv3cvHGTR45Uhr2e1wSUzYsMm0mGNdd+MVl8
         oL3Q==
X-Gm-Message-State: AOAM532sGLsjIqg903Dlp2AHFhv2WKUixCR7xDLYcBjLWahlsOHEM7RR
        NpEZSa+gwN5ZN1f0/4GFtzI=
X-Google-Smtp-Source: ABdhPJwu+t1R0727wNwefX3eqzjjFCFUPgERH1zO8M00d/uqjBHCsDnoiU2XDyvbgPeZhxg++mLSag==
X-Received: by 2002:a6b:d009:: with SMTP id x9mr1955003ioa.199.1624932966835;
        Mon, 28 Jun 2021 19:16:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:707c:50a9:e7e5:baa? ([2600:1700:e72:80a0:707c:50a9:e7e5:baa])
        by smtp.gmail.com with ESMTPSA id u16sm2559256iob.41.2021.06.28.19.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 19:16:06 -0700 (PDT)
Subject: Re: [PATCH v7 00/16] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git@jeffhostetler.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b49f8b53-ccbf-b156-3054-03d1273cf9dd@gmail.com>
Date:   Mon, 28 Jun 2021 22:16:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.932.v7.git.1624932293.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2021 10:04 PM, Derrick Stolee via GitGitGadget wrote:
...
> Update in V7 (relative to v5)
> =============================
> 
> APOLOGIES: As I was working on this cover letter, I was still organizing my
> big list of patches, including reordering some into this series. I forgot to
> actually include them in my v6 submission, so here is a re-submission.
> Please ignore v6.

Since v6 was a mistake, here is the full range-diff of v5 versus v7:

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
 4:  f4dddac1859 !  4:  e10fa11cfdb t1092: expand repository data shape
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
 5:  856346b72f7 =  5:  e94ffa07d46 t1092: add tests for status/add and sparse files
 6:  f3f6223e955 =  6:  a8dda933567 unpack-trees: preserve cache_bottom
 7:  45ae96adf28 !  7:  e52166f6e4c unpack-trees: compare sparse directories correctly
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
 8:  724194eef9f !  9:  237ccf4e43d unpack-trees: unpack sparse directory entries
    @@ Commit message
         might want to perform a merge operation on the entry, such as during
         'git checkout <commit>' which wants to replace a sparse tree entry with
         the tree for that path at the target commit. We extend the logic within
    -    unpack_nondirectories() to create a sparse-directory entry in this case,
    +    unpack_single_entry() to create a sparse-directory entry in this case,
         and then that is sent to call_unpack_fn().
     
         There are some subtleties in this process. For instance, we need to
         update find_cache_entry() to allow finding a sparse-directory entry that
    -    exactly matches a given path.
    +    exactly matches a given path. Use the new helper method
    +    sparse_dir_matches_path() for this. We also need to ignore conflict
    +    markers in the case that the entries correspond to directories and we
    +    already have a sparse directory entry.
     
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
    --				 const struct traverse_info *info)
    -+				 const struct traverse_info *info,
    -+				 int sparse_directory)
    - {
    - 	int i;
    +@@ unpack-trees.c: static int unpack_single_entry(int n, unsigned long mask,
      	struct unpack_trees_options *o = info->data;
      	unsigned long conflicts = info->df_conflicts | dirmask;
      
    @@ unpack-trees.c: static int unpack_nondirectories(int n, unsigned long mask,
      	if (mask == dirmask && !src[0])
      		return 0;
      
    -+	/* no-op if our cache entry doesn't match the expectations. */
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
     +	 * Check for a sparse-directory entry named "path/".
     +	 * Due to the input p->path not having a trailing
     +	 * slash, the negative 'pos' value overshoots the
    -+	 * expected position by one, hence "-2" here.
    ++	 * expected position by at least one, hence "-2" here.
     +	 */
     +	pos = -pos - 2;
     +
     +	if (pos < 0 || pos >= o->src_index->cache_nr)
    -+		return NULL;
    -+
    -+	ce = o->src_index->cache[pos];
    -+
    -+	if (!S_ISSPARSEDIR(ce->ce_mode))
      		return NULL;
     +
     +	/*
    -+	 * Compare ce->name to info->name + '/' + p->path + '/'
    -+	 * if info->name is non-empty. Compare ce->name to
    -+	 * p-.path + '/' otherwise.
    ++	 * We might have multiple entries between 'pos' and
    ++	 * the actual sparse-directory entry, so start walking
    ++	 * back until finding it or passing where it would be.
     +	 */
    -+	if (info->namelen) {
    -+		if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
    -+		    ce->name[info->namelen] == '/' &&
    -+		    !strncmp(ce->name, info->name, info->namelen) &&
    -+		    !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))
    ++	while (pos >= 0) {
    ++		ce = o->src_index->cache[pos];
    ++
    ++		if (strncmp(ce->name, p->path, p->pathlen))
    ++			return NULL;
    ++
    ++		if (S_ISSPARSEDIR(ce->ce_mode) &&
    ++		    sparse_dir_matches_path(ce, info, p))
     +			return ce;
    -+	} else if (ce->ce_namelen == p->pathlen + 1 &&
    -+		   !strncmp(ce->name, p->path, p->pathlen))
    -+		return ce;
    ++
    ++		pos--;
    ++	}
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
       * Note that traverse_by_cache_tree() duplicates some logic in this function
       * without actually calling it. If you change the logic here you may need to
    -@@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
    - 		}
    - 	}
    - 
    --	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
    -+	if (unpack_nondirectories(n, mask, dirmask, src, names, info, 0) < 0)
    - 		return -1;
    - 
    - 	if (o->merge && src[0]) {
     @@ unpack-trees.c: static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
      			}
      		}
      
     -		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     -					     names, info) < 0)
    -+		if (is_sparse_directory_entry(src[0], names, info)) {
    -+			if (unpack_nondirectories(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
    -+				return -1;
    -+		} else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
    ++		if (!is_sparse_directory_entry(src[0], names, info) &&
    ++		    traverse_trees_recursive(n, dirmask, mask & ~dirmask,
     +						    names, info) < 0) {
      			return -1;
     +		}
 -:  ----------- > 10:  9f31c691af6 unpack-trees: handle dir/file conflict of sparse entries
 9:  b8ff179f43e ! 11:  2a43287c47e dir.c: accept a directory as part of cone-mode patterns
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
10:  b9b97e01129 ! 12:  f83aa08ff6b diff-lib: handle index diffs with sparse dirs
    @@ Commit message
         identical to before: the lack of a cache entry is the same with a sparse
         index.
     
    -    In the case where a tree is modified, we need to expand the tree
    -    recursively, and start comparing each contained entry as either an
    -    addition, deletion, or modification. This causes an interesting
    -    recursion that did not exist before.
    +    Use diff_tree_oid() appropriately to compute the diff.
     
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
11:  611b9f61fb2 = 13:  35063ffb8ed status: skip sparse-checkout percentage with sparse-index
12:  0c0a765dde8 = 14:  b4033a9bf36 status: use sparse-index throughout
13:  02f2c7b6398 ! 15:  717a3f49f97 wt-status: expand added sparse directory entries
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
14:  46ca150c354 ! 16:  1d744848ee6 fsmonitor: integrate with sparse index
    @@ t/t7519-status-fsmonitor.sh: test_expect_success 'status succeeds after staging/
     +	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
     +		git status --porcelain=v2 >actual &&
     +	test_region $1 index ensure_full_index trace2.txt &&
    ++	test_region fsm_hook query trace2.txt &&
     +	test_cmp expect actual &&
     +	rm trace2.txt &&
     +	git sparse-checkout disable
 
