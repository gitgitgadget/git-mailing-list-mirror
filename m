From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 3/8] push: trivial reorganization
Date: Sat, 12 Oct 2013 02:05:59 -0500
Message-ID: <1381561561-20459-7-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNJ-0004uk-Mi
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab3JLHMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:21 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:50292 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab3JLHMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:18 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so3163155oag.30
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nv0oIs/Qiq+UngeNK70uWOOq/yHwb+h+E5N2eVh+JJo=;
        b=xQRWUhHXDqo43NIpzU9Ql/2njiy6oIbKIeKNCkx9NLR+tznp+5svqLM75k9v9hk1EL
         HxoQSP0VHrkA9ScYiabp6nwFl5t8gmkQOKtvq8b4/Ip/uTUIZWNDJsQNPYk1lcB0f+Oq
         Vmv8WSX59pBhuVo6VthfaaRP5DteTt6iaSL/oi1QfkZxqN55rwyD9Gm6C8RJSZubDaLM
         LNvy41EtRcuijjTer7cM33MvX8HipKYJu6WJztPuWU82pUYG5XA17uM0owinnCQExrOo
         qkYrl46pQGWcoA3JWAC1VGOVfteab8abq79kAKJt7aXfi1AYKGQxhE6+qrkVm+WHpmd5
         qGmw==
X-Received: by 10.182.129.201 with SMTP id ny9mr17903197obb.0.1381561937706;
        Sat, 12 Oct 2013 00:12:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm28634232obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235993>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 04f0eaf..5dc06a3 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -113,20 +113,11 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
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
@@ -156,8 +147,6 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
-	if (!branch)
-		die(_(message_detached_head_die), remote->name);
 	add_refspec(branch->name);
 }
 
@@ -191,9 +180,23 @@ static int is_workflow_triangular(struct remote *remote)
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
@@ -208,17 +211,17 @@ static void setup_default_push_refspecs(struct remote *remote)
 
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
1.8.4-fc
