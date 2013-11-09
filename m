From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 56/86] builtin/fetch: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:49 +0100
Message-ID: <20131109070720.18178.30355.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:09:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2fl-0003IA-Uq
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933316Ab3KIHJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:23 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36282 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933294Ab3KIHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 3DCFF53;
	Sat,  9 Nov 2013 08:08:43 +0100 (CET)
X-git-sha1: e465380a244eed5f3dfaf2dab67b7fbeb0e2c839 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237501>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8eb6cd0..78d4add 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -313,7 +313,7 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (!is_null_sha1(ref->old_sha1) &&
-	    !prefixcmp(ref->name, "refs/tags/")) {
+	    has_prefix(ref->name, "refs/tags/")) {
 		int r;
 		r = s_update_ref("updating tag", ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
@@ -336,10 +336,10 @@ static int update_local_ref(struct ref *ref,
 		 * more likely to follow a standard layout.
 		 */
 		const char *name = remote_ref ? remote_ref->name : "";
-		if (!prefixcmp(name, "refs/tags/")) {
+		if (has_prefix(name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
-		} else if (!prefixcmp(name, "refs/heads/")) {
+		} else if (has_prefix(name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
 		} else {
@@ -471,15 +471,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				kind = "";
 				what = "";
 			}
-			else if (!prefixcmp(rm->name, "refs/heads/")) {
+			else if (has_prefix(rm->name, "refs/heads/")) {
 				kind = "branch";
 				what = rm->name + 11;
 			}
-			else if (!prefixcmp(rm->name, "refs/tags/")) {
+			else if (has_prefix(rm->name, "refs/tags/")) {
 				kind = "tag";
 				what = rm->name + 10;
 			}
-			else if (!prefixcmp(rm->name, "refs/remotes/")) {
+			else if (has_prefix(rm->name, "refs/remotes/")) {
 				kind = "remote-tracking branch";
 				what = rm->name + 13;
 			}
@@ -644,7 +644,7 @@ static void find_non_local_tags(struct transport *transport,
 
 	for_each_ref(add_existing, &existing_refs);
 	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
-		if (prefixcmp(ref->name, "refs/tags/"))
+		if (!has_prefix(ref->name, "refs/tags/"))
 			continue;
 
 		/*
@@ -892,7 +892,7 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 {
 	struct remote_group_data *g = priv;
 
-	if (!prefixcmp(key, "remotes.") &&
+	if (has_prefix(key, "remotes.") &&
 			!strcmp(key + 8, g->name)) {
 		/* split list by white space */
 		int space = strcspn(value, " \t\n");
-- 
1.8.4.1.566.geca833c
