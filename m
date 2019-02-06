Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45DF91F453
	for <e@80x24.org>; Wed,  6 Feb 2019 19:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBFTfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 14:35:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:35000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726708AbfBFTfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 14:35:54 -0500
Received: (qmail 14236 invoked by uid 109); 6 Feb 2019 19:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 19:35:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4740 invoked by uid 111); 6 Feb 2019 19:36:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 14:36:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 14:35:52 -0500
Date:   Wed, 6 Feb 2019 14:35:52 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] test-date: drop unused parameter to getnanos()
Message-ID: <20190206193552.GA6539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The getnanos() helper always gets the current time from our
getnanotime() facility. The caller cannot override it via TEST_DATE_NOW,
and hence we simply ignore the "now" parameter to the function. Let's
remove it, as it may mislead callers into thinking it does something.

Signed-off-by: Jeff King <peff@peff.net>
---
This goes on the js/vsts-ci branch.

Noticed by merging 'next' with my -Wunused-parameters work-in-progress. :)

 t/helper/test-date.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 792a805374..f9e2b91ed1 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -83,7 +83,7 @@ static void parse_approx_timestamp(const char **argv, struct timeval *now)
 	}
 }
 
-static void getnanos(const char **argv, struct timeval *now)
+static void getnanos(const char **argv)
 {
 	double seconds = getnanotime() / 1.0e9;
 
@@ -119,7 +119,7 @@ int cmd__date(int argc, const char **argv)
 	else if (!strcmp(*argv, "timestamp"))
 		parse_approx_timestamp(argv+1, &now);
 	else if (!strcmp(*argv, "getnanos"))
-		getnanos(argv+1, &now);
+		getnanos(argv+1);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(timestamp_t) == 8 ? 0 : 1;
 	else if (!strcmp(*argv, "time_t-is64bit"))
-- 
2.20.1.1122.g2972e48916
