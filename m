From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] gitk: Let the ttk theme be controllable via preferences.
Date: Sun,  4 Jul 2010 11:17:45 -0400
Message-ID: <1278256665-29034-1-git-send-email-nelhage@mit.edu>
Cc: git@vger.kernel.org, Nelson Elhage <nelhage@mit.edu>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 04 17:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVQyN-0004bW-Ex
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 17:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667Ab0GDPTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jul 2010 11:19:05 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:45822 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757538Ab0GDPTE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jul 2010 11:19:04 -0400
X-AuditID: 1209190d-b7c19ae0000009ea-25-4c30a665b78e
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Brightmail Gateway) with SMTP id AE.F6.02538.566A03C4; Sun,  4 Jul 2010 11:19:01 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o64FJ1mU027717;
	Sun, 4 Jul 2010 11:19:01 -0400
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o64FIw1d014666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 4 Jul 2010 11:19:00 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.1
X-Brightmail-Tracker: AAAAAhTzV1kU9CrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150225>

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
 gitk-git/gitk |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..8790cee 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2626,7 +2626,7 @@ proc savestuff {w} {
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
     global autoselect extdifftool perfile_attrs markbgcolor use_ttk
-    global hideremotes want_ttk
+    global hideremotes want_ttk ttk_theme
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2653,6 +2653,7 @@ proc savestuff {w} {
 	puts $f [list set limitdiffs $limitdiffs]
 	puts $f [list set uicolor $uicolor]
 	puts $f [list set want_ttk $want_ttk]
+	puts $f [list set ttk_theme $ttk_theme]
 	puts $f [list set bgcolor $bgcolor]
 	puts $f [list set fgcolor $fgcolor]
 	puts $f [list set colors $colors]
@@ -10696,7 +10697,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
     global tabstop limitdiffs autoselect extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes want_ttk have_ttk ttk_theme
 
     set top .gitkprefs
     set prefstop $top
@@ -10705,7 +10706,8 @@ proc doprefs {} {
 	return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+		   ttk_theme} {
 	set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -10764,6 +10766,17 @@ proc doprefs {} {
     }
     grid x $top.want_ttk $top.ttk_note -sticky w
 
+    if {$have_ttk} {
+	ttk::combobox $top.ttk_theme -textvariable ttk_theme \
+	    -values [ttk::style theme names]
+	$top.ttk_theme state readonly
+	if {!$use_ttk} {
+	    $top.ttk_theme state disabled
+	}
+	${NS}::label $top.lttk_theme -text [mc "Theme"]
+	grid x $top.lttk_theme $top.ttk_theme -sticky w
+    }
+
     ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.ui -padx 40 -relief sunk -background $uicolor
@@ -10892,7 +10905,8 @@ proc prefscan {} {
     global oldprefs prefstop
 
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes want_ttk \
+		   ttk_theme} {
 	global $v
 	set $v $oldprefs($v)
     }
@@ -10906,7 +10920,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes use_ttk ttk_theme
 
     catch {destroy $prefstop}
     unset prefstop
@@ -10955,6 +10969,9 @@ proc prefsok {} {
     if {$hideremotes != $oldprefs(hideremotes)} {
 	rereadrefs
     }
+    if {$use_ttk && $ttk_theme != $oldprefs(ttk_theme)} {
+	ttk::style theme use $ttk_theme
+    }
 }
 
 proc formatdate {d} {
@@ -11369,6 +11386,7 @@ set datetimeformat "%Y-%m-%d %H:%M:%S"
 set autoselect 1
 set perfile_attrs 0
 set want_ttk 1
+set ttk_theme "default"
 
 if {[tk windowingsystem] eq "aqua"} {
     set extdifftool "opendiff"
@@ -11519,6 +11537,10 @@ if {![info exists have_ttk]} {
 set use_ttk [expr {$have_ttk && $want_ttk}]
 set NS [expr {$use_ttk ? "ttk" : ""}]
 
+if {$use_ttk} {
+    ttk::style theme use $ttk_theme
+}
+
 set git_version [join [lrange [split [lindex [exec git version] end] .] 0 2] .]
 
 set runq {}
-- 
1.7.1.1
