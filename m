From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCHv2] gitk: Show the current view's name in the window title.
Date: Tue,  7 Apr 2015 11:51:51 -0400
Message-ID: <1428421911-20393-1-git-send-email-marcnarc@xiplink.com>
References: <20150406043711.GC31463@iris.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 17:51:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfVmw-0004UW-CK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 17:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbbDGPvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 11:51:37 -0400
Received: from domain.not.configured ([192.252.130.194]:41646 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753473AbbDGPvg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 11:51:36 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 85F4E601AD;
	Tue,  7 Apr 2015 11:51:34 -0400 (EDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <20150406043711.GC31463@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266923>

If the current view is the "Command line" view, show the command line
arguments instead of the view name.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

This is v2 of my previous "Show the command-line revs in the window title" RFC
patch.  (I'm having trouble accessing gmane, or I'd include a link here.)

This version incorporates Paul's feedback (thanks!) and handles view properly.

		M.

 gitk | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index b859879..90419e3 100755
--- a/gitk
+++ b/gitk
@@ -4034,6 +4034,19 @@ proc shellsplit {str} {
     return $l
 }
 
+proc set_window_title {} {
+    global appname curview viewname vrevs
+    set rev [mc "All files"]
+    if {$curview ne 0} {
+	if {$viewname($curview) eq [mc "Command line"]} {
+	    set rev [string map {"--gitk-symmetric-diff-marker" "--merge"} $vrevs($curview)]
+	} else {
+	    set rev $viewname($curview)
+	}
+    }
+    wm title . "[reponame]: $rev - $appname"
+}
+
 # Code to implement multiple views
 
 proc newview {ishighlight} {
@@ -4510,6 +4523,7 @@ proc showview {n} {
     } elseif {$numcommits == 0} {
 	show_status [mc "No commits selected"]
     }
+    set_window_title
 }
 
 # Stuff relating to the highlighting facility
@@ -6650,6 +6664,7 @@ proc show_status {msg} {
     global canv fgcolor
 
     clear_display
+    set_window_title
     $canv create text 3 3 -anchor nw -text $msg -font mainfont \
 	-tags text -fill $fgcolor
 }
@@ -12393,7 +12408,7 @@ catch {
 }
 # wait for the window to become visible
 tkwait visibility .
-wm title . "[reponame] - $appname"
+set_window_title
 update
 readrefs
 
-- 
2.3.5
