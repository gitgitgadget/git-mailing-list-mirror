From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 12/17] strbuf: add strbuf_replace()
Date: Sun, 26 Jan 2014 18:00:05 +0100
Message-ID: <20140126170011.24291.50133.chriscool@tuxfamily.org>
References: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 26 18:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TRQ-0004LF-CC
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbaAZRYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:24:06 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:65135 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752972AbaAZRYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:24:03 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id B04B76C;
	Sun, 26 Jan 2014 18:24:01 +0100 (CET)
X-git-sha1: 731ba402c39ac4d25d15fbc1a1101373e97b4d1d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140126165018.24291.47716.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241097>

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
