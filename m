From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/18] rebase -i: Handle the author script all in one place in do_next
Date: Thu, 14 Jan 2010 06:54:52 +0100
Message-ID: <946239c2ed9c6bf1b536d96c6bf06788878c63b9.1263447038.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIgd-0002Vo-S0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab0ANFze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632Ab0ANFzb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:31 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58631 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab0ANFza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:30 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bS001912;
	Thu, 14 Jan 2010 06:55:26 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136941>

This change has no practical effect but makes the code easier to
follow.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 04a1c3a..15b8605 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -449,6 +449,8 @@ do_next () {
 		make_squash_message $squash_style $sha1 > "$MSG"
 		failed=f
 		author_script=$(get_author_ident_from_commit HEAD)
+		echo "$author_script" > "$AUTHOR_SCRIPT"
+		eval "$author_script"
 		output git reset --soft HEAD^
 		pick_one -n $sha1 || failed=t
 		case "$(peek_next_command)" in
@@ -467,11 +469,9 @@ do_next () {
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-		echo "$author_script" > "$AUTHOR_SCRIPT"
 		if test $failed = f
 		then
 			# This is like --amend, but with a different message
-			eval "$author_script"
 			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-- 
1.6.6
