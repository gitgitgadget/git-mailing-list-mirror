Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B24FC433E2
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34224207E8
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMy5QPaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgFZMav (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgFZMap (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E85C08C5DD
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so9217076wmh.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ud8jTtdygfJzBwVWu9g0NPPZ/f/77FUNYqqjh8Ghw0g=;
        b=WMy5QPaE9Roajd0coMm0yb8OiMDGtKOl2qfY6sReu2IbTSCuwJ25dxPEPZlqZAl4yI
         yxFqpoUIR0Oobo4yT7RRbCP46VlJYpd5kCx/aW08YuwukYhM2Bk/HafWXTaRiKCVufn3
         MQI+rf7K+NDr8dJqQNk3yxSgFi/qhTpIBpQMYWs+QRHF+z8JDcHYF3K85sw66AJTVbTU
         Otp8D+aAGKQd4uqKElfMTU6wEMRSGg761ntJS010M/9h5FHKcuNERTCLy/ugHepT1may
         TQ9AavHyCDhOwciw2r+De9valmiE//n9DK0Ts++2vuwcbEI3tvd1wDI/BrfrB5uwgqu3
         ZAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ud8jTtdygfJzBwVWu9g0NPPZ/f/77FUNYqqjh8Ghw0g=;
        b=dr15NxmmrAKUkoP1U/Adep289VTVs03GeQY1NkqEWM5tjzLwT/heNUKIOfL8PMMMLd
         OeRjb66scJjPuq/8O8JW7Hvxy89y2DKJ3Kc6goPdBbyo4Ak2dLArsWB7d13I3mxFu4Hq
         GXG4YPFAfGwocSwSaXuz06/Z90nmjIFSaFds8ZfHL7a/vBilNYDEEh14RZAkMF9T1erJ
         T0lfN/890JeHluZOi6Hbxlw/ziRPpv3WDZx6ESo0wj/pR9u01ZUXVuQGs5FDKdeg0WWX
         yBhn8YDtEpiOejYJwh04c458zYzm7pBMhmiWpS1IFU6hdOZb0tq4IobkozFt82w0DQGW
         ls2Q==
X-Gm-Message-State: AOAM532y2E6sZbPPIUlNPABhqX+10kX7J0nMp+VFxTIQFDK6N+0coE15
        q2kAJ7smhpplIqgWs24KKuRq02EB
X-Google-Smtp-Source: ABdhPJzcOzNVpLq+vaJM+Fh5MzIWNg0Mqgtupddf3OTNKlSagkUVP/HPR8HUXst6AAlZ53yRhIYaIw==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr3063484wme.64.1593174644101;
        Fri, 26 Jun 2020 05:30:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm26634751wrs.77.2020.06.26.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:43 -0700 (PDT)
Message-Id: <8828dcd9068abdc44d321900280fdb51d2b7f138.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:32 +0000
Subject: [PATCH v3 06/10] commit-graph: simplify chunk writes into loop
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>

In write_commit_graph_file() we now have one block of code filling the
array of 'struct chunk_info' with the IDs and sizes of chunks to be
written, and an other block of code calling the functions responsible
for writing individual chunks.  In case of optional chunks like Extra
Edge List an Base Graphs List there is also a condition checking
whether that chunk is necessary/desired, and that same condition is
repeated in both blocks of code. Other, newer chunks have similar
optional conditions.

Eliminate these repeated conditions by storing the function pointers
responsible for writing individual chunks in the 'struct chunk_info'
array as well, and calling them in a loop to write the commit-graph
file.  This will open up the possibility for a bit of foolproofing in
the following patch.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d51682998d..e43ee58ea6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1555,9 +1555,13 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
+typedef int (*chunk_write_fn)(struct hashfile *f,
+			      struct write_commit_graph_context *ctx);
+
 struct chunk_info {
 	uint32_t id;
 	uint64_t size;
+	chunk_write_fn write_fn;
 };
 
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
@@ -1620,27 +1624,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
 	chunks[0].size = GRAPH_FANOUT_SIZE;
+	chunks[0].write_fn = write_graph_chunk_fanout;
 	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
 	chunks[1].size = hashsz * ctx->commits.nr;
+	chunks[1].write_fn = write_graph_chunk_oids;
 	chunks[2].id = GRAPH_CHUNKID_DATA;
 	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
+	chunks[2].write_fn = write_graph_chunk_data;
 	if (ctx->num_extra_edges) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
 		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
+		chunks[num_chunks].write_fn = write_graph_chunk_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->changed_paths) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
 		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_indexes;
 		num_chunks++;
 		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
 		chunks[num_chunks].size = sizeof(uint32_t) * 3
 					  + ctx->total_bloom_filter_data_size;
+		chunks[num_chunks].write_fn = write_graph_chunk_bloom_data;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
 		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
 		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks[num_chunks].write_fn = write_graph_chunk_base;
 		num_chunks++;
 	}
 
@@ -1676,19 +1687,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			progress_title.buf,
 			num_chunks * ctx->commits.nr);
 	}
-	write_graph_chunk_fanout(f, ctx);
-	write_graph_chunk_oids(f, ctx);
-	write_graph_chunk_data(f, ctx);
-	if (ctx->num_extra_edges)
-		write_graph_chunk_extra_edges(f, ctx);
-	if (ctx->changed_paths) {
-		write_graph_chunk_bloom_indexes(f, ctx);
-		write_graph_chunk_bloom_data(f, ctx);
-	}
-	if (ctx->num_commit_graphs_after > 1 &&
-	    write_graph_chunk_base(f, ctx)) {
-		return -1;
+
+	for (i = 0; i < num_chunks; i++) {
+		if (chunks[i].write_fn(f, ctx))
+			return -1;
 	}
+
 	stop_progress(&ctx->progress);
 	strbuf_release(&progress_title);
 
-- 
gitgitgadget

