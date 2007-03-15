From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 01/10] Fix stack deletion when orig-base is present.
Date: Thu, 15 Mar 2007 01:26:34 +0100
Message-ID: <20070315002634.9094.6274.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:26:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdno-0002yw-4P
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbXCOA0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbXCOA0g
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:36 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58992 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964930AbXCOA0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:36 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 188D1395B;
	Thu, 15 Mar 2007 01:26:35 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id A4C1A1F095;
	Thu, 15 Mar 2007 01:26:34 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42257>


The introduction of the orig-base file makes the stack deletion fail
to remove the stack's directory, leaving the stack in a zombie state,
where attempting to recreate it was refused because of the directory
already existing, but attempting to delete it failed since the applied
and unapplied files were not found.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index feb77e3..8a63102 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -676,6 +676,8 @@ class Series(StgitObject):
                 os.remove(self.__current_file)
             if os.path.exists(self.__descr_file):
                 os.remove(self.__descr_file)
+            if os.path.exists(self._dir()+'/orig-base'):
+                os.remove(self._dir()+'/orig-base')
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
