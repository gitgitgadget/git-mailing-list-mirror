Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28093C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0429520776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/HRUI2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgE2Iv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgE2Ivd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51352C08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so2592764wrp.3
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xq9RPwStefHvCymyxByn3fvYLabVFMEidu2zASdQcu0=;
        b=G/HRUI2MG3qzrPCZ1Iuo6DiUplG9ImjappnenKNxJQfkI1+B41wC7lBmF2QrJQgUbJ
         acwr0ofWGGUyYSLa/n2vVRf2x8byKu3MjuFy0xY/FOpnwHBuhQDgFixqLmtm/A/9MHIJ
         AM/noY/f41IAsrjABoF2VVi5zTSBuDgf0r8zmYm6G2aYoqDDrRH0UjctvAXlue3bSjX3
         xdmVJt3lBGVYbjAZgRzcXcFWxUJUgRost3t/IRHrNY0PmldcgG5NgOdSVsx5eYXMk4Ib
         octeYg7bz+etr8Po0w8PIrd+e9v/qf0gX0t4ZifAKmplSIyxK9qp+NgukM02ytLhozgr
         Irjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xq9RPwStefHvCymyxByn3fvYLabVFMEidu2zASdQcu0=;
        b=AVjP1JrnCBIbQ/p63eibS6WRSnVWr08tTO9a/1aqGmqM8/rt0AhX5jN3L7SVbm4ooM
         sSELzHUUg3g+GNW43FePCnWjFnWND5vRoMqsApSYRSm4jdtkXZjGD9jPe0eIjLtRviVq
         0LhccIgZDB/URGhBrS2decRC4PfTo9wK/PekxNqQYJj9doYy7Bf68tu28ZCo5N5jdcqa
         0vuWDacAOk3OUEbcYpBTkEisuLwOClbxWgin9dH/Gd/Q4ULSy3U9AKqEY8ysJHnWaSmW
         HebgY22cdy6eSHUf9RT9v4OyZDLlkjJcoJPlTGAQcFBO5YOfwespiJsdTyW8l67ndn3Z
         oC9A==
X-Gm-Message-State: AOAM532ytW/ZQoKAlQnSHMsk1Qu9p0pMLNNQH+pnWB7wRZ75sUnpiTNL
        h61ejoKjbAVXyhnuyad+SdkjGuju
X-Google-Smtp-Source: ABdhPJyZBo+zX3d+JS5eH5Iv7771KLHseOIarzbTIe83Lg85hPLFiwIPooN/wgZsIo7fxDbvY5a1GQ==
X-Received: by 2002:adf:8023:: with SMTP id 32mr8118751wrk.247.1590742291682;
        Fri, 29 May 2020 01:51:31 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 22/34] commit-graph: write the Modified Path Bloom Filters chunk
Date:   Fri, 29 May 2020 10:50:26 +0200
Message-Id: <20200529085038.26008-23-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the Modified Path Bloom Filters chunk first, keeping track of
the offsets where each (non-embedded) Bloom filter has been written,
and then write the Modified Path Bloom Filter Index chunk using those
recorded offsets.
---
 commit-graph.c | 78 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fb24600bb3..3210ec2f93 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -26,6 +26,7 @@
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX 0x4d504249 /* "MPBI" */
+#define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTERS 0x4d504246 /* "MPBF" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_EXCLUDES 0x4d504258 /* "MPBX" */
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
@@ -56,6 +57,12 @@
 
 struct modified_path_bloom_filter_info {
 	struct bloom_filter filter;
+	/*
+	 * The offset relative to the start of the Modified Path Bloom
+	 * Filters chunk where this Bloom filter has been written,
+	 * -1 before that.
+	 */
+	uint64_t offset;
 };
 
 static void free_modified_path_bloom_filter_info_in_slab(
@@ -1019,6 +1026,9 @@ struct write_commit_graph_context {
 		 */
 		uint32_t *hashes;
 		int hashes_nr, hashes_alloc;
+
+		/* Excluding embedded modified path Bloom filters */
+		uint64_t total_filter_size;
 	} mpbfctx;
 };
 
@@ -1219,6 +1229,43 @@ static int write_graph_chunk_extra_edges(struct hashfile *f,
 	return 0;
 }
 
+static int write_graph_chunk_modified_path_bloom_filters(struct hashfile *f,
+		struct write_commit_graph_context *ctx)
+{
+	uint64_t offset = 0;
+	int i;
+
+	for (i = 0; i < ctx->commits.nr; i++) {
+		struct commit *commit = ctx->commits.list[i];
+		struct modified_path_bloom_filter_info *bfi;
+		unsigned int filter_size;
+
+		display_progress(ctx->progress, ++ctx->progress_cnt);
+
+		bfi = modified_path_bloom_filters_peek(
+				&modified_path_bloom_filters, commit);
+
+		if (!bfi || !bfi->filter.nr_bits)
+			continue;
+		if (bfi->filter.nr_bits == GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS)
+			continue;
+
+		if (offset >> 62)
+			BUG("offset %lu is too large for the Modified Path Bloom Filter Index chunk",
+			    offset);
+
+		bfi->offset = offset;
+
+		filter_size = bloom_filter_bytes(&bfi->filter);
+
+		hashwrite_be32(f, bfi->filter.nr_bits);
+		hashwrite(f, bfi->filter.bits, filter_size);
+
+		offset += sizeof(uint32_t) + filter_size;
+	}
+	return 0;
+}
+
 static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 		struct write_commit_graph_context *ctx)
 {
@@ -1247,8 +1294,11 @@ static int write_graph_chunk_modified_path_bloom_index(struct hashfile *f,
 			 */
 			filterdata[0] |= 1 << 7;
 			hashwrite(f, filterdata, sizeof(filterdata));
+		} else if (bfi->offset != -1) {
+			uint64_t offset = htonll(bfi->offset);
+			hashwrite(f, &offset, sizeof(offset));
 		} else
-			BUG("writing non-embedded Bloom filters is not implemented yet");
+			BUG("modified path Bloom filter offset is still -1?!");
 	}
 	return 0;
 }
@@ -1424,17 +1474,20 @@ static void create_modified_path_bloom_filter(
 	diff_tree_oid(parent_oid, &commit->object.oid, "", &mpbfctx->diffopt);
 	path_component_count = mpbfctx->hashes_nr / mpbfctx->num_hashes;
 
+	bfi = modified_path_bloom_filters_at(&modified_path_bloom_filters,
+					     commit);
+	bfi->offset = -1;
 	if (path_component_count > mpbfctx->embedded_limit) {
-		/* Not implemented yet. */
-	} else {
-		bfi = modified_path_bloom_filters_at(
-				&modified_path_bloom_filters, commit);
-
+		bloom_filter_init(&bfi->filter, mpbfctx->num_hashes,
+				  path_component_count);
+		mpbfctx->total_filter_size += sizeof(uint32_t) +
+					      bloom_filter_bytes(&bfi->filter);
+	} else
 		bloom_filter_init_with_size(&bfi->filter,
 				GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS);
-		bloom_filter_set_bits(&bfi->filter, mpbfctx->hashes,
-				      mpbfctx->hashes_nr);
-	}
+
+	bloom_filter_set_bits(&bfi->filter, mpbfctx->hashes,
+			      mpbfctx->hashes_nr);
 }
 
 static void add_missing_parents(struct write_commit_graph_context *ctx, struct commit *commit)
@@ -1845,6 +1898,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		chunks_nr++;
 	}
 	if (ctx->mpbfctx.use_modified_path_bloom_filters) {
+		if (ctx->mpbfctx.total_filter_size) {
+			ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+			chunks[chunks_nr].id = GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTERS;
+			chunks[chunks_nr].size = ctx->mpbfctx.total_filter_size;
+			chunks[chunks_nr].write_fn = write_graph_chunk_modified_path_bloom_filters;
+			chunks_nr++;
+		}
 		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 		chunks[chunks_nr].id = GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX;
 		chunks[chunks_nr].size = sizeof(uint8_t) +
-- 
2.27.0.rc1.431.g5c813f95dc

