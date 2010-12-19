From: maximilian attems <max@stro.at>
Subject: [PATCH] am: Allow passing exclude and include args to apply
Date: Sun, 19 Dec 2010 17:17:41 +0100
Message-ID: <1292775461-26762-1-git-send-email-max@stro.at>
Cc: Junio C Hamano <gitster@pobox.com>, klibc@zytor.com,
	maximilian attems <max@stro.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 19 17:17:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PULxM-0007xa-Cn
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab0LSQRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 11:17:51 -0500
Received: from vostochny.stro.at ([78.47.22.85]:33509 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab0LSQRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 11:17:50 -0500
Received: from stro.at (178.112.199.118.wireless.dyn.drei.com [178.112.199.118])
	by vostochny.stro.at (Postfix) with ESMTPA id 2052AC05C;
	Sun, 19 Dec 2010 16:17:49 +0000 (UTC)
Received: by stro.at (Postfix, from userid 1000)
	id 01569204A7; Sun, 19 Dec 2010 17:17:47 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163959>

When porting patches from dash git to klibc git,
where dash has a different directory structure those
switches are handy:
Exported with format-patch on dash side and used am
as import for klibc side.

Signed-off-by: maximilian attems <max@stro.at>
---
 Documentation/git-am.txt |    5 ++++-
 git-am.sh                |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 51297d0..4c65dba 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 	 [--3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
-	 [--reject] [-q | --quiet] [--scissors | --no-scissors]
+	 [--exclude=PATH] [--include=PATH] [--reject] [-q | --quiet]
+	 [--scissors | --no-scissors]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
 
@@ -87,6 +88,8 @@ default.   You can use `--no-utf8` to override this.
 -C<n>::
 -p<n>::
 --directory=<dir>::
+--exclude=<path-pattern>::
+--include=<path-pattern>::
 --reject::
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
diff --git a/git-am.sh b/git-am.sh
index df09b42..174f6a2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -22,6 +22,8 @@ whitespace=     pass it through git-apply
 ignore-space-change pass it through git-apply
 ignore-whitespace pass it through git-apply
 directory=      pass it through git-apply
+exclude=        pass it through git-apply
+include=        pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 patch-format=   format the patch(es) are in
@@ -340,7 +342,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace|--directory)
+	--whitespace|--directory|--exclude|--include)
 		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
 		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
-- 
1.7.2.3
