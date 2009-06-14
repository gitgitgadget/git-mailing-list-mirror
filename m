From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Sun, 14 Jun 2009 21:47:54 +0200
Message-ID: <87bpoqoavp.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 14 21:48:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvgo-0004s8-E4
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763290AbZFNTsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763181AbZFNTsA
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:48:00 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:47701 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761906AbZFNTsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:48:00 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 27E524C8185
	for <git@vger.kernel.org>; Sun, 14 Jun 2009 21:47:56 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 491174C8049
	for <git@vger.kernel.org>; Sun, 14 Jun 2009 21:47:54 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2D7E5383F3; Sun, 14 Jun 2009 21:47:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121559>


Otherwise, a fluky allocation failure would cause merge
configuration settings to be silently ignored.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 ll-merge.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 31d6f0a..9168958 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -231,7 +231,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)

 	if (!strcmp(var, "merge.default")) {
 		if (value)
-			default_ll_merge = strdup(value);
+			default_ll_merge = xstrdup(value);
 		return 0;
 	}

@@ -265,7 +265,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 	if (!strcmp("name", ep)) {
 		if (!value)
 			return error("%s: lacks value", var);
-		fn->description = strdup(value);
+		fn->description = xstrdup(value);
 		return 0;
 	}

@@ -288,14 +288,14 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		 * file named by %A, and signal that it has done with zero exit
 		 * status.
 		 */
-		fn->cmdline = strdup(value);
+		fn->cmdline = xstrdup(value);
 		return 0;
 	}

 	if (!strcmp("recursive", ep)) {
 		if (!value)
 			return error("%s: lacks value", var);
-		fn->recursive = strdup(value);
+		fn->recursive = xstrdup(value);
 		return 0;
 	}

--
1.6.3.2.406.gd6a466
