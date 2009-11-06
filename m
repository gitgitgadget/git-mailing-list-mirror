From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [gitk] [PATCH] 1/2 Merging master into dev
Date: 06 Nov 2009 23:27:54 +0000
Message-ID: <87y6mjutc5.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6YDs-0004OI-Bn
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759930AbZKFX1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759927AbZKFX1w
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:27:52 -0500
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:54806 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759691AbZKFX1v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 18:27:51 -0500
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1N6YDj-0006iu-Mf; Fri, 06 Nov 2009 23:27:55 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1N6YDi-0006jF-V8; Fri, 06 Nov 2009 23:27:55 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id A4ED413D310; Fri,  6 Nov 2009 23:27:54 +0000 (GMT)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132346>


commit 0dd59acf864aedc131e8b9daccc93afd8252a292
Merge: aa43561 8d84995
Author: Pat Thoyts <patthoyts@users.sourceforge.net>
Date:   Fri Nov 6 15:35:48 2009 +0000

    Merged master into dev
    
    Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

diff --cc gitk
index c0f38ad,db5ec54..6360077
--- a/gitk
+++ b/gitk
@@@ -1810,13 -1787,10 +1810,13 @@@ proc make_transient {window origin} 
      }
  }
  
- proc show_error {w top msg} {
+ proc show_error {w top msg {mc mc}} {
 +    global NS
 +    if {![info exists NS]} {set NS ""}
 +    if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
      message $w.m -text $msg -justify center -aspect 400
      pack $w.m -side top -fill x -padx 20 -pady 20
-     ${NS}::button $w.ok -default active -text [mc OK] -command "destroy $top"
 -    button $w.ok -text [$mc OK] -command "destroy $top"
++    ${NS}::button $w.ok -default active -text [$mc OK] -command "destroy $top"
      pack $w.ok -side bottom -fill x
      bind $top <Visibility> "grab $top; focus $top"
      bind $top <Key-Return> "destroy $top"
@@@ -2616,9 -2519,9 +2616,9 @@@ proc savestuff {w} 
      global maxwidth showneartags showlocalchanges
      global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
      global cmitmode wrapcomment datetimeformat limitdiffs
-     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
+     global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
 -    global autoselect extdifftool perfile_attrs markbgcolor
 -    global hideremotes
 +    global autoselect extdifftool perfile_attrs markbgcolor use_ttk
 +    global hideremotes want_ttk
  
      if {$stuffsaved} return
      if {![winfo viewable .]} return
@@@ -2642,7 -2546,7 +2643,8 @@@
  	puts $f [list set showlocalchanges $showlocalchanges]
  	puts $f [list set datetimeformat $datetimeformat]
  	puts $f [list set limitdiffs $limitdiffs]
 +	puts $f [list set want_ttk $want_ttk]
+ 	puts $f [list set uicolor $uicolor]
  	puts $f [list set bgcolor $bgcolor]
  	puts $f [list set fgcolor $fgcolor]
  	puts $f [list set colors $colors]
@@@ -10630,11 -10443,11 +10651,11 @@@ proc chg_fontparam {v sub op} 
  }
  
  proc doprefs {} {
 -    global maxwidth maxgraphpct
 +    global maxwidth maxgraphpct use_ttk NS
      global oldprefs prefstop showneartags showlocalchanges
-     global bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
+     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
      global tabstop limitdiffs autoselect extdifftool perfile_attrs
 -    global hideremotes
 +    global hideremotes want_ttk have_ttk
  
      set top .gitkprefs
      set prefstop $top
@@@ -10643,69 -10456,65 +10664,73 @@@
  	return
      }
      foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
 -		   limitdiffs tabstop perfile_attrs hideremotes} {
 +		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
  	set oldprefs($v) [set $v]
      }
 -    toplevel $top
 +    ttk_toplevel $top
      wm title $top [mc "Gitk preferences"]
      make_transient $top .
 -    label $top.ldisp -text [mc "Commit list display options"]
 +    ${NS}::label $top.ldisp -text [mc "Commit list display options"]
      grid $top.ldisp - -sticky w -pady 10
 -    label $top.spacer -text " "
 -    label $top.maxwidthl -text [mc "Maximum graph width (lines)"] \
 -	-font optionfont
 +    ${NS}::label $top.spacer -text " "
 +    ${NS}::label $top.maxwidthl -text [mc "Maximum graph width (lines)"]
      spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
      grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
 -    label $top.maxpctl -text [mc "Maximum graph width (% of pane)"] \
 -	-font optionfont
 +    ${NS}::label $top.maxpctl -text [mc "Maximum graph width (% of pane)"]
      spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
      grid x $top.maxpctl $top.maxpct -sticky w
 -    checkbutton $top.showlocal -text [mc "Show local changes"] \
 -	-font optionfont -variable showlocalchanges
 +    ${NS}::checkbutton $top.showlocal -text [mc "Show local changes"] \
 +	-variable showlocalchanges
      grid x $top.showlocal -sticky w
 -    checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
 -	-font optionfont -variable autoselect
 +    ${NS}::checkbutton $top.autoselect -text [mc "Auto-select SHA1"] \
 +	-variable autoselect
      grid x $top.autoselect -sticky w
 +    ${NS}::checkbutton $top.hideremotes -text [mc "Hide remote refs"] \
 +	-variable hideremotes
 +    grid x $top.hideremotes -sticky w
  
 -    label $top.ddisp -text [mc "Diff display options"]
 +    ${NS}::label $top.ddisp -text [mc "Diff display options"]
      grid $top.ddisp - -sticky w -pady 10
 -    label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
 +    ${NS}::label $top.tabstopl -text [mc "Tab spacing"]
      spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
      grid x $top.tabstopl $top.tabstop -sticky w
 -    checkbutton $top.ntag -text [mc "Display nearby tags"] \
 -	-font optionfont -variable showneartags
 +    ${NS}::checkbutton $top.ntag -text [mc "Display nearby tags"] \
 +	-variable showneartags
      grid x $top.ntag -sticky w
 -    checkbutton $top.hideremotes -text [mc "Hide remote refs"] \
 -	-font optionfont -variable hideremotes
 -    grid x $top.hideremotes -sticky w
 -    checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
 -	-font optionfont -variable limitdiffs
 +    ${NS}::checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
 +	-variable limitdiffs
      grid x $top.ldiff -sticky w
 -    checkbutton $top.lattr -text [mc "Support per-file encodings"] \
 -	-font optionfont -variable perfile_attrs
 +    ${NS}::checkbutton $top.lattr -text [mc "Support per-file encodings"] \
 +	-variable perfile_attrs
      grid x $top.lattr -sticky w
  
 -    entry $top.extdifft -textvariable extdifftool
 -    frame $top.extdifff
 -    label $top.extdifff.l -text [mc "External diff tool" ] -font optionfont \
 -	-padx 10
 -    button $top.extdifff.b -text [mc "Choose..."] -font optionfont \
 -	-command choose_extdiff
 +    ${NS}::entry $top.extdifft -textvariable extdifftool
 +    ${NS}::frame $top.extdifff
 +    ${NS}::label $top.extdifff.l -text [mc "External diff tool" ]
 +    ${NS}::button $top.extdifff.b -text [mc "Choose..."] -command choose_extdiff
      pack $top.extdifff.l $top.extdifff.b -side left
 -    grid x $top.extdifff $top.extdifft -sticky w
 +    pack configure $top.extdifff.l -padx 10
 +    grid x $top.extdifff $top.extdifft -sticky ew
 +
 +    ${NS}::label $top.lgen -text [mc "General options"]
 +    grid $top.lgen - -sticky w -pady 10
 +    ${NS}::checkbutton $top.want_ttk -variable want_ttk \
 +	-text [mc "Use themed widgets"]
 +    if {$have_ttk} {
 +	${NS}::label $top.ttk_note -text [mc "(change requires restart)"]
 +    } else {
 +	${NS}::label $top.ttk_note -text [mc "(currently unavailable)"]
 +    }
 +    grid x $top.want_ttk $top.ttk_note -sticky w
  
 -    label $top.cdisp -text [mc "Colors: press to choose"]
 +    ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
      grid $top.cdisp - -sticky w -pady 10
+     label $top.ui -padx 40 -relief sunk -background $uicolor
+     button $top.uibut -text [mc "Interface"] -font optionfont \
+        -command [list choosecolor uicolor {} $top.ui [mc "interface"] setui]
+     grid x $top.uibut $top.ui -sticky w
      label $top.bg -padx 40 -relief sunk -background $bgcolor
 -    button $top.bgbut -text [mc "Background"] -font optionfont \
 +    ${NS}::button $top.bgbut -text [mc "Background"] \
  	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg]
      grid x $top.bgbut $top.bg -sticky w
      label $top.fg -padx 40 -relief sunk -background $fgcolor
