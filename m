From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: add keybinding to switch to parent commit
Date: Tue,  8 Jul 2014 23:45:35 +0300
Message-ID: <1404852335-27731-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4cHG-0000VI-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbaGHUqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:46:10 -0400
Received: from p3plsmtpa07-07.prod.phx3.secureserver.net ([173.201.192.236]:46832
	"EHLO p3plsmtpa07-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753893AbaGHUqI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 16:46:08 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa07-07.prod.phx3.secureserver.net with 
	id Pwm11o00U3gsSd601wm6FB; Tue, 08 Jul 2014 13:46:08 -0700
X-Mailer: git-send-email 2.0.0.526.g5318336
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253048>

Signed-off-by: Max Kirillov <max@max630.net>
---
Hi.

I was missing this one. Actually the most needed is go to first
parent, though the second also may be useful.
 gitk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/gitk b/gitk
index 41e5071..de35fe4 100755
--- a/gitk
+++ b/gitk
@@ -2594,6 +2594,9 @@ proc makewindow {} {
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
+    for {set i 1} {$i<10} {incr i} {
+	bind . <$M1B-Key-$i> [list go_to_parent $i]
+    }
 
     set maincursor [. cget -cursor]
     set textcursor [$ctext cget -cursor]
@@ -3016,6 +3019,7 @@ proc keys {} {
 [mc "<Down>, n, j	Move down one commit"]
 [mc "<Left>, z, h	Go back in history list"]
 [mc "<Right>, x, l	Go forward in history list"]
+[mc "<%s-n>	Go to n-th parent of current commit in history list" $M1T]
 [mc "<PageUp>	Move up one page in commit list"]
 [mc "<PageDown>	Move down one page in commit list"]
 [mc "<%s-Home>	Scroll to top of commit list" $M1T]
@@ -7494,6 +7498,14 @@ proc goforw {} {
     }
 }
 
+proc go_to_parent {i} {
+    global parents curview targetid
+    set ps $parents($curview,$targetid)
+    if {[llength $ps] >= $i} {
+	selbyid [lindex $ps [expr $i - 1]]
+    }
+}
+
 proc gettree {id} {
     global treefilelist treeidlist diffids diffmergeid treepending
     global nullid nullid2
-- 
2.0.0.526.g5318336
