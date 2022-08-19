Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70C2C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 08:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiHSIvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbiHSIvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 04:51:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA45E395F
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 01:51:05 -0700 (PDT)
Received: (qmail 17546 invoked by uid 109); 19 Aug 2022 08:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 08:51:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 415 invoked by uid 111); 19 Aug 2022 08:51:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 04:51:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 04:51:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/6] verify_one_sparse(): drop unused repository parameter
Message-ID: <Yv9O+HDMLKglLcqY@coredump.intra.peff.net>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function has never used its repository parameter since it was
introduced in 9ad2d5ea71 (sparse-index: loose integration with
cache_tree_verify(), 2021-03-30). As that commit notes, it may
eventually be extended further, and that might require looking at a
repository struct. But it would be easy to add it back later if
necessary. In the mean time, dropping it makes the code shorter and
appease -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 56db0b5026..c97111cccf 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -857,9 +857,7 @@ int cache_tree_matches_traversal(struct cache_tree *root,
 	return 0;
 }
 
-static void verify_one_sparse(struct repository *r,
-			      struct index_state *istate,
-			      struct cache_tree *it,
+static void verify_one_sparse(struct index_state *istate,
 			      struct strbuf *path,
 			      int pos)
 {
@@ -910,7 +908,7 @@ static int verify_one(struct repository *r,
 			return 1;
 
 		if (pos >= 0) {
-			verify_one_sparse(r, istate, it, path, pos);
+			verify_one_sparse(istate, path, pos);
 			return 0;
 		}
 
-- 
2.37.2.928.g0821088f4a

