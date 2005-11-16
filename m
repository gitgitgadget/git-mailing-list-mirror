From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Give python a chance to find "backported" modules
Date: Wed, 16 Nov 2005 03:33:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511160331150.15130@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Nov 16 03:34:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcD7N-0004yX-17
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 03:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVKPCdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 21:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbVKPCdq
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 21:33:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48018 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965186AbVKPCdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 21:33:45 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A356713F793; Wed, 16 Nov 2005 03:33:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 87C78B51F8; Wed, 16 Nov 2005 03:33:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 653DD59124; Wed, 16 Nov 2005 03:33:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4B6F113F793; Wed, 16 Nov 2005 03:33:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11991>


python 2.2.1 is perfectly capable of executing git-merge-recursive,
provided that it finds heapq and sets. All you have to do is to steal
heapq.py and sets.py from python 2.3 or newer, and drop them in your
GIT_PYTHON_PATH. 

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	I noted that the python modules are installed uncompiled,
	i.e. *.py but not *.pyc. Is this intended?

 git-merge-recursive.py |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

applies-to: 2a67ad9e41fc614c7848ceff43f4b60b99cf932d
dfd75a554e84139ddce7b62ec82ef94254da1573
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 1bf73f3..d7d36aa 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -3,11 +3,13 @@
 # Copyright (C) 2005 Fredrik Kuivinen
 #
 
-import sys, math, random, os, re, signal, tempfile, stat, errno, traceback
+import sys
+sys.path.append('''@@GIT_PYTHON_PATH@@''')
+
+import math, random, os, re, signal, tempfile, stat, errno, traceback
 from heapq import heappush, heappop
 from sets import Set
 
-sys.path.append('''@@GIT_PYTHON_PATH@@''')
 from gitMergeCommon import *
 
 outputIndent = 0
---
0.99.9.GIT
