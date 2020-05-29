Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F0C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6880020776
	for <git@archiver.kernel.org>; Fri, 29 May 2020 08:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0gSeoIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgE2Iv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgE2Ivf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 04:51:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB554C08C5C9
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so2286943wmd.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 01:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E25T6WKYfK/7sdSOmyHdVl5+9CRJNLnuNQ7Z36H+LLc=;
        b=u0gSeoIfcWmdkYQS1Mq+I01/iHFmWEf30EdZIHk+lEx4fuRzdDvYoQgi+DxV5SjBC7
         /Qb4jYithl2O6Aid6urD0x3cSscEIUprkuOVVPoSWQRjqCfkafA0HQNdaKoDwtF+BOZb
         5mVVzmLDhDzONRfxSIwyJiS/KctNm+tzqv2iJqYNLhp2fM284LKT7RnAbN49B6hC2grx
         4DEENCAw+PyfKmKHYaaZ9t7lF3Vlwtr20u8HHQlQI+y/N56lCYHXAc+BVosqiHsO1Gl0
         ZDzKf8fnfMawLORjHn0ORW05v6va9FsSE82vWWXfrugjDGlb9eg9fuhPxw/7DmZ1wi18
         kHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E25T6WKYfK/7sdSOmyHdVl5+9CRJNLnuNQ7Z36H+LLc=;
        b=NLLJ7k8PXAvCR1FE31/j+bpZalB9YysDbUyjXwKY/DONHSK9Tccqd+jfAKSCLf/rQy
         P50XXXvcf1Xb+OZ5vGHBFIn+2FfDtV9BauL+iIisHp81JEe8fENtsrWDgZX16XtbWlsk
         MqLL1taUyOwemP8qYFwk+97L+AM7W7YhbPIyjGcoOTHkfHGxif2rdR4qTsT9wScUYD25
         vLHbQHrg9VWiZL4onaVZArFV0lmPYmjxxWxexeVux607rYADzu2eUElGKlbL41TQpzO6
         4Fk8gm9T4egcjynTHAGYPQ4u5kXct0+gWfQPkKTYzCPLEAEWOyEnFPxorRfWxijQQ02t
         Q6tQ==
X-Gm-Message-State: AOAM530a8emzs7jAtsmTybdw+EgbqmAxLyuoBEHmX5+b42figEABlxOm
        VACWE0yaE42ghINFFaLrZqfDu7NM
X-Google-Smtp-Source: ABdhPJwZccDYZQ9BoRH5DC0i1J4+AgGqP4BqG8ZqJHeJYUERh8v9WgHXWErrozRrh76iMHIDA+57Gw==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr7758614wmj.187.1590742293168;
        Fri, 29 May 2020 01:51:33 -0700 (PDT)
Received: from localhost.localdomain (84-236-109-105.pool.digikabel.hu. [84.236.109.105])
        by smtp.gmail.com with ESMTPSA id f11sm3525255wrj.2.2020.05.29.01.51.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 01:51:32 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 23/34] commit-graph: load and use the Modified Path Bloom Filters chunk
Date:   Fri, 29 May 2020 10:50:27 +0200
Message-Id: <20200529085038.26008-24-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.27.0.rc1.431.g5c813f95dc
In-Reply-To: <20200529085038.26008-1-szeder.dev@gmail.com>
References: <20200529085038.26008-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The table below compares the average runtime and memory usage of

  git rev-list HEAD -- "$path"

with and without modified path Bloom filters for 5000+ randomly
selected paths from each repository:

                  Average runtime            |       Max RSS
                 without     with   Speedup  |  without   with
  -------------------------------------------+-------------------------
  android-base   0.8780s   0.1742s    5.04x  |   387MB   227MB   -41.4%
  cmssw          0.3143s   0.0452s    6.95x  |   181MB    79MB   -56.4%
  cpython        0.7453s   0.0956s    7.80x  |   159MB    71MB   -55.4%
  elasticsearch  0.1492s   0.0191s    7.82x  |   134MB    53MB   -60.2%
  gcc            7.1852s   0.3584s   20.05x  |   297MB   231MB   -22.3%
  gecko-dev      4.6113s   0.6318s    7.30x  |   832MB   600MB   -27.9%
  git            0.6180s   0.0405s   15.26x  |   131MB    43MB   -67.2%
  glibc          0.5618s   0.0471s   11.93x  |   136MB    50MB   -63.3%
  go             0.4913s   0.0515s    9.53x  |   130MB    50MB   -61.5%
  jdk            0.0482s   0.0089s    5.42x  |    52MB    39MB   -25.0%
  linux          0.7043s   0.1129s    6.24x  |   438MB   270MB   -38.4%
  llvm-project   2.6844s   0.4873s    5.51x  |   384MB   282MB   -26.6%
  rails          0.2784s   0.0484s    5.75x  |    88MB    51MB   -42.1%
  rust           0.7757s   0.0619s   12.53x  |   345MB    89MB   -74.3%
  tensorflow     0.6258s   0.0642s    9.74x  |   233MB    85MB   -63.5%
  webkit         1.9137s   0.3332s    5.74x  |   941MB   480MB   -49.0%
---
 commit-graph.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 commit-graph.h |  2 ++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3210ec2f93..f9a21ecdfb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -327,6 +327,15 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
 			}
 			break;
 
+		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTERS:
+			if (graph->chunk_mpbf_filters)
+				chunk_repeated = 1;
+			else {
+				graph->chunk_mpbf_filters = data + chunk_offset;
+				graph->chunk_mpbf_filters_size = next_chunk_offset - chunk_offset;
+			}
+			break;
+
 		case GRAPH_CHUNKID_MODIFIED_PATH_BLOOM_FILTER_EXCLUDES:
 			if (graph->chunk_mpbf_excludes)
 				chunk_repeated = 1;
@@ -830,6 +839,7 @@ static int load_modified_path_bloom_filter_from_graph(
 		struct commit *parent, struct bloom_filter *bf)
 {
 	const uint8_t *bloom_index;
+	uint64_t offset;
 	int first_parent = 0;
 
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
@@ -857,9 +867,39 @@ static int load_modified_path_bloom_filter_from_graph(
 		bf->nr_bits = GRAPH_MODIFIED_PATH_BLOOM_FILTER_EMBEDDED_NR_BITS;
 		bf->bits = (uint8_t*) bloom_index;
 		return 1;
+	} else if (bloom_index[0] & (1 << 6)) {
+		/*
+		 * Modified path Bloom filters for second..nth parents of
+		 * merge commits are not implemented yet.
+		 */
+		return 0;
+	} else {
+		if (!first_parent)
+			return 0;
+		offset = get_be64(bloom_index);
 	}
-	/* support for non-embedded Bloom filters is not implemented yet. */
-	return 0;
+
+	if (!graph->chunk_mpbf_filters)
+		BUG("commit %s refers to offset %lu of the Modified Path Bloom Filters chunk, but that chunk is missing",
+		    oid_to_hex(&commit->object.oid), offset);
+
+	if (offset + sizeof(uint32_t) >= graph->chunk_mpbf_filters_size)
+		BUG("commit %s refers to offset %lu of the Modified Path Bloom Filters chunk, but that's too large for chunk of size %lu bytes",
+		    oid_to_hex(&commit->object.oid), offset,
+		    graph->chunk_mpbf_filters_size);
+
+	bf->nr_bits = get_be32(graph->chunk_mpbf_filters + offset);
+	if (!bf->nr_bits)
+		BUG("commit %s has a modified path Bloom filter at offset %lu, which has zero size",
+		    oid_to_hex(&commit->object.oid), offset);
+	if (offset + sizeof(uint32_t) + bloom_filter_bytes(bf) > graph->chunk_mpbf_filters_size)
+		BUG("commit %s has a modified path Bloom filter of %u bits at offset %lu, which doesn't fit into a Modified Path Bloom Filters chunk of %lu bytes",
+		    oid_to_hex(&commit->object.oid), bf->nr_bits, offset,
+		    graph->chunk_mpbf_filters_size);
+	/* Casting away const-ness :( */
+	bf->bits = (uint8_t*)(graph->chunk_mpbf_filters + offset + sizeof(uint32_t));
+
+	return 1;
 }
 
 enum bloom_result check_modified_path_bloom_filter(struct repository *r,
diff --git a/commit-graph.h b/commit-graph.h
index 09dfc16932..cde0d7fa30 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -69,6 +69,8 @@ struct commit_graph {
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_mpbf_index;
 	uint64_t chunk_mpbf_index_size;
+	const unsigned char *chunk_mpbf_filters;
+	uint64_t chunk_mpbf_filters_size;
 	const unsigned char *chunk_mpbf_excludes;
 
 	uint8_t num_modified_path_bloom_hashes;
-- 
2.27.0.rc1.431.g5c813f95dc

