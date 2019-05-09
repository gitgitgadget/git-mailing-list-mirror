Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF851F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEIVbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:31:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:53714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726219AbfEIVbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:31:48 -0400
Received: (qmail 10104 invoked by uid 109); 9 May 2019 21:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:31:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6577 invoked by uid 111); 9 May 2019 21:32:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:32:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:31:46 -0400
Date:   Thu, 9 May 2019 17:31:46 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/14] remove_all_fetch_refspecs(): drop unused "remote"
 parameter
Message-ID: <20190509213146.GK15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function already takes a "key" parameter which uniquely identifies
the config key that we need to remove. There's no need for it to look at
the "remote" parameter at all. Let's drop it in the name of simplicity.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f7edf7f2cb..5591cef775 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1407,7 +1407,7 @@ static int update(int argc, const char **argv)
 	return retval;
 }
 
-static int remove_all_fetch_refspecs(const char *remote, const char *key)
+static int remove_all_fetch_refspecs(const char *key)
 {
 	return git_config_set_multivar_gently(key, NULL, NULL, 1);
 }
@@ -1437,7 +1437,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	if (!remote_is_configured(remote, 1))
 		die(_("No such remote '%s'"), remotename);
 
-	if (!add_mode && remove_all_fetch_refspecs(remotename, key.buf)) {
+	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
 		strbuf_release(&key);
 		return 1;
 	}
-- 
2.21.0.1382.g4c6032d436

