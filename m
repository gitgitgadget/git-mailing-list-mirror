From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH gitk 2/4] gitk: split out diff part in $commitinfo
Date: Sun, 9 Jun 2013 21:44:13 +0200
Message-ID: <d69e0570e081412e0fdc0d5cbf1ddbc32df09575.1370806329.git.trast@inf.ethz.ch>
References: <cover.1370806329.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllXZ-0003Xs-Al
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab3FIToW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:44:22 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:11316 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab3FIToT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:44:19 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:10 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:15 +0200
X-Mailer: git-send-email 1.8.3.496.g0d0267b
In-Reply-To: <cover.1370806329.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227153>

So far we just parsed everything after the headers into the "comment"
bit of $commitinfo, including notes and -- if you gave weird options
-- the diff.

Split out the diff, if any, into a separate field.  It's easy to
recognize, since the log message is indented but the /^diff / that
starts a diff is not.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 81dce20..261bda8 100755
--- a/gitk
+++ b/gitk
@@ -1704,8 +1704,14 @@ proc parsecommit {id contents listed} {
 	set comment $newcomment
     }
     set hasnote [string first "\nNotes:\n" $contents]
+    set diff ""
+    set i [string first "\ndiff" $comment]
+    if {$i >= 0} {
+	set diff [string range $comment $i end]
+	set comment [string range $comment 0 $i]
+    }
     set commitinfo($id) [list $headline $auname $audate \
-			     $comname $comdate $comment $hasnote]
+			     $comname $comdate $comment $hasnote $diff]
 }
 
 proc getcommit {id} {
-- 
1.8.3.496.g0d0267b
