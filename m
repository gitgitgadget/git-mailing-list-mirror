From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Classify commands in stg --help output.
Date: Sun, 28 May 2006 23:25:19 +0200
Message-ID: <20060528212519.3207.76228.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 23:21:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkSh9-0007rY-57
	for gcvg-git@gmane.org; Sun, 28 May 2006 23:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWE1VU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 17:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWE1VU6
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 17:20:58 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:11441 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750951AbWE1VU5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 17:20:57 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 78AA9275A4;
	Sun, 28 May 2006 23:20:56 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FkSt2-0007Fj-8v; Sun, 28 May 2006 23:33:24 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20895>


Commands will be much easier to find out that way.
Inspiration mostly comes from pg-help.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/main.py |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/stgit/main.py b/stgit/main.py
index df4e1f5..83bffb4 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -100,19 +100,85 @@ commands = {
     'uncommit': stgit.commands.uncommit,
     }
 
+# classification: repository, stack, patch, working copy
+repocommands = (
+    'branch',
+    'clone',
+    'id'
+    )
+stackcommands = (
+    'applied',
+    'clean',
+    'commit',
+    'goto',
+    'init',
+    'pop',
+    'pull',
+    'push',
+    'series',
+    'top',
+    'unapplied',
+    'uncommit'
+    )
+patchcommands = (
+    'delete',
+    'export',
+    'files',
+    'fold',
+    'import',
+    'mail',
+    'new',
+    'pick',
+    'refresh',
+    'rename',
+    'show'
+    )
+wccommands = (
+    'add',
+    'diff',
+    'patches',
+    'resolved',
+    'rm',
+    'status'
+    )
+
+def _print_helpstring(cmd):
+    print '  ' + cmd + ' ' * (12 - len(cmd)) + commands[cmd].help
+    
 def print_help():
     print 'usage: %s <command> [options]' % os.path.basename(sys.argv[0])
     print
-    print 'commands:'
+    print 'Generic commands:'
     print '  help        print the detailed command usage'
     print '  version     display version information'
     print '  copyright   display copyright information'
-    print
-
+    # unclassified commands if any
     cmds = commands.keys()
     cmds.sort()
     for cmd in cmds:
-        print '  ' + cmd + ' ' * (12 - len(cmd)) + commands[cmd].help
+        if not cmd in repocommands and not cmd in stackcommands \
+               and not cmd in patchcommands and not cmd in wccommands:
+            _print_helpstring(cmd)
+    print
+
+    print 'Repository commands:'
+    for cmd in repocommands:
+        _print_helpstring(cmd)
+    print
+    
+    print 'Stack commands:'
+    for cmd in stackcommands:
+        _print_helpstring(cmd)
+    print
+
+    print 'Patch commands:'
+    for cmd in patchcommands:
+        _print_helpstring(cmd)
+    print
+
+    print 'Working-copy commands:'
+    for cmd in wccommands:
+        _print_helpstring(cmd)
 
 #
 # The main function (command dispatcher)
