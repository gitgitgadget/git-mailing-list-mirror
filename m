Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 655D020953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbdCPWIy (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:08:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:45465 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbdCPWIx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:08:53 -0400
Received: (qmail 2681 invoked by uid 109); 16 Mar 2017 22:08:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 22:08:52 +0000
Received: (qmail 6465 invoked by uid 111); 16 Mar 2017 22:09:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 18:09:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 18:08:49 -0400
Date:   Thu, 16 Mar 2017 18:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/5] sha1dc: disable safe_hash feature
Message-ID: <20170316220849.ye56ycpoly2o5fg6@sigill.intra.peff.net>
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The safe_hash feature is designed to make sha1dc a drop-in
replacement for sha1, where colliding entries will get a
permuted hash to un-collide them. However, since we're
handling the collision case ourselves, this isn't helpful
(and is actually harmful, as it means you get the wrong
object id if you want to show it in a log message).

Signed-off-by: Jeff King <peff@peff.net>
---
We could also disable this at runtime, but there's not really any point.
And this way we know that we won't miss a call.

 sha1dc/sha1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index da516c14c..00760c352 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -1661,7 +1661,7 @@ void SHA1DCInit(SHA1_CTX* ctx)
 	ctx->ihv[3] = 0x10325476;
 	ctx->ihv[4] = 0xC3D2E1F0;
 	ctx->found_collision = 0;
-	ctx->safe_hash = 1;
+	ctx->safe_hash = 0;
 	ctx->ubc_check = 1;
 	ctx->detect_coll = 1;
 	ctx->reduced_round_coll = 0;
-- 
2.12.0.623.g86ec6c963

