Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1CA8207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933091AbcI3Tgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:36:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50612 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932431AbcI3Tgo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:36:44 -0400
Received: (qmail 31255 invoked by uid 109); 30 Sep 2016 19:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 19:36:44 +0000
Received: (qmail 13520 invoked by uid 111); 30 Sep 2016 19:36:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 15:36:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 15:36:42 -0400
Date:   Fri, 30 Sep 2016 15:36:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH 6/6] tmp-objdir: do not migrate files starting with '.'
Message-ID: <20160930193641.gkpcuxbbc7bei67h@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This avoids "." and "..", as we already do, but also leaves
room for index-pack to store extra data in the quarantine
area (e.g., for passing back any analysis to be read by the
pre-receive hook).

Signed-off-by: Jeff King <peff@peff.net>
---
 tmp-objdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 9f53238..2181a42 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -181,7 +181,7 @@ static int read_dir_paths(struct string_list *out, const char *path)
 		return -1;
 
 	while ((de = readdir(dh)))
-		if (!is_dot_or_dotdot(de->d_name))
+		if (de->d_name[0] != '.')
 			string_list_append(out, de->d_name);
 
 	closedir(dh);
-- 
2.10.0.618.g82cc264
