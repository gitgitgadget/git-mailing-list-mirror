From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] The user does not want to mess with the refspecs.
Date: Fri, 02 Feb 2007 00:48:00 +0100
Message-ID: <20070201234759.3313.51174.stgit@gandelf.nowhere.earth>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClfj-0001e2-Rs
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbXBAXsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422919AbXBAXsv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:48:51 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:43737 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422897AbXBAXsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:48:51 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AE07D7A3C;
	Fri,  2 Feb 2007 00:48:49 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 11BCB1F07F;
	Fri,  2 Feb 2007 00:48:00 +0100 (CET)
In-Reply-To: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38434>


The only use I know of for this parameter is 'stg pull . <branch>',
for which 'stg rebase <branch>' should be used instead.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 0608fb6..f837fd4 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -24,7 +24,7 @@ from stgit import stack, git
 
 
 help = 'pull the changes from the remote repository'
-usage = """%prog [options] [<repository>] [<refspec>]
+usage = """%prog [options] [<repository>]
 
 Pull the latest changes from the given repository (defaulting to
 'origin'). This command works by popping all the patches from the
@@ -34,8 +34,7 @@ of the stack to the latest parent HEAD and pushing the patches back
 there are conflicts. They need to be resolved and the patch pushed
 again.
 
-Check the 'git pull' documentation for the <repository> and <refspec>
-format."""
+Check the 'git pull' documentation for the <repository> format."""
 
 options = [make_option('-n', '--nopush',
                        help = 'do not push the patches back after pulling',
@@ -47,7 +46,7 @@ options = [make_option('-n', '--nopush',
 def func(parser, options, args):
     """Pull the changes from a remote repository
     """
-    if len(args) > 2:
+    if len(args) > 1:
         parser.error('incorrect number of arguments')
 
     if len(args) >= 1:
@@ -55,10 +54,6 @@ def func(parser, options, args):
     else:
         repository = crt_series.get_parent_remote()
 
-    refspec = None
-    if len(args) == 2:
-        refspec = args[1]
-
     if crt_series.get_protected():
         raise CmdException, 'This branch is protected. Pulls are not permitted'
 
@@ -76,7 +71,7 @@ def func(parser, options, args):
 
     # pull the remote changes
     print 'Pulling from "%s"...' % repository
-    git.pull(repository, refspec)
+    git.pull(repository)
     print 'done'
 
     # push the patches back
