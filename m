From: "Mark Levedahl" <mdl123@verizon.net>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 10:04:59 -0500
Message-ID: <epsviu$j4$1@sea.gmane.org>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl> <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C14563.8060707@verizon.net> <Pine.LNX.4.63.0702011016430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <epsrj3$gh8$1@sea.gmane.org> <Pine.LNX.4.63.0702011503230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0038_01C745E8.7056BB90"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 16:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdVt-0005wg-C6
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 16:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbXBAPFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 10:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422922AbXBAPFv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 10:05:51 -0500
Received: from main.gmane.org ([80.91.229.2]:56356 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422915AbXBAPFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 10:05:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCdV1-0004mT-Ic
	for git@vger.kernel.org; Thu, 01 Feb 2007 16:05:19 +0100
Received: from sahara.mdnt.com ([12.109.151.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 16:05:19 +0100
Received: from mdl123 by sahara.mdnt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 16:05:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: sahara.mdnt.com
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.3028
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38361>

This is a multi-part message in MIME format.

------=_NextPart_000_0038_01C745E8.7056BB90
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

"Johannes Schindelin" <Johannes.Schindelin@gmx.de> wrote in message 
news:Pine.LNX.4.63.0702011503230.22628@wbgn013.biozentrum.uni-wuerzburg.de...

> Thanks a lot. It's way easier to review now, except for the lines
> beginning with "M" ;-)
>
> Ciao,
> Dscho
>

Maybe this works better?


------=_NextPart_000_0038_01C745E8.7056BB90
Content-Type: application/octet-stream;
	name="0002-Make-gitk-work-reasonably-well-on-Cygwin.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-Make-gitk-work-reasonably-well-on-Cygwin.patch"

>From 3c04250616f0deed881ce1690e8c1950b1643b07 Mon Sep 17 00:00:00 2001=0A=
From: Mark Levedahl <mdl123@verizon.net>=0A=
Date: Thu, 1 Feb 2007 08:46:38 -0500=0A=
Subject: [PATCH] Make gitk work reasonably well on Cygwin.=0A=
=0A=
The gitk gui layout was completely broken on Cygwin. If gitk was started=0A=
without previous geometry in ~/.gitk, the user could drag the window =
sashes=0A=
to get a useable layout. However, if ~/.gitk existed, this was not =
possible=0A=
at all.=0A=
=0A=
The fix was to rewrite makewindow, changing the toplevel containers and=0A=
the particular geometry information saved between sessions. Numerous bugs=0A=
in both the Cygwin and the Linux Tk versions make this a delicate=0A=
balancing act: the version here works in both but many subtle variants=0A=
are competely broken in one or the other environment.=0A=
=0A=
Three user visible changes result:=0A=
1 - The viewer is fully functional under Cygwin.=0A=
2 - The search bar moves from the bottom to the top of the lower left=0A=
    pane. This was necessary to get around a layout problem on Cygwin.=0A=
3 - The window size and position is saved and restored between sessions.=0A=
    Again, this is necessary to get around a layout problem on Cygwin.=0A=
=0A=
Signed-off-by: Mark Levedahl <mdl123@verizon.net>=0A=
---=0A=
 gitk |  276 =
++++++++++++++++++++++++++++++++++++------------------------------=0A=
 1 files changed, 150 insertions(+), 126 deletions(-)=0A=
=0A=
diff --git a/gitk b/gitk=0A=
index 650435e..8132812 100755=0A=
--- a/gitk=0A=
+++ b/gitk=0A=
@@ -435,56 +435,59 @@ proc makewindow {} {=0A=
     .bar.help configure -font $uifont=0A=
     . configure -menu .bar=0A=
 =0A=
-    if {![info exists geometry(canv1)]} {=0A=
-	set geometry(canv1) [expr {45 * $charspc}]=0A=
-	set geometry(canv2) [expr {30 * $charspc}]=0A=
-	set geometry(canv3) [expr {15 * $charspc}]=0A=
-	set geometry(canvh) [expr {25 * $linespc + 4}]=0A=
-	set geometry(ctextw) 80=0A=
-	set geometry(ctexth) 30=0A=
-	set geometry(cflistw) 30=0A=
-    }=0A=
+    # the gui has upper and lower half, parts of a paned window.=0A=
     panedwindow .ctop -orient vertical=0A=
-    if {[info exists geometry(width)]} {=0A=
-	.ctop conf -width $geometry(width) -height $geometry(height)=0A=
-	set texth [expr {$geometry(height) - $geometry(canvh) - 56}]=0A=
-	set geometry(ctexth) [expr {($texth - 8) /=0A=
-				    [font metrics $textfont -linespace]}]=0A=
-    }=0A=
-    frame .ctop.top=0A=
-    frame .ctop.top.bar=0A=
-    frame .ctop.top.lbar=0A=
-    pack .ctop.top.lbar -side bottom -fill x=0A=
-    pack .ctop.top.bar -side bottom -fill x=0A=
-    set cscroll .ctop.top.csb=0A=
-    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0=0A=
-    pack $cscroll -side right -fill y=0A=
-    panedwindow .ctop.top.clist -orient horizontal -sashpad 0 =
-handlesize 4=0A=
-    pack .ctop.top.clist -side top -fill both -expand 1=0A=
-    .ctop add .ctop.top=0A=
-    set canv .ctop.top.clist.canv=0A=
-    canvas $canv -height $geometry(canvh) -width $geometry(canv1) \=0A=
+=0A=
+    # possibly use assumed geometry=0A=
+    if {![info exists geometry(topheight)]} {=0A=
+        set geometry(topheight) [expr {15 * $linespc}]=0A=
+        set geometry(topwidth) [expr {80 * $charspc}]=0A=
+        set geometry(botheight) [expr {15 * $linespc}]=0A=
+        set geometry(botwidth) [expr {50 * $charspc}]=0A=
+        set geometry(canv) [expr {40 * $charspc}]=0A=
+        set geometry(canv2) [expr {20 * $charspc}]=0A=
+        set geometry(canv3) [expr {20 * $charspc}]=0A=
+    }=0A=
+=0A=
+    # the upper half will have a paned window, a scroll bar to the =
right, and some stuff below=0A=
+    frame .tf -height $geometry(topheight) -width $geometry(topwidth)=0A=
+    frame .tf.histframe=0A=
+    panedwindow .tf.histframe.pwclist -orient horizontal -sashpad 0 =
-handlesize 4=0A=
+=0A=
+    # create three canvases=0A=
+    set cscroll .tf.histframe.csb=0A=
+    set canv .tf.histframe.pwclist.canv=0A=
+    canvas $canv -width $geometry(canv) \=0A=
 	-background $bgcolor -bd 0 \=0A=
 	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"=0A=
-    .ctop.top.clist add $canv=0A=
-    set canv2 .ctop.top.clist.canv2=0A=
-    canvas $canv2 -height $geometry(canvh) -width $geometry(canv2) \=0A=
+    .tf.histframe.pwclist add $canv=0A=
+    set canv2 .tf.histframe.pwclist.canv2=0A=
+    canvas $canv2 -width $geometry(canv2) \=0A=
 	-background $bgcolor -bd 0 -yscrollincr $linespc=0A=
-    .ctop.top.clist add $canv2=0A=
-    set canv3 .ctop.top.clist.canv3=0A=
-    canvas $canv3 -height $geometry(canvh) -width $geometry(canv3) \=0A=
+    .tf.histframe.pwclist add $canv2=0A=
+    set canv3 .tf.histframe.pwclist.canv3=0A=
+    canvas $canv3 -width $geometry(canv3) \=0A=
 	-background $bgcolor -bd 0 -yscrollincr $linespc=0A=
-    .ctop.top.clist add $canv3=0A=
-    bind .ctop.top.clist <Configure> {resizeclistpanes %W %w}=0A=
+    .tf.histframe.pwclist add $canv3=0A=
+=0A=
+    # a scroll bar to rule them=0A=
+    scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0=0A=
+    pack $cscroll -side right -fill y=0A=
+    bind .tf.histframe.pwclist <Configure> {resizeclistpanes %W %w}=0A=
     lappend bglist $canv $canv2 $canv3=0A=
+    pack .tf.histframe.pwclist -fill both -expand 1 -side left=0A=
 =0A=
-    set sha1entry .ctop.top.bar.sha1=0A=
+    # we have two button bars at bottom of top frame. Bar 1=0A=
+    frame .tf.bar=0A=
+    frame .tf.lbar -height 15=0A=
+=0A=
+    set sha1entry .tf.bar.sha1=0A=
     set entries $sha1entry=0A=
-    set sha1but .ctop.top.bar.sha1label=0A=
+    set sha1but .tf.bar.sha1label=0A=
     button $sha1but -text "SHA1 ID: " -state disabled -relief flat \=0A=
 	-command gotocommit -width 8 -font $uifont=0A=
     $sha1but conf -disabledforeground [$sha1but cget -foreground]=0A=
-    pack .ctop.top.bar.sha1label -side left=0A=
+    pack .tf.bar.sha1label -side left=0A=
     entry $sha1entry -width 40 -font $textfont -textvariable sha1string=0A=
     trace add variable sha1string write sha1change=0A=
     pack $sha1entry -side left -pady 2=0A=
@@ -505,91 +508,105 @@ proc makewindow {} {=0A=
 	0x00, 0x38, 0xff, 0x7f, 0xff, 0x7f, 0xff, 0x7f, 0x00, 0x38, 0x00, 0x1c,=0A=
 	0x00, 0x0e, 0x00, 0x07, 0x80, 0x03, 0xc0, 0x01};=0A=
     }=0A=
-    button .ctop.top.bar.leftbut -image bm-left -command goback \=0A=
+    button .tf.bar.leftbut -image bm-left -command goback \=0A=
 	-state disabled -width 26=0A=
-    pack .ctop.top.bar.leftbut -side left -fill y=0A=
-    button .ctop.top.bar.rightbut -image bm-right -command goforw \=0A=
+    pack .tf.bar.leftbut -side left -fill y=0A=
+    button .tf.bar.rightbut -image bm-right -command goforw \=0A=
 	-state disabled -width 26=0A=
-    pack .ctop.top.bar.rightbut -side left -fill y=0A=
+    pack .tf.bar.rightbut -side left -fill y=0A=
 =0A=
-    button .ctop.top.bar.findbut -text "Find" -command dofind -font =
$uifont=0A=
-    pack .ctop.top.bar.findbut -side left=0A=
+    button .tf.bar.findbut -text "Find" -command dofind -font $uifont=0A=
+    pack .tf.bar.findbut -side left=0A=
     set findstring {}=0A=
-    set fstring .ctop.top.bar.findstring=0A=
+    set fstring .tf.bar.findstring=0A=
     lappend entries $fstring=0A=
     entry $fstring -width 30 -font $textfont -textvariable findstring=0A=
     trace add variable findstring write find_change=0A=
-    pack $fstring -side left -expand 1 -fill x=0A=
+    pack $fstring -side left -expand 1 -fill x -in .tf.bar=0A=
     set findtype Exact=0A=
-    set findtypemenu [tk_optionMenu .ctop.top.bar.findtype \=0A=
-			  findtype Exact IgnCase Regexp]=0A=
+    set findtypemenu [tk_optionMenu .tf.bar.findtype \=0A=
+		      findtype Exact IgnCase Regexp]=0A=
     trace add variable findtype write find_change=0A=
-    .ctop.top.bar.findtype configure -font $uifont=0A=
-    .ctop.top.bar.findtype.menu configure -font $uifont=0A=
+    .tf.bar.findtype configure -font $uifont=0A=
+    .tf.bar.findtype.menu configure -font $uifont=0A=
     set findloc "All fields"=0A=
-    tk_optionMenu .ctop.top.bar.findloc findloc "All fields" Headline \=0A=
+    tk_optionMenu .tf.bar.findloc findloc "All fields" Headline \=0A=
 	Comments Author Committer=0A=
     trace add variable findloc write find_change=0A=
-    .ctop.top.bar.findloc configure -font $uifont=0A=
-    .ctop.top.bar.findloc.menu configure -font $uifont=0A=
-    pack .ctop.top.bar.findloc -side right=0A=
-    pack .ctop.top.bar.findtype -side right=0A=
-=0A=
-    label .ctop.top.lbar.flabel -text "Highlight:  Commits " \=0A=
-	-font $uifont=0A=
-    pack .ctop.top.lbar.flabel -side left -fill y=0A=
+    .tf.bar.findloc configure -font $uifont=0A=
+    .tf.bar.findloc.menu configure -font $uifont=0A=
+    pack .tf.bar.findloc -side right=0A=
+    pack .tf.bar.findtype -side right=0A=
+=0A=
+    # build up the bottom bar of upper window=0A=
+    label .tf.lbar.flabel -text "Highlight:  Commits " \=0A=
+    -font $uifont=0A=
+    pack .tf.lbar.flabel -side left -fill y=0A=
     set gdttype "touching paths:"=0A=
-    set gm [tk_optionMenu .ctop.top.lbar.gdttype gdttype "touching =
paths:" \=0A=
-		"adding/removing string:"]=0A=
+    set gm [tk_optionMenu .tf.lbar.gdttype gdttype "touching paths:" \=0A=
+	"adding/removing string:"]=0A=
     trace add variable gdttype write hfiles_change=0A=
     $gm conf -font $uifont=0A=
-    .ctop.top.lbar.gdttype conf -font $uifont=0A=
-    pack .ctop.top.lbar.gdttype -side left -fill y=0A=
-    entry .ctop.top.lbar.fent -width 25 -font $textfont \=0A=
+    .tf.lbar.gdttype conf -font $uifont=0A=
+    pack .tf.lbar.gdttype -side left -fill y=0A=
+    entry .tf.lbar.fent -width 25 -font $textfont \=0A=
 	-textvariable highlight_files=0A=
     trace add variable highlight_files write hfiles_change=0A=
-    lappend entries .ctop.top.lbar.fent=0A=
-    pack .ctop.top.lbar.fent -side left -fill x -expand 1=0A=
-    label .ctop.top.lbar.vlabel -text " OR in view" -font $uifont=0A=
-    pack .ctop.top.lbar.vlabel -side left -fill y=0A=
+    lappend entries .tf.lbar.fent=0A=
+    pack .tf.lbar.fent -side left -fill x -expand 1=0A=
+    label .tf.lbar.vlabel -text " OR in view" -font $uifont=0A=
+    pack .tf.lbar.vlabel -side left -fill y=0A=
     global viewhlmenu selectedhlview=0A=
-    set viewhlmenu [tk_optionMenu .ctop.top.lbar.vhl selectedhlview =
None]=0A=
+    set viewhlmenu [tk_optionMenu .tf.lbar.vhl selectedhlview None]=0A=
     $viewhlmenu entryconf None -command delvhighlight=0A=
     $viewhlmenu conf -font $uifont=0A=
-    .ctop.top.lbar.vhl conf -font $uifont=0A=
-    pack .ctop.top.lbar.vhl -side left -fill y=0A=
-    label .ctop.top.lbar.rlabel -text " OR " -font $uifont=0A=
-    pack .ctop.top.lbar.rlabel -side left -fill y=0A=
+    .tf.lbar.vhl conf -font $uifont=0A=
+    pack .tf.lbar.vhl -side left -fill y=0A=
+    label .tf.lbar.rlabel -text " OR " -font $uifont=0A=
+    pack .tf.lbar.rlabel -side left -fill y=0A=
     global highlight_related=0A=
-    set m [tk_optionMenu .ctop.top.lbar.relm highlight_related None \=0A=
-	       "Descendent" "Not descendent" "Ancestor" "Not ancestor"]=0A=
+    set m [tk_optionMenu .tf.lbar.relm highlight_related None \=0A=
+	"Descendent" "Not descendent" "Ancestor" "Not ancestor"]=0A=
     $m conf -font $uifont=0A=
-    .ctop.top.lbar.relm conf -font $uifont=0A=
+    .tf.lbar.relm conf -font $uifont=0A=
     trace add variable highlight_related write vrel_change=0A=
-    pack .ctop.top.lbar.relm -side left -fill y=0A=
-=0A=
-    panedwindow .ctop.cdet -orient horizontal=0A=
-    .ctop add .ctop.cdet=0A=
-    frame .ctop.cdet.left=0A=
-    frame .ctop.cdet.left.bot=0A=
-    pack .ctop.cdet.left.bot -side bottom -fill x=0A=
-    button .ctop.cdet.left.bot.search -text "Search" -command dosearch \=0A=
+    pack .tf.lbar.relm -side left -fill y=0A=
+=0A=
+    # Finish putting the upper half of the viewer together=0A=
+    pack .tf.lbar -in .tf -side bottom -fill x=0A=
+    pack .tf.bar -in .tf -side bottom -fill x=0A=
+    pack .tf.histframe -fill both -side top -expand 1=0A=
+    .ctop add .tf=0A=
+=0A=
+    # now build up the bottom=0A=
+    panedwindow .pwbottom -orient horizontal=0A=
+=0A=
+    # lower left, a text box over search bar, scroll bar to the right=0A=
+    # if we know window height, then that will set the lower text =
height, otherwise=0A=
+    # we set lower text height which will drive window height=0A=
+    if {[info exists geometry(main)]} {=0A=
+        frame .bleft -width $geometry(botwidth)=0A=
+    } else {=0A=
+        frame .bleft -width $geometry(botwidth) -height =
$geometry(botheight)=0A=
+    }=0A=
+    frame .bleft.top=0A=
+=0A=
+    button .bleft.top.search -text "Search" -command dosearch \=0A=
 	-font $uifont=0A=
-    pack .ctop.cdet.left.bot.search -side left -padx 5=0A=
-    set sstring .ctop.cdet.left.bot.sstring=0A=
+    pack .bleft.top.search -side left -padx 5=0A=
+    set sstring .bleft.top.sstring=0A=
     entry $sstring -width 20 -font $textfont -textvariable searchstring=0A=
     lappend entries $sstring=0A=
     trace add variable searchstring write incrsearch=0A=
     pack $sstring -side left -expand 1 -fill x=0A=
-    set ctext .ctop.cdet.left.ctext=0A=
+    set ctext .bleft.ctext=0A=
     text $ctext -background $bgcolor -foreground $fgcolor \=0A=
 	-state disabled -font $textfont \=0A=
-	-width $geometry(ctextw) -height $geometry(ctexth) \=0A=
 	-yscrollcommand scrolltext -wrap none=0A=
-    scrollbar .ctop.cdet.left.sb -command "$ctext yview"=0A=
-    pack .ctop.cdet.left.sb -side right -fill y=0A=
+    scrollbar .bleft.sb -command "$ctext yview"=0A=
+    pack .bleft.top -side top -fill x=0A=
+    pack .bleft.sb -side right -fill y=0A=
     pack $ctext -side left -fill both -expand 1=0A=
-    .ctop.cdet add .ctop.cdet.left=0A=
     lappend bglist $ctext=0A=
     lappend fglist $ctext=0A=
 =0A=
@@ -620,36 +637,45 @@ proc makewindow {} {=0A=
     $ctext tag conf msep -font [concat $textfont bold]=0A=
     $ctext tag conf found -back yellow=0A=
 =0A=
-    frame .ctop.cdet.right=0A=
-    frame .ctop.cdet.right.mode=0A=
-    radiobutton .ctop.cdet.right.mode.patch -text "Patch" \=0A=
+    .pwbottom add .bleft=0A=
+=0A=
+    # lower right=0A=
+    frame .bright=0A=
+    frame .bright.mode=0A=
+    radiobutton .bright.mode.patch -text "Patch" \=0A=
 	-command reselectline -variable cmitmode -value "patch"=0A=
-    radiobutton .ctop.cdet.right.mode.tree -text "Tree" \=0A=
+    radiobutton .bright.mode.tree -text "Tree" \=0A=
 	-command reselectline -variable cmitmode -value "tree"=0A=
-    grid .ctop.cdet.right.mode.patch .ctop.cdet.right.mode.tree -sticky =
ew=0A=
-    pack .ctop.cdet.right.mode -side top -fill x=0A=
-    set cflist .ctop.cdet.right.cfiles=0A=
+    grid .bright.mode.patch .bright.mode.tree -sticky ew=0A=
+    pack .bright.mode -side top -fill x=0A=
+    set cflist .bright.cfiles=0A=
     set indent [font measure $mainfont "nn"]=0A=
-    text $cflist -width $geometry(cflistw) \=0A=
+    text $cflist \=0A=
 	-background $bgcolor -foreground $fgcolor \=0A=
 	-font $mainfont \=0A=
 	-tabs [list $indent [expr {2 * $indent}]] \=0A=
-	-yscrollcommand ".ctop.cdet.right.sb set" \=0A=
+	-yscrollcommand ".bright.sb set" \=0A=
 	-cursor [. cget -cursor] \=0A=
 	-spacing1 1 -spacing3 1=0A=
     lappend bglist $cflist=0A=
     lappend fglist $cflist=0A=
-    scrollbar .ctop.cdet.right.sb -command "$cflist yview"=0A=
-    pack .ctop.cdet.right.sb -side right -fill y=0A=
+    scrollbar .bright.sb -command "$cflist yview"=0A=
+    pack .bright.sb -side right -fill y=0A=
     pack $cflist -side left -fill both -expand 1=0A=
     $cflist tag configure highlight \=0A=
 	-background [$cflist cget -selectbackground]=0A=
     $cflist tag configure bold -font [concat $mainfont bold]=0A=
-    .ctop.cdet add .ctop.cdet.right=0A=
-    bind .ctop.cdet <Configure> {resizecdetpanes %W %w}=0A=
 =0A=
-    pack .ctop -side top -fill both -expand 1=0A=
+    .pwbottom add .bright=0A=
+    .ctop add .pwbottom=0A=
 =0A=
+    # restore window position if known=0A=
+    if {[info exists geometry(main)]} {=0A=
+        wm geometry . "$geometry(main)"=0A=
+    }=0A=
+=0A=
+    bind .pwbottom <Configure> {resizecdetpanes %W %w}=0A=
+    pack .ctop -fill both -expand 1=0A=
     bindall <1> {selcanvline %W %x %y}=0A=
     #bindall <B1-Motion> {selcanvline %W %x %y}=0A=
     bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"=0A=
@@ -802,18 +828,16 @@ proc savestuff {w} {=0A=
 	puts $f [list set fgcolor $fgcolor]=0A=
 	puts $f [list set colors $colors]=0A=
 	puts $f [list set diffcolors $diffcolors]=0A=
-	puts $f "set geometry(width) [winfo width .ctop]"=0A=
-	puts $f "set geometry(height) [winfo height .ctop]"=0A=
-	puts $f "set geometry(canv1) [expr {[winfo width $canv]-2}]"=0A=
-	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-2}]"=0A=
-	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-2}]"=0A=
-	puts $f "set geometry(canvh) [expr {[winfo height $canv]-2}]"=0A=
-	set wid [expr {([winfo width $ctext] - 8) \=0A=
-			   / [font measure $textfont "0"]}]=0A=
-	puts $f "set geometry(ctextw) $wid"=0A=
-	set wid [expr {([winfo width $cflist] - 11) \=0A=
-			   / [font measure [$cflist cget -font] "0"]}]=0A=
-	puts $f "set geometry(cflistw) $wid"=0A=
+=0A=
+        puts $f "set geometry(main) [winfo geometry .]"=0A=
+	puts $f "set geometry(topwidth) [winfo width .tf]"=0A=
+	puts $f "set geometry(topheight) [winfo height .tf]"=0A=
+	puts $f "set geometry(canv) [expr {[winfo width $canv]-0}]"=0A=
+	puts $f "set geometry(canv2) [expr {[winfo width $canv2]-0}]"=0A=
+	puts $f "set geometry(canv3) [expr {[winfo width $canv3]-0}]"=0A=
+	puts $f "set geometry(botwidth) [winfo width .bleft]"=0A=
+	puts $f "set geometry(botheight) [winfo height .bleft]"=0A=
+=0A=
 	puts -nonewline $f "set permviews {"=0A=
 	for {set v 0} {$v < $nextviewnum} {incr v} {=0A=
 	    if {$viewperm($v)} {=0A=
@@ -4043,11 +4067,11 @@ proc addtohistory {cmd} {=0A=
     }=0A=
     incr historyindex=0A=
     if {$historyindex > 1} {=0A=
-	.ctop.top.bar.leftbut conf -state normal=0A=
+	.tf.bar.leftbut conf -state normal=0A=
     } else {=0A=
-	.ctop.top.bar.leftbut conf -state disabled=0A=
+	.tf.bar.leftbut conf -state disabled=0A=
     }=0A=
-    .ctop.top.bar.rightbut conf -state disabled=0A=
+    .tf.bar.rightbut conf -state disabled=0A=
 }=0A=
 =0A=
 proc godo {elt} {=0A=
@@ -4067,10 +4091,10 @@ proc goback {} {=0A=
     if {$historyindex > 1} {=0A=
 	incr historyindex -1=0A=
 	godo [lindex $history [expr {$historyindex - 1}]]=0A=
-	.ctop.top.bar.rightbut conf -state normal=0A=
+	.tf.bar.rightbut conf -state normal=0A=
     }=0A=
     if {$historyindex <=3D 1} {=0A=
-	.ctop.top.bar.leftbut conf -state disabled=0A=
+	.tf.bar.leftbut conf -state disabled=0A=
     }=0A=
 }=0A=
 =0A=
@@ -4081,10 +4105,10 @@ proc goforw {} {=0A=
 	set cmd [lindex $history $historyindex]=0A=
 	incr historyindex=0A=
 	godo $cmd=0A=
-	.ctop.top.bar.leftbut conf -state normal=0A=
+	.tf.bar.leftbut conf -state normal=0A=
     }=0A=
     if {$historyindex >=3D [llength $history]} {=0A=
-	.ctop.top.bar.rightbut conf -state disabled=0A=
+	.tf.bar.rightbut conf -state disabled=0A=
     }=0A=
 }=0A=
 =0A=
@@ -4591,7 +4615,7 @@ proc searchmarkvisible {doall} {=0A=
 proc scrolltext {f0 f1} {=0A=
     global searchstring=0A=
 =0A=
-    .ctop.cdet.left.sb set $f0 $f1=0A=
+    .bleft.sb set $f0 $f1=0A=
     if {$searchstring ne {}} {=0A=
 	searchmarkvisible 0=0A=
     }=0A=
-- =0A=
1.5.0.rc2.76.g4fc0-dirty=0A=
=0A=

------=_NextPart_000_0038_01C745E8.7056BB90
Content-Type: application/octet-stream;
	name="0001-gitk-remove-trailing-whitespace-from-a-few-lines.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-gitk-remove-trailing-whitespace-from-a-few-lines.patch"

>From 3fc0e83b18d528ac5eceb5cc5b5404fa47fa69a5 Mon Sep 17 00:00:00 2001=0A=
From: Mark Levedahl <mdl123@verizon.net>=0A=
Date: Thu, 1 Feb 2007 08:44:46 -0500=0A=
Subject: [PATCH] gitk - remove trailing whitespace from a few lines.=0A=
=0A=
Signed-off-by: Mark Levedahl <mdl123@verizon.net>=0A=
---=0A=
 gitk |    8 ++++----=0A=
 1 files changed, 4 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/gitk b/gitk=0A=
index 31d0aad..650435e 100755=0A=
--- a/gitk=0A=
+++ b/gitk=0A=
@@ -427,7 +427,7 @@ proc makewindow {} {=0A=
     .bar.view add separator=0A=
     .bar.view add radiobutton -label "All files" -command {showview 0} \=0A=
 	-variable selectedview -value 0=0A=
-    =0A=
+=0A=
     menu .bar.help=0A=
     .bar add cascade -label "Help" -menu .bar.help=0A=
     .bar.help add command -label "About gitk" -command about=0A=
@@ -1402,7 +1402,7 @@ proc newview {ishighlight} {=0A=
     set newviewname($nextviewnum) "View $nextviewnum"=0A=
     set newviewperm($nextviewnum) 0=0A=
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]=0A=
-    vieweditor $top $nextviewnum "Gitk view definition" =0A=
+    vieweditor $top $nextviewnum "Gitk view definition"=0A=
 }=0A=
 =0A=
 proc editview {} {=0A=
@@ -3897,7 +3897,7 @@ proc selectline {l isnew} {=0A=
 	}=0A=
 	$ctext insert end "\n"=0A=
     }=0A=
- =0A=
+=0A=
     set headers {}=0A=
     set olds [lindex $parentlist $l]=0A=
     if {[llength $olds] > 1} {=0A=
@@ -4006,7 +4006,7 @@ proc selnextpage {dir} {=0A=
         set l [expr $numcommits - 1]=0A=
     }=0A=
     unmarkmatches=0A=
-    selectline $l 1    =0A=
+    selectline $l 1=0A=
 }=0A=
 =0A=
 proc unselectline {} {=0A=
-- =0A=
1.5.0.rc2.76.g4fc0-dirty=0A=
=0A=

------=_NextPart_000_0038_01C745E8.7056BB90--
