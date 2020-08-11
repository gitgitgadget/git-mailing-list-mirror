Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB9C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352F52076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 20:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="CNcknv/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgHKUvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 16:51:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A1C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l64so151218qkb.8
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QujgihJkXaAq08e5yzeTcqSAp6g2VkPcjCQxDs9nx0A=;
        b=CNcknv/uPHWr9bDTrqzybTQtPbCifNtwWuz+1lFLvA7CARKhjA5/KZePwqQSPtLmdS
         RYpgibO8uyfPdMfbnJbn/8c9dkxKiYmqk9DZNo6M+uQ9DB7xFO+94+ONE24jZZ5y2XJR
         PAXybQSVydgf0UHCJ3sUSU+00etrNjp6Xr1J+dwO33OYczFGOqOIhOkMlfJPI1pCnc9H
         H/PCZ4WeFyTd9Uxw+UTa/7mbJIYgcwMuKJdbfepi+OEtt6FJTxC38xOKUMmcPSzKkVKr
         fLvTANalNx0kGUgZ4Tybdj1XN4ZIFydRMtmIAmdopc3ZWpd7bzkHUkJJAFmB4cKNhL3j
         5/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QujgihJkXaAq08e5yzeTcqSAp6g2VkPcjCQxDs9nx0A=;
        b=KoHsdSYijtQk6bu9f18bF0HL/CHocYdOdknUsFlGlSKg5pTSDTd2wfqo8FkPDBikRE
         7/ngelj8U8/o4P+3I14V2PBfNTjqpl0uS2tQ5qSqRuvqGB+S72nq53zL9RMS9NGSx3vv
         3qsL3mqU94wBLlFweFc2PUXwVZVdaVqNTHqxeizH2GiFf9vFYDuMtIX9fLyAeIRHteZO
         +rqglQsEgw6tel3J7nmt7ZH7jCZ5MKvQq/JYVFCWP4BMHAtH9uNw/E+pb5o55H5tVtph
         u2aAljjigiIj4Q6eneCXrd5x8LnVUlghBf+84j6rCuGmrrOqo/z3nWlV05RF1z0pOOsx
         9rOw==
X-Gm-Message-State: AOAM533/JrSx59dfhihfhcFVPx5+bw65ak/kvVyXVvJWAnCpzNGDTJfE
        piLwKi8DE/02kDpbPm3d2gEXwbI7fxlRK+zx
X-Google-Smtp-Source: ABdhPJwQcYgLUmT1FhXqmqM+QFiiUd13vsnX4DMQJ6+8PUL+5XuxJyLYAKOUVWgnOSMGFjfI7qbmcw==
X-Received: by 2002:a05:620a:128e:: with SMTP id w14mr2792886qki.97.1597179075978;
        Tue, 11 Aug 2020 13:51:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id l45sm19771987qtf.11.2020.08.11.13.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 13:51:15 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:51:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com,
        gitster@pobox.com
Subject: [PATCH v3 00/14] more miscellaneous Bloom filter improvements
Message-ID: <cover.1597178914.git.me@ttaylorr.com>
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

Here's a(nother) re-roll of mine and Stolee's series to introduce the
new BFXL commit-graph chunk, along with the '--max-new-filters' option
to 'git commit-graph write'.

Not really much has changed since v2, other than a rebase onto the
latest from master (the fifth 2.29 batch, at the time of writing), and
to squash in a few fixups that I sent in response to my v2 series.

Hopefully this should be ready for queueing. (Stolee has looked at this
a lot off-list, but it would be great to get an ack from him on list,
too).

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
 Documentation/git-commit-graph.txt            |   4 +
 .../technical/commit-graph-format.txt         |  12 +
 blame.c                                       |   8 +-
 bloom.c                                       |  51 +++-
 bloom.h                                       |  22 +-
 builtin/commit-graph.c                        |  61 +++-
 commit-graph.c                                | 274 +++++++++++++-----
 commit-graph.h                                |  19 +-
 csum-file.h                                   |   6 +
 diff.h                                        |   2 -
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 midx.c                                        |   3 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   7 +-
 t/helper/test-bloom.c                         |   4 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t4216-log-bloom.sh                          | 148 ++++++++--
 t/t5324-split-commit-graph.sh                 |  13 +
 tree-diff.c                                   |   5 +-
 23 files changed, 522 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

Range-diff against v2:
 [ ... rebase onto 'master' ... ]
 1:  001f3385ff = 34:  e714e54240 commit-graph: introduce 'get_bloom_filter_settings()'
 2:  e4d068a478 = 35:  9fc8b17d6f t4216: use an '&&'-chain
 3:  afdc614c0d = 36:  8dbe4838b7 commit-graph: pass a 'struct repository *' in more places
 4:  038e996ced = 37:  f59db1e30d t/helper/test-read-graph.c: prepare repo settings
 5:  404f10319a = 38:  daae6788c0 commit-graph: respect 'commitGraph.readChangedPaths'
 6:  053991f048 = 39:  bf498844ef commit-graph.c: store maximum changed paths
 7:  23525947c8 ! 40:  eba2794873 bloom: split 'get_bloom_filter()' in two
    @@ bloom.h: void add_key_to_filter(const struct bloom_key *key,
     +						 int compute_if_not_present,
     +						 int *computed);
     +
    -+#define DEFAULT_BLOOM_MAX_CHANGES 512
     +#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
     +	(r), (c), 0, NULL)

 8:  4deb724fc1 ! 41:  4f08177dbe bloom: use provided 'struct bloom_filter_settings'
    @@ bloom.h: void init_bloom_filters(void);
     +						 const struct bloom_filter_settings *settings,
      						 int *computed);

    - #define DEFAULT_BLOOM_MAX_CHANGES 512
      #define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
     -	(r), (c), 0, NULL)
     +	(r), (c), 0, NULL, NULL)
 9:  d1c4bbcaa9 = 42:  cc1dc8b121 bloom/diff: properly short-circuit on max_changes
10:  e92ccafcf7 = 43:  23fd52c3b8 commit-graph.c: sort index into commits list
11:  c42d678714 = 44:  4800cd373e csum-file.h: introduce 'hashwrite_be64()'
12:  100b26d7c8 ! 45:  619e0c619d commit-graph: add large-filters bitmap chunk
    @@ Commit message
         To allow using the existing bitmap code with 64-bit words, we write the
         data in network byte order from the 64-bit words. This means we also
         need to read the array from the commit-graph file by translating each
    -    word from network byte order using get_be64() upon first use of the
    -    bitmap. This is only used when writing the commit-graph, so this is a
    -    relatively small operation compared to the other writing code.
    +    word from network byte order using get_be64() when loading the commit
    +    graph. (Note that this *could* be delayed until first-use, but a later
    +    patch will rely on this being initialized early, so we assume the
    +    up-front cost when parsing instead of delaying initialization).

         By avoiding the need to move to new versions of the BDAT and BIDX chunk,
         we can give ourselves more time to consider whether or not other
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
     +			if (graph->chunk_bloom_large_filters)
     +				chunk_repeated = 1;
     +			else if (r->settings.commit_graph_read_changed_paths) {
    -+				graph->bloom_large_to_alloc = get_be64(chunk_lookup + 4)
    -+							      - chunk_offset - sizeof(uint32_t);
    -+
    -+				graph->bloom_large.word_alloc = 0; /* populate when necessary */
    ++				size_t alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
     +				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
     +				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
    ++				if (alloc) {
    ++					size_t j;
    ++					graph->bloom_large = bitmap_word_alloc(alloc);
    ++
    ++					for (j = 0; j < graph->bloom_large->word_alloc; j++)
    ++						graph->bloom_large->words[j] = get_be64(
    ++							graph->chunk_bloom_large_filters + j * sizeof(eword_t));
    ++				}
     +			}
     +			break;
      		}
    @@ commit-graph.c: struct commit_graph *parse_commit_graph(struct repository *r,
      		graph->chunk_bloom_data = NULL;
     +		graph->chunk_bloom_large_filters = NULL;
      		FREE_AND_NULL(graph->bloom_filter_settings);
    ++		bitmap_free(graph->bloom_large);
      	}

    + 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
     @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
      	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
      }
    @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, cons
     +	while (g && graph_pos < g->num_commits_in_base)
     +		g = g->base_graph;
     +
    -+	if (!g || !g->bloom_large_to_alloc)
    ++	if (!(g && g->bloom_large))
     +		return 0;
    -+
    -+	if (!g->bloom_large.word_alloc) {
    -+		size_t i;
    -+		g->bloom_large.word_alloc = g->bloom_large_to_alloc;
    -+		g->bloom_large.words = xmalloc(g->bloom_large_to_alloc * sizeof(eword_t));
    -+
    -+		for (i = 0; i < g->bloom_large_to_alloc; i++)
    -+			g->bloom_large.words[i] = get_be64(g->chunk_bloom_large_filters
    -+							   + i * sizeof(eword_t));
    -+	}
    -+
    -+	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
    ++	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
     +}

      struct packed_oid_list {
    @@ commit-graph.h: struct commit_graph {
      	const unsigned char *chunk_bloom_data;
     +	const unsigned char *chunk_bloom_large_filters;
     +
    -+	size_t bloom_large_to_alloc;
    -+	struct bitmap bloom_large;
    ++	struct bitmap *bloom_large;

      	struct bloom_filter_settings *bloom_filter_settings;
      };
13:  2ee0b84351 = 46:  b2e33ecba8 commit-graph: rename 'split_commit_graph_opts'
14:  3b66ae4a9c ! 47:  09f6871f66 builtin/commit-graph.c: introduce '--max-new-filters=<n>'
    @@ bloom.c: static int load_bloom_filter_from_graph(struct commit_graph *g,
      		start_index = 0;

     +	if ((start_index == end_index) &&
    -+	    (g->bloom_large.word_alloc && !bitmap_get(&g->bloom_large, lex_pos))) {
    ++	    (g->bloom_large && !bitmap_get(g->bloom_large, lex_pos))) {
     +		/*
     +		 * If the filter is zero-length, either (1) the filter has no
     +		 * changes, (2) the filter has too many changes, or (3) it
    @@ commit-graph.c: struct tree *get_commit_tree_in_graph(struct repository *r, cons
      {
      	uint32_t graph_pos = commit_graph_position(c);
      	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
    +@@ commit-graph.c: static int get_bloom_filter_large_in_graph(struct commit_graph *g,
    +
    + 	if (!(g && g->bloom_large))
    + 		return 0;
    ++	if (g->bloom_filter_settings->max_changed_paths != max_changed_paths) {
    ++		/*
    ++		 * Force all commits which are subject to a different
    ++		 * 'max_changed_paths' limit to be recomputed from scratch.
    ++		 *
    ++		 * Note that this could likely be improved, but is ignored since
    ++		 * all real-world graphs set the maximum number of changed paths
    ++		 * at 512.
    ++		 */
    ++		return 0;
    ++	}
    + 	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
    + }
    +
     @@ commit-graph.c: static void compute_bloom_filters(struct write_commit_graph_context *ctx)
      	int i;
      	struct progress *progress = NULL;
--
2.28.0.rc1.13.ge78abce653
