From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - enable selected patch text on Windows
Date: Tue, 07 Aug 2007 21:40:34 -0400
Message-ID: <11865372352543-git-send-email-mdl123@verizon.net>
References: <1186440352826-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 03:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIaXY-0001YT-44
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 03:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945AbXHHBkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 21:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbXHHBkp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 21:40:45 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:44339 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbXHHBko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 21:40:44 -0400
Received: from fal-l07294-lp.us.ray.com ([72.66.124.87])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMF0058VLZPGPS1@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 07 Aug 2007 20:40:38 -0500 (CDT)
In-reply-to: <1186440352826-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.3.rc4.25.gade7b9
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55290>

On windows, mouse input follows the keyboard focus, so to allow selecting
text from the patch canvas we must not shift focus back to the top level.
This change has no negative impact on X, so we don't explicitly test
for Win32 on this change. This provides similar selection capability
as already available using X-Windows.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---

This version enforces setting focus to the top level window whenever a
scrolling command is issued. The first version lacked that and could allow
some letters to erroneously appear in the patch window. This was purely
cosmetic but annoying to one co-worker on a very slow machine.

 gitk |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..84f5ee4 100755
--- a/gitk
+++ b/gitk
@@ -955,8 +955,8 @@ proc bindkey {ev script} {
 # set the focus back to the toplevel for any click outside
 # the entry widgets
 proc click {w} {
-    global entries
-    foreach e $entries {
+    global ctext entries
+    foreach e [concat $entries $ctext] {
 	if {$w == $e} return
     }
     focus .
@@ -4565,6 +4565,7 @@ proc sellastline {} {

 proc selnextline {dir} {
     global selectedline
+    focus .
     if {![info exists selectedline]} return
     set l [expr {$selectedline + $dir}]
     unmarkmatches
@@ -4645,6 +4646,7 @@ proc godo {elt} {

 proc goback {} {
     global history historyindex
+    focus .

     if {$historyindex > 1} {
 	incr historyindex -1
@@ -4658,6 +4660,7 @@ proc goback {} {

 proc goforw {} {
     global history historyindex
+    focus .

     if {$historyindex < [llength $history]} {
 	set cmd [lindex $history $historyindex]
--
1.5.3.rc4.25.gade7b9
