From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] pretty: make show_ident_date public
Date: Thu, 1 May 2014 21:07:22 -0400
Message-ID: <20140502010722.GB25413@sigill.intra.peff.net>
References: <20140502010328.GA30556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:07:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1wm-0007B5-K6
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbaEBBHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:07:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43263 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbaEBBHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 21:07:24 -0400
Received: (qmail 27984 invoked by uid 102); 2 May 2014 01:07:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 20:07:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 21:07:22 -0400
Content-Disposition: inline
In-Reply-To: <20140502010328.GA30556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247915>

We use this function internally to format "Date" lines in
commit logs, but other parts of the code will want it, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  | 7 +++++++
 pretty.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 107ac61..dd9e689 100644
--- a/cache.h
+++ b/cache.h
@@ -1046,6 +1046,13 @@ struct ident_split {
 extern int split_ident_line(struct ident_split *, const char *, int);
 
 /*
+ * Like show_date, but pull the timestamp and tz parameters from
+ * the ident_split. It will also sanity-check the values and produce
+ * a well-known sentinel date if they appear bogus.
+ */
+const char *show_ident_date(const struct ident_split *id, enum date_mode mode);
+
+/*
  * Compare split idents for equality or strict ordering. Note that we
  * compare only the ident part of the line, ignoring any timestamp.
  *
diff --git a/pretty.c b/pretty.c
index 3c43db5..e1e2cad 100644
--- a/pretty.c
+++ b/pretty.c
@@ -393,8 +393,8 @@ static void add_rfc2047(struct strbuf *sb, const char *line, size_t len,
 	strbuf_addstr(sb, "?=");
 }
 
-static const char *show_ident_date(const struct ident_split *ident,
-				   enum date_mode mode)
+const char *show_ident_date(const struct ident_split *ident,
+			    enum date_mode mode)
 {
 	unsigned long date = 0;
 	long tz = 0;
-- 
1.9.1.656.ge8a0637
