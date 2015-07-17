From: Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 10:39:03 +0200
Message-ID: <205a18f7f8a7892a1fa63a91a84bfd9b@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 10:46:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG1HM-00057u-7u
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 10:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbbGQIpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 04:45:54 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:33060 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746AbbGQIpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 04:45:52 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Jul 2015 04:45:52 EDT
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id E1C2CC343E;
	Fri, 17 Jul 2015 10:39:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RELAYS
	autolearn=ham version=3.3.2
Received: by mx1.2b3w.ch (Postfix, from userid 33)
	id C401FC3442; Fri, 17 Jul 2015 10:39:03 +0200 (CEST)
X-PHP-Originating-Script: 0:main.inc
X-Sender: dev+git@drbeat.li
User-Agent: Roundcube Webmail/0.7.2
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274060>

When referring to earlier commits in commit messages or other text, one
of the established formats is

     <abbrev-sha> ("<summary>", <author-date>)

Add a "Copy commit summary" command to the context menu that puts this
text for the currently selected commit on the clipboard. This makes it
easy for our users to create well-formatted commit references.

The <abbrev-sha> is produced with the %h format specifier to make it
unique. Its minimum length can be controlled with the config setting
core.abbrev.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
Reviewed-by: Johannes Sixt <j6t@kdbg.org>
Cc: Paul Mackerras <paulus@samba.org>

---
Changes since v2:
- call git log to produce a unique <abbrev-sha>
- use the short date format

Changes since v1:
- drop the "commit " literal in front of the <abbrev-sha>
---
  gitk-git/gitk | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..4915f53 100755
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
@@ -9341,6 +9342,17 @@ proc mktaggo {} {
      mktagcan
  }

+proc copysummary {} {
+    global rowmenuid
+
+    set format "%h (\"%s\", %ad)"
+    set summary [exec git show -s --pretty=format:$format --date=short 
\
+                 $rowmenuid]
+
+    clipboard clear
+    clipboard append $summary
+}
+
  proc writecommit {} {
      global rowmenuid wrcomtop commitinfo wrcomcmd NS

-- 
2.4.0
