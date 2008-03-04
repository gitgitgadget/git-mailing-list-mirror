From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] am: remove support for -d .dotest
Date: Tue,  4 Mar 2008 00:25:05 -0800
Message-ID: <1204619106-30449-2-git-send-email-gitster@pobox.com>
References: <1204619106-30449-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 09:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSTU-0004l3-Ko
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbYCDIZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbYCDIZc
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:25:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbYCDIZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:25:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0223A387E
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4B246387D for <git@vger.kernel.org>; Tue,  4 Mar 2008 03:25:28 -0500
 (EST)
X-Mailer: git-send-email 1.5.4.3.529.gb25fb
In-Reply-To: <1204619106-30449-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76049>

It has been supported for a long time, but I do not think this feature has
been in use in the real world at all.  We would eventually move this out
of the toplevel of the work tree and to somewhere under $GIT_DIR, so let's
remove the command line option to specify the location now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2b5bbb7..25129e6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -9,7 +9,7 @@ git-am [options] <mbox>|<Maildir>...
 git-am [options] --resolved
 git-am [options] --skip
 --
-d,dotest=       use <dir> and not .dotest
+d,dotest=       (removed -- do not use)
 i,interactive   run interactively
 b,binary        pass --allo-binary-replacement to git-apply
 3,3way          allow fall back on 3way merging if needed
@@ -50,10 +50,6 @@ stop_here_user_resolve () {
     then
         cmdline="$cmdline -3"
     fi
-    if test '.dotest' != "$dotest"
-    then
-        cmdline="$cmdline -d=$dotest"
-    fi
     echo "When you have resolved this problem run \"$cmdline --resolved\"."
     echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
 
@@ -125,7 +121,7 @@ reread_subject () {
 }
 
 prec=4
-dotest="${prefix}.dotest"
+dotest=".dotest"
 sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
 git_apply_opt=
@@ -152,8 +148,8 @@ do
 	--skip)
 		skip=t ;;
 	-d|--dotest)
-		shift
-		case "$1" in /*) dotest=$1;; *) dotest="$prefix$1" ;; esac ;;
+		die "-d option is not longer supported.  Do not use."
+		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace)
@@ -189,7 +185,7 @@ then
 	0,)
 		# No file input but without resume parameters; catch
 		# user error to feed us a patch from standard input
-		# when there is already .dotest.  This is somewhat
+		# when there is already $dotest.  This is somewhat
 		# unreliable -- stdin could be /dev/null for example
 		# and the caller did not intend to feed us a patch but
 		# wanted to continue unattended.
-- 
1.5.4.3.529.gb25fb

