From: Per Strandh <Per.Strandh@q-matic.se>
Subject: [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot
 path [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot path
 [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot path
Date: Tue, 13 Oct 2009 22:09:12 +0200
Message-ID: <65D9329CA2AF94438F542D48F2A42E830F95F51514@GOT-SRV-005.QMATIC.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:26:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnwV-0006OW-9X
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934281AbZJMULK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934278AbZJMULI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:11:08 -0400
Received: from mail.q-matic.se ([194.236.6.196]:11665 "EHLO mail.q-matic.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760804AbZJMULF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 16:11:05 -0400
Received: from GOT-SRV-005.QMATIC.local ([192.168.10.105]) by
 GOT-SRV-005.QMATIC.local ([192.168.10.105]) with mapi; Tue, 13 Oct 2009
 22:09:16 +0200
Thread-Topic: [PATCH] git-p4: Fixed bug that didn't allow spaces in the
 depot path [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot
 path [PATCH] git-p4: Fixed bug that didn't allow spaces in the depot path
Thread-Index: AcpMP9QZT0Q/vDgnQeCGs0sv9l64hwAAIctQ
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130200>

git-p4 clone (and sync) did not work if the specified depot path contained spaces.
Fixed by quoting the argument to the "p4 changes" and "p4 files" commands.

Signed-off-by: Per Strandh <per.strandh@q-matic.se>
---
 contrib/fast-import/git-p4 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e710219..01b6bbb 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -440,8 +440,8 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
-                                                        for p in depotPaths]))
+    output = p4_read_pipe_lines("changes \"" + ' '.join (["%s...%s" % (p, changeRange)
+                                                        for p in depotPaths]) + "\"" )
 
     changes = {}
     for line in output:
@@ -1437,10 +1437,10 @@ class P4Sync(Command):
         newestRevision = 0
 
         fileCnt = 0
-        for info in p4CmdList("files "
+        for info in p4CmdList("files \""
                               +  ' '.join(["%s...%s"
                                            % (p, revision)
-                                           for p in self.depotPaths])):
+                                           for p in self.depotPaths]) + "\""):
 
             if info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
-- 
1.6.3.msysgit.0

git-p4 clone (and sync) did not work if the specified depot path contained spaces.
Fixed by quoting the argument to the "p4 changes" and "p4 files" commands.

Signed-off-by: Per Strandh <per.strandh@q-matic.se>
---
 contrib/fast-import/git-p4 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e710219..01b6bbb 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -440,8 +440,8 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
-                                                        for p in depotPaths]))
+    output = p4_read_pipe_lines("changes \"" + ' '.join (["%s...%s" % (p, changeRange)
+                                                        for p in depotPaths]) + "\"" )
 
     changes = {}
     for line in output:
@@ -1437,10 +1437,10 @@ class P4Sync(Command):
         newestRevision = 0
 
         fileCnt = 0
-        for info in p4CmdList("files "
+        for info in p4CmdList("files \""
                               +  ' '.join(["%s...%s"
                                            % (p, revision)
-                                           for p in self.depotPaths])):
+                                           for p in self.depotPaths]) + "\""):
 
             if info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
-- 
1.6.3.msysgit.0

git-p4 clone (and sync) did not work if the specified depot path contained spaces.
Fixed by quoting the argument to the "p4 changes" and "p4 files" commands.

Signed-off-by: Per Strandh <per.strandh@q-matic.se>
---
 contrib/fast-import/git-p4 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e710219..01b6bbb 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -440,8 +440,8 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
-                                                        for p in depotPaths]))
+    output = p4_read_pipe_lines("changes \"" + ' '.join (["%s...%s" % (p, changeRange)
+                                                        for p in depotPaths]) + "\"" )
 
     changes = {}
     for line in output:
@@ -1437,10 +1437,10 @@ class P4Sync(Command):
         newestRevision = 0
 
         fileCnt = 0
-        for info in p4CmdList("files "
+        for info in p4CmdList("files \""
                               +  ' '.join(["%s...%s"
                                            % (p, revision)
-                                           for p in self.depotPaths])):
+                                           for p in self.depotPaths]) + "\""):
 
             if info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
-- 
1.6.3.msysgit.0
