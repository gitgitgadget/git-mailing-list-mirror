Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDF320A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdAXArw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:47:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:43574 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbdAXArt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:47:49 -0500
Received: (qmail 10075 invoked by uid 109); 24 Jan 2017 00:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:47:47 +0000
Received: (qmail 11541 invoked by uid 111); 24 Jan 2017 00:48:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:48:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:47:45 -0500
Date:   Mon, 23 Jan 2017 19:47:45 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/12] receive-pack: fix misleading namespace/.have comment
Message-ID: <20170124004745.pbs6ckmw5vge44dv@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
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
index 27bb52988..8f8762e4a 100644
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
2.11.0.765.g454d2182f

