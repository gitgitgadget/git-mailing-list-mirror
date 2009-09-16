From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH 1/5] Remove the 'fail_dump' argument to git.apply_patch()
Date: Wed, 16 Sep 2009 22:40:55 +0100
Message-ID: <20090916214055.6622.96912.stgit@toshiba-laptop>
References: <20090916214049.6622.44662.stgit@toshiba-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 23:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo2Ml-0003lJ-62
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760127AbZIPVse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760164AbZIPVsb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:48:31 -0400
Received: from cpc3-cmbg12-0-0-cust617.cmbg.cable.ntl.com ([86.9.126.106]:45393
	"EHLO toshiba-laptop" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760161AbZIPVs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:48:28 -0400
Received: by toshiba-laptop (Postfix, from userid 1000)
	id 907F21C079A; Wed, 16 Sep 2009 22:40:55 +0100 (BST)
In-Reply-To: <20090916214049.6622.44662.stgit@toshiba-laptop>
User-Agent: StGit/0.15-rc3-5-g9f71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128682>

Since we have a 'reject' argument, there is no need for the failed diff
to be dumped.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/git.py |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 012e282..97b1e96 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -818,7 +818,7 @@ def repack():
     GRun('repack', '-a', '-d', '-f').run()
 
 def apply_patch(filename = None, diff = None, base = None,
-                fail_dump = True, reject = False, strip = None):
+                reject = False, strip = None):
     """Apply a patch onto the current or given index. There must not
     be any local changes in the tree, otherwise the command fails
     """
@@ -847,14 +847,7 @@ def apply_patch(filename = None, diff = None, base = None,
     except GitRunException:
         if base:
             switch(orig_head)
-        if fail_dump:
-            # write the failed diff to a file
-            f = file('.stgit-failed.patch', 'w+')
-            f.write(diff)
-            f.close()
-            out.warn('Diff written to the .stgit-failed.patch file')
-
-        raise
+        raise GitException('Diff does not apply cleanly')
 
     if base:
         top = commit(message = 'temporary commit used for applying a patch',
