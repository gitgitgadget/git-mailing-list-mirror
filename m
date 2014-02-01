From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/9] am: parse options in stuck-long mode
Date: Sat,  1 Feb 2014 02:18:00 +0000
Message-ID: <1391221086-1044384-4-git-send-email-sandals@crustytoothpaste.net>
References: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 01 03:18:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9QAT-0008J1-53
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 03:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbaBACSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 21:18:15 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51544 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754368AbaBACSM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 21:18:12 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 51DFC2807F;
	Sat,  1 Feb 2014 02:18:11 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc1.1006.g81f3755.dirty
In-Reply-To: <1391221086-1044384-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241332>

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
1.9.rc1.1006.g13f506b.dirty
