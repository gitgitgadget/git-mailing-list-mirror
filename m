From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Add an option to delete a patch from a certain branch
Date: Mon, 31 Oct 2005 21:54:47 +0100
Message-ID: <20051031205446.2341.98354.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 21:52:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgbz-0001yd-Ma
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVJaUuc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVJaUuc
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:50:32 -0500
Received: from host54-33.pool8257.interbusiness.it ([82.57.33.54]:59870 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751245AbVJaUub
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:50:31 -0500
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 644ED1BA9C;
	Mon, 31 Oct 2005 21:54:47 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10886>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Actually, simply adding the option is enough...
Restrict print_crt_patch() to the case when we didn't specify --branch (as it's
useless otherwise).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/delete.py |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -32,8 +32,8 @@ be part of the unapplied list or be the 
 case the command also popping it from the stack. Note that the
 'delete' operation is irreversible."""
 
-options = []
-
+options = [make_option('-b', '--branch',
+                       help = 'use BRANCH instead of the default one')]
 
 def func(parser, options, args):
     """Deletes a patch
@@ -48,4 +48,6 @@ def func(parser, options, args):
 
     crt_series.delete_patch(args[0])
     print 'Patch "%s" successfully deleted' % args[0]
-    print_crt_patch()
+
+    if not options.branch:
+        print_crt_patch()
