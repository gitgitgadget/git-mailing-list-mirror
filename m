Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07A9F1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdBHVBb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:01:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:51791 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbdBHVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:01:23 -0500
Received: (qmail 28458 invoked by uid 109); 8 Feb 2017 20:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:15 +0000
Received: (qmail 6942 invoked by uid 111); 8 Feb 2017 20:53:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:13 -0500
Date:   Wed, 8 Feb 2017 15:53:13 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/11] receive-pack: fix misleading namespace/.have comment
Message-ID: <20170208205313.mxwr7bqq4qbexj5q@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The comment claims that we handle alternate ".have" lines
through this function, but that hasn't been the case since
85f251045 (write_head_info(): handle "extra refs" locally,
2012-01-06).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a4926fcfb..1821ad5fa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -261,10 +261,7 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	/*
 	 * Advertise refs outside our current namespace as ".have"
 	 * refs, so that the client can use them to minimize data
-	 * transfer but will otherwise ignore them. This happens to
-	 * cover ".have" that are thrown in by add_one_alternate_ref()
-	 * to mark histories that are complete in our alternates as
-	 * well.
+	 * transfer but will otherwise ignore them.
 	 */
 	if (!path)
 		path = ".have";
-- 
2.12.0.rc0.371.ga6cf8653b

