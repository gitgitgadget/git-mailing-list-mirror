From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv2] Docs: Expand explanation of the use of + in git push refspecs.
Date: Thu, 19 Feb 2009 12:39:47 -0500
Message-ID: <20090224165105.0FAE53360A6@rincewind>
References: <20090219180258.2C7983360A6@rincewind>
Cc: srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 17:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0WT-0003N4-AU
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbZBXQvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZBXQvQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:51:16 -0500
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:53778 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbZBXQvP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 11:51:15 -0500
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 0F2E91EBBFF;
	Tue, 24 Feb 2009 11:51:13 -0500 (EST)
Received: by relay10.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 029E41EBC8D;
	Tue, 24 Feb 2009 11:51:13 -0500 (EST)
Received: by rincewind (Postfix, from userid 1000)
	id 0FAE53360A6; Tue, 24 Feb 2009 11:51:05 -0500 (EST)
In-Reply-To: <20090219180258.2C7983360A6@rincewind>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111312>

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

This version incorporates comments from Junio and Sverre.

 Documentation/git-push.txt |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7d1eced..2fae4fd 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -48,17 +48,19 @@ push. Arbitrary expressions cannot be used here, an actual ref must
 be named. If `:`<dst> is omitted, the same ref as <src> will be
 updated.
 +
-The object referenced by <src> is used to fast forward the ref <dst>
-on the remote side. If the optional leading plus `{plus}` is used, the
-remote ref is updated even if it does not result in a fast forward
-update.
+The object referenced by <src> is used to update the <dst> reference
+on the remote side, but by default this is only allowed if the
+update can fast forward <dst>.  By having the optional leading `{plus}`,
+you can tell git to update the <dst> ref even when the update is not a
+fast forward.  This does *not* attempt to merge <src> into <dst>.  See
+EXAMPLES below for details.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
 Pushing an empty <src> allows you to delete the <dst> ref from
 the remote repository.
 +
-The special refspec `:` (or `+:` to allow non-fast forward updates)
+The special refspec `:` (or `{plus}:` to allow non-fast forward updates)
 directs git to push "matching" branches: for every branch that exists on
 the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.  This is the default operation mode
@@ -218,6 +220,30 @@ git push origin :experimental::
 	Find a ref that matches `experimental` in the `origin` repository
 	(e.g. `refs/heads/experimental`), and delete it.
 
+git push origin {plus}dev:master::
+	Update the origin repository's master branch with the dev branch,
+	allowing non-fast forward updates.  *This can leave unreferenced
+	commits dangling in the origin repository.*  Consider the
+	following situation, where a fast forward is not possible:
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
+	    o---o---o---X---Y---Z  master
+----
++
+Commits A and B would no longer belong to a branch with a symbolic name,
+and so would be unreachable.  As such, these commits would be removed by
+a `git gc` command on the origin repository.
+
 
 Author
 ------
-- 
1.6.1.2.390.gba743
