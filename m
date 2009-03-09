From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 7/7] git push: Remove warning for "git push" default change
Date: Mon,  9 Mar 2009 23:35:51 +0100
Message-ID: <1236638151-6465-8-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:18:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgojX-0001tF-8R
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbZCIXQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbZCIXQi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:16:38 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57861 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZCIXQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:16:37 -0400
X-Greylist: delayed 2419 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2009 19:16:37 EDT
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo5M-0002Lo-6q
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:38 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112753>

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/config.txt |    4 ++--
 builtin-push.c           |   27 ---------------------------
 cache.h                  |    1 -
 environment.c            |    2 +-
 4 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 437216c..d110edc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1170,10 +1170,10 @@ push.default::
 	branch, or `origin` if no remote is configured. `origin` is also used
 	if you are not on any branch.
 +
-* `nothing` do not push anything.  This is new the default value.
+* `nothing` do not push anything.  This is the default value.
 * `matching` push all matching branches to the current remote.
   All branches having the same name in both ends are considered to be
-  matching.  This used to be the default value.
+  matching.
 * `current` push the current branch to the branch it is tracking on
   the remote
 
diff --git a/builtin-push.c b/builtin-push.c
index 93f12a8..d0ab76d 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -74,36 +74,10 @@ static void setup_push_current(struct remote *remote)
 						branch->merge[n]->src));
 }
 
-static const char *warn_unconfigured_push_msg[] = {
-	"You did not specify any refspecs to push, and the current remote",
-	"has not configured any push refspecs. The default action in this",
-	"case has been to push all matching refspecs, that is, all branches",
-	"that exist both locally and remotely will be updated.",
-	"This default will change in the future.",
-	"",
-	"You can specify what action you want to take in this case, and",
-	"avoid seeing this message again, by configuring 'push.default' to:",
-	"  'nothing'  : Do not push anythig (the future default)",
-	"  'matching' : Push all matching branches (the current default)",
-	"  'current'  : Push the current branch to whatever it is tracking",
-	""
-};
-
-static void warn_unconfigured_push()
-{
-	int i;
-	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
-		warning("%s", warn_unconfigured_push_msg[i]);
-}
-
 static void handle_default_push(struct remote *remote, int *flags)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
-	case PUSH_DEFAULT_UNSPECIFIED:
-		warn_unconfigured_push();
-		/* fallthrough */
-
 	case PUSH_DEFAULT_NOTHING:
 		die("No refspec given, and none configured.");
 		break;
@@ -115,7 +89,6 @@ static void handle_default_push(struct remote *remote, int *flags)
 	case PUSH_DEFAULT_CURRENT:
 		setup_push_current(remote);
 		break;
-
 	}
 }
 
diff --git a/cache.h b/cache.h
index 3a6acb8..f3f8e28 100644
--- a/cache.h
+++ b/cache.h
@@ -542,7 +542,6 @@ enum rebase_setup_type {
 };
 
 enum push_default_type {
-	PUSH_DEFAULT_UNSPECIFIED = -1,
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_CURRENT,
diff --git a/environment.c b/environment.c
index 4696885..6766394 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+enum push_default_type push_default = PUSH_DEFAULT_NOTHING;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
-- 
1.6.2.105.g6ff1f.dirty
