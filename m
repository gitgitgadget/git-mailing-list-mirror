Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26EC433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4832920723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrbSnns7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgE2IvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgE2IvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA898C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so2501483wrn.11
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aa09xbF1s6CPu0fooG6l3ZNN6OOcSLl+f/MT/1t9fzo=;
        b=NrbSnns7XGCd3f5VGLNccKufytHLcg8FcQ/pT/3wlx0cAjEAUi0MH4+HAJ0/ZAZL4n
         kWLhClzlTGNHsIyHH5z5bzbg2KOFghVmgYfxqJ1myyVUX3bB21Y3JCWKAPOmJz2BFdUj
         UtSQJ5ZRpm0mC7mZ0mOv/p9tl2LP5/EiTHhB56R12iqOJyYL5xKCQ5zwlRa9LJRgtwqR
         f0N03b7UZVcp+ZO4Ig3nbcz4vZ3+Tt1uXb5lXAormV9TOh2hwZH4j2qGAO1RayGIjsu6
         P0zAcc9I9um/DvgbyFeBkK9tM5oj+SGPqIs6SzC9iYDznsOKIzPJWJUhV0K1ThZ+rAxM
         9vCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aa09xbF1s6CPu0fooG6l3ZNN6OOcSLl+f/MT/1t9fzo=;
        b=YGB07IGP/u4cTAu3i1vZv/M/HiNxzBQTNu8NIamlQxRaukh9/SqDaYyRj7wD2rk1xu
         c190lBnjf1HPTO5UIe6jCXaKRIpN+5kJ7wLs1FabpmtIsEKO68r9woRklBySJdiryRgH
         b8Nx6xdSIGIbUamMTcHd0knShY0x1zZfzy3VjIARZLDjGiXJ8ht9F+y+6UR/YXLHH0CG
         e5OJsVdZRO1m9WHaEqQZ5XlSeTAaNs+nczq9jm/W9vNvu4ejLDvMfaUzJckuNBV5PecP
         iSs1PsWenacCkEmues+MN7ijzAVVxVQ9nyBc7yz6BC/3WX3/zH7yoDqnYL0b+CMYCD7L
         baHw==
X-Gm-Message-State: AOAM530zqxxQCu3JYWdIiR+tEMrw7SxHUyXZCYa5fO/wS7SUtOvqOM3h
        7loY+WQDwiCypG3luQqWtovN46IV
X-Google-Smtp-Source: ABdhPJyhV68CbBUUYa7qMwo3P13VLjFkkBY0ubc6QvT3cJsi4JqgQr2aw1Ij2+K8E25W0nXnQgN2NQ==
X-Received: by 2002:adf:f882:: with SMTP id u2mr8164739wrp.40.1590742269814;
        Fri, 29 May 2020 01:51:09 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:09 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 09/34] commit-graph: simplify write_commit_graph_file() #1
Date:   Fri, 29 May 2020 10:50:13 +0200
Message-Id: <20200529085038.26008-10-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
---
 commit-graph.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f64b1c01a8..416f4b2468 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1351,10 +1351,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
 	uint32_t chunk_ids[6];
-	uint64_t chunk_offsets[6];
+	uint64_t chunk_sizes[6];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
+	uint64_t chunk_offset;
 	struct object_id file_hash;
 
 	if (ctx->split) {
@@ -1394,35 +1395,24 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	}
 
 	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
+	chunk_sizes[0] = GRAPH_FANOUT_SIZE;
 	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
+	chunk_sizes[1] = hashsz * ctx->commits.nr;
 	chunk_ids[2] = GRAPH_CHUNKID_DATA;
+	chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
 	if (ctx->num_extra_edges) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
+		chunk_sizes[3] = 4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
+		chunk_sizes[4] = hashsz * (ctx->num_commit_graphs_after - 1);
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
-	if (ctx->num_commit_graphs_after > 1) {
-		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
-						hashsz * (ctx->num_commit_graphs_after - 1);
-		num_chunks++;
-	}
+	chunk_sizes[num_chunks] = 0;
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
@@ -1431,13 +1421,16 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
2.27.0.rc1.431.g5c813f95dc

