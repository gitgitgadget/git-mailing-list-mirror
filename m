From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 2/5] Rename Repository.head to Repository.head_ref
Date: Wed, 04 Jun 2008 22:13:25 +0100
Message-ID: <20080604211325.32531.84968.stgit@localhost.localdomain>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40XX-00070Z-E2
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYFDV2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYFDV2L
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:28:11 -0400
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:33740 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111AbYFDV2J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:28:09 -0400
X-Greylist: delayed 893 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jun 2008 17:28:07 EDT
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080604211731.GVFB28496.mtaout01-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:17:31 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080604211333.FPLS18637.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:13:33 +0100
In-Reply-To: <20080604210655.32531.82580.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83831>

This is to avoid confusion with the Stack.head function which returns
a commit object rather than a file name. The patch also changes the
"new" function to use stack.head directly rather than via the
Repository.refs... object.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/new.py |    3 +--
 stgit/lib/git.py      |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 15bb2e0..c4ee4e1 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -58,9 +58,8 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
 
-    head = directory.repository.refs.get(directory.repository.head)
     cd = gitlib.CommitData(
-        tree = head.data.tree, parents = [head], message = '',
+        tree = stack.head.data.tree, parents = [stack.head], message = '',
         author = gitlib.Person.author(), committer = gitlib.Person.committer())
 
     # Set patch commit message from commandline.
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index c9f01e3..fd66f6d 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -443,13 +443,13 @@ class Repository(RunWithEnv):
                                                 ).output_one_line()
         return self.get_commit(sha1)
     @property
-    def head(self):
+    def head_ref(self):
         try:
             return self.run(['git', 'symbolic-ref', '-q', 'HEAD']
                             ).output_one_line()
         except run.RunException:
             raise DetachedHeadException()
-    def set_head(self, ref, msg):
+    def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_output()
     def simple_merge(self, base, ours, theirs):
         """Given three L{Tree}s, tries to do an in-index merge with a
