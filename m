From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH 7/7] gitk: Explicitly position popup windows.
Date: Wed,  8 Oct 2008 11:05:40 +0400
Message-ID: <1223449540-20457-8-git-send-email-angavrilov@gmail.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-2-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-4-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
 <1223449540-20457-7-git-send-email-angavrilov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 09:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnTAU-0006GO-UL
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 09:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYJHHHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 03:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbYJHHHh
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 03:07:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:30663 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYJHHH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 03:07:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2606209fgg.17
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7CZ0EW/CX+fEQHM0g2qAFOlmpR41/bTRmdKyqkRYzMY=;
        b=mv93sKUS7aGtozm0ky+cUDSGn44ndDIv/8YGQXneSR7PeLWGHUE3YW4S/kZ9FAuRL5
         EpMn+ey+9LXvDVqjsYasRBA/+RgHAe2TVk8B2tNohxxkfZH4dXpSvjNFJjoQGZrk5i/H
         MnbTCWDEGlnEQ9jvxjPWJGX3zYPt8B+jhTgUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W6d/pHiCAdNdIj+5gAMtENgIqcGXBkSLnQ4EL+ORkBlD62cyOLBjgRaFVCxt7qBJre
         unaL0MX9cMhfPUkxp4XiQEhFeMFne9U3vUgMnDFHefeLEiGH0hCHztfQ9RHCirqcrbui
         dgGIGf/f0HsHetJPWv2tWtC3DF+OWJQbz+3G8=
Received: by 10.180.237.12 with SMTP id k12mr5814199bkh.106.1223449647851;
        Wed, 08 Oct 2008 00:07:27 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id e17sm15096059fke.10.2008.10.08.00.07.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 00:07:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1223449540-20457-7-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97780>

For some reason, on Windows all transient windows are placed
in the upper left corner of the screen. Thus, it is necessary
to explicitly position the windows using the tk::PlaceWindow
function.

Reference list and the Edit View dialog are positioned under
the mouse cursor, thus allowing the user to create them in a
convenient place using keyboard shortcuts, and providing a
sane position when opened through the menu.

Other popups are centered on the main window.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index c7dd487..9e580a6 100755
--- a/gitk
+++ b/gitk
@@ -1703,7 +1703,7 @@ proc removehead {id name} {
     unset headids($name)
 }
 
-proc show_error {w top msg} {
+proc show_error {w top msg {owner {}}} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text [mc OK] -command "destroy $top"
@@ -1712,6 +1712,9 @@ proc show_error {w top msg} {
     bind $top <Key-Return> "destroy $top"
     bind $top <Key-space>  "destroy $top"
     bind $top <Key-Escape> "destroy $top"
+    if {$owner ne {}} {
+	tk::PlaceWindow $top widget $owner
+    }
     tkwait window $top
 }
 
@@ -1719,7 +1722,7 @@ proc error_popup {msg {owner .}} {
     set w .error
     toplevel $w
     wm transient $w $owner
-    show_error $w $w $msg
+    show_error $w $w $msg $owner
 }
 
 proc confirm_popup {msg {owner .}} {
@@ -1738,6 +1741,7 @@ proc confirm_popup {msg {owner .}} {
     bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     bind $w <Key-space>  "set confirm_ok 1; destroy $w"
     bind $w <Key-Escape> "destroy $w"
+    tk::PlaceWindow $w widget $owner
     tkwait window $w
     return $confirm_ok
 }
@@ -2493,6 +2497,7 @@ Use and redistribute under the terms of the GNU General Public License"] \
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    tk::PlaceWindow $w widget .
 }
 
 proc keys {} {
@@ -2554,6 +2559,7 @@ proc keys {} {
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    tk::PlaceWindow $w widget .
 }
 
 # Procedures for manipulating the file list window at the
@@ -3497,6 +3503,7 @@ proc vieweditor {top n title} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid columnconfigure $top.buts 2 -weight 1 -uniform a
     pack $top.buts -in $top -side top -fill x
+    tk::PlaceWindow $top pointer .
     focus $top.t
 }
 
@@ -7684,6 +7691,7 @@ proc mkpatch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    tk::PlaceWindow $top widget .
 }
 
 proc mkpatchrev {} {
@@ -7758,6 +7766,7 @@ proc mktag {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.tag
+    tk::PlaceWindow $top widget .
 }
 
 proc domktag {} {
@@ -7865,6 +7874,7 @@ proc writecommit {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    tk::PlaceWindow $top widget .
 }
 
 proc wrcomgo {} {
@@ -7914,6 +7924,7 @@ proc mkbranch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.name
+    tk::PlaceWindow $top widget .
 }
 
 proc mkbrgo {top} {
@@ -8093,6 +8104,7 @@ proc resethead {} {
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
+    tk::PlaceWindow $w widget .
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
@@ -8278,6 +8290,7 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    tk::PlaceWindow $top pointer .
 }
 
 proc sel_reflist {w x y} {
@@ -9630,6 +9643,7 @@ proc choosefont {font which} {
 	grid columnconfigure $top.buts 1 -weight 1 -uniform a
 	pack $top.buts -side bottom -fill x
 	trace add variable fontparam write chg_fontparam
+	tk::PlaceWindow $top widget $prefstop
     } else {
 	raise $top
 	$top.c itemconf text -text $which
@@ -9801,6 +9815,7 @@ proc doprefs {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
     bind $top <Visibility> "focus $top.buts.ok"
+    tk::PlaceWindow $top widget .
 }
 
 proc choose_extdiff {} {
-- 
1.6.0.20.g6148bc
