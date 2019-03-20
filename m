Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D968A20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfCTIPK (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:15:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:57428 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726049AbfCTIPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:15:10 -0400
Received: (qmail 19645 invoked by uid 109); 20 Mar 2019 08:15:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:15:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6332 invoked by uid 111); 20 Mar 2019 08:15:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:15:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:15:07 -0400
Date:   Wed, 20 Mar 2019 04:15:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/13] unpack-trees: drop name_entry from
 traverse_by_cache_tree()
Message-ID: <20190320081507.GF10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pull the names from the existing index rather than the tree entry,
which is after all the point of this function. Let's drop the unused
"names" parameter.

Note that we leave the "nr_names" parameter, as it tells us how many
trees we are traversing (and thus how many index stages to set up).

Signed-off-by: Jeff King <peff@peff.net>
---
 unpack-trees.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 22c41a3ba8..79551ab9cc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -707,7 +707,6 @@ static int index_pos_by_traverse_info(struct name_entry *names,
  * instead of ODB since we already know what these trees contain.
  */
 static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
-				  struct name_entry *names,
 				  struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
@@ -797,7 +796,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 		 * unprocessed entries before 'pos'.
 		 */
 		bottom = o->cache_bottom;
-		ret = traverse_by_cache_tree(pos, nr_entries, n, names, info);
+		ret = traverse_by_cache_tree(pos, nr_entries, n, info);
 		o->cache_bottom = bottom;
 		return ret;
 	}
-- 
2.21.0.701.g4401309e11

