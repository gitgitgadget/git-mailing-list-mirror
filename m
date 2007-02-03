From: Ray Lehtiniemi <rayl@mail.com>
Subject: Enhanced diff options for gitk (Re: --unified=0)
Date: Sat, 03 Feb 2007 15:12:51 -0700
Message-ID: <200702031512.52778.rayl@mail.com>
References: <200702020919.31801.rayl@mail.com>
 <7virej3rkt.fsf@assigned-by-dhcp.cox.net>
Reply-To: rayl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 03 23:15:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDTAa-000125-Uj
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 23:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbXBCWPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 17:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXBCWPj
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 17:15:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43814 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbXBCWPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 17:15:38 -0500
Received: from pd3mr2so.prod.shaw.ca
 (pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCW00H1SR1KPQB0@l-daemon> for git@vger.kernel.org; Sat,
 03 Feb 2007 15:12:56 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
 by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JCW001NDR1KK0K1@pd3mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 03 Feb 2007 15:12:57 -0700 (MST)
Received: from s0106001109ed07db.cg.shawcable.net ([68.147.121.172])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JCW00HRRR1JMEF0@l-daemon> for git@vger.kernel.org; Sat,
 03 Feb 2007 15:12:55 -0700 (MST)
In-reply-to: <7virej3rkt.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38613>

On Saturday 03 February 2007 13:37, Junio C Hamano wrote:

> That's sick.

:-)  i actually only noticed it while testing this patch....

 
-- >8 --
[PATCH] Enhanced diff options for gitk.

The diff options box in the gitk preferences dialog
doesn't do much because the GIT_DIFF_OPTS environment
variable only honors the --unified option.

Adjust the usage of $diffopts and remove GIT_DIFF_OPTS
from gitk so that other diff options will be honored.

Signed-off-by: Ray Lehtiniemi <rayl@mail.com>
---
 gitk |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 68cfd63..7ee19b7 100755
--- a/gitk
+++ b/gitk
@@ -4183,9 +4183,7 @@ proc mergediff {id l} {
 
     set diffmergeid $id
     set diffids $id
-    # this doesn't seem to actually affect anything...
-    set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git diff-tree --no-commit-id --cc $id]
+    set cmd [concat | git diff-tree $diffopts --no-commit-id --cc $id]
     if {[catch {set mdf [open $cmd r]} err]} {
 	error_popup "Error getting merge diffs: $err"
 	return
@@ -4332,8 +4330,7 @@ proc getblobdiffs {ids} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
     global nextupdate diffinhdr treediffs
 
-    set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [concat | git diff-tree --no-commit-id -r -p -C $ids]
+    set cmd [concat | git diff-tree $diffopts --no-commit-id -r -p -C $ids]
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return
@@ -5896,7 +5893,7 @@ proc prefscan {} {
 }
 
 proc prefsok {} {
-    global maxwidth maxgraphpct
+    global maxwidth maxgraphpct diffopts
     global oldprefs prefstop showneartags
 
     catch {destroy $prefstop}
@@ -5906,6 +5903,8 @@ proc prefsok {} {
 	redisplay
     } elseif {$showneartags != $oldprefs(showneartags)} {
 	reselectline
+    } elseif {$diffopts != $oldprefs(diffopts)} {
+	reselectline
     }
 }
 
@@ -6188,7 +6187,7 @@ proc tcl_encoding {enc} {
 
 # defaults...
 set datemode 0
-set diffopts "-U 5 -p"
+set diffopts ""
 set wrcomcmd "git diff-tree --stdin -p --pretty"
 
 set gitencoding {}
-- 
1.5.0.rc3.28.g8bbd
