From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 67/86] builtin/merge: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:00 +0100
Message-ID: <20131109070720.18178.28589.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:14:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2kV-0000SN-5b
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932917Ab3KIHOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:14:21 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:55669 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758667Ab3KIHOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:18 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id EEC6D64;
	Sat,  9 Nov 2013 08:14:16 +0100 (CET)
X-git-sha1: da7b72bd60bc61456d4b19cf6a83f6ae0623c06d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237543>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/merge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 02a69c1..5c70cec 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -453,17 +453,17 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		die(_("'%s' does not point to a commit"), remote);
 
 	if (dwim_ref(remote, strlen(remote), branch_head, &found_ref) > 0) {
-		if (!prefixcmp(found_ref, "refs/heads/")) {
+		if (has_prefix(found_ref, "refs/heads/")) {
 			strbuf_addf(msg, "%s\t\tbranch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
-		if (!prefixcmp(found_ref, "refs/tags/")) {
+		if (has_prefix(found_ref, "refs/tags/")) {
 			strbuf_addf(msg, "%s\t\ttag '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
 		}
-		if (!prefixcmp(found_ref, "refs/remotes/")) {
+		if (has_prefix(found_ref, "refs/remotes/")) {
 			strbuf_addf(msg, "%s\t\tremote-tracking branch '%s' of .\n",
 				    sha1_to_hex(branch_head), remote);
 			goto cleanup;
@@ -577,8 +577,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 {
 	int status;
 
-	if (branch && !prefixcmp(k, "branch.") &&
-		!prefixcmp(k + 7, branch) &&
+	if (branch && has_prefix(k, "branch.") &&
+		has_prefix(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
 		free(branch_mergeoptions);
 		branch_mergeoptions = xstrdup(v);
@@ -1113,7 +1113,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * current branch.
 	 */
 	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, 0, &flag);
-	if (branch && !prefixcmp(branch, "refs/heads/"))
+	if (branch && has_prefix(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit = NULL;
-- 
1.8.4.1.566.geca833c
