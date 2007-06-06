From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Fix removal of series with non-existant trash dir.
Date: Wed, 06 Jun 2007 23:05:17 +0200
Message-ID: <20070606210517.7657.97905.stgit@gandelf.nowhere.earth>
References: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2hL-0003gu-J2
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934989AbXFFVFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935190AbXFFVFS
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:05:18 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44469 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935096AbXFFVFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:05:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 514CD5A09C;
	Wed,  6 Jun 2007 23:05:15 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C55D41F019;
	Wed,  6 Jun 2007 23:05:17 +0200 (CEST)
In-Reply-To: <20070606205852.7657.69286.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49313>


Otherwise it is not possible to delete a stack that never had a patch
deleted (eg. a newborn stack).

Signed-off-by: Yann Dirson <ydirson@altern.org>

---

 stgit/stack.py |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 26b0561..30fcca7 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -679,10 +679,11 @@ class Series(StgitObject):
             for p in patches:
                 Patch(p, self.__patch_dir, self.__refs_dir).delete()
 
-            # remove the trash directory
-            for fname in os.listdir(self.__trash_dir):
-                os.remove(os.path.join(self.__trash_dir, fname))
-            os.rmdir(self.__trash_dir)
+            # remove the trash directory if any
+            if os.path.exists(self.__trash_dir):
+                for fname in os.listdir(self.__trash_dir):
+                    os.remove(os.path.join(self.__trash_dir, fname))
+                os.rmdir(self.__trash_dir)
 
             # FIXME: find a way to get rid of those manual removals
             # (move functionality to StgitObject ?)
