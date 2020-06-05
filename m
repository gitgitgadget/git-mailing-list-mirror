Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3FC433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4A92070B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 13:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGg7vgTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFENAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFENAq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 09:00:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F5C08C5C6
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 06:00:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so9646230wru.12
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/olBEMbrOpRVmHc0T5Ksbiyh/UfsR1ZqVlsfQnmh+K0=;
        b=SGg7vgThe3zKwK3nXGu2+fw54ykzx7A26w+vJF0sYpSMG6IxRKhHaqflFbOtcLwL0J
         Ss1JHiwYcqozq6TZJKMaTYorZKrZlv4otkCDAqM1+nNtAq2K50XDGFIB48T6FM9nW9sa
         hlEhqU5s1PvwJnYd/0jvaUdQdMeDFBEnThUIerenm9yGODaq6QFX6rssWOTs1oJEvdSH
         9VONb0MwoTC6mJgJMxRaFwsZdW/vlHzsUZ5LAEmoZNS9k5KZpF4hPusiZ5ulYNNlGMmv
         EApOrEKrFerJCBxJSTf4Yns6wSbQEYhuyQlDs0HgW+IGH2RczBT26c47NrPeB0CJP4fl
         fBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/olBEMbrOpRVmHc0T5Ksbiyh/UfsR1ZqVlsfQnmh+K0=;
        b=SzA3kFhRdhJT6HeSDesFHWvoJUTND4/+0G4ca3WytvpfStDsHFH1bZy+UsIynJwd/F
         Fj7SBa6DzsHb7coUKpv0hD/aAV6r9TnsIvwvD5opZQNOTCbUaRBQZTbL0DY52T2XU16C
         t10DzMKl4cbg2+GdExDirSeVd8F5zGF8oLByexBzZwOEd4z2F0/TrDEIjj/bY9s+RNmb
         e37iveZwn6pT3nt/pUYAcaxOiqzGjGvvIlU2j1ANB/2hC3ByizuHPWsyg16MUSuBiZ2R
         QODBlWsaIx6zqKhM3XzPi7QCtrJEoOLzMDVUeye84u0ZhrWUFHCaXVfz0stwRK8TvCOT
         uX3A==
X-Gm-Message-State: AOAM532YAIe4JNbuxadJ/Zo3yFC9ILw0iRXG2ck30rLWbbY65iiFRmdJ
        idDZc4gHvvq8JVtm9cBE7E7MFupr
X-Google-Smtp-Source: ABdhPJzAoy2j9HsUAVEDmwVLAeFfHVHdogzXIJxSjdjEEbPZykyRHyWaXV+7EiBa7wZ8YCt/e1kp2Q==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr9395516wrx.200.1591362043498;
        Fri, 05 Jun 2020 06:00:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n204sm11688514wma.5.2020.06.05.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:00:42 -0700 (PDT)
Message-Id: <83641b5e49e4f2abd2185fc1cde58eadad496cd4.1591362033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.650.git.1591362032.gitgitgadget@gmail.com>
References: <pull.650.git.1591362032.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?SZEDER=20G=C3=A1bor?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 13:00:30 +0000
Subject: [PATCH 08/10] commit-graph: simplify parse_commit_graph() #2
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

The Chunk Lookup table stores the chunks' starting offset in the
commit-graph file, not their sizes.  Consequently, the size of a chunk
can only be calculated by subtracting its offset from the offset of
the subsequent chunk (or that of the terminating label).  This is
currenly implemented in a bit complicated way: as we iterate over the
entries of the Chunk Lookup table, we check the id of each chunk and
store its starting offset, then we check the id of the last seen chunk
and calculate its size using its previously saved offset.  At the
moment there is only one chunk for which we calculate its size, but
this patch series will add more, and the repeated chunk id checks are
not that pretty.

Instead let's read ahead the offset of the next chunk on each
iteration, so we can calculate the size of each chunk right away,
right where we store its starting offset.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9927762f18c..84206f0f512 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -230,8 +230,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
 	struct commit_graph *graph;
-	uint64_t last_chunk_offset;
-	uint32_t last_chunk_id;
+	uint64_t next_chunk_offset;
 	uint32_t graph_signature;
 	unsigned char graph_version, hash_version;
 
@@ -281,18 +280,17 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		return NULL;
 	}
 
-	last_chunk_id = 0;
-	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
-	for (i = 0; i <= graph->num_chunks; i++) {
+	next_chunk_offset = get_be64(chunk_lookup + 4);
+	for (i = 0; i < graph->num_chunks; i++) {
 		uint32_t chunk_id;
-		uint64_t chunk_offset;
+		uint64_t chunk_offset = next_chunk_offset;
 		int chunk_repeated = 0;
 
 		chunk_id = get_be32(chunk_lookup + 0);
-		chunk_offset = get_be64(chunk_lookup + 4);
 
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
+		next_chunk_offset = get_be64(chunk_lookup + 4);
 
 		if (chunk_offset > graph_size - the_hash_algo->rawsz) {
 			error(_("commit-graph improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
@@ -312,8 +310,11 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		case GRAPH_CHUNKID_OIDLOOKUP:
 			if (graph->chunk_oid_lookup)
 				chunk_repeated = 1;
-			else
+			else {
 				graph->chunk_oid_lookup = data + chunk_offset;
+				graph->num_commits = (next_chunk_offset - chunk_offset)
+						     / graph->hash_len;
+			}
 			break;
 
 		case GRAPH_CHUNKID_DATA:
@@ -368,15 +369,6 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 			free(graph);
 			return NULL;
 		}
-
-		if (last_chunk_id == GRAPH_CHUNKID_OIDLOOKUP)
-		{
-			graph->num_commits = (chunk_offset - last_chunk_offset)
-					     / graph->hash_len;
-		}
-
-		last_chunk_id = chunk_id;
-		last_chunk_offset = chunk_offset;
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
-- 
gitgitgadget

