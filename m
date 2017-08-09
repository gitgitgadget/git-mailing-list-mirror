Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D6F1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdHIMCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 08:02:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:33164 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752409AbdHIMCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 08:02:10 -0400
Received: (qmail 1891 invoked by uid 109); 9 Aug 2017 12:02:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 12:02:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26502 invoked by uid 111); 9 Aug 2017 12:02:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 08:02:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 08:02:07 -0400
Date:   Wed, 9 Aug 2017 08:02:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] http: #error on too-old curl
Message-ID: <20170809120207.amjpwhxz3evjci6x@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already fail to build with versions of curl older than
7.19.4. But doing an explicit check with an #error has two
benefits.

One is that it makes it clear to users that the build
failure is intentional, so they don't waste time trying to
debug it.

And two is that it documents our current "too old"
assumption, so that we know whether we need use an #ifdef
when using newer curl features in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.h b/http.h
index da4d8589d8..29acfe8c55 100644
--- a/http.h
+++ b/http.h
@@ -10,6 +10,10 @@
 #include "remote.h"
 #include "url.h"
 
+#if LIBCURL_VERSION_NUM < 0x071304
+#error "your libcurl version is too old; Git requires curl >= 7.19.4"
+#endif
+
 #define DEFAULT_MAX_REQUESTS 5
 
 /*
-- 
2.14.0.609.gd2d1f7ddf
