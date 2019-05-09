Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CB81F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEIVbl (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:31:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:53708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:31:41 -0400
Received: (qmail 10098 invoked by uid 109); 9 May 2019 21:31:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:31:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6561 invoked by uid 111); 9 May 2019 21:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:32:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:31:39 -0400
Date:   Thu, 9 May 2019 17:31:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/14] receive-pack: drop unused "commands" from
 prepare_shallow_update()
Message-ID: <20190509213138.GJ15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass in the list of proposed ref updates to prepare_shallow_update(),
but that function doesn't actually need it (and never has since its
inception in 0a1bc12b6e4). Only its caller, update_shallow_info(), needs
to look at the command list.

Let's drop the unused parameter to reduce confusion.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 29f165d8bd..77b7122456 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1809,8 +1809,7 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 	return ret;
 }
 
-static void prepare_shallow_update(struct command *commands,
-				   struct shallow_info *si)
+static void prepare_shallow_update(struct shallow_info *si)
 {
 	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
@@ -1876,7 +1875,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(commands, si);
+		prepare_shallow_update(si);
 		return;
 	}
 
-- 
2.21.0.1382.g4c6032d436

