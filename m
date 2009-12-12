From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH RESEND] gitk: add "--no-replace-objects" option
Date: Sat, 12 Dec 2009 05:52:39 +0100
Message-ID: <20091212045240.4249.66874.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Dec 12 05:53:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJJzI-0007ly-D2
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 05:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761217AbZLLEx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 23:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761186AbZLLEx0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 23:53:26 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36156 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759163AbZLLEx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 23:53:26 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B330781805F;
	Sat, 12 Dec 2009 05:53:24 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id AE9F9818045;
	Sat, 12 Dec 2009 05:53:20 +0100 (CET)
X-git-sha1: cb1573b18ff6b9b73e272beb1b4e50d50d4dee18 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135123>

Replace refs are useful to change some git objects after they
have started to be shared between different repositories. One
might want to ignore them to see the original state, and
"--no-replace-objects" option can be used from the command
line to do so.

This option simply sets the GIT_NO_REPLACE_OBJECTS environment
variable, and that is enough to make gitk ignore replace refs.

The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
safer on some platforms, thanks to Johannes Sixt and Michael J
Gruber.

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gitk-git/gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

	I previously sent this patch as part of a series:

	http://thread.gmane.org/gmane.comp.version-control.git/133423/focus=133427

	and it looks like it has been lost.

	Thanks in advance.

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 364c7a8..86dff0f 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -130,7 +130,7 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs
+    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -210,6 +210,9 @@ proc parseviewargs {n arglist} {
 		# git rev-parse doesn't understand --merge
 		lappend revargs --gitk-symmetric-diff-marker MERGE_HEAD...HEAD
 	    }
+	    "--no-replace-objects" {
+		set env(GIT_NO_REPLACE_OBJECTS) "1"
+	    }
 	    "-*" {
 		# Other flag arguments including -<n>
 		if {[string is digit -strict [string range $arg 1 end]]} {
-- 
1.6.6.rc1.8.gd33ec
