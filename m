From: Mark Burton <markb@ordern.com>
Subject: [PATCH v2] gitk: Highlight commit/comment text only if search type
 is "containing:".
Date: Sun, 16 Nov 2008 22:18:32 +0000
Organization: Order N Ltd.
Message-ID: <20081116221832.1f4303ee@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 23:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1pyA-0003y4-SB
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 23:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734AbYKPWSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 17:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYKPWSf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 17:18:35 -0500
Received: from c2bthomr04.btconnect.com ([213.123.20.122]:26407 "EHLO
	c2bthomr04.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYKPWSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 17:18:34 -0500
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2bthomr04.btconnect.com
	with ESMTP id JSN48954;
	Sun, 16 Nov 2008 22:18:32 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 77FC0190CA9
	for <git@vger.kernel.org>; Sun, 16 Nov 2008 22:18:32 +0000 (GMT)
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr04.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0203.49209C38.01CE,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101169>


Highlighting the text in the commit list and comments that matches the
current find string is useful when the search type is "containing:". When
the search type is "touching paths:" or "adding/removing string:" the
highlight doesn't help so this patch suppresses the highlighting for
those search types.

Signed-off-by: Mark Burton <markb@ordern.com>
---

 Patch same as before - just made the commit message a bit clearer.

 gitk-git/gitk |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 3353f4a..dea8bc8 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4302,6 +4302,7 @@ proc askfindhighlight {row id} {
     global nhighlights commitinfo iddrawn
     global findloc
     global markingmatches
+    global gdttype
 
     if {![info exists commitinfo($id)]} {
 	getcommit $id
@@ -4326,7 +4327,7 @@ proc askfindhighlight {row id} {
 		bolden_name $row mainfontbold
 	    }
 	}
-	if {$markingmatches} {
+	if {$markingmatches && $gdttype eq [mc "containing:"]} {
 	    markrowmatches $row $id
 	}
     }
@@ -5565,6 +5566,7 @@ proc drawcmitrow {row} {
     global filehighlight fhighlights findpattern nhighlights
     global hlview vhighlights
     global highlight_related rhighlights
+    global gdttype
 
     if {$row >= $numcommits} return
 
@@ -5595,7 +5597,7 @@ proc drawcmitrow {row} {
 	set iddrawn($id) 1
 	incr nrows_drawn
     }
-    if {$markingmatches} {
+    if {$markingmatches && $gdttype eq [mc "containing:"]} {
 	markrowmatches $row $id
     }
 }
@@ -6227,7 +6229,8 @@ proc findselectline {l} {
     set markingmatches 1
     set findcurline $l
     selectline $l 1
-    if {$findloc == [mc "All fields"] || $findloc == [mc "Comments"]} {
+    if {$gdttype eq [mc "containing:"] &&
+	($findloc == [mc "All fields"] || $findloc == [mc "Comments"])} {
 	# highlight the matches in the comments
 	set f [$ctext get 1.0 $commentend]
 	set matches [findmatches $f]
-- 
1.6.0.4
