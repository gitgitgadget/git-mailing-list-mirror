Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00071C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC71823977
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgI0IkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:40:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:42422 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgI0IkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:40:10 -0400
Received: (qmail 29195 invoked by uid 109); 27 Sep 2020 08:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:40:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4111 invoked by uid 111); 27 Sep 2020 08:40:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:40:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:40:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: [PATCH v2 6/8] shortlog: rename parse_stdin_ident()
Message-ID: <20200927084009.GF2465761@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927083933.GA2222823@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is actually useful for parsing any identity, whether from
stdin or not. We'll need it for handling trailers.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d2d8103dd3..e6f4faec7c 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -98,8 +98,8 @@ static void insert_one_record(struct shortlog *log,
 	}
 }
 
-static int parse_stdin_ident(struct shortlog *log,
-			     struct strbuf *out, const char *in)
+static int parse_ident(struct shortlog *log,
+		       struct strbuf *out, const char *in)
 {
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
@@ -156,7 +156,7 @@ static void read_from_stdin(struct shortlog *log)
 			; /* discard blanks */
 
 		strbuf_reset(&mapped_ident);
-		if (parse_stdin_ident(log, &mapped_ident, v) < 0)
+		if (parse_ident(log, &mapped_ident, v) < 0)
 			continue;
 
 		insert_one_record(log, mapped_ident.buf, oneline.buf);
-- 
2.28.0.1127.ga65787d918

