From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 2/4] Fix drop-down menus in the git-gui dialogs.
Date: Tue, 27 Mar 2007 14:30:05 +0400
Message-ID: <20070327103005.GP14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:30:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8wT-0001ka-Dn
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbXC0KaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753773AbXC0KaN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:30:13 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:59730 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbXC0KaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:30:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=o8cy7PuHcZEUfcP7PRZDUf1RNWpTwtmdxCG9vmSBoGrl49f9OuCdq8ojkEt5zPgLEpsnqD3AzRfQVpz1iwoPNrE1aHuHL1geigVOZFbnIDhlSRBsbibv0/MI1gIb4JsXLZ5AoIe47zJi+a8z3QNm3ss1LC06c/9MInIeYwRLXCE=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW8wM-000DaG-7c; Tue, 27 Mar 2007 14:30:10 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43251>

If the drop-down menu (for example "Local Branch" from the dialog
activated by the "Branch/Create..." menu item) is chosen with the
left mouse button, then the pointer is moved off the drop-down menu
while the mouse button is still pressed and then the 'Escape' key
is pressed, the main menu will be broken. Next time when you will
try to select any main menu item, the Tcl/Tk interpreter will spawn
an internal error.

Error was fixed by "grab"bing the drop-down menu windows on their
activation. Now all drop-down menus are disappearing once the mouse
button is depressed, no matter what is the current position of the
mouse pointer.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 8157184..1f3ee05 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2126,6 +2126,7 @@ proc do_create_branch {} {
 		-font font_ui
 	set lbranchm [eval tk_optionMenu $w.from.head_m create_branch_head \
 		$all_heads]
+	bind $lbranchm <Visibility> "grab $lbranchm"
 	$lbranchm configure -font font_ui
 	$w.from.head_m configure -font font_ui
 	grid $w.from.head_r $w.from.head_m -sticky w
@@ -2140,6 +2141,7 @@ proc do_create_branch {} {
 		set tbranchm [eval tk_optionMenu $w.from.tracking_m \
 			create_branch_trackinghead \
 			$all_trackings]
+		bind $tbranchm <Visibility> "grab $tbranchm"
 		$tbranchm configure -font font_ui
 		$w.from.tracking_m configure -font font_ui
 		grid $w.from.tracking_r $w.from.tracking_m -sticky w
@@ -2155,6 +2157,7 @@ proc do_create_branch {} {
 		set tagsm [eval tk_optionMenu $w.from.tag_m \
 			create_branch_tag \
 			$all_tags]
+		bind $tagsm <Visibility> "grab $tagsm"
 		$tagsm configure -font font_ui
 		$w.from.tag_m configure -font font_ui
 		grid $w.from.tag_r $w.from.tag_m -sticky w
@@ -2353,6 +2356,7 @@ proc do_delete_branch {} {
 	set mergedlocalm [eval tk_optionMenu $w.validate.head_m \
 		delete_branch_head \
 		$all_heads]
+	bind $mergedlocalm <Visibility> "grab $mergedlocalm"
 	$mergedlocalm configure -font font_ui
 	$w.validate.head_m configure -font font_ui
 	grid $w.validate.head_r $w.validate.head_m -sticky w
@@ -2367,6 +2371,7 @@ proc do_delete_branch {} {
 		set mergedtrackm [eval tk_optionMenu $w.validate.tracking_m \
 			delete_branch_trackinghead \
 			$all_trackings]
+		bind $mergedtrackm <Visibility> "grab $mergedtrackm"
 		$mergedtrackm configure -font font_ui
 		$w.validate.tracking_m configure -font font_ui
 		grid $w.validate.tracking_r $w.validate.tracking_m -sticky w
@@ -2744,6 +2749,7 @@ proc do_push_anywhere {} {
 			-font font_ui
 		set remmenu [eval tk_optionMenu $w.dest.remote_m push_remote \
 			$all_remotes]
+		bind $remmenu <Visibility> "grab $remmenu"
 		$remmenu configure -font font_ui
 		$w.dest.remote_m configure -font font_ui
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
@@ -4713,6 +4719,7 @@ proc do_options {} {
 		set fontmenu [eval tk_optionMenu $w.global.$name.family \
 			global_config_new(gui.$font^^family) \
 			$all_fonts]
+		bind $fontmenu <Visibility> "grab $fontmenu"
 		$w.global.$name.family configure -font font_ui
 		$fontmenu configure -font font_ui
 		spinbox $w.global.$name.size \
-- 
1.5.0.3-dirty
