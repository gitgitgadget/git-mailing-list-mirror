From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] tcl/tk8.5: fix changing colors through Edit->Preferences
Date: Wed, 26 Mar 2008 18:45:26 +0000
Message-ID: <20080326184526.2240.qmail@b31b9595cabb35.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeadX-0007Zl-8u
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773AbYCZSpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760219AbYCZSpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:45:09 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:59570 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757773AbYCZSpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:45:08 -0400
Received: (qmail 2241 invoked by uid 1000); 26 Mar 2008 18:45:26 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78298>

With tcl/tk8.5 the lset command seems to behave differently.  When
changing the background color through Edit->Preferences, the changes
are applied, but new dialogs, such as View->New view... barf with

 Error: unknown color name "{#ffffff}"

Additionally when closing gitk, and starting it up again, a bad value
has been saved to ~/.gitk, preventing gitk from running properly; it
fails with

 Error in startup script: unknown color name "{#ffffff}"
 ...

This commit changes the color dialogs to not handle variables containing
just a single color value as tcl lists, which fixes the issue.  Tested
with tcl/tk8.4 and 8.5.

Dmitry Potapov reported this problem through
 http://bugs.debian.org/472615

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 gitk |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 84ab02e..9a4d9c4 100755
--- a/gitk
+++ b/gitk
@@ -8045,11 +8045,11 @@ proc doprefs {} {
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
     button $top.bgbut -text [mc "Background"] -font optionfont \
-	-command [list choosecolor bgcolor 0 $top.bg background setbg]
+	-command [list choosecolor bgcolor {} $top.bg background setbg]
     grid x $top.bgbut $top.bg -sticky w
     label $top.fg -padx 40 -relief sunk -background $fgcolor
     button $top.fgbut -text [mc "Foreground"] -font optionfont \
-	-command [list choosecolor fgcolor 0 $top.fg foreground setfg]
+	-command [list choosecolor fgcolor {} $top.fg foreground setfg]
     grid x $top.fgbut $top.fg -sticky w
     label $top.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
     button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfont \
@@ -8069,7 +8069,7 @@ proc doprefs {} {
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
     button $top.selbgbut -text [mc "Select bg"] -font optionfont \
-	-command [list choosecolor selectbgcolor 0 $top.selbgsep background setselbg]
+	-command [list choosecolor selectbgcolor {} $top.selbgsep background setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
 
     label $top.cfont -text [mc "Fonts: press to choose"]
-- 
1.5.4.4
