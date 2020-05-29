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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E88C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF8620723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUUcHuct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgE2IvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgE2IvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F031EC08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:12 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so2625210wru.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSLeKvlclJG8zvTmUNsJgF/OSsfTGEM3yhZ9lBbV2kM=;
        b=nUUcHuctVCNXEQoauEaTVwgtUbYCqXOMLwtVLLUjsnxYwec/LLFUHnd7Qb5rGmnse2
         khcpglxy38mIE3wdJfyK3crn8EVv47wpA+O+fsEtxJd8FJTkzwTjnheUGEMCFtBPWOs/
         TJwLYAJngAG97RxF+JUVW5fkgw2wlUs+bzcNs+H6TuLDzMxx4dWUN6GMphu1B09Is3LM
         BNHvea7t86gUftDaL8vECtB4fx/VPT46QTfFXse9DCM3zaiywtsMmD4QpOBlKoXVUK38
         f4Qt390ahEI6nbh/eamSURGgxoMpAtx8lxlZPQB95KitUcaL6F6U2r/eSwLWuHQoEXkB
         v1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSLeKvlclJG8zvTmUNsJgF/OSsfTGEM3yhZ9lBbV2kM=;
        b=cx3ky8l+dfiPFeq8PIhAGyNzgAQw8rfzvZxQr6OP4XFQnI0mTo1GLcYxaD+opz4zx/
         8LHaI3ZrR+/1lYPtdH6IiflnMB6ZB+1tDLewUQHoyE8ouuDXS3qd3QfppmSPqCMv0s3C
         Wq/SznXXifD+IBbO7oz1O0jkH0ggyUmL4jjtbSV9w3uPDEJ2MokywQpegeyy2l4AkBNY
         Nft/6JwCcc23lsPE5RfwbTmI/ILrp8K23aDSWk4qjxETGlSfzz4u2A2xWGeTjeSQkGRV
         hS/93XpPRYGQ5sAnrhSbsZVqTz9xbJ9CY5GLMamB1p7GinWNKI8NVhg8WCkNZOc8qJJk
         WZ2A==
X-Gm-Message-State: AOAM532ntN74V/bO/Hf/j8xYWdtScqUBJdAgukM9gtLRMdoEpAXGVLlQ
        ik8DLAzN0WSx3tA4nsV9HmKkW0nF
X-Google-Smtp-Source: ABdhPJzWyr6ywqAGxZLyuPbaAUff/CzB3Z7AlVFCqjh2ZegAcKNzqDPj+Eee8TFb+KHwNe8CDz9jtg==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr8297197wru.210.1590742271436;
        Fri, 29 May 2020 01:51:11 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:10 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/34] commit-graph: simplify write_commit_graph_file() #2
Date:   Fri, 29 May 2020 10:50:14 +0200
Message-Id: <20200529085038.26008-11-szeder.dev@gmail.com>
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

Unify the 'chunk_ids' and 'chunk_sizes' arrays into an array of
'struct chunk_info'.  This will allow more cleanups in the following
patches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 416f4b2468..d95c739c10 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1344,14 +1344,18 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
+struct chunk_info {
+	uint32_t id;
+	uint64_t size;
+};
+
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
 	int fd;
 	struct hashfile *f;
 	struct lock_file lk = LOCK_INIT;
-	uint32_t chunk_ids[6];
-	uint64_t chunk_sizes[6];
+	struct chunk_info chunks[6];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
@@ -1394,25 +1398,25 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}
 
-	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
-	chunk_sizes[0] = GRAPH_FANOUT_SIZE;
-	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_sizes[1] = hashsz * ctx->commits.nr;
-	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
+	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
+	chunks[0].size = GRAPH_FANOUT_SIZE;
+	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
+	chunks[1].size = hashsz * ctx->commits.nr;
+	chunks[2].id = GRAPH_CHUNKID_DATA;
+	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
 	if (ctx->num_extra_edges) {
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
-		chunk_sizes[3] = 4 * ctx->num_extra_edges;
+		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
+		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
-		chunk_sizes[4] = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
+		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
 		num_chunks++;
 	}
 
-	chunk_ids[num_chunks] = 0;
-	chunk_sizes[num_chunks] = 0;
+	chunks[num_chunks].id = 0;
+	chunks[num_chunks].size = 0;
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
@@ -1425,12 +1429,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	for (i = 0; i <= num_chunks; i++) {
 		uint32_t chunk_write[3];
 
-		chunk_write[0] = htonl(chunk_ids[i]);
+		chunk_write[0] = htonl(chunks[i].id);
 		chunk_write[1] = htonl(chunk_offset >> 32);
 		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
 		hashwrite(f, chunk_write, 12);
 
-		chunk_offset += chunk_sizes[i];
+		chunk_offset += chunks[i].size;
 	}
 
 	if (ctx->report_progress) {
-- 
2.27.0.rc1.431.g5c813f95dc

