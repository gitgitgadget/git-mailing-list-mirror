Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C936B20248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfDKNsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:48:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726145AbfDKNsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:48:16 -0400
Received: (qmail 7126 invoked by uid 109); 11 Apr 2019 13:48:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Apr 2019 13:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27834 invoked by uid 111); 11 Apr 2019 13:48:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Apr 2019 09:48:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2019 09:48:14 -0400
Date:   Thu, 11 Apr 2019 09:48:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?546L5YGl5by6?= <jianqiang.wang@securitygossip.com>
Subject: [PATCH 1/4] test-prio-queue: use xmalloc
Message-ID: <20190411134814.GA9182@sigill.intra.peff.net>
References: <20190411134736.GA28543@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411134736.GA28543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test-prio-queue.c doesn't check the return value of malloc, and could
segfault.

It's unlikely for this to matter in practice; it's a small allocation,
and this code isn't even installed alongside the rest of Git. But let's
use xmalloc(), which makes auditing for other accidental uses of bare
malloc() easier.

Reported-by: 王健强 <jianqiang.wang@securitygossip.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-prio-queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 5bc9c46ea5..f4028442e3 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -40,7 +40,7 @@ int cmd__prio_queue(int argc, const char **argv)
 		} else if (!strcmp(*argv, "stack")) {
 			pq.compare = NULL;
 		} else {
-			int *v = malloc(sizeof(*v));
+			int *v = xmalloc(sizeof(*v));
 			*v = atoi(*argv);
 			prio_queue_put(&pq, v);
 		}
-- 
2.21.0.922.g1a559e573c

