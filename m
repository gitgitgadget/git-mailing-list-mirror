From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] git-mv: follow -k request even on failing renames
Date: Sun, 27 Nov 2005 22:11:33 +0100
Message-ID: <200511272211.33293.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:12:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTol-0002gI-Lz
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVK0VMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVK0VMM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:12:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:21392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751092AbVK0VMM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 16:12:12 -0500
Received: (qmail invoked by alias); 27 Nov 2005 21:12:10 -0000
Received: from p5496A06C.dip0.t-ipconnect.de (EHLO linux) [84.150.160.108]
  by mail.gmx.net (mp030) with SMTP; 27 Nov 2005 22:12:10 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12825>

-k requests to keep running on an error condition.
Previously, git-mv stopped on failing renames even with -k.

There are some error conditions which are not checked in the
first phase of git-mv, eg. 'permission denied'. Still, option
-k should work.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

 git-mv.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

applies-to: 6ff4820f59a60e776e7a853cbe0fdbb908f3d8af
190f908c52de643bcb05a11d8537551bd1df067f
diff --git a/git-mv.perl b/git-mv.perl
index 8d294d6..65b1dcf 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -151,6 +151,11 @@ while(scalar @srcs > 0) {
     if (!$opt_n) {
 	if (!rename($src,$dst)) {
 	    $bad = "renaming '$src' failed: $!";
+	    if ($opt_k) {
+		print "Warning: skipped: $bad\n";
+		$bad = "";
+		next;
+	    }
 	    last;
 	}
     }
---
0.99.9.GIT
