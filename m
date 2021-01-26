Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1250BC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8522207B3
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404736AbhAZQDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404169AbhAZQC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B906C0610D6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so17006642wrx.4
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=97irUJYECDLVWkK+k5eog9vFuUY3oDEfcKFZppunCQ0=;
        b=Hk3gFV8FhEpIFW9/fHV+GH7DrhvoDElsDHak4DEnvncPXQALxOku51Sv9pyH8o2dzw
         16L4NGloOWUHoREFOqkMuD9faff9e2ucqT3skj9tYfim04h4NSCm41NxHkogrySXGS7S
         Gds9aycG+Uqulg/hHyxF/wT76oyzstbHcWC/8VcfamO4VTBAk18k/lW/0ApOzmf9GPri
         GlhMM32tc8KDUHqLG70gtZm7Mc65dglHF9YUvJ+GfMIkgQ1yyf3yamtfBikGpioUFZiY
         9w98vwPDIkp9CQdOJrbmYTrzOw+Zim8W8wa3I5N8Cgbr8wvkb9TNBm1j8TJP+WSYF5mO
         FPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=97irUJYECDLVWkK+k5eog9vFuUY3oDEfcKFZppunCQ0=;
        b=Vi0ilwYp32/YBhFXi5QZ4vQyHLnQv47QUdyih5bEzVWgKUR3lIHd9wDCi4xFHSDkip
         imkgydHmXZievGZB8sVWrxnzj5uwDf+eXXEZqdois4t57GaTdfXgC2RyPInrcCE9iAnR
         hDQxrrfL7lZuxn2P15FK0rf0YWGq1yvDDB08XO2jINOUM0ETHm5ZDF5Z5sLKygQJWawK
         8ZJ0P71uyKJhPAyq3OhAK2fU5nv1y5Z17x8k6er4QWDckTst2kVG9Pkv0LqANpjUonn6
         p9bndLe/wqfDMdh00uzQB65oZJ8fxqQ+354fr/XtRnkg0pCldB/aw32InkVCMCnI5fv0
         POuA==
X-Gm-Message-State: AOAM532Mu37zEk+C2El55eV7ojdyqrhFhFJIEFRxPX5zln2r3j3a7HZj
        8TrgrZOzZxaRwLUglOAznTSFb1I79jY=
X-Google-Smtp-Source: ABdhPJwSXzu06mgdab8eo9kHOMEACaEAijcXod1ecXz3CDM7i84LQbB69sFQbd5BeSX8UDOWwRtHAA==
X-Received: by 2002:adf:9148:: with SMTP id j66mr7159766wrj.28.1611676890874;
        Tue, 26 Jan 2021 08:01:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1sm28068267wrl.95.2021.01.26.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:30 -0800 (PST)
Message-Id: <a3d6177a352643721fdc07512629b48d1213157a.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:12 +0000
Subject: [PATCH 03/17] commit-graph: use chunk-format write API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
index b26ed72396e..b2c0f233eab 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,7 @@
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
+#include "chunk-format.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
@@ -1767,27 +1768,17 @@ static int write_graph_chunk_base(struct hashfile *f,
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
@@ -1833,76 +1824,50 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -1914,17 +1879,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -1941,6 +1896,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	close_commit_graph(ctx->r->objects);
 	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	free_chunkfile(cf);
 
 	if (ctx->split) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
-- 
gitgitgadget

