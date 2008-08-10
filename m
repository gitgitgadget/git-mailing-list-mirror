From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH 04/12]  Utilise the new 'p4_system' function.
Date: Sun, 10 Aug 2008 19:26:27 +0100
Message-ID: <1218392795-4084-5-git-send-email-wildfire@progsoc.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-2-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-3-git-send-email-wildfire@progsoc.org>
 <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
Cc: simon@lst.de, Anand Kumria <wildfire@progsoc.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 20:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFnk-0003cT-13
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbYHJSgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYHJSgz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:36:55 -0400
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:47892 "EHLO
	giskard.kumria.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053AbYHJSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:36:54 -0400
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com)
	by giskard.kumria.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFmd-00022g-Oy; Mon, 11 Aug 2008 04:36:53 +1000
Received: from anand by eve.kumria.com with local (Exim 4.69)
	(envelope-from <anand@eve.kumria.com>)
	id 1KSFch-00015C-Ld; Sun, 10 Aug 2008 19:26:35 +0100
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1218392795-4084-4-git-send-email-wildfire@progsoc.org>
X-Spam-Score: -2.2
X-Spam-Score-Int: -21
X-Spam-Bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91863>

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 contrib/fast-import/git-p4 |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 08acd51..2ed36ec 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -98,7 +98,7 @@ def setP4ExecBit(file, mode):
         if p4Type[-1] == "+":
             p4Type = p4Type[0:-1]
 
-    system("p4 reopen -t %s %s" % (p4Type, file))
+    p4_system("reopen -t %s %s" % (p4Type, file))
 
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
@@ -561,7 +561,7 @@ class P4Submit(Command):
             modifier = diff['status']
             path = diff['src']
             if modifier == "M":
-                system("p4 edit \"%s\"" % path)
+                p4_system("edit \"%s\"" % path)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
                     filesToChangeExecBit[path] = diff['dst_mode']
                 editedFiles.add(path)
@@ -576,8 +576,8 @@ class P4Submit(Command):
                     filesToAdd.remove(path)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
-                system("p4 integrate -Dt \"%s\" \"%s\"" % (src, dest))
-                system("p4 edit \"%s\"" % (dest))
+                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                p4_system("edit \"%s\"" % (dest))
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
@@ -601,7 +601,7 @@ class P4Submit(Command):
             if response == "s":
                 print "Skipping! Good luck with the next patches..."
                 for f in editedFiles:
-                    system("p4 revert \"%s\"" % f);
+                    p4_system("revert \"%s\"" % f);
                 for f in filesToAdd:
                     system("rm %s" %f)
                 return
@@ -624,10 +624,10 @@ class P4Submit(Command):
         system(applyPatchCmd)
 
         for f in filesToAdd:
-            system("p4 add \"%s\"" % f)
+            p4_system("add \"%s\"" % f)
         for f in filesToDelete:
-            system("p4 revert \"%s\"" % f)
-            system("p4 delete \"%s\"" % f)
+            p4_system("revert \"%s\"" % f)
+            p4_system("delete \"%s\"" % f)
 
         # Set/clear executable bits
         for f in filesToChangeExecBit.keys():
@@ -728,7 +728,7 @@ class P4Submit(Command):
 
         os.chdir(self.clientPath)
         print "Syncronizing p4 checkout..."
-        system("p4 sync ...")
+        p4_system("sync ...")
 
         self.check()
 
-- 
1.5.6.3
