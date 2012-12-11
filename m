From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 2/2] strbuf_add_wrapped*(): Remove unused return value
Date: Tue, 11 Dec 2012 06:59:22 +0100
Message-ID: <1355205562-23459-3-git-send-email-prohaska@zib.de>
References: <7v8v97efdv.fsf@alter.siamese.dyndns.org>
 <1355205562-23459-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, "Jan H. Schoenherr" <schnhrr@cs.tu-berlin.de>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiItd-0000vB-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 07:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab2LKGAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 01:00:23 -0500
Received: from mailer.zib.de ([130.73.108.11]:61159 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2LKGAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 01:00:21 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id qBB5xulP024501;
	Tue, 11 Dec 2012 07:00:01 +0100 (CET)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id qBB5xabP025369;
	Tue, 11 Dec 2012 06:59:56 +0100 (MET)
X-Mailer: git-send-email 1.7.12.1.429.gf87fa45
In-Reply-To: <1355205562-23459-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211281>

Since shortlog isn't using the return value anymore (see previous
commit), the functions can be changed to void.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 utf8.c | 13 ++++++-------
 utf8.h |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/utf8.c b/utf8.c
index 5c61bbe..a4ee665 100644
--- a/utf8.c
+++ b/utf8.c
@@ -323,7 +323,7 @@ static size_t display_mode_esc_sequence_len(const char *s)
  * If indent is negative, assume that already -indent columns have been
  * consumed (and no extra indent is necessary for the first line).
  */
-int strbuf_add_wrapped_text(struct strbuf *buf,
+void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent1, int indent2, int width)
 {
 	int indent, w, assume_utf8 = 1;
@@ -332,7 +332,7 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 
 	if (width <= 0) {
 		strbuf_add_indented_text(buf, text, indent1, indent2);
-		return 1;
+		return;
 	}
 
 retry:
@@ -356,14 +356,14 @@ retry:
 			if (w <= width || !space) {
 				const char *start = bol;
 				if (!c && text == start)
-					return w;
+					return;
 				if (space)
 					start = space;
 				else
 					strbuf_addchars(buf, ' ', indent);
 				strbuf_add(buf, start, text - start);
 				if (!c)
-					return w;
+					return;
 				space = text;
 				if (c == '\t')
 					w |= 0x07;
@@ -405,13 +405,12 @@ new_line:
 	}
 }
 
-int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
+void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
 			     int indent, int indent2, int width)
 {
 	char *tmp = xstrndup(data, len);
-	int r = strbuf_add_wrapped_text(buf, tmp, indent, indent2, width);
+	strbuf_add_wrapped_text(buf, tmp, indent, indent2, width);
 	free(tmp);
-	return r;
 }
 
 int is_encoding_utf8(const char *name)
diff --git a/utf8.h b/utf8.h
index 93ef600..a214238 100644
--- a/utf8.h
+++ b/utf8.h
@@ -9,9 +9,9 @@ int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
 
-int strbuf_add_wrapped_text(struct strbuf *buf,
+void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
-int strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
+void strbuf_add_wrapped_bytes(struct strbuf *buf, const char *data, int len,
 			     int indent, int indent2, int width);
 
 #ifndef NO_ICONV
-- 
1.8.1.rc1.2.gfb98a3a
