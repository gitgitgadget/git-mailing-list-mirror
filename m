From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/2] merge-recursive: Speed up commit graph construction
Date: Thu, 2 Feb 2006 12:43:35 +0100
Message-ID: <20060202114335.GC8103@c165.ib.student.liu.se>
References: <20060202113848.GA8103@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 02 12:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4csF-000130-WE
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 12:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWBBLnh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 06:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWBBLnh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 06:43:37 -0500
Received: from [85.8.31.11] ([85.8.31.11]:64677 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750912AbWBBLng (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 06:43:36 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 3283B4114; Thu,  2 Feb 2006 12:57:05 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F4csB-0007Xx-00; Thu, 02 Feb 2006 12:43:35 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060202113848.GA8103@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15504>

Use __slots__ to speed up construction and decrease memory consumption
of the Commit objects.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 gitMergeCommon.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

23aa79d4e86761e049bc44b5106cd45355045174
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
index ff6f58a..fdbf9e4 100644
--- a/gitMergeCommon.py
+++ b/gitMergeCommon.py
@@ -107,7 +107,10 @@ def isSha(obj):
     return (type(obj) is str and bool(shaRE.match(obj))) or \
            (type(obj) is int and obj >= 1)
 
-class Commit:
+class Commit(object):
+    __slots__ = ['parents', 'firstLineMsg', 'children', '_tree', 'sha',
+                 'virtual']
+
     def __init__(self, sha, parents, tree=None):
         self.parents = parents
         self.firstLineMsg = None
-- 
1.1.6.gc78e-dirty
