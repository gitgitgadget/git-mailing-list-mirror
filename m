Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B642023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbcGHJMv (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:12:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:41877 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754317AbcGHJMp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:12:45 -0400
Received: (qmail 5138 invoked by uid 102); 8 Jul 2016 09:12:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:12:46 -0400
Received: (qmail 11926 invoked by uid 107); 8 Jul 2016 09:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:13:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:12:42 -0400
Date:	Fri, 8 Jul 2016 05:12:42 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] write_file: add format attribute
Message-ID: <20160708091241.GG10152@sigill.intra.peff.net>
References: <20160708090400.GA26594@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This gives us compile-time checking of our format strings,
which is a good thing.

I had also hoped it would help with confusing write_file()
and write_file_buf(), since the former's "..." can make it
match the signature of the latter. But given that the buffer
for write_file_buf() is generally not a string literal, the
compiler won't complain unless -Wformat-nonliteral is on,
and that creates a ton of false positives elsewhere in the
code base.

While we're there, let's also give the function a docstring,
which it never had.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cache.h b/cache.h
index 9d6ad4f..c6a282c 100644
--- a/cache.h
+++ b/cache.h
@@ -1751,6 +1751,14 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
  */
 extern void write_file_buf(const char *path, const char *buf, size_t len);
 
+/**
+ * Like write_file_buf(), but format the contents into a buffer first.
+ * Additionally, write_file() will append a newline if one is not already
+ * present, making it convenient to write text files:
+ *
+ *   write_file(path, "counter: %d", ctr);
+ */
+__attribute__((format (printf, 2, 3)))
 extern void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
-- 
2.9.0.393.g704e522

