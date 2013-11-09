From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 30/86] http-push: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:23 +0100
Message-ID: <20131109070720.18178.17480.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2h9-0004uI-W3
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933353Ab3KIHKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:48 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54171 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933269Ab3KIHIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:35 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 4FBDA96;
	Sat,  9 Nov 2013 08:08:32 +0100 (CET)
X-git-sha1: a3d73b5cd6f86948be326c6b7de57c883a284c6a 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237521>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 http-push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-push.c b/http-push.c
index 69200ba..0994344 100644
--- a/http-push.c
+++ b/http-push.c
@@ -771,7 +771,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 			lock->owner = xmalloc(strlen(ctx->cdata) + 1);
 			strcpy(lock->owner, ctx->cdata);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TIMEOUT)) {
-			if (!prefixcmp(ctx->cdata, "Second-"))
+			if (has_prefix(ctx->cdata, "Second-"))
 				lock->timeout =
 					strtol(ctx->cdata + 7, NULL, 10);
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
@@ -1579,7 +1579,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 		return;
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
-	if (!prefixcmp((char *)buffer.buf, "ref: ")) {
+	if (has_prefix((char *)buffer.buf, "ref: ")) {
 		*symref = xmemdupz((char *)buffer.buf + 5, buffer.len - 6);
 	} else {
 		get_sha1_hex(buffer.buf, sha1);
-- 
1.8.4.1.566.geca833c
