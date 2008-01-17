From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] gitk: Add checkbutton to ignore space changes
Date: Thu, 17 Jan 2008 23:42:55 +0100
Message-ID: <12006097753995-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Thu Jan 17 23:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFdTS-00019Z-KS
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 23:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760924AbYAQWn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760922AbYAQWnZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 17:43:25 -0500
Received: from mailer.zib.de ([130.73.108.11]:52179 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760614AbYAQWnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 17:43:23 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0HMguuD010216;
	Thu, 17 Jan 2008 23:42:56 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0HMgtlM003163;
	Thu, 17 Jan 2008 23:42:56 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70935>

Ignoring space changes can be helpful.  For example, a commit
claims to only reformat source code and you quickly want to
verify if this claim is true.  Or a commit accidentally changes
code formatting and you want to focus on the real changes.

In such cases a button to toggle of whitespace changes would be
quite handy.  You could quickly toggle between seeing and
ignoring whitespace changes.

This commit adds such a checkbutton right above the diff view.

However, in general it is a good thing to see whitespace changes
and therefore the state of the checkbutton is not saved. For
example, space changes might happen unintentionally.  But they are
real changes yielding different sha1s for the blobs involved.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 gitk-git/gitk |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index b3cb8e8..6eadbde 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -632,6 +632,7 @@ proc makewindow {} {
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global diffcontextstring diffcontext
+    global ignorespace
     global maincursor textcursor curtextcursor
     global rowctxmenu fakerowmenu mergemax wrapcomment
     global highlight_files gdttype
@@ -849,6 +850,9 @@ proc makewindow {} {
     trace add variable diffcontextstring write diffcontextchange
     lappend entries .bleft.mid.diffcontext
     pack .bleft.mid.labeldiffcontext .bleft.mid.diffcontext -side left
+    checkbutton .bleft.mid.ignspace -text [mc "Ignore space change"] \
+	-command changeignorespace -variable ignorespace
+    pack .bleft.mid.ignspace -side left -padx 5
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
 	-state disabled -font textfont \
@@ -5269,13 +5273,21 @@ proc diffcontextchange {n1 n2 op} {
     }
 }
 
+proc changeignorespace {} {
+    reselectline
+}
+
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
     global diffinhdr treediffs
     global diffcontext
+    global ignorespace
     global limitdiffs viewfiles curview
 
     set cmd [diffcmd $ids "-p -C --no-commit-id -U$diffcontext"]
+    if {$ignorespace} {
+	append cmd " -w"
+    }
     if {$limitdiffs && $viewfiles($curview) ne {}} {
 	set cmd [concat $cmd -- $viewfiles($curview)]
     }
@@ -8458,6 +8470,7 @@ set bgcolor white
 set fgcolor black
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
+set ignorespace 0
 set selectbgcolor gray85
 
 ## For msgcat loading, first locate the installation location.
-- 
1.5.4.rc2.60.g46ee
