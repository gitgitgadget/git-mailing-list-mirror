Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966CC43461
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D210A20716
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 22:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zm1pi2Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgICWq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgICWq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 18:46:56 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985FC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 15:46:56 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so3282872qtv.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 15:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaJQtzdsCf45kIF/uBoImpwYsOf4KjIXg2At5AUVAY8=;
        b=zm1pi2Idrzm22iVvRuvRsVjpCKTDDY1sSXKBSGwKX1zaoF7dyTn3l0BuVIa2T/yHG/
         Z0/S4ST/d0WxGiLgthPUY6gzNoMojnFhzi7iGzKwlBGBDuJg7lxoBSMx4zLSViXuJHb9
         ksca5c/X4WdImFTjmc6NQ1bJ/ycu2N+yqdNYT5mtb5OB4ouQR+hYwuXHVe8eec72RSuz
         TPRRPxrHLpAGSpY3Hqak804Y6Jo0Q+scOIC4Gv6fAURABKjWImwYXz4mUxCUPJHHHIPF
         fNpGnlSaW5CTgPya59XnnnWtXFJqrEntyHRUJKwSpLc+hZJpmFc5UbKKnwqtVz8ABenz
         pUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaJQtzdsCf45kIF/uBoImpwYsOf4KjIXg2At5AUVAY8=;
        b=C5Lj+iraADFDmBdcidOUeW0rgjsxGS23t5cjGDbCfC9izWm4RwHQzQThjSngd+ey0Z
         EysnkGxAzYLcaGevXnSWZLNG/wVz320fDbCzL0HZJ/nrxiNPLGwFmBYR8uZnpI83/WBI
         WopPcl7I/Kuy7jUpiHUG3bf28yUnGEVUMvtogMfYR1f2DF9KDWRvCtrDMf4OI39qreXN
         xKdIjS4zhJ9KxJEh/oY+SRVdohEcFP3z/nyrpJZApeWa1+h7szF1Q9Al88U/Tvscrq7E
         2/WhV+r7LOSAfsECvU5dy/G9KqFwJmNyrtJbgsmxGAuRsdaX9HcZfyMBVHi9cvuYPkz+
         sAkA==
X-Gm-Message-State: AOAM530ZjDop15iR4TIkVUzecUEhOGyEflKc8xe/1lTVPgjhmSwHesxR
        QlKN0cqAUD2Pyl40uYK0MgEFXZxQue3HQG2W
X-Google-Smtp-Source: ABdhPJxkrA1jakxFR9fTl9UjB4kTdn5cPxsHdRvKUtdz5AAbnEv4oSEbXVB4eiFOd9IxHl1dr/JSAg==
X-Received: by 2002:ac8:7388:: with SMTP id t8mr5939957qtp.187.1599173215222;
        Thu, 03 Sep 2020 15:46:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a97c:6dae:76a4:c715])
        by smtp.gmail.com with ESMTPSA id b34sm3242868qtc.73.2020.09.03.15.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:46:54 -0700 (PDT)
Date:   Thu, 3 Sep 2020 18:46:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v4 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <3063beb58859f997188ae0cca046aaa93eec3d9d.1599172908.git.me@ttaylorr.com>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1599172907.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599172907.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit has more than a certain number of changed paths (commonly
512), the commit-graph machinery represents it as a zero-length filter.
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
word from network byte order using get_be64() when loading the commit
graph. Initialize this bitmap lazily to avoid paying a linear-time cost
upon each commit-graph load even if we do not need the bitmaps
themselves.

By avoiding the need to move to new versions of the BDAT and BIDX chunk,
we can give ourselves more time to consider whether or not other
modifications to these chunks are worthwhile without holding up this
change.

Another approach would be to introduce a new BIDX chunk (say, one
identified by 'BID2') which is identical to the existing BIDX chunk,
except the most-significant bit of each offset is interpreted as "this
filter is too big" iff looking at a BID2 chunk. This avoids having to
write a bitmap, but forces older clients to rewrite their commit-graphs
(as well as reduces the theoretical largest Bloom filters we could
write, and forces us to maintain the code necessary to translate BIDX
chunks to BID2 ones). Separately from this patch, I implemented this
alternate approach and did not find it to be advantageous.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .../technical/commit-graph-format.txt         |  13 +++
 bloom.h                                       |   2 +-
 commit-graph.c                                | 100 +++++++++++++++---
 commit-graph.h                                |  10 ++
 t/t4216-log-bloom.sh                          |  25 ++++-
 5 files changed, 135 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 6ddbceba15..db212b8cc5 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -128,6 +128,19 @@ CHUNK DATA:
       of length zero.
     * The BDAT chunk is present if and only if BIDX is present.
 
+  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
+    * It starts with a 32-bit unsigned integer specifying the maximum number of
+      changed-paths that can be stored in a single Bloom filter.
+    * It then contains a list of 64-bit words in network order (the length of
+      this list is determined by the width of the chunk) which is a bitmap. The
+      'i'th bit is set exactly when the 'i'th commit in the graph has a
+      changed-path Bloom filter with zero entries (either because the commit is
+      empty, or because it contains more entries than is allowed per filter by
+      the layer that contains it).
+    * The BFXL chunk is present only when the BIDX and BDAT chunks are
+      also present.
+
+
   Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
diff --git a/bloom.h b/bloom.h
index 3f19e3fca4..464d9b57de 100644
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
index 01d791343a..68ffa6ec35 100644
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
 
@@ -436,6 +437,16 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 				graph->bloom_filter_settings->bits_per_entry = get_be32(data + chunk_offset + 8);
 			}
 			break;
+
+		case GRAPH_CHUNKID_BLOOMLARGE:
+			if (graph->chunk_bloom_large_filters)
+				chunk_repeated = 1;
+			else if (r->settings.commit_graph_read_changed_paths) {
+				graph->chunk_bloom_large_filters = data + chunk_offset + sizeof(uint32_t);
+				graph->bloom_large_alloc = get_be64(chunk_lookup + 4) - chunk_offset - sizeof(uint32_t);
+				graph->bloom_filter_settings->max_changed_paths = get_be32(data + chunk_offset);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -450,6 +461,8 @@ struct commit_graph *parse_commit_graph(struct repository *r,
 		/* We need both the bloom chunks to exist together. Else ignore the data */
 		graph->chunk_bloom_indexes = NULL;
 		graph->chunk_bloom_data = NULL;
+		graph->chunk_bloom_large_filters = NULL;
+		graph->bloom_large_alloc = 0;
 		FREE_AND_NULL(graph->bloom_filter_settings);
 	}
 
@@ -939,6 +952,32 @@ struct tree *get_commit_tree_in_graph(struct repository *r, const struct commit
 	return get_commit_tree_in_graph_one(r, r->objects->commit_graph, c);
 }
 
+int get_bloom_filter_large_in_graph(struct commit_graph *g,
+				    const struct commit *c)
+{
+	uint32_t graph_pos;
+	if (!find_commit_in_graph(c, g, &graph_pos))
+		return 0;
+
+	while (g && graph_pos < g->num_commits_in_base)
+		g = g->base_graph;
+
+	if (!g)
+		return 0;
+
+	if (!g->bloom_large && g->bloom_large_alloc) {
+		size_t i;
+		g->bloom_large = bitmap_word_alloc(g->bloom_large_alloc);
+
+		for (i = 0; i < g->bloom_large->word_alloc; i++)
+			g->bloom_large->words[i] = get_be64(
+				g->chunk_bloom_large_filters + i * sizeof(eword_t));
+	}
+
+	if (!g->bloom_large)
+		return 0;
+	return bitmap_get(g->bloom_large, graph_pos - g->num_commits_in_base);
+}
 
 struct packed_oid_list {
 	struct object_id *list;
@@ -977,8 +1016,10 @@ struct write_commit_graph_context {
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
 
+	int count_bloom_filter_known_large;
 	int count_bloom_filter_found_large;
 	int count_bloom_filter_computed;
+	struct bitmap *bloom_large;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1242,6 +1283,23 @@ static int write_graph_chunk_bloom_data(struct hashfile *f,
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
@@ -1405,6 +1463,8 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 	struct json_writer jw = JSON_WRITER_INIT;
 
 	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_known_large",
+			 ctx->count_bloom_filter_known_large);
 	jw_object_intmax(&jw, "filter_found_large",
 			 ctx->count_bloom_filter_found_large);
 	jw_object_intmax(&jw, "filter_computed",
@@ -1423,6 +1483,7 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 	int *sorted_commits;
 
 	init_bloom_filters();
+	ctx->bloom_large = bitmap_word_alloc(ctx->commits.nr / BITS_IN_EWORD + 1);
 
 	if (ctx->report_progress)
 		progress = start_delayed_progress(
@@ -1437,21 +1498,28 @@ static void compute_bloom_filters(struct write_commit_graph_context *ctx)
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
 
@@ -1771,6 +1839,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -2510,6 +2583,7 @@ void free_commit_graph(struct commit_graph *g)
 	}
 	free(g->filename);
 	free(g->bloom_filter_settings);
+	bitmap_free(g->bloom_large);
 	free(g);
 }
 
diff --git a/commit-graph.h b/commit-graph.h
index d9acb22bac..9afb1477d5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "object-store.h"
 #include "oidset.h"
+#include "ewah/ewok.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
@@ -50,6 +51,9 @@ void load_commit_graph_info(struct repository *r, struct commit *item);
 struct tree *get_commit_tree_in_graph(struct repository *r,
 				      const struct commit *c);
 
+int get_bloom_filter_large_in_graph(struct commit_graph *g,
+				    const struct commit *c);
+
 struct commit_graph {
 	const unsigned char *data;
 	size_t data_len;
@@ -71,6 +75,10 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
+	const unsigned char *chunk_bloom_large_filters;
+
+	struct bitmap *bloom_large;
+	size_t bloom_large_alloc;
 
 	struct bloom_filter_settings *bloom_filter_settings;
 };
@@ -83,6 +91,8 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
 struct commit_graph *parse_commit_graph(struct repository *r,
 					void *graph_map, size_t graph_size);
 
+void prepare_commit_graph_bloom_large(struct commit_graph *g);
+
 /*
  * Return 1 if and only if the repository has a commit-graph
  * file and generation numbers are computed in that file.
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index e8788749bf..fed4929af3 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -38,7 +38,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
 	EOF
 '
 graph_read_expect () {
-	NUM_CHUNKS=5
+	NUM_CHUNKS=6
 	cat >expect <<- EOF
 	header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
 	num_commits: $1
@@ -267,5 +267,28 @@ test_expect_success 'correctly report changes over limit' '
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
2.27.0.2918.gc99a27ff8f

