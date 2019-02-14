Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F641F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405194AbfBNFs3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:48:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:43722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726129AbfBNFs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:48:29 -0500
Received: (qmail 744 invoked by uid 109); 14 Feb 2019 05:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:48:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6841 invoked by uid 111); 14 Feb 2019 05:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:48:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:48:27 -0500
Date:   Thu, 14 Feb 2019 00:48:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 03/10] diff: drop unused emit data parameter from
 sane_truncate_line()
Message-ID: <20190214054827.GC20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass the "struct emit_callback" (which contains all of the context
for our diff) into sane_truncate_line(), but that function doesn't
actually use it. In theory we might eventually develop a diff option
that impacts this, but in the meantime let's not mislead anybody reading
the code. Since the function is static, it would be easy to pass it
again if it should ever become useful.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index de45bbd76e..d24843b531 100644
--- a/diff.c
+++ b/diff.c
@@ -2287,7 +2287,7 @@ const char *diff_line_prefix(struct diff_options *opt)
 	return msgbuf->buf;
 }
 
-static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
+static unsigned long sane_truncate_line(char *line, unsigned long len)
 {
 	const char *cp;
 	unsigned long allot;
@@ -2351,7 +2351,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	if (line[0] == '@') {
 		if (ecbdata->diff_words)
 			diff_words_flush(ecbdata);
-		len = sane_truncate_line(ecbdata, line, len);
+		len = sane_truncate_line(line, len);
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
 		return;
-- 
2.21.0.rc1.567.g648f076c3f

