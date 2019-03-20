Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FDD20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfCTIQ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:16:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:57452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727569AbfCTIQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:16:29 -0400
Received: (qmail 19695 invoked by uid 109); 20 Mar 2019 08:16:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:16:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6397 invoked by uid 111); 20 Mar 2019 08:16:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:16:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:16:27 -0400
Date:   Wed, 20 Mar 2019 04:16:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/13] parse-options: drop unused ctx parameter from
 show_gitcomp()
Message-ID: <20190320081627.GJ10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion display doesn't actually care about where we are in the
parsing. It's generated completely from the set of available options. So
we don't need to see the parse-options context struct at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cec74522e5..ade83a7b20 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -523,8 +523,7 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
 	}
 }
 
-static int show_gitcomp(struct parse_opt_ctx_t *ctx,
-			const struct option *opts)
+static int show_gitcomp(const struct option *opts)
 {
 	const struct option *original_opts = opts;
 	int nr_noopts = 0;
@@ -603,7 +602,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		/* lone --git-completion-helper is asked by git-completion.bash */
 		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
-			return show_gitcomp(ctx, options);
+			return show_gitcomp(options);
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-- 
2.21.0.701.g4401309e11

