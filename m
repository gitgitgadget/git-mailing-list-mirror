From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: Fix errors in the theme patch
Date: 12 May 2009 15:45:06 +0100
Message-ID: <87zldi9y8d.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 12 16:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3tET-0002DS-OS
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 16:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZELOpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752663AbZELOpQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 10:45:16 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:51833 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbZELOpP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 10:45:15 -0400
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1M3tEH-0003Am-CR; Tue, 12 May 2009 15:45:13 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1M3tED-0005Z3-G7; Tue, 12 May 2009 15:45:09 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 7003E5183F; Tue, 12 May 2009 15:45:07 +0100 (BST)
CC: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118899>


  This patch fixes a typo in the commit selection combobox that
  prevented it from working and sets the width of the widget.
  Also fixed show_error to handle errors arising before the gui is
  fully configured (ie: invalid command line parameters)

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 4526193..082fa77 100755
--- a/gitk
+++ b/gitk
@@ -1798,6 +1798,7 @@ proc make_transient {window origin} {
 
 proc show_error {w top msg} {
     global NS
+    if {![info exists NS]} {set NS ""}
     if {[wm state $top] eq "withdrawn"} { wm deiconify $top }
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
@@ -1920,7 +1921,12 @@ proc mca {str} {
 proc makedroplist {w varname args} {
     global use_ttk
     if {$use_ttk} {
-	set gm [ttk::combobox $w -width 10 -state readonly\
+        set width 0
+        foreach label $args {
+            set cx [string length $label]
+            if {$cx > $width} {set width $cx}
+        }
+	set gm [ttk::combobox $w -width $width -state readonly\
 		    -textvariable $varname -values $args]
     } else {
 	set gm [eval [linsert $args 0 tk_optionMenu $w $varname]]
@@ -2141,7 +2147,7 @@ proc makewindow {} {
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 \
 	-side left -fill y
     set gdttype [mc "containing:"]
-    set gm [makedroplist .tf.lbar.gdttype gdtype \
+    set gm [makedroplist .tf.lbar.gdttype gdttype \
 		[mc "containing:"] \
 		[mc "touching paths:"] \
 		[mc "adding/removing string:"]]
-- 
1.6.3.msysgit.0
