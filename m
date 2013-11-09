From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 18/86] sequencer: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:11 +0100
Message-ID: <20131109070720.18178.17858.chriscool@tuxfamily.org>
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
	id 1Vf2fA-0002lM-HM
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616Ab3KIHIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:08:46 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54125 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932785Ab3KIHI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:28 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 29EEF7B;
	Sat,  9 Nov 2013 08:08:27 +0100 (CET)
X-git-sha1: 724434dded6e4ee6c04ad7010f82fd447231b076 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237486>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sequencer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 06e52b4..64cc6f0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -41,7 +41,7 @@ static int is_cherry_picked_from_line(const char *buf, int len)
 	 * We only care that it looks roughly like (cherry picked from ...)
 	 */
 	return len > strlen(cherry_picked_prefix) + 1 &&
-		!prefixcmp(buf, cherry_picked_prefix) && buf[len - 1] == ')';
+		has_prefix(buf, cherry_picked_prefix) && buf[len - 1] == ')';
 }
 
 /*
@@ -180,7 +180,7 @@ static char *get_encoding(const char *message)
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
-		if (!prefixcmp(p, "encoding ")) {
+		if (has_prefix(p, "encoding ")) {
 			char *result = xmalloc(eol - 8 - p);
 			strlcpy(result, p + 9, eol - 8 - p);
 			return result;
@@ -705,10 +705,10 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
 	char *end_of_object_name;
 	int saved, status, padding;
 
-	if (!prefixcmp(bol, "pick")) {
+	if (has_prefix(bol, "pick")) {
 		action = REPLAY_PICK;
 		bol += strlen("pick");
-	} else if (!prefixcmp(bol, "revert")) {
+	} else if (has_prefix(bol, "revert")) {
 		action = REPLAY_REVERT;
 		bol += strlen("revert");
 	} else
-- 
1.8.4.1.566.geca833c
