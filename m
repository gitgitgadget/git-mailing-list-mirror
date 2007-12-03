From: Pini Reznik <pinir@expand.com>
Subject: [PATCH] Open external merge tool with original file extensions in all three files
Date: Mon,  3 Dec 2007 17:31:14 +0200
Message-ID: <1196695874-22567-1-git-send-email-pinir@expand.com>
Cc: Pini Reznik <pinir@expand.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 17:13:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzDv2-0005nJ-9C
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 17:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbXLCQMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 11:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbXLCQMz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 11:12:55 -0500
Received: from smtp-tlv.expand.com ([192.116.193.121]:31397 "EHLO
	smtp-tlv.expand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbXLCQMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 11:12:54 -0500
X-Greylist: delayed 2607 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 11:12:54 EST
Received: from localhost.localdomain ([172.16.30.232]) by smtp-tlv.expand.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 3 Dec 2007 17:30:59 +0200
X-Mailer: git-send-email 1.5.3.5
X-OriginalArrivalTime: 03 Dec 2007 15:30:59.0093 (UTC) FILETIME=[81192C50:01C835C1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66922>

This required to be able to use syntax highlighting in meld during conflicts resolution.
Before this change, two merged versions of file with a conflict were open with temporal extensions .LOCAL.$$ and REMOTE.$$
This way they were not recognized as a code files.

Signed-off-by: Pini Reznik <pinir@expand.com>
---
 git-mergetool.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 5587c5e..4c15d22 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -152,10 +152,11 @@ merge_file () {
 	exit 1
     fi
 
-    BACKUP="$path.BACKUP.$$"
-    LOCAL="$path.LOCAL.$$"
-    REMOTE="$path.REMOTE.$$"
-    BASE="$path.BASE.$$"
+    extension=`echo $path | awk -F \. '{print $NF}'`
+    BACKUP="$path.BACKUP.$$.${extension}"
+    LOCAL="$path.LOCAL.$$.${extension}"
+    REMOTE="$path.REMOTE.$$.${extension}"
+    BASE="$path.BASE.$$.${extension}"
 
     mv -- "$path" "$BACKUP"
     cp -- "$BACKUP" "$path"
-- 
1.5.3.5
