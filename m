Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674FA1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393029AbfJRE4j (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:56:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389158AbfJRE4j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:56:39 -0400
Received: (qmail 9425 invoked by uid 109); 18 Oct 2019 04:56:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14208 invoked by uid 111); 18 Oct 2019 04:59:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 00:59:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:56:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/23] fsck_describe_object(): build on our get_object_name()
 primitive
Message-ID: <20191018045638.GJ17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This isolates the implementation detail of using the decoration code to
our put/get functions.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably this could be squashed into the previous commit. By not doing
so, it made describe_object() more of a pure code movement.

 fsck.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index ecd5957362..b0c4de67c9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -351,10 +351,7 @@ const char *fsck_describe_object(struct fsck_options *options,
 	};
 	static int b = 0;
 	struct strbuf *buf;
-	char *name = NULL;
-
-	if (options->object_names)
-		name = lookup_decoration(options->object_names, obj);
+	const char *name = fsck_get_object_name(options, obj);
 
 	buf = bufs + b;
 	b = (b + 1) % ARRAY_SIZE(bufs);
-- 
2.23.0.1228.gee29b05929

