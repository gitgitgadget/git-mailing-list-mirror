From: dev+git@drbeat.li
Subject: [PATCH] gitk: Add a "Copy commit summary" command
Date: Tue, 14 Jul 2015 18:42:30 +0200
Message-ID: <1436892150-24267-1-git-send-email-dev+git@drbeat.li>
Cc: Beat Bolli <dev+git@drbeat.li>, Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 18:50:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF3Pq-0007iK-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 18:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbbGNQun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2015 12:50:43 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:56484 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbbGNQum (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 12:50:42 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2015 12:50:41 EDT
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id ADC0FC3442;
	Tue, 14 Jul 2015 18:42:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 8CDD7C343D;
	Tue, 14 Jul 2015 18:42:45 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id 4355E1FF5C; Tue, 14 Jul 2015 18:42:45 +0200 (CEST)
X-Mailer: git-send-email 2.1.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273967>

From: Beat Bolli <dev+git@drbeat.li>

When referencing earlier commits in new commit messages or other text,
one of the established formats is

    commit <abbrev-sha> ("<summary>", <author-date>)

Add a "Copy commit summary" command to the context menu that puts this
text for the currently selected commit on the clipboard. This makes it
easy for our users to create well-formatted commit references.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Cc: Paul Mackerras <paulus@samba.org>
---
 gitk-git/gitk | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..0612331 100755
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
+    set summary "[mc "commit"] $id (\"$commit\", $date)"
+
+    clipboard clear
+    clipboard append $summary
+}
+
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
 
-- 
2.1.4
