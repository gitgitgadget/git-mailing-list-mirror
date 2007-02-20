From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/5] Move stack-base querying into Series class.
Date: Tue, 20 Feb 2007 01:14:08 +0100
Message-ID: <20070220001408.31139.3657.stgit@gandelf.nowhere.earth>
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
	id 1HJJE2-0000P4-EP
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965819AbXBTAuz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965821AbXBTAuz
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:50:55 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44250 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965819AbXBTAuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:50:51 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D73B84EBFF;
	Tue, 20 Feb 2007 01:25:32 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C454A1F08A;
	Tue, 20 Feb 2007 01:14:08 +0100 (CET)
In-Reply-To: <20070220000908.31139.36841.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40181>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/common.py |    2 +-
 stgit/stack.py           |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index a352d89..240d003 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -101,7 +101,7 @@ def git_id(rev):
             elif patch_id == 'log':
                 return series.get_patch(patch).get_log()
         if patch == 'base' and patch_id == None:
-            return read_string(series.get_base_file())
+            return series.get_base()
     except RevParseException:
         pass
     return git.rev_parse(rev + '^{commit}')
diff --git a/stgit/stack.py b/stgit/stack.py
index 3632aa1..dc6caa6 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -394,6 +394,9 @@ class Series(StgitObject):
         self.__begin_stack_check()
         return self.__base_file
 
+    def get_base(self):
+        return read_string(self.get_base_file())
+
     def get_protected(self):
         return os.path.isfile(os.path.join(self._dir(), 'protected'))
 
@@ -609,7 +612,7 @@ class Series(StgitObject):
         """
         try:
             # allow cloning of branches not under StGIT control
-            base = read_string(self.get_base_file())
+            base = self.get_base()
         except:
             base = git.get_head()
         Series(target_series).init(create_at = base)
