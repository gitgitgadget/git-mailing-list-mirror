From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] git-gui: move gitk launcher into a separate file
Date: Sat,  2 May 2009 11:20:53 +0200
Message-ID: <1241256054-14117-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 02 11:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0BRX-0006Dm-Vg
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 11:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZEBJWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 05:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbZEBJWn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 05:22:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53961 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbZEBJWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 05:22:42 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 73A2A1012E1F2;
	Sat,  2 May 2009 11:21:39 +0200 (CEST)
Received: from [89.59.107.122] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M0BPf-0002rf-00; Sat, 02 May 2009 11:21:39 +0200
X-Mailer: git-send-email 1.6.3.rc3.79.g777c
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/iMvj0/B+XEKpiS+y5tUWgPuwffYVU1KRnHcIM
	xUCJKo103pcmMZaQitPMm0xgJ1vEmM0T2tOSMlzvaVzoCAu1oC
	l0LOPXNjXmyd+f6dN1kA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118127>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 git-gui.sh   |   39 ---------------------------------------
 lib/gitk.tcl |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 39 deletions(-)
 create mode 100644 lib/gitk.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 14b92ba..6ff04c4 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1902,45 +1902,6 @@ proc incr_font_size {font {amt 1}} {
 ##
 ## ui commands
 
-set starting_gitk_msg [mc "Starting gitk... please wait..."]
-
-proc do_gitk {revs} {
-	# -- Always start gitk through whatever we were loaded with.  This
-	#    lets us bypass using shell process on Windows systems.
-	#
-	set exe [_which gitk -script]
-	set cmd [list [info nameofexecutable] $exe]
-	if {$exe eq {}} {
-		error_popup [mc "Couldn't find gitk in PATH"]
-	} else {
-		global env
-
-		if {[info exists env(GIT_DIR)]} {
-			set old_GIT_DIR $env(GIT_DIR)
-		} else {
-			set old_GIT_DIR {}
-		}
-
-		set pwd [pwd]
-		cd [file dirname [gitdir]]
-		set env(GIT_DIR) [file tail [gitdir]]
-
-		eval exec $cmd $revs &
-
-		if {$old_GIT_DIR eq {}} {
-			unset env(GIT_DIR)
-		} else {
-			set env(GIT_DIR) $old_GIT_DIR
-		}
-		cd $pwd
-
-		ui_status $::starting_gitk_msg
-		after 10000 {
-			ui_ready $starting_gitk_msg
-		}
-	}
-}
-
 proc do_explore {} {
 	set explorer {}
 	if {[is_Cygwin] || [is_Windows]} {
diff --git a/lib/gitk.tcl b/lib/gitk.tcl
new file mode 100644
index 0000000..fcbb73d
--- /dev/null
+++ b/lib/gitk.tcl
@@ -0,0 +1,41 @@
+# git-gui gitk launcher
+# Copyright (C) 2006, 2007 Shawn Pearce
+
+set starting_gitk_msg [mc "Starting gitk... please wait..."]
+
+proc do_gitk {revs} {
+	# -- Always start gitk through whatever we were loaded with.  This
+	#    lets us bypass using shell process on Windows systems.
+	#
+	set exe [_which gitk -script]
+	set cmd [list [info nameofexecutable] $exe]
+	if {$exe eq {}} {
+		error_popup [mc "Couldn't find gitk in PATH"]
+	} else {
+		global env
+
+		if {[info exists env(GIT_DIR)]} {
+			set old_GIT_DIR $env(GIT_DIR)
+		} else {
+			set old_GIT_DIR {}
+		}
+
+		set pwd [pwd]
+		cd [file dirname [gitdir]]
+		set env(GIT_DIR) [file tail [gitdir]]
+
+		eval exec $cmd $revs &
+
+		if {$old_GIT_DIR eq {}} {
+			unset env(GIT_DIR)
+		} else {
+			set env(GIT_DIR) $old_GIT_DIR
+		}
+		cd $pwd
+
+		ui_status $::starting_gitk_msg
+		after 10000 {
+			ui_ready $starting_gitk_msg
+		}
+	}
+}
-- 
1.6.3.rc3.79.g777c
