From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/9] am: parse options in stuck-long mode
Date: Fri, 24 Jan 2014 00:51:00 +0000
Message-ID: <1390524666-51274-4-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Uzo-0001lT-7C
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaAXAvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:41 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51327 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753234AbaAXAvT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:19 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 27FA82807F;
	Fri, 24 Jan 2014 00:51:18 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240988>

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
1.9.rc0.1002.gd081c64.dirty
