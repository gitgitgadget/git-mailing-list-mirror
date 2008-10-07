From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [Gitk PATCH 1/6] gitk: Add procedure to create accelerated menus
Date: Tue,  7 Oct 2008 23:56:44 +0200
Message-ID: <1223416609-18864-2-git-send-email-robin.rosenberg@dewire.com>
References: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: speace@spearce.org
X-From: git-owner@vger.kernel.org Tue Oct 07 23:59:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnKaU-00033q-7T
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 23:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbYJGV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 17:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755042AbYJGV6I
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 17:58:08 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:40081 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbYJGV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 17:58:07 -0400
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 78574383B2; Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 0C57F37EA5; Tue,  7 Oct 2008 23:58:05 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id E21F537E43;
	Tue,  7 Oct 2008 23:58:04 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223416609-18864-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97747>

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
