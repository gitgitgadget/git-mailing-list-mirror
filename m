Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F12C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C14C2146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtzGNp5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLTWFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35528 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfLTWF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:29 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so9859059edv.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jvzyRr0y4T3PrWPI48LkRBUpMJffE0pXek+8LCZXFTc=;
        b=TtzGNp5pGt790CTYKRl/hlRJtZ/9dI1EWJqDzZEY7P+X3Os4CgzJU59GJtvnhmwVrg
         AoHq5Tbo6NeBHGhRMJ2/YdBqllQkaIIozT5tFDa+0MCgLBzZ9XlpZVYi+hcoPg+GUQON
         l3RBKKo1kquijDorgDJ+NGoDRLh36EykuSDxIHGWSGn23EhR45utCD1BSlAdhN3dH5By
         TIVeAGIjjJZm8N23YY/996Ca91+HBlDx788nPvpAZI/RZLdzPWA4YT1/cXtJpXA30U9k
         QcCH9jc2OAhJnRkjwFZ700gJ/c++E/aeK8B1B3Jw36ImH7cjw1K4pMu0pOyTZ8WfM6pt
         Pxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jvzyRr0y4T3PrWPI48LkRBUpMJffE0pXek+8LCZXFTc=;
        b=A1WK9prSp/YTNyIQdF5M7WyshU9CtbiERjxvETe18GHaAhiOO+HFtR7kyYcRB7dxrm
         vXQNTuJyRuzCbyxX9nOMTCsV2RCE30fePPO6yaOLh+rXalNpp3w8/0EHvgQwy241DK97
         lQGb8MLEHqPPOtBX95eGgmsy0iVKL4bPavHpzNupQd5F+RxEKWo+fKy+PBkgF9nQMWGf
         u48GnmhHC44x5jJES9yR8q11mIR8gRfVJ0QezmKeYHmVEgryDSgQj40nZAvGA1cgQzD6
         PGDztf1bAM52X5W7ZW32bO1p+eSRSuaMQ89k1YJL9bR4s5uFYs9OvhR9aYu/A5nMKYfq
         za1g==
X-Gm-Message-State: APjAAAV/xiMCU5mF6SNTO65H4YBkUTKtjVFU1d8XvVx5Ymt9/YntxTpf
        5OPO8qh1xopBtxzOfytrXb03QeHf
X-Google-Smtp-Source: APXvYqw0xtKQgRJUqZuZ4N2vrd0CjUQkqpq7+uTpz6JuHs7qhiP29TpWyrfzV56VJ3VQ2fiRCd/g9g==
X-Received: by 2002:a17:906:f286:: with SMTP id gu6mr18517322ejb.146.1576879526580;
        Fri, 20 Dec 2019 14:05:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id va15sm1268038ejb.18.2019.12.20.14.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:26 -0800 (PST)
Message-Id: <7648021072ca11153ac65c90f0ebed5973f20e1a.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:16 +0000
Subject: [PATCH 5/9] commit-graph: write changed path bloom filters to
 commit-graph file.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Write bloom filters to the commit-graph using the format described in
Documentation/technical/commit-graph-format.txt

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 commit-graph.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++-
 commit-graph.h |  5 ++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8c4941eeaa..def2ade166 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -24,7 +24,9 @@
 #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 5
+#define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
+#define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
+#define MAX_NUM_CHUNKS 7
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -282,6 +284,32 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 				chunk_repeated = 1;
 			else
 				graph->chunk_base_graphs = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMINDEXES:
+			if (graph->chunk_bloom_indexes)
+				chunk_repeated = 1;
+			else
+				graph->chunk_bloom_indexes = data + chunk_offset;
+			break;
+
+		case GRAPH_CHUNKID_BLOOMDATA:
+			if (graph->chunk_bloom_data)
+				chunk_repeated = 1;
+			else {
+				uint32_t hash_version;
+				graph->chunk_bloom_data = data + chunk_offset;
+				hash_version = get_be32(data + chunk_offset);
+
+				if (hash_version != 1)
+					break;
+
+				graph->settings = xmalloc(sizeof(struct bloom_filter_settings));
+				graph->settings->hash_version = hash_version;
+				graph->settings->num_hashes = get_be32(data + chunk_offset + 4);
+				graph->settings->bits_per_entry = get_be32(data + chunk_offset + 8);
+			}
+			break;
 		}
 
 		if (chunk_repeated) {
@@ -996,6 +1024,39 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
+static void write_graph_chunk_bloom_indexes(struct hashfile *f,
+					    struct write_commit_graph_context *ctx)
+{
+	struct commit **list = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+	uint32_t cur_pos = 0;
+
+	while (list < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *list);
+		cur_pos += filter->len;
+		hashwrite_be32(f, cur_pos);
+		list++;
+	}
+}
+
+static void write_graph_chunk_bloom_data(struct hashfile *f,
+					 struct write_commit_graph_context *ctx,
+					 struct bloom_filter_settings *settings)
+{
+	struct commit **first = ctx->commits.list;
+	struct commit **last = ctx->commits.list + ctx->commits.nr;
+
+	hashwrite_be32(f, settings->hash_version);
+	hashwrite_be32(f, settings->num_hashes);
+	hashwrite_be32(f, settings->bits_per_entry);
+
+	while (first < last) {
+		struct bloom_filter *filter = get_bloom_filter(ctx->r, *first);
+		hashwrite(f, filter->data, filter->len * sizeof(uint64_t));
+		first++;
+	}
+}
+
 static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
@@ -1388,6 +1449,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
 	struct object_id file_hash;
+	struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1432,6 +1494,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
 		num_chunks++;
 	}
+	if (ctx->bloom) {
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
+		num_chunks++;
+		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
 		num_chunks++;
@@ -1450,6 +1518,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 						4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
+	if (ctx->bloom) {
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] + sizeof(uint32_t) * ctx->commits.nr;
+		num_chunks++;
+
+		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] + sizeof(uint32_t) * 3 + ctx->total_bloom_filter_size;
+		num_chunks++;
+	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
 						hashsz * (ctx->num_commit_graphs_after - 1);
@@ -1487,6 +1562,10 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	write_graph_chunk_data(f, hashsz, ctx);
 	if (ctx->num_extra_edges)
 		write_graph_chunk_extra_edges(f, ctx);
+	if (ctx->bloom) {
+		write_graph_chunk_bloom_indexes(f, ctx);
+		write_graph_chunk_bloom_data(f, ctx, &bloom_settings);
+	}
 	if (ctx->num_commit_graphs_after > 1 &&
 	    write_graph_chunk_base(f, ctx)) {
 		return -1;
diff --git a/commit-graph.h b/commit-graph.h
index 952a4b83be..2202ad91ae 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -10,6 +10,7 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 
 struct commit;
+struct bloom_filter_settings;
 
 char *get_commit_graph_filename(const char *obj_dir);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
@@ -58,6 +59,10 @@ struct commit_graph {
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_extra_edges;
 	const unsigned char *chunk_base_graphs;
+	const unsigned char *chunk_bloom_indexes;
+	const unsigned char *chunk_bloom_data;
+
+	struct bloom_filter_settings *settings;
 };
 
 struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
-- 
gitgitgadget

