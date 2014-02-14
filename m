From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 3/9] am: parse options in stuck-long mode
Date: Fri, 14 Feb 2014 19:51:47 +0000
Message-ID: <1392407513-37443-4-git-send-email-sandals@crustytoothpaste.net>
References: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 20:52:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEOoB-0002uf-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbaBNTwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:52:01 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51925 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752784AbaBNTwA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:52:00 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AA94D28084;
	Fri, 14 Feb 2014 19:51:58 +0000 (UTC)
X-Mailer: git-send-email 1.9.0.rc3.1008.gd08b47c.dirty
In-Reply-To: <1392407513-37443-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242133>

From: Nicolas Vigier <boklm@mars-attacks.org>

There is no functional change. The reason for this change is to be able
to add a new option taking an optional argument.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-am.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a3b6f98..020abf6 100755
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
1.9.0.rc3.1008.gd08b47c.dirty
