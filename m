From: Chuck Lever <cel@netapp.com>
Subject: [PATCH] Fast-forwarding does a git.switch() even when it forwarded no patches
Date: Thu, 01 Dec 2005 19:15:13 -0500
Message-ID: <20051202001513.9140.14792.stgit@dexter.citi.umich.edu>
References: <20051202001141.9140.23252.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhyaD-0006n9-BG
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 01:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVLBAPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 19:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVLBAPP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 19:15:15 -0500
Received: from citi.umich.edu ([141.211.133.111]:14674 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932580AbVLBAPO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 19:15:14 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id A09691BB85;
	Thu,  1 Dec 2005 19:15:13 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051202001141.9140.23252.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13092>

The git.switch() in forward_patches() is not needed when no patches have
been fast forwarded.  This is a significant speed up.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/stack.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 3fd6a46..3cc37c5 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -735,6 +735,9 @@ class Series:
             forwarded+=1
             unapplied.remove(name)
 
+        if forwarded == 0:
+            return 0
+
         git.switch(top)
 
         append_strings(self.__applied_file, names[0:forwarded])
