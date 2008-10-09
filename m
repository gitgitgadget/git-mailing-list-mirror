From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 1/6] gitk: Add procedure to create accelerated menus
Date: Thu,  9 Oct 2008 08:09:45 +0200
Message-ID: <1223532590-8706-2-git-send-email-robin.rosenberg@dewire.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Oct 09 08:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnolX-000419-Hj
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 08:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbYJIGLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 02:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbYJIGLO
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 02:11:14 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:57587 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636AbYJIGLG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 02:11:06 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 36DB93C3D8; Thu,  9 Oct 2008 08:11:04 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 04EAB3C652; Thu,  9 Oct 2008 08:11:01 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id A558837E4D;
	Thu,  9 Oct 2008 08:11:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97822>

These are the undescores menu items that can be selected with the Alt+letter,
key combination on Windows and Linux or Command+letter on Macs.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 gitk |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 2eaa2ae..050019c 100755
--- a/gitk
+++ b/gitk
@@ -1750,6 +1750,33 @@ proc setoptions {} {
     option add *Entry.font uifont startupFile
 }
 
+# Menu command wrapper. Intercepts any -label arguments, 
+# removes the & and adds the -underline argument necessary
+# to implement the menu accelerator.
+proc mcw {menubar args} {
+    set ai [lsearch $args "-label"]
+    if { $ai > 0 } {
+	set label [lindex $args [expr {$ai + 1}]]
+	foreach {l u} [::tk::UnderlineAmpersand $label] {
+	    lset args [expr {$ai + 1}] $l
+	}
+	lappend args -underline
+	lappend args $u
+    }
+    set cmd [ list $menubar ]
+    foreach a $args {
+	lappend cmd $a
+    }
+    eval $cmd
+}
+
+# Wrapper for mc to remove ampersands used for accelerators.
+proc mca {label} {
+    set tl8 [mc $label]
+    foreach {l u} [::tk::UnderlineAmpersand $tl8] break
+    return $l
+}
+
 proc makewindow {} {
     global canv canv2 canv3 linespc charspc ctext cflist cscroll
     global tabstop
-- 
1.6.0.2.308.gef4a
