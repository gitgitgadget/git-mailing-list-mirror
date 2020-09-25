Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC40C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E34AD22211
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgIYHFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:05:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:40442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgIYHFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:05:19 -0400
Received: (qmail 13175 invoked by uid 109); 25 Sep 2020 07:05:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:05:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16020 invoked by uid 111); 25 Sep 2020 07:05:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:05:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:05:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/8] shortlog: rename parse_stdin_ident()
Message-ID: <20200925070518.GF62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
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
2.28.0.1085.g44a0350633

