From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/4] notes: only clean up message file when editing
Date: Sat, 14 Feb 2009 20:15:03 +0100
Message-ID: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 20:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQ0Y-0008VK-P4
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZBNTPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZBNTPR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:15:17 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20714 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbZBNTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:15:16 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
X-Mailer: git-send-email 1.6.2.rc0.288.g6852b
X-OriginalArrivalTime: 14 Feb 2009 19:15:14.0272 (UTC) FILETIME=[905ACE00:01C98ED8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109897>

We clean up the notes file when exiting.  However, actions other than
'edit' have nothing to do with the file, so they should not remove it
when done.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-notes.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index 9cbad02..246df65 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -14,13 +14,13 @@ test -z "$GIT_NOTES_REF" && GIT_NOTES_REF="refs/notes/commits"
 COMMIT=$(git rev-parse --verify --default HEAD "$@") ||
 die "Invalid commit: $@"
 
-MESSAGE="$GIT_DIR"/new-notes-$COMMIT
-trap '
-	test -f "$MESSAGE" && rm "$MESSAGE"
-' 0
-
 case "$ACTION" in
 edit)
+	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
+	trap '
+		test -f "$MESSAGE" && rm "$MESSAGE"
+	' 0
+
 	GIT_NOTES_REF= git log -1 $COMMIT | sed "s/^/#/" > "$MESSAGE"
 
 	GIT_INDEX_FILE="$MESSAGE".idx
-- 
1.6.2.rc0.288.g6852b
