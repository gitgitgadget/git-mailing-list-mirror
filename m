From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH 6/7] git push: Change default for "git push" to nothing.
Date: Mon,  9 Mar 2009 23:35:50 +0100
Message-ID: <1236638151-6465-7-git-send-email-finnag@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 00:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgojX-0001tF-Ty
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbZCIXQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZCIXQk
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:16:40 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:57864 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZCIXQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:16:39 -0400
Received: from decibel.pvv.ntnu.no
	([129.241.210.179] helo=localhost.localdomain ident=finnag)
	by decibel.pvv.ntnu.no with esmtp (Exim 4.69)
	(envelope-from <finnag@pvv.org>)
	id 1Lgo5K-0002Lo-3g
	for git@vger.kernel.org; Mon, 09 Mar 2009 23:36:36 +0100
X-Mailer: git-send-email 1.6.2.99.g52e77
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112754>

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 Documentation/config.txt   |    4 ++--
 Documentation/git-push.txt |    4 +---
 builtin-push.c             |    7 ++++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 50bc1d0..437216c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1170,10 +1170,10 @@ push.default::
 	branch, or `origin` if no remote is configured. `origin` is also used
 	if you are not on any branch.
 +
-* `nothing` do not push anything
+* `nothing` do not push anything.  This is new the default value.
 * `matching` push all matching branches to the current remote.
   All branches having the same name in both ends are considered to be
-  matching. This is the default value.
+  matching.  This used to be the default value.
 * `current` push the current branch to the branch it is tracking on
   the remote
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb7b3d2..149c1f0 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -64,9 +64,7 @@ the remote repository.
 The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below).
+already exists on the remote side.
 
 --all::
 	Instead of naming each ref to push, specifies that all
diff --git a/builtin-push.c b/builtin-push.c
index 7ef499f..93f12a8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -104,6 +104,10 @@ static void handle_default_push(struct remote *remote, int *flags)
 		warn_unconfigured_push();
 		/* fallthrough */
 
+	case PUSH_DEFAULT_NOTHING:
+		die("No refspec given, and none configured.");
+		break;
+
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
@@ -112,9 +116,6 @@ static void handle_default_push(struct remote *remote, int *flags)
 		setup_push_current(remote);
 		break;
 
-	case PUSH_DEFAULT_NOTHING:
-		die("No refspec given, and none configured.");
-		break;
 	}
 }
 
-- 
1.6.2.105.g6ff1f.dirty
