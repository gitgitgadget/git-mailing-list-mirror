From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 45/86] builtin/apply: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:38 +0100
Message-ID: <20131109070720.18178.29781.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gQ-00044O-1w
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331Ab3KIHKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:00 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65479 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933281Ab3KIHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 8F6B2A5;
	Sat,  9 Nov 2013 08:08:38 +0100 (CET)
X-git-sha1: 45f3dfc45c64be0b1f88503742d45ad6675accbd 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237510>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..49028da 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1409,10 +1409,10 @@ static void recount_diff(const char *line, int size, struct fragment *fragment)
 		case '\\':
 			continue;
 		case '@':
-			ret = size < 3 || prefixcmp(line, "@@ ");
+			ret = size < 3 || !has_prefix(line, "@@ ");
 			break;
 		case 'd':
-			ret = size < 5 || prefixcmp(line, "diff ");
+			ret = size < 5 || !has_prefix(line, "diff ");
 			break;
 		default:
 			ret = -1;
@@ -1798,11 +1798,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 
 	*status_p = 0;
 
-	if (!prefixcmp(buffer, "delta ")) {
+	if (has_prefix(buffer, "delta ")) {
 		patch_method = BINARY_DELTA_DEFLATED;
 		origlen = strtoul(buffer + 6, NULL, 10);
 	}
-	else if (!prefixcmp(buffer, "literal ")) {
+	else if (has_prefix(buffer, "literal ")) {
 		patch_method = BINARY_LITERAL_DEFLATED;
 		origlen = strtoul(buffer + 8, NULL, 10);
 	}
@@ -3627,12 +3627,12 @@ static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20
 	    hunk->oldpos == 1 && hunk->oldlines == 1 &&
 	    /* does preimage begin with the heading? */
 	    (preimage = memchr(hunk->patch, '\n', hunk->size)) != NULL &&
-	    !prefixcmp(++preimage, heading) &&
+	    has_prefix(++preimage, heading) &&
 	    /* does it record full SHA-1? */
 	    !get_sha1_hex(preimage + sizeof(heading) - 1, sha1) &&
 	    preimage[sizeof(heading) + 40 - 1] == '\n' &&
 	    /* does the abbreviated name on the index line agree with it? */
-	    !prefixcmp(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
+	    has_prefix(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
 		return 0; /* it all looks fine */
 
 	/* we may have full object name on the index line */
-- 
1.8.4.1.566.geca833c
