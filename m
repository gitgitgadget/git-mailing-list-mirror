From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Mak gitk bind keyboard actions to the command key on Mac OS
Date: Thu, 19 Jul 2007 00:37:58 -0400
Message-ID: <20070719043758.GA14752@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 06:38:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBNmT-0002xy-92
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 06:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXGSEiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 00:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbXGSEiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 00:38:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37829 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbXGSEiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 00:38:08 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBNm7-0002T5-GJ; Thu, 19 Jul 2007 00:38:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B4F620FBAE; Thu, 19 Jul 2007 00:37:59 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52933>

git-gui already uses the command key for accelerators, but gitk has
never done so.  I'm actually finding it very hard to move back and
forth between the two applications as git-gui is following the Mac
OS X conventions and gitk is not.

This trick is the same one that git-gui uses to determine which
key to bind actions to.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 gitk |   75 +++++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/gitk b/gitk
index 39e452a..6f58803 100755
--- a/gitk
+++ b/gitk
@@ -796,6 +796,12 @@ proc makewindow {} {
         wm geometry . "$geometry(main)"
     }
 
+    if {[tk windowingsystem] eq {aqua}} {
+        set M1B M1
+    } else {
+        set M1B Control
+    }
+
     bind .pwbottom <Configure> {resizecdetpanes %W %w}
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
@@ -814,12 +820,12 @@ proc makewindow {} {
     bindkey <Key-Left> "goback"
     bind . <Key-Prior> "selnextpage -1"
     bind . <Key-Next> "selnextpage 1"
-    bind . <Control-Home> "allcanvs yview moveto 0.0"
-    bind . <Control-End> "allcanvs yview moveto 1.0"
-    bind . <Control-Key-Up> "allcanvs yview scroll -1 units"
-    bind . <Control-Key-Down> "allcanvs yview scroll 1 units"
-    bind . <Control-Key-Prior> "allcanvs yview scroll -1 pages"
-    bind . <Control-Key-Next> "allcanvs yview scroll 1 pages"
+    bind . <$M1B-Home> "allcanvs yview moveto 0.0"
+    bind . <$M1B-End> "allcanvs yview moveto 1.0"
+    bind . <$M1B-Key-Up> "allcanvs yview scroll -1 units"
+    bind . <$M1B-Key-Down> "allcanvs yview scroll 1 units"
+    bind . <$M1B-Key-Prior> "allcanvs yview scroll -1 pages"
+    bind . <$M1B-Key-Next> "allcanvs yview scroll 1 pages"
     bindkey <Key-Delete> "$ctext yview scroll -1 pages"
     bindkey <Key-BackSpace> "$ctext yview scroll -1 pages"
     bindkey <Key-space> "$ctext yview scroll 1 pages"
@@ -839,15 +845,15 @@ proc makewindow {} {
     bindkey ? findprev
     bindkey f nextfile
     bindkey <F5> updatecommits
-    bind . <Control-q> doquit
-    bind . <Control-f> dofind
-    bind . <Control-g> {findnext 0}
-    bind . <Control-r> dosearchback
-    bind . <Control-s> dosearch
-    bind . <Control-equal> {incrfont 1}
-    bind . <Control-KP_Add> {incrfont 1}
-    bind . <Control-minus> {incrfont -1}
-    bind . <Control-KP_Subtract> {incrfont -1}
+    bind . <$M1B-q> doquit
+    bind . <$M1B-f> dofind
+    bind . <$M1B-g> {findnext 0}
+    bind . <$M1B-r> dosearchback
+    bind . <$M1B-s> dosearch
+    bind . <$M1B-equal> {incrfont 1}
+    bind . <$M1B-KP_Add> {incrfont 1}
+    bind . <$M1B-minus> {incrfont -1}
+    bind . <$M1B-KP_Subtract> {incrfont -1}
     wm protocol . WM_DELETE_WINDOW doquit
     bind . <Button-1> "click %W"
     bind $fstring <Key-Return> dofind
@@ -1088,12 +1094,17 @@ proc keys {} {
 	raise $w
 	return
     }
+    if {[tk windowingsystem] eq {aqua}} {
+	set M1T Cmd
+    } else {
+	set M1T Ctrl
+    }
     toplevel $w
     wm title $w "Gitk key bindings"
-    message $w.m -text {
+    message $w.m -text "
 Gitk key bindings:
 
-<Ctrl-Q>		Quit
+<$M1T-Q>		Quit
 <Home>		Move to first commit
 <End>		Move to last commit
 <Up>, p, i	Move up one commit
@@ -1102,12 +1113,12 @@ Gitk key bindings:
 <Right>, x, l	Go forward in history list
 <PageUp>	Move up one page in commit list
 <PageDown>	Move down one page in commit list
-<Ctrl-Home>	Scroll to top of commit list
-<Ctrl-End>	Scroll to bottom of commit list
-<Ctrl-Up>	Scroll commit list up one line
-<Ctrl-Down>	Scroll commit list down one line
-<Ctrl-PageUp>	Scroll commit list up one page
-<Ctrl-PageDown>	Scroll commit list down one page
+<$M1T-Home>	Scroll to top of commit list
+<$M1T-End>	Scroll to bottom of commit list
+<$M1T-Up>	Scroll commit list up one line
+<$M1T-Down>	Scroll commit list down one line
+<$M1T-PageUp>	Scroll commit list up one page
+<$M1T-PageDown>	Scroll commit list down one page
 <Shift-Up>	Move to previous highlighted line
 <Shift-Down>	Move to next highlighted line
 <Delete>, b	Scroll diff view up one page
@@ -1115,20 +1126,20 @@ Gitk key bindings:
 <Space>		Scroll diff view down one page
 u		Scroll diff view up 18 lines
 d		Scroll diff view down 18 lines
-<Ctrl-F>		Find
-<Ctrl-G>		Move to next find hit
+<$M1T-F>		Find
+<$M1T-G>		Move to next find hit
 <Return>	Move to next find hit
 /		Move to next find hit, or redo find
 ?		Move to previous find hit
 f		Scroll diff view to next file
-<Ctrl-S>		Search for next hit in diff view
-<Ctrl-R>		Search for previous hit in diff view
-<Ctrl-KP+>	Increase font size
-<Ctrl-plus>	Increase font size
-<Ctrl-KP->	Decrease font size
-<Ctrl-minus>	Decrease font size
+<$M1T-S>		Search for next hit in diff view
+<$M1T-R>		Search for previous hit in diff view
+<$M1T-KP+>	Increase font size
+<$M1T-plus>	Increase font size
+<$M1T-KP->	Decrease font size
+<$M1T-minus>	Decrease font size
 <F5>		Update
-} \
+" \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     $w.m configure -font $uifont
-- 
1.5.3.rc2.822.g75e72
