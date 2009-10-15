From: "Guillermo S. Romero" <gsromero@infernal-iceberg.com>
Subject: [PATCH] gitk: Add configuration for UI colour scheme (menus,
 scrollbars, etc)
Date: Thu, 15 Oct 2009 18:51:49 +0200
Message-ID: <20091015165149.GA28219@crossbow.battleship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 19:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyU7L-0002cU-P2
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935203AbZJORTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 13:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935146AbZJORTt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 13:19:49 -0400
Received: from jubjub.tera-byte.com ([216.234.161.59]:38318 "EHLO
	jubjub.tera-byte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932952AbZJORTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 13:19:48 -0400
X-Greylist: delayed 1613 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2009 13:19:47 EDT
Received: from crossbow.battleship (localhost.localdomain [127.0.0.1])
	by jubjub.tera-byte.com (8.13.8/8.13.8) with ESMTP id n9FGpoCv014985;
	Thu, 15 Oct 2009 10:51:51 -0600
Received: from unnamed by crossbow.battleship with local (Exim 4.69)
	(envelope-from <gsromero@infernal-iceberg.com>)
	id 1MyTYL-0007YV-UC; Thu, 15 Oct 2009 18:51:49 +0200
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130403>

Add option to control global colour scheme in Edit > Preferences dialog
so the whole interface can have other color beyond the default one
and match changes to other areas controlled by bgcolor and fgcolor.

Signed-off-by: Guillermo S. Romero <gsromero@infernal-iceberg.com>
---

Hi:

Small cosmetic patch. I found all colours were easily configurable
from prefs, except the main colour, which can look a bit out of place
with the rest. No big changes, Tk computes all needed colours for
button shading, fonts, etc. I hope the patch is correct, first time
with git.

Thanks for the app, pretty useful.

GSR
 
PS: Not subscribed to git@vger, so remember to CC: me.
 

 gitk-git/gitk |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..d40a735 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2519,7 +2519,7 @@ proc savestuff {w} {
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
-    global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
+    global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
     global autoselect extdifftool perfile_attrs markbgcolor
     global hideremotes
 
@@ -2546,6 +2546,7 @@ proc savestuff {w} {
 	puts $f [list set showlocalchanges $showlocalchanges]
 	puts $f [list set datetimeformat $datetimeformat]
 	puts $f [list set limitdiffs $limitdiffs]
+	puts $f [list set uicolor $uicolor]
 	puts $f [list set bgcolor $bgcolor]
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
@@ -10425,7 +10426,7 @@ proc chg_fontparam {v sub op} {
 proc doprefs {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags showlocalchanges
-    global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
+    global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect extdifftool perfile_attrs
     global hideremotes
 
@@ -10489,6 +10490,10 @@ proc doprefs {} {
 
     label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
+    label $top.ui -padx 40 -relief sunk -background $uicolor
+    button $top.uibut -text [mc "Interface"] -font optionfont \
+       -command [list choosecolor uicolor {} $top.ui [mc "interface"] setui]
+    grid x $top.uibut $top.ui -sticky w
     label $top.bg -padx 40 -relief sunk -background $bgcolor
     button $top.bgbut -text [mc "Background"] -font optionfont \
 	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg]
@@ -10572,6 +10577,10 @@ proc setselbg {c} {
     allcanvs itemconf secsel -fill $c
 }
 
+proc setui {c} {
+    tk_setPalette $c
+}
+
 proc setbg {c} {
     global bglist
 
@@ -11079,6 +11088,7 @@ if {[tk windowingsystem] eq "aqua"} {
 }
 
 set colors {green red blue magenta darkgrey brown orange}
+set uicolor grey85
 set bgcolor white
 set fgcolor black
 set diffcolors {red "#00a000" blue}
@@ -11130,6 +11140,8 @@ eval font create textfontbold [fontflags textfont 1]
 parsefont uifont $uifont
 eval font create uifont [fontflags uifont]
 
+tk_setPalette $uicolor
+
 setoptions
 
 # check that we can find a .git directory somewhere...
-- 
1.6.4.3
