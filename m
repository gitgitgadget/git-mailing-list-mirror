Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEEA20248
	for <e@80x24.org>; Sat, 13 Apr 2019 05:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDMFyM (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 01:54:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726175AbfDMFyL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 01:54:11 -0400
Received: (qmail 27752 invoked by uid 109); 13 Apr 2019 05:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 13 Apr 2019 05:54:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12637 invoked by uid 111); 13 Apr 2019 05:54:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Apr 2019 01:54:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Apr 2019 01:54:09 -0400
Date:   Sat, 13 Apr 2019 01:54:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 5/7] fetch: use free_refs()
Message-ID: <20190413055409.GE19495@sigill.intra.peff.net>
References: <20190413055127.GA32340@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413055127.GA32340@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need for us to write this loop manually when a helper
function can already do it.

Signed-off-by: Jeff King <peff@peff.net>
---
 fetch-pack.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index e69993b2eb..a181d3401d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -630,10 +630,7 @@ static void filter_refs(struct fetch_pack_args *args,
 	}
 
 	oidset_clear(&tip_oids);
-	for (ref = unmatched; ref; ref = next) {
-		next = ref->next;
-		free(ref);
-	}
+	free_refs(unmatched);
 
 	*refs = newlist;
 }
-- 
2.21.0.931.gd0bc72a411

