From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [GIT-GUI PATCH] Teach git gui about file type changes
Date: Fri, 22 Aug 2008 22:10:27 +0200
Message-ID: <1219435827-11122-1-git-send-email-hendeby@isy.liu.se>
Cc: Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcyu-00010a-Dn
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 22:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbYHVUKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbYHVUKb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 16:10:31 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:60267 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbYHVUKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 16:10:31 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 341E625A6A
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 22:10:29 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 07325-06; Fri,  4 Jul 2008 02:08:54 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id F36C125A67;
	Fri, 22 Aug 2008 22:10:27 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id EFB2B2ED78; Fri, 22 Aug 2008 22:10:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.150.gf1ade9
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93353>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

Hi!

First of all, I'm really new to tcl/tk and the git gui code base so I
would appreciate any and all pointers here to make the changes
acceptable.

Secondly, I could really not come up with an icon to represent a type
change of a file.  Right now it is just different from all the others
and not illustrative at all...

/Gustaf

 git-gui.sh     |   18 +++++++++++++++++-
 lib/commit.tcl |    2 ++
 lib/index.tcl  |    7 +++++++
 3 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ad65aaa..8ad6567 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1619,6 +1619,15 @@ static unsigned char file_merge_bits[] = {
    0xfa, 0x17, 0x02, 0x10, 0xfe, 0x1f};
 } -maskdata $filemask
 
+image create bitmap file_statechange -background white -foreground green -data {
+#define file_merge_width 14
+#define file_merge_height 15
+static unsigned char file_statechange_bits[] = {
+   0xfe, 0x01, 0x02, 0x03, 0x02, 0x05, 0x02, 0x09, 0x02, 0x1f, 0x62, 0x10,
+   0x62, 0x10, 0xba, 0x11, 0xba, 0x11, 0x62, 0x10, 0x62, 0x10, 0x02, 0x10,
+   0x02, 0x10, 0x02, 0x10, 0xfe, 0x1f};
+} -maskdata $filemask
+
 set ui_index .vpane.files.index.list
 set ui_workdir .vpane.files.workdir.list
 
@@ -1627,12 +1636,14 @@ set all_icons(A$ui_index)   file_fulltick
 set all_icons(M$ui_index)   file_fulltick
 set all_icons(D$ui_index)   file_removed
 set all_icons(U$ui_index)   file_merge
+set all_icons(T$ui_index)   file_statechange
 
 set all_icons(_$ui_workdir) file_plain
 set all_icons(M$ui_workdir) file_mod
 set all_icons(D$ui_workdir) file_question
 set all_icons(U$ui_workdir) file_merge
 set all_icons(O$ui_workdir) file_plain
+set all_icons(T$ui_workdir) file_statechange
 
 set max_status_desc 0
 foreach i {
@@ -1643,6 +1654,9 @@ foreach i {
 		{MM {mc "Portions staged for commit"}}
 		{MD {mc "Staged for commit, missing"}}
 
+		{_T {mc "File type changed, not staged"}}
+		{T_ {mc "File type changed, staged"}}
+
 		{_O {mc "Untracked, not staged"}}
 		{A_ {mc "Staged for commit"}}
 		{AM {mc "Portions staged for commit"}}
@@ -2757,7 +2771,9 @@ proc popup_diff_menu {ctxm x y X Y} {
 	if {$::is_3way_diff
 		|| $current_diff_path eq {}
 		|| ![info exists file_states($current_diff_path)]
-		|| {_O} eq [lindex $file_states($current_diff_path) 0]} {
+		|| {_O} eq [lindex $file_states($current_diff_path) 0]
+		|| {_T} eq [lindex $file_states($current_diff_path) 0]
+		|| {T_} eq [lindex $file_states($current_diff_path) 0]} {
 		set s disabled
 	} else {
 		set s normal
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 40a7103..f4ab707 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -149,6 +149,7 @@ The rescan will be automatically started now.
 		_? {continue}
 		A? -
 		D? -
+		T_ -
 		M? {set files_ready 1}
 		U? {
 			error_popup [mc "Unmerged files cannot be committed.
@@ -428,6 +429,7 @@ A rescan will be automatically started now.
 		__ -
 		A_ -
 		M_ -
+		T_ -
 		D_ {
 			unset file_states($path)
 			catch {unset selected_paths($path)}
diff --git a/lib/index.tcl b/lib/index.tcl
index 3c1fce7..0a98715 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -99,6 +99,7 @@ proc write_update_indexinfo {fd pathList totalCnt batch after} {
 		switch -glob -- [lindex $s 0] {
 		A? {set new _O}
 		M? {set new _M}
+		T_ {set new _T}
 		D_ {set new _D}
 		D? {set new _?}
 		?? {continue}
@@ -162,6 +163,7 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		?D {set new D_}
 		_O -
 		AM {set new A_}
+		_T {set new T_}
 		U? {
 			if {[file exists $path]} {
 				set new M_
@@ -231,6 +233,7 @@ proc write_checkout_index {fd pathList totalCnt batch after} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
+		_T -
 		?D {
 			puts -nonewline $fd "[encoding convertto $path]\0"
 			display_file $path ?_
@@ -252,6 +255,7 @@ proc unstage_helper {txt paths} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		A? -
 		M? -
+		T_ -
 		D? {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
@@ -296,6 +300,7 @@ proc add_helper {txt paths} {
 		_O -
 		?M -
 		?D -
+		_T -
 		U? {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
@@ -336,6 +341,7 @@ proc do_add_all {} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
+		_T -
 		?D {lappend paths $path}
 		}
 	}
@@ -353,6 +359,7 @@ proc revert_helper {txt paths} {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
+		_T -
 		?D {
 			lappend pathList $path
 			if {$path eq $current_diff_path} {
-- 
1.6.0.150.gf1ade9
