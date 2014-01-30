From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 12/17] strbuf: add strbuf_replace()
Date: Thu, 30 Jan 2014 07:49:15 +0100
Message-ID: <20140130064921.7504.3401.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mCs-0005Q7-RS
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbaA3HiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:24 -0500
Received: from [194.158.98.14] ([194.158.98.14]:38490 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752817AbaA3HiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:20 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 1C89F6E;
	Thu, 30 Jan 2014 08:37:50 +0100 (CET)
X-git-sha1: 36cec4196decac15661cbc16239c3f8909ee13cf 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241250>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 strbuf.c | 7 +++++++
 strbuf.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 2124bb8..e45e513 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -197,6 +197,13 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 	strbuf_setlen(sb, sb->len + dlen - len);
 }
 
+void strbuf_replace(struct strbuf *sb, const char *a, const char *b)
+{
+	char *ptr = strstr(sb->buf, a);
+	if (ptr)
+		strbuf_splice(sb, ptr - sb->buf, strlen(a), b, strlen(b));
+}
+
 void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
 {
 	strbuf_splice(sb, pos, 0, data, len);
diff --git a/strbuf.h b/strbuf.h
index 02bff3a..38faf70 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -111,6 +111,9 @@ extern void strbuf_remove(struct strbuf *, size_t pos, size_t len);
 extern void strbuf_splice(struct strbuf *, size_t pos, size_t len,
                           const void *, size_t);
 
+/* first occurence of a replaced with b */
+extern void strbuf_replace(struct strbuf *, const char *a, const char *b);
+
 extern void strbuf_add_commented_lines(struct strbuf *out, const char *buf, size_t size);
 
 extern void strbuf_add(struct strbuf *, const void *, size_t);
-- 
1.8.5.2.201.gacc5987
