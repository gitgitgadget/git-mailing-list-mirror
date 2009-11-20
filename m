From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] gitk: add --no-replace-objects option
Date: Fri, 20 Nov 2009 20:40:45 +0100
Message-ID: <20091120194046.4469.53971.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 20:39:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBZKN-0004Es-EK
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 20:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbZKTTjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 14:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbZKTTjT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 14:39:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:40020 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbZKTTjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 14:39:19 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 014AB81809A;
	Fri, 20 Nov 2009 20:39:15 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F10698181A5;
	Fri, 20 Nov 2009 20:39:11 +0100 (CET)
X-git-sha1: 35a01daa7ad61c5549403167910626588943b6bd 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133371>

This option simply sets the GIT_NO_REPLACE_OBJECTS environment
variable, and that is enough to make gitk ignore replace refs.

The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
safer on some platforms, thanks to Johannes Sixt and Michael J
Gruber.

Replace refs are useful to change some git objects after they
have started to be shared between different repositories. One
might want to ignore them to see the original state.

Tested-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gitk-git/gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..c586b93 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -128,7 +128,7 @@ proc unmerged_files {files} {
 }
 
 proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs
+    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
 
     set vdatemode($n) 0
     set vmergeonly($n) 0
@@ -208,6 +208,9 @@ proc parseviewargs {n arglist} {
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
1.6.5.1.gaf97d
