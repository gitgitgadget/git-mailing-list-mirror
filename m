From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 12/16] strbuf: add strbuf_replace()
Date: Sun, 19 Jan 2014 09:53:50 +0100
Message-ID: <20140119085355.2734.54612.chriscool@tuxfamily.org>
References: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oAS-0008R0-03
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbaASIzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:55:39 -0500
Received: from [194.158.98.15] ([194.158.98.15]:50035 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752028AbaASIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:55:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A148434;
	Sun, 19 Jan 2014 09:54:32 +0100 (CET)
X-git-sha1: 3f7af0d23bd6b936ca867958baafcbd972b5f4bf 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240684>

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
