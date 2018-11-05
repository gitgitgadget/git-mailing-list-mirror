Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88DB41F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeKEP7V (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:59:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:40390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:59:21 -0500
Received: (qmail 21735 invoked by uid 109); 5 Nov 2018 06:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17176 invoked by uid 111); 5 Nov 2018 06:40:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:40:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:41:12 -0500
Date:   Mon, 5 Nov 2018 01:41:12 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/13] format-patch: mark "--no-numbered" option with NONEG
Message-ID: <20181105064112.GG25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have separate parse-options entries for "numbered" and "no-numbered",
which means that we accept "--no-no-numbered". It does not behave
sensibly, though (it ignores the "unset" flag and acts like
"--no-numbered").

We could fix that, but obviously this is silly and unintentional. Let's
just disallow it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 061d4fd864..41188e723c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1508,7 +1508,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_NOARG, numbered_callback },
 		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
-			    PARSE_OPT_NOARG, no_numbered_callback },
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback },
 		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
-- 
2.19.1.1505.g9cd28186cf

