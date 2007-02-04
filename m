From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Don't print "rebasing" if the head doesn't change
Date: Sun, 04 Feb 2007 12:44:03 -0500
Message-ID: <20070204174403.7926.29304.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 18:44:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDlPN-0006h9-Kl
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 18:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbXBDRoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 12:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbXBDRoH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 12:44:07 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42833 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbXBDRoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 12:44:05 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDlOE-0004GY-Lj
	for git@vger.kernel.org; Sun, 04 Feb 2007 12:42:58 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDlPH-000248-60; Sun, 04 Feb 2007 12:44:03 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38697>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---
Please ignore previous version of this patch; it was buggy.
---

 stgit/commands/pull.py |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index b63ef7a..2d4a782 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -73,8 +73,10 @@ def func(parser, options, args):
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
     if (config.get('stgit.pull-does-rebase') == 'yes'):
-        print 'rebasing to "%s"...' % git.fetch_head()
-        git.reset(tree_id = git.fetch_head())
+        fetch_head = git.fetch_head()
+        if fetch_head != git.get_head():
+            print 'rebasing to "%s"...' % fetch_head
+            git.reset(tree_id = fetch_head)
     print 'done'
 
     # push the patches back
