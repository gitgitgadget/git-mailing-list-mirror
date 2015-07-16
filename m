From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Thu, 16 Jul 2015 17:29:25 +0200
Message-ID: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 17:29:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFl6U-00040B-HM
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 17:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbbGPP3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 11:29:37 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:60104 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641AbbGPP3g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 11:29:36 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id BB9FEC3442;
	Thu, 16 Jul 2015 17:29:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id A20EEC33DD;
	Thu, 16 Jul 2015 17:29:32 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 6BF0420322; Thu, 16 Jul 2015 17:29:32 +0200 (CEST)
X-Mailer: git-send-email 2.1.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274031>

When referring to earlier commits in commit messages or other text, one
of the established formats is

    <abbrev-sha> ("<summary>", <author-date>)

Add a "Copy commit summary" command to the context menu that puts this
text for the currently selected commit on the clipboard. This makes it
easy for our users to create well-formatted commit references.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
 gitk-git/gitk | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..72a2756 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2617,6 +2617,7 @@ proc makewindow {} {
 	{mc "Diff selected -> this" command {diffvssel 1}}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
+	{mc "Copy commit summary" command copysummary}
 	{mc "Write commit to file" command writecommit}
 	{mc "Create new branch" command mkbranch}
 	{mc "Cherry-pick this commit" command cherrypick}
@@ -9341,6 +9342,19 @@ proc mktaggo {} {
     mktagcan
 }
 
+proc copysummary {} {
+    global rowmenuid commitinfo
+
+    set id [string range $rowmenuid 0 7]
+    set info $commitinfo($rowmenuid)
+    set commit [lindex $info 0]
+    set date [formatdate [lindex $info 2]]
+    set summary "$id (\"$commit\", $date)"
+
+    clipboard clear
+    clipboard append $summary
+}
+
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
 
-- 
2.1.4
