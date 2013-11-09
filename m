From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 10/86] sha1_name: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:03 +0100
Message-ID: <20131109070720.18178.85797.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hm-0005cp-Hk
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933370Ab3KIHLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:25 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54095 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933227Ab3KIHIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:24 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id A0C936C;
	Sat,  9 Nov 2013 08:08:23 +0100 (CET)
X-git-sha1: 8dfe7d17e84b80e4b643ff6a5310504f51d570c5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237534>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1_name.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 0e5fe7f..3224a39 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -547,7 +547,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
-				if (!prefixcmp(real_ref, "refs/heads/")) {
+				if (has_prefix(real_ref, "refs/heads/")) {
 					str = real_ref + 11;
 					len = strlen(real_ref + 11);
 				} else {
@@ -677,15 +677,15 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (!prefixcmp(sp, "commit}"))
+	if (has_prefix(sp, "commit}"))
 		expected_type = OBJ_COMMIT;
-	else if (!prefixcmp(sp, "tag}"))
+	else if (has_prefix(sp, "tag}"))
 		expected_type = OBJ_TAG;
-	else if (!prefixcmp(sp, "tree}"))
+	else if (has_prefix(sp, "tree}"))
 		expected_type = OBJ_TREE;
-	else if (!prefixcmp(sp, "blob}"))
+	else if (has_prefix(sp, "blob}"))
 		expected_type = OBJ_BLOB;
-	else if (!prefixcmp(sp, "object}"))
+	else if (has_prefix(sp, "object}"))
 		expected_type = OBJ_ANY;
 	else if (sp[0] == '}')
 		expected_type = OBJ_NONE;
@@ -912,7 +912,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	const char *match = NULL, *target = NULL;
 	size_t len;
 
-	if (!prefixcmp(message, "checkout: moving from ")) {
+	if (has_prefix(message, "checkout: moving from ")) {
 		match = message + strlen("checkout: moving from ");
 		target = strstr(match, " to ");
 	}
@@ -1305,7 +1305,7 @@ static void diagnose_invalid_index_path(int stage,
 
 static char *resolve_relative_path(const char *rel)
 {
-	if (prefixcmp(rel, "./") && prefixcmp(rel, "../"))
+	if (!has_prefix(rel, "./") && !has_prefix(rel, "../"))
 		return NULL;
 
 	if (!startup_info)
-- 
1.8.4.1.566.geca833c
