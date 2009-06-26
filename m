From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] rebase -i: use "git sequencer--helper --make-patch"
Date: Fri, 26 Jun 2009 23:08:46 +0200
Message-ID: <20090626210847.3885.97099.chriscool@tuxfamily.org>
References: <20090626205319.3885.91532.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:09:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKIfU-0000qR-W3
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 23:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755852AbZFZVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 17:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754958AbZFZVI4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 17:08:56 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56334 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbZFZVIv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 17:08:51 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1A86E818151;
	Fri, 26 Jun 2009 23:08:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 08F67818139;
	Fri, 26 Jun 2009 23:08:43 +0200 (CEST)
X-git-sha1: e61c38e262903efd95931e7dc65c07cbae3f0008 
X-Mailer: git-mail-commits v0.5.0
In-Reply-To: <20090626205319.3885.91532.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122325>

to simplify the "make_patch" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3be49dd..82f1133 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -146,18 +146,7 @@ load_author_ident () {
 }
 
 make_patch () {
-	sha1_and_parents="$(git rev-list --parents -1 "$1")"
-	case "$sha1_and_parents" in
-	?*' '?*' '?*)
-		git diff --cc $sha1_and_parents
-		;;
-	?*' '?*)
-		git diff-tree -p "$1^!"
-		;;
-	*)
-		echo "Root commit"
-		;;
-	esac > "$DOTEST"/patch
+	git sequencer--helper --make-patch "$1"
 	test -f "$DOTEST"/message ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$DOTEST"/message
 	test -f "$SAVE_AUTHOR_INFO" || {
-- 
1.6.3.GIT
