From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH 3/4] Improve look-and-feel of the git-gui tool.
Date: Tue, 27 Mar 2007 14:31:02 +0400
Message-ID: <20070327103102.GQ14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Mar 27 12:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW8xp-0002WK-Sj
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbXC0KbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbXC0KbM
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:31:12 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:52953 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbXC0KbK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 06:31:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=ivyO+Vd6oRPjnekV9NMD3eMQ6HUNHjZ05/pUOvJ0Fkz11pkslszN6ZRYvJmbIzu5MZid//vVx11ao6skWsNy/YZD56uCfW22WWsbeDtJ6BEK5z/Pg8qNJb+tcWAnRkchUDmLgbPiqZ1QeOGHJvcMQUZW/6ykcBqtXPMG213b/jg=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW8xJ-000DaR-47; Tue, 27 Mar 2007 14:31:09 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43252>

Made the default buttons on the dialog active and focused upon the
dialog appearence.

Bound 'Escape' and 'Return' keys to the dialog dismissal where it
was appropriate: mainly for dialogs with only one button and no
editable fields, but on console output dialogs as well.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-gui/git-gui.sh |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 1f3ee05..7c2ec6b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2710,10 +2710,12 @@ proc do_push_anywhere {} {
 	frame $w.buttons
 	button $w.buttons.create -text Push \
 		-font font_ui \
+		-default active \
 		-command [list start_push_anywhere_action $w]
 	pack $w.buttons.create -side right
 	button $w.buttons.cancel -text {Cancel} \
 		-font font_ui \
+		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -2805,7 +2807,7 @@ proc do_push_anywhere {} {
 	set push_thin 0
 	set push_tags 0
 
-	bind $w <Visibility> "grab $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	wm title $w "[appname] ([reponame]): Push"
 	tkwait window $w
@@ -4137,6 +4139,7 @@ proc console_done {args} {
 		if {[winfo exists $w]} {
 			$w.m.s conf -background green -text {Success}
 			$w.ok conf -state normal
+			focus $w.ok
 		}
 	} else {
 		if {![winfo exists $w]} {
@@ -4144,6 +4147,7 @@ proc console_done {args} {
 		}
 		$w.m.s conf -background red -text {Error: Command Failed}
 		$w.ok conf -state normal
+		focus $w.ok
 	}
 
 	array unset console_cr $w
@@ -4211,9 +4215,11 @@ proc do_stats {} {
 	frame $w.buttons -border 1
 	button $w.buttons.close -text Close \
 		-font font_ui \
+		-default active \
 		-command [list destroy $w]
 	button $w.buttons.gc -text {Compress Database} \
 		-font font_ui \
+		-default normal \
 		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
 	pack $w.buttons.gc -side left
@@ -4242,7 +4248,7 @@ proc do_stats {} {
 	}
 	pack $w.stat -pady 10 -padx 10
 
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
 	wm title $w "[appname] ([reponame]): Database Statistics"
@@ -4539,6 +4545,7 @@ proc do_about {} {
 	frame $w.buttons
 	button $w.buttons.close -text {Close} \
 		-font font_ui \
+		-default active \
 		-command [list destroy $w]
 	pack $w.buttons.close -side right
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -4584,8 +4591,9 @@ $copyright" \
 		clipboard append -format STRING -type STRING -- \[$w.vers cget -text\]
 	"
 
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> "destroy $w"
+	bind $w <Key-Return> "destroy $w"
 	bind_button3 $w.vers "tk_popup $w.ctxm %X %Y; grab $w; focus $w"
 	wm title $w "About [appname]"
 	tkwait window $w
@@ -4622,14 +4630,17 @@ proc do_options {} {
 	frame $w.buttons
 	button $w.buttons.restore -text {Restore Defaults} \
 		-font font_ui \
+		-default normal \
 		-command do_restore_defaults
 	pack $w.buttons.restore -side left
 	button $w.buttons.save -text Save \
 		-font font_ui \
+		-default active \
 		-command [list do_save_config $w]
 	pack $w.buttons.save -side right
 	button $w.buttons.cancel -text {Cancel} \
 		-font font_ui \
+		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -4733,7 +4744,7 @@ proc do_options {} {
 		pack $w.global.$name -side top -anchor w -fill x
 	}
 
-	bind $w <Visibility> "grab $w; focus $w"
+	bind $w <Visibility> "grab $w; focus $w.buttons.save"
 	bind $w <Key-Escape> "destroy $w"
 	wm title $w "[appname] ([reponame]): Options"
 	tkwait window $w
-- 
1.5.0.3-dirty
