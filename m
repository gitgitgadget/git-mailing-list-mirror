Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173BC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499CE20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5HVuZsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgE2Ivp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgE2Ivl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD023C0A88B4
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so2573360wrt.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGp0WjsQ6+2XetZJcojt2bGV/K33EZG/AxxU2XagIpw=;
        b=Z5HVuZsKBId+ATSVfZzvwhMpVjtS3iu1LNyugtRHhhvn9Eo1lETIY7JR7sc2GAfEfE
         rUPErqRfQ6dQ4AAiZYMOClNzqv7ypb7A/lW0Lg5qOCL84U+hFAfgiL8CiDL9OrIVPmEw
         gHbDfP/bQ4TceFtsRQvrGk93o6+Hw/pmoFsq38o92xuWB0deGzNKrwMtT9T2bV3Tx15q
         9uNaLCvzz/osCJ5f0RTPBJ6v+z5IQDAk/vnzL57wuNqqWl2Ngg89bKmY0cPUUMcyIaIQ
         gC9ssu7gECDjUNyudTMJvJq9P82h6r7pbN2mP5wTQTP25YliCNZkvao5yoEsLPvYaiSX
         090A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGp0WjsQ6+2XetZJcojt2bGV/K33EZG/AxxU2XagIpw=;
        b=Mm2S8+nFCXixt55J6wtTIPgq8qm2WpyQRoJeIiPf6n5ggVn/xCN6LYGZnN8XwRk9AW
         k6Zh462QOUY8ygch+Lqk8Yro3pnK1y3BDtPBZ79B9k1dyFnUQyq3W0odNoUiThW9bJdW
         CGX3JpRlvqgz/HydDEKR1noLOW46cld3TVK7LemuSZSROWKThPJKXIblEJfvdiaxLtRa
         6DND308A+zsOsXnYFWkzkC/upmlrNPDS9n6FUp5YGsaVaUPBVY8I1BF8+9uAmpyyP7IA
         ShEWLV1zzE1+/G7RBplQpLGzEBkoKec+Fmqzegs/cWpyZiuwexqxEth58g0tH6VTWkCS
         XlvQ==
X-Gm-Message-State: AOAM531F1gmra2j8cZxapdt/1xcz+R+GJSEMTuL/XadZJ3jLHaap+7/C
        RBNHXRBQNfSD4cLzDMCivB7J6X5y
X-Google-Smtp-Source: ABdhPJwo/3gb6Ww5ejqS0pSxIO4DOhq2WXXmMauqMXaS8FVBtj6GTiRojVWpKBVHCe3ti7mBCdSUnA==
X-Received: by 2002:a05:6000:12c4:: with SMTP id l4mr8189471wrx.128.1590742299212;
        Fri, 29 May 2020 01:51:39 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 27/34] commit-graph: load modified path Bloom filters for merge commits
Date:   Fri, 29 May 2020 10:50:31 +0200
Message-Id: <20200529085038.26008-28-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 commit-graph.c | 53 +++++++++++++++++++++++++++++++++++++++++++++-----
 commit-graph.h |  2 ++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 178bbf0113..32738ba4b8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -26,6 +26,7 @@
 #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
 #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_INDEX 0x4d504249 /* "MPBI" */
+#define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_MERGE_INDEX 0x4d50424d /* "MPBM" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTERS 0x4d504246 /* "MPBF" */
 #define GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_EXCLUDES 0x4d504258 /* "MPBX" */
 
@@ -328,6 +329,15 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 			}
 			break;
 
+		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_MERGE_INDEX:
+			if (graph->chunk_mpbf_merge_index)
+				chunk_repeated = 1;
+			else {
+				graph->chunk_mpbf_merge_index = data + chunk_offset;
+				graph->chunk_mpbf_merge_index_size = next_chunk_offset - chunk_offset;
+			}
+			break;
+
 		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTERS:
 			if (graph->chunk_mpbf_filters)
 				chunk_repeated = 1;
@@ -869,11 +879,44 @@ static int load_modified_path_bloom_filter_from_graph(
 		bf->bits = (uint8_t*) bloom_index;
 		return 1;
 	} else if (bloom_index[0] & (1 << 6)) {
-		/*
-		 * Modified path Bloom filters for second..nth parents of
-		 * merge commits are not implemented yet.
-		 */
-		return 0;
+		struct commit_list *p;
+		uint32_t pos;
+		int found = 0;
+
+		pos = get_be32(bloom_index + sizeof(uint32_t));
+
+		if (!graph->chunk_mpbf_merge_index)
+			BUG("commit %s refers to position %u in the Modified Path Bloom Filter Merge Index chunk, but that chunk is missing",
+			    oid_to_hex(&commit->object.oid), pos);
+
+		for (p = commit->parents; p; p = p->next, pos++)
+			if (p->item == parent) {
+				found = 1;
+				break;
+			}
+		if (!found)
+			BUG("commit %s has no parent %s\n",
+			    oid_to_hex(&commit->object.oid),
+			    oid_to_hex(&parent->object.oid));
+
+		if (pos * sizeof(uint64_t) > graph->chunk_mpbf_merge_index_size)
+			BUG("commit %s and parent %s refer to position %u in the Modified Path Bloom Filter Merge Index chunk, but that's too large for a chunk of size %lu bytes",
+			    oid_to_hex(&commit->object.oid),
+			    oid_to_hex(&parent->object.oid), pos,
+			    graph->chunk_mpbf_merge_index_size);
+		bloom_index = graph->chunk_mpbf_merge_index + sizeof(uint64_t) * pos;
+		if (bloom_index[0] & (1 << 7)) {
+			uint64_t v;
+			memcpy(&v, bloom_index, sizeof(v));
+			if (v == GRAPH_MODIFIED_PATH_BLOOM_FILTER_NONE)
+				return 0;
+
+			/* embedded modified path Bloom filter */
+			bf->nr_bits = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS;
+			bf->bits = (uint8_t*) bloom_index;
+			return 1;
+		} else
+			offset = get_be64(bloom_index);
 	} else {
 		if (!first_parent)
 			return 0;
diff --git a/commit-graph.h b/commit-graph.h
index cde0d7fa30..b2605a0e3b 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -69,6 +69,8 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_mpbf_index;
 	uint64_t chunk_mpbf_index_size;
+	const unsigned char *chunk_mpbf_merge_index;
+	uint64_t chunk_mpbf_merge_index_size;
 	const unsigned char *chunk_mpbf_filters;
 	uint64_t chunk_mpbf_filters_size;
 	const unsigned char *chunk_mpbf_excludes;
-- 
2.27.0.rc1.431.g5c813f95dc

