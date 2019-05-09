Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2501F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfEIVa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:30:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:30:58 -0400
Received: (qmail 10081 invoked by uid 109); 9 May 2019 21:30:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:30:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6526 invoked by uid 111); 9 May 2019 21:31:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:31:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:30:56 -0400
Date:   Thu, 9 May 2019 17:30:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/14] name-rev: drop unused parameters from is_better_name()
Message-ID: <20190509213056.GH15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this function was extracted in 0041bf6544 (name-rev: refactor logic
to see if a new candidate is a better name, 2017-03-29), it ended up
getting more arguments than it needs.

It's possible we may later use these values to evaluate the name, but
since it's a static function with a single caller, it will be easy to
add them back then.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/name-rev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 05ccf53e00..16df43473a 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -40,9 +40,7 @@ static void set_commit_rev_name(struct commit *commit, struct rev_name *name)
 }
 
 static int is_better_name(struct rev_name *name,
-			  const char *tip_name,
 			  timestamp_t taggerdate,
-			  int generation,
 			  int distance,
 			  int from_tag)
 {
@@ -103,8 +101,7 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		set_commit_rev_name(commit, name);
 		goto copy_data;
-	} else if (is_better_name(name, tip_name, taggerdate,
-				  generation, distance, from_tag)) {
+	} else if (is_better_name(name, taggerdate, distance, from_tag)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
-- 
2.21.0.1382.g4c6032d436

