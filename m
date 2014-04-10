From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/9] push: trivial reorganization
Date: Thu, 10 Apr 2014 14:04:38 -0500
Message-ID: <1397156686-31349-2-git-send-email-felipe.contreras@gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 21:15:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYKR9-00064T-Ty
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 21:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbaDJTOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 15:14:53 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:56225 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030242AbaDJTOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 15:14:52 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so4785375obc.26
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47R36GJlkTFDOLThWmi1g0o5ZPUZGGrxvJ6BaD9eT2A=;
        b=NMgzzTzyXJj2GjoJaVjUJF8dwyeF6Kae/1MNRFcpzCabWTh0vRfxQBafoIrB78W81l
         om4nVaTh29LNGd2Lioib4Qd1+vW5shkmC6FHdgTbo8/dT0ty/Jj7vHqQvfs0SHCLP3eE
         GccCAVyp/37x8xrb2ExFWuzrsgH/1suCkpUtpYMqdoE9JcUDy6+UWaZSpmsR17QENk0K
         d25cn6i6ylfMOZztfY1fTrUNzifbTXe1WiyNORS95xibPcDe6gnm7FccQzMf/LxqlfTk
         i3yV45NYWwWhzhCUQg6GPdM8lLQ5c/xEtog5SB325Q9/YJ4sqHclU/hV1DnfmANxxhRA
         1Q7Q==
X-Received: by 10.182.153.41 with SMTP id vd9mr77755obb.87.1397157291624;
        Thu, 10 Apr 2014 12:14:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id la3sm8356173obb.19.2014.04.10.12.14.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 12:14:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246039>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 0e50ddb..d10aefc 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -155,20 +155,11 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	    remote->name, branch->name, advice_maybe);
 }
 
-static const char message_detached_head_die[] =
-	N_("You are not currently on a branch.\n"
-	   "To push the history leading to the current (detached HEAD)\n"
-	   "state now, use\n"
-	   "\n"
-	   "    git push %s HEAD:<name-of-remote-branch>\n");
-
 static void setup_push_upstream(struct remote *remote, struct branch *branch,
 				int triangular)
 {
 	struct strbuf refspec = STRBUF_INIT;
 
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
@@ -198,8 +189,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	add_refspec(branch->name);
 }
 
@@ -240,9 +229,23 @@ static int is_workflow_triangular(struct remote *remote)
 	return (fetch_remote && fetch_remote != remote);
 }
 
-static void setup_default_push_refspecs(struct remote *remote)
+static const char message_detached_head_die[] =
+	N_("You are not currently on a branch.\n"
+	   "To push the history leading to the current (detached HEAD)\n"
+	   "state now, use\n"
+	   "\n"
+	   "    git push %s HEAD:<name-of-remote-branch>\n");
+
+static struct branch *get_current_branch(struct remote *remote)
 {
 	struct branch *branch = branch_get(NULL);
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+	return branch;
+}
+
+static void setup_default_push_refspecs(struct remote *remote)
+{
 	int triangular = is_workflow_triangular(remote);
 
 	switch (push_default) {
@@ -257,17 +260,17 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	case PUSH_DEFAULT_SIMPLE:
 		if (triangular)
-			setup_push_current(remote, branch);
+			setup_push_current(remote, get_current_branch(remote));
 		else
-			setup_push_upstream(remote, branch, triangular);
+			setup_push_upstream(remote, get_current_branch(remote), triangular);
 		break;
 
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote, branch, triangular);
+		setup_push_upstream(remote, get_current_branch(remote), triangular);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
-		setup_push_current(remote, branch);
+		setup_push_current(remote, get_current_branch(remote));
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
-- 
1.9.1+fc1
