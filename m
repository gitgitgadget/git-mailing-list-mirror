Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 687161F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGXKcN (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:32:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:57170 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726189AbeGXKcN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:32:13 -0400
Received: (qmail 7681 invoked by uid 109); 24 Jul 2018 09:26:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:26:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25621 invoked by uid 111); 24 Jul 2018 09:26:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:26:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:26:39 -0400
Date:   Tue, 24 Jul 2018 05:26:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] banned.h: mark strcat() as banned
Message-ID: <20180724092639.GB3288@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724092329.GA24250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strcat() function has all of the same overflow problems
as strcpy(). And as a bonus, it's easy to end up
accidentally quadratic, as each subsequent call has to walk
through the existing string.

The last strcat() call went away in f063d38b80 (daemon: use
cld->env_array when re-spawning, 2015-09-24). In general,
strcat() can be replaced either with a dynamic string
(strbuf or xstrfmt), or with xsnprintf if you know the
length is bounded.

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/banned.h b/banned.h
index c50091ad7d..32e0bae01d 100644
--- a/banned.h
+++ b/banned.h
@@ -12,5 +12,7 @@
 
 #undef strcpy
 #define strcpy(x,y) BANNED(strcpy)
+#undef strcat
+#define strcat(x,y) BANNED(strcat)
 
 #endif /* BANNED_H */
-- 
2.18.0.542.g2bf2fc4f7e

