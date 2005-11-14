From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 1/4] Better error message when renaming patches to same name
Date: Mon, 14 Nov 2005 11:50:55 -0500
Message-ID: <20051114165055.22202.28533.stgit@dexter.citi.umich.edu>
References: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Nov 14 17:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhXm-0002pa-39
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVKNQu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKNQu4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:50:56 -0500
Received: from citi.umich.edu ([141.211.133.111]:19345 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751189AbVKNQuz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:50:55 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 5B9BC1BB9A
	for <git@vger.kernel.org>; Mon, 14 Nov 2005 11:50:55 -0500 (EST)
To: git@vger.kernel.org
In-Reply-To: <20051114165007.22202.69803.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11824>

Generate a more precise error message when trying to rename a patch to the
same name.  This is what we get currently:

  [cel@dexter main]$ stg rename nfs_direct_wait nfs_direct_wait
  Renaming patch "nfs_direct_wait" -> "nfs_direct_wait"...stg rename: Patch
  "nfs_direct_wait" already exists

  [cel@dexter main]$

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/stack.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 1ffeaee..0907b37 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -775,6 +775,9 @@ class Series:
         applied = self.get_applied()
         unapplied = self.get_unapplied()
 
+        if oldname == newname:
+            raise StackException, '"To" name and "from" name are the same'
+
         if newname in applied or newname in unapplied:
             raise StackException, 'Patch "%s" already exists' % newname
 
