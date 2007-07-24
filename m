From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/4] Add range comparison support to stg-mdiff.
Date: Tue, 24 Jul 2007 20:57:35 +0200
Message-ID: <20070724185735.17180.36833.stgit@gandelf.nowhere.earth>
References: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:58:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDPal-0005vj-1G
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465AbXGXS6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbXGXS6a
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 14:58:30 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45219 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbXGXS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 14:58:29 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 44BB95A244;
	Tue, 24 Jul 2007 20:58:28 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 287FD5A22B;
	Tue, 24 Jul 2007 20:58:28 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id EBD5A1F084;
	Tue, 24 Jul 2007 20:57:35 +0200 (CEST)
In-Reply-To: <20070724185535.17180.24577.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53628>

From: Yann Dirson <yann.dirson@sagem.com>

We can now compare arbitrary deltas, not just single commits.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-mdiff |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/contrib/stg-mdiff b/contrib/stg-mdiff
index cd0c678..9bb324a 100755
--- a/contrib/stg-mdiff
+++ b/contrib/stg-mdiff
@@ -12,7 +12,7 @@ set -e
 
 usage()
 {
-    echo "Usage: $(basename $0) <patch1> <patch2>"
+    echo "Usage: $(basename $0) <from1>..[<to1>]|<patch1> <from2>..[<to2>]|<patch2>"
     exit 1
 }
 
@@ -20,4 +20,13 @@ if [ "$#" != 2 ]; then
     usage
 fi
 
-colordiff -u <(stg show "$1") <(stg show "$2") | less -RFX
+case "$1" in
+*..*) cmd1="stg diff" ;;
+*)    cmd1="stg show" ;;
+esac
+case "$2" in
+*..*) cmd2="stg diff" ;;
+*)    cmd2="stg show" ;;
+esac
+
+colordiff -u <($cmd1 "$1") <($cmd2 "$2") | less -RFX
