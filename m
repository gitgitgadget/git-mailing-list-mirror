From: Pini Reznik <pinir@expand.com>
Subject: [PATCH] Open external merge tool with original file extensions for all three files
Date: Wed,  5 Dec 2007 09:19:13 +0200
Message-ID: <1196839153-31084-1-git-send-email-pinir@expand.com>
Cc: Pini Reznik <pinir@expand.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 08:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoVl-0004En-On
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbXLEHRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXLEHRP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:17:15 -0500
Received: from smtp-tlv.expand.com ([192.116.193.121]:19235 "EHLO
	smtp-tlv.expand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLEHRO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:17:14 -0500
Received: from localhost.localdomain ([172.16.30.232]) by smtp-tlv.expand.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 5 Dec 2007 09:18:50 +0200
X-Mailer: git-send-email 1.5.3.5
X-OriginalArrivalTime: 05 Dec 2007 07:18:50.0859 (UTC) FILETIME=[15B9BBB0:01C8370F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67116>

Before this fix conflicted files were open in external merge tool with temporal extensions like REMOTE.$$ and LOCAL.$$.
This way meld was unable to recognize these files and syntax highlighting feature was unusable.


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
