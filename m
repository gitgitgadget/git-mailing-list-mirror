From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 4/4] Port stg-whatchanged improvements to stg-mdiff and
	have the former use the latter.
Date: Tue, 24 Jul 2007 20:57:46 +0200
Message-ID: <20070724185746.17180.29218.stgit@gandelf.nowhere.earth>
References: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:58:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPam-0005vj-2r
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbXGXS6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753943AbXGXS6i
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:58:38 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45351 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754946AbXGXS6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:58:37 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A12DF59FE3;
	Tue, 24 Jul 2007 20:58:36 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 905CA5A19D;
	Tue, 24 Jul 2007 20:58:36 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 2FCDC1F084;
	Tue, 24 Jul 2007 20:57:46 +0200 (CEST)
In-Reply-To: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53627>

From: Yann Dirson <yann.dirson@sagem.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-mdiff       |    2 ++
 contrib/stg-whatchanged |   10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/stg-mdiff b/contrib/stg-mdiff
index 61cba9e..74d7f77 100755
--- a/contrib/stg-mdiff
+++ b/contrib/stg-mdiff
@@ -46,4 +46,6 @@ case "$2" in
 esac
 
 colordiff $diffopts \
+    -I '^index [0-9a-b]*..[0-9a-b]*' \
+    -I '^@@ .* @@' \
     <($cmd1 "$1") <($cmd2 "$2") | less -RFX
diff --git a/contrib/stg-whatchanged b/contrib/stg-whatchanged
index 231f4f5..afeda2c 100755
--- a/contrib/stg-whatchanged
+++ b/contrib/stg-whatchanged
@@ -25,11 +25,9 @@ fi
 # in this case (unlike, eg., "pick --fold")
 patchdir="$(git-rev-parse --git-dir)/patches/$(stg branch)/patches/$(stg top)"
 case $(stg log | head -n1) in
-    *push\(c\)*) current_cmd="stg show //top.old" ;;
-    *) current_cmd="stg show" ;;
+    *push\(c\)*) former="//top.old" ;;
+    *) former="//top" ;;
 esac
 
-colordiff "$@" \
-    -I '^index [0-9a-b]*..[0-9a-b]*' \
-    -I '^@@ .* @@' \
-    <($current_cmd) <(stg diff -r//bottom) | less -RFX
+stg-mdiff -o "$*" \
+    $former //bottom..
