From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 13/13] rebase -i: use "git sequencer--helper --cherry-pick"
Date: Wed, 12 Aug 2009 07:15:51 +0200
Message-ID: <20090812051552.18155.74239.chriscool@tuxfamily.org>
References: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 07:28:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb6O2-0003mw-GN
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 07:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZHLF2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 01:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbZHLF2X
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 01:28:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47777 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbZHLF2J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 01:28:09 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 741BF8180B5;
	Wed, 12 Aug 2009 07:28:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7E2768180FB;
	Wed, 12 Aug 2009 07:27:57 +0200 (CEST)
X-git-sha1: e010d32219ce9a2417e879f0b377669531299b31 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090812051116.18155.70541.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125661>

instead of "git cherry-pick", as this will make it easier to
port "git-rebase--interactive.sh" to C.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7651fd6..30af512 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -147,7 +147,7 @@ pick_one () {
 		pick_one_preserving_merges "$@" && return
 	if test ! -z "$REBASE_ROOT"
 	then
-		output git cherry-pick "$@"
+		git sequencer--helper --cherry-pick $sha1 $no_ff
 		return
 	fi
 	parent_sha1=$(git rev-parse --verify $sha1^) ||
@@ -157,7 +157,7 @@ pick_one () {
 		git sequencer--helper --fast-forward $sha1 \
 			"$GIT_REFLOG_ACTION" "$VERBOSE"
 	else
-		output git cherry-pick "$@"
+		git sequencer--helper --cherry-pick $sha1 $no_ff
 	fi
 }
 
@@ -269,7 +269,9 @@ pick_one_preserving_merges () {
 			fi
 			;;
 		*)
-			output git cherry-pick "$@" ||
+			no_commit=
+			test "a$1" = "a-n" && no_commit=t
+			git sequencer--helper --cherry-pick $sha1 $no_commit ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
-- 
1.6.4.271.ge010d
