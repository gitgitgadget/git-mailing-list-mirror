Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188E01F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeESB6C (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:58:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbeESB6B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:58:01 -0400
Received: (qmail 9247 invoked by uid 109); 19 May 2018 01:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:58:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15890 invoked by uid 111); 19 May 2018 01:58:08 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:58:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:57:58 -0700
Date:   Fri, 18 May 2018 18:57:58 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] query_fsmonitor: use xsnprintf for formatting integers
Message-ID: <20180519015758.GC32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180519015444.GA12080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These formatted integers should always fit into their
64-byte buffers. Let's use xsnprintf() to add an assertion
that this is the case, which makes auditing for other
unchecked snprintfs() easier.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsmonitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ed3d1a074d..cc19b27e1d 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -104,8 +104,8 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que
 	if (!(argv[0] = core_fsmonitor))
 		return -1;
 
-	snprintf(ver, sizeof(ver), "%d", version);
-	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
+	xsnprintf(ver, sizeof(ver), "%d", version);
+	xsnprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
 	argv[1] = ver;
 	argv[2] = date;
 	argv[3] = NULL;
-- 
2.17.0.1052.g7d69f75dbf

