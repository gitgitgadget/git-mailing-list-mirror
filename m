From: David Fries <david@Fries.net>
Subject: [PATCH 2/3] gitk: improve dark background, use diffcolor 2 for link
Date: Wed, 10 Nov 2010 23:19:01 -0600
Message-ID: <1289452742-7235-2-git-send-email-david@fries.net>
References: <1289451597-6950-1-git-send-email-david@fries.net>
Cc: David Fries <David@Fries.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 06:19:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGPZC-0007I0-Sr
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 06:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0KKFTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 00:19:14 -0500
Received: from SpacedOut.fries.net ([67.64.210.234]:34633 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0KKFTF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 00:19:05 -0500
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id oAB5J31k007278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 10 Nov 2010 23:19:03 -0600
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id oAB5J32o007277;
	Wed, 10 Nov 2010 23:19:03 -0600
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289451597-6950-1-git-send-email-david@fries.net>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Wed, 10 Nov 2010 23:19:03 -0600 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161211>

blue on a black background might as well look like dark blue on black
and is very difficult to read.  The "Diff: hunk header" keeps the
colors more consistent and both default to blue.

Signed-off-by: David Fries <David@Fries.net>
---
 gitk-git/gitk |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index af43353..bef2e53 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6673,7 +6673,7 @@ proc appendwithlinks {text tags} {
 }
 
 proc setlink {id lk} {
-    global curview ctext pendinglinks
+    global curview ctext pendinglinks diffcolors
 
     set known 0
     if {[string length $id] < 40} {
@@ -6687,7 +6687,7 @@ proc setlink {id lk} {
 	set known [commitinview $id $curview]
     }
     if {$known} {
-	$ctext tag conf $lk -foreground blue -underline 1
+	$ctext tag conf $lk -foreground [lindex $diffcolors 2] -underline 1
 	$ctext tag bind $lk <1> [list selbyid $id]
 	$ctext tag bind $lk <Enter> {linkcursor %W 1}
 	$ctext tag bind $lk <Leave> {linkcursor %W -1}
@@ -10792,8 +10792,7 @@ proc doprefs {} {
     label $top.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
     ${NS}::button $top.hunksepbut -text [mc "Diff: hunk header"] \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
-		      [mc "diff hunk header"] \
-		      [list $ctext tag conf hunksep -foreground]]
+		      [mc "diff hunk header"] sethunksep ]
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.markbgsep -padx 40 -relief sunk -background $markbgcolor
     ${NS}::button $top.markbgbut -text [mc "Marked line bg"] \
@@ -10890,6 +10889,19 @@ proc setfg {c} {
     $canv itemconf line -fill $c
 }
 
+# update hunksep and each link foreground color
+proc sethunksep {c} {
+    global ctext linknum
+
+    $ctext tag conf hunksep -foreground $c
+    for {set i 0} {$i < $linknum} {incr i} {
+        # Use -underline to determine if it is a known link and gets this color
+        if {[$ctext tag cget link$i -underline] != ""} {
+            $ctext tag conf link$i -foreground $c
+        }
+    }
+}
+
 proc prefscan {} {
     global oldprefs prefstop
 
-- 
1.7.2.3
