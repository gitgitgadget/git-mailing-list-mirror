Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4EAC433E1
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA69206E6
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os/2aUtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFENA5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFENAr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4956C08C5C8
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so9692602wro.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Ix3lC8CNjsHAgSGIKCQ2XS6FIuVOEUMMdFtp6+hlJu0=;
        b=os/2aUtwJNBC1S7trJFyQ3BtEFh0BErrNjr6Dj9Pea1OQKTqn63FsdDMkFCQmZemL5
         GlTrB9N90PTG/JOhvLIZzPhnLJVw72NgLduKkH3Lmm8GyRn14pezqvQWNhENUATibDwt
         s4N3X9CnIaSmwwQ5UEequOpP6x0A3BXtAT3s8vqopP/O5hivhr5vHTGwrieUwmeM/OpW
         2TLABpC8dB07Zq7pTqBZODP0MSWpiyDmL22KbUrYjcUFHYk+LOfmC+I+gSlKYJVAiZSX
         qGlkfJ3+Wixtumd6iJqkYPLi9ycrbLPz1I3js66Po8vsSZ2IATrfs7opmuSyJVPjsUUx
         2OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Ix3lC8CNjsHAgSGIKCQ2XS6FIuVOEUMMdFtp6+hlJu0=;
        b=PMBIaruqPI70BkeUkW5xneopWP2uV2KsMnvroi7vRdtWF+xu8oOv8VB1H3/OWmkHLJ
         tGtJf5VrkGGrFyZfqx+uW+VMTM2tXP6Ee4d8SNPOq4LIumNeyxv1DA8XHOPeldJAhdN1
         j5pzjj+RNpOaJM14/7AX+w6LNo+7Elqm0ZU0GzjlB/+/h5506XQqcVNtRbKd+aRVpMTI
         V9WpMS2qYDg0Q3cyKiVV1vjNrFN8u2oml9Oh4/z2wD5Q2RFQSkwnbTG6Y3aZjygSGSzb
         lHCWl3x4NxRGbgjdww+6F4ai91KL9QbaS9og4A1+7+UwLX+JRQSIe/HaBRd8Hc8DMzG2
         Sypg==
X-Gm-Message-State: AOAM530Hgy152BxWKHZenTNti4Vk/YjeheSWXlcXqJk5g8WLe+yrpbWi
        gqDNYxnNzDWbQJtWZzUG01dR9Km6
X-Google-Smtp-Source: ABdhPJzFwaz4nI9XBMvwJ1pTizdsNDCB2WVas6e9COOU2PjnCvprdo88Dk1/WZ3lAG1+yEvs45dR0g==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr10515240wro.60.1591362045404;
        Fri, 05 Jun 2020 06:00:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v24sm11032358wmh.45.2020.06.05.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:44 -0700 (PDT)
Message-Id: <5984fb01ebcff326fe137720e5fcf784cf321e34.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:32 +0000
Subject: [PATCH 10/10] commit-graph: simplify write_commit_graph_file() #2
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

Unify the 'chunk_ids' and 'chunk_sizes' arrays into an array of
'struct chunk_info'.  This will allow more cleanups in the following
patches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 79cddabcd12..887837e8826 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1522,14 +1522,18 @@ static int write_graph_chunk_base(struct hashfile *f,
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
-	uint32_t chunk_ids[MAX_NUM_CHUNKS + 1];
-	uint64_t chunk_sizes[MAX_NUM_CHUNKS + 1];
+	struct chunk_info chunks[MAX_NUM_CHUNKS + 1];
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
@@ -1573,35 +1577,34 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	}
 
-	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
-	chunk_sizes[0] = GRAPH_FANOUT_SIZE;
-	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
-	chunk_sizes[1] = hashsz * ctx->commits.nr;
-	chunk_ids[2] = GRAPH_CHUNKID_DATA;
-	chunk_sizes[2] = (hashsz + 16) * ctx->commits.nr;
-
+	chunks[0].id = GRAPH_CHUNKID_OIDFANOUT;
+	chunks[0].size = GRAPH_FANOUT_SIZE;
+	chunks[1].id = GRAPH_CHUNKID_OIDLOOKUP;
+	chunks[1].size = hashsz * ctx->commits.nr;
+	chunks[2].id = GRAPH_CHUNKID_DATA;
+	chunks[2].size = (hashsz + 16) * ctx->commits.nr;
 	if (ctx->num_extra_edges) {
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_EXTRAEDGES;
-		chunk_sizes[num_chunks] = 4 * ctx->num_extra_edges;
+		chunks[num_chunks].id = GRAPH_CHUNKID_EXTRAEDGES;
+		chunks[num_chunks].size = 4 * ctx->num_extra_edges;
 		num_chunks++;
 	}
 	if (ctx->changed_paths) {
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMINDEXES;
-		chunk_sizes[num_chunks] = sizeof(uint32_t) * ctx->commits.nr;
+		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMINDEXES;
+		chunks[num_chunks].size = sizeof(uint32_t) * ctx->commits.nr;
 		num_chunks++;
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_BLOOMDATA;
-		chunk_sizes[num_chunks] = sizeof(uint32_t) * 3
+		chunks[num_chunks].id = GRAPH_CHUNKID_BLOOMDATA;
+		chunks[num_chunks].size = sizeof(uint32_t) * 3
 					  + ctx->total_bloom_filter_data_size;
 		num_chunks++;
 	}
 	if (ctx->num_commit_graphs_after > 1) {
-		chunk_ids[num_chunks] = GRAPH_CHUNKID_BASE;
-		chunk_sizes[num_chunks] = hashsz * (ctx->num_commit_graphs_after - 1);
+		chunks[num_chunks].id = GRAPH_CHUNKID_BASE;
+		chunks[num_chunks].size = hashsz * (ctx->num_commit_graphs_after - 1);
 		num_chunks++;
 	}
 
-	chunk_ids[num_chunks] = 0;
-	chunk_sizes[num_chunks] = 0;
+	chunks[num_chunks].id = 0;
+	chunks[num_chunks].size = 0;
 
 	hashwrite_be32(f, GRAPH_SIGNATURE);
 
@@ -1614,12 +1617,12 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
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
gitgitgadget
