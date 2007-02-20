From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/5] Keep track of safe base changes.
Date: Tue, 20 Feb 2007 01:14:19 +0100
Message-ID: <20070220001418.31139.49033.stgit@gandelf.nowhere.earth>
References: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJJE1-0000P4-Tt
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbXBTAux (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965822AbXBTAuw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:52 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44248 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965818AbXBTAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:50 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D74CC51554;
	Tue, 20 Feb 2007 01:25:32 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 049D31F091;
	Tue, 20 Feb 2007 01:14:19 +0100 (CET)
In-Reply-To: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40183>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |    2 ++
 stgit/stack.py           |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 240d003..56cb517 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -366,6 +366,8 @@ def rebase(target):
     git.reset(tree_id = git_id(target))
 
 def post_rebase(applied, nopush, merged):
+    # memorize that we rebased to here
+    crt_series._set_field('orig-base', git.get_head())
     # push the patches back
     if not nopush:
         push_patches(applied, merged)
diff --git a/stgit/stack.py b/stgit/stack.py
index 3185d64..0f5d868 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -540,6 +540,7 @@ class Series(StgitObject):
         os.makedirs(os.path.join(self._dir(), 'patches'))
         os.makedirs(self.__refs_dir)
         self.__begin_stack_check()
+        self._set_field('orig-base', git.get_head())
 
     def convert(self):
         """Either convert to use a separate patch directory, or
