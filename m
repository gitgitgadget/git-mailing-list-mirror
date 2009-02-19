From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Expand explanation of the use of + in git push refspecs.
Date: Thu, 19 Feb 2009 12:39:47 -0500
Message-ID: <20090219180258.2C7983360A6@rincewind>
Cc: srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 19:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaDGI-0006Bb-GL
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 19:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbZBSSDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 13:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbZBSSDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 13:03:09 -0500
Received: from smtp162.iad.emailsrvr.com ([207.97.245.162]:33733 "EHLO
	smtp162.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZBSSDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 13:03:08 -0500
Received: from relay6.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay6.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id C751D7B7853;
	Thu, 19 Feb 2009 13:03:06 -0500 (EST)
Received: by relay6.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4A5EA7B908D;
	Thu, 19 Feb 2009 13:03:05 -0500 (EST)
Received: by rincewind (Postfix, from userid 1000)
	id 2C7983360A6; Thu, 19 Feb 2009 13:02:58 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110725>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---
 Documentation/git-push.txt |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7d1eced..4cb13a1 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -50,20 +50,21 @@ updated.
 +
 The object referenced by <src> is used to fast forward the ref <dst>
 on the remote side. If the optional leading plus `{plus}` is used, the
-remote ref is updated even if it does not result in a fast forward
-update.
+remote ref is *overwritten* with the local ref.  (The use of `{plus}`
+is recommended only for private, unshared repositories.)  See EXAMPLES
+below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
-The special refspec `:` (or `+:` to allow non-fast forward updates)
-directs git to push "matching" branches: for every branch that exists on
-the local side, the remote side is updated if a branch of the same name
-already exists on the remote side.  This is the default operation mode
-if no explicit refspec is found (that is neither on the command line
-nor in any Push line of the corresponding remotes file---see below).
+The special refspec `:` (or `{plus}:` to allow overwriting) directs git to
+push "matching" branches: for every branch that exists on the local
+side, the remote side is updated if a branch of the same name already
+exists on the remote side.  This is the default operation mode if no
+explicit refspec is found (that is neither on the command line nor in
+any Push line of the corresponding remotes file---see below).
 
 --all::
 	Instead of naming each ref to push, specifies that all
@@ -218,6 +219,29 @@ git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
+git push origin {plus}dev:master::
+	*Overwrite* the origin repository's master branch with the dev
+	branch.  *This can abandon commits in the origin repository.*
+	Consider the following situation:
++
+----
+	    o---o---o---A---B  origin/master
+	             \
+	              X---Y---Z  dev
+----
++
+The above command would change the origin repository to
++
+----
+	              A---B  (unnamed branch)
+	             /
+	    o---o---o---X---Y---Z  origin/master
+----
++
+That is, commits A and B would belong to an unreachable branch without a
+symbolic name.  As such, these commits would be removed by a `git gc`
+command on the origin repository.
+
 
 Author
 ------
-- 
1.6.1.2.390.gba743
