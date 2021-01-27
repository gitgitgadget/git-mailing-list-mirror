Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057EEC433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EC207FC
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhA0PGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhA0PCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA2C061353
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:03 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g10so2262039wrx.1
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IVxpJhxwjfihzysiEtTywlKgWec7iN7UTRxTl4Cf+Tw=;
        b=RfUbmthH2r8av4PEryiLNPOSnXdpOewtMxRDd29dV6ejhr9lDjy9x/alvM4IoeHaXI
         qpKkyg590s7UPMdTci5o5+yVLiAyM6w61HKnh1GnwKYXyPUF4PtMVZ62mlCwSEmA2S7r
         vSSgDJZZOHHpR20gLK+/A2nvsXhOUuAuBPEV9p0cXfMYqkp93EyJ3jd6d+QF5Siomt8g
         1mBKjS6SucaaqHyQvLvh7xkf1rfrKklss+WZfj2sPO0LsS0ZRvoUvmwSCRjX8qpYWOwz
         s1BS/xStL2MBvuamz54icNSiAlZyv3NuTIdYd4+ktXhAjNlrb8+8Madr+eJ1nzUhXWL9
         VXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IVxpJhxwjfihzysiEtTywlKgWec7iN7UTRxTl4Cf+Tw=;
        b=tixK2OFM96SUWkCpyVG9zIyT3Re1S1hVgDRTCUwktuvWAWID23knpOdurCYF7u5qTU
         CaGehA3hk3xSnCXY/2Cb284tYnQ8lcfCIWIqyMFV03QnzwQQobK0fNpxxowWAindJgN1
         wxBzMjZ2H/GIJsGAA3XOCSLPt4b9rmj7c25jEbbxnAGmqBsnDc1nWOR9n517VfN+Cp2g
         1neUALbWktoGtGVtNP4ULnJK2BBOEKmLwWFf0hR0oTDz7Uf8EfqTQja4KXOkCDKZ84qo
         9dX+izLnymjZWYkslhI+JKmOGC+QovdkoUmU3X8rTY92SxvzhgQm4HdikNNBI7Y21tSL
         JLlQ==
X-Gm-Message-State: AOAM531DphE51DC6swpUyy+OTpXIWugpnQwU7ASn2sO18ShJI/IuoUK5
        FJBga/qrVtUuoNNMKE8zMbZA7zqBUKI=
X-Google-Smtp-Source: ABdhPJz6xiDkbMLK9EUSaRLYYSY4ji6q4FqGu4EaRy+ipwQUmJNWQGf4wTZMXgnqQAPzPXpW8OS08w==
X-Received: by 2002:a5d:6588:: with SMTP id q8mr11675022wru.294.1611759721856;
        Wed, 27 Jan 2021 07:02:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23sm2717182wmc.35.2021.01.27.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:00 -0800 (PST)
Message-Id: <70af6e3083f4f5e2b921c1c9817c790c8b5f66ce.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:42 +0000
Subject: [PATCH v2 03/17] commit-graph: use chunk-format write API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph write logic is ready to make use of the chunk-format
write API. Each chunk write method is already in the correct prototype.
We only need to use the 'struct chunkfile' pointer and the correct API
calls.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 118 ++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 81 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fae7d1b6393..ba33777dcb8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,7 @@
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
+#include "chunk-format.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
@@ -1758,27 +1759,17 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
-typedef int (*chunk_write_fn)(struct hashfile *f,
-			      void *data);
-
-struct chunk_info {
-	uint32_t id;
-	uint64_t size;
-	chunk_write_fn write_fn;
-};
-
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
 	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	struct chunk_info chunks[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
-	uint64_t chunk_offset;
 	struct object_id file_hash;
+	struct chunkfile *cf;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1824,76 +1815,50 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}
 
-	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
-	chunks[0].size = GRAPH_FANOUT_SIZE;
-	chunks[0].write_fn = write_graph_chunk_fanout;
-	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
-	chunks[1].size = hashsz * ctx->commits.nr;
-	chunks[1].write_fn = write_graph_chunk_oids;
-	chunks[2].id = GRAPH_CHUNKID_DATA;
-	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
-	chunks[2].write_fn = write_graph_chunk_data;
+	cf = init_chunkfile(f);
+
+	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT,
+		  write_graph_chunk_fanout, GRAPH_FANOUT_SIZE);
+	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP,
+		  write_graph_chunk_oids, hashsz * ctx->commits.nr);
+	add_chunk(cf, GRAPH_CHUNKID_DATA,
+		  write_graph_chunk_data, (hashsz + 16) * ctx->commits.nr);
 
 	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
 		ctx->write_generation_data = 0;
-	if (ctx->write_generation_data) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA;
-		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
-		chunks[num_chunks].write_fn = write_graph_chunk_generation_data;
-		num_chunks++;
-	}
-	if (ctx->num_generation_data_overflows) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW;
-		chunks[num_chunks].size = sizeof(timestamp_t) * ctx->num_generation_data_overflows;
-		chunks[num_chunks].write_fn = write_graph_chunk_generation_data_overflow;
-		num_chunks++;
-	}
-	if (ctx->num_extra_edges) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
-		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
-		chunks[num_chunks].write_fn = write_graph_chunk_extra_edges;
-		num_chunks++;
-	}
+	if (ctx->write_generation_data)
+		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
+			  write_graph_chunk_generation_data,
+			  sizeof(uint32_t) * ctx->commits.nr);
+	if (ctx->num_generation_data_overflows)
+		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+			  write_graph_chunk_generation_data_overflow,
+			  sizeof(timestamp_t) * ctx->num_generation_data_overflows);
+	if (ctx->num_extra_edges)
+		add_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES,
+			  write_graph_chunk_extra_edges,
+			  4 * ctx->num_extra_edges);
 	if (ctx->changed_paths) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
-		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
-		chunks[num_chunks].write_fn = write_graph_chunk_bloom_indexes;
-		num_chunks++;
-		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
-		chunks[num_chunks].size = sizeof(uint32_t) * 3
-					  + ctx->total_bloom_filter_data_size;
-		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
-		num_chunks++;
-	}
-	if (ctx->num_commit_graphs_after > 1) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
-		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
-		chunks[num_chunks].write_fn = write_graph_chunk_base;
-		num_chunks++;
-	}
-
-	chunks[num_chunks].id = 0;
-	chunks[num_chunks].size = 0;
+		add_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+			  write_graph_chunk_bloom_indexes,
+			  sizeof(uint32_t) * ctx->commits.nr);
+		add_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
+			  write_graph_chunk_bloom_data,
+			  sizeof(uint32_t) * 3
+				+ ctx->total_bloom_filter_data_size);
+	}
+	if (ctx->num_commit_graphs_after > 1)
+		add_chunk(cf, GRAPH_CHUNKID_BASE,
+			  write_graph_chunk_base,
+			  hashsz * (ctx->num_commit_graphs_after - 1));
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
 	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, get_num_chunks(cf));
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
-	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunks[i].id);
-		chunk_write[1] = htonl(chunk_offset >> 32);
-		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
-
-		chunk_offset += chunks[i].size;
-	}
-
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
 			    Q_("Writing out commit graph in %d pass",
@@ -1905,17 +1870,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			num_chunks * ctx->commits.nr);
 	}
 
-	for (i = 0; i < num_chunks; i++) {
-		uint64_t start_offset = f->total + f->offset;
-
-		if (chunks[i].write_fn(f, ctx))
-			return -1;
-
-		if (f->total + f->offset != start_offset + chunks[i].size)
-			BUG("expected to write %"PRId64" bytes to chunk %"PRIx32", but wrote %"PRId64" instead",
-			    chunks[i].size, chunks[i].id,
-			    f->total + f->offset - start_offset);
-	}
+	write_chunkfile(cf, ctx);
 
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
@@ -1932,6 +1887,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	close_commit_graph(ctx->r->objects);
 	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	free_chunkfile(cf);
 
 	if (ctx->split) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
-- 
gitgitgadget

