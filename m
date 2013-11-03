From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH 3/8] am: parse options in stuck-long mode
Date: Sun,  3 Nov 2013 16:54:19 +0100
Message-ID: <1383494064-5653-4-git-send-email-boklm@mars-attacks.org>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 16:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd01D-00088f-84
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 16:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab3KCPyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 10:54:54 -0500
Received: from mx0.mars-attacks.org ([92.243.25.60]:35785 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820Ab3KCPys (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 10:54:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id D728148C2
	for <git@vger.kernel.org>; Sun,  3 Nov 2013 16:55:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WelCbsa0nCY4; Sun,  3 Nov 2013 16:55:03 +0100 (CET)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 54C643ECC;
	Sun,  3 Nov 2013 16:55:03 +0100 (CET)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id ED5E243934; Sun,  3 Nov 2013 16:54:46 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237267>

There is no functionnal change. The reason for this change is to be able
to add a new option taking an optional argument.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 git-am.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a3b6f988229c..020abf6940bd 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -4,7 +4,7 @@
 
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
-OPTIONS_STUCKLONG=
+OPTIONS_STUCKLONG=t
 OPTIONS_SPEC="\
 git am [options] [(<mbox>|<Maildir>)...]
 git am [options] (--continue | --skip | --abort)
@@ -414,14 +414,14 @@ it will be removed. Please do not use it anymore."
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
-	--resolvemsg)
-		shift; resolvemsg=$1 ;;
-	--whitespace|--directory|--exclude|--include)
-		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
-	-C|-p)
-		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-	--patch-format)
-		shift ; patch_format="$1" ;;
+	--resolvemsg=*)
+		resolvemsg="${1#--resolvemsg=}" ;;
+	--whitespace=*|--directory=*|--exclude=*|--include=*)
+		git_apply_opt="$git_apply_opt $(sq "$1")" ;;
+	-C*|-p*)
+		git_apply_opt="$git_apply_opt $(sq "$1")" ;;
+	--patch-format=*)
+		patch_format="${1#--patch-format=}" ;;
 	--reject|--ignore-whitespace|--ignore-space-change)
 		git_apply_opt="$git_apply_opt $1" ;;
 	--committer-date-is-author-date)
-- 
1.8.4.2
