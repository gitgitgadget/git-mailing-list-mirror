From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH 3/9] gitk i18n implementation: Markup many strings for translation.
Date: Wed, 7 Nov 2007 18:42:55 +0100
Message-ID: <200711071842.55975.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <200711071840.59972.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 18:16:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpoVa-0002wH-6I
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 18:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758765AbXKGRPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbXKGRPw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 12:15:52 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:45952 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758714AbXKGRPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 12:15:49 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HEK8K018134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 18:14:20 +0100
Received: from [192.168.2.102] (p549012B6.dip0.t-ipconnect.de [84.144.18.182])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7HEIGX003941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 18:14:19 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <200711071840.59972.stimming@tuhh.de>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63836>

---
This patch should intentionally markup only those strings that aren't u=
sed
in any peculiar way, but are just plain strings. The more involved stri=
ngs
in optionmenu widgets will come in a separate patch.

 gitk |  401=20
+++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 201 insertions(+), 200 deletions(-)

diff --git a/gitk b/gitk
index 629acfb..e291577 100755
--- a/gitk
+++ b/gitk
@@ -98,7 +98,7 @@ proc start_rev_list {view} {
 	set fd [open [concat | git log --no-color -z --pretty=3Draw $order --=
parents \
 			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
     } err]} {
-	error_popup "Error executing git rev-list: $err"
+	error_popup "[mc "Error executing git rev-list:"] $err"
 	exit 1
     }
     set commfd($view) $fd
@@ -111,7 +111,7 @@ proc start_rev_list {view} {
 	fconfigure $fd -encoding $tclencoding
     }
     filerun $fd [list getcommitlines $fd $view]
-    nowbusy $view "Reading"
+    nowbusy $view [mc "Reading"]
     if {$view =3D=3D $curview} {
 	set progressdirn 1
 	set progresscoords {0 0}
@@ -138,7 +138,7 @@ proc getcommits {} {
     set phase getcommits
     initlayout
     start_rev_list $curview
-    show_status "Reading commits..."
+    show_status [mc "Reading commits..."]
 }
=20
 # This makes a string representation of a positive integer which
@@ -261,7 +261,7 @@ proc getcommitlines {fd view}  {
 	    if {[string length $shortcmit] > 80} {
 		set shortcmit "[string range $shortcmit 0 80]..."
 	    }
-	    error_popup "Can't parse git log output: {$shortcmit}"
+	    error_popup "[mc "Can't parse git log output:"] {$shortcmit}"
 	    exit 1
 	}
 	set id [lindex $ids 0]
@@ -372,7 +372,7 @@ proc chewcommits {view} {
 		#set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
 		#puts "overall $ms ms for $numcommits commits"
 	    } else {
-		show_status "No commits selected"
+		show_status [mc "No commits selected"]
 	    }
 	    notbusy layout
 	    set phase {}
@@ -483,7 +483,7 @@ proc getcommit {id} {
     } else {
 	readcommit $id
 	if {![info exists commitinfo($id)]} {
-	    set commitinfo($id) {"No commit information available"}
+	    set commitinfo($id) [list [mc "No commit information available"]]
 	}
     }
     return 1
@@ -582,7 +582,7 @@ proc removehead {id name} {
 proc show_error {w top msg} {
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text OK -command "destroy $top"
+    button $w.ok -text [mc OK] -command "destroy $top"
     pack $w.ok -side bottom -fill x
     bind $top <Visibility> "grab $top; focus $top"
     bind $top <Key-Return> "destroy $top"
@@ -604,9 +604,9 @@ proc confirm_popup msg {
     wm transient $w .
     message $w.m -text $msg -justify center -aspect 400
     pack $w.m -side top -fill x -padx 20 -pady 20
-    button $w.ok -text OK -command "set confirm_ok 1; destroy $w"
+    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x
-    button $w.cancel -text Cancel -command "destroy $w"
+    button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x
     bind $w <Visibility> "grab $w; focus $w"
     tkwait window $w
@@ -630,33 +630,33 @@ proc makewindow {} {
     global have_tk85
=20
     menu .bar
-    .bar add cascade -label "File" -menu .bar.file
+    .bar add cascade -label [mc "File"] -menu .bar.file
     .bar configure -font uifont
     menu .bar.file
-    .bar.file add command -label "Update" -command updatecommits
-    .bar.file add command -label "Reread references" -command rereadre=
fs
-    .bar.file add command -label "List references" -command showrefs
-    .bar.file add command -label "Quit" -command doquit
+    .bar.file add command -label [mc "Update"] -command updatecommits
+    .bar.file add command -label [mc "Reread references"] -command rer=
eadrefs
+    .bar.file add command -label [mc "List references"] -command showr=
efs
+    .bar.file add command -label [mc "Quit"] -command doquit
     .bar.file configure -font uifont
     menu .bar.edit
-    .bar add cascade -label "Edit" -menu .bar.edit
-    .bar.edit add command -label "Preferences" -command doprefs
+    .bar add cascade -label [mc "Edit"] -menu .bar.edit
+    .bar.edit add command -label [mc "Preferences"] -command doprefs
     .bar.edit configure -font uifont
=20
     menu .bar.view -font uifont
-    .bar add cascade -label "View" -menu .bar.view
-    .bar.view add command -label "New view..." -command {newview 0}
-    .bar.view add command -label "Edit view..." -command editview \
+    .bar add cascade -label [mc "View"] -menu .bar.view
+    .bar.view add command -label [mc "New view..."] -command {newview =
0}
+    .bar.view add command -label [mc "Edit view..."] -command editview=
 \
 	-state disabled
-    .bar.view add command -label "Delete view" -command delview -state=
=20
disabled
+    .bar.view add command -label [mc "Delete view"] -command delview -=
state=20
disabled
     .bar.view add separator
-    .bar.view add radiobutton -label "All files" -command {showview 0}=
 \
+    .bar.view add radiobutton -label [mc "All files"] -command {showvi=
ew 0} \
 	-variable selectedview -value 0
=20
     menu .bar.help
-    .bar add cascade -label "Help" -menu .bar.help
-    .bar.help add command -label "About gitk" -command about
-    .bar.help add command -label "Key bindings" -command keys
+    .bar add cascade -label [mc "Help"] -menu .bar.help
+    .bar.help add command -label [mc "About gitk"] -command about
+    .bar.help add command -label [mc "Key bindings"] -command keys
     .bar.help configure -font uifont
     . configure -menu .bar
=20
@@ -713,7 +713,7 @@ proc makewindow {} {
     set sha1entry .tf.bar.sha1
     set entries $sha1entry
     set sha1but .tf.bar.sha1label
-    button $sha1but -text "SHA1 ID: " -state disabled -relief flat \
+    button $sha1but -text [mc "SHA1 ID: "] -state disabled -relief fla=
t \
 	-command gotocommit -width 8 -font uifont
     $sha1but conf -disabledforeground [$sha1but cget -foreground]
     pack .tf.bar.sha1label -side left
@@ -763,10 +763,10 @@ proc makewindow {} {
     set progupdatepending 0
=20
     # build up the bottom bar of upper window
-    label .tf.lbar.flabel -text "Find " -font uifont
-    button .tf.lbar.fnext -text "next" -command {dofind 1 1} -font uif=
ont
-    button .tf.lbar.fprev -text "prev" -command {dofind -1 1} -font ui=
font
-    label .tf.lbar.flab2 -text " commit " -font uifont
+    label .tf.lbar.flabel -text "[mc "Find"] " -font uifont
+    button .tf.lbar.fnext -text [mc "next"] -command {dofind 1 1} -fon=
t=20
uifont
+    button .tf.lbar.fprev -text [mc "prev"] -command {dofind -1 1} -fo=
nt=20
uifont
+    label .tf.lbar.flab2 -text " [mc "commit"] " -font uifont
     pack .tf.lbar.flabel .tf.lbar.fnext .tf.lbar.fprev .tf.lbar.flab2 =
\
 	-side left -fill y
     set gdttype "containing:"
@@ -822,7 +822,7 @@ proc makewindow {} {
     frame .bleft.top
     frame .bleft.mid
=20
-    button .bleft.top.search -text "Search" -command dosearch \
+    button .bleft.top.search -text [mc "Search"] -command dosearch \
 	-font uifont
     pack .bleft.top.search -side left -padx 5
     set sstring .bleft.top.sstring
@@ -830,13 +830,13 @@ proc makewindow {} {
     lappend entries $sstring
     trace add variable searchstring write incrsearch
     pack $sstring -side left -expand 1 -fill x
-    radiobutton .bleft.mid.diff -text "Diff" -font uifont \
+    radiobutton .bleft.mid.diff -text [mc "Diff"] -font uifont \
 	-command changediffdisp -variable diffelide -value {0 0}
-    radiobutton .bleft.mid.old -text "Old version" -font uifont \
+    radiobutton .bleft.mid.old -text [mc "Old version"] -font uifont \
 	-command changediffdisp -variable diffelide -value {0 1}
-    radiobutton .bleft.mid.new -text "New version" -font uifont \
+    radiobutton .bleft.mid.new -text [mc "New version"] -font uifont \
 	-command changediffdisp -variable diffelide -value {1 0}
-    label .bleft.mid.labeldiffcontext -text "      Lines of context: "=
 \
+    label .bleft.mid.labeldiffcontext -text "      [mc "Lines of conte=
xt"]: "=20
\
 	-font uifont
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     spinbox .bleft.mid.diffcontext -width 5 -font textfont \
@@ -895,10 +895,10 @@ proc makewindow {} {
     # lower right
     frame .bright
     frame .bright.mode
-    radiobutton .bright.mode.patch -text "Patch" \
+    radiobutton .bright.mode.patch -text [mc "Patch"] \
 	-command reselectline -variable cmitmode -value "patch"
     .bright.mode.patch configure -font uifont
-    radiobutton .bright.mode.tree -text "Tree" \
+    radiobutton .bright.mode.tree -text [mc "Tree"] \
 	-command reselectline -variable cmitmode -value "tree"
     .bright.mode.tree configure -font uifont
     grid .bright.mode.patch .bright.mode.tree -sticky ew
@@ -1015,43 +1015,43 @@ proc makewindow {} {
=20
     set rowctxmenu .rowctxmenu
     menu $rowctxmenu -tearoff 0
-    $rowctxmenu add command -label "Diff this -> selected" \
+    $rowctxmenu add command -label [mc "Diff this -> selected"] \
 	-command {diffvssel 0}
-    $rowctxmenu add command -label "Diff selected -> this" \
+    $rowctxmenu add command -label [mc "Diff selected -> this"] \
 	-command {diffvssel 1}
-    $rowctxmenu add command -label "Make patch" -command mkpatch
-    $rowctxmenu add command -label "Create tag" -command mktag
-    $rowctxmenu add command -label "Write commit to file" -command=20
writecommit
-    $rowctxmenu add command -label "Create new branch" -command mkbran=
ch
-    $rowctxmenu add command -label "Cherry-pick this commit" \
+    $rowctxmenu add command -label [mc "Make patch"] -command mkpatch
+    $rowctxmenu add command -label [mc "Create tag"] -command mktag
+    $rowctxmenu add command -label [mc "Write commit to file"] -comman=
d=20
writecommit
+    $rowctxmenu add command -label [mc "Create new branch"] -command m=
kbranch
+    $rowctxmenu add command -label [mc "Cherry-pick this commit"] \
 	-command cherrypick
-    $rowctxmenu add command -label "Reset HEAD branch to here" \
+    $rowctxmenu add command -label [mc "Reset HEAD branch to here"] \
 	-command resethead
=20
     set fakerowmenu .fakerowmenu
     menu $fakerowmenu -tearoff 0
-    $fakerowmenu add command -label "Diff this -> selected" \
+    $fakerowmenu add command -label [mc "Diff this -> selected"] \
 	-command {diffvssel 0}
-    $fakerowmenu add command -label "Diff selected -> this" \
+    $fakerowmenu add command -label [mc "Diff selected -> this"] \
 	-command {diffvssel 1}
-    $fakerowmenu add command -label "Make patch" -command mkpatch
-#    $fakerowmenu add command -label "Commit" -command {mkcommit 0}
-#    $fakerowmenu add command -label "Commit all" -command {mkcommit 1=
}
-#    $fakerowmenu add command -label "Revert local changes" -command=20
revertlocal
+    $fakerowmenu add command -label [mc "Make patch"] -command mkpatch
+#    $fakerowmenu add command -label [mc "Commit"] -command {mkcommit =
0}
+#    $fakerowmenu add command -label [mc "Commit all"] -command {mkcom=
mit 1}
+#    $fakerowmenu add command -label [mc "Revert local changes"] -comm=
and=20
revertlocal
=20
     set headctxmenu .headctxmenu
     menu $headctxmenu -tearoff 0
-    $headctxmenu add command -label "Check out this branch" \
+    $headctxmenu add command -label [mc "Check out this branch"] \
 	-command cobranch
-    $headctxmenu add command -label "Remove this branch" \
+    $headctxmenu add command -label [mc "Remove this branch"] \
 	-command rmbranch
=20
     global flist_menu
     set flist_menu .flistctxmenu
     menu $flist_menu -tearoff 0
-    $flist_menu add command -label "Highlight this too" \
+    $flist_menu add command -label [mc "Highlight this too"] \
 	-command {flist_hl 0}
-    $flist_menu add command -label "Highlight this only" \
+    $flist_menu add command -label [mc "Highlight this only"] \
 	-command {flist_hl 1}
 }
=20
@@ -1277,17 +1277,17 @@ proc about {} {
 	return
     }
     toplevel $w
-    wm title $w "About gitk"
-    message $w.m -text {
+    wm title $w [mc "About gitk"]
+    message $w.m -text [mc "
 Gitk - a commit viewer for git
=20
 Copyright =A9 2005-2006 Paul Mackerras
=20
-Use and redistribute under the terms of the GNU General Public License=
} \
+Use and redistribute under the terms of the GNU General Public License=
"] \
 	    -justify center -aspect 400 -border 2 -bg white -relief groove
     pack $w.m -side top -fill x -padx 2 -pady 2
     $w.m configure -font uifont
-    button $w.ok -text Close -command "destroy $w" -default active
+    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
     pack $w.ok -side bottom
     $w.ok configure -font uifont
     bind $w <Visibility> "focus $w.ok"
@@ -1308,8 +1308,8 @@ proc keys {} {
 	set M1T Ctrl
     }
     toplevel $w
-    wm title $w "Gitk key bindings"
-    message $w.m -text "
+    wm title $w [mc "Gitk key bindings"]
+    message $w.m -text [mc "
 Gitk key bindings:
=20
 <$M1T-Q>		Quit
@@ -1347,11 +1347,11 @@ f		Scroll diff view to next file
 <$M1T-KP->	Decrease font size
 <$M1T-minus>	Decrease font size
 <F5>		Update
-" \
+"] \
 	    -justify left -bg white -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
     $w.m configure -font uifont
-    button $w.ok -text Close -command "destroy $w" -default active
+    button $w.ok -text [mc "Close"] -command "destroy $w" -default act=
ive
     pack $w.ok -side bottom
     $w.ok configure -font uifont
     bind $w <Visibility> "focus $w.ok"
@@ -1860,7 +1860,7 @@ proc newview {ishighlight} {
     set newviewname($nextviewnum) "View $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
-    vieweditor $top $nextviewnum "Gitk view definition"
+    vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
=20
 proc editview {} {
@@ -1885,20 +1885,20 @@ proc vieweditor {top n title} {
=20
     toplevel $top
     wm title $top $title
-    label $top.nl -text "Name" -font uifont
+    label $top.nl -text [mc "Name"] -font uifont
     entry $top.name -width 20 -textvariable newviewname($n) -font uifo=
nt
     grid $top.nl $top.name -sticky w -pady 5
-    checkbutton $top.perm -text "Remember this view" -variable=20
newviewperm($n) \
+    checkbutton $top.perm -text [mc "Remember this view"] -variable=20
newviewperm($n) \
 	-font uifont
     grid $top.perm - -pady 5 -sticky w
     message $top.al -aspect 1000 -font uifont \
-	-text "Commits to include (arguments to git rev-list):"
+	-text [mc "Commits to include (arguments to git rev-list):"]
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
 	-background white -font uifont
     grid $top.args - -sticky ew -padx 5
     message $top.l -aspect 1000 -font uifont \
-	-text "Enter files and directories to include, one per line:"
+	-text [mc "Enter files and directories to include, one per line:"]
     grid $top.l - -sticky w
     text $top.t -width 40 -height 10 -background white -font uifont
     if {[info exists viewfiles($n)]} {
@@ -1911,9 +1911,9 @@ proc vieweditor {top n title} {
     }
     grid $top.t - -sticky ew -padx 5
     frame $top.buts
-    button $top.buts.ok -text "OK" -command [list newviewok $top $n] \
+    button $top.buts.ok -text [mc "OK"] -command [list newviewok $top =
$n] \
 	-font uifont
-    button $top.buts.can -text "Cancel" -command [list destroy $top] \
+    button $top.buts.can -text [mc "Cancel"] -command [list destroy $t=
op] \
 	-font uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -1947,7 +1947,7 @@ proc newviewok {top n} {
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
     } err]} {
-	error_popup "Error in commit selection arguments: $err"
+	error_popup "[mc "Error in commit selection arguments:"] $err"
 	wm raise $top
 	focus $top
 	return
@@ -2090,8 +2090,8 @@ proc showview {n} {
=20
     set curview $n
     set selectedview $n
-    .bar.view entryconf Edit* -state [expr {$n =3D=3D 0? "disabled": "=
normal"}]
-    .bar.view entryconf Delete* -state [expr {$n =3D=3D 0? "disabled":=
 "normal"}]
+    .bar.view entryconf [mc "Edit view..."] -state [expr {$n =3D=3D=20
0? "disabled": "normal"}]
+    .bar.view entryconf [mc "Delete view"] -state [expr {$n =3D=3D=20
0? "disabled": "normal"}]
=20
     run refill_reflist
     if {![info exists viewdata($n)]} {
@@ -2148,11 +2148,11 @@ proc showview {n} {
     }
     if {$phase ne {}} {
 	if {$phase eq "getcommits"} {
-	    show_status "Reading commits..."
+	    show_status [mc "Reading commits..."]
 	}
 	run chewcommits $n
     } elseif {$numcommits =3D=3D 0} {
-	show_status "No commits selected"
+	show_status [mc "No commits selected"]
     }
 }
=20
@@ -2880,7 +2880,7 @@ proc readdiffindex {fd serial} {
     if {$isdiff && $serial =3D=3D $lserial && $localirow =3D=3D -1} {
 	# add the line for the changes in the index to the graph
 	set localirow $commitrow($curview,$mainheadid)
-	set hl "Local changes checked in to index but not committed"
+	set hl [mc "Local changes checked in to index but not committed"]
 	set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
 	set commitdata($nullid2) "\n    $hl\n"
 	insertrow $localirow $nullid2
@@ -2910,7 +2910,7 @@ proc readdifffiles {fd serial} {
 	} else {
 	    set localfrow $commitrow($curview,$mainheadid)
 	}
-	set hl "Local uncommitted changes, not checked in to index"
+	set hl [mc "Local uncommitted changes, not checked in to index"]
 	set commitinfo($nullid) [list  $hl {} {} {} {} "    $hl\n"]
 	set commitdata($nullid) "\n    $hl\n"
 	insertrow $localfrow $nullid
@@ -4716,11 +4716,11 @@ proc selectline {l isnew} {
     set linknum 0
     set info $commitinfo($id)
     set date [formatdate [lindex $info 2]]
-    $ctext insert end "Author: [lindex $info 1]  $date\n"
+    $ctext insert end "[mc "Author"]: [lindex $info 1]  $date\n"
     set date [formatdate [lindex $info 4]]
-    $ctext insert end "Committer: [lindex $info 3]  $date\n"
+    $ctext insert end "[mc "Committer"]: [lindex $info 3]  $date\n"
     if {[info exists idtags($id)]} {
-	$ctext insert end "Tags:"
+	$ctext insert end [mc "Tags:"]
 	foreach tag $idtags($id) {
 	    $ctext insert end " $tag"
 	}
@@ -4737,18 +4737,18 @@ proc selectline {l isnew} {
 	    } else {
 		set tag m$np
 	    }
-	    $ctext insert end "Parent: " $tag
+	    $ctext insert end "[mc "Parent"]: " $tag
 	    appendwithlinks [commit_descriptor $p] {}
 	    incr np
 	}
     } else {
 	foreach p $olds {
-	    append headers "Parent: [commit_descriptor $p]"
+	    append headers "[mc "Parent"]: [commit_descriptor $p]"
 	}
     }
=20
     foreach c $children($curview,$id) {
-	append headers "Child:  [commit_descriptor $c]"
+	append headers "[mc "Child"]:  [commit_descriptor $c]"
     }
=20
     # make anything that looks like a SHA1 ID be a clickable link
@@ -4757,13 +4757,13 @@ proc selectline {l isnew} {
 	if {![info exists allcommits]} {
 	    getallcommits
 	}
-	$ctext insert end "Branch: "
+	$ctext insert end "[mc "Branch"]: "
 	$ctext mark set branch "end -1c"
 	$ctext mark gravity branch left
-	$ctext insert end "\nFollows: "
+	$ctext insert end "\n[mc "Follows"]: "
 	$ctext mark set follows "end -1c"
 	$ctext mark gravity follows left
-	$ctext insert end "\nPrecedes: "
+	$ctext insert end "\n[mc "Precedes"]: "
 	$ctext mark set precedes "end -1c"
 	$ctext mark gravity precedes left
 	$ctext insert end "\n"
@@ -5045,7 +5045,7 @@ proc mergediff {id l} {
 	set cmd [concat $cmd -- $viewfiles($curview)]
     }
     if {[catch {set mdf [open $cmd r]} err]} {
-	error_popup "Error getting merge diffs: $err"
+	error_popup "[mc "Error getting merge diffs:"] $err"
 	return
     }
     fconfigure $mdf -blocking 0
@@ -5722,9 +5722,9 @@ proc sha1change {n1 n2 op} {
     }
     if {[$sha1but cget -state] =3D=3D $state} return
     if {$state =3D=3D "normal"} {
-	$sha1but conf -state normal -relief raised -text "Goto: "
+	$sha1but conf -state normal -relief raised -text "[mc "Goto:"] "
     } else {
-	$sha1but conf -state disabled -relief flat -text "SHA1 ID: "
+	$sha1but conf -state disabled -relief flat -text "[mc "SHA1 ID:"] "
     }
 }
=20
@@ -5749,7 +5749,7 @@ proc gotocommit {} {
 	    }
 	    if {$matches ne {}} {
 		if {[llength $matches] > 1} {
-		    error_popup "Short SHA1 id $id is ambiguous"
+		    error_popup [mc "Short SHA1 id %s is ambiguous" $id]
 		    return
 		}
 		set id [lindex $matches 0]
@@ -5761,11 +5761,11 @@ proc gotocommit {} {
 	return
     }
     if {[regexp {^[0-9a-fA-F]{4,}$} $sha1string]} {
-	set type "SHA1 id"
+	set msg [mc "SHA1 id %s is not known" $sha1string]
     } else {
-	set type "Tag/Head"
+	set msg [mc "Tag/Head %s is not known" $sha1string]
     }
-    error_popup "$type $sha1string is not known"
+    error_popup $msg
 }
=20
 proc lineenter {x y id} {
@@ -5895,17 +5895,17 @@ proc lineclick {x y id isnew} {
     $ctext conf -state normal
     clear_ctext
     settabs 0
-    $ctext insert end "Parent:\t"
+    $ctext insert end "[mc "Parent"]:\t"
     $ctext insert end $id link0
     setlink $id link0
     set info $commitinfo($id)
     $ctext insert end "\n\t[lindex $info 0]\n"
-    $ctext insert end "\tAuthor:\t[lindex $info 1]\n"
+    $ctext insert end "\t[mc "Author"]:\t[lindex $info 1]\n"
     set date [formatdate [lindex $info 2]]
-    $ctext insert end "\tDate:\t$date\n"
+    $ctext insert end "\t[mc "Date"]:\t$date\n"
     set kids $children($curview,$id)
     if {$kids ne {}} {
-	$ctext insert end "\nChildren:"
+	$ctext insert end "\n[mc "Children"]:"
 	set i 0
 	foreach child $kids {
 	    incr i
@@ -5915,9 +5915,9 @@ proc lineclick {x y id isnew} {
 	    $ctext insert end $child link$i
 	    setlink $child link$i
 	    $ctext insert end "\n\t[lindex $info 0]"
-	    $ctext insert end "\n\tAuthor:\t[lindex $info 1]"
+	    $ctext insert end "\n\t[mc "Author"]:\t[lindex $info 1]"
 	    set date [formatdate [lindex $info 2]]
-	    $ctext insert end "\n\tDate:\t$date\n"
+	    $ctext insert end "\n\t[mc "Date"]:\t$date\n"
 	}
     }
     $ctext conf -state disabled
@@ -5962,13 +5962,13 @@ proc rowmenu {x y id} {
     }
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
-	$menu entryconfigure 7 -label "Reset $mainhead branch to here"
+	$menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead=
]
     } else {
 	set menu $fakerowmenu
     }
-    $menu entryconfigure "Diff this*" -state $state
-    $menu entryconfigure "Diff selected*" -state $state
-    $menu entryconfigure "Make patch" -state $state
+    $menu entryconfigure [mc "Diff this -> selected"] -state $state
+    $menu entryconfigure [mc "Diff selected -> this"] -state $state
+    $menu entryconfigure [mc "Make patch"] -state $state
     tk_popup $menu $x $y
 }
=20
@@ -5993,13 +5993,13 @@ proc doseldiff {oldid newid} {
=20
     $ctext conf -state normal
     clear_ctext
-    init_flist "Top"
-    $ctext insert end "From "
+    init_flist [mc "Top"]
+    $ctext insert end "[mc "From"] "
     $ctext insert end $oldid link0
     setlink $oldid link0
     $ctext insert end "\n     "
     $ctext insert end [lindex $commitinfo($oldid) 0]
-    $ctext insert end "\n\nTo   "
+    $ctext insert end "\n\n[mc "To"]   "
     $ctext insert end $newid link1
     setlink $newid link1
     $ctext insert end "\n     "
@@ -6022,9 +6022,9 @@ proc mkpatch {} {
     set patchtop $top
     catch {destroy $top}
     toplevel $top
-    label $top.title -text "Generate patch"
+    label $top.title -text [mc "Generate patch"]
     grid $top.title - -pady 10
-    label $top.from -text "From:"
+    label $top.from -text [mc "From:"]
     entry $top.fromsha1 -width 40 -relief flat
     $top.fromsha1 insert 0 $oldid
     $top.fromsha1 conf -state readonly
@@ -6033,7 +6033,7 @@ proc mkpatch {} {
     $top.fromhead insert 0 $oldhead
     $top.fromhead conf -state readonly
     grid x $top.fromhead -sticky w
-    label $top.to -text "To:"
+    label $top.to -text [mc "To:"]
     entry $top.tosha1 -width 40 -relief flat
     $top.tosha1 insert 0 $newid
     $top.tosha1 conf -state readonly
@@ -6042,16 +6042,16 @@ proc mkpatch {} {
     $top.tohead insert 0 $newhead
     $top.tohead conf -state readonly
     grid x $top.tohead -sticky w
-    button $top.rev -text "Reverse" -command mkpatchrev -padx 5
+    button $top.rev -text [mc "Reverse"] -command mkpatchrev -padx 5
     grid $top.rev x -pady 10
-    label $top.flab -text "Output file:"
+    label $top.flab -text [mc "Output file:"]
     entry $top.fname -width 60
     $top.fname insert 0 [file normalize "patch$patchnum.patch"]
     incr patchnum
     grid $top.flab $top.fname -sticky w
     frame $top.buts
-    button $top.buts.gen -text "Generate" -command mkpatchgo
-    button $top.buts.can -text "Cancel" -command mkpatchcan
+    button $top.buts.gen -text [mc "Generate"] -command mkpatchgo
+    button $top.buts.can -text [mc "Cancel"] -command mkpatchcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -6086,7 +6086,7 @@ proc mkpatchgo {} {
     set cmd [lrange $cmd 1 end]
     lappend cmd >$fname &
     if {[catch {eval exec $cmd} err]} {
-	error_popup "Error creating patch: $err"
+	error_popup "[mc "Error creating patch:"] $err"
     }
     catch {destroy $patchtop}
     unset patchtop
@@ -6106,9 +6106,9 @@ proc mktag {} {
     set mktagtop $top
     catch {destroy $top}
     toplevel $top
-    label $top.title -text "Create tag"
+    label $top.title -text [mc "Create tag"]
     grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
     entry $top.sha1 -width 40 -relief flat
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
@@ -6117,12 +6117,12 @@ proc mktag {} {
     $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
     $top.head conf -state readonly
     grid x $top.head -sticky w
-    label $top.tlab -text "Tag name:"
+    label $top.tlab -text [mc "Tag name:"]
     entry $top.tag -width 60
     grid $top.tlab $top.tag -sticky w
     frame $top.buts
-    button $top.buts.gen -text "Create" -command mktaggo
-    button $top.buts.can -text "Cancel" -command mktagcan
+    button $top.buts.gen -text [mc "Create"] -command mktaggo
+    button $top.buts.can -text [mc "Cancel"] -command mktagcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -6136,11 +6136,11 @@ proc domktag {} {
     set id [$mktagtop.sha1 get]
     set tag [$mktagtop.tag get]
     if {$tag =3D=3D {}} {
-	error_popup "No tag name specified"
+	error_popup [mc "No tag name specified"]
 	return
     }
     if {[info exists tagids($tag)]} {
-	error_popup "Tag \"$tag\" already exists"
+	error_popup [mc "Tag \"%s\" already exists" $tag]
 	return
     }
     if {[catch {
@@ -6150,7 +6150,7 @@ proc domktag {} {
 	puts $f $id
 	close $f
     } err]} {
-	error_popup "Error creating tag: $err"
+	error_popup "[mc "Error creating tag:"] $err"
 	return
     }
=20
@@ -6203,9 +6203,9 @@ proc writecommit {} {
     set wrcomtop $top
     catch {destroy $top}
     toplevel $top
-    label $top.title -text "Write commit to file"
+    label $top.title -text [mc "Write commit to file"]
     grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
     entry $top.sha1 -width 40 -relief flat
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
@@ -6214,16 +6214,16 @@ proc writecommit {} {
     $top.head insert 0 [lindex $commitinfo($rowmenuid) 0]
     $top.head conf -state readonly
     grid x $top.head -sticky w
-    label $top.clab -text "Command:"
+    label $top.clab -text [mc "Command:"]
     entry $top.cmd -width 60 -textvariable wrcomcmd
     grid $top.clab $top.cmd -sticky w -pady 10
-    label $top.flab -text "Output file:"
+    label $top.flab -text [mc "Output file:"]
     entry $top.fname -width 60
     $top.fname insert 0 [file normalize "commit-[string range $rowmenu=
id 0=20
6]"]
     grid $top.flab $top.fname -sticky w
     frame $top.buts
-    button $top.buts.gen -text "Write" -command wrcomgo
-    button $top.buts.can -text "Cancel" -command wrcomcan
+    button $top.buts.gen -text [mc "Write"] -command wrcomgo
+    button $top.buts.can -text [mc "Cancel"] -command wrcomcan
     grid $top.buts.gen $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -6238,7 +6238,7 @@ proc wrcomgo {} {
     set cmd "echo $id | [$wrcomtop.cmd get]"
     set fname [$wrcomtop.fname get]
     if {[catch {exec sh -c $cmd >$fname &} err]} {
-	error_popup "Error writing commit: $err"
+	error_popup "[mc "Error writing commit:"] $err"
     }
     catch {destroy $wrcomtop}
     unset wrcomtop
@@ -6257,19 +6257,19 @@ proc mkbranch {} {
     set top .makebranch
     catch {destroy $top}
     toplevel $top
-    label $top.title -text "Create new branch"
+    label $top.title -text [mc "Create new branch"]
     grid $top.title - -pady 10
-    label $top.id -text "ID:"
+    label $top.id -text [mc "ID:"]
     entry $top.sha1 -width 40 -relief flat
     $top.sha1 insert 0 $rowmenuid
     $top.sha1 conf -state readonly
     grid $top.id $top.sha1 -sticky w
-    label $top.nlab -text "Name:"
+    label $top.nlab -text [mc "Name:"]
     entry $top.name -width 40
     grid $top.nlab $top.name -sticky w
     frame $top.buts
-    button $top.buts.go -text "Create" -command [list mkbrgo $top]
-    button $top.buts.can -text "Cancel" -command "catch {destroy $top}=
"
+    button $top.buts.go -text [mc "Create"] -command [list mkbrgo $top=
]
+    button $top.buts.can -text [mc "Cancel"] -command "catch {destroy =
$top}"
     grid $top.buts.go $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
@@ -6283,7 +6283,7 @@ proc mkbrgo {top} {
     set name [$top.name get]
     set id [$top.sha1 get]
     if {$name eq {}} {
-	error_popup "Please specify a name for the new branch"
+	error_popup [mc "Please specify a name for the new branch"]
 	return
     }
     catch {destroy $top}
@@ -6312,11 +6312,12 @@ proc cherrypick {} {
     set oldhead [exec git rev-parse HEAD]
     set dheads [descheads $rowmenuid]
     if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >=3D 0} {
-	set ok [confirm_popup "Commit [string range $rowmenuid 0 7] is alread=
y\
-			included in branch $mainhead -- really re-apply it?"]
+	set ok [confirm_popup [mc "Commit %s is already\
+		included in branch %s -- really re-apply it?" \
+				   [string range $rowmenuid 0 7] $mainhead]]
 	if {!$ok} return
     }
-    nowbusy cherrypick "Cherry-picking"
+    nowbusy cherrypick [mc "Cherry-picking"]
     update
     # Unfortunately git-cherry-pick writes stuff to stderr even when
     # no error occurs, and exec takes that as an indication of error..=
=2E
@@ -6328,7 +6329,7 @@ proc cherrypick {} {
     set newhead [exec git rev-parse HEAD]
     if {$newhead eq $oldhead} {
 	notbusy cherrypick
-	error_popup "No changes committed"
+	error_popup [mc "No changes committed"]
 	return
     }
     addnewchild $newhead $oldhead
@@ -6351,28 +6352,28 @@ proc resethead {} {
     set w ".confirmreset"
     toplevel $w
     wm transient $w .
-    wm title $w "Confirm reset"
+    wm title $w [mc "Confirm reset"]
     message $w.m -text \
-	"Reset branch $mainhead to [string range $rowmenuid 0 7]?" \
+	[mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]=
 \
 	-justify center -aspect 1000
     pack $w.m -side top -fill x -padx 20 -pady 20
     frame $w.f -relief sunken -border 2
-    message $w.f.rt -text "Reset type:" -aspect 1000
+    message $w.f.rt -text [mc "Reset type:"] -aspect 1000
     grid $w.f.rt -sticky w
     set resettype mixed
     radiobutton $w.f.soft -value soft -variable resettype -justify lef=
t \
-	-text "Soft: Leave working tree and index untouched"
+	-text [mc "Soft: Leave working tree and index untouched"]
     grid $w.f.soft -sticky w
     radiobutton $w.f.mixed -value mixed -variable resettype -justify l=
eft \
-	-text "Mixed: Leave working tree untouched, reset index"
+	-text [mc "Mixed: Leave working tree untouched, reset index"]
     grid $w.f.mixed -sticky w
     radiobutton $w.f.hard -value hard -variable resettype -justify lef=
t \
-	-text "Hard: Reset working tree and index\n(discard ALL local changes=
)"
+	-text [mc "Hard: Reset working tree and index\n(discard ALL local cha=
nges)"]
     grid $w.f.hard -sticky w
     pack $w.f -side top -fill x
-    button $w.ok -text OK -command "set confirm_ok 1; destroy $w"
+    button $w.ok -text [mc OK] -command "set confirm_ok 1; destroy $w"
     pack $w.ok -side left -fill x -padx 20 -pady 20
-    button $w.cancel -text Cancel -command "destroy $w"
+    button $w.cancel -text [mc Cancel] -command "destroy $w"
     pack $w.cancel -side right -fill x -padx 20 -pady 20
     bind $w <Visibility> "grab $w; focus $w"
     tkwait window $w
@@ -6383,7 +6384,7 @@ proc resethead {} {
     } else {
 	dohidelocalchanges
 	filerun $fd [list readresetstat $fd]
-	nowbusy reset "Resetting"
+	nowbusy reset [mc "Resetting"]
     }
 }
=20
@@ -6440,7 +6441,7 @@ proc cobranch {} {
=20
     # check the tree is clean first??
     set oldmainhead $mainhead
-    nowbusy checkout "Checking out"
+    nowbusy checkout [mc "Checking out"]
     update
     dohidelocalchanges
     if {[catch {
@@ -6470,14 +6471,14 @@ proc rmbranch {} {
     set id $headmenuid
     # this check shouldn't be needed any more...
     if {$head eq $mainhead} {
-	error_popup "Cannot delete the currently checked-out branch"
+	error_popup [mc "Cannot delete the currently checked-out branch"]
 	return
     }
     set dheads [descheads $id]
     if {[llength $dheads] =3D=3D 1 && $idheads($dheads) eq $head} {
 	# the stuff on this branch isn't on any other branch
-	if {![confirm_popup "The commits on branch $head aren't on any other\
-			branch.\nReally delete branch $head?"]} return
+	if {![confirm_popup [mc "The commits on branch %s aren't on any other=
\
+			branch.\nReally delete branch %s?" $head $head]]} return
     }
     nowbusy rmbranch
     update
@@ -6507,7 +6508,7 @@ proc showrefs {} {
 	return
     }
     toplevel $top
-    wm title $top "Tags and heads: [file tail [pwd]]"
+    wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
     text $top.list -background $bgcolor -foreground $fgcolor \
 	-selectbackground $selectbgcolor -font mainfont \
 	-xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -6521,14 +6522,14 @@ proc showrefs {} {
     grid $top.list $top.ysb -sticky nsew
     grid $top.xsb x -sticky ew
     frame $top.f
-    label $top.f.l -text "Filter: " -font uifont
+    label $top.f.l -text "[mc "Filter"]: " -font uifont
     entry $top.f.e -width 20 -textvariable reflistfilter -font uifont
     set reflistfilter "*"
     trace add variable reflistfilter write reflistfilter_change
     pack $top.f.e -side right -fill x -expand 1
     pack $top.f.l -side left
     grid $top.f - -sticky ew -pady 2
-    button $top.close -command [list destroy $top] -text "Close" \
+    button $top.close -command [list destroy $top] -text [mc "Close"] =
\
 	-font uifont
     grid $top.close -
     grid columnconfigure $top 0 -weight 1
@@ -6816,9 +6817,9 @@ proc getallclines {fd} {
 	    dropcache $err
 	    return
 	}
-	error_popup "Error reading commit topology information;\
+	error_popup "[mc "Error reading commit topology information;\
 		branch and preceding/following tag information\
-		will be incomplete.\n($err)"
+	        will be incomplete."]\n($err)"
 	set cacheok 0
     }
     if {[incr allcommits -1] =3D=3D 0} {
@@ -7800,7 +7801,7 @@ proc showtag {tag isnew} {
     if {[info exists tagcontents($tag)]} {
 	set text $tagcontents($tag)
     } else {
-	set text "Tag: $tag\nId:  $tagids($tag)"
+	set text "[mc "Tag"]: $tag\n[mc "Id"]:  $tagids($tag)"
     }
     appendwithlinks $text {}
     $ctext conf -state disabled
@@ -7840,7 +7841,7 @@ proc choosefont {font which} {
 	font create sample
 	eval font config sample [font actual $font]
 	toplevel $top
-	wm title $top "Gitk font chooser"
+	wm title $top [mc "Gitk font chooser"]
 	label $top.l -textvariable fontparam(which) -font uifont
 	pack $top.l -side top
 	set fontlist [lsort [font families]]
@@ -7857,10 +7858,10 @@ proc choosefont {font which} {
 	    -textvariable fontparam(size) \
 	    -validatecommand {string is integer -strict %s}
 	checkbutton $top.g.bold -padx 5 \
-	    -font {{Times New Roman} 12 bold} -text "B" -indicatoron 0 \
+	    -font {{Times New Roman} 12 bold} -text [mc "B"] -indicatoron 0 \
 	    -variable fontparam(weight) -onvalue bold -offvalue normal
 	checkbutton $top.g.ital -padx 5 \
-	    -font {{Times New Roman} 12 italic} -text "I" -indicatoron 0  \
+	    -font {{Times New Roman} 12 italic} -text [mc "I"] -indicatoron 0=
  \
 	    -variable fontparam(slant) -onvalue italic -offvalue roman
 	pack $top.g.size $top.g.bold $top.g.ital -side left
 	pack $top.g -side top
@@ -7871,9 +7872,9 @@ proc choosefont {font which} {
 	bind $top.c <Configure> [list centertext $top.c]
 	pack $top.c -side top -fill x
 	frame $top.buts
-	button $top.buts.ok -text "OK" -command fontok -default active \
+	button $top.buts.ok -text [mc "OK"] -command fontok -default active \
 	    -font uifont
-	button $top.buts.can -text "Cancel" -command fontcan -default normal =
\
+	button $top.buts.can -text [mc "Cancel"] -command fontcan -default no=
rmal \
 	    -font uifont
 	grid $top.buts.ok $top.buts.can
 	grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -7955,85 +7956,85 @@ proc doprefs {} {
 	set oldprefs($v) [set $v]
     }
     toplevel $top
-    wm title $top "Gitk preferences"
-    label $top.ldisp -text "Commit list display options"
+    wm title $top [mc "Gitk preferences"]
+    label $top.ldisp -text [mc "Commit list display options"]
     $top.ldisp configure -font uifont
     grid $top.ldisp - -sticky w -pady 10
     label $top.spacer -text " "
-    label $top.maxwidthl -text "Maximum graph width (lines)" \
+    label $top.maxwidthl -text [mc "Maximum graph width (lines)"] \
 	-font optionfont
     spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxwi=
dth
     grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
-    label $top.maxpctl -text "Maximum graph width (% of pane)" \
+    label $top.maxpctl -text [mc "Maximum graph width (% of pane)"] \
 	-font optionfont
     spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgrap=
hpct
     grid x $top.maxpctl $top.maxpct -sticky w
     frame $top.showlocal
-    label $top.showlocal.l -text "Show local changes" -font optionfont
+    label $top.showlocal.l -text [mc "Show local changes"] -font optio=
nfont
     checkbutton $top.showlocal.b -variable showlocalchanges
     pack $top.showlocal.b $top.showlocal.l -side left
     grid x $top.showlocal -sticky w
=20
-    label $top.ddisp -text "Diff display options"
+    label $top.ddisp -text [mc "Diff display options"]
     $top.ddisp configure -font uifont
     grid $top.ddisp - -sticky w -pady 10
-    label $top.tabstopl -text "Tab spacing" -font optionfont
+    label $top.tabstopl -text [mc "Tab spacing"] -font optionfont
     spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
     grid x $top.tabstopl $top.tabstop -sticky w
     frame $top.ntag
-    label $top.ntag.l -text "Display nearby tags" -font optionfont
+    label $top.ntag.l -text [mc "Display nearby tags"] -font optionfon=
t
     checkbutton $top.ntag.b -variable showneartags
     pack $top.ntag.b $top.ntag.l -side left
     grid x $top.ntag -sticky w
     frame $top.ldiff
-    label $top.ldiff.l -text "Limit diffs to listed paths" -font optio=
nfont
+    label $top.ldiff.l -text [mc "Limit diffs to listed paths"] -font=20
optionfont
     checkbutton $top.ldiff.b -variable limitdiffs
     pack $top.ldiff.b $top.ldiff.l -side left
     grid x $top.ldiff -sticky w
=20
-    label $top.cdisp -text "Colors: press to choose"
+    label $top.cdisp -text [mc "Colors: press to choose"]
     $top.cdisp configure -font uifont
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
-    button $top.bgbut -text "Background" -font optionfont \
+    button $top.bgbut -text [mc "Background"] -font optionfont \
 	-command [list choosecolor bgcolor 0 $top.bg background setbg]
     grid x $top.bgbut $top.bg -sticky w
     label $top.fg -padx 40 -relief sunk -background $fgcolor
-    button $top.fgbut -text "Foreground" -font optionfont \
+    button $top.fgbut -text [mc "Foreground"] -font optionfont \
 	-command [list choosecolor fgcolor 0 $top.fg foreground setfg]
     grid x $top.fgbut $top.fg -sticky w
     label $top.diffold -padx 40 -relief sunk -background [lindex $diff=
colors=20
0]
-    button $top.diffoldbut -text "Diff: old lines" -font optionfont \
+    button $top.diffoldbut -text [mc "Diff: old lines"] -font optionfo=
nt \
 	-command [list choosecolor diffcolors 0 $top.diffold "diff old lines"=
 \
 		      [list $ctext tag conf d0 -foreground]]
     grid x $top.diffoldbut $top.diffold -sticky w
     label $top.diffnew -padx 40 -relief sunk -background [lindex $diff=
colors=20
1]
-    button $top.diffnewbut -text "Diff: new lines" -font optionfont \
+    button $top.diffnewbut -text [mc "Diff: new lines"] -font optionfo=
nt \
 	-command [list choosecolor diffcolors 1 $top.diffnew "diff new lines"=
 \
 		      [list $ctext tag conf d1 -foreground]]
     grid x $top.diffnewbut $top.diffnew -sticky w
     label $top.hunksep -padx 40 -relief sunk -background [lindex $diff=
colors=20
2]
-    button $top.hunksepbut -text "Diff: hunk header" -font optionfont =
\
+    button $top.hunksepbut -text [mc "Diff: hunk header"] -font option=
font \
 	-command [list choosecolor diffcolors 2 $top.hunksep \
 		      "diff hunk header" \
 		      [list $ctext tag conf hunksep -foreground]]
     grid x $top.hunksepbut $top.hunksep -sticky w
     label $top.selbgsep -padx 40 -relief sunk -background $selectbgcol=
or
-    button $top.selbgbut -text "Select bg" -font optionfont \
+    button $top.selbgbut -text [mc "Select bg"] -font optionfont \
 	-command [list choosecolor selectbgcolor 0 $top.selbgsep background=20
setselbg]
     grid x $top.selbgbut $top.selbgsep -sticky w
=20
-    label $top.cfont -text "Fonts: press to choose"
+    label $top.cfont -text [mc "Fonts: press to choose"]
     $top.cfont configure -font uifont
     grid $top.cfont - -sticky w -pady 10
-    mkfontdisp mainfont $top "Main font"
-    mkfontdisp textfont $top "Diff display font"
-    mkfontdisp uifont $top "User interface font"
+    mkfontdisp mainfont $top [mc "Main font"]
+    mkfontdisp textfont $top [mc "Diff display font"]
+    mkfontdisp uifont $top [mc "User interface font"]
=20
     frame $top.buts
-    button $top.buts.ok -text "OK" -command prefsok -default active
+    button $top.buts.ok -text [mc "OK"] -command prefsok -default acti=
ve
     $top.buts.ok configure -font uifont
-    button $top.buts.can -text "Cancel" -command prefscan -default nor=
mal
+    button $top.buts.can -text [mc "Cancel"] -command prefscan -defaul=
t=20
normal
     $top.buts.can configure -font uifont
     grid $top.buts.ok $top.buts.can
     grid columnconfigure $top.buts 0 -weight 1 -uniform a
@@ -8046,7 +8047,7 @@ proc choosecolor {v vi w x cmd} {
     global $v
=20
     set c [tk_chooseColor -initialcolor [lindex [set $v] $vi] \
-	       -title "Gitk: choose color for $x"]
+	       -title [mc "Gitk: choose color for %s" $x]]
     if {$c eq {}} return
     $w conf -background $c
     lset $v $vi $c
@@ -8427,8 +8428,8 @@ proc tcl_encoding {enc} {
=20
 # First check that Tcl/Tk is recent enough
 if {[catch {package require Tk 8.4} err]} {
-    show_error {} . "Sorry, gitk cannot run with this version of Tcl/T=
k.\n\
-		     Gitk requires at least Tcl/Tk 8.4."
+    show_error {} . [mc "Sorry, gitk cannot run with this version of T=
cl/Tk.
\n\
+		     Gitk requires at least Tcl/Tk 8.4."]
     exit 1
 }
=20
@@ -8512,11 +8513,11 @@ eval font create uifont [fontflags uifont]
=20
 # check that we can find a .git directory somewhere...
 if {[catch {set gitdir [gitdir]}]} {
-    show_error {} . "Cannot find a git repository here."
+    show_error {} . [mc "Cannot find a git repository here."]
     exit 1
 }
 if {![file isdirectory $gitdir]} {
-    show_error {} . "Cannot find the git directory \"$gitdir\"."
+    show_error {} . [mc "Cannot find the git directory \"%s\"." $gitdi=
r]
     exit 1
 }
=20
@@ -8555,8 +8556,8 @@ if {$i >=3D [llength $argv] && $revtreeargs ne {}=
} {
 	# with git log and git rev-list, check revtreeargs for filenames.
 	foreach arg $revtreeargs {
 	    if {[file exists $arg]} {
-		show_error {} . "Ambiguous argument '$arg': both revision\
-				 and filename"
+		show_error {} . [mc "Ambiguous argument '%s': both revision\
+				 and filename" $arg]
 		exit 1
 	    }
 	}
@@ -8567,7 +8568,7 @@ if {$i >=3D [llength $argv] && $revtreeargs ne {}=
} {
 	if {$i > 0} {
 	    set err [string range $err [expr {$i + 6}] end]
 	}
-	show_error {} . "Bad arguments to gitk:\n$err"
+	show_error {} . "[mc "Bad arguments to gitk:"]\n$err"
 	exit 1
     }
 }
@@ -8579,7 +8580,7 @@ if {$mergeonly} {
     if {[catch {
 	set fd [open "| git ls-files -u" r]
     } err]} {
-	show_error {} . "Couldn't get list of unmerged files: $err"
+	show_error {} . "[mc "Couldn't get list of unmerged files:"] $err"
 	exit 1
     }
     while {[gets $fd line] >=3D 0} {
@@ -8595,11 +8596,11 @@ if {$mergeonly} {
     catch {close $fd}
     if {$mlist eq {}} {
 	if {$nr_unmerged =3D=3D 0} {
-	    show_error {} . "No files selected: --merge specified but\
-			     no files are unmerged."
+	    show_error {} . [mc "No files selected: --merge specified but\
+			     no files are unmerged."]
 	} else {
-	    show_error {} . "No files selected: --merge specified but\
-			     no unmerged files are within file limit."
+	    show_error {} . [mc "No files selected: --merge specified but\
+			     no unmerged files are within file limit."]
 	}
 	exit 1
     }
@@ -8657,13 +8658,13 @@ if {$cmdline_files ne {} || $revtreeargs ne {}}=
 {
     set curview 1
     set selectedview 1
     set nextviewnum 2
-    set viewname(1) "Command line"
+    set viewname(1) [mc "Command line"]
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
     set viewperm(1) 0
     addviewmenu 1
-    .bar.view entryconf Edit* -state normal
-    .bar.view entryconf Delete* -state normal
+    .bar.view entryconf [mc "Edit view..."] -state normal
+    .bar.view entryconf [mc "Delete view"] -state normal
 }
=20
 if {[info exists permviews]} {
--=20
1.5.3.4.206.g58ba4
