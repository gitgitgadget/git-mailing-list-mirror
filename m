From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] merge-recursive: Improve the error message printed when merge(1) isn't found.
Date: Sun, 29 Jan 2006 13:16:08 +0100
Message-ID: <20060129121608.GC4815@c165.ib.student.liu.se>
References: <43DB4D16.6050807@drugphish.ch> <20060129120344.GB4815@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roberto Nibali <ratz@drugphish.ch>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Jan 29 13:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3BTu-0006xe-Ja
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 13:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWA2MQU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 07:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWA2MQU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 07:16:20 -0500
Received: from [85.8.31.11] ([85.8.31.11]:47517 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750938AbWA2MQT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 07:16:19 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 532AB40FF; Sun, 29 Jan 2006 13:29:24 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F3BTU-0007sl-00; Sun, 29 Jan 2006 13:16:08 +0100
To: Fredrik Kuivinen <freku045@student.liu.se>
Content-Disposition: inline
In-Reply-To: <20060129120344.GB4815@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15214>


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

75cd8eff434fd6e9cf7fff98f13a27bfaa1b363b
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 56c3641..b17c8e5 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -205,11 +205,16 @@ def mergeFile(oPath, oSha, oMode, aPath,
             orig = runProgram(['git-unpack-file', oSha]).rstrip()
             src1 = runProgram(['git-unpack-file', aSha]).rstrip()
             src2 = runProgram(['git-unpack-file', bSha]).rstrip()
-            [out, code] = runProgram(['merge',
-                                      '-L', branch1Name + '/' + aPath,
-                                      '-L', 'orig/' + oPath,
-                                      '-L', branch2Name + '/' + bPath,
-                                      src1, orig, src2], returnCode=True)
+            try:
+                [out, code] = runProgram(['merge',
+                                          '-L', branch1Name + '/' + aPath,
+                                          '-L', 'orig/' + oPath,
+                                          '-L', branch2Name + '/' + bPath,
+                                          src1, orig, src2], returnCode=True)
+            except ProgramError, e:
+                print >>sys.stderr, e
+                die("Failed to execute 'merge'. merge(1) is used as the "
+                    "file-level merge tool. Is 'merge' in your path?")
 
             sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
                               src1]).rstrip()
-- 
0.99.9k.g3480-dirty
