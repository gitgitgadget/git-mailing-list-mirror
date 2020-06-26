Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47D1C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95904204EA
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bac8vs2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgFZMam (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZMal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE72C08C5DB
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so8670275wmh.4
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=D87Tc3kfUUkWAPhv7N1H5BjQKZKq9HxSIZwiklYEqDU=;
        b=bac8vs2yBAukY+en87KxywBNv6tR8FtawuTpoc0MC3cGRrqrmel80BF8zDWbbzAdGc
         rKwpEn4odeMdERj4pasnO6Q082X+ICZHff5C29oUbN5mI4W7P+0r2BlMu1ExdC8lNbn4
         FCAWS4zvgaBRZRO7SMVpLmcDcZKf/wzsgLfGHgIAKFllZXDEu93F0WB9O91kYH/qPbKM
         QPw+QXM6DFcudPxhywaWz5bk+k+6uontDDLY8HaP/9lpgqG2QPa2E00oYLDrDUJx0kpz
         5tTAbULbp5g8PadARf1lU7krsImRfVJIzaGW3ApbgR3imVCVF9msjz2zPplS795ZuIJE
         GPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=D87Tc3kfUUkWAPhv7N1H5BjQKZKq9HxSIZwiklYEqDU=;
        b=RnBwKWwmJEjIyfUBJXKT7Em06Xf3RBOvLJO2KlWT2cA6rZ+woBwV7xSSybaE5qD7t/
         vqV1W0KM1TuV0xpMZmeo9VvBbNgYgzT5G+uoWFww7o0jXt79avGvo/ICvJRf3nTLLTxW
         L9PWDY3w7JlRyBxxzrvtgS4KGzFxKsgEb2pQ8bJLE6BYa/aRoZoyngBXZDbE1WxXiNSe
         nE/kU+4TqL+2uE+kUc9bRU8qfswR+VQhqQx2Xv52bQhXMSqc1xMWdIK9D2Ig774CjVxG
         +zUe3lV4Di6QKoxRzaA+jEdHiMevLlCTYQklXrLsT+6TJjgEeWKsTCU5r/BBqD6wzAog
         JwvA==
X-Gm-Message-State: AOAM533yBwJy9EPFgGsckLF5wTYbSXTb4hV7Jq7thoL9v/km6Qkfqe2h
        v/GxkZY0iMdnskLrKguMlVr68jvj
X-Google-Smtp-Source: ABdhPJxhU0JcdkQWccm1FplAz/vX+bAL0c9onZLsOuirIdsqST3ajgdqvTkdG+TgG/jfrcumLFI71Q==
X-Received: by 2002:a05:600c:2108:: with SMTP id u8mr3465359wml.189.1593174638941;
        Fri, 26 Jun 2020 05:30:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm21218232wro.90.2020.06.26.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:38 -0700 (PDT)
Message-Id: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:26 +0000
Subject: [PATCH v3 00/10] More commit-graph/Bloom filter improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This builds on sg/commit-graph-cleanups, which took several patches from
Szeder's series [1] and applied them almost directly to a more-recent
version of Git [2].

[1] https://lore.kernel.org/git/20200529085038.26008-1-szeder.dev@gmail.com/
[2] 
https://lore.kernel.org/git/pull.650.git.1591362032.gitgitgadget@gmail.com/

This series adds a few extra improvements, several of which are rooted in
Szeder's original series. I maintained his authorship and sign-off, even
though the patches did not apply or cherry-pick at all.

(In v2, I have removed the range-diff comparison to Szeder's series, so look
at the v1 cover letter for that.)

The patches have been significantly reordered. René pointed out (and Szeder
discovered in the old thread) that we are not re-using the
bloom_filter_settings from the existing commit-graph when writing a new one.

 1. commit-graph: place bloom_settings in context
 2. commit-graph: change test to die on parse, not load

These are mostly the same, except we now use a pointer to the settings in
the commit-graph write context.

 3. bloom: get_bloom_filter() cleanups

This new patch is a subtle change in behavior that will become relevant in
the very next patch. In fact, if we swap patch 3 and 4, then
t4216-log-bloom.sh fails with a segfault due to a NULL filter.

 4. commit-graph: persist existence of changed-paths

This patch is now updated to use the existing changed-path filter settings.

 5. commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
 6. commit-graph: simplify chunk writes into loop
 7. commit-graph: check chunk sizes after writing

These are all the same as before.

 8. revision.c: fix whitespace

This patch is the cleanup part of Taylor's patch.

 9. revision: empty pathspecs should not use Bloom filters

Here is Taylor's fix for empty pathspecs.

 10. commit-graph: check all leading directories in changed path Bloom
     filters
 11. bloom: enforce a minimum size of 8 bytes

Finally, we get these performance patches. Patch 10 is updated to have the
better logic around directory separators and empty paths. Also, the list of
Bloom keys is ordered with the deepest path first. That has some tiny
performance benefits for deep paths since we can short-circuit the multi-key
checks more often. That code path is much faster than the tree parsing, so
it is hard to measure any change.

Updates in V3:

 * Responded to René's feedback.
 * Fixed the test in Patch 4 to use GIT_TEST_ variables and extend the
   GIT_TRACE2 depth to work with 'seen' branch.

Thanks, -Stolee

Derrick Stolee (5):
  commit-graph: place bloom_settings in context
  commit-graph: change test to die on parse, not load
  bloom: fix logic in get_bloom_filter()
  commit-graph: persist existence of changed-paths
  revision.c: fix whitespace

SZEDER Gábor (4):
  commit-graph: unify the signatures of all write_graph_chunk_*()
    functions
  commit-graph: simplify chunk writes into loop
  commit-graph: check chunk sizes after writing
  commit-graph: check all leading directories in changed path Bloom
    filters

Taylor Blau (1):
  revision: empty pathspecs should not use Bloom filters

 Documentation/git-commit-graph.txt |   5 +-
 bloom.c                            |  14 ++-
 builtin/commit-graph.c             |   5 +-
 commit-graph.c                     | 138 +++++++++++++++++++++--------
 commit-graph.h                     |   3 +-
 revision.c                         |  58 +++++++++---
 revision.h                         |   6 +-
 t/t4216-log-bloom.sh               |  23 ++++-
 t/t5318-commit-graph.sh            |   2 +-
 9 files changed, 189 insertions(+), 65 deletions(-)


base-commit: 7fbfe07ab4d4e58c0971dac73001b89f180a0af3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-659%2Fderrickstolee%2Fbloom-2-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-659/derrickstolee/bloom-2-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/659

Range-diff vs v2:

  1:  57002040bc =  1:  57002040bc commit-graph: place bloom_settings in context
  2:  6b63f9bd8a =  2:  6b63f9bd8a commit-graph: change test to die on parse, not load
  3:  492deaf916 !  3:  2f809499ab bloom: get_bloom_filter() cleanups
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    bloom: get_bloom_filter() cleanups
     +    bloom: fix logic in get_bloom_filter()
      
          The get_bloom_filter() method is a bit complicated in some parts where
          it does not need to be. In particular, it needs to return a NULL filter
     @@ Commit message
      
          Also clean up some style issues while we are here.
      
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## bloom.c ##
     @@ bloom.c: struct bloom_filter *get_bloom_filter(struct repository *r,
      -			else
      -				return NULL;
      -		}
     -+		    r->objects->commit_graph->chunk_bloom_indexes &&
     -+		    load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
     -+			return filter;
     ++		    r->objects->commit_graph->chunk_bloom_indexes)
     ++			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
       	}
       
      -	if (filter->data || !compute_if_not_present)
      +	if (filter->data)
       		return filter;
     -+	if (!filter->data && !compute_if_not_present)
     ++	if (!compute_if_not_present)
      +		return NULL;
       
       	repo_diff_setup(r, &diffopt);
  4:  8727b25468 !  4:  33e22d05cb commit-graph: persist existence of changed-paths
     @@ commit-graph.c: static void write_graph_chunk_bloom_data(struct hashfile *f,
       		progress = start_delayed_progress(
       			_("Writing changed paths Bloom filters data"),
      @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     + 	int num_chunks = 3;
     + 	uint64_t chunk_offset;
       	struct object_id file_hash;
     - 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     +-	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     ++	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
       
      -	ctx->bloom_settings = &bloom_settings;
     -+	if (!ctx->bloom_settings)
     ++	if (!ctx->bloom_settings) {
     ++		bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
     ++							      bloom_settings.bits_per_entry);
     ++		bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
     ++							  bloom_settings.num_hashes);
      +		ctx->bloom_settings = &bloom_settings;
     ++	}
       
       	if (ctx->split) {
       		struct strbuf tmp_file = STRBUF_INIT;
     @@ t/t4216-log-bloom.sh: test_expect_success 'Use Bloom filters if they exist in th
       	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
       '
       
     -+BASE_BDAT_OFFSET=2240
     -+BASE_K_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 10))
     -+BASE_LEN_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 14))
     -+
     -+corrupt_graph() {
     -+	pos=$1
     -+	data="${2:-\0}"
     -+	grepstr=$3
     -+	orig_size=$(wc -c < .git/objects/info/commit-graph) &&
     -+	zero_pos=${4:-${orig_size}} &&
     -+	printf "$data" | dd of=".git/objects/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
     -+	dd of=".git/objects/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null
     -+}
     -+
      +test_expect_success 'persist filter settings' '
      +	test_when_finished rm -rf .git/objects/info/commit-graph* &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
     -+	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
     -+	cp .git/objects/info/commit-graph commit-graph-before &&
     -+	corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
     -+	corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
     -+	cp .git/objects/info/commit-graph commit-graph-after &&
     -+	test_commit c18 A/corrupt &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
     -+	grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
     ++	rm -rf .git/objects/info/commit-graph* &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
     ++		GIT_TRACE2_EVENT_NESTING=5 \
     ++		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
     ++		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
     ++		git commit-graph write --reachable --changed-paths &&
     ++	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2.txt &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
     ++		GIT_TRACE2_EVENT_NESTING=5 \
     ++		git commit-graph write --reachable --changed-paths &&
     ++	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15}" trace2-auto.txt
      +'
      +
       test_done
  5:  244668fec4 !  5:  81c45d5260 commit-graph: unify the signatures of all write_graph_chunk_*() functions
     @@ Commit message
          This opens up the possibility for further cleanups and foolproofing in
          the following two patches.
      
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ commit-graph.c: static void write_graph_chunk_fanout(struct hashfile *f,
       	for (count = 0; count < ctx->commits.nr; count++, list++) {
       		display_progress(ctx->progress, ++ctx->progress_cnt);
      -		hashwrite(f, (*list)->object.oid.hash, (int)hash_len);
     -+		hashwrite(f, (*list)->object.oid.hash, (int)the_hash_algo->rawsz);
     ++		hashwrite(f, (*list)->object.oid.hash, the_hash_algo->rawsz);
       	}
      +
      +	return 0;
  6:  8b959f2f37 !  6:  8828dcd906 commit-graph: simplify chunk writes into loop
     @@ Commit message
          file.  This will open up the possibility for a bit of foolproofing in
          the following patch.
      
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
      -		return -1;
      +
      +	for (i = 0; i < num_chunks; i++) {
     -+		if (chunks[i].write_fn(f, ctx)) {
     -+			error(_("failed writing chunk with id %"PRIx32""),
     -+			      chunks[i].id);
     ++		if (chunks[i].write_fn(f, ctx))
      +			return -1;
     -+		}
       	}
      +
       	stop_progress(&ctx->progress);
  7:  3eb10933dc !  7:  ddbf297755 commit-graph: check chunk sizes after writing
     @@ Commit message
          in a loop we can do this check in a single place for all chunks, and
          any chunks added in the future will get checked as well.
      
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## commit-graph.c ##
      @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     - 			num_chunks * ctx->commits.nr);
       	}
       
     -+	chunk_offset = f->total + f->offset;
       	for (i = 0; i < num_chunks; i++) {
     -+		uint64_t end_offset;
     ++		uint64_t start_offset = f->total + f->offset;
      +
     - 		if (chunks[i].write_fn(f, ctx)) {
     - 			error(_("failed writing chunk with id %"PRIx32""),
     - 			      chunks[i].id);
     + 		if (chunks[i].write_fn(f, ctx))
       			return -1;
     - 		}
      +
     -+		end_offset = f->total + f->offset;
     -+		if (end_offset - chunk_offset != chunks[i].size)
     ++		if (f->total + f->offset != start_offset + chunks[i].size)
      +			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
     -+			    chunks[i].size, chunks[i].id, end_offset - chunk_offset);
     -+		chunk_offset = end_offset;
     ++			    chunks[i].size, chunks[i].id,
     ++			    f->total + f->offset - start_offset);
       	}
       
       	stop_progress(&ctx->progress);
  8:  0bcfc1f051 =  8:  8b63706141 revision.c: fix whitespace
  9:  719c7091a7 =  9:  7d6163305a revision: empty pathspecs should not use Bloom filters
 10:  9c2076b4ce ! 10:  40061233ca commit-graph: check all leading directories in changed path Bloom filters
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
      +	p = path;
      +	while (*p) {
     -+		if (is_dir_sep(*p))
     ++		/*
     ++		 * At this point, the path is normalized to use Unix-style
     ++		 * path separators. This is required due to how the
     ++		 * changed-path Bloom filters store the paths.
     ++		 */
     ++		if (*p == '/')
      +			path_component_nr++;
      +		p++;
      +	}
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      +
      +	p = path + len - 1;
      +	while (p > path) {
     -+		if (is_dir_sep(*p))
     ++		if (*p == '/')
      +			fill_bloom_key(path, p - path,
      +				       &revs->bloom_keys[path_component_nr++],
      +				       revs->bloom_filter_settings);
 11:  1022c0ad21 <  -:  ---------- bloom: enforce a minimum size of 8 bytes

-- 
gitgitgadget
