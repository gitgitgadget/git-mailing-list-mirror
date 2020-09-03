Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA8C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C82020716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="LEaEtyGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgICWpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgICWp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:45:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF4C061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:45:29 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n10so3280692qtv.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z3e0AyStPPplGd4P+365qTaFq4nRK2D7mrm92rWpZTw=;
        b=LEaEtyGIn030Simr7YGZJmyjM+nSUNGWgGEwWxIEhPepKUeLlmAv4FnM598O27FFYq
         X200FadFgRZ0LtAEpA0KxAbAnzxMUCk7yAaWz0LO6aH31kITvMEKcdcJOzQkPg1RQpRt
         vYWMqiZssGKmAsuY1Um8mimGW0EDcgX9xyFXw7dVwQ/Gr1+M6bIJ6ha9k5WbGkq/r4Rx
         8la/4/SEi0+M++HFVFyd+Jdw3+BoBXBaD/Jo9+wiKiSLR+CcnDcraV9sebNqGLRWHfk5
         IDzeFIfbk3GQxJHjFUDrd4M4K+ROfNqyCQVUSnELZK/aYEUYSy9o3goFm8eJzudyb+Z7
         MhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3e0AyStPPplGd4P+365qTaFq4nRK2D7mrm92rWpZTw=;
        b=D45RLQdw2DU5QG/wpOAvfzGjXdWyt/rIt6jXSHqEV0a6uIOCG13XPnHWksY58bLveC
         O558NFngmSLS9ZyWryguH5QeZ1cAiksgJgTWRiBMRU2dze+KvkcrBV5bnJzXSwh/IdmN
         7pJ1v9auEWXXn37JcMSwAhg4s4tSv0jU86mVvFQnte3c7c0PA4v6iQJVMhaqEoxYPnnD
         JV8vJOl0OSyAabqluQ6o0z0YoPg6Wx5ejjFBhTm3GUUQ2YN9CL5VwEY+C5vyojub6UTs
         307m+UFvQG/yNqtxnPOvJVFFUqtE63jfb3FlPOzLSRerCzmAxdctKSePugTEYar1++QD
         VWww==
X-Gm-Message-State: AOAM533rTY9TBloRH9d5eHhqYJTs76Ptyci1FTyGOcaOSdtVUml2AmCX
        VVjtqEsiVVNDfQxzztE8BynLI9AXFkKw0W+9
X-Google-Smtp-Source: ABdhPJy/OpaS+S/sQtKNM17ZbjhA/UBFlpQQF9SveuhTp6497GDYRb+QFf0Xg8si/vFUtJBhsMbyWg==
X-Received: by 2002:ac8:1c82:: with SMTP id f2mr191384qtl.305.1599173128137;
        Thu, 03 Sep 2020 15:45:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id y9sm3312847qka.0.2020.09.03.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:45:27 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:45:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 00/14] more miscellaneous Bloom filter improvements
Message-ID: <cover.1599172907.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596480582.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is another reroll of my series to introduce a '--max-new-filters'
option to the 'git commit-graph write' sub-command to limit the number
of changed-path Bloom filters a single process is willing to compute
from scratch.

As a reminder (since it's been a while since v3), this is done by adding
a new 'BFXL' chunk, which specifies which Bloom filters (a) have been
computed and (b) were too large to store, and thus are encoded as
zero-length filters.

Things seem to have settled down since the review in v3, so I'm hoping
that this is what will end up being queued.

Thanks again for all of your review, and sorry for the prolonged radio
silence on this topic. I've had my hands full working on something else
that I'm hoping to start testing and sending to the list soon.

Derrick Stolee (1):
  bloom/diff: properly short-circuit on max_changes

Taylor Blau (13):
  commit-graph: introduce 'get_bloom_filter_settings()'
  t4216: use an '&&'-chain
  commit-graph: pass a 'struct repository *' in more places
  t/helper/test-read-graph.c: prepare repo settings
  commit-graph: respect 'commitGraph.readChangedPaths'
  commit-graph.c: store maximum changed paths
  bloom: split 'get_bloom_filter()' in two
  bloom: use provided 'struct bloom_filter_settings'
  commit-graph.c: sort index into commits list
  csum-file.h: introduce 'hashwrite_be64()'
  commit-graph: add large-filters bitmap chunk
  commit-graph: rename 'split_commit_graph_opts'
  builtin/commit-graph.c: introduce '--max-new-filters=<n>'

 Documentation/config.txt                      |   2 +
 Documentation/config/commitgraph.txt          |   8 +
 Documentation/git-commit-graph.txt            |   6 +
 .../technical/commit-graph-format.txt         |  13 +
 blame.c                                       |   8 +-
 bloom.c                                       |  43 ++-
 bloom.h                                       |  22 +-
 builtin/commit-graph.c                        |  61 +++-
 commit-graph.c                                | 278 +++++++++++++-----
 commit-graph.h                                |  28 +-
 csum-file.h                                   |   6 +
 diff.h                                        |   2 -
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 make: *** [Makefile                           |   0
 midx.c                                        |   3 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   7 +-
 t/helper/test-bloom.c                         |   4 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t4216-log-bloom.sh                          | 173 +++++++++--
 t/t5324-split-commit-graph.sh                 |  13 +
 tree-diff.c                                   |   5 +-
 24 files changed, 553 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt
 create mode 100644 make: *** [Makefile

Range-diff against v3:
[rebased onto master]
  1:  e714e54240 = 232:  97d80f109f commit-graph: introduce 'get_bloom_filter_settings()'
  2:  9fc8b17d6f = 233:  d60698d2f8 t4216: use an '&&'-chain
  3:  8dbe4838b7 = 234:  639a962a49 commit-graph: pass a 'struct repository *' in more places
  4:  f59db1e30d = 235:  ccab59dfe4 t/helper/test-read-graph.c: prepare repo settings
  5:  daae6788c0 = 236:  8aff54d83e commit-graph: respect 'commitGraph.readChangedPaths'
  6:  bf498844ef = 237:  965489d361 commit-graph.c: store maximum changed paths
  7:  eba2794873 = 238:  ba89a0cb83 bloom: split 'get_bloom_filter()' in two
  8:  4f08177dbe = 239:  89bedba089 bloom: use provided 'struct bloom_filter_settings'
  9:  cc1dc8b121 = 240:  427f129656 bloom/diff: properly short-circuit on max_changes
 10:  23fd52c3b8 = 241:  08b5f185f6 commit-graph.c: sort index into commits list
 11:  4800cd373e = 242:  d7cbd4ca1a csum-file.h: introduce 'hashwrite_be64()'
 12:  619e0c619d ! 243:  3063beb588 commit-graph: add large-filters bitmap chunk
    @@ Commit message

         When a commit has more than a certain number of changed paths (commonly
         512), the commit-graph machinery represents it as a zero-length filter.
    -    This is done since having many entries in the Bloom filter has
    -    undesirable effects on the false positivity rate.
    -
         In addition to these too-large filters, the commit-graph machinery also
         represents commits with no filter and commits with no changed paths in
         the same way.
    @@ Commit message
         data in network byte order from the 64-bit words. This means we also
         need to read the array from the commit-graph file by translating each
         word from network byte order using get_be64() when loading the commit
    -    graph. (Note that this *could* be delayed until first-use, but a later
    -    patch will rely on this being initialized early, so we assume the
    -    up-front cost when parsing instead of delaying initialization).
    +    graph. Initialize this bitmap lazily to avoid paying a linear-time cost
    +    upon each commit-graph load even if we do not need the bitmaps
    +    themselves.

         By avoiding the need to move to new versions of the BDAT and BIDX chunk,
         we can give ourselves more time to consider whether or not other
    @@ Commit message
         except the most-significant bit of each offset is interpreted as "this
         filter is too big" iff looking at a BID2 chunk. This avoids having to
         write a bitmap, but forces older clients to rewrite their commit-graphs
    -    (as well as reduces the theoretical largest Bloom filters we couldl
    +    (as well as reduces the theoretical largest Bloom filters we could
         write, and forces us to maintain the code necessary to translate BIDX
         chunks to BID2 ones). Separately from this patch, I implemented this
         alternate approach and did not find it to be advantageous.
    @@ Documentation/technical/commit-graph-format.txt: CHUNK DATA:
     +  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
     +    * It starts with a 32-bit unsigned integer specifying the maximum number of
     +      changed-paths that can be stored in a single Bloom filter.
    -+    * It then contains a list of 64-bit words (the length of this list is
    -+      determined by the width of the chunk) which is a bitmap. The 'i'th bit is
    -+      set exactly when the 'i'th commit in the graph has a changed-path Bloom
    -+      filter with zero entries (either because the commit is empty, or because
    -+      it contains more than 512 changed paths).
    ++    * It then contains a list of 64-bit words in network order (the length of
    ++      this list is determined by the width of the chunk) which is a bitmap. The
    ++      'i'th bit is set exactly when the 'i'th commit in the graph has a
    ++      changed-path Bloom filter with zero entries (either because the commit is
    ++      empty, or because it contains more entries than is allowed per filter by
    ++      the layer that contains it).
     +    * The BFXL chunk is present only when the BIDX and BDAT chunks are
     +      also present.
     +
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
     +			if (graph->chunk_bloom_large_filters)
     +				chunk_repeated = 1;
     +			else if (r->settings.commit_graph_read_changed_paths) {
    -+				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
     +				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
    ++				graph->bloom_large_alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
     +				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
    -+				if (alloc) {
    -+					size_t j;
    -+					graph->bloom_large = bitmap_word_alloc(alloc);
    -+
    -+					for (j = 0; j < graph->bloom_large->word_alloc; j++)
    -+						graph->bloom_large->words[j] = get_be64(
    -+							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
    -+				}
     +			}
     +			break;
      		}
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      		graph->chunk_bloom_indexes = NULL;
      		graph->chunk_bloom_data = NULL;
     +		graph->chunk_bloom_large_filters = NULL;
    ++		graph->bloom_large_alloc = 0;
      		FREE_AND_NULL(graph->bloom_filter_settings);
    -+		bitmap_free(graph->bloom_large);
      	}

    - 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
     @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
      	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
      }

    -+static int get_bloom_filter_large_in_graph(struct commit_graph *g,
    -+					   const struct commit *c)
    ++int get_bloom_filter_large_in_graph(struct commit_graph *g,
    ++				    const struct commit *c)
     +{
    -+	uint32_t graph_pos = commit_graph_position(c);
    -+	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
    ++	uint32_t graph_pos;
    ++	if (!find_commit_in_graph(c, g, &graph_pos))
     +		return 0;
     +
     +	while (g && graph_pos < g->num_commits_in_base)
     +		g = g->base_graph;
     +
    -+	if (!(g && g->bloom_large))
    ++	if (!g)
    ++		return 0;
    ++
    ++	if (!g->bloom_large && g->bloom_large_alloc) {
    ++		size_t i;
    ++		g->bloom_large = bitmap_word_alloc(g->bloom_large_alloc);
    ++
    ++		for (i = 0; i < g->bloom_large->word_alloc; i++)
    ++			g->bloom_large->words[i] = get_be64(
    ++				g->chunk_bloom_large_filters + i * sizeof(eword_t));
    ++	}
    ++
    ++	if (!g->bloom_large)
     +		return 0;
     +	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
     +}
    @@ commit-graph.h

      #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
      #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
    +@@ commit-graph.h: void load_commit_graph_info(struct repository *r, struct commit *item);
    + struct tree *get_commit_tree_in_graph(struct repository *r,
    + 				      const struct commit *c);
    +
    ++int get_bloom_filter_large_in_graph(struct commit_graph *g,
    ++				    const struct commit *c);
    ++
    + struct commit_graph {
    + 	const unsigned char *data;
    + 	size_t data_len;
     @@ commit-graph.h: struct commit_graph {
      	const unsigned char *chunk_base_graphs;
      	const unsigned char *chunk_bloom_indexes;
    @@ commit-graph.h: struct commit_graph {
     +	const unsigned char *chunk_bloom_large_filters;
     +
     +	struct bitmap *bloom_large;
    ++	size_t bloom_large_alloc;

      	struct bloom_filter_settings *bloom_filter_settings;
      };
    +@@ commit-graph.h: struct commit_graph *read_commit_graph_one(struct repository *r,
    + struct commit_graph *parse_commit_graph(struct repository *r,
    + 					void *graph_map, size_t graph_size);
    +
    ++void prepare_commit_graph_bloom_large(struct commit_graph *g);
    ++
    + /*
    +  * Return 1 if and only if the repository has a commit-graph
    +  * file and generation numbers are computed in that file.

      ## t/t4216-log-bloom.sh ##
     @@ t/t4216-log-bloom.sh: test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
    - 	git commit-graph write --reachable --changed-paths
    + 	EOF
      '
      graph_read_expect () {
     -	NUM_CHUNKS=5
     +	NUM_CHUNKS=6
      	cat >expect <<- EOF
    - 	header: 43475048 1 1 $NUM_CHUNKS 0
    + 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
      	num_commits: $1
     @@ t/t4216-log-bloom.sh: test_expect_success 'correctly report changes over limit' '
      		done
 13:  b2e33ecba8 ! 244:  ee0bc109f3 commit-graph: rename 'split_commit_graph_opts'
    @@ Commit message
         commit-graph API which have nothing to do with splitting.

         Rename the 'split_commit_graph_opts' structure to the more-generic
    -    'commit_graph_opts' to encompass both.
    +    'commit_graph_opts' to encompass both. Likewise, rename the 'flags'
    +    member to instead be 'split_flags' to clarify that it only has to do
    +    with the behavior implied by '--split'.

    -    Suggsted-by: Derrick Stolee <dstolee@microsoft.com>
    +    Suggested-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## builtin/commit-graph.c ##
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv)
      			N_("enable computation for changed paths")),
      		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
     -		OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
    -+		OPT_CALLBACK_F(0, "split", &write_opts.flags, NULL,
    ++		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
      			N_("allow writing an incremental commit-graph file"),
      			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
      			write_option_parse_split),
    @@ commit-graph.c: static void close_reachable(struct write_commit_graph_context *c
     -	enum commit_graph_split_flags flags = ctx->split_opts ?
     -		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
     +	enum commit_graph_split_flags flags = ctx->opts ?
    -+		ctx->opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
    ++		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;

      	if (ctx->report_progress)
      		ctx->progress = start_delayed_progress(
    @@ commit-graph.c: static uint32_t count_distinct_commits(struct write_commit_graph
     -	enum commit_graph_split_flags flags = ctx->split_opts ?
     -		ctx->split_opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
     +	enum commit_graph_split_flags flags = ctx->opts ?
    -+		ctx->opts->flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
    ++		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;

      	ctx->num_extra_edges = 0;
      	if (ctx->report_progress)
    @@ commit-graph.c: static void split_graph_merge_strategy(struct write_commit_graph
     +			size_mult = ctx->opts->size_multiple;

     -		flags = ctx->split_opts->flags;
    -+		flags = ctx->opts->flags;
    ++		flags = ctx->opts->split_flags;
      	}

      	g = ctx->r->objects->commit_graph;
    @@ commit-graph.c: int write_commit_graph(struct object_directory *odb,
     -		if (ctx->split_opts)
     -			replace = ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
     +		if (ctx->opts)
    -+			replace = ctx->opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
    ++			replace = ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
      	}

      	ctx->approx_nr_objects = approximate_object_count();
    @@ commit-graph.h: enum commit_graph_split_flags {
      	int size_multiple;
      	int max_commits;
      	timestamp_t expire_time;
    +-	enum commit_graph_split_flags flags;
    ++	enum commit_graph_split_flags split_flags;
    + };
    +
    + /*
     @@ commit-graph.h: struct split_commit_graph_opts {
       */
      int write_commit_graph_reachable(struct object_directory *odb,
    @@ commit-graph.h: struct split_commit_graph_opts {

      #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)

    +
    + ## make: *** [Makefile (new) ##
 14:  09f6871f66 ! 245:  cd0a9da639 builtin/commit-graph.c: introduce '--max-new-filters=<n>'
    @@ Commit message
         builtin/commit-graph.c: introduce '--max-new-filters=<n>'

         Introduce a command-line flag and configuration variable to fill in the
    -    'max_new_filters' variable introduced by the previous patch.
    +    'max_new_filters' variable introduced two patches ago.

         The command-line option '--max-new-filters' takes precedence over
         'commitGraph.maxNewFilters', which is the default value.
    @@ Documentation/git-commit-graph.txt: this option is given, future commit-graph wr
      +
     +With the `--max-new-filters=<n>` option, generate at most `n` new Bloom
     +filters (if `--changed-paths` is specified). If `n` is `-1`, no limit is
    -+enforced. Overrides the `commitGraph.maxNewFilters` configuration.
    ++enforced. Commits whose filters are not calculated are stored as a
    ++length zero Bloom filter, and their bit is marked in the `BFXL` chunk.
    ++Overrides the `commitGraph.maxNewFilters` configuration.
     ++
      With the `--split[=<strategy>]` option, write the commit-graph as a
      chain of multiple commit-graph files stored in
      `<dir>/info/commit-graphs`. Commit-graph layers are merged based on the

      ## bloom.c ##
    -@@ bloom.c: static int load_bloom_filter_from_graph(struct commit_graph *g,
    - 	else
    - 		start_index = 0;
    +@@ bloom.c: struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,

    -+	if ((start_index == end_index) &&
    -+	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
    -+		/*
    -+		 * If the filter is zero-length, either (1) the filter has no
    -+		 * changes, (2) the filter has too many changes, or (3) it
    -+		 * wasn't computed (eg., due to '--max-new-filters').
    -+		 *
    -+		 * If either (1) or (2) is the case, the 'large' bit will be set
    -+		 * for this Bloom filter. If it is unset, then it wasn't
    -+		 * computed. In that case, return nothing, since we don't have
    -+		 * that filter in the graph.
    -+		 */
    -+		return 0;
    -+	}
    + 	if (!filter->data) {
    + 		load_commit_graph_info(r, c);
    +-		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH &&
    +-			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c))
    +-				return filter;
    ++		if (commit_graph_position(c) != COMMIT_NOT_FROM_GRAPH)
    ++			load_bloom_filter_from_graph(r->objects->commit_graph, filter, c);
    + 	}
    +
    +-	if (filter->data)
    ++	if (filter->data && filter->len)
    + 		return filter;
    + 	if (!compute_if_not_present)
    + 		return NULL;
    +
    ++	if (filter && !filter->len &&
    ++	    get_bloom_filter_large_in_graph(r->objects->commit_graph, c,
    ++					    settings->max_changed_paths))
    ++		return filter;
    ++
     +
    - 	filter->len = end_index - start_index;
    - 	filter->data = (unsigned char *)(g->chunk_bloom_data +
    - 					sizeof(unsigned char) * start_index +
    + 	repo_diff_setup(r, &diffopt);
    + 	diffopt.flags.recursive = 1;
    + 	diffopt.detect_rename = 0;

      ## builtin/commit-graph.c ##
     @@ builtin/commit-graph.c: static char const * const builtin_commit_graph_usage[] = {
    @@ commit-graph.c
     @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
      }

    - static int get_bloom_filter_large_in_graph(struct commit_graph *g,
    --					   const struct commit *c)
    -+					   const struct commit *c,
    -+					   uint32_t max_changed_paths)
    + int get_bloom_filter_large_in_graph(struct commit_graph *g,
    +-				    const struct commit *c)
    ++				    const struct commit *c,
    ++				    uint32_t max_changed_paths)
      {
    - 	uint32_t graph_pos = commit_graph_position(c);
    - 	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
    -@@ commit-graph.c: static int get_bloom_filter_large_in_graph(struct commit_graph *g,
    + 	uint32_t graph_pos;
    + 	if (!find_commit_in_graph(c, g, &graph_pos))
    +@@ commit-graph.c: int get_bloom_filter_large_in_graph(struct commit_graph *g,

    - 	if (!(g && g->bloom_large))
    + 	if (!g->bloom_large)
      		return 0;
     +	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
     +		/*
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
      		ctx->order_by_pack ? commit_pos_cmp : commit_gen_cmp,
      		&ctx->commits);

    -+	max_new_filters = ctx->opts->max_new_filters >= 0 ?
    ++	max_new_filters = ctx->opts && ctx->opts->max_new_filters >= 0 ?
     +		ctx->opts->max_new_filters : ctx->commits.nr;
     +
      	for (i = 0; i < ctx->commits.nr; i++) {
    @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_cont
      	}

      ## commit-graph.h ##
    +@@ commit-graph.h: struct tree *get_commit_tree_in_graph(struct repository *r,
    + 				      const struct commit *c);
    +
    + int get_bloom_filter_large_in_graph(struct commit_graph *g,
    +-				    const struct commit *c);
    ++				    const struct commit *c,
    ++				    uint32_t max_changed_paths);
    +
    + struct commit_graph {
    + 	const unsigned char *data;
     @@ commit-graph.h: struct commit_graph_opts {
      	int max_commits;
      	timestamp_t expire_time;
    - 	enum commit_graph_split_flags flags;
    + 	enum commit_graph_split_flags split_flags;
     +	int max_new_filters;
      };

    @@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation does not recompute t
     +			2 0 1
     +	)
     +'
    ++
    ++test_expect_success 'Bloom generation backfills empty commits' '
    ++	git init empty &&
    ++	test_when_finished "rm -fr empty" &&
    ++	(
    ++		cd empty &&
    ++		for i in $(test_seq 1 6)
    ++		do
    ++			git commit --allow-empty -m "$i"
    ++		done &&
    ++
    ++		# Generate Bloom filters for empty commits 1-6, two at a time.
    ++		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
    ++			0 2 2 &&
    ++		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
    ++			2 2 2 &&
    ++		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
    ++			4 2 2 &&
    ++
    ++		# Finally, make sure that once all commits have filters, that
    ++		# none are subsequently recomputed.
    ++		test_bloom_filters_computed "--reachable --changed-paths --max-new-filters=2" \
    ++			6 0 0
    ++	)
    ++'
     +
      test_done
--
2.27.0.2918.gc99a27ff8f
