From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 02/11] Make "empty patch" checking optional in "series" command.
Date: Fri, 16 Sep 2005 21:35:13 +0200
Message-ID: <20050916193513.18681.60765.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2i-0005rS-DU
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbVIPTi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbVIPTi3
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:29 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:28043 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965307AbVIPTi2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:28 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id E0F4B284E1;
	Fri, 16 Sep 2005 21:35:13 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8710>

That's just too slow, and quilt doesn't do it, so user will live with it.
Don't know if there's a reason to allow dropping the fanciness here
entirely, but I think there's no user doing one-liner scripts with quilt
series. And anyway, for that you can do "stg applied; stg unapplied".

Actually, with this patch you must ask explicitly the checking.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/series.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/series.py b/stgit/commands/series.py
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -31,7 +31,10 @@ Show all the patches in the series. The 
 with a '+' and the unapplied ones with a '-'. The current patch is
 prefixed with a '>'. Empty patches are prefixed with a '0'."""
 
-options = []
+options = [make_option('-e', '--empty',
+                       help = 'check whether patches are empty '
+                       '(much slower)',
+                       action = 'store_true') ]
 
 
 def func(parser, options, args):
@@ -43,19 +46,19 @@ def func(parser, options, args):
     applied = crt_series.get_applied()
     if len(applied) > 0:
         for p in applied [0:-1]:
-            if crt_series.empty_patch(p):
+            if options.empty and crt_series.empty_patch(p):
                 print '0', p
             else:
                 print '+', p
         p = applied[-1]
 
-        if crt_series.empty_patch(p):
+        if options.empty and crt_series.empty_patch(p):
             print '0>%s' % p
         else:
             print '> %s' % p
 
     for p in crt_series.get_unapplied():
-        if crt_series.empty_patch(p):
+        if options.empty and crt_series.empty_patch(p):
             print '0', p
         else:
             print '-', p
