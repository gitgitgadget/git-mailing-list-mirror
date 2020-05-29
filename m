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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5212C433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8458A20723
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niADDxFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgE2IvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgE2IvK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD89C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so2624698wru.0
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ze0baRJzbWZV+UqBej9xtjj9xdJaKXx+x3lfNTIFBw=;
        b=niADDxFKFjxE2e0LB2HXTB7N+3a49MRfnJ+qANsTflXCGdXuUVh6kNLUVwrSMZuwEC
         xzyA2/ofhEwBFTifKO18Ps5t3rsuT5z18quZMl/Ud9umPfEVVJUHxhRdG87fEqoVBbv3
         EIDrK7p7ct6P2ZLq3UHc/kLpUjukMwTNda051gSRDKjr0PIRVoji9fA3Id4yx1he1qc4
         mPpjk/cJIB6znE/8Eu15Ff0ayq3+dnB5Tm81wKfbDpMxoiNM3Dar0qgWDUb1J2PehT3v
         xbdApxvCTuRMPw1P0fJ+vVjRYIrEiUj6UMr4bjPJZlheNQNxl5ZP1sR1tN4wNd/3+Mrg
         iB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ze0baRJzbWZV+UqBej9xtjj9xdJaKXx+x3lfNTIFBw=;
        b=MrmoKV8Rqembl8TBi4/MH0ucP4IIcJbEmq5SywotRUzHholI0PMZA5fPAPiY/VYquB
         6glQD8EkYAxIHrTLWxM17G7GumD5Sqgi4HtWDbzLAEQhbuSNUyjGazskrerNQbMniRVN
         Lpon//GzReOwIPml7EOTQ362hlNtfhtcEt0UbskV5lPw+yXOrGrtfKgAcu2JhPo6R5SK
         vZGS9ZtAp6DS29xRD+izmulOqKh8QSrAFjP/6BV0zP4zRnVMqdPG0iLL2MCyJeyEsMh8
         SjyRr2v/6Bsttr2x+z0blCjFPRjHRKmwejh3pX9Rcq0NihpXf1oyjGFD6W89yWzdTfJy
         epXA==
X-Gm-Message-State: AOAM5326BQb/75cohGPmUqRpeJpwu3vIH47XSBdB+YZrsXvcpXNLGyw+
        7DLZ0xTbz3Tlv9J4VznSzpazEKav
X-Google-Smtp-Source: ABdhPJxVPPRiuWC8FipdQzubfPk4uxwtkonF+6UrnFAJpKD72WYIB4EWvwmR09X2bf/eL0PA/u1oBA==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr8177904wrt.220.1590742268336;
        Fri, 29 May 2020 01:51:08 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:07 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/34] commit-graph: simplify parse_commit_graph() #2
Date:   Fri, 29 May 2020 10:50:12 +0200
Message-Id: <20200529085038.26008-9-szeder.dev@gmail.com>
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
---
 commit-graph.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 69facf3bf5..f64b1c01a8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -175,8 +175,7 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 	const unsigned char *data, *chunk_lookup;
 	uint32_t i;
 	struct commit_graph *graph;
-	uint64_t last_chunk_offset;
-	uint32_t last_chunk_id;
+	uint64_t next_chunk_offset;
 	uint32_t graph_signature;
 	unsigned char graph_version, hash_version;
 
@@ -226,16 +225,17 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 		return NULL;
 	}
 
-	last_chunk_id = 0;
-	last_chunk_offset = 8;
 	chunk_lookup = data + 8;
-	for (i = 0; i <= graph->num_chunks; i++) {
+	next_chunk_offset = get_be64(chunk_lookup + 4);
+	for (i = 0; i < graph->num_chunks; i++) {
 		uint32_t chunk_id;
 		uint64_t chunk_offset;
 		int chunk_repeated = 0;
 
 		chunk_id = get_be32(chunk_lookup + 0);
-		chunk_offset = get_be64(chunk_lookup + 4);
+		chunk_offset = next_chunk_offset;
+		next_chunk_offset = get_be64(chunk_lookup + 4 +
+					     GRAPH_CHUNKLOOKUP_WIDTH);
 
 		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
 
@@ -257,8 +257,11 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
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
@@ -287,15 +290,6 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
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
 
 	hashcpy(graph->oid.hash, graph->data + graph->data_len - graph->hash_len);
-- 
2.27.0.rc1.431.g5c813f95dc

