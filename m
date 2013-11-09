From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 74/86] builtin/remote: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:07:07 +0100
Message-ID: <20131109070720.18178.25613.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2l5-00014x-KD
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933483Ab3KIHPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:01 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37720 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758692Ab3KIHOV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E9BD532;
	Sat,  9 Nov 2013 08:14:19 +0100 (CET)
X-git-sha1: dffcebdd42141e734b9252012dc57370d3e1d477 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237554>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/remote.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index b9a1024..e45358c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -261,7 +261,7 @@ static const char *abbrev_ref(const char *name, const char *prefix)
 
 static int config_read_branches(const char *key, const char *value, void *cb)
 {
-	if (!prefixcmp(key, "branch.")) {
+	if (has_prefix(key, "branch.")) {
 		const char *orig_key = key;
 		char *name;
 		struct string_list_item *item;
@@ -526,9 +526,9 @@ static int add_branch_for_removal(const char *refname,
 	}
 
 	/* don't delete non-remote-tracking refs */
-	if (prefixcmp(refname, "refs/remotes/")) {
+	if (!has_prefix(refname, "refs/remotes/")) {
 		/* advise user how to delete local branches */
-		if (!prefixcmp(refname, "refs/heads/"))
+		if (has_prefix(refname, "refs/heads/"))
 			string_list_append(branches->skipped,
 					   abbrev_branch(refname));
 		/* silently skip over other non-remote refs */
@@ -563,7 +563,7 @@ static int read_remote_branches(const char *refname,
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
-	if (!prefixcmp(refname, buf.buf)) {
+	if (has_prefix(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
-- 
1.8.4.1.566.geca833c
