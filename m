From: newren@gmail.com
Subject: [PATCH] gitk: Make more options easily accessible from Edit View dialog
Date: Mon, 23 Mar 2009 11:57:46 -0600
Message-ID: <1237831066-23554-1-git-send-email-newren@gmail.com>
References: <18887.24393.595519.320173@cargo.ozlabs.ibm.com>
Cc: git@vger.kernel.org, angavrilov@gmail.com,
	Elijah Newren <newren@gmail.com>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Mar 23 18:59:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LloR4-0001Tl-5x
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 18:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbZCWR6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 13:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbZCWR6K
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 13:58:10 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39912 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZCWR6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 13:58:08 -0400
Received: by qyk16 with SMTP id 16so2715980qyk.33
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3yD+rfXlG8F2bB/Or2gheNcPlg3+X7a3nMiFzB43/xg=;
        b=BEx26Jcl7NyduuXlSG+n51RWn1xAdQeT4iazAjb2onzW72B58esyLAb1xypqkPM4bA
         dQ+UKJT83/wwu4pOrL1lLZteKjD7H9yCxjblejG2G1gTMN0pnhnT45yWx7BK9TZuFKCS
         /7iRI5mVJLZcp4/Bv8iMq9ktMqzxyI0eOdC4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ftkepcSVkHaVbsmlDqRbFGV/NDUKQpWa8KBYn3JbIFei4TmM8utdEDmRd8+IFKx0KZ
         m4QLmOIxxLxXJgd8hiAQqd9OQVGUsCp8uKwxWYONWUrdOTQaL1SJUkerMsyHXEZSL2e7
         q6J/6wEJGhnQ3L+iqUnPcIe16DxFd2bKu5u6M=
Received: by 10.142.179.2 with SMTP id b2mr2962622wff.33.1237831082416;
        Mon, 23 Mar 2009 10:58:02 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id 22sm11719854wfg.43.2009.03.23.10.58.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 10:58:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.307.g91408
In-Reply-To: <18887.24393.595519.320173@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114339>

From: Elijah Newren <newren@gmail.com>

Commit 218a900bd8efd0d49f8a0d9491aa4786a998d4f4 added a number of new
individual fields for the Edit View dialog to make them more accessible
to end users, while still allowing all options to be specified in the
"arguments to git log" field.  This patch extends the dialog further,
to include refs, author, committer, commit message, and patch contents.
As before everything still remains accessible from the "arguments to
git log" input field.

Additionally, this provides hints for the format of the various input
fields (for example, listing some sample date strings in different
formats), and puts related query items into subsections to make it
easier to digest the number of options that exist.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 gitk-git/gitk |  131 +++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1773ae6..6c08031 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3631,17 +3631,35 @@ proc newview {ishighlight} {
 }
 
 set known_view_options {
-    {perm    b    . {}               {mc "Remember this view"}}
-    {args    t50= + {}               {mc "Commits to include (arguments to git log):"}}
-    {all     b    * "--all"          {mc "Use all refs"}}
-    {dorder  b    . {"--date-order" "-d"}      {mc "Strictly sort by date"}}
-    {lright  b    . "--left-right"   {mc "Mark branch sides"}}
-    {since   t15  + {"--since=*" "--after=*"}  {mc "Since date:"}}
-    {until   t15  . {"--until=*" "--before=*"} {mc "Until date:"}}
-    {limit   t10  + "--max-count=*"  {mc "Max count:"}}
-    {skip    t10  . "--skip=*"       {mc "Skip:"}}
-    {first   b    . "--first-parent" {mc "Limit to first parent"}}
-    {cmd     t50= + {}               {mc "Command to generate more commits to include:"}}
+    {perm      b    .  {}               {mc "Remember this view"}}
+    {reflabel  l    +  {}               {mc "References (space separated list):"}}
+    {refs      t15  .. {}               {mc "Branches & tags:"}}
+    {allrefs   b    *. "--all"          {mc "All refs"}}
+    {branches  b    .  "--branches"     {mc "All (local) branches"}}
+    {tags      b    .  "--tags"         {mc "All tags"}}
+    {remotes   b    .  "--remotes"      {mc "All remote-tracking branches"}}
+    {commitlbl l    +  {}               {mc "Commit Info (regular expressions):"}}
+    {author    t15  .. "--author=*"     {mc "Author:"}}
+    {committer t15  .  "--committer=*"  {mc "Committer:"}}
+    {loginfo   t15  .. "--grep=*"       {mc "Commit Message:"}}
+    {allmatch  b    .. "--all-match"    {mc "Matches all Commit Info criteria"}}
+    {changes_l l    +  {}               {mc "Changes to Files:"}}
+    {pickaxe_s r0   .  {}               {mc "Fixed String"}}
+    {pickaxe_t r1   .  "--pickaxe-regex"  {mc "Regular Expression"}}
+    {pickaxe   t15  .. "-S*"            {mc "Search string:"}}
+    {datelabel l    +  {}               {mc "Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2009 15:27:38\"):"}}
+    {since     t15  ..  {"--since=*" "--after=*"}  {mc "Since:"}}
+    {until     t15  .   {"--until=*" "--before=*"} {mc "Until:"}}
+    {limit_lbl l    +  {}               {mc "Limit and/or skip a number of revisions (positive integer):"}}
+    {limit     t10  *. "--max-count=*"  {mc "Number to show:"}}
+    {skip      t10  .  "--skip=*"       {mc "Number to skip:"}}
+    {misc_lbl  l    +  {}               {mc "Miscellaneous options:"}}
+    {dorder    b    *. {"--date-order" "-d"}      {mc "Strictly sort by date"}}
+    {lright    b    .  "--left-right"   {mc "Mark branch sides"}}
+    {first     b    .  "--first-parent" {mc "Limit to first parent"}}
+    {args      t50  *. {}               {mc "Additional arguments to git log:"}}
+    {allpaths  path +  {}               {mc "Enter files and directories to include, one per line:"}}
+    {cmd       t50= +  {}               {mc "Command to generate more commits to include:"}}
     }
 
 proc encode_view_opts {n} {
@@ -3653,13 +3671,19 @@ proc encode_view_opts {n} {
 	if {$patterns eq {}} continue
 	set pattern [lindex $patterns 0]
 
-	set val $newviewopts($n,[lindex $opt 0])
-	
 	if {[lindex $opt 1] eq "b"} {
+	    set val $newviewopts($n,[lindex $opt 0])
 	    if {$val} {
 		lappend rargs $pattern
 	    }
+	} elseif {[regexp {^r(\d+)$} [lindex $opt 1] type value]} {
+	    regexp {^(.*_)} [lindex $opt 0] uselessvar button_id
+	    set val $newviewopts($n,$button_id)
+	    if {$val eq $value} {
+		lappend rargs $pattern
+	    }
 	} else {
+	    set val $newviewopts($n,[lindex $opt 0])
 	    set val [string trim $val]
 	    if {$val ne {}} {
 		set pfix [string range $pattern 0 end-1]
@@ -3667,6 +3691,7 @@ proc encode_view_opts {n} {
 	    }
 	}
     }
+    set rargs [concat $rargs [shellsplit $newviewopts($n,refs)]]
     return [concat $rargs [shellsplit $newviewopts($n,args)]]
 }
 
@@ -3674,14 +3699,22 @@ proc decode_view_opts {n view_args} {
     global known_view_options newviewopts
 
     foreach opt $known_view_options {
+	set id [lindex $opt 0]
 	if {[lindex $opt 1] eq "b"} {
+	    # Checkboxes
+	    set val 0
+        } elseif {[regexp {^r(\d+)$} [lindex $opt 1]]} {
+	    # Radiobuttons
+	    regexp {^(.*_)} $id uselessvar id
 	    set val 0
 	} else {
+	    # Text fields
 	    set val {}
 	}
-	set newviewopts($n,[lindex $opt 0]) $val
+	set newviewopts($n,$id) $val
     }
     set oargs [list]
+    set refargs [list]
     foreach arg $view_args {
 	if {[regexp -- {^-([0-9]+)$} $arg arg cnt]
 	    && ![info exists found(limit)]} {
@@ -3695,11 +3728,17 @@ proc decode_view_opts {n view_args} {
 	    if {[info exists found($id)]} continue
 	    foreach pattern [lindex $opt 3] {
 		if {![string match $pattern $arg]} continue
-		if {[lindex $opt 1] ne "b"} {
+		if {[lindex $opt 1] eq "b"} {
+		    # Check buttons
+		    set val 1
+		} elseif {[regexp {^r(\d+)$} [lindex $opt 1] match num]} {
+		    # Radio buttons
+		    regexp {^(.*_)} $id uselessvar id
+		    set val $num
+		} else {
+		    # Text input fields
 		    set size [string length $pattern]
 		    set val [string range $arg [expr {$size-1}] end]
-		} else {
-		    set val 1
 		}
 		set newviewopts($n,$id) $val
 		set found($id) 1
@@ -3708,8 +3747,13 @@ proc decode_view_opts {n view_args} {
 	    if {[info exists val]} break
 	}
 	if {[info exists val]} continue
-	lappend oargs $arg
+	if {[regexp {^-} $arg]} {
+	    lappend oargs $arg
+	} else {
+	    lappend refargs $arg
+	}
     }
+    set newviewopts($n,refs) [shellarglist $refargs]
     set newviewopts($n,args) [shellarglist $oargs]
 }
 
@@ -3745,16 +3789,16 @@ proc vieweditor {top n title} {
     global known_view_options
 
     toplevel $top
-    wm title $top $title
+    wm title $top [concat $title "-- criteria for selecting revisions"]
     make_transient $top .
 
     # View name
     frame $top.nfr
-    label $top.nl -text [mc "Name"]
+    label $top.nl -text [mc "View Name:"]
     entry $top.name -width 20 -textvariable newviewname($n)
     pack $top.nfr -in $top -fill x -pady 5 -padx 3
-    pack $top.nl -in $top.nfr -side left -padx {0 30}
-    pack $top.name -in $top.nfr -side left
+    pack $top.nl -in $top.nfr -side left -padx {0 5}
+    pack $top.name -in $top.nfr -side left -padx {0 25}
 
     # View options
     set cframe $top.nfr
@@ -3773,14 +3817,28 @@ proc vieweditor {top n title} {
 	    frame $cframe
 	    pack $cframe -in $top -fill x -pady 3 -padx 3
 	    set cexpand [expr {$flags eq "*"}]
+        } elseif {$flags eq ".." || $flags eq "*."} {
+	    set cframe $top.fr$cnt
+	    incr cnt
+	    frame $cframe
+	    pack $cframe -in $top -fill x -pady 3 -padx [list 15 3]
+	    set cexpand [expr {$flags eq "*."}]
 	} else {
 	    set lxpad 5
 	}
 
-	if {$type eq "b"} {
+	if {$type eq "l"} {
+            label $cframe.l_$id -text $title
+            pack $cframe.l_$id -in $cframe -side left -pady [list 3 0] -anchor w
+	} elseif {$type eq "b"} {
 	    checkbutton $cframe.c_$id -text $title -variable newviewopts($n,$id)
 	    pack $cframe.c_$id -in $cframe -side left \
 		-padx [list $lxpad 0] -expand $cexpand -anchor w
+	} elseif {[regexp {^r(\d+)$} $type type sz]} {
+	    regexp {^(.*_)} $id uselessvar button_id
+	    radiobutton $cframe.c_$id -text $title -variable newviewopts($n,$button_id) -value $sz
+	    pack $cframe.c_$id -in $cframe -side left \
+		-padx [list $lxpad 0] -expand $cexpand -anchor w
 	} elseif {[regexp {^t(\d+)$} $type type sz]} {
 	    message $cframe.l_$id -aspect 1500 -text $title
 	    entry $cframe.e_$id -width $sz -background $bgcolor \
@@ -3793,23 +3851,22 @@ proc vieweditor {top n title} {
 		-textvariable newviewopts($n,$id)
 	    pack $cframe.l_$id -in $cframe -side top -pady [list 3 0] -anchor w
 	    pack $cframe.e_$id -in $cframe -side top -fill x
+	} elseif {$type eq "path"} {
+	    message $top.l -aspect 1500 -text $title
+	    pack $top.l -in $top -side top -pady [list 3 0] -anchor w -padx 3
+	    text $top.t -width 40 -height 5 -background $bgcolor -font uifont
+	    if {[info exists viewfiles($n)]} {
+		foreach f $viewfiles($n) {
+		    $top.t insert end $f
+		    $top.t insert end "\n"
+		}
+		$top.t delete {end - 1c} end
+		$top.t mark set insert 0.0
+	    }
+	    pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand 1 -padx 3
 	}
     }
 
-    # Path list
-    message $top.l -aspect 1500 \
-	-text [mc "Enter files and directories to include, one per line:"]
-    pack $top.l -in $top -side top -pady [list 7 0] -anchor w -padx 3
-    text $top.t -width 40 -height 5 -background $bgcolor -font uifont
-    if {[info exists viewfiles($n)]} {
-	foreach f $viewfiles($n) {
-	    $top.t insert end $f
-	    $top.t insert end "\n"
-	}
-	$top.t delete {end - 1c} end
-	$top.t mark set insert 0.0
-    }
-    pack $top.t -in $top -side top -pady [list 0 5] -fill both -expand 1 -padx 3
     frame $top.buts
     button $top.buts.ok -text [mc "OK"] -command [list newviewok $top $n]
     button $top.buts.apply -text [mc "Apply (F5)"] -command [list newviewok $top $n 1]
-- 
1.6.0.6
