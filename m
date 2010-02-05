From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 8/9] rebase -i: use new --ff cherry-pick option
Date: Sat, 06 Feb 2010 00:11:10 +0100
Message-ID: <20100205231112.3689.91599.chriscool@tuxfamily.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXM4-0008WA-3J
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933331Ab0BEXMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:12:37 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53996 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757666Ab0BEXMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:12:03 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 509B8818096;
	Sat,  6 Feb 2010 00:11:52 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0E5F78180B6;
	Sat,  6 Feb 2010 00:11:50 +0100 (CET)
X-git-sha1: 8bd2aaac4010e4b3b41816015356ba2af03f4780 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100205231028.3689.12228.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139115>

This simplifies rebase -i a little bit.

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
