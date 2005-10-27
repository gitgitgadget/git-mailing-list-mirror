From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 1/2] Parse /top.old with id and when requesting diffs
Date: Thu, 27 Oct 2005 10:56:22 +0200
Message-ID: <20051027085622.2482.22005.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 11:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV3dc-0007Rp-Pe
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVJ0JB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVJ0JB3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:01:29 -0400
Received: from [151.97.230.9] ([151.97.230.9]:33475 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S965012AbVJ0JB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 05:01:28 -0400
Received: (qmail 31812 invoked by uid 508); 27 Oct 2005 11:01:24 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 27 Oct 2005 11:01:24 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 533399AE00;
	Thu, 27 Oct 2005 10:56:24 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10703>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Comparing a patch after and before a merge is very important, and looking into
.git/patches by hand is not the nicer way to do it.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/common.py |    5 +++++
 stgit/stack.py           |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -68,6 +68,11 @@ def git_id(string):
             return series.get_patch(patch_name).get_top()
         elif patch_id == 'bottom':
             return series.get_patch(patch_name).get_bottom()
+        # Note we can return None here.
+        elif patch_id == 'top.old':
+            return series.get_patch(patch_name).get_old_top()
+        elif patch_id == 'bottom.old':
+            return series.get_patch(patch_name).get_old_bottom()
 
     # base
     if patch_name == 'base' and len(string_list) == 1:
diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -165,6 +165,9 @@ class Patch:
         elif os.path.isfile(fname):
             os.remove(fname)
 
+    def get_old_bottom(self):
+        return self.__get_field('bottom.old')
+
     def get_bottom(self):
         return self.__get_field('bottom')
 
@@ -177,6 +180,9 @@ class Patch:
                 self.__set_field('bottom.old', None)
         self.__set_field('bottom', string)
 
+    def get_old_top(self):
+        return self.__get_field('top.old')
+
     def get_top(self):
         return self.__get_field('top')
 
