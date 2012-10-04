From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH 2/2] gitk: When searching, only highlight files when in Patch mode
Date: Thu,  4 Oct 2012 22:50:17 +0200
Message-ID: <1349383817-14457-3-git-send-email-stefan@haller-berlin.de>
References: <506956E1.1080303@viscovery.net>
 <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:12:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJti3-00033L-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab2JDUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 16:51:04 -0400
Received: from server90.greatnet.de ([83.133.96.186]:45023 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab2JDUvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 16:51:03 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 487B72C4074;
	Thu,  4 Oct 2012 22:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.8.0.rc0.36.gef0f079
In-Reply-To: <1349383817-14457-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207049>

This fixes another regression that was introduced in b967135 ("gitk:
Synchronize highlighting in file view when scrolling diff"): when
searching for a string in tree mode, jumping to the next search hit
would highlight the "Comments" entry in the file list.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 8935284..0ee5585 100755
--- a/gitk
+++ b/gitk
@@ -7967,8 +7967,9 @@ proc highlightfile {cline} {
 }
 
 proc highlightfile_for_scrollpos {topidx} {
-    global difffilestart
+    global cmitmode difffilestart
 
+    if {$cmitmode eq "tree"} return
     if {![info exists difffilestart]} return
 
     set top [lindex [split $topidx .] 0]
@@ -8192,12 +8193,10 @@ proc scrolltext {f0 f1} {
     global searchstring cmitmode ctext
     global suppress_highlighting_file_for_this_scrollpos
 
-    if {$cmitmode ne "tree"} {
-	set topidx [$ctext index @0,0]
-	if {![info exists suppress_highlighting_file_for_this_scrollpos]
-	    || $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
-	    highlightfile_for_scrollpos $topidx
-	}
+    set topidx [$ctext index @0,0]
+    if {![info exists suppress_highlighting_file_for_this_scrollpos]
+	|| $topidx ne $suppress_highlighting_file_for_this_scrollpos} {
+	highlightfile_for_scrollpos $topidx
     }
 
     catch {unset suppress_highlighting_file_for_this_scrollpos}
-- 
1.8.0.rc0.36.gef0f079
