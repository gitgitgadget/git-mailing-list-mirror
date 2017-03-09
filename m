Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FD4B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 13:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbdCIN3H (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 08:29:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41267 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbdCIN3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 08:29:07 -0500
Received: (qmail 19603 invoked by uid 109); 9 Mar 2017 13:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:29:06 +0000
Received: (qmail 4162 invoked by uid 111); 9 Mar 2017 13:29:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 08:29:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 08:29:04 -0500
Date:   Thu, 9 Mar 2017 08:29:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/4] ref-filter: die on parse_commit errors
Message-ID: <20170309132903.om7b2uvn6vsvjiwt@sigill.intra.peff.net>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tag-contains algorithm quietly returns "does not
contain" when parse_commit() fails. But a parse failure is
an indication that the repository is corrupt. We should die
loudly rather than producing a bogus result.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 631978a4f..5cb49b7c2 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1523,9 +1523,7 @@ static enum contains_result contains_test(struct commit *candidate,
 		return CONTAINS_YES;
 	}
 
-	if (parse_commit(candidate) < 0)
-		return CONTAINS_NO;
-
+	parse_commit_or_die(candidate);
 	return CONTAINS_UNKNOWN;
 }
 
-- 
2.12.0.445.g818af77e0

