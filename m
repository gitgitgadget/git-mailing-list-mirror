From: Reilly Grant <reillyeon@qotw.net>
Subject: [PATCH v2] git-p4: Avoid modules deprecated in Python 2.6.
Date: Thu, 10 Sep 2009 00:02:38 -0700
Message-ID: <1252566158-13305-1-git-send-email-reillyeon@qotw.net>
Cc: Reilly Grant <reillyeon@qotw.net>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 10 09:03:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mldgd-0001eX-Ba
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 09:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbZIJHDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 03:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148AbZIJHDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 03:03:09 -0400
Received: from jane.qotw.net ([72.14.183.39]:37030 "EHLO jane.qotw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbZIJHDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 03:03:08 -0400
Received: by jane.qotw.net (Postfix, from userid 1000)
	id 308C153887; Thu, 10 Sep 2009 03:03:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qotw.net; s=jane;
	t=1252566190; bh=RRWXrR+QraV7xzoYMAwQrcWQVjg7yCiq9l4fHUkZSOc=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=j0DaP21BSFUCiBfG6QsihQx78xhpqwY8QIaquVYeKb3fooYjvBCGuw3XlVVJuvT7T
	 nDAmEBsjwFfmiPsszAaqmbXIN+xg2IeX6AHw6IfLO10ifQ68fDkCZPOw2KidwAVrml
	 1bzjfQOCHLLYqgs46vFD+GwBnXB9TaEi2ElfuGtE=
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128098>

The popen2, sha and sets modules are deprecated in Python 2.6 (sha in
Python 2.5).  Both popen2 and sha are not actually used in git-p4.
Replace usage of sets.Set with the builtin set object.

The built-in set object was added in Python 2.4 and is already used in
other parts of this script, so this dependency is nothing new.

Signed-off-by: Reilly Grant <reillyeon@qotw.net>
---
 contrib/fast-import/git-p4 |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 38438f3..e710219 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -8,12 +8,10 @@
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
 
-import optparse, sys, os, marshal, popen2, subprocess, shelve
-import tempfile, getopt, sha, os.path, time, platform
+import optparse, sys, os, marshal, subprocess, shelve
+import tempfile, getopt, os.path, time, platform
 import re
 
-from sets import Set;
-
 verbose = False
 
 
@@ -864,8 +862,8 @@ class P4Sync(Command):
 
         self.usage += " //depot/path[@revRange]"
         self.silent = False
-        self.createdBranches = Set()
-        self.committedChanges = Set()
+        self.createdBranches = set()
+        self.committedChanges = set()
         self.branch = ""
         self.detectBranches = False
         self.detectLabels = False
@@ -1662,7 +1660,7 @@ class P4Sync(Command):
 
             if len(self.changesFile) > 0:
                 output = open(self.changesFile).readlines()
-                changeSet = Set()
+                changeSet = set()
                 for line in output:
                     changeSet.add(int(line))
 
-- 
1.6.3.3
