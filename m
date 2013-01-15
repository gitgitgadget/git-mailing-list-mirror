From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 02/14] git p4: rearrange and simplify hasOrigin handling
Date: Mon, 14 Jan 2013 19:46:56 -0500
Message-ID: <1358210828-2369-3-git-send-email-pw@padd.com>
References: <1358210828-2369-1-git-send-email-pw@padd.com>
Cc: Olivier Delalleau <shish@keba.be>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 01:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuuhI-0000c7-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 01:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3AOArw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 19:47:52 -0500
Received: from honk.padd.com ([74.3.171.149]:52461 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756994Ab3AOArw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 19:47:52 -0500
Received: from arf.padd.com (unknown [50.55.148.35])
	by honk.padd.com (Postfix) with ESMTPSA id 9F3BC2F3F;
	Mon, 14 Jan 2013 16:47:51 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 101DA28EC2; Mon, 14 Jan 2013 19:47:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.427.gd1ed7ef
In-Reply-To: <1358210828-2369-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213553>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 69f1452..68f7458 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2754,23 +2754,23 @@ class P4Sync(Command, P4UserMap):
         self.changeRange = ""
         self.initialParent = ""
         self.previousDepotPaths = []
+        self.hasOrigin = False
 
         # map from branch depot path to parent branch
         self.knownBranches = {}
         self.initialParents = {}
-        self.hasOrigin = originP4BranchesExist()
-        if not self.syncWithOrigin:
-            self.hasOrigin = False
 
         if self.importIntoRemotes:
             self.refPrefix = "refs/remotes/p4/"
         else:
             self.refPrefix = "refs/heads/p4/"
 
-        if self.syncWithOrigin and self.hasOrigin:
-            if not self.silent:
-                print "Syncing with origin first by calling git fetch origin"
-            system("git fetch origin")
+        if self.syncWithOrigin:
+            self.hasOrigin = originP4BranchesExist()
+            if self.hasOrigin:
+                if not self.silent:
+                    print 'Syncing with origin first, using "git fetch origin"'
+                system("git fetch origin")
 
         if len(self.branch) == 0:
             self.branch = self.refPrefix + "master"
-- 
1.8.1.350.gdbf6fd0
