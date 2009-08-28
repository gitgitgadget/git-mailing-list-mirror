From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 06/15] rebase -i: use "git sequencer--helper --reset-hard"
Date: Fri, 28 Aug 2009 06:47:36 +0200
Message-ID: <20090828044746.4307.71321.chriscool@tuxfamily.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 07:00:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgtZh-0006Ec-PA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 07:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbZH1E7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 00:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZH1E7P
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 00:59:15 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49763 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbZH1E7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 00:59:13 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B415A8180EC;
	Fri, 28 Aug 2009 06:59:03 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 748108180BF;
	Fri, 28 Aug 2009 06:59:00 +0200 (CEST)
X-git-sha1: d656b317de5e46c1c84d42194014387480b2255e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20090828043913.4307.34708.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127258>

instead of "git reset --hard"

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c9c75c0..0041994 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -154,7 +154,8 @@ pick_one () {
 		die "Could not get the parent of $sha1"
 	current_sha1=$(git rev-parse --verify HEAD)
 	if test "$no_ff$current_sha1" = "$parent_sha1"; then
-		output git reset --hard $sha1
+		git sequencer--helper --reset-hard $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE"
 		test "a$1" = a-n && output git reset --soft $current_sha1
 		sha1=$(git rev-parse --short $sha1)
 		output warn Fast forward to $sha1
@@ -238,7 +239,8 @@ pick_one_preserving_merges () {
 	case $fast_forward in
 	t)
 		output warn "Fast forward to $sha1"
-		output git reset --hard $sha1 ||
+		git sequencer--helper --reset-hard $sha1 \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" ||
 			die "Cannot fast forward to $sha1"
 		;;
 	f)
@@ -536,7 +538,8 @@ first and then run 'git rebase --continue' again."
 			git symbolic-ref HEAD $HEADNAME
 			;;
 		esac &&
-		output git reset --hard $HEAD &&
+		git sequencer--helper --reset-hard $HEAD \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" &&
 		rm -rf "$DOTEST"
 		exit
 		;;
@@ -548,7 +551,9 @@ first and then run 'git rebase --continue' again."
 		git rerere clear
 		test -d "$DOTEST" || die "No interactive rebase running"
 
-		output git reset --hard && do_rest
+		git sequencer--helper --reset-hard HEAD \
+			"$GIT_REFLOG_ACTION" "$VERBOSE" &&
+		do_rest
 		;;
 	-s)
 		case "$#,$1" in
-- 
1.6.4.271.ge010d
