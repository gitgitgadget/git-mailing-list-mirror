From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 9/9] rebase -i: use new --ff cherry-pick option
Date: Wed, 03 Mar 2010 21:11:44 +0100
Message-ID: <20100303201146.23506.89089.chriscool@tuxfamily.org>
References: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 03:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn0Rp-0008HT-Uj
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 03:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685Ab0CDCFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 21:05:44 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40593 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab0CDCFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 21:05:24 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 50E79818076;
	Thu,  4 Mar 2010 03:05:10 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 19553818082;
	Thu,  4 Mar 2010 03:05:08 +0100 (CET)
X-git-sha1: 76f22179ccf156761bd7fc9a4adb366decafacea 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100303201046.23506.32653.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141502>

This simplifies rebase -i a little bit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 415ae72..a57f043 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -230,8 +230,8 @@ do_with_author () {
 }
 
 pick_one () {
-	no_ff=
-	case "$1" in -n) sha1=$2; no_ff=t ;; *) sha1=$1 ;; esac
+	ff=--ff
+	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
@@ -240,16 +240,7 @@ pick_one () {
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
1.7.0.315.gbc198
