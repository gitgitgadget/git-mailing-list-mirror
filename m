From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Make selection highlight color configurable
Date: Sun, 20 May 2007 12:12:48 -0400
Message-ID: <11796775683753-git-send-email-mdl123@verizon.net>
References: <11796759513709-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 18:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpo1x-0006CP-3N
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbXETQNI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757684AbXETQNI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:13:08 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:59010 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796AbXETQNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:13:07 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.225])
 by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JIC00LZYL1ES35B@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 20 May 2007 11:12:51 -0500 (CDT)
In-reply-to: <11796759513709-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.2.rc3.95.gb3c7e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47851>

Cygwin's tk by default uses a very dark selection background color that
makes the currently selected text almost unreadable. On linux, the default
selection background is a light gray which is very usable. This makes the
default a light gray everywhere but allows the user to configure the
color as well.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index a57e84c..530f8e1 100755
--- a/gitk
+++ b/gitk
@@ -402,7 +402,7 @@ proc makewindow {} {
     global rowctxmenu mergemax wrapcomment
     global highlight_files gdttype
     global searchstring sstring
-    global bgcolor fgcolor bglist fglist diffcolors
+    global bgcolor fgcolor bglist fglist diffcolors selectbgcolor
     global headctxmenu
 
     menu .bar
@@ -457,15 +457,18 @@ proc makewindow {} {
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
     canvas $canv \
+	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 \
 	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
     .tf.histframe.pwclist add $canv
     set canv2 .tf.histframe.pwclist.canv2
     canvas $canv2 \
+	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv2
     set canv3 .tf.histframe.pwclist.canv3
     canvas $canv3 \
+	-selectbackground $selectbgcolor \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
     eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
@@ -666,6 +669,7 @@ proc makewindow {} {
     set cflist .bright.cfiles
     set indent [font measure $mainfont "nn"]
     text $cflist \
+	-selectbackground $selectbgcolor \
 	-background $bgcolor -foreground $fgcolor \
 	-font $mainfont \
 	-tabs [list $indent [expr {2 * $indent}]] \
@@ -825,7 +829,7 @@ proc savestuff {w} {
     global maxwidth showneartags
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment
-    global colors bgcolor fgcolor diffcolors
+    global colors bgcolor fgcolor diffcolors selectbgcolor
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -844,6 +848,7 @@ proc savestuff {w} {
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
+	puts $f [list set selectbgcolor $selectbgcolor]
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
@@ -5845,7 +5850,7 @@ proc doquit {} {
 proc doprefs {} {
     global maxwidth maxgraphpct diffopts
     global oldprefs prefstop showneartags
-    global bgcolor fgcolor ctext diffcolors
+    global bgcolor fgcolor ctext diffcolors selectbgcolor
     global uifont
 
     set top .gitkprefs
@@ -5912,6 +5917,10 @@ proc doprefs {} {
 		      "diff hunk header" \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
+    label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
+    button $top.selbgbut -text "Select bg" -font optionfont \
+	-command [list choosecolor selectbgcolor 0 $top.bg background setselbg]
+    grid x $top.selbgbut $top.selbgsep -sticky w
 
     frame $top.buts
     button $top.buts.ok -text "OK" -command prefsok -default active
@@ -5936,6 +5945,16 @@ proc choosecolor {v vi w x cmd} {
     eval $cmd $c
 }
 
+proc setselbg {c} {
+    global bglist cflist
+    foreach w $bglist {
+	$w configure -selectbackground $c
+    }
+    $cflist tag configure highlight \
+	-background [$cflist cget -selectbackground]
+    allcanvs itemconf secsel -fill $c
+}
+
 proc setbg {c} {
     global bglist
 
@@ -6292,6 +6311,7 @@ set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
 set fgcolor black
 set diffcolors {red "#00a000" blue}
+set selectbgcolor gray85
 
 catch {source ~/.gitk}
 
-- 
1.5.2.rc3.95.gb3c7e
