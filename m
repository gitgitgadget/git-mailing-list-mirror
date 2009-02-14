From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/5] notes: only clean up message file when editing
Date: Sat, 14 Feb 2009 21:23:21 +0100
Message-ID: <4655551d70d8829a7a15219aef384deb4e63371a.1234642638.git.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR4R-0004Kh-K7
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbZBNUXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZBNUXf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:23:35 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27331 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739AbZBNUXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:23:35 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:34 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:33 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <200902142056.42198.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 20:23:33.0334 (UTC) FILETIME=[1B960760:01C98EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109919>

We clean up the notes file when exiting.  However, actions other than
'edit' have nothing to do with the file, so they should not remove it
when done.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

Same as v1.

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
1.6.2.rc0.296.ge2122
