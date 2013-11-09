From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 58/86] builtin/for-each-ref: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:06:51 +0100
Message-ID: <20131109070720.18178.435.chriscool@tuxfamily.org>
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
	id 1Vf2fj-0003IA-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312Ab3KIHJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:19 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36374 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933298Ab3KIHIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:44 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 1E38097;
	Sat,  9 Nov 2013 08:08:44 +0100 (CET)
X-git-sha1: 80649d69c2d3d6942299b0f3ef1cb85d065ac49d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237500>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/for-each-ref.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1d4083c..c22f200 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -432,7 +432,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 		if (name[wholen] != 0 &&
 		    strcmp(name + wholen, "name") &&
 		    strcmp(name + wholen, "email") &&
-		    prefixcmp(name + wholen, "date"))
+		    !has_prefix(name + wholen, "date"))
 			continue;
 		if (!wholine)
 			wholine = find_wholine(who, wholen, buf, sz);
@@ -444,7 +444,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 			v->s = copy_name(wholine);
 		else if (!strcmp(name + wholen, "email"))
 			v->s = copy_email(wholine);
-		else if (!prefixcmp(name + wholen, "date"))
+		else if (has_prefix(name + wholen, "date"))
 			grab_date(wholine, v, name);
 	}
 
@@ -466,7 +466,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 		if (deref)
 			name++;
 
-		if (!prefixcmp(name, "creatordate"))
+		if (has_prefix(name, "creatordate"))
 			grab_date(wholine, v, name);
 		else if (!strcmp(name, "creator"))
 			v->s = copy_line(wholine);
@@ -646,14 +646,14 @@ static void populate_value(struct refinfo *ref)
 			name++;
 		}
 
-		if (!prefixcmp(name, "refname"))
+		if (has_prefix(name, "refname"))
 			refname = ref->refname;
-		else if (!prefixcmp(name, "symref"))
+		else if (has_prefix(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
-		else if (!prefixcmp(name, "upstream")) {
+		else if (has_prefix(name, "upstream")) {
 			struct branch *branch;
 			/* only local branches may have an upstream */
-			if (prefixcmp(ref->refname, "refs/heads/"))
+			if (!has_prefix(ref->refname, "refs/heads/"))
 				continue;
 			branch = branch_get(ref->refname + 11);
 
-- 
1.8.4.1.566.geca833c
