From: Max Kirillov <max@max630.net>
Subject: [PATCH] gitk: switch to patch mode when searching for line origin
Date: Sat, 5 Apr 2014 23:38:50 +0300
Message-ID: <20140405203850.GA20967@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 22:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWXVB-0003Bf-0n
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 22:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbaDEUrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 16:47:10 -0400
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net ([173.201.192.107]:58930
	"EHLO p3plsmtpa06-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753576AbaDEUrJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2014 16:47:09 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Apr 2014 16:47:09 EDT
Received: from wheezy.local ([89.27.29.195])
	by p3plsmtpa06-06.prod.phx3.secureserver.net with 
	id mLeq1n00z4CavkR01LewZx; Sat, 05 Apr 2014 13:38:58 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245785>

If the "Show origin of this line" is started from tree mode,
it still shows the result in tree mode, which I suppose not
what user expects to see.
---
 gitk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 90764e8..5a99350 100755
--- a/gitk
+++ b/gitk
@@ -3870,7 +3870,7 @@ proc read_line_source {fd inst} {
 	    set id $nullid2
 	}
 	if {[commitinview $id $curview]} {
-	    selectline [rowofcommit $id] 1 [list $fname $lnum]
+	    selectline [rowofcommit $id] 1 [list $fname $lnum] 1
 	} else {
 	    error_popup [mc "That line comes from commit %s, \
 			     which is not in this view" [shortids $id]]
@@ -7161,7 +7161,7 @@ proc make_idmark {id} {
     $canv raise $t
 }
 
-proc selectline {l isnew {desired_loc {}}} {
+proc selectline {l isnew {desired_loc {}} {switch_to_patch 0}} {
     global canv ctext commitinfo selectedline
     global canvy0 linespc parents children curview
     global currentid sha1entry
@@ -7187,6 +7187,10 @@ proc selectline {l isnew {desired_loc {}}} {
 	setcanvscroll
     }
 
+    if {$cmitmode ne "patch" && $switch_to_patch} {
+        set cmitmode "patch"
+    }
+
     set y [expr {$canvy0 + $l * $linespc}]
     set ymax [lindex [$canv cget -scrollregion] 3]
     set ytop [expr {$y - $linespc - 1}]
-- 
1.8.5.2.421.g4cdf8d0
