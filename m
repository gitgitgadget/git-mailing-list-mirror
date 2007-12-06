From: Pini Reznik <pinir@expand.com>
Subject: [PATCH] Open external merge tool with original file extensions for all three files
Date: Thu,  6 Dec 2007 09:06:59 +0200
Message-ID: <1196924819-4007-1-git-send-email-pinir@expand.com>
Cc: Pini Reznik <pinir@expand.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 08:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AnN-0007kY-Gw
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbXLFHEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbXLFHEz
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:04:55 -0500
Received: from smtp-tlv.expand.com ([192.116.193.121]:54699 "EHLO
	smtp-tlv.expand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbXLFHEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:04:54 -0500
Received: from localhost.localdomain ([172.16.30.232]) by smtp-tlv.expand.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Dec 2007 09:04:49 +0200
X-Mailer: git-send-email 1.5.3.5
X-OriginalArrivalTime: 06 Dec 2007 07:04:49.0781 (UTC) FILETIME=[4AD12A50:01C837D6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67262>

Before this fix conflicted files were open in external merge
tool with temporal extensions like REMOTE.$$ and LOCAL.$$.
This way meld was unable to recognize these files and
syntax highlighting feature was unusable.

Signed-off-by: Pini Reznik <pinir@expand.com>
---
 git-mergetool.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5587c5e..2f31fa2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -152,10 +152,11 @@ merge_file () {
 	exit 1
     fi
 
-    BACKUP="$path.BACKUP.$$"
-    LOCAL="$path.LOCAL.$$"
-    REMOTE="$path.REMOTE.$$"
-    BASE="$path.BASE.$$"
+    ext="$$$(expr "$path" : '.*\(\.[^/]*\)$')"
+    BACKUP="$path.BACKUP.$ext"
+    LOCAL="$path.LOCAL.$ext"
+    REMOTE="$path.REMOTE.$ext"
+    BASE="$path.BASE.$ext"
 
     mv -- "$path" "$BACKUP"
     cp -- "$BACKUP" "$path"
-- 
1.5.3.5
