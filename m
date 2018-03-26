Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5E51F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 07:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeCZH3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 03:29:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:42882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbeCZH3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 03:29:24 -0400
Received: (qmail 3447 invoked by uid 109); 26 Mar 2018 07:29:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 07:29:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17423 invoked by uid 111); 26 Mar 2018 07:30:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 03:30:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 03:29:22 -0400
Date:   Mon, 26 Mar 2018 03:29:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 4/5] branch: drop deprecated "-l" option
Message-ID: <20180326072922.GD12530@sigill.intra.peff.net>
References: <20180326072505.GA12436@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180326072505.GA12436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We marked the "-l" option as deprecated back in <insert sha1
here>. Now that sufficient time has passed, let's follow
through and get rid of it.

Signed-off-by: Jeff King <peff@peff.net>
---
I'll need some help from the maintainer on the commit message. :)

 builtin/branch.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e50a5a1680..f7cd333587 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -570,15 +570,6 @@ static int edit_branch_description(const char *branch_name)
 	return 0;
 }
 
-static int deprecated_reflog_option_cb(const struct option *opt,
-				       const char *arg, int unset)
-{
-	warning("the '-l' alias for '--create-reflog' is deprecated;");
-	warning("it will be removed in a future version of Git");
-	*(int *)opt->value = !unset;
-	return 0;
-}
-
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
@@ -622,12 +613,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
-		{
-			OPTION_CALLBACK, 'l', NULL, &reflog, NULL,
-			N_("deprecated synonym for --create-reflog"),
-			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			deprecated_reflog_option_cb
-		},
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
-- 
2.17.0.rc1.509.g060626845b

