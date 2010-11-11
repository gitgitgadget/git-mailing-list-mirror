From: David Fries <david@Fries.net>
Subject: [PATCH 1/3] gitk: improve dark background, s/black/$fgcolor/
Date: Wed, 10 Nov 2010 23:19:00 -0600
Message-ID: <1289452742-7235-1-git-send-email-david@fries.net>
References: <1289451597-6950-1-git-send-email-david@fries.net>
Cc: David Fries <David@Fries.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 06:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGPZB-0007I0-SB
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 06:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0KKFTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 00:19:06 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:34632 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752460Ab0KKFTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 00:19:05 -0500
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAB5J2wo007267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Nov 2010 23:19:02 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAB5J2f4007266;
	Wed, 10 Nov 2010 23:19:02 -0600
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289451597-6950-1-git-send-email-david@fries.net>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 10 Nov 2010 23:19:02 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161209>

Replace most uses of black with $fgcolor as items such as a black
outline on the tag or tag lines with a black background doesn't show
up.  Use $fgcolor instead to make it contrast with the background.

Signed-off-by: David Fries <David@Fries.net>
---
 gitk-git/gitk |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1b0e09a..af43353 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6270,7 +6270,7 @@ proc drawtags {id x xt y1} {
 	set xt [expr {$xt + $delta + $wid + $lthickness + $linespc}]
     }
     set t [$canv create line $x $y1 [lindex $xvals end] $y1 \
-	       -width $lthickness -fill black -tags tag.$id]
+	       -width $lthickness -fill $fgcolor -tags [list tag.$id line]]
     $canv lower $t
     foreach tag $marks x $xvals wid $wvals {
 	set xl [expr {$x + $delta}]
@@ -6280,7 +6280,7 @@ proc drawtags {id x xt y1} {
 	    # draw a tag
 	    set t [$canv create polygon $x [expr {$yt + $delta}] $xl $yt \
 		       $xr $yt $xr $yb $xl $yb $x [expr {$yb - $delta}] \
-		       -width 1 -outline black -fill yellow -tags tag.$id]
+		       -width 1 -outline $fgcolor -fill yellow -tags tag.$id]
 	    $canv bind $t <1> [list showtag $tag 1]
 	    set rowtextx([rowofcommit $id]) [expr {$xr + $linespc}]
 	} else {
@@ -6295,7 +6295,7 @@ proc drawtags {id x xt y1} {
 	    }
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
-		-width 1 -outline black -fill $col -tags tag.$id
+		-width 1 -outline $fgcolor -fill $col -tags tag.$id
 	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
@@ -8215,6 +8215,7 @@ proc linehover {} {
     global hoverx hovery hoverid hovertimer
     global canv linespc lthickness
     global commitinfo
+    global fgcolor
 
     set text [lindex $commitinfo($hoverid) 0]
     set ymax [lindex [$canv cget -scrollregion] 3]
@@ -8227,7 +8228,7 @@ proc linehover {} {
     set x1 [expr {$x + [font measure mainfont $text] + 2 * $lthickness}]
     set y1 [expr {$y + $linespc + 2 * $lthickness}]
     set t [$canv create rectangle $x0 $y0 $x1 $y1 \
-	       -fill \#ffff80 -outline black -width 1 -tags hover]
+	       -fill \#ffff80 -outline $fgcolor -width 1 -tags hover]
     $canv raise $t
     set t [$canv create text $x $y -anchor nw -text $text -tags hover \
 	       -font mainfont]
@@ -10886,6 +10887,7 @@ proc setfg {c} {
     allcanvs itemconf text -fill $c
     $canv itemconf circle -outline $c
     $canv itemconf markid -outline $c
+    $canv itemconf line -fill $c
 }
 
 proc prefscan {} {
-- 
1.7.2.3
