From: TamerTas <tamertas@outlook.com>
Subject: [PATCH][GSOC2014] changed logical chain in branch.c to lookup tables
Date: Mon, 10 Mar 2014 21:04:22 +0200
Message-ID: <BLU0-SMTP15131ED34F192C9871ACC0CD5740@phx.gbl>
References: <y>
 <1394478262-17911-1-git-send-email-tamertas@outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: TamerTas <tamertas@outlook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 20:04:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5VD-00044x-OK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 20:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbaCJTEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 15:04:39 -0400
Received: from blu0-omc3-s27.blu0.hotmail.com ([65.55.116.102]:15426 "EHLO
	blu0-omc3-s27.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556AbaCJTEi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 15:04:38 -0400
Received: from BLU0-SMTP151 ([65.55.116.73]) by blu0-omc3-s27.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 10 Mar 2014 12:04:38 -0700
X-TMN: [crcPX33VcTJtQsB97qiJXuBcBZ79/lCo]
X-Originating-Email: [tamertas@outlook.com]
Received: from localhost.localdomain ([24.133.189.163]) by BLU0-SMTP151.phx.gbl over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 10 Mar 2014 12:04:36 -0700
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1394478262-17911-1-git-send-email-tamertas@outlook.com>
X-OriginalArrivalTime: 10 Mar 2014 19:04:36.0980 (UTC) FILETIME=[94B54340:01CF3C93]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243793>


Signed-off-by: TamerTas <tamertas@outlook.com>
---
 branch.c |   31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..397edd3 100644
--- a/branch.c
+++ b/branch.c
@@ -50,6 +50,9 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
+	const char *location[] = {"local", "remote"};
+	const char *type[] = {"branch", "ref"};
+
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
@@ -77,29 +80,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	strbuf_release(&key);
 
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
-		else
-			die("BUG: impossible combination of %d and %p",
-			    remote_is_branch, origin);
+        
+        printf_ln(rebasing ?
+              _("Branch %s set up to track %s %s %s by rebasing.") :
+              _("Branch %s set up to track %s %s %s."),
+              local, location[!origin], type[remote_is_branch], remote);
 	}
 }
 
-- 
1.7.9.5
