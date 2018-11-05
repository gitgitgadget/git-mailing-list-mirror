Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A291F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbeKEP7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:59:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:40384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:59:02 -0500
Received: (qmail 21722 invoked by uid 109); 5 Nov 2018 06:40:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:40:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17160 invoked by uid 111); 5 Nov 2018 06:40:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:40:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:40:53 -0500
Date:   Mon, 5 Nov 2018 01:40:53 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/13] status: mark --find-renames option with NONEG
Message-ID: <20181105064053.GF25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you run "git status --no-find-renames", it will behave the same as
"--find-renames", because we ignore the "unset" parameter (we see a NULL
"arg", but since the score argument is optional, we just think that the
user did not provide a score).

We already have a separate "--no-renames" to disable renames, so there's
not much point in supporting "--no-find-renames". Let's just flag it as
an error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 074bd9a551..4d7754ca43 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1335,7 +1335,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
 		{ OPTION_CALLBACK, 'M', "find-renames", &rename_score_arg,
 		  N_("n"), N_("detect renames, optionally set similarity index"),
-		  PARSE_OPT_OPTARG, opt_parse_rename_score },
+		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, opt_parse_rename_score },
 		OPT_END(),
 	};
 
-- 
2.19.1.1505.g9cd28186cf

