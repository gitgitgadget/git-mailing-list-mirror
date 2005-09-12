From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 3/5] Introduce a 'die' function.
Date: Mon, 12 Sep 2005 23:30:47 +0200
Message-ID: <20050912213047.GE6644@c165.ib.student.liu.se>
References: <20050912212601.GB6644@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 12 23:30:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvt5-0005p1-Af
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVILVat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVILVat
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:30:49 -0400
Received: from [85.8.31.11] ([85.8.31.11]:5869 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932263AbVILVas (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:30:48 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B475E4115; Mon, 12 Sep 2005 23:35:48 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEvt1-0001vr-00; Mon, 12 Sep 2005 23:30:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050912212601.GB6644@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8433>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-fredrik.py |   15 +++++----------
 gitMergeCommon.py    |   12 ++++++++----
 2 files changed, 13 insertions(+), 14 deletions(-)

8ca382168d366c68c567c1f85fb6d2cb02b40f37
diff --git a/git-merge-fredrik.py b/git-merge-fredrik.py
--- a/git-merge-fredrik.py
+++ b/git-merge-fredrik.py
@@ -120,9 +120,8 @@ def unmergedCacheEntries():
             e.stages[stage].mode = mode
             e.stages[stage].sha1 = sha1
         else:
-            print 'Error: Merge program failed: Unexpected output from', \
-                  'git-ls-files:', l
-            sys.exit(2)
+            die('Error: Merge program failed: Unexpected output from', \
+                'git-ls-files:', l)
     return res
 
 def mergeTrees(head, merge, common, branch1Name, branch2Name,
@@ -381,15 +380,12 @@ def processEntry(entry, branch1Name, bra
         os.unlink(src1)
         os.unlink(src2)
     else:
-        print 'ERROR: Fatal merge failure.'
-        print "ERROR: Shouldn't happen"
-        sys.exit(2)
+        die("ERROR: Fatal merge failure, shouldn't happen.")
 
     return cleanMerge
 
 def usage():
-    print 'Usage:', sys.argv[0], ' <base>... -- <head> <remote>..'
-    sys.exit(2)
+    die('Usage:', sys.argv[0], ' <base>... -- <head> <remote>..')
 
 # main entry point as merge strategy module
 # The first parameters up to -- are merge bases, and the rest are heads.
@@ -399,8 +395,7 @@ def usage():
 for nextArg in xrange(1, len(sys.argv)):
     if sys.argv[nextArg] == '--':
         if len(sys.argv) != nextArg + 3:
-            print 'Not handling anything other than two heads merge.'
-            sys.exit(2)
+            die('Not handling anything other than two heads merge.')
         try:
             h1 = firstBranch = sys.argv[nextArg + 1]
             h2 = secondBranch = sys.argv[nextArg + 2]
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -10,6 +10,10 @@ if sys.version_info[0] < 2 or \
 
 import subprocess
 
+def die(*args):
+    printList(args, sys.stderr)
+    sys.exit(2)
+
 # Debugging machinery
 # -------------------
 
@@ -28,11 +32,11 @@ def debug(*args):
         if funcName in functionsToDebug:
             printList(args)
 
-def printList(list):
+def printList(list, file=sys.stdout):
     for x in list:
-        sys.stdout.write(str(x))
-        sys.stdout.write(' ')
-    sys.stdout.write('\n')
+        file.write(str(x))
+        file.write(' ')
+    file.write('\n')
 
 # Program execution
 # -----------------
