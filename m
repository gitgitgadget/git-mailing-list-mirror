From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 17/86] tag: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:10 +0100
Message-ID: <20131109070720.18178.87446.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fB-0002lM-Mt
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637Ab3KIHIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:51 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54121 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932763Ab3KIHI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id B505A83;
	Sat,  9 Nov 2013 08:08:26 +0100 (CET)
X-git-sha1: 6ed83dadb50b3095bb34b62315f5ab6f2ac11ee9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237488>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 tag.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tag.c b/tag.c
index 78d272b..0b00c76 100644
--- a/tag.c
+++ b/tag.c
@@ -86,7 +86,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 		return -1;
 	bufptr += 48; /* "object " + sha1 + "\n" */
 
-	if (prefixcmp(bufptr, "type "))
+	if (!has_prefix(bufptr, "type "))
 		return -1;
 	bufptr += 5;
 	nl = memchr(bufptr, '\n', tail - bufptr);
@@ -109,7 +109,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 		item->tagged = NULL;
 	}
 
-	if (bufptr + 4 < tail && !prefixcmp(bufptr, "tag "))
+	if (bufptr + 4 < tail && has_prefix(bufptr, "tag "))
 		; 		/* good */
 	else
 		return -1;
@@ -120,7 +120,7 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
 	item->tag = xmemdupz(bufptr, nl - bufptr);
 	bufptr = nl + 1;
 
-	if (bufptr + 7 < tail && !prefixcmp(bufptr, "tagger "))
+	if (bufptr + 7 < tail && has_prefix(bufptr, "tagger "))
 		item->date = parse_tag_date(bufptr, tail);
 	else
 		item->date = 0;
@@ -160,8 +160,8 @@ size_t parse_signature(const char *buf, unsigned long size)
 {
 	char *eol;
 	size_t len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE) &&
-			prefixcmp(buf + len, PGP_MESSAGE)) {
+	while (len < size && !has_prefix(buf + len, PGP_SIGNATURE) &&
+			!has_prefix(buf + len, PGP_MESSAGE)) {
 		eol = memchr(buf + len, '\n', size - len);
 		len += eol ? eol - (buf + len) + 1 : size - len;
 	}
-- 
1.8.4.1.566.geca833c
