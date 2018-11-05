Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13D361F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeKEP5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:57:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:40372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728985AbeKEP5r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:57:47 -0500
Received: (qmail 21602 invoked by uid 109); 5 Nov 2018 06:39:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:39:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17126 invoked by uid 111); 5 Nov 2018 06:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:38:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:39:38 -0500
Date:   Mon, 5 Nov 2018 01:39:38 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/13] pack-objects: mark index-version option as NONEG
Message-ID: <20181105063938.GD25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "git pack-objects --no-index-version" will segfault, since the
callback is not prepared to handle the "unset" flag.

In theory this might be used to counteract an earlier "--index-version",
or override a pack.indexversion config setting. But the semantics aren't
immediately obvious, and it's unlikely anybody wants this. Let's just
disable the broken option for now.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e50c6cd1ff..4eac2f997b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3252,7 +3252,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("similar to --all-progress when progress meter is shown")),
 		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
-		  0, option_parse_index_version },
+		  PARSE_OPT_NONEG, option_parse_index_version },
 		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
 			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
-- 
2.19.1.1505.g9cd28186cf

