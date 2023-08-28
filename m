Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E810C83F17
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 21:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjH1Vry (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjH1Vrn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 17:47:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03227F9
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 14:47:40 -0700 (PDT)
Received: (qmail 542 invoked by uid 109); 28 Aug 2023 21:47:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Aug 2023 21:47:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4532 invoked by uid 111); 28 Aug 2023 21:47:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Aug 2023 17:47:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Aug 2023 17:47:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/22] commit-graph: mark unused data parameters in
 generation callbacks
Message-ID: <20230828214739.GF3831137@coredump.intra.peff.net>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828214604.GA3830831@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The compute_generation_info code uses function pointers to abstract the
get/set generation operations. Some callers don't need the extra void
data pointer, which should be annotated to appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..73a539495b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1568,12 +1568,14 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static timestamp_t get_generation_from_graph_data(struct commit *c, void *data)
+static timestamp_t get_generation_from_graph_data(struct commit *c,
+						  void *data UNUSED)
 {
 	return commit_graph_data_at(c)->generation;
 }
 
-static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
+static void set_generation_v2(struct commit *c, timestamp_t t,
+			      void *data UNUSED)
 {
 	struct commit_graph_data *g = commit_graph_data_at(c);
 	g->generation = t;
@@ -1616,7 +1618,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 }
 
 static void set_generation_in_graph_data(struct commit *c, timestamp_t t,
-					 void *data)
+					 void *data UNUSED)
 {
 	commit_graph_data_at(c)->generation = t;
 }
-- 
2.42.0.505.g4c6fb48dec

