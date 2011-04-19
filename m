From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: [PATCH] gitk: When a commit contains a note, mark it with a yellow
	box.
Date: Tue, 19 Apr 2011 22:37:09 +0200
Message-ID: <20110419203709.GA17397@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 22:44:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCHn8-0004wp-EN
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 22:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab1DSUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 16:44:34 -0400
Received: from rdrz.de ([217.160.107.209]:47274 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755124Ab1DSUod (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 16:44:33 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Apr 2011 16:44:32 EDT
Received: (qmail 27170 invoked by uid 1009); 19 Apr 2011 20:37:09 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171816>

It is desirable to see at a glance which commits do contain notes.
Therefore mark them with a yellow rectangle.

That can be suppressed with `gitk --no-notes`.

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
---

Maybe this patch is helpful. Sorry for any tcl/tk nonsense, it's not
my first language...

 gitk |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 4cde0c4..b182c75 100755
--- a/gitk
+++ b/gitk
@@ -1674,8 +1674,9 @@ proc parsecommit {id contents listed} {
     if {$comdate != {}} {
 	set cdate($id) $comdate
     }
+    set hasnote [string first "\nNotes:\n" $contents]
     set commitinfo($id) [list $headline $auname $audate \
-			     $comname $comdate $comment]
+			     $comname $comdate $comment $hasnote]
 }
 
 proc getcommit {id} {
@@ -5899,6 +5900,9 @@ proc drawcmittext {id row col} {
 	|| [info exists idotherrefs($id)]} {
 	set xt [drawtags $id $x $xt $y]
     }
+    if {[lindex $commitinfo($id) 6] > 0} {
+	set xt [drawnotesign $xt $y]
+    }
     set headline [lindex $commitinfo($id) 0]
     set name [lindex $commitinfo($id) 1]
     set date [lindex $commitinfo($id) 2]
@@ -6345,6 +6349,17 @@ proc drawtags {id x xt y1} {
     return $xt
 }
 
+proc drawnotesign {xt y} {
+    global linespc canv fgcolor
+
+    set orad [expr {$linespc / 3}]
+    set t [$canv create rectangle [expr {$xt - $orad}] [expr {$y - $orad}] \
+	       [expr {$xt + $orad - 1}] [expr {$y + $orad - 1}] \
+	       -fill yellow -outline $fgcolor -width 1 -tags circle]
+    set xt [expr {$xt + $orad * 3}]
+    return $xt
+}
+
 proc xcoord {i level ln} {
     global canvx0 xspc1 xspc2
 
-- 
1.7.5.rc1.12.gff46a
