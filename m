From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Sun, 9 Nov 2008 17:53:30 +0300
Organization: HOME
Message-ID: <200811091753.31198.angavrilov@gmail.com>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com> <1225652389-22082-7-git-send-email-angavrilov@gmail.com> <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 15:56:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzBic-00028o-K8
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 15:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbYKIOzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 09:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbYKIOzf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 09:55:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:1296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbYKIOze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 09:55:34 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1864312fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=mfUNGmNcwGuE17K7pSz9/ioAg8YblLiPpRXCwqu7Ytw=;
        b=QhLUfr71e+N5p7RWt3Um6ugDNdxmH2VC7j0iE3xUUcxnN00ntQqoN2859xzkMJzZ84
         UmTgG6SR3PlsX8HqE1AK81MurkGAJv51AjQt/ZBj2/f0Fl3M1MiaSj8/b/nq02aI/BNv
         6H7BmfQ8+vHVzFt0KWUM9HexIpAhpyCdxK+uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jDC9V/DOyHIxz57mzbj7s07usWrMKfIHRTHi+u4h7LRhmdsJpJcvBXWqWeMjhm0YeO
         CnkPjPwH3tNE1sxSmOxGQSFn1UjJsVSHAQu+S6w3dT5WatjiZ7C5tVa5e1ZyRL8TYNa1
         W4N0tqrzyy+6s4PsJm390ThXj0aRgp+fjXgWU=
Received: by 10.180.224.13 with SMTP id w13mr1751926bkg.40.1226242532637;
        Sun, 09 Nov 2008 06:55:32 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm8521270fkt.3.2008.11.09.06.55.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 06:55:31 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
In-Reply-To: <18708.11537.229423.296701@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100447>

On Friday 07 November 2008 14:57:05 Paul Mackerras wrote:
> Alexander Gavrilov writes:
> 
> > For some reason, on Windows all transient windows are placed
> > in the upper left corner of the screen. Thus, it is necessary
> > to explicitly position the windows relative to their parent.
> > For simplicity this patch uses the function that is used
> > internally by Tk dialogs.
> 
> Is there any reason to call tk::PlaceWindow under Linux or MacOS?
> If not I'd rather add an if statement so we only call it on Windows.

I don't know about MacOS, but in Linux it does seem unnecessary, so:


--- >8 ---
Subject: [PATCH] gitk: Explicitly position popup windows.

For some reason, on Windows all transient windows are placed
in the upper left corner of the screen. Thus, it is necessary
to explicitly position the windows relative to their parent.
For simplicity this patch uses the function that is used
internally by Tk dialogs.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1363d20..d72412c 100755
--- a/gitk
+++ b/gitk
@@ -1739,7 +1739,17 @@ proc removehead {id name} {
     unset headids($name)
 }
 
-proc show_error {w top msg} {
+proc center_window {window origin} {
+    # Let platforms with a real window manager
+    # deal with it on their own
+    if {$::tcl_platform(platform) ne {windows}} return
+
+    # Use a handy function from Tk. Note that it
+    # calls 'update' to figure out dimensions.
+    tk::PlaceWindow $window widget $origin
+}
+
+proc show_error {w top msg {owner {}}} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
     button $w.ok -text [mc OK] -command "destroy $top"
@@ -1748,6 +1758,9 @@ proc show_error {w top msg} {
     bind $top <Key-Return> "destroy $top"
     bind $top <Key-space>  "destroy $top"
     bind $top <Key-Escape> "destroy $top"
+    if {$owner ne {}} {
+	center_window $top $owner
+    }
     tkwait window $top
 }
 
@@ -1755,7 +1768,7 @@ proc error_popup {msg {owner .}} {
     set w .error
     toplevel $w
     wm transient $w $owner
-    show_error $w $w $msg
+    show_error $w $w $msg $owner
 }
 
 proc confirm_popup {msg {owner .}} {
@@ -1774,6 +1787,7 @@ proc confirm_popup {msg {owner .}} {
     bind $w <Key-Return> "set confirm_ok 1; destroy $w"
     bind $w <Key-space>  "set confirm_ok 1; destroy $w"
     bind $w <Key-Escape> "destroy $w"
+    center_window $w $owner
     tkwait window $w
     return $confirm_ok
 }
@@ -2572,6 +2586,7 @@ Use and redistribute under the terms of the GNU General Public License"] \
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    center_window $w .
 }
 
 proc keys {} {
@@ -2635,6 +2650,7 @@ proc keys {} {
     bind $w <Visibility> "focus $w.ok"
     bind $w <Key-Escape> "destroy $w"
     bind $w <Key-Return> "destroy $w"
+    center_window $w .
 }
 
 # Procedures for manipulating the file list window at the
@@ -3687,6 +3703,7 @@ proc vieweditor {top n title} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid columnconfigure $top.buts 2 -weight 1 -uniform a
     pack $top.buts -in $top -side top -fill x
+    center_window $top .
     focus $top.t
 }
 
@@ -7950,6 +7967,7 @@ proc mkpatch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    center_window $top .
 }
 
 proc mkpatchrev {} {
@@ -8024,6 +8042,7 @@ proc mktag {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.tag
+    center_window $top .
 }
 
 proc domktag {} {
@@ -8131,6 +8150,7 @@ proc writecommit {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.fname
+    center_window $top .
 }
 
 proc wrcomgo {} {
@@ -8181,6 +8201,7 @@ proc mkbranch {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - -pady 10 -sticky ew
     focus $top.name
+    center_window $top .
 }
 
 proc mkbrgo {top} {
@@ -8341,6 +8362,7 @@ proc resethead {} {
     bind $w <Key-Escape> [list destroy $w]
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
+    center_window $w .
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
@@ -8526,6 +8548,7 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    center_window $top .
 }
 
 proc sel_reflist {w x y} {
@@ -9878,6 +9901,7 @@ proc choosefont {font which} {
 	grid columnconfigure $top.buts 1 -weight 1 -uniform a
 	pack $top.buts -side bottom -fill x
 	trace add variable fontparam write chg_fontparam
+	center_window $top $prefstop
     } else {
 	raise $top
 	$top.c itemconf text -text $which
@@ -10060,6 +10084,7 @@ proc doprefs {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
     bind $top <Visibility> "focus $top.buts.ok"
+    center_window $top .
 }
 
 proc choose_extdiff {} {
-- 
1.6.0.3.15.gb8d36
