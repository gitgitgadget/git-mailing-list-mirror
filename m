From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 3/4] Don't print "rebasing" if the head doesn't change
Date: Sun, 04 Feb 2007 00:32:31 -0500
Message-ID: <20070204053231.15035.4631.stgit@dv.roinet.com>
References: <20070204053221.15035.88015.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 06:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDa0u-0003wt-NX
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 06:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164AbXBDFck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 00:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXBDFcg
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 00:32:36 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:48774 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbXBDFcd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 00:32:33 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDZyJ-0008GL-QJ
	for git@vger.kernel.org; Sun, 04 Feb 2007 00:31:27 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDZzL-0003w5-Tx; Sun, 04 Feb 2007 00:32:31 -0500
In-Reply-To: <20070204053221.15035.88015.stgit@dv.roinet.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38651>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 stgit/commands/pull.py |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index b63ef7a..0aee6bf 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -73,8 +73,10 @@ def func(parser, options, args):
     print 'Pulling from "%s"...' % repository
     git.fetch(repository)
     if (config.get('stgit.pull-does-rebase') == 'yes'):
-        print 'rebasing to "%s"...' % git.fetch_head()
-        git.reset(tree_id = git.fetch_head())
+        tree_id = git.fetch_head()
+        if tree_id != git.get_head():
+            print 'rebasing to "%s"...' % tree_id
+            git.reset(tree_id)
     print 'done'
 
     # push the patches back
