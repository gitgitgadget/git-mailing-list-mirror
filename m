From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/86] upload-pack: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:05 +0100
Message-ID: <20131109070720.18178.39708.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2ha-0005PQ-4j
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933366Ab3KIHLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:14 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36291 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232Ab3KIHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 8EBB8A4;
	Sat,  9 Nov 2013 08:08:24 +0100 (CET)
X-git-sha1: b3c853f4d0d23f00949d4371e4e0832e80c5c833 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237530>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index a6c54e0..ce4ae75 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -394,7 +394,7 @@ static int get_common_commits(void)
 			got_other = 0;
 			continue;
 		}
-		if (!prefixcmp(line, "have ")) {
+		if (has_prefix(line, "have ")) {
 			switch (got_sha1(line+5, sha1)) {
 			case -1: /* they have what we do not */
 				got_other = 1;
@@ -540,7 +540,7 @@ static void receive_needs(void)
 		if (!line)
 			break;
 
-		if (!prefixcmp(line, "shallow ")) {
+		if (has_prefix(line, "shallow ")) {
 			unsigned char sha1[20];
 			struct object *object;
 			if (get_sha1_hex(line + 8, sha1))
@@ -556,14 +556,14 @@ static void receive_needs(void)
 			}
 			continue;
 		}
-		if (!prefixcmp(line, "deepen ")) {
+		if (has_prefix(line, "deepen ")) {
 			char *end;
 			depth = strtol(line + 7, &end, 0);
 			if (end == line + 7 || depth <= 0)
 				die("Invalid deepen: %s", line);
 			continue;
 		}
-		if (prefixcmp(line, "want ") ||
+		if (!has_prefix(line, "want ") ||
 		    get_sha1_hex(line+5, sha1_buf))
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
@@ -777,7 +777,7 @@ int main(int argc, char **argv)
 			strict = 1;
 			continue;
 		}
-		if (!prefixcmp(arg, "--timeout=")) {
+		if (has_prefix(arg, "--timeout=")) {
 			timeout = atoi(arg+10);
 			daemon_mode = 1;
 			continue;
-- 
1.8.4.1.566.geca833c
