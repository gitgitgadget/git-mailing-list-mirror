From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/4] Fix stg-whatchanged to deal with conflicts already
	solved.
Date: Tue, 24 Jul 2007 20:57:30 +0200
Message-ID: <20070724185730.17180.87589.stgit@gandelf.nowhere.earth>
References: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPaW-0005qo-2o
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbXGXS6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbXGXS6X
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:58:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45198 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836AbXGXS6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:58:22 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 579585A218;
	Tue, 24 Jul 2007 20:58:21 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3F1765A213;
	Tue, 24 Jul 2007 20:58:21 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id D15191F084;
	Tue, 24 Jul 2007 20:57:30 +0200 (CEST)
In-Reply-To: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53625>

From: Yann Dirson <yann.dirson@sagem.com>

The most reliable way I found to decide if we were in the process of
solving a conflict, including when all conflicted files have already
been marked resolved, is to check the latest patchlog entry.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-whatchanged |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index a416e97..231f4f5 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -24,12 +24,10 @@ fi
 # Merges via "push" leave top=bottom so we must look at old patch
 # in this case (unlike, eg., "pick --fold")
 patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$(stg top)"
-if [ -s "$(git-rev-parse --git-dir)/conflicts" ];
-then
-    current_cmd="stg show //top.old"
-else
-    current_cmd="stg show"
-fi
+case $(stg log | head -n1) in
+    *push\(c\)*) current_cmd="stg show //top.old" ;;
+    *) current_cmd="stg show" ;;
+esac
 
 colordiff "$@" \
     -I '^index [0-9a-b]*..[0-9a-b]*' \
