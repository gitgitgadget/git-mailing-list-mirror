From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/7] Move identification of parent branch's remote def up into
	stack class.
Date: Tue, 30 Jan 2007 00:05:35 +0100
Message-ID: <20070129230535.7102.54749.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfa5-00053b-6m
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbXA2XG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbXA2XG3
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:06:29 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:60146 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964806AbXA2XG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:06:28 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 9633E43730;
	Tue, 30 Jan 2007 00:06:26 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 84DA81F07F;
	Tue, 30 Jan 2007 00:05:35 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38107>


Also adds the __set_parent_remote() counterpart method, but only
private since it is expected to be called only through set_parent, to
be introduced in subsequent patch.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    2 +-
 stgit/stack.py         |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index e47858a..0608fb6 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -53,7 +53,7 @@ def func(parser, options, args):
     if len(args) >= 1:
         repository = args[0]
     else:
-        repository = config.get('branch.%s.remote' % git.get_head_file()) or 'origin'
+        repository = crt_series.get_parent_remote()
 
     refspec = None
     if len(args) == 2:
diff --git a/stgit/stack.py b/stgit/stack.py
index 6281f36..947b416 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -407,6 +407,12 @@ class Series(StgitObject):
     def set_description(self, line):
         self._set_field('description', line)
 
+    def get_parent_remote(self):
+        return config.get('branch.%s.remote' % self.__name) or 'origin'
+
+    def __set_parent_remote(self, remote):
+        value = config.set('branch.%s.remote' % self.__name, remote)
+
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
 
