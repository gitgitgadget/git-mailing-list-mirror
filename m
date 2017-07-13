Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD419202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 14:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752188AbdGMO67 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 10:58:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751201AbdGMO67 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 10:58:59 -0400
Received: (qmail 23981 invoked by uid 109); 13 Jul 2017 14:58:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:58:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32091 invoked by uid 111); 13 Jul 2017 14:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 10:59:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 10:58:56 -0400
Date:   Thu, 13 Jul 2017 10:58:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/15] ref-filter: simplify automatic color reset
Message-ID: <20170713145856.ckciq3z5fparijaz@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user-format doesn't add the closing color reset, we
add one automatically. But we do so by parsing the "reset"
string. We can just use the baked-in string literal, which
is simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ae6ecbd1c..6da5be3ac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2084,11 +2084,7 @@ void format_ref_array_item(struct ref_array_item *info, const char *format,
 	}
 	if (need_color_reset_at_eol) {
 		struct atom_value resetv;
-		char color[COLOR_MAXLEN] = "";
-
-		if (color_parse("reset", color) < 0)
-			die("BUG: couldn't parse 'reset' as a color");
-		resetv.s = color;
+		resetv.s = GIT_COLOR_RESET;
 		append_atom(&resetv, &state);
 	}
 	if (state.stack->prev)
-- 
2.13.2.1157.gc6daca446

