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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519FCC433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B8B20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCzW2HZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2IvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgE2IvS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AB5C08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k26so2435108wmi.4
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pxj6OC6L7CyhCiORkdwWsxjGstpQzlhALBp4zedrXEQ=;
        b=mCzW2HZ8Mf+NX19aBxAl2RUm+U/0SczJC2b95J69rg9oMtX9PP28LJEmPwPpPISVWm
         2SbFQIlyrCNWT78Ju6U1LVziARY1pH9oAespH9E9hf6uO/1ahRvnCFWE3GwL3FgV+PkV
         WMGZhGjiRSaOoFbIHABSYJlYP2ddfmH7lUW8cAGM+H427R3U4jOP+ZnwaXhUF8FNECzo
         COAlu+XNi+cc2hhyE8Wk7/JlCK8WQWZniQICyn04PPI3LYjD8EgbaNN3j/4rcodYlgX9
         ph9TAvOL6qiUrddK4zN9qXiX23cAynSnQPc/Kt9CB94jJqmWrZNpCO/yNtxxaCSLiNI2
         IDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pxj6OC6L7CyhCiORkdwWsxjGstpQzlhALBp4zedrXEQ=;
        b=okRAwhdeV1S5uhWk4a5/YNJC/niq4qNQV/QcP6Goiy6V+nf/Y4HqB0MGlinPByJQ6b
         gEKQLBmiKryam4Jaokg1Y9F4UmjyRwk55Nc3OCwlNDldu5MxvzDpl+aoqmmg2eT8icJG
         bXj/+rxiIDaVH1NzM7TQr+X0JYlJ/afQP2Fnf6EJb+aOjwGv+95cDcK3MMh9hQk2cscU
         6awb4/J0lGFh8cYwCVLqCQTOoyLsRdnFyDX8FYdQ+HkTeujPcv27BS76+hvyKmlZvkJ0
         nOoRanbmFlcDkh1M4ycWqjcfVGNPIaaVxeQ9De0xFTQNZyq+L6OXT/82ENrfq/LhqXCU
         YIng==
X-Gm-Message-State: AOAM533sSIO7P02OgLP3Kj4NMLsG5cWgOaZgsGlYjYUFLZJ+6xTemNPw
        XnoCl0E57DvCPRDtZrG2sI2UMLzw
X-Google-Smtp-Source: ABdhPJywvTAoJG5A9H/OT4oeSZFkYgGmg4Svy6eH4dHv9jKPRXgZKOlorcoY4sO53a+rY5OBGjgVyQ==
X-Received: by 2002:a1c:e389:: with SMTP id a131mr7782104wmh.46.1590742276469;
        Fri, 29 May 2020 01:51:16 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 13/34] commit-graph: simplify write_commit_graph_file() #3
Date:   Fri, 29 May 2020 10:50:17 +0200
Message-Id: <20200529085038.26008-14-szeder.dev@gmail.com>
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

In write_commit_graph_file() we now have one block of code filling the
array of 'struct chunk_info' with the IDs and sizes of chunks to be
written, and an other block of code calling the functions responsible
for writing individual chunks.  In case of optional chunks like Extra
Edge List an Base Graphs List there is also a condition checking
whether that chunk is necessary/desired, and that same condition is
repeated in both blocks of code.  This patch series is about to add
more optional chunks, so there would be even more repeated conditions.

Eliminate these repeated conditions by storing the function pointers
responsible for writing individual chunks in the 'struct chunk_info'
array as well, and calling them in a loop to write the commit-graph
file.  This will open up the possibility for a bit of foolproofing in
the following patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 commit-graph.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 33e70bdfea..fe26245fad 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1348,9 +1348,12 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
+typedef int (*chunk_write_fn)(struct hashfile *f,
+			      struct write_commit_graph_context *ctx);
 struct chunk_info {
 	uint32_t id;
 	uint64_t size;
+	chunk_write_fn write_fn;
 };
 
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
@@ -1406,31 +1409,37 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 	chunks[chunks_nr].id = GRAPH_CHUNKID_OIDFANOUT;
 	chunks[chunks_nr].size = GRAPH_FANOUT_SIZE;
+	chunks[chunks_nr].write_fn = write_graph_chunk_fanout;
 	chunks_nr++;
 	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 	chunks[chunks_nr].id = GRAPH_CHUNKID_OIDLOOKUP;
 	chunks[chunks_nr].size = hashsz * ctx->commits.nr;
+	chunks[chunks_nr].write_fn = write_graph_chunk_oids;
 	chunks_nr++;
 	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 	chunks[chunks_nr].id = GRAPH_CHUNKID_DATA;
 	chunks[chunks_nr].size = (hashsz + 16) * ctx->commits.nr;
+	chunks[chunks_nr].write_fn = write_graph_chunk_data;
 	chunks_nr++;
 	if (ctx->num_extra_edges) {
 		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 		chunks[chunks_nr].id = GRAPH_CHUNKID_EXTRAEDGES;
 		chunks[chunks_nr].size = 4 * ctx->num_extra_edges;
+		chunks[chunks_nr].write_fn = write_graph_chunk_extra_edges;
 		chunks_nr++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 		chunks[chunks_nr].id = GRAPH_CHUNKID_BASE;
 		chunks[chunks_nr].size = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks[chunks_nr].write_fn = write_graph_chunk_base;
 		chunks_nr++;
 	}
 
 	ALLOC_GROW(chunks, chunks_nr + 1, chunks_alloc);
 	chunks[chunks_nr].id = 0;
 	chunks[chunks_nr].size = 0;
+	chunks[chunks_nr].write_fn = NULL;
 	/*
 	 * Do not increase 'chunks_nr', so it still reflects the number of
 	 * actual chunks, without the Chunk Lookup table's terminating label.
@@ -1465,16 +1474,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			progress_title.buf,
 			chunks_nr * ctx->commits.nr);
 	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, ctx);
-	write_graph_chunk_data(f, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	if (ctx->num_commit_graphs_after > 1 &&
-	    write_graph_chunk_base(f, ctx)) {
-		ret = -1;
-		goto cleanup;
-	}
+	for (i = 0; i < chunks_nr; i++)
+		if (chunks[i].write_fn(f, ctx)) {
+			ret = -1;
+			goto cleanup;
+		}
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-- 
2.27.0.rc1.431.g5c813f95dc

