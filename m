Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38701F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeESB6s (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:58:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:46192 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbeESB6r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:58:47 -0400
Received: (qmail 9309 invoked by uid 109); 19 May 2018 01:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:58:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15922 invoked by uid 111); 19 May 2018 01:58:54 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:58:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:58:44 -0700
Date:   Fri, 18 May 2018 18:58:44 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/5] fmt_with_err: add a comment that truncation is OK
Message-ID: <20180519015843.GE32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180519015444.GA12080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions like die_errno() use fmt_with_err() to combine the
caller-provided format with the strerror() string. We use a
fixed stack buffer because we're already handling an error
and don't have any way to report another one. Our buffer
should generally be big enough to fit this, but if it's not,
truncation is our best option. Let's add a comment to that
effect, so that anybody auditing the code for truncation
bugs knows that this is fine.

Signed-off-by: Jeff King <peff@peff.net>
---
 usage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/usage.c b/usage.c
index cdd534c9df..b3c78931ad 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,7 @@ static const char *fmt_with_err(char *buf, int n, const char *fmt)
 		}
 	}
 	str_error[j] = 0;
+	/* Truncation is acceptable here */
 	snprintf(buf, n, "%s: %s", fmt, str_error);
 	return buf;
 }
-- 
2.17.0.1052.g7d69f75dbf
