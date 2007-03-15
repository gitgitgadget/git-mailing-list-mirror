From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 02/10] Fix diagnostic messages on patch deletion and simplify
	others.
Date: Thu, 15 Mar 2007 01:26:39 +0100
Message-ID: <20070315002639.9094.82423.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdno-0002yw-Kd
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbXCOA0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422757AbXCOA0m
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:42 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58998 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964931AbXCOA0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:41 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 37AB181DC;
	Thu, 15 Mar 2007 01:26:40 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C3EF71F095;
	Thu, 15 Mar 2007 01:26:39 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42256>


Also make use standard os.removedirs(), allowing for the same
simplification.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 8a63102..8fdaf2c 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -571,7 +571,7 @@ class Series(StgitObject):
                 os.rmdir(self.__patch_dir)
                 print 'done'
             else:
-                print 'Patch directory %s is not empty.' % self.__name
+                print 'Patch directory %s is not empty.' % self.__patch_dir
 
             self.__patch_dir = self._dir()
 
@@ -678,18 +678,19 @@ class Series(StgitObject):
                 os.remove(self.__descr_file)
             if os.path.exists(self._dir()+'/orig-base'):
                 os.remove(self._dir()+'/orig-base')
+
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
-                print 'Patch directory %s is not empty.' % self.__name
+                print 'Patch directory %s is not empty.' % self.__patch_dir
+
             if not os.listdir(self._dir()):
-                remove_dirs(os.path.join(self.__base_dir, 'patches'),
-                            self.__name)
+                os.removedirs(self._dir())
             else:
-                print 'Series directory %s is not empty.' % self.__name
+                raise StackException, 'Series directory %s is not empty.' % self._dir()
+
             if not os.listdir(self.__refs_dir):
-                remove_dirs(os.path.join(self.__base_dir, 'refs', 'patches'),
-                            self.__name)
+                os.removedirs(self.__refs_dir)
             else:
                 print 'Refs directory %s is not empty.' % self.__refs_dir
 
