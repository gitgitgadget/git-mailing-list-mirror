From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/18] rebase -i: Introduce a constant AUTHOR_SCRIPT
Date: Thu, 14 Jan 2010 06:54:46 +0100
Message-ID: <61d29b935d5c979df6eab9d8a69fd072577bc6b1.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 06:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIhQ-0002mp-As
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab0ANF4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458Ab0ANFz1
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:55:27 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58605 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab0ANFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:55:23 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from localhost.localdomain (p4FC1EBF4.dip.t-dialin.net [79.193.235.244])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o0E5t4bM001912;
	Thu, 14 Jan 2010 06:55:19 +0100
X-Mailer: git-send-email 1.6.6
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
In-Reply-To: <cover.1263447037.git.mhagger@alum.mit.edu>
References: <cover.1263447037.git.mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136950>

Add a constant AUTHOR_SCRIPT, holding the filename of the
$DOTEST/author_script file, and document how this temporary file is
used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 git-rebase--interactive.sh |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 77e5773..6fcc00e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -75,6 +75,12 @@ SQUASH_MSG="$DOTEST"/message-squash
 REWRITTEN="$DOTEST"/rewritten
 
 DROPPED="$DOTEST"/dropped
+
+# A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+# GIT_AUTHOR_DATE that will be used for the commit that is currently
+# being rebased.
+AUTHOR_SCRIPT="$DOTEST"/author-script
+
 PRESERVE_MERGES=
 STRATEGY=
 ONTO=
@@ -167,8 +173,8 @@ make_patch () {
 	esac > "$DOTEST"/patch
 	test -f "$MSG" ||
 		git cat-file commit "$1" | sed "1,/^$/d" > "$MSG"
-	test -f "$DOTEST"/author-script ||
-		get_author_ident_from_commit "$1" > "$DOTEST"/author-script
+	test -f "$AUTHOR_SCRIPT" ||
+		get_author_ident_from_commit "$1" > "$AUTHOR_SCRIPT"
 }
 
 die_with_patch () {
@@ -377,8 +383,7 @@ peek_next_command () {
 }
 
 do_next () {
-	rm -f "$MSG" "$DOTEST"/author-script \
-		"$DOTEST"/amend || exit
+	rm -f "$MSG" "$AUTHOR_SCRIPT" "$DOTEST"/amend || exit
 	read command sha1 rest < "$TODO"
 	case "$command" in
 	'#'*|''|noop)
@@ -454,7 +459,7 @@ do_next () {
 			rm -f "$GIT_DIR"/MERGE_MSG || exit
 			;;
 		esac
-		echo "$author_script" > "$DOTEST"/author-script
+		echo "$author_script" > "$AUTHOR_SCRIPT"
 		if test $failed = f
 		then
 			# This is like --amend, but with a different message
@@ -631,7 +636,7 @@ do
 		then
 			: Nothing to commit -- skip this
 		else
-			. "$DOTEST"/author-script ||
+			. "$AUTHOR_SCRIPT" ||
 				die "Cannot find the author identity"
 			amend=
 			if test -f "$DOTEST"/amend
-- 
1.6.6
