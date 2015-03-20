From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 26/27] t/*svn*: fix moderate &&-chain breakage
Date: Fri, 20 Mar 2015 15:32:55 +0100
Message-ID: <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
References: <550C2E7B.3030203@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 15:33:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYxyy-0004HY-HA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 15:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbbCTOc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 10:32:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55431 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131AbbCTOc6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 10:32:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id EF49720A91
	for <git@vger.kernel.org>; Fri, 20 Mar 2015 10:32:55 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 20 Mar 2015 10:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:from:to:cc:subject:date:message-id:in-reply-to
	:references; s=mesmtp; bh=uyLZ0HLRlx/8CBTJy8ql6id6jfk=; b=CNzCy/
	13KH/MaGDbcOeD5NP0lH/dgHunhmZsh4k6bkcl/EhUd2Y2qGBMyot4WI4ps8H1ki
	td0hY3mGhOS0NlQSkJEQsANXjYn20+0s7DOifRfDuJIO/gjQLNmhF5saBk0toTZQ
	KTa9BaJ2pIQXXHbLKAEE21y19LxKdEJiN+01o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=uyLZ0HLRlx/8CB
	TJy8ql6id6jfk=; b=qLcRskfKcKtD338bkRnSXOhBz6bGN0Os4ErfwKv5ZdIkyA
	8xewFO+B0GP/G+La6PY2hXt/si1brLf7iBwWfGkOstWt7BUa/yRJckrfnRtU2tUD
	DLox/MJD2yhF90+Af6jYVQR5Yqa0i3ItNk080TQo+LvVNVXvbFqsQ+19guAM0=
X-Sasl-enc: qZJUFP3gRCdrtO5hFhrT2yozcKa+472nw/aUYrf0WWmm 1426861977
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C2798C00013;
	Fri, 20 Mar 2015 10:32:57 -0400 (EDT)
X-Mailer: git-send-email 2.3.3.438.g7254779
In-Reply-To: <550C2E7B.3030203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265907>

All of these cases are moderate since they would most probably not
lead to missed failing tests: Either they would fail otherwise,
or fail a rm in test_when_finished only.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t2026-prune-linked-checkouts.sh |  4 ++--
 t/t9158-git-svn-mergeinfo.sh      |  4 ++--
 t/t9161-git-svn-mergeinfo-push.sh | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t2026-prune-linked-checkouts.sh b/t/t2026-prune-linked-checkouts.sh
index 2936d52..e885baf 100755
--- a/t/t2026-prune-linked-checkouts.sh
+++ b/t/t2026-prune-linked-checkouts.sh
@@ -65,7 +65,7 @@ test_expect_success 'prune directories with gitdir pointing to nowhere' '
 '
 
 test_expect_success 'not prune locked checkout' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir -p .git/worktrees/ghi &&
 	: >.git/worktrees/ghi/locked &&
 	git prune --worktrees &&
@@ -73,7 +73,7 @@ test_expect_success 'not prune locked checkout' '
 '
 
 test_expect_success 'not prune recent checkouts' '
-	test_when_finished rm -r .git/worktrees
+	test_when_finished rm -r .git/worktrees &&
 	mkdir zz &&
 	mkdir -p .git/worktrees/jlm &&
 	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
diff --git a/t/t9158-git-svn-mergeinfo.sh b/t/t9158-git-svn-mergeinfo.sh
index 8c9539e..13f78f2 100755
--- a/t/t9158-git-svn-mergeinfo.sh
+++ b/t/t9158-git-svn-mergeinfo.sh
@@ -34,7 +34,7 @@ test_expect_success 'change svn:mergeinfo' '
 '
 
 test_expect_success 'verify svn:mergeinfo' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk) &&
 	test "$mergeinfo" = "/branches/foo:1-10"
 '
 
@@ -46,7 +46,7 @@ test_expect_success 'change svn:mergeinfo multiline' '
 '
 
 test_expect_success 'verify svn:mergeinfo multiline' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/trunk) &&
 	test "$mergeinfo" = "/branches/bar:1-10
 /branches/other:3-5,8,10-11"
 '
diff --git a/t/t9161-git-svn-mergeinfo-push.sh b/t/t9161-git-svn-mergeinfo-push.sh
index 6cb0909..f113aca 100755
--- a/t/t9161-git-svn-mergeinfo-push.sh
+++ b/t/t9161-git-svn-mergeinfo-push.sh
@@ -24,7 +24,7 @@ test_expect_success 'propagate merge information' '
 	'
 
 test_expect_success 'check svn:mergeinfo' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1) &&
 	test "$mergeinfo" = "/branches/svnb2:3,8"
 	'
 
@@ -34,7 +34,7 @@ test_expect_success 'merge another branch' '
 	'
 
 test_expect_success 'check primary parent mergeinfo respected' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1) &&
 	test "$mergeinfo" = "/branches/svnb2:3,8
 /branches/svnb3:4,9"
 	'
@@ -45,7 +45,7 @@ test_expect_success 'merge existing merge' '
 	'
 
 test_expect_success "check both parents' mergeinfo respected" '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1) &&
 	test "$mergeinfo" = "/branches/svnb2:3,8
 /branches/svnb3:4,9
 /branches/svnb4:5-6,10-12
@@ -70,7 +70,7 @@ test_expect_success 'second forward merge' '
 	'
 
 test_expect_success 'check new mergeinfo added' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb1) &&
 	test "$mergeinfo" = "/branches/svnb2:3,8,16-17
 /branches/svnb3:4,9
 /branches/svnb4:5-6,10-12
@@ -84,7 +84,7 @@ test_expect_success 'reintegration merge' '
 	'
 
 test_expect_success 'check reintegration mergeinfo' '
-	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4)
+	mergeinfo=$(svn_cmd propget svn:mergeinfo "$svnrepo"/branches/svnb4) &&
 	test "$mergeinfo" = "/branches/svnb1:2-4,7-9,13-18
 /branches/svnb2:3,8,16-17
 /branches/svnb3:4,9
-- 
2.3.3.438.g7254779
