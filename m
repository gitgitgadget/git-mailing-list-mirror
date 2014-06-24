From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: add visiblerefs option, which lists always shown
 branches
Date: Tue, 24 Jun 2014 08:19:44 +0300
Message-ID: <20140624051944.GA14064@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzJGs-0004VV-A7
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 07:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaFXF1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 01:27:50 -0400
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net ([68.178.252.104]:57596
	"EHLO p3plsmtpa11-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751116AbaFXF1u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2014 01:27:50 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2014 01:27:50 EDT
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa11-03.prod.phx3.secureserver.net with 
	id J5Kt1o00D3gsSd6015KzUS; Mon, 23 Jun 2014 22:20:00 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252386>

When many branches contain the commit, they used to be shown in
the form "A, B and many more", where A, B can be master of current
HEAD. But there are more which might be interesting to always know about.
For example, "origin/master".

The new option, visiblerefs, is stored in ~/.gitk. It contains a list
of references which are always shown before "and many more" if they
contain the commit. By default it is `{"master"}', which is compatible
with previous behavior.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 41e5071..7ce6014 100755
--- a/gitk
+++ b/gitk
@@ -2787,7 +2787,7 @@ proc savestuff {w} {
     global mainheadcirclecolor workingfilescirclecolor indexcirclecolor
     global linkfgcolor circleoutlinecolor
     global autoselect autosellen extdifftool perfile_attrs markbgcolor use_ttk
-    global hideremotes want_ttk maxrefs
+    global hideremotes want_ttk maxrefs visiblerefs
     global config_file config_file_tmp
 
     if {$stuffsaved} return
@@ -2813,6 +2813,7 @@ proc savestuff {w} {
 	puts $f [list set autosellen $autosellen]
 	puts $f [list set showneartags $showneartags]
 	puts $f [list set maxrefs $maxrefs]
+	puts $f [list set visiblerefs $visiblerefs]
 	puts $f [list set hideremotes $hideremotes]
 	puts $f [list set showlocalchanges $showlocalchanges]
 	puts $f [list set datetimeformat $datetimeformat]
@@ -7033,7 +7034,7 @@ proc viewnextline {dir} {
 # add a list of tag or branch names at position pos
 # returns the number of names inserted
 proc appendrefs {pos ids var} {
-    global ctext linknum curview $var maxrefs mainheadid
+    global ctext linknum curview $var maxrefs visiblerefs mainheadid
 
     if {[catch {$ctext index $pos}]} {
 	return 0
@@ -7054,14 +7055,14 @@ proc appendrefs {pos ids var} {
     if {[llength $tags] > $maxrefs} {
 	# If we are displaying heads, and there are too many,
 	# see if there are some important heads to display.
-	# Currently this means "master" and the current head.
+	# Currently that are the current head and heads listed in $visiblerefs option
 	set itags {}
 	if {$var eq "idheads"} {
 	    set utags {}
 	    foreach ti $tags {
 		set hname [lindex $ti 0]
 		set id [lindex $ti 1]
-		if {($hname eq "master" || $id eq $mainheadid) &&
+		if {([lsearch -exact $visiblerefs $hname] != -1 || $id eq $mainheadid) &&
 		    [llength $itags] < $maxrefs} {
 		    lappend itags $ti
 		} else {
@@ -12043,6 +12044,7 @@ set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
 set maxrefs 20
+set visiblerefs {"master"}
 set maxlinelen 200
 set showlocalchanges 1
 set limitdiffs 1
-- 
2.0.0.526.g5318336
