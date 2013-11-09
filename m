From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 72/86] builtin/receive-pack: replace prefixcmd() with
 has_prefix()
Date: Sat, 09 Nov 2013 08:07:05 +0100
Message-ID: <20131109070720.18178.25145.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2lX-0001ea-4X
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712Ab3KIHP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:15:26 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:33945 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758684Ab3KIHOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:20 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 18E8057;
	Sat,  9 Nov 2013 08:14:19 +0100 (CET)
X-git-sha1: 7a5c265be4534e2e4ad88cd9eb1b8827eb3ea019 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237558>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/receive-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 67ce1ef..a4de530 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -428,7 +428,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
+	if (!has_prefix(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
@@ -459,7 +459,7 @@ static const char *update(struct command *cmd)
 	}
 
 	if (!is_null_sha1(old_sha1) && is_null_sha1(new_sha1)) {
-		if (deny_deletes && !prefixcmp(name, "refs/heads/")) {
+		if (deny_deletes && has_prefix(name, "refs/heads/")) {
 			rp_error("denying ref deletion for %s", name);
 			return "deletion prohibited";
 		}
@@ -483,7 +483,7 @@ static const char *update(struct command *cmd)
 
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !prefixcmp(name, "refs/heads/")) {
+	    has_prefix(name, "refs/heads/")) {
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
 
-- 
1.8.4.1.566.geca833c
