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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5959C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AEF20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwlSmuDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgE2IvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgE2IvP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20632C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so2488140wru.12
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AwbeNjCGkrC2eS1uZk0En1qi4xz1nodTJdEFIybPKA=;
        b=BwlSmuDNLImKRYU7La69Brv2yUw3T4+oTc+ZZdYEopSF83hUo7yV4Zs2gAnkqxNjph
         IWVqtoMf1PLkQwp+xdA/+kTBCqNWkJ8ZGMO0q8t423VNw/HC/NaTF7V+pumAHZ+GwauS
         aW9Uh0F0ujNrCOW+VFtw48sn/9WgSTOXG7gAbCxYXvTTge44wCmZ+YmgJJ2aYRr6gUBA
         Rt4cUNxY3E/gNYKKPnYfhaOdp0zZcEyufUQacwbUq+MIwwrqrlUUY6oa14WS9xIMNTrR
         rMUyUr/rd2w40tfdwnCpPCNKRWRJMWCXNTYtk/DWxK944HnVqa9Bx7VqaonKSwZZ5EVo
         AAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AwbeNjCGkrC2eS1uZk0En1qi4xz1nodTJdEFIybPKA=;
        b=skNBBVEQYwVStOgr5+cOC5dD7KTahzPuLHHgHWVHUjKq4tPPPgKJ59SULsn4NfZbDt
         KUumZ/7RX2bi2w2kJAtt3+ho39jac8DVmosruwXY1sgiWOOa5e/PDi6muzwIGpSmMbmq
         nkSrqrjIndqS+w/8ioFPomBEC3K3w+JshpyS7bWOmWNGhx5ACk30k5YV4qogMhi2fCS5
         Nb+1Mv3DCgX0Vz0gx2xoeDA8zDeNAlrtUH2A0S8rrToUVK0MZldPsHHvl3FHYID97K7k
         4DGdzkr9J9paIokoSFDtFx/c63gQJZtsnVCYVPPrlAeISnh49JPryaYxKg2P7UJnm3we
         YxvA==
X-Gm-Message-State: AOAM533m0kcXk+H25s5thEnrWQv4LcfnLLuWDS6ksE2G5RS+c05XxYvS
        yH8Ec/umP6OuWQE53hF77JL5gIbg
X-Google-Smtp-Source: ABdhPJwptIIUucDuaePpfZNNYJtCWIC1BUG3fn9SFPgfCNVX9REW/XNlnjBGykZvA7oyT7R7fII9nQ==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr8187491wrx.128.1590742273432;
        Fri, 29 May 2020 01:51:13 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 11/34] commit-graph: allocate the 'struct chunk_info' array dinamically
Date:   Fri, 29 May 2020 10:50:15 +0200
Message-Id: <20200529085038.26008-12-szeder.dev@gmail.com>
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

During writing a new commit-graph file, the size of the 'struct
chunk_info' array is hardcoded to be the maximum number of possible
chunks plus one for the terminating label.  This array size must be
adjusted each time when a new chunk is added, which can be easily
forgotten.

So let's make the constant-sized 'struct chunk_info' array an
ALLOC_GROW()-able array instead.

There are a couple of cases where writing a new commit-graph file
returns with error; those spots were adjusted to free the dinamically
allocated 'struct chunk_info' array.

Arguably the several ALLOC_GROW() call sites look unusal, because we
usually call ALLOC_GROW() in loops, once in each iteration...
However, this way anyone who adds a new chunk will notice that they
have to cargo-cult the ALLOC_GROW() call as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 74 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d95c739c10..c8ba17e457 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1355,12 +1355,13 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	struct chunk_info chunks[6];
+	struct chunk_info *chunks = NULL;
+	int chunks_nr = 0, chunks_alloc = 0;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
-	int num_chunks = 3;
 	uint64_t chunk_offset;
 	struct object_id file_hash;
+	int ret = 0;
 
 	if (ctx->split) {
 		struct strbuf tmp_file = STRBUF_INIT;
@@ -1398,35 +1399,48 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}
 
-	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
-	chunks[0].size = GRAPH_FANOUT_SIZE;
-	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
-	chunks[1].size = hashsz * ctx->commits.nr;
-	chunks[2].id = GRAPH_CHUNKID_DATA;
-	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
+	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+	chunks[chunks_nr].id = GRAPH_CHUNKID_OIDFANOUT;
+	chunks[chunks_nr].size = GRAPH_FANOUT_SIZE;
+	chunks_nr++;
+	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+	chunks[chunks_nr].id = GRAPH_CHUNKID_OIDLOOKUP;
+	chunks[chunks_nr].size = hashsz * ctx->commits.nr;
+	chunks_nr++;
+	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+	chunks[chunks_nr].id = GRAPH_CHUNKID_DATA;
+	chunks[chunks_nr].size = (hashsz + 16) * ctx->commits.nr;
+	chunks_nr++;
 	if (ctx->num_extra_edges) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
-		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
-		num_chunks++;
+		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+		chunks[chunks_nr].id = GRAPH_CHUNKID_EXTRAEDGES;
+		chunks[chunks_nr].size = 4 * ctx->num_extra_edges;
+		chunks_nr++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
-		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
-		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
-		num_chunks++;
+		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+		chunks[chunks_nr].id = GRAPH_CHUNKID_BASE;
+		chunks[chunks_nr].size = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks_nr++;
 	}
 
-	chunks[num_chunks].id = 0;
-	chunks[num_chunks].size = 0;
+	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
+	chunks[chunks_nr].id = 0;
+	chunks[chunks_nr].size = 0;
+	/*
+	 * Do not increase 'chunks_nr', so it still reflects the number of
+	 * actual chunks, without the Chunk Lookup table's terminating label.
+	 */
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
 	hashwrite_u8(f, GRAPH_VERSION);
 	hashwrite_u8(f, oid_version());
-	hashwrite_u8(f, num_chunks);
+	hashwrite_u8(f, chunks_nr);
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
-	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	for (i = 0; i <= num_chunks; i++) {
+	chunk_offset = 8 + (chunks_nr + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
+	for (i = 0; i <= chunks_nr; i++) {
 		uint32_t chunk_write[3];
 
 		chunk_write[0] = htonl(chunks[i].id);
@@ -1441,11 +1455,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		strbuf_addf(&progress_title,
 			    Q_("Writing out commit graph in %d pass",
 			       "Writing out commit graph in %d passes",
-			       num_chunks),
-			    num_chunks);
+			       chunks_nr),
+			    chunks_nr);
 		ctx->progress = start_delayed_progress(
 			progress_title.buf,
-			num_chunks * ctx->commits.nr);
+			chunks_nr * ctx->commits.nr);
 	}
 	write_graph_chunk_fanout(f, ctx);
 	write_graph_chunk_oids(f, hashsz, ctx);
@@ -1454,7 +1468,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		write_graph_chunk_extra_edges(f, ctx);
 	if (ctx->num_commit_graphs_after > 1 &&
 	    write_graph_chunk_base(f, ctx)) {
-		return -1;
+		ret = -1;
+		goto cleanup;
 	}
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
@@ -1481,7 +1496,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		if (!chainf) {
 			error(_("unable to open commit-graph chain file"));
-			return -1;
+			ret = -1;
+			goto cleanup;
 		}
 
 		if (ctx->base_graph_name) {
@@ -1493,7 +1509,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 				if (result) {
 					error(_("failed to rename base commit-graph file"));
-					return -1;
+					ret = -1;
+					goto cleanup;
 				}
 			}
 		} else {
@@ -1513,13 +1530,16 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		if (result) {
 			error(_("failed to rename temporary commit-graph file"));
-			return -1;
+			ret = -1;
+			goto cleanup;
 		}
 	}
 
 	commit_lock_file(&lk);
 
-	return 0;
+cleanup:
+	free(chunks);
+	return ret;
 }
 
 static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
-- 
2.27.0.rc1.431.g5c813f95dc

