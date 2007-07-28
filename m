From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH] git-gui.git: Wording suggestions, 2nd try
Date: Sat, 28 Jul 2007 22:17:10 +0200
Message-ID: <200707282217.10772.stimming@tuhh.de>
References: <20070726111902.xqkxcdlsbo8w4c8k@webmail.tu-harburg.de> <861wevqz7d.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:18:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsjg-0003ga-I9
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:18:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbXG1UR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbXG1UR6
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:17:58 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:37928 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbXG1UR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:17:57 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l6SKHJBr003192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 28 Jul 2007 22:17:19 +0200
Received: from [192.168.2.102] (p549024E3.dip0.t-ipconnect.de [84.144.36.227])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.1/8.13.1) with ESMTP id l6SKHHcY010327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 22:17:19 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <861wevqz7d.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54061>

Unify wording to say "to stage" instead of "to add" always.

Also, the warning message when clicking "Reset" is adapted to
the wording "Reset" rather than a confusion "Cancel commit?".

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
This time, this patch is actually based on git-gui.git's master. If you want to, you can directly apply this regardless of i18n work that was deferred until later.
The last hunk in lib/merge.tcl looks a bit confusing; in preparation of i18n work, the previous message that inserted a single word into the long english sentence was already replaced by the i18n'able form of two completely different messages. But nevertheless the main point is that when clicking "Reset", the upcoming question should use the wording "reset", which it will do after this patch.

 git-gui.sh          |    6 +++---
 lib/checkout_op.tcl |    2 +-
 lib/commit.tcl      |    4 ++--
 lib/index.tcl       |    2 +-
 lib/merge.tcl       |   18 +++++++++++-------
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f87b955..d7fad46 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1827,12 +1827,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Add To Commit} \
+	.mbar.commit add command -label {Stage To Commit} \
 		-command do_add_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Add Tracked Files To Commit} \
+	.mbar.commit add command -label {Stage Changed Files To Commit} \
 		-command do_add_all \
 		-accelerator $M1T-I
 	lappend disable_on_lock \
@@ -2154,7 +2154,7 @@ pack .vpane.lower.commarea.buttons.rescan -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.rescan conf -state}
 
-button .vpane.lower.commarea.buttons.incall -text {Add Tracked} \
+button .vpane.lower.commarea.buttons.incall -text {Stage Changed} \
 	-command do_add_all
 pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 40cc73a..170f737 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -248,7 +248,7 @@ method _checkout {} {
 	if {[lock_index checkout_op]} {
 		after idle [cb _start_checkout]
 	} else {
-		_error $this "Index is already locked."
+		_error $this "Staging area (index) is already locked."
 		delete_this
 	}
 }
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 1f5c2c3..f857a2f 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -153,7 +153,7 @@ The rescan will be automatically started now.
 		U? {
 			error_popup "Unmerged files cannot be committed.
 
-File [short_path $path] has merge conflicts.  You must resolve them and add the file before committing.
+File [short_path $path] has merge conflicts.  You must resolve them and stage the file before committing.
 "
 			unlock_index
 			return
@@ -169,7 +169,7 @@ File [short_path $path] cannot be committed by this program.
 	if {!$files_ready && ![string match *merge $curType]} {
 		info_popup {No changes to commit.
 
-You must add at least 1 file before you can commit.
+You must stage at least 1 file before you can commit.
 }
 		unlock_index
 		return
diff --git a/lib/index.tcl b/lib/index.tcl
index 3ea72e1..f47f929 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -360,7 +360,7 @@ proc revert_helper {txt paths} {
 		"[appname] ([reponame])" \
 		"Revert changes in $s?
 
-Any unadded changes will be permanently lost by the revert." \
+Any unstaged changes will be permanently lost by the revert." \
 		question \
 		1 \
 		{Do Nothing} \
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 148d859..f6a2df3 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -45,7 +45,7 @@ The rescan will be automatically started now.
 
 File [short_path $path] has merge conflicts.
 
-You must resolve them, add the file, and commit to complete the current merge.  Only then can you begin another merge.
+You must resolve them, stage the file, and commit to complete the current merge.  Only then can you begin another merge.
 "
 			unlock_index
 			return 0
@@ -219,16 +219,20 @@ You must finish amending this commit.
 	if {![lock_index abort]} return
 
 	if {[string match *merge* $commit_type]} {
-		set op merge
+		set op_question "Abort merge?
+
+Aborting the current merge will cause *ALL* uncommitted changes to be lost.
+
+Continue with aborting the current merge?"
 	} else {
-		set op commit
-	}
+		set op_question "Reset changes?
 
-	if {[ask_popup "Abort $op?
+Resetting the changes will cause *ALL* uncommitted changes to be lost.
 
-Aborting the current $op will cause *ALL* uncommitted changes to be lost.
+Continue with resetting the current changes?"
+	}
 
-Continue with aborting the current $op?"] eq {yes}} {
+	if {[ask_popup $op_question] eq {yes}} {
 		set fd [git_read read-tree --reset -u HEAD]
 		fconfigure $fd -blocking 0 -translation binary
 		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-- 
1.5.2
