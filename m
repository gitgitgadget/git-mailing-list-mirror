From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/5] Exit with status code 2 if we get an exception.
Date: Mon, 12 Sep 2005 23:29:54 +0200
Message-ID: <20050912212954.GD6644@c165.ib.student.liu.se>
References: <20050912212601.GB6644@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Sep 12 23:31:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvsE-0005gN-Ai
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVILV34 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVILV34
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:29:56 -0400
Received: from [85.8.31.11] ([85.8.31.11]:5357 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932262AbVILV3z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:29:55 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C2C524115; Mon, 12 Sep 2005 23:34:55 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EEvsA-0001v7-00; Mon, 12 Sep 2005 23:29:54 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050912212601.GB6644@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8434>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-fredrik.py |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

f814a54ac034f4455363582b2c2f3d386bf8f0be
diff --git a/git-merge-fredrik.py b/git-merge-fredrik.py
--- a/git-merge-fredrik.py
+++ b/git-merge-fredrik.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 
-import sys, math, random, os, re, signal, tempfile, stat, errno
+import sys, math, random, os, re, signal, tempfile, stat, errno, traceback
 from heapq import heappush, heappop
 from sets import Set
 
@@ -409,15 +409,20 @@ for nextArg in xrange(1, len(sys.argv)):
         break
 
 print 'Merging', h1, 'with', h2
-h1 = runProgram(['git-rev-parse', '--verify', h1 + '^0']).rstrip()
-h2 = runProgram(['git-rev-parse', '--verify', h2 + '^0']).rstrip()
 
-graph = buildGraph([h1, h2])
-
-[res, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
-                     firstBranch, secondBranch, graph)
-
-print ''
+try:
+    h1 = runProgram(['git-rev-parse', '--verify', h1 + '^0']).rstrip()
+    h2 = runProgram(['git-rev-parse', '--verify', h2 + '^0']).rstrip()
+
+    graph = buildGraph([h1, h2])
+
+    [res, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
+                         firstBranch, secondBranch, graph)
+
+    print ''
+except:
+    traceback.print_exc(None, sys.stderr)
+    sys.exit(2)
 
 if clean:
     sys.exit(0)
