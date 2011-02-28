From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] push: better error messages for detached HEAD and "no destination"
Date: Mon, 28 Feb 2011 22:14:05 +0100
Message-ID: <1298927645-2716-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 28 22:43:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAsN-0004gL-KC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1B1Vn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 16:43:26 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33299 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835Ab1B1Vn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 16:43:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1SLECJG030433
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Feb 2011 22:14:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PuAQ3-0000No-6l; Mon, 28 Feb 2011 22:14:15 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1PuAQ3-0000lR-5h; Mon, 28 Feb 2011 22:14:15 +0100
X-Mailer: git-send-email 1.7.4.1.142.g43604.dirty
In-Reply-To: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Feb 2011 22:14:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1SLECJG030433
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1299532454.72077@5uMtDQl8H81m9uKBjcLYWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168152>

In both cases, give a hint on what to do next. We mention explicitely
"detached HEAD" since this is the keyword to look for in documentations.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin/push.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 210eb36..48fb050 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -69,7 +69,8 @@ static void setup_push_upstream(struct remote *remote)
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
-		die("You are not currently on a branch.");
+		die("You are not currently on a branch (detached HEAD).\n"
+		    "Please, checkout the branch you want to push first or specify it on the command line.");
 	if (!branch->merge_nr || !branch->merge)
 		die("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
@@ -152,7 +153,14 @@ static int do_push(const char *repo, int flags)
 	if (!remote) {
 		if (repo)
 			die("bad repository '%s'", repo);
-		die("No destination configured to push to.");
+		die("No destination configured to push to.\n"
+		    "Either specify the URL from the command line or configure a remote repository using\n"
+		    "\n"
+		    "    git remote add <name> <url>\n"
+		    "\n"
+		    "and then push using the remote name like\n"
+		    "\n"
+		    "    git push <name>\n");
 	}
 
 	if (remote->mirror)
-- 
1.7.4.1.142.g43604.dirty
