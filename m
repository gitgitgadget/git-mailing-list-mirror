Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A66CC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE59206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfLtyJIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgFWRrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732913AbgFWRrO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D60C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so19493230wrm.4
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BcvFR35SxqrTDz3QQOoPFvjcJtMv032AbVV528qfDC8=;
        b=PfLtyJIJfEfGEzXMt5VLhrWZd9f7TXDGURhTPr7oB7Z889XYzuZCs0F+PHmciVtRif
         cCUAqrob3GLM4qO0jnvOJFwbZgrZTXVguqzfQcJ8dU1G6Ap1TEdmt1iJeuVP2nTMH+pp
         369p+hqc95iXk2p3H+EoXafxVs1IesMDymolnPVkOtFjHqsQ4jWN/9v6utQsSlRn5OPc
         0O+F41nVfj31CFTeUmaoBkqAjbG6TDGMygSJ2l797KTlh2UZxav5r8hPR6IFMXbNaC+7
         LGu8MRN7/0aYreQn2Xoki/PUIRVCQ0waI4OXiUeVAagXmps+fWMO7hWQi55akevwiZdG
         Bfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BcvFR35SxqrTDz3QQOoPFvjcJtMv032AbVV528qfDC8=;
        b=I0fsZ1kKjt0GGWYYGJo1H/D2e31C/mZbN0OAzFz6tiSzDtZ3FTPRFox+8RBBEIjdHO
         M948fLq0RZ+/1tZ7wIBpAoQ/UNY4722f3AsohrY/UrscKWeAlpUE9tcJ6yRIipRj0vA8
         Av1kWTfcdaFWsx1bGxoxOec7RoH0pNFYqp7OjeB2qxXay1gcZxq/wwbCmd74bMs7OlHn
         64cFCifqlXTL/oXFp1cVlABGRp3AZnTP6Oe1dKmVQ9hAGD6n+iCZpFEZXXHe3dqT66j7
         57hYQhv5I9ZnJfyZrOE6h8+2EHyOwzSAanUwANng9loE6RywbSruK+Xec4ZHJg0QpCqh
         X88w==
X-Gm-Message-State: AOAM530HRHNOMprJwiAK0MgB/3ho9m8Ysmla79QCGcfKPlfyoVi60hiP
        AEHVmnRIP0J6Z1I8Bk3m+eSTSaDo
X-Google-Smtp-Source: ABdhPJyMYT2cpEf9AGEmXxCwdsrcgnuEEVaUx3aR2mV76NRyqcwGtGoBTiibTa1HUPXjf/H24cfc0A==
X-Received: by 2002:a5d:518a:: with SMTP id k10mr13756632wrv.316.1592934432016;
        Tue, 23 Jun 2020 10:47:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm1129976wru.9.2020.06.23.10.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:11 -0700 (PDT)
Message-Id: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:46:59 +0000
Subject: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
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

Thanks, -Stolee

Derrick Stolee (6):
  commit-graph: place bloom_settings in context
  commit-graph: change test to die on parse, not load
  bloom: get_bloom_filter() cleanups
  commit-graph: persist existence of changed-paths
  revision.c: fix whitespace
  bloom: enforce a minimum size of 8 bytes

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
 bloom.c                            |  19 ++--
 builtin/commit-graph.c             |   5 +-
 commit-graph.c                     | 136 +++++++++++++++++++++--------
 commit-graph.h                     |   3 +-
 revision.c                         |  53 ++++++++---
 revision.h                         |   6 +-
 t/t4216-log-bloom.sh               |  35 +++++++-
 t/t5318-commit-graph.sh            |   2 +-
 9 files changed, 200 insertions(+), 64 deletions(-)


base-commit: 7fbfe07ab4d4e58c0971dac73001b89f180a0af3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-659%2Fderrickstolee%2Fbloom-2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-659/derrickstolee/bloom-2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/659

Range-diff vs v1:

  1:  c966969071 !  1:  57002040bc commit-graph: place bloom_settings in context
     @@ Commit message
          to combine the function prototypes and use function pointers to
          simplify write_commit_graph_file().
      
     +    By using a pointer, we can later replace the settings to match those
     +    that exist in the current commit-graph, in case a future Git version
     +    allows customization of these parameters.
     +
          Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ commit-graph.c: struct write_commit_graph_context {
       
       	const struct split_commit_graph_opts *split_opts;
       	size_t total_bloom_filter_data_size;
     -+	struct bloom_filter_settings bloom_settings;
     ++	const struct bloom_filter_settings *bloom_settings;
       };
       
       static void write_graph_chunk_fanout(struct hashfile *f,
     @@ commit-graph.c: static void write_graph_chunk_bloom_data(struct hashfile *f,
      -	hashwrite_be32(f, settings->hash_version);
      -	hashwrite_be32(f, settings->num_hashes);
      -	hashwrite_be32(f, settings->bits_per_entry);
     -+	hashwrite_be32(f, ctx->bloom_settings.hash_version);
     -+	hashwrite_be32(f, ctx->bloom_settings.num_hashes);
     -+	hashwrite_be32(f, ctx->bloom_settings.bits_per_entry);
     ++	hashwrite_be32(f, ctx->bloom_settings->hash_version);
     ++	hashwrite_be32(f, ctx->bloom_settings->num_hashes);
     ++	hashwrite_be32(f, ctx->bloom_settings->bits_per_entry);
       
       	while (list < last) {
       		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list, 0);
     @@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_con
       	struct object_id file_hash;
       	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
       
     -+	ctx->bloom_settings = bloom_settings;
     ++	ctx->bloom_settings = &bloom_settings;
      +
       	if (ctx->split) {
       		struct strbuf tmp_file = STRBUF_INIT;
  7:  60bbc15d24 =  2:  6b63f9bd8a commit-graph: change test to die on parse, not load
  -:  ---------- >  3:  492deaf916 bloom: get_bloom_filter() cleanups
  8:  db5b8fe843 !  4:  8727b25468 commit-graph: persist existence of changed-paths
     @@ Commit message
          property of "my commit-graph has changed-path filters" automatically. A
          user can drop filters using the --no-changed-paths option.
      
     +    In the process, we need to be extremely careful to match the Bloom
     +    filter settings as specified by the commit-graph. This will allow future
     +    versions of Git to customize these settings, and the version with this
     +    change will persist those settings as commit-graphs are rewritten on
     +    top.
     +
     +    Use the trace2 API to signal the settings used during the write, and
     +    check that output in a test after manually adjusting the correct bytes
     +    in the commit-graph file.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## Documentation/git-commit-graph.txt ##
     @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
       
      
       ## commit-graph.c ##
     +@@
     + #include "progress.h"
     + #include "bloom.h"
     + #include "commit-slab.h"
     ++#include "json-writer.h"
     ++#include "trace2.h"
     + 
     + void git_test_write_commit_graph_or_die(void)
     + {
     +@@ commit-graph.c: static void write_graph_chunk_bloom_indexes(struct hashfile *f,
     + 	stop_progress(&progress);
     + }
     + 
     ++static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
     ++{
     ++	struct json_writer jw = JSON_WRITER_INIT;
     ++
     ++	jw_object_begin(&jw, 0);
     ++	jw_object_intmax(&jw, "hash_version", ctx->bloom_settings->hash_version);
     ++	jw_object_intmax(&jw, "num_hashes", ctx->bloom_settings->num_hashes);
     ++	jw_object_intmax(&jw, "bits_per_entry", ctx->bloom_settings->bits_per_entry);
     ++	jw_end(&jw);
     ++
     ++	trace2_data_json("bloom", ctx->r, "settings", &jw);
     ++
     ++	jw_release(&jw);
     ++}
     ++
     + static void write_graph_chunk_bloom_data(struct hashfile *f,
     + 					 struct write_commit_graph_context *ctx)
     + {
     +@@ commit-graph.c: static void write_graph_chunk_bloom_data(struct hashfile *f,
     + 	struct progress *progress = NULL;
     + 	int i = 0;
     + 
     ++	trace2_bloom_filter_settings(ctx);
     ++
     + 	if (ctx->report_progress)
     + 		progress = start_delayed_progress(
     + 			_("Writing changed paths Bloom filters data"),
     +@@ commit-graph.c: static int write_commit_graph_file(struct write_commit_graph_context *ctx)
     + 	struct object_id file_hash;
     + 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
     + 
     +-	ctx->bloom_settings = &bloom_settings;
     ++	if (!ctx->bloom_settings)
     ++		ctx->bloom_settings = &bloom_settings;
     + 
     + 	if (ctx->split) {
     + 		struct strbuf tmp_file = STRBUF_INIT;
      @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       	ctx->split = flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
       	ctx->check_oids = flags & COMMIT_GRAPH_WRITE_CHECK_OIDS ? 1 : 0;
     @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
       
      +	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
      +		ctx->changed_paths = 1;
     -+	else if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
     ++	if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
     ++		struct commit_graph *g;
      +		prepare_commit_graph_one(ctx->r, ctx->odb);
      +
     ++		g = ctx->r->objects->commit_graph;
     ++
      +		/* We have changed-paths already. Keep them in the next graph */
     -+		if (ctx->r->objects->commit_graph &&
     -+		    ctx->r->objects->commit_graph->chunk_bloom_data)
     ++		if (g && g->chunk_bloom_data) {
      +			ctx->changed_paths = 1;
     ++			ctx->bloom_settings = g->bloom_filter_settings;
     ++		}
      +	}
      +
       	if (ctx->split) {
     @@ t/t4216-log-bloom.sh: test_expect_success 'setup - add commit-graph to the chain
       	test_line_count = 2 .git/objects/info/commit-graphs/commit-graph-chain
       '
       
     +@@ t/t4216-log-bloom.sh: test_expect_success 'Use Bloom filters if they exist in the latest but not all c
     + 	test_bloom_filters_used_when_some_filters_are_missing "-- A/B"
     + '
     + 
     ++BASE_BDAT_OFFSET=2240
     ++BASE_K_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 10))
     ++BASE_LEN_BYTE_OFFSET=$((BASE_BDAT_OFFSET + 14))
     ++
     ++corrupt_graph() {
     ++	pos=$1
     ++	data="${2:-\0}"
     ++	grepstr=$3
     ++	orig_size=$(wc -c < .git/objects/info/commit-graph) &&
     ++	zero_pos=${4:-${orig_size}} &&
     ++	printf "$data" | dd of=".git/objects/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
     ++	dd of=".git/objects/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null
     ++}
     ++
     ++test_expect_success 'persist filter settings' '
     ++	test_when_finished rm -rf .git/objects/info/commit-graph* &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
     ++	grep "{\"hash_version\":1,\"num_hashes\":7,\"bits_per_entry\":10}" trace2.txt &&
     ++	cp .git/objects/info/commit-graph commit-graph-before &&
     ++	corrupt_graph $BASE_K_BYTE_OFFSET "\09" &&
     ++	corrupt_graph $BASE_LEN_BYTE_OFFSET "\0F" &&
     ++	cp .git/objects/info/commit-graph commit-graph-after &&
     ++	test_commit c18 A/corrupt &&
     ++	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" git commit-graph write --reachable --changed-paths &&
     ++	grep "{\"hash_version\":1,\"num_hashes\":57,\"bits_per_entry\":70}" trace2.txt
     ++'
     ++
     + test_done
     + \ No newline at end of file
  2:  65eb15221c !  5:  244668fec4 commit-graph: unify the signatures of all write_graph_chunk_*() functions
     @@ Commit message
      
       ## commit-graph.c ##
      @@ commit-graph.c: struct write_commit_graph_context {
     - 	struct bloom_filter_settings bloom_settings;
     + 	const struct bloom_filter_settings *bloom_settings;
       };
       
      -static void write_graph_chunk_fanout(struct hashfile *f,
     @@ commit-graph.c: static void write_graph_chunk_bloom_indexes(struct hashfile *f,
      +	return 0;
       }
       
     + static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
     +@@ commit-graph.c: static void trace2_bloom_filter_settings(struct write_commit_graph_context *ctx)
     + 	jw_release(&jw);
     + }
     + 
      -static void write_graph_chunk_bloom_data(struct hashfile *f,
      -					 struct write_commit_graph_context *ctx)
      +static int write_graph_chunk_bloom_data(struct hashfile *f,
  3:  3d24b9802d =  6:  8b959f2f37 commit-graph: simplify chunk writes into loop
  4:  bdca834e6d =  7:  3eb10933dc commit-graph: check chunk sizes after writing
  -:  ---------- >  8:  0bcfc1f051 revision.c: fix whitespace
  -:  ---------- >  9:  719c7091a7 revision: empty pathspecs should not use Bloom filters
  5:  9975fc96f1 ! 10:  9c2076b4ce commit-graph: check all leading directories in changed path Bloom filters
     @@ Commit message
          This adjusts the tracing values in t4216-log-bloom.sh, which provides a
          concrete way to notice the improvement.
      
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
     +    Helped-by: René Scharfe <l.s.r@web.de>
          Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
       	int last_index;
      -	int len;
      +	size_t len;
     -+	int path_component_nr = 0, j;
     ++	int path_component_nr = 1;
       
       	if (!revs->commits)
       		return;
      @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
     - 
     - 	len = strlen(path);
     + 		return;
     + 	}
       
      -	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
      -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
      +	p = path;
     -+	do {
     -+		p = strchrnul(p + 1, '/');
     -+		path_component_nr++;
     -+	} while (p - path < len);
     ++	while (*p) {
     ++		if (is_dir_sep(*p))
     ++			path_component_nr++;
     ++		p++;
     ++	}
      +
      +	revs->bloom_keys_nr = path_component_nr;
      +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
      +
     -+	p = path;
     -+	for (j = 0; j < revs->bloom_keys_nr; j++) {
     -+		p = strchrnul(p + 1, '/');
     ++	fill_bloom_key(path, len, &revs->bloom_keys[0],
     ++		       revs->bloom_filter_settings);
     ++	path_component_nr = 1;
      +
     -+		fill_bloom_key(path, p - path, &revs->bloom_keys[j],
     -+			       revs->bloom_filter_settings);
     ++	p = path + len - 1;
     ++	while (p > path) {
     ++		if (is_dir_sep(*p))
     ++			fill_bloom_key(path, p - path,
     ++				       &revs->bloom_keys[path_component_nr++],
     ++				       revs->bloom_filter_settings);
     ++		p--;
      +	}
       
       	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
  6:  2a5f1e1752 = 11:  1022c0ad21 bloom: enforce a minimum size of 8 bytes

-- 
gitgitgadget
