From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/9] rebase -i: use "git sequencer--helper --fast-forward"
Date: Fri, 21 Aug 2009 07:49:55 +0200
Message-ID: <20090821055001.3726.90621.chriscool@tuxfamily.org>
References: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeN6Y-0001bm-Pk
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbZHUFzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZHUFzs
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:55:48 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56361 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbZHUFzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:55:44 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 57AD7818111;
	Fri, 21 Aug 2009 07:55:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 23C53818109;
	Fri, 21 Aug 2009 07:55:35 +0200 (CEST)
X-git-sha1: 95350f4b51b5bf96573aed427cac93b8477be612 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090821054729.3726.5078.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126681>

when fast forwarding.

Note that in the first hunk of this patch, there was this line:

test "a$1" = a-n && output git reset --soft $current_sha1

but the test always failed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-rebase--interactive.sh |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0041994..7651fd6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -154,11 +154,8 @@ pick_one () {
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
 	if test "$no_ff$current_sha1" = "$parent_sha1"; then
-		git sequencer--helper --reset-hard $sha1 \
+		git sequencer--helper --fast-forward $sha1 \
 			"$GIT_REFLOG_ACTION" "$VERBOSE"
-		test "a$1" = a-n && output git reset --soft $current_sha1
-		sha1=$(git rev-parse --short $sha1)
-		output warn Fast forward to $sha1
 	else
 		output git cherry-pick "$@"
 	fi
@@ -238,10 +235,8 @@ pick_one_preserving_merges () {
 	done
 	case $fast_forward in
 	t)
-		output warn "Fast forward to $sha1"
-		git sequencer--helper --reset-hard $sha1 \
-			"$GIT_REFLOG_ACTION" "$VERBOSE" ||
-			die "Cannot fast forward to $sha1"
+		git sequencer--helper --fast-forward $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" || exit
 		;;
 	f)
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
-- 
1.6.4.271.ge010d
