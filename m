From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 63/86] builtin/log: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:56 +0100
Message-ID: <20131109070720.18178.86174.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2mB-0002M0-2x
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933484Ab3KIHQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:16:06 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37695 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758650Ab3KIHOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:16 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 38D576E;
	Sat,  9 Nov 2013 08:14:15 +0100 (CET)
X-git-sha1: accafe9b77c15fe362c0369baa92552d2e933230 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237567>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 77d0f5f..054e663 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -390,7 +390,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
-	if (!prefixcmp(var, "color.decorate."))
+	if (has_prefix(var, "color.decorate."))
 		return parse_decorate_color_config(var, 15, value);
 	if (!strcmp(var, "log.mailmap")) {
 		use_mailmap_config = git_config_bool(var, value);
@@ -457,7 +457,7 @@ static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
 		int new_offset = offset + 1;
 		while (new_offset < size && buf[new_offset++] != '\n')
 			; /* do nothing */
-		if (!prefixcmp(buf + offset, "tagger "))
+		if (has_prefix(buf + offset, "tagger "))
 			show_tagger(buf + offset + 7,
 				    new_offset - offset - 7, rev);
 		offset = new_offset;
@@ -862,7 +862,7 @@ static char *find_branch_name(struct rev_info *rev)
 	ref = rev->cmdline.rev[positive].name;
 	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
 	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
-	    !prefixcmp(full_ref, "refs/heads/") &&
+	    has_prefix(full_ref, "refs/heads/") &&
 	    !hashcmp(tip_sha1, branch_sha1))
 		branch = xstrdup(full_ref + strlen("refs/heads/"));
 	free(full_ref);
@@ -1368,7 +1368,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			unsigned char sha1[20];
 			const char *ref;
 			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
-			if (ref && !prefixcmp(ref, "refs/heads/"))
+			if (ref && has_prefix(ref, "refs/heads/"))
 				branch_name = xstrdup(ref + strlen("refs/heads/"));
 			else
 				branch_name = xstrdup(""); /* no branch */
-- 
1.8.4.1.566.geca833c
