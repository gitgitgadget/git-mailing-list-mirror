From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] [GITK] use "git <command>" instead of "git-<command>"
Date: Wed, 25 Jan 2006 08:56:35 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060125075635.GB2768@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 25 08:56:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1fWC-0001ut-Ts
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 08:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWAYH4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 02:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWAYH4i
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 02:56:38 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:41350 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1750780AbWAYH4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 02:56:37 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F1fW7-0000w2-U2
	for git@vger.kernel.org; Wed, 25 Jan 2006 08:56:36 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0P7uaJx003480
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 08:56:36 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0P7uZOi003479
	for git@vger.kernel.org; Wed, 25 Jan 2006 08:56:35 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15123>

Otherwise gitk is not able to work with installations using a gitexecdir
different from bindir.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 gitk |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

05f2a8c2fb8811bb78dd3c81c204e8635ca0fd83
diff --git a/gitk b/gitk
index f12b3ce..6aa340d 100755
--- a/gitk
+++ b/gitk
@@ -21,7 +21,7 @@ proc parse_args {rargs} {
 
     if [catch {
 	set parse_args [concat --default HEAD $rargs]
-	set parsed_args [split [eval exec git-rev-parse $parse_args] "\n"]
+	set parsed_args [split [eval exec git rev-parse $parse_args] "\n"]
     }] {
 	# if git-rev-parse failed for some reason...
 	if {$rargs == {}} {
@@ -40,7 +40,7 @@ proc start_rev_list {rlargs} {
     set nextupdate [expr {$startmsecs + 100}]
     set ncmupdate 1
     if [catch {
-	set commfd [open [concat | git-rev-list --header --topo-order \
+	set commfd [open [concat | git rev-list --header --topo-order \
 			      --parents $rlargs] r]
     } err] {
 	puts stderr "Error executing git-rev-list: $err"
@@ -181,7 +181,7 @@ proc doupdate {reading} {
 }
 
 proc readcommit {id} {
-    if [catch {set contents [exec git-cat-file commit $id]}] return
+    if [catch {set contents [exec git cat-file commit $id]}] return
     parsecommit $id $contents 0 {}
 }
 
@@ -242,7 +242,7 @@ proc updatecommits {rargs} {
     set phase updatecommits
     set oldcommits $commits
     set commits {}
-    set removed_commits [split [eval exec git-rev-list $ignorenew] "\n" ]
+    set removed_commits [split [eval exec git rev-list $ignorenew] "\n" ]
     if {[llength $removed_commits] > 0} {
 	allcanvs delete all
 	foreach c $removed_commits {
@@ -359,7 +359,7 @@ proc readrefs {} {
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
     }
-    set refd [open [list | git-ls-remote [gitdir]] r]
+    set refd [open [list | git ls-remote [gitdir]] r]
     while {0 <= [set n [gets $refd line]]} {
 	if {![regexp {^([0-9a-f]{40})	refs/([^^]*)$} $line \
 	    match id path]} {
@@ -376,14 +376,14 @@ proc readrefs {} {
 	    set type {}
 	    set tag {}
 	    catch {
-		set commit [exec git-rev-parse "$id^0"]
+		set commit [exec git rev-parse "$id^0"]
 		if {"$commit" != "$id"} {
 		    set tagids($name) $commit
 		    lappend idtags($commit) $name
 		}
 	    }		
 	    catch {
-	        set tagcontents($name) [exec git-cat-file tag "$id"]
+	        set tagcontents($name) [exec git cat-file tag "$id"]
 	    }
 	} elseif { $type == "heads" } {
 	    set headids($name) $id
@@ -1855,7 +1855,7 @@ proc findpatches {} {
     }
 
     if {[catch {
-	set f [open [list | git-diff-tree --stdin -s -r -S$findstring \
+	set f [open [list | git diff-tree --stdin -s -r -S$findstring \
 			 << $inputids] r]
     } err]} {
 	error_popup "Error starting search process: $err"
@@ -1958,7 +1958,7 @@ proc findfiles {} {
     # start off a git-diff-tree process if needed
     if {$diffsneeded ne {}} {
 	if {[catch {
-	    set df [open [list | git-diff-tree -r --stdin << $diffsneeded] r]
+	    set df [open [list | git diff-tree -r --stdin << $diffsneeded] r]
 	} err ]} {
 	    error_popup "Error starting search process: $err"
 	    return
@@ -2382,7 +2382,7 @@ proc findgca {ids} {
 	    set gca $id
 	} else {
 	    if {[catch {
-		set gca [exec git-merge-base $gca $id]
+		set gca [exec git merge-base $gca $id]
 	    } err]} {
 		return {}
 	    }
@@ -2470,7 +2470,7 @@ proc showmergediff {} {
     catch {unset grouphunks}
     set groupfilelast -1
     foreach p $parents($diffmergeid) {
-	set cmd [list | git-diff-tree -p $p $diffmergeid]
+	set cmd [list | git diff-tree -p $p $diffmergeid]
 	set cmd [concat $cmd $mergefilelist($diffmergeid)]
 	if {[catch {set f [open $cmd r]} err]} {
 	    error_popup "Error getting diffs: $err"
@@ -2912,7 +2912,7 @@ proc gettreediffs {ids} {
     global treediff parents treepending
     set treepending $ids
     set treediff {}
-    if [catch {set gdtf [open [concat | git-diff-tree --no-commit-id -r $ids] r]}] return
+    if [catch {set gdtf [open [concat | git diff-tree --no-commit-id -r $ids] r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
 }
@@ -2946,7 +2946,7 @@ proc getblobdiffs {ids} {
     global difffilestart nextupdate diffinhdr treediffs
 
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git-diff-tree --no-commit-id -r -p -C $ids]
+    set cmd [concat | git diff-tree --no-commit-id -r -p -C $ids]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return
@@ -3524,7 +3524,7 @@ proc mkpatchgo {} {
     set oldid [$patchtop.fromsha1 get]
     set newid [$patchtop.tosha1 get]
     set fname [$patchtop.fname get]
-    if {[catch {exec git-diff-tree -p $oldid $newid >$fname &} err]} {
+    if {[catch {exec git diff-tree -p $oldid $newid >$fname &} err]} {
 	error_popup "Error creating patch: $err"
     }
     catch {destroy $patchtop}
@@ -4090,11 +4090,11 @@ proc tcl_encoding {enc} {
 # defaults...
 set datemode 0
 set diffopts "-U 5 -p"
-set wrcomcmd "git-diff-tree --stdin -p --pretty"
+set wrcomcmd "git diff-tree --stdin -p --pretty"
 
 set gitencoding {}
 catch {
-    set gitencoding [exec git-repo-config --get i18n.commitencoding]
+    set gitencoding [exec git repo-config --get i18n.commitencoding]
 }
 if {$gitencoding == ""} {
     set gitencoding "utf-8"
-- 
1.1.4.g2eaa

-- 
Uwe Zeisberger

dd if=/proc/self/exe bs=1 skip=1 count=3 2>/dev/null
