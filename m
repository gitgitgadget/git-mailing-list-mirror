From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 7/7] rebase -i: use new --ff cherry-pick option
Date: Sat, 06 Mar 2010 21:34:46 +0100
Message-ID: <20100306203447.2960.47050.chriscool@tuxfamily.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 03:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No6EB-0003Eu-1w
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 03:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0CGC17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 21:27:59 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:45523 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402Ab0CGC1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 21:27:52 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9E5EA81809E;
	Sun,  7 Mar 2010 03:27:43 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A6AC4818083;
	Sun,  7 Mar 2010 03:27:37 +0100 (CET)
X-git-sha1: 71a7387794f538429d49595209dae43899a8cf6d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100306203250.2960.30309.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141638>

This simplifies rebase -i a little bit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3e4fd14..92d19f5 100755
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
1.7.0.1.307.g861f4
