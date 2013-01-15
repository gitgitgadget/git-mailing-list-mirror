From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 04/14] git p4: inline listExistingP4GitBranches
Date: Mon, 14 Jan 2013 19:46:58 -0500
Message-ID: <1358210828-2369-5-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:49:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuui4-0001Gy-EI
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162Ab3AOAsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:48:33 -0500
Received: from honk.padd.com ([74.3.171.149]:52467 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757118Ab3AOAsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:48:33 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id B4D342F3F;
	Mon, 14 Jan 2013 16:48:32 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 28B6B28EC2; Mon, 14 Jan 2013 19:48:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213555>

It is four lines of code used in only one place.  Simplify by
including it where it is used.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 03680b0..8814049 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2518,13 +2518,6 @@ class P4Sync(Command, P4UserMap):
                 branch = branch[len(self.projectName):]
             self.knownBranches[branch] = branch
 
-    def listExistingP4GitBranches(self):
-        # branches holds mapping from name to commit
-        branches = p4BranchesInGit(self.importIntoRemotes)
-        self.p4BranchesInGit = branches.keys()
-        for branch in branches.keys():
-            self.initialParents[self.refPrefix + branch] = branches[branch]
-
     def updateOptionDict(self, d):
         option_keys = {}
         if self.keepRepoPath:
@@ -2805,7 +2798,12 @@ class P4Sync(Command, P4UserMap):
         if args == []:
             if self.hasOrigin:
                 createOrUpdateBranchesFromOrigin(self.refPrefix, self.silent)
-            self.listExistingP4GitBranches()
+
+            # branches holds mapping from branch name to sha1
+            branches = p4BranchesInGit(self.importIntoRemotes)
+            self.p4BranchesInGit = branches.keys()
+            for branch in branches.keys():
+                self.initialParents[self.refPrefix + branch] = branches[branch]
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
-- 
1.8.1.350.gdbf6fd0
