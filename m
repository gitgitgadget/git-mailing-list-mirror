From: newren@gmail.com
Subject: [RFC with a proof of concept PATCH] Add Bonsai-like query options to gitk
Date: Mon,  9 Mar 2009 13:42:27 -0600
Message-ID: <1236627747-32107-1-git-send-email-newren@gmail.com>
Cc: angavrilov@gmail.com, paulus@samba.org,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 20:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LglOX-0005eq-KC
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 20:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZCITmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZCITmp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 15:42:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:41813 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZCITmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 15:42:44 -0400
Received: by wa-out-1112.google.com with SMTP id v33so1048819wah.21
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 12:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=SczwI1jwlcI/f1EDbZilzk4iwXeHeMgl5wQ8QQLWGtI=;
        b=UhH59iBFHiZso0FEL8FkyoCHtYrhlEnGg3Bxp89FX0rp3dLE9PaVrdF+1zmB2O7U0h
         l5xPUXZyi9hIM1Qi+kL4CnLRTBg0le6Vh0WoyfloG6UBf2SdEdnsPUEsJVx546lh04Hy
         Fylp0L0VneW2d+SWfa89JEfn8iTX5olkLdD2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WRCSzfKd8XcQVO7lNOIL4Bzy0gOrIJC4rizJmedDeoUbZySp5vCOa2M0KcGbodCkfl
         PvKq1+1CRyubNRPpuEPsyAxCl1Apn2ZACca2cC5pbhudgW8D9KywTzb24qa05TiAQMDM
         1o3jCLn91XowCZKjIcpg4p24hviv1ceJo25nA=
Received: by 10.114.95.12 with SMTP id s12mr3701978wab.223.1236627762376;
        Mon, 09 Mar 2009 12:42:42 -0700 (PDT)
Received: from localhost.localdomain (c-69-254-130-124.hsd1.nm.comcast.net [69.254.130.124])
        by mx.google.com with ESMTPS id z20sm806618pod.12.2009.03.09.12.42.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Mar 2009 12:42:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.95.g934f7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112734>

From: Elijah Newren <newren@gmail.com>

Hi,

(If you like screenshots, I've got some before & after ones up at
http://www.gnome.org/~newren/temp/gitk/gitk-edit-view.html, but
remember that this is just a proof of concept and call for comments.)

I've talked a little bit with the Trilinos project[1] about git.  One
issue that has come up is that they need a replacement for Bonsai (see
http://bonsai.mozilla.org/cvsqueryform.cgi).  When I pointed out git
log and its many option, I was told that they wanted something that
would only be used infrequently by any given individual, and thus they
wanted something that didn't require memorizing or looking up command
line options.  gitk, particularly the View->Edit View menu option,
looks like a step in the right direction.  I'm guessing that with a
tweak or two, it could probably satisfy this use case.  The issues I
see are:
  * many important options (--author, --grep, -S, --pickaxe-regex) are
    still selected in gitk by typing in command line options into the
    appropriate box
  * the format of some fields is not clear; examples: (1) it is not
    clear which date format is acceptable, and (2) it is not clear
    that the "Skip" field takes integers as input.

My below proof of concept patch:
  * Adds options for selecting revisions based on branch/tag names,
    author, committer, commit message, and patch contents (technically
    this was all available before, but only if you were familiar with
    the command line options to git log)
  * Provides hints for input format (for example, lists some sample
    date strings in a few different formats)
  * Puts related query items into subsections, to make it easier to
    digest the sheer number of options that now exist
  * Rearranges the previous dialog options due to the above changes

Potential issues with my patch:
  * Maybe this is the wrong place to put Bonsai-like querying and I
    should look at gitweb or cgit instead (while I personally like
    client-side solutions, maybe others won't?)  Further, this may
    push gitk in a way that others don't like.
  * I'm pretty sure I broke the view remembering feature.  I can work
    on fixing this up if people generally like the idea behind the
    patch.
  * Is this dialog too overwhelming or too large now?
  * My lack of Tcl/Tk skills, and UI design skills.


Elijah

[1] http://trilinos.sandia.gov/  I'm not part of the Trilinos project;
I'm just a co-worker.
---
 gitk-git/gitk |   95 +++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1773ae6..79f18b5 100644
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
@@ -3659,6 +3677,11 @@ proc encode_view_opts {n} {
 	    if {$val} {
 		lappend rargs $pattern
 	    }
+	} elseif {[regexp {^r(\d+)$} [lindex $opt 1] type value]} {
+            regexp {^(.*_)} [lindex $opt 0] uselessvar button_id
+	    if {$newviewopts($n,$button_id) eq $value} {
+		lappend rargs $pattern
+	    }
 	} else {
 	    set val [string trim $val]
 	    if {$val ne {}} {
@@ -3667,6 +3690,7 @@ proc encode_view_opts {n} {
 	    }
 	}
     }
+    set rargs [concat $rargs [shellsplit $newviewopts($n,refs)]]
     return [concat $rargs [shellsplit $newviewopts($n,args)]]
 }
 
@@ -3757,6 +3781,11 @@ proc vieweditor {top n title} {
     pack $top.name -in $top.nfr -side left
 
     # View options
+    frame $top.ifr
+    label $top.il -text [mc "* Please specify criteria for selecting revisions to view * "]
+    pack $top.il -anchor center
+
+    # View options
     set cframe $top.nfr
     set cexpand 0
     set cnt 0
@@ -3773,14 +3802,29 @@ proc vieweditor {top n title} {
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
+            regexp {^(.*_)} $id uselessvar button_id
+	    set newviewopts($n,$button_id) 0
+	    radiobutton $cframe.c_$id -text $title -variable newviewopts($n,$button_id) -value $sz
+	    pack $cframe.c_$id -in $cframe -side left \
+		-padx [list $lxpad 0] -expand $cexpand -anchor w
 	} elseif {[regexp {^t(\d+)$} $type type sz]} {
 	    message $cframe.l_$id -aspect 1500 -text $title
 	    entry $cframe.e_$id -width $sz -background $bgcolor \
@@ -3793,23 +3837,22 @@ proc vieweditor {top n title} {
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
1.6.2.95.g934f7
