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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14894C43219
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87C164EB8
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhBRQon (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhBROI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8FC06178C
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a4so900426wro.8
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A0mjRAGwx9qw7No/M0C4XtAhKDwaCLfcwX8f2+rRN6o=;
        b=ovwkXL1KYK9BOvFqq4w7tspwhdv8imP5JIgReKugwJa8tbDTQmC56sucfNnhoLkvuf
         onXlm1TbcvlLSEKfIvGCuZzmDCc+g+LVoFNK7unzAnk1A5yEhp3ztsWb7QJttHvoqZbO
         fPQcz+S3Ub4hEttiJ8xM+d8Zz8pNXGkiW4AvbQzhq3fhUViEBj+fKsfWerjerbYdi9J0
         lLPFTTdh1H2949qk425nYizVBBrRaBn5+4CmFz1V7L14Z3TwAS0VbqCXWcOarC/lZaPD
         LFAK9b9QdKM6wNqCrkMjlnv5h3+x7z3hx4eZf9OcD4MIlF0N6coLFXdssgFtbgJTqnMF
         Yz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A0mjRAGwx9qw7No/M0C4XtAhKDwaCLfcwX8f2+rRN6o=;
        b=X3viQ7+tW76hCk+5OzaVMChzIxBrdXJ//n2Wj+FDM5jHhOu64fyCezQxL5Z4z8vPWn
         WrM4CgaTN9BwD9Ho03x97Bvt++LoRxFAs2lah31/3UnGlK5DJLdFoV0vBU/Ea5FmNMF/
         2SY3Nc3dbW7zbXQbs9hxuIGKqaGTUHj9cA+AxAq2i0qSD5OQzESG0tK98mZ4zP82kES4
         6F+0GeKty+owZcd3z0xu+JwjOMj2Z84HMgBf73CJNQ2rNUEzX9YMf5qFjjhX+2+ide6B
         5FdL38iel66NH9IR23KBS+SktIvo2cJmGAlVH3srjcJxcTbEPdnqWqn7RIRcitF4NZum
         cnOA==
X-Gm-Message-State: AOAM530rz0qsIO/z3i5v0TlkWkFlDM9qD/sMD2RmAvblr+lWEsWotsiA
        h2niphmc2g43ffviqIIravRBswfCyjc=
X-Google-Smtp-Source: ABdhPJwPs0EUua+MnAETVYK6zcXLEg1Gf0PqMneS0bqE9HbTjGACb7jt6PxceaANJTZCGAq3DtKTZQ==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr4598726wru.300.1613657264702;
        Thu, 18 Feb 2021 06:07:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b2sm9593682wrn.2.2021.02.18.06.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:44 -0800 (PST)
Message-Id: <ddebf2389880e14a332e354f7b1dbc86a3964985.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:25 +0000
Subject: [PATCH v4 03/17] commit-graph: use chunk-format write API
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
 commit-graph.c | 119 +++++++++++++++----------------------------------
 1 file changed, 37 insertions(+), 82 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index fae7d1b63931..a889130cc849 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,7 @@
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
+#include "chunk-format.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
@@ -44,7 +45,6 @@ void git_test_write_commit_graph_or_die(void)
 #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
 #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
-#define MAX_NUM_CHUNKS 9
 
 #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
 
@@ -1758,27 +1758,17 @@ static int write_graph_chunk_base(struct hashfile *f,
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
@@ -1824,76 +1814,50 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
+	add_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, GRAPH_FANOUT_SIZE,
+		  write_graph_chunk_fanout);
+	add_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, hashsz * ctx->commits.nr,
+		  write_graph_chunk_oids);
+	add_chunk(cf, GRAPH_CHUNKID_DATA, (hashsz + 16) * ctx->commits.nr,
+		  write_graph_chunk_data);
 
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
+			  sizeof(uint32_t) * ctx->commits.nr,
+			  write_graph_chunk_generation_data);
+	if (ctx->num_generation_data_overflows)
+		add_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+			  sizeof(timestamp_t) * ctx->num_generation_data_overflows,
+			  write_graph_chunk_generation_data_overflow);
+	if (ctx->num_extra_edges)
+		add_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES,
+			  4 * ctx->num_extra_edges,
+			  write_graph_chunk_extra_edges);
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
+			  sizeof(uint32_t) * ctx->commits.nr,
+			  write_graph_chunk_bloom_indexes);
+		add_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
+			  sizeof(uint32_t) * 3
+				+ ctx->total_bloom_filter_data_size,
+			  write_graph_chunk_bloom_data);
+	}
+	if (ctx->num_commit_graphs_after > 1)
+		add_chunk(cf, GRAPH_CHUNKID_BASE,
+			  hashsz * (ctx->num_commit_graphs_after - 1),
+			  write_graph_chunk_base);
 
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
@@ -1905,17 +1869,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
@@ -1932,6 +1886,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	close_commit_graph(ctx->r->objects);
 	finalize_hashfile(f, file_hash.hash, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
+	free_chunkfile(cf);
 
 	if (ctx->split) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
-- 
gitgitgadget

