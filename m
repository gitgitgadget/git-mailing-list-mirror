Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA33D20248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCTIOJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:14:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:57416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725942AbfCTIOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:14:09 -0400
Received: (qmail 19609 invoked by uid 109); 20 Mar 2019 08:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6299 invoked by uid 111); 20 Mar 2019 08:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:14:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:14:07 -0400
Date:   Wed, 20 Mar 2019 04:14:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/13] update-index: drop unused prefix_length parameter from
 do_reupdate()
Message-ID: <20190320081407.GD10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prefix is always a NUL-terminated string, and we just end up passing
it along to parse_pathspec() anyway (which does not even take a length).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/update-index.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1b6c42f748..ff5cfd1194 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -724,7 +724,7 @@ static int do_unresolve(int ac, const char **av,
 }
 
 static int do_reupdate(int ac, const char **av,
-		       const char *prefix, int prefix_length)
+		       const char *prefix)
 {
 	/* Read HEAD and run update-index on paths that are
 	 * merged and already different between index and HEAD.
@@ -940,8 +940,7 @@ static enum parse_opt_result reupdate_callback(
 
 	/* consume remaining arguments. */
 	setup_work_tree();
-	*has_errors = do_reupdate(ctx->argc, ctx->argv,
-				prefix, prefix ? strlen(prefix) : 0);
+	*has_errors = do_reupdate(ctx->argc, ctx->argv, prefix);
 	if (*has_errors)
 		active_cache_changed = 0;
 
-- 
2.21.0.701.g4401309e11

