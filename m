From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH v2] gitk: Show patch for initial commit
Date: Sat, 1 Oct 2011 21:05:54 +0200
Message-ID: <20111001190554.GA5854@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, zbyszek@in.waw.pl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 21:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA4sr-0007eT-42
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 21:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666Ab1JATF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 15:05:57 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:49262 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab1JATF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 15:05:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 320F94DA;
	Sat,  1 Oct 2011 21:05:55 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 7477C4D9;
	Sat,  1 Oct 2011 21:05:54 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id 57A4463; Sat,  1 Oct 2011 21:05:54 +0200 (MEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182571>

Make gitk show the patch for the initial commit by default.
Override with log.showroot.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
 gitk-git/gitk |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..40ea73f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7402,7 +7402,7 @@ proc addtocflist {ids} {
 }
 
 proc diffcmd {ids flags} {
-    global nullid nullid2
+    global log_showroot nullid nullid2
 
     set i [lsearch -exact $ids $nullid]
     set j [lsearch -exact $ids $nullid2]
@@ -7436,7 +7436,11 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree -r]
+	if {$log_showroot eq true} {
+	    set cmd [concat $cmd --root]
+	}
+	set cmd [concat $cmd $flags $ids]
     }
     return $cmd
 }
@@ -11403,6 +11407,11 @@ catch {
     }
 }
 
+set log_showroot true
+catch {
+    set log_showroot [exec git config --get log.showroot]
+}
+
 if {[tk windowingsystem] eq "aqua"} {
     set mainfont {{Lucida Grande} 9}
     set textfont {Monaco 9}
-- 
1.7.7
