From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 59/86] builtin/fsck: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:52 +0100
Message-ID: <20131109070720.18178.73487.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fZ-00036C-QU
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab3KIHJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:18 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36380 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758581Ab3KIHIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:46 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 88C59B3;
	Sat,  9 Nov 2013 08:08:44 +0100 (CET)
X-git-sha1: 621c932de98423dc31ad0e5a3e35bd46f6facac5 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237496>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 97ce678..a80e51f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -442,7 +442,7 @@ static void fsck_dir(int i, char *path)
 			add_sha1_list(sha1, DIRENT_SORT_HINT(de));
 			continue;
 		}
-		if (!prefixcmp(de->d_name, "tmp_obj_"))
+		if (has_prefix(de->d_name, "tmp_obj_"))
 			continue;
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
@@ -484,7 +484,7 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 
 static int is_branch(const char *refname)
 {
-	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
+	return !strcmp(refname, "HEAD") || has_prefix(refname, "refs/heads/");
 }
 
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
@@ -566,7 +566,7 @@ static int fsck_head_link(void)
 	if (!strcmp(head_points_at, "HEAD"))
 		/* detached HEAD */
 		null_is_error = 1;
-	else if (prefixcmp(head_points_at, "refs/heads/"))
+	else if (!has_prefix(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
 	if (is_null_sha1(head_sha1)) {
-- 
1.8.4.1.566.geca833c
