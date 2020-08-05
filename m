Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40071C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ADD22D6D
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="aIjN3++Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgHERGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgHERDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 13:03:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA05C0617A5
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 10:03:01 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 77so10033979qkm.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dfZPKLJ6r3UEWyGZR3vKueGNOUl/lW3q87JIhDFzLg8=;
        b=aIjN3++YoJkfU9/RG+X9A5G7gri5HG+/j3rs2rdk8g7lco1HeZWNU8oBH2wH/gnyLQ
         j5dPPLOPe4JYVaBsw4bCvrQEV0a3vMdyMU2oyuVtn5p6XN5hcKwRwxf3OZH/OX+lVWNv
         QWh/7q06QbstFS7mUdeByxtiomJ/07j9ZU14FobslCNQ+Tg8lBlUhs1impmRpHyYjPV8
         h5oiTMvzuEMESMbqpgnbfGBEnzBaIc1si29OrsuQTb92fu6sQNOWUeziwFba7ncFiGdv
         RHm1IcrukYntJJnP6cS+6ghkHWhPmn6X578lUWOHYs9jgMaOcf3VCMzxsA33GKa0XLP0
         +TQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dfZPKLJ6r3UEWyGZR3vKueGNOUl/lW3q87JIhDFzLg8=;
        b=OZycNibSr6C3v3mfVOxVwemxaKxgENC30wpkzZFlMZmaFXsbFtIdKd0xDEl8jcqaC6
         /jQAMXKTkhZfadKtSwNU122fNrdcO1/tPeUL0+wVCDHqiFJ5lH7o8CcszePis078tQUv
         G6Oxq6zUq6o5JPwVcHX9QKXq+kvjRbKEd4m5lm7PenS8xKAET09TToubNHi29VQCkH21
         3+32iStHLFPYyhHbSCcozBKR1eVwyL5sEOmmI3IgT7YQFusSOn2MfGpDa2jQbpDgclHY
         MPiXdYxXnvw/d5qt6BDW/cOqN7BPLjQXeZ3kGKzHRs2jgNWZOesBxGCTtZFC2KVPzRXk
         Dx+g==
X-Gm-Message-State: AOAM5312QHI0eI+53eSppSz5qwf/MY/ftQXF9YGlw06h/J2U2s3vIFNJ
        KJ65PaZkPMGONL5bREpEB2kG497gZZwglA==
X-Google-Smtp-Source: ABdhPJxZpbsk+tX1kS1D7DRcO92uh1DxCabMBNkrbF8Gn1tHtP+qMMCwvMFnWyDFCcZoct9BuP2uhQ==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr4506879qke.85.1596646979826;
        Wed, 05 Aug 2020 10:02:59 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:d118:9acc:fdba:dee7])
        by smtp.gmail.com with ESMTPSA id m17sm2311399qkn.45.2020.08.05.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 10:02:58 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:02:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, szeder.dev@gmail.com
Subject: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1596646576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596646576.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit has more than a certain number of changed paths (commonly
512), the commit-graph machinery represents it as a zero-length filter.
This is done since having many entries in the Bloom filter has
undesirable effects on the false positivity rate.

In addition to these too-large filters, the commit-graph machinery also
represents commits with no filter and commits with no changed paths in
the same way.

When writing a commit-graph that aggregates several incremental
commit-graph layers (eg., with '--split=replace'), the commit-graph
machinery first computes all of the Bloom filters that it wants to write
but does not already know about from existing graph layers. Because we
overload the zero-length filter in the above fashion, this leads to
recomputing large filters over and over again.

This is already undesirable, since it means that we are wasting
considerable effort to discover that a commit with too many changed
paths, only to throw that effort away (and then repeat the process the
next time a roll-up is performed).

In a subsequent patch, we will add a '--max-new-filters=<n>' option,
which specifies an upper-bound on the number of new filters we are
willing to compute from scratch. Suppose that there are 'N' too-large
filters, and we specify '--max-new-filters=M'. If 'N >= M', it is
unlikely that any filters will be generated, since we'll spend most of
our effort on filters that we ultimately throw away. If 'N < M', filters
will trickle in over time, but only at most 'M - N' per-write.

To address this, add a new chunk which encodes a bitmap where the ith
bit is on iff the ith commit has zero or at least 512 changed paths.
Likewise store the maximum number of changed paths we are willing to
store in order to prepare for eventually making this value more easily
customizable. When computing Bloom filters, first consult the relevant
bitmap (in the case that we are rolling up existing layers) to see if
computing the Bloom filter from scratch would be a waste of time.

This patch implements a new chunk instead of extending the existing BIDX
and BDAT chunks because modifying these chunks would confuse old
clients. (Eg., setting the most-significant bit in the BIDX chunk would
confuse old clients and require a version bump).

To allow using the existing bitmap code with 64-bit words, we write the
data in network byte order from the 64-bit words. This means we also
need to read the array from the commit-graph file by translating each
word from network byte order using get_be64() upon first use of the
bitmap. This is only used when writing the commit-graph, so this is a
relatively small operation compared to the other writing code.

By avoiding the need to move to new versions of the BDAT and BIDX chunk,
we can give ourselves more time to consider whether or not other
modifications to these chunks are worthwhile without holding up this
change.

Another approach would be to introduce a new BIDX chunk (say, one
identified by 'BID2') which is identical to the existing BIDX chunk,
except the most-significant bit of each offset is interpreted as "this
filter is too big" iff looking at a BID2 chunk. This avoids having to
write a bitmap, but forces older clients to rewrite their commit-graphs
(as well as reduces the theoretical largest Bloom filters we couldl
write, and forces us to maintain the code necessary to translate BIDX
chunks to BID2 ones). Separately from this patch, I implemented this
alternate approach and did not find it to be advantageous.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../technical/commit-graph-format.txt         |  12 +++
 bloom.h                                       |   2 +-
 commit-graph.c                                | 101 +++++++++++++++---
 commit-graph.h                                |   5 +
 t/t4216-log-bloom.sh                          |  25 ++++-
 5 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 440541045d..5f2d9ab4d7 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -123,6 +123,18 @@ CHUNK DATA:
       of length zero.
     * The BDAT chunk is present if and only if BIDX is present.
 
+  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
+    * It starts with a 32-bit unsigned integer specifying the maximum number of
+      changed-paths that can be stored in a single Bloom filter.
+    * It then contains a list of 64-bit words (the length of this list is
+      determined by the width of the chunk) which is a bitmap. The 'i'th bit is
+      set exactly when the 'i'th commit in the graph has a changed-path Bloom
+      filter with zero entries (either because the commit is empty, or because
+      it contains more than 512 changed paths).
+    * The BFXL chunk is present only when the BIDX and BDAT chunks are
+      also present.
+
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
diff --git a/bloom.h b/bloom.h
index 2353c74a24..73238276bc 100644
--- a/bloom.h
+++ b/bloom.h
@@ -33,7 +33,7 @@ struct bloom_filter_settings {
 	 * The maximum number of changed paths per commit
 	 * before declaring a Bloom filter to be too-large.
 	 *
-	 * Not written to the commit-graph file.
+	 * Written to the 'BFXL' chunk (instead of 'BDAT').
 	 */
 	uint32_t max_changed_paths;
 };
diff --git a/commit-graph.c b/commit-graph.c
index 8964453433..1fee49d171 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -41,8 +41,9 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
+#define GRAPH_CHUNKID_BLOOMLARGE 0x4246584c /* "BFXL" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 7
+#define MAX_NUM_CHUNKS 8
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -429,6 +430,19 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
 			}
 			break;
+
+		case GRAPH_CHUNKID_BLOOMLARGE:
+			if (graph->chunk_bloom_large_filters)
+				chunk_repeated = 1;
+			else if (r->settings.commit_graph_read_changed_paths) {
+				graph->bloom_large_to_alloc = get_be64(chunk_lookup + 4)
+							      - chunk_offset - sizeof(uint32_t);
+
+				graph->bloom_large.word_alloc = 0; /* populate when necessary */
+				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
+				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -443,6 +457,7 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		/* We need both the bloom chunks to exist together. Else ignore the data */
 		graph->chunk_bloom_indexes = NULL;
 		graph->chunk_bloom_data = NULL;
+		graph->chunk_bloom_large_filters = NULL;
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
@@ -932,6 +947,31 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+static int get_bloom_filter_large_in_graph(struct commit_graph *g,
+					   const struct commit *c)
+{
+	uint32_t graph_pos = commit_graph_position(c);
+	if (graph_pos == COMMIT_NOT_FROM_GRAPH)
+		return 0;
+
+	while (g && graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (!g || !g->bloom_large_to_alloc)
+		return 0;
+
+	if (!g->bloom_large.word_alloc) {
+		size_t i;
+		g->bloom_large.word_alloc = g->bloom_large_to_alloc;
+		g->bloom_large.words = xmalloc(g->bloom_large_to_alloc * sizeof(eword_t));
+
+		for (i = 0; i < g->bloom_large_to_alloc; i++)
+			g->bloom_large.words[i] = get_be64(g->chunk_bloom_large_filters
+							   + i * sizeof(eword_t));
+	}
+
+	return bitmap_get(&g->bloom_large, graph_pos - g->num_commits_in_base);
+}
 
 struct packed_oid_list {
 	struct object_id *list;
@@ -970,8 +1010,10 @@ struct write_commit_graph_context {
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
 
+	int count_bloom_filter_known_large;
 	int count_bloom_filter_found_large;
 	int count_bloom_filter_computed;
+	struct bitmap *bloom_large;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1235,6 +1277,23 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_bloom_large(struct hashfile *f,
+					 struct write_commit_graph_context *ctx)
+{
+	size_t i, alloc = ctx->commits.nr / BITS_IN_EWORD;
+	if (ctx->commits.nr % BITS_IN_EWORD)
+		alloc++;
+	if (alloc > ctx->bloom_large->word_alloc)
+		BUG("write_graph_chunk_bloom_large: bitmap not large enough");
+
+	trace2_region_enter("commit-graph", "bloom_large", ctx->r);
+	hashwrite_be32(f, ctx->bloom_settings->max_changed_paths);
+	for (i = 0; i < ctx->bloom_large->word_alloc; i++)
+		hashwrite_be64(f, ctx->bloom_large->words[i]);
+	trace2_region_leave("commit-graph", "bloom_large", ctx->r);
+	return 0;
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1398,6 +1457,8 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_known_large",
+			 ctx->count_bloom_filter_known_large);
 	jw_object_intmax(&jw, "filter_found_large",
 			 ctx->count_bloom_filter_found_large);
 	jw_object_intmax(&jw, "filter_computed",
@@ -1416,6 +1477,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int *sorted_commits;
 
 	init_bloom_filters();
+	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
 
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
@@ -1430,21 +1492,28 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 		&ctx->commits);
 
 	for (i = 0; i < ctx->commits.nr; i++) {
-		int computed = 0;
 		int pos = sorted_commits[i];
 		struct commit *c = ctx->commits.list[pos];
-		struct bloom_filter *filter = get_or_compute_bloom_filter(
-			ctx->r,
-			c,
-			1,
-			ctx->bloom_settings,
-			&computed);
-		if (computed) {
-			ctx->count_bloom_filter_computed++;
-			if (filter && !filter->len)
-				ctx->count_bloom_filter_found_large++;
+		if (get_bloom_filter_large_in_graph(ctx->r->objects->commit_graph, c)) {
+			bitmap_set(ctx->bloom_large, pos);
+			ctx->count_bloom_filter_known_large++;
+		} else {
+			int computed = 0;
+			struct bloom_filter *filter = get_or_compute_bloom_filter(
+				ctx->r,
+				c,
+				1,
+				ctx->bloom_settings,
+				&computed);
+			if (computed) {
+				ctx->count_bloom_filter_computed++;
+				if (filter && !filter->len) {
+					bitmap_set(ctx->bloom_large, pos);
+					ctx->count_bloom_filter_found_large++;
+				}
+			}
+			ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		}
-		ctx->total_bloom_filter_data_size += sizeof(unsigned char) * filter->len;
 		display_progress(progress, i + 1);
 	}
 
@@ -1764,6 +1833,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 					  + ctx->total_bloom_filter_data_size;
 		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
 		num_chunks++;
+		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMLARGE;
+		chunks[num_chunks].size = sizeof(eword_t) * ctx->bloom_large->word_alloc
+					+ sizeof(uint32_t);
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_large;
+		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
@@ -2503,6 +2577,7 @@ void free_commit_graph(struct commit_graph *g)
 	}
 	free(g->filename);
 	free(g->bloom_filter_settings);
+	bitmap_free(g->bloom_large);
 	free(g);
 }
 
diff --git a/commit-graph.h b/commit-graph.h
index d9acb22bac..f4fb996dd5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "object-store.h"
 #include "oidset.h"
+#include "ewah/ewok.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
@@ -71,6 +72,10 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
+	const unsigned char *chunk_bloom_large_filters;
+
+	size_t bloom_large_to_alloc;
+	struct bitmap bloom_large;
 
 	struct bloom_filter_settings *bloom_filter_settings;
 };
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 21b67677ef..6859d85369 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -33,7 +33,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	git commit-graph write --reachable --changed-paths
 '
 graph_read_expect () {
-	NUM_CHUNKS=5
+	NUM_CHUNKS=6
 	cat >expect <<- EOF
 	header: 43475048 1 1 $NUM_CHUNKS 0
 	num_commits: $1
@@ -262,5 +262,28 @@ test_expect_success 'correctly report changes over limit' '
 		done
 	)
 '
+test_bloom_filters_computed () {
+	commit_graph_args=$1
+	bloom_trace_prefix="{\"filter_known_large\":$2,\"filter_found_large\":$3,\"filter_computed\":$4"
+	rm -f "$TRASH_DIRECTORY/trace.event" &&
+	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $commit_graph_args &&
+	grep "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.event"
+}
+
+test_expect_success 'Bloom generation does not recompute too-large filters' '
+	(
+		cd limits &&
+
+		# start from scratch and rebuild
+		rm -f .git/objects/info/commit-graph &&
+		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
+			git commit-graph write --reachable --changed-paths \
+			--split=replace &&
+		test_commit c1 filter &&
+
+		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
+			2 0 1
+	)
+'
 
 test_done
-- 
2.28.0.rc1.13.ge78abce653

