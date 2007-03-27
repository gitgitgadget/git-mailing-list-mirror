From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 1/4] Teach git-gui to use the user-defined UI font everywhere.
Date: Tue, 27 Mar 2007 14:29:09 +0400
Message-ID: <20070327102908.GO14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8vZ-0001Gn-H3
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbXC0K3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbXC0K3T
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:29:19 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:64814 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbXC0K3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:29:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=hau9tdwjA/E70U+BGrdJqZnG9sRInOKvXMNtGJzdATbyV5gvB59VXdHGl7/+kMHyojtpzghtAi1t3SURcCoY9F7MwNbhGVGK+GCfN2TDgl35ZEtshrz4CkHWb6TSlHhP3ixXseGeZ47bH7reY9ZlTv3cd0vtErMkk2mitGarpG8=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW8vR-000Da2-Kh; Tue, 27 Mar 2007 14:29:14 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43249>

Some parts of git-gui were not respecting the default GUI font.
Most of them were catched and fixed.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |   64 ++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 60e79ca..8157184 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -242,6 +242,8 @@ proc error_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	set cmd [list tk_messageBox \
 		-icon error \
 		-type ok \
@@ -258,6 +260,8 @@ proc warn_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	set cmd [list tk_messageBox \
 		-icon warning \
 		-type ok \
@@ -274,6 +278,8 @@ proc info_popup {msg {parent .}} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	tk_messageBox \
 		-parent $parent \
 		-icon info \
@@ -287,6 +293,8 @@ proc ask_popup {msg} {
 	if {[reponame] ne {}} {
 		append title " ([reponame])"
 	}
+	option add *Dialog.msg.font font_ui
+	option add *Button.font font_ui
 	return [tk_messageBox \
 		-parent . \
 		-icon question \
@@ -2116,7 +2124,10 @@ proc do_create_branch {} {
 		-value head \
 		-variable create_branch_revtype \
 		-font font_ui
-	eval tk_optionMenu $w.from.head_m create_branch_head $all_heads
+	set lbranchm [eval tk_optionMenu $w.from.head_m create_branch_head \
+		$all_heads]
+	$lbranchm configure -font font_ui
+	$w.from.head_m configure -font font_ui
 	grid $w.from.head_r $w.from.head_m -sticky w
 	set all_trackings [all_tracking_branches]
 	if {$all_trackings ne {}} {
@@ -2126,9 +2137,11 @@ proc do_create_branch {} {
 			-value tracking \
 			-variable create_branch_revtype \
 			-font font_ui
-		eval tk_optionMenu $w.from.tracking_m \
+		set tbranchm [eval tk_optionMenu $w.from.tracking_m \
 			create_branch_trackinghead \
-			$all_trackings
+			$all_trackings]
+		$tbranchm configure -font font_ui
+		$w.from.tracking_m configure -font font_ui
 		grid $w.from.tracking_r $w.from.tracking_m -sticky w
 	}
 	set all_tags [load_all_tags]
@@ -2139,9 +2152,11 @@ proc do_create_branch {} {
 			-value tag \
 			-variable create_branch_revtype \
 			-font font_ui
-		eval tk_optionMenu $w.from.tag_m \
+		set tagsm [eval tk_optionMenu $w.from.tag_m \
 			create_branch_tag \
-			$all_tags
+			$all_tags]
+		$tagsm configure -font font_ui
+		$w.from.tag_m configure -font font_ui
 		grid $w.from.tag_r $w.from.tag_m -sticky w
 	}
 	radiobutton $w.from.exp_r \
@@ -2335,7 +2350,11 @@ proc do_delete_branch {} {
 		-value head \
 		-variable delete_branch_checktype \
 		-font font_ui
-	eval tk_optionMenu $w.validate.head_m delete_branch_head $all_heads
+	set mergedlocalm [eval tk_optionMenu $w.validate.head_m \
+		delete_branch_head \
+		$all_heads]
+	$mergedlocalm configure -font font_ui
+	$w.validate.head_m configure -font font_ui
 	grid $w.validate.head_r $w.validate.head_m -sticky w
 	set all_trackings [all_tracking_branches]
 	if {$all_trackings ne {}} {
@@ -2345,9 +2364,11 @@ proc do_delete_branch {} {
 			-value tracking \
 			-variable delete_branch_checktype \
 			-font font_ui
-		eval tk_optionMenu $w.validate.tracking_m \
+		set mergedtrackm [eval tk_optionMenu $w.validate.tracking_m \
 			delete_branch_trackinghead \
-			$all_trackings
+			$all_trackings]
+		$mergedtrackm configure -font font_ui
+		$w.validate.tracking_m configure -font font_ui
 		grid $w.validate.tracking_r $w.validate.tracking_m -sticky w
 	}
 	radiobutton $w.validate.always_r \
@@ -2721,7 +2742,10 @@ proc do_push_anywhere {} {
 			-value remote \
 			-variable push_urltype \
 			-font font_ui
-		eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
+		set remmenu [eval tk_optionMenu $w.dest.remote_m push_remote \
+			$all_remotes]
+		$remmenu configure -font font_ui
+		$w.dest.remote_m configure -font font_ui
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
 		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
 			set push_remote origin
@@ -4686,9 +4710,11 @@ proc do_options {} {
 		frame $w.global.$name
 		label $w.global.$name.l -text "$text:" -font font_ui
 		pack $w.global.$name.l -side left -anchor w -fill x
-		eval tk_optionMenu $w.global.$name.family \
+		set fontmenu [eval tk_optionMenu $w.global.$name.family \
 			global_config_new(gui.$font^^family) \
-			$all_fonts
+			$all_fonts]
+		$w.global.$name.family configure -font font_ui
+		$fontmenu configure -font font_ui
 		spinbox $w.global.$name.size \
 			-textvariable global_config_new(gui.$font^^size) \
 			-from 2 -to 80 -increment 1 \
@@ -5083,18 +5109,18 @@ set ui_comm {}
 # -- Menu Bar
 #
 menu .mbar -tearoff 0
-.mbar add cascade -label Repository -menu .mbar.repository
-.mbar add cascade -label Edit -menu .mbar.edit
+.mbar add cascade -label Repository -menu .mbar.repository -font font_ui
+.mbar add cascade -label Edit -menu .mbar.edit -font font_ui
 if {[is_enabled branch]} {
-	.mbar add cascade -label Branch -menu .mbar.branch
+	.mbar add cascade -label Branch -menu .mbar.branch -font font_ui
 }
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
-	.mbar add cascade -label Commit -menu .mbar.commit
+	.mbar add cascade -label Commit -menu .mbar.commit -font font_ui
 }
 if {[is_enabled transport]} {
-	.mbar add cascade -label Merge -menu .mbar.merge
-	.mbar add cascade -label Fetch -menu .mbar.fetch
-	.mbar add cascade -label Push -menu .mbar.push
+	.mbar add cascade -label Merge -menu .mbar.merge -font font_ui
+	.mbar add cascade -label Fetch -menu .mbar.fetch -font font_ui
+	.mbar add cascade -label Push -menu .mbar.push -font font_ui
 }
 . configure -menu .mbar
 
@@ -5370,7 +5396,7 @@ if {[is_MacOSX]} {
 
 # -- Help Menu
 #
-.mbar add cascade -label Help -menu .mbar.help
+.mbar add cascade -label Help -menu .mbar.help -font font_ui
 menu .mbar.help
 
 if {![is_MacOSX]} {
-- 
1.5.0.3-dirty
