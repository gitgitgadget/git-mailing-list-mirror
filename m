From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/4] gitk: add "--no-replace-objects" option
Date: Sun, 22 Nov 2009 07:56:43 +0100
Message-ID: <20091122065645.4811.99983.chriscool@tuxfamily.org>
References: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 07:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC6MU-0000Ul-Ae
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 07:55:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbZKVGze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 01:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZKVGzY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 01:55:24 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38971 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbZKVGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 01:55:22 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 48E6D8180A3;
	Sun, 22 Nov 2009 07:55:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0740E81804E;
	Sun, 22 Nov 2009 07:55:17 +0100 (CET)
X-git-sha1: bbc42c7e76a9aeb56cc5b9624e8dd09627aa463e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091122064652.4811.38993.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133427>

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
