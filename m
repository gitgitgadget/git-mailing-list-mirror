From: jjengla@sandia.gov
Subject: [PATCH] Add post-merge hook.
Date: Thu, 30 Aug 2007 16:40:17 -0600
Message-ID: <11885136172952-git-send-email-jjengla@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Josh England" <jjengla@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 00:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQsi6-0001qk-6B
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762996AbXH3Wly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762891AbXH3Wly
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:41:54 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:3995 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762756AbXH3Wlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 18:41:53 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Thu, 30 Aug 2007 16:41:32 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from ES23SNLNT.srn.sandia.gov (ec04snlnt.sandia.gov
 [134.253.164.156] (may be forged)) by mailgate.sandia.gov (
 8.14.0/8.14.0) with ESMTP id l7UMfVQn028708 for <git@vger.kernel.org>;
 Thu, 30 Aug 2007 16:41:31 -0600
Received: from ef01snlnt.srn.sandia.gov ([134.253.164.107]) by
 ES23SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Thu, 30
 Aug 2007 16:41:31 -0600
Received: from truth ([134.253.45.6]) by ef01snlnt.srn.sandia.gov with
 Microsoft SMTPSVC(6.0.3790.3959); Thu, 30 Aug 2007 16:41:31 -0600
Received: by truth (sSMTP sendmail emulation); Thu, 30 Aug 2007 16:40:17
 -0600
X-Mailer: git-send-email 1.5.3.rc7-dirty
X-OriginalArrivalTime: 30 Aug 2007 22:41:31.0629 (UTC)
 FILETIME=[E93F19D0:01C7EB56]
X-TMWD-Spam-Summary: TS=20070830224134; SEV=2.2.2; DFV=B2007083020;
 IFV=2.0.4,4.0-9; AIF=B2007083020; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364437343739442E303036423A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007083020_5.02.0125_4.0-9
X-WSS-ID: 6AC998162E0914806-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57085>

From: Josh England <jjengla@sandia.gov>

This adds a post-merge hook that will run after `git pull` operations
if enabled.  The hook is passed no arguments and cannot affect the
outcome of a merge.

Signed-off-by: Josh England <jjengla@sandia.gov>
---
 Documentation/hooks.txt |    8 ++++++++
 git-merge.sh            |    6 ++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index c39edc5..841b37f 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -87,6 +87,14 @@ parameter, and is invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git-commit`.
 
+post-merge
+-----------
+
+This hook is invoked by `git-merge`, which happens when a `git pull`
+is done on a local repository.
+
+The hook takes no parameters, and cannot affect the outcome of `git-merge`.
+
 [[pre-receive]]
 pre-receive
 -----------
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..0a77bfb 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -97,6 +97,12 @@ finish () {
 		fi
 		;;
 	esac
+
+	# Run a post-merge hook
+        if test -x "$GIT_DIR"/hooks/post-merge
+        then
+                "$GIT_DIR"/hooks/post-merge
+        fi
 }
 
 merge_name () {
-- 
1.5.3.rc7-dirty
