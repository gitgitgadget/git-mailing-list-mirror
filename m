From: Mark Burton <markb@ordern.com>
Subject: [PATCH] gitk: Highlight found text only for when search type is "containing".
Date: Sat, 15 Nov 2008 23:12:49 +0000
Message-ID: <1226790769-25019-1-git-send-email-markb@ordern.com>
Cc: Mark Burton <markb@ordern.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 00:19:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1UQ1-0000cA-Nw
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 00:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYKOXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 18:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752874AbYKOXRz
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 18:17:55 -0500
Received: from c2beaomr06.btconnect.com ([213.123.26.184]:21113 "EHLO
	c2beaomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYKOXRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 18:17:54 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Nov 2008 18:17:54 EST
Received: from crow.ordern.com (host86-128-20-200.range86-128.btcentralplus.com [86.128.20.200])
	by c2beaomr06.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id ASY21775;
	Sat, 15 Nov 2008 23:12:49 GMT
Received: by crow.ordern.com (Postfix, from userid 1000)
	id 5770C190E4D; Sat, 15 Nov 2008 23:12:49 +0000 (GMT)
X-Mailer: git-send-email 1.6.0.4
X-Junkmail-Status: score=10/50, host=c2beaomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0201.491F5772.003C,ss=1,fgs=0,
	ip=86.128.20.200,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101096>

Highlighting the text in the commit list and comments that match the find
string is useful but only really when the search type is "containing".

This patch suppresses the highlighting for the other search types.


Signed-off-by: Mark Burton <markb@ordern.com>
---
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
