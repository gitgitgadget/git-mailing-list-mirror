From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] strbuf.h: drop boilerplate descriptions of strbuf_split_*
Date: Fri, 16 Jan 2015 04:05:57 -0500
Message-ID: <20150116090556.GF31113@peff.net>
References: <20150116090225.GA30797@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 10:06:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YC2r3-0003yl-UD
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 10:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbbAPJGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 04:06:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:35444 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752142AbbAPJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 04:05:59 -0500
Received: (qmail 3014 invoked by uid 102); 16 Jan 2015 09:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 03:05:59 -0600
Received: (qmail 23525 invoked by uid 107); 16 Jan 2015 09:06:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jan 2015 04:06:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jan 2015 04:05:57 -0500
Content-Disposition: inline
In-Reply-To: <20150116090225.GA30797@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262545>

The description of strbuf_split_buf says most of what
needs to be said for all of the split variants that take
strings, raw memory, etc. We have a boilerplate comment
above each that points to the first. This boilerplate
ends up making it harder to read, because it spaces out the
functions, which could otherwise be read as a group.

Let's drop the boilerplate completely, and mention the
variants in the top comment. This is perhaps slightly worse
for a hypothetical system which pulls the documentation for
each function out of the comment immediately preceding it.
But such a system does not yet exist, and anyway, the end
result of extracting the boilerplate comments would not lead
to a very easy-to-read result.  We would do better in the
long run to teach the extraction system about groups of
related functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 6fa7156..61c9c73 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -441,36 +441,29 @@ static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
  * substring containing everything following the (max-1)th terminator
  * character).
  *
+ * The most generic form is `strbuf_split_buf`, which takes an arbitrary
+ * pointer/len buffer. The `_str` variant takes a NUL-terminated string,
+ * the `_max` variant takes a strbuf, and just `strbuf_split` is a convenience
+ * wrapper to drop the `max` parameter.
+ *
  * For lighter-weight alternatives, see string_list_split() and
  * string_list_split_in_place().
  */
 extern struct strbuf **strbuf_split_buf(const char *, size_t,
 					int terminator, int max);
 
-/**
- * Split a NUL-terminated string at the specified terminator
- * character.  See strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split_str(const char *str,
 					       int terminator, int max)
 {
 	return strbuf_split_buf(str, strlen(str), terminator, max);
 }
 
-/**
- * Split a strbuf at the specified terminator character.  See
- * strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,
 						int terminator, int max)
 {
 	return strbuf_split_buf(sb->buf, sb->len, terminator, max);
 }
 
-/**
- * Split a strbuf at the specified terminator character.  See
- * strbuf_split_buf() for more information.
- */
 static inline struct strbuf **strbuf_split(const struct strbuf *sb,
 					   int terminator)
 {
-- 
2.2.1.425.g441bb3c
