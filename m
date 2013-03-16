From: Manuel Bua <manuel.bua@gmail.com>
Subject: [PATCH] gitk: Add user-configurable branch bg color
Date: Sat, 16 Mar 2013 21:05:40 +0100
Message-ID: <1363464340-24883-1-git-send-email-manuel.bua@gmail.com>
Cc: paulus@samba.org, Manuel Bua <manuel.bua@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 21:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGxNw-0005e1-72
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 21:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab3CPUGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 16:06:43 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:48068 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab3CPUGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 16:06:43 -0400
Received: by mail-ee0-f43.google.com with SMTP id c50so2110599eek.2
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GBro21FvNvJ+dIIZY3mQA1sOUnv8QNBh5Q94dMGGCm8=;
        b=T3VrjkE1VgcYT2cQtSJEX6yfvSMGiEJ1MULGk7MYGXIP/G9obcLgrBrxxUXbgBU2yX
         BuafxYguRkuGPeHMzqMXg+dr4OR1lm/RRbrgpKua062HwI+GG9MHv6Pq5CuRbQ/Ji8e8
         SM6w0pKTc0AxnXK6CRx0synqMhGssEkYbgVRD44K3d2kkRapEASJBhCzKTSLFN8PqYtf
         WG3wzUg3+yTlnUE8OPeoM7A4evyfnCW+uZjJdBFwLNgTFtHxDmhMuq96YhgNNhup0ke3
         2XFDrracz2HlABKaUxpdtn8d0ylwJlrNyvNvViVBb/KjsJR4Plg6Uf3hyPYY+v10AQ+v
         V7tg==
X-Received: by 10.14.110.68 with SMTP id t44mr31672690eeg.25.1363464401425;
        Sat, 16 Mar 2013 13:06:41 -0700 (PDT)
Received: from moon.localdomain (dynamic-adsl-94-39-207-144.clienti.tiscali.it. [94.39.207.144])
        by mx.google.com with ESMTPS id q5sm17714576eep.11.2013.03.16.13.06.39
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 13:06:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218316>

In some cases, the default branch background color (green) isn't
an optimal choice, thus it can be difficult to read.

This provides a way for the user to customize the color used to
fill the rectangle around the branch name, by choosing another
one from the "Preferences" dialog.

The default behavior of using "green" as the default color is
maintained.

Signed-off-by: Manuel Bua <manuel.bua@gmail.com>
---
 gitk | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index b3706fc..310c9a9 100755
--- a/gitk
+++ b/gitk
@@ -2720,7 +2720,7 @@ proc savestuff {w} {
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
-    global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor
+    global colors uicolor bgcolor fgcolor diffcolors diffcontext selectbgcolor branchcolor
     global autoselect autosellen extdifftool perfile_attrs markbgcolor use_ttk
     global hideremotes want_ttk maxrefs
 
@@ -2760,6 +2760,7 @@ proc savestuff {w} {
 	puts $f [list set selectbgcolor $selectbgcolor]
 	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]
+	puts $f [list set branchcolor $branchcolor]
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
@@ -6344,7 +6345,7 @@ proc bindline {t id} {
 proc drawtags {id x xt y1} {
     global idtags idheads idotherrefs mainhead
     global linespc lthickness
-    global canv rowtextx curview fgcolor bgcolor ctxbut
+    global canv rowtextx curview fgcolor bgcolor ctxbut branchcolor
 
     set marks {}
     set ntags 0
@@ -6399,7 +6400,7 @@ proc drawtags {id x xt y1} {
 	} else {
 	    # draw a head or other ref
 	    if {[incr nheads -1] >= 0} {
-		set col green
+		set col $branchcolor
 		if {$tag eq $mainhead} {
 		    set font mainfontbold
 		}
@@ -11033,7 +11034,7 @@ proc prefspage_general {notebook} {
 }
 
 proc prefspage_colors {notebook} {
-    global NS uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
+    global NS uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor branchcolor
 
     set page [create_prefs_page $notebook.colors]
 
@@ -11077,6 +11078,12 @@ proc prefspage_colors {notebook} {
     ${NS}::button $page.selbgbut -text [mc "Select bg"] \
 	-command [list choosecolor selectbgcolor {} $page.selbgsep [mc "background"] setselbg]
     grid x $page.selbgbut $page.selbgsep -sticky w
+    label $page.selbranchcolsep -padx 40 -relief sunk -background $branchcolor
+    ${NS}::button $page.selbranchcolbut -text [mc "Select branch bg"] \
+	-command [list choosecolor branchcolor {} $page.selbranchcolsep \
+			[mc "branch background"] \
+			setbranchcolor]
+    grid x $page.selbranchcolbut $page.selbranchcolsep -sticky w
     return $page
 }
 
@@ -11221,6 +11228,10 @@ proc setfg {c} {
     $canv itemconf markid -outline $c
 }
 
+proc setbranchcolor {c} {
+	reloadcommits
+}
+
 proc prefscan {} {
     global oldprefs prefstop
 
@@ -11742,6 +11753,7 @@ set diffcontext 3
 set ignorespace 0
 set worddiff ""
 set markbgcolor "#e0e0ff"
+set branchcolor green
 
 set circlecolors {white blue gray blue blue}
 
-- 
1.8.2
