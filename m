From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 1/2] Teach gitk to use the user-defined UI font everywhere.
Date: Tue, 27 Mar 2007 14:36:12 +0400
Message-ID: <20070327103611.GX14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW92P-0004pV-7W
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:36:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbXC0KgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 06:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbXC0KgU
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:36:20 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59441 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753782AbXC0KgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:36:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Content-Transfer-Encoding:Sender:X-Spam-Status:Subject;
	b=lJd3aDmZ4HvAS2wZ8rNKbz8od50VaD8zJ/BV+Xex8aiGShXNuQFdHi8gyOnfNtbYCxJTaMXsjAjEzihRvyRL3KLmdooJuSOChbvXoJgevmbf1DF6t8arm0k/f06gX+lHN9WE8WyXJc/a5D4xzbDVxLf8gJ2X0s2UYvoK/XmcfL8=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW92G-000DbQ-H7; Tue, 27 Mar 2007 14:36:17 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-0.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50,
	LONGWORDS
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43255>

Some parts of gitk were not respecting the default GUI font. Most
of them were catched and fixed.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 gitk |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 1cd2a8f..f54ff27 100755
--- a/gitk
+++ b/gitk
@@ -648,8 +648,10 @@ proc makewindow {} {
     frame .bright.mode
     radiobutton .bright.mode.patch -text "Patch" \
 	-command reselectline -variable cmitmode -value "patch"
+    .bright.mode.patch configure -font $uifont
     radiobutton .bright.mode.tree -text "Tree" \
 	-command reselectline -variable cmitmode -value "tree"
+    .bright.mode.tree configure -font $uifont
     grid .bright.mode.patch .bright.mode.tree -sticky ew
     pack .bright.mode -side top -fill x
     set cflist .bright.cfiles
@@ -922,6 +924,7 @@ proc bindall {event action} {
 }
=20
 proc about {} {
+    global uifont
     set w .about
     if {[winfo exists $w]} {
 	raise $w
@@ -937,11 +940,14 @@ Copyright =A9 2005-2006 Paul Mackerras
 Use and redistribute under the terms of the GNU General Public License=
} \
 	    -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
+    $w.m configure -font $uifont
     button $w.ok -text Close -command "destroy $w"
     pack $w.ok -side bottom
+    $w.ok configure -font $uifont
 }
=20
 proc keys {} {
+    global uifont
     set w .keys
     if {[winfo exists $w]} {
 	raise $w
@@ -990,8 +996,10 @@ f		Scroll diff view to next file
 } \
 	    -justify left -bg white -border 2 -relief sunken
     pack $w.m -side top -fill both
+    $w.m configure -font $uifont
     button $w.ok -text Close -command "destroy $w"
     pack $w.ok -side bottom
+    $w.ok configure -font $uifont
 }
=20
 # Procedures for manipulating the file list window at the
@@ -1457,20 +1465,21 @@ proc vieweditor {top n title} {
     toplevel $top
     wm title $top $title
     label $top.nl -text "Name" -font $uifont
-    entry $top.name -width 20 -textvariable newviewname($n)
+    entry $top.name -width 20 -textvariable newviewname($n) -font $uif=
ont
     grid $top.nl $top.name -sticky w -pady 5
-    checkbutton $top.perm -text "Remember this view" -variable newview=
perm($n)
+    checkbutton $top.perm -text "Remember this view" -variable newview=
perm($n) \
+	-font $uifont
     grid $top.perm - -pady 5 -sticky w
     message $top.al -aspect 1000 -font $uifont \
 	-text "Commits to include (arguments to git rev-list):"
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
-	-background white
+	-background white -font $uifont
     grid $top.args - -sticky ew -padx 5
     message $top.l -aspect 1000 -font $uifont \
 	-text "Enter files and directories to include, one per line:"
     grid $top.l - -sticky w
-    text $top.t -width 40 -height 10 -background white
+    text $top.t -width 40 -height 10 -background white -font $uifont
     if {[info exists viewfiles($n)]} {
 	foreach f $viewfiles($n) {
 	    $top.t insert end $f
@@ -1481,8 +1490,10 @@ proc vieweditor {top n title} {
     }
     grid $top.t - -sticky ew -padx 5
     frame $top.buts
-    button $top.buts.ok -text "OK" -command [list newviewok $top $n]
-    button $top.buts.can -text "Cancel" -command [list destroy $top]
+    button $top.buts.ok -text "OK" -command [list newviewok $top $n] \
+	-font $uifont
+    button $top.buts.can -text "Cancel" -command [list destroy $top] \
+	-font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -5813,6 +5824,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct diffopts
     global oldprefs prefstop showneartags
     global bgcolor fgcolor ctext diffcolors
+    global uifont
=20
     set top .gitkprefs
     set prefstop $top
@@ -5826,6 +5838,7 @@ proc doprefs {} {
     toplevel $top
     wm title $top "Gitk preferences"
     label $top.ldisp -text "Commit list display options"
+    $top.ldisp configure -font $uifont
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
     label $top.maxwidthl -text "Maximum graph width (lines)" \
@@ -5838,6 +5851,7 @@ proc doprefs {} {
     grid x $top.maxpctl $top.maxpct -sticky w
=20
     label $top.ddisp -text "Diff display options"
+    $top.ddisp configure -font $uifont
     grid $top.ddisp - -sticky w -pady 10
     label $top.diffoptl -text "Options for diff program" \
 	-font optionfont
@@ -5850,6 +5864,7 @@ proc doprefs {} {
     grid x $top.ntag -sticky w
=20
     label $top.cdisp -text "Colors: press to choose"
+    $top.cdisp configure -font $uifont
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
     button $top.bgbut -text "Background" -font optionfont \
@@ -5878,7 +5893,9 @@ proc doprefs {} {
=20
     frame $top.buts
     button $top.buts.ok -text "OK" -command prefsok
+    $top.buts.ok configure -font $uifont
     button $top.buts.can -text "Cancel" -command prefscan
+    $top.buts.can configure -font $uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
--=20
1.5.0.3-dirty
