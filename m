From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 6/6] rebase -i: use new --ff cherry-pick option
Date: Mon, 01 Feb 2010 08:55:41 +0100
Message-ID: <20100201075542.3929.76895.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 08:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbr6A-0005ho-Mb
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 08:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab0BAHxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 02:53:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49907 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab0BAHxD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 02:53:03 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AC34F8180BE;
	Mon,  1 Feb 2010 08:52:55 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A9DE181812C;
	Mon,  1 Feb 2010 08:52:52 +0100 (CET)
X-git-sha1: 72fba024e7e5ceac970dbf13beaf5889596a5d4c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100201074835.3929.11509.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138590>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c2f6089..6b224a6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -222,8 +222,8 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
-	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
+	ff=--ff
+	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
@@ -232,16 +232,7 @@ pick_one () {
 		output git cherry-pick "$@"
 		return
 	fi
-	parent_sha1=$(git rev-parse --verify $sha1^) ||
-		die "Could not get the parent of $sha1"
-	current_sha1=$(git rev-parse --verify HEAD)
-	if test -z "$no_ff" && test "$current_sha1" = "$parent_sha1"
-	then
-		output git reset --hard $sha1
-		output warn Fast-forward to $(git rev-parse --short $sha1)
-	else
-		output git cherry-pick "$@"
-	fi
+	output git cherry-pick $ff "$@"
 }
 
 pick_one_preserving_merges () {
-- 
1.6.6.1.557.g77031
