From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/86] wt-status: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:04 +0100
Message-ID: <20131109070720.18178.3070.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2ha-0005PQ-Ni
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368Ab3KIHLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:16 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54103 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933230Ab3KIHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:25 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 217DE5C;
	Sat,  9 Nov 2013 08:08:24 +0100 (CET)
X-git-sha1: 57f7327ecc20e3705122c2663da90744008daad1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237533>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 wt-status.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index b4e44ba..47806d1 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -803,7 +803,7 @@ static void wt_status_print_tracking(struct wt_status *s)
 	int i;
 
 	assert(s->branch && !s->is_initial);
-	if (prefixcmp(s->branch, "refs/heads/"))
+	if (!has_prefix(s->branch, "refs/heads/"))
 		return;
 	branch = branch_get(s->branch + 11);
 	if (!format_tracking_info(branch, &sb))
@@ -1062,9 +1062,9 @@ static char *read_and_strip_branch(const char *path)
 		strbuf_setlen(&sb, sb.len - 1);
 	if (!sb.len)
 		goto got_nothing;
-	if (!prefixcmp(sb.buf, "refs/heads/"))
+	if (has_prefix(sb.buf, "refs/heads/"))
 		strbuf_remove(&sb,0, strlen("refs/heads/"));
-	else if (!prefixcmp(sb.buf, "refs/"))
+	else if (has_prefix(sb.buf, "refs/"))
 		;
 	else if (!get_sha1_hex(sb.buf, sha1)) {
 		const char *abbrev;
@@ -1094,7 +1094,7 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 	struct grab_1st_switch_cbdata *cb = cb_data;
 	const char *target = NULL, *end;
 
-	if (prefixcmp(message, "checkout: moving from "))
+	if (!has_prefix(message, "checkout: moving from "))
 		return 0;
 	message += strlen("checkout: moving from ");
 	target = strstr(message, " to ");
@@ -1129,9 +1129,9 @@ static void wt_status_get_detached_from(struct wt_status_state *state)
 	     ((commit = lookup_commit_reference_gently(sha1, 1)) != NULL &&
 	      !hashcmp(cb.nsha1, commit->object.sha1)))) {
 		int ofs;
-		if (!prefixcmp(ref, "refs/tags/"))
+		if (has_prefix(ref, "refs/tags/"))
 			ofs = strlen("refs/tags/");
-		else if (!prefixcmp(ref, "refs/remotes/"))
+		else if (has_prefix(ref, "refs/remotes/"))
 			ofs = strlen("refs/remotes/");
 		else
 			ofs = 0;
@@ -1220,7 +1220,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
-		if (!prefixcmp(branch_name, "refs/heads/"))
+		if (has_prefix(branch_name, "refs/heads/"))
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
@@ -1421,7 +1421,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	branch_name = s->branch;
 
-	if (!prefixcmp(branch_name, "refs/heads/"))
+	if (has_prefix(branch_name, "refs/heads/"))
 		branch_name += 11;
 	else if (!strcmp(branch_name, "HEAD")) {
 		branch_name = _("HEAD (no branch)");
-- 
1.8.4.1.566.geca833c
