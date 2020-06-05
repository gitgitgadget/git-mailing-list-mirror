Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC8C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44287206DB
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukEH8uwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgFENA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgFENAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2CC08C5C7
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x13so9673055wrv.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=px9NT5jC+M41wwnbV/pfr/TjhxWSjfbaku59YW5MCDA=;
        b=ukEH8uwQkJMGqbvqxdjXUjSJntRoTx/CphiarfyTIEHRbnn0LxsZ7P2e8dOh9TkUVC
         mH4ssg8aAJj0YLiLOlXpsqjy8onI+4bKKmYVAHRzVoV6B2jX3/kfms/1ud7I1nruueyE
         2D/oG8M18aPQVcr/0sJTEsz1ywcdSDj9q1szWotBE0XuHWwEd71A6T4tDQtrQYS3xnor
         gazisQgdNT+XHZztz/3TYlQTlcm38Ngrvl2fRHK8ITnC4FBk/RMuSV24mN1LyJxR9e3s
         W1PATn07Qe1whc3VFvhH1OtDJwkZ4bPkN8HEql45pCXQYE51qmjrwPe711DyOSI/5Ws2
         00MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=px9NT5jC+M41wwnbV/pfr/TjhxWSjfbaku59YW5MCDA=;
        b=QCnnO+Zha8CnSAWn9Qd3bZdQdNHIfsrA6OFtjex4gN7zly/17ldcCztLk3vaI5RYip
         fA+c53HRfTpfrAZX56cMidY8tkrtpWHSAVAw7lHg/jelqpg/H3mz+/2jnd9z0Bo2Hnmg
         b9ffK77bNq4gRaRPt4dbBzAj6J2Ug22KvoN4fz8RUlKgEcT6YAGdBRzBz4huPUTa3445
         XL6qyQi+s4Q5oXtx5rwRwTE5ZMUhH2vgessVv/L4kV6Lx+yMf1ZdJrIBEH/Sn2U2vnYE
         GQuXmHx89UpiCpBG/TKlh6SMm4Rwq4kkSjwdPjr48IcKZ2TdUj4Z6kixcB4KA+sFo9Zg
         Jxbw==
X-Gm-Message-State: AOAM533N26Hu5OZF47bk13t4bxdyeEnu+/FyKM/iGx4p9HNaA8h9no4U
        a2Ng8yebcB4Kn6PyqEbQF9N4O1IM
X-Google-Smtp-Source: ABdhPJyscv8/eEF6dnxZA3AWovxIAp1mFnyoeUviU57IXbnfUSgmjLDPN5LRR7pFo5049+8GDshWTA==
X-Received: by 2002:a05:6000:1185:: with SMTP id g5mr10320241wrx.39.1591362044549;
        Fri, 05 Jun 2020 06:00:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm12093457wrs.43.2020.06.05.06.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:44 -0700 (PDT)
Message-Id: <9b818b9cb9128d19f3ce6087cb34cdf4dd601977.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:31 +0000
Subject: [PATCH 09/10] commit-graph: simplify write_commit_graph_file() #1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, jnareb@gmail.com,
        peff@peff.net, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In write_commit_graph_file() one block of code fills the array of
chunk IDs, another block of code fills the array of chunk offsets,
then the chunk IDs and offsets are written to the Chunk Lookup table,
and finally a third block of code writes the actual chunks.  In case
of optional chunks like Extra Edge List and Base Graphs List there is
also a condition checking whether that chunk is necessary/desired, and
that same condition is repeated in all those three blocks of code.
This patch series is about to add more optional chunks, so there would
be even more repeated conditions.

Those chunk offsets are relative to the beginning of the file, so they
inherently depend on the size of the Chunk Lookup table, which in turn
depends on the number of chunks that are to be written to the
commit-graph file.  IOW at the time we set the first chunk's ID we
can't yet know its offset, because we don't yet know how many chunks
there are.

Simplify this by initially filling an array of chunk sizes, not
offsets, and calculate the offsets based on the chunk sizes only
later, while we are writing the Chunk Lookup table.  This way we can
fill the arrays of chunk IDs and sizes in one go, eliminating one set
of repeated conditions.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 84206f0f512..79cddabcd12 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1529,10 +1529,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
-	uint64_t chunk_offsets[MAX_NUM_CHUNKS + 1];
+	uint64_t chunk_sizes[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
+	uint64_t chunk_offset;
 	struct object_id file_hash;
 	const struct bloom_filter_settings bloom_settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
@@ -1573,50 +1574,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_sizes[0] = GRAPH_FANOUT_SIZE;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_sizes[1] = hashsz * ctx->commits.nr;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
+
 	if (ctx->num_extra_edges) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
+		chunk_sizes[num_chunks] = 4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->changed_paths) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
+		chunk_sizes[num_chunks] = sizeof(uint32_t) * ctx->commits.nr;
 		num_chunks++;
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
+		chunk_sizes[num_chunks] = sizeof(uint32_t) * 3
+					  + ctx->total_bloom_filter_data_size;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
+		chunk_sizes[num_chunks] = hashsz * (ctx->num_commit_graphs_after - 1);
 		num_chunks++;
 	}
 
 	chunk_ids[num_chunks] = 0;
-
-	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
-	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
-	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
-
-	num_chunks = 3;
-	if (ctx->num_extra_edges) {
-		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						4 * ctx->num_extra_edges;
-		num_chunks++;
-	}
-	if (ctx->changed_paths) {
-		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						sizeof(uint32_t) * ctx->commits.nr;
-		num_chunks++;
-
-		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						sizeof(uint32_t) * 3 + ctx->total_bloom_filter_data_size;
-		num_chunks++;
-	}
-	if (ctx->num_commit_graphs_after > 1) {
-		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						hashsz * (ctx->num_commit_graphs_after - 1);
-		num_chunks++;
-	}
+	chunk_sizes[num_chunks] = 0;
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
@@ -1625,13 +1610,16 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
+	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
 
 		chunk_write[0] = htonl(chunk_ids[i]);
-		chunk_write[1] = htonl(chunk_offsets[i] >> 32);
-		chunk_write[2] = htonl(chunk_offsets[i] & 0xffffffff);
+		chunk_write[1] = htonl(chunk_offset >> 32);
+		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
 		hashwrite(f, chunk_write, 12);
+
+		chunk_offset += chunk_sizes[i];
 	}
 
 	if (ctx->report_progress) {
-- 
gitgitgadget

