Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041A020248
	for <e@80x24.org>; Wed, 20 Mar 2019 08:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbfCTIQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 04:16:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:57456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726686AbfCTIQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 04:16:44 -0400
Received: (qmail 19702 invoked by uid 109); 20 Mar 2019 08:16:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Mar 2019 08:16:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6406 invoked by uid 111); 20 Mar 2019 08:17:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 20 Mar 2019 04:17:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2019 04:16:42 -0400
Date:   Wed, 20 Mar 2019 04:16:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/13] pretty: drop unused strbuf from
 parse_padding_placeholder()
Message-ID: <20190320081642.GL10403@sigill.intra.peff.net>
References: <20190320081258.GA5621@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320081258.GA5621@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other parts of the --pretty user-format expansion,
this function is not actually writing to the output, but
instead just storing the padding values into a context
struct. We don't need to be passed a strbuf at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index f925a014f9..ced0485257 100644
--- a/pretty.c
+++ b/pretty.c
@@ -988,8 +988,7 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
 	return rest - placeholder;
 }
 
-static size_t parse_padding_placeholder(struct strbuf *sb,
-					const char *placeholder,
+static size_t parse_padding_placeholder(const char *placeholder,
 					struct format_commit_context *c)
 {
 	const char *ch = placeholder;
@@ -1194,7 +1193,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	case '<':
 	case '>':
-		return parse_padding_placeholder(sb, placeholder, c);
+		return parse_padding_placeholder(placeholder, c);
 	}
 
 	/* these depend on the commit */
-- 
2.21.0.701.g4401309e11

