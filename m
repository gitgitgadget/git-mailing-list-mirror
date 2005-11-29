From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 3/7] Align branch descriptions in output of "stg branch -l"
Date: Tue, 29 Nov 2005 17:09:43 -0500
Message-ID: <20051129220942.9885.29688.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfh-0006zv-GW
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVK2WJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2WJp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:45 -0500
Received: from citi.umich.edu ([141.211.133.111]:37029 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932438AbVK2WJn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:43 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 561BE1BBD7;
	Tue, 29 Nov 2005 17:09:43 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12963>

When printing branch descriptions, start descriptions in the same column.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/branch.py |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c3f7944..ccf1f6b 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -63,7 +63,7 @@ options = [make_option('-c', '--create',
 def __is_current_branch(branch_name):
     return crt_series.get_branch() == branch_name
 
-def __print_branch(branch_name):
+def __print_branch(branch_name, length):
     initialized = ' '
     current = ' '
     protected = ' '
@@ -76,8 +76,8 @@ def __print_branch(branch_name):
         current = '>'
     if branch.get_protected():
         protected = 'p'
-    print '%s %s%s\t%s\t%s' % (current, initialized, protected, branch_name, \
-                               branch.get_description())
+    print current + ' ' + initialized + protected + '\t' + \
+          branch_name.ljust(length) + '  | ' + branch.get_description()
 
 def __delete_branch(doomed_name, force = False):
     doomed = stack.Series(doomed_name)
@@ -138,10 +138,11 @@ def func(parser, options, args):
 
         branches = os.listdir(os.path.join(git.get_base_dir(), 'refs', 'heads'))
         branches.sort()
+        max_len = max([len(i) for i in branches])
 
         print 'Available branches:'
         for i in branches:
-            __print_branch(i)
+            __print_branch(i, max_len)
         return
 
     elif options.protect:
