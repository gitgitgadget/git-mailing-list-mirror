Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5316D1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeKEQAt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:00:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:40396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728955AbeKEQAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:00:49 -0500
Received: (qmail 21827 invoked by uid 109); 5 Nov 2018 06:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:42:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17193 invoked by uid 111); 5 Nov 2018 06:41:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:41:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:42:40 -0500
Date:   Mon, 5 Nov 2018 01:42:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/13] show-branch: mark --reflog option as NONEG
Message-ID: <20181105064240.GH25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running "git show-branch --no-reflog" will behave as if "--reflog" was
given with no options, which makes no sense.

In theory this option might be used to cancel an earlier "--reflog"
option, but the semantics are not clear. Let's punt on it and just
disallow the broken option.

Signed-off-by: Jeff King <peff@peff.net>
---
On most of these I tried to decide whether there was a sensible
behavior, and actually do the fix. But I have to admit I have no idea
how "show-branch -g" is supposed to work, which is the main reason I
punted here. If somebody cares enough to write a patch, they can
supersede this (but we should do something, because the current behavior
is nonsense).

 builtin/show-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 65f4a4c83c..b1b540f7f6 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -674,7 +674,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
-			    PARSE_OPT_OPTARG,
+			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			    parse_reflog_param },
 		OPT_END()
 	};
-- 
2.19.1.1505.g9cd28186cf

