From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] t7508: test advice.statusHints
Date: Thu, 22 Apr 2010 22:30:19 +0200
Message-ID: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
References: <7v39yo53mt.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 22:31:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O533M-0004X8-M0
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488Ab0DVUa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:30:29 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58732 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758004Ab0DVUa0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 16:30:26 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D7D9DEBF36;
	Thu, 22 Apr 2010 16:30:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 22 Apr 2010 16:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=2s9rR+Z8GajdXdyyuOxSJ0Bd0pQ=; b=SszrOBpYlYS1E50TfVsiJu0yQVc3ATn+x5lskYqJx+1Evl9SD+4W76+Cr2o0sn1b2WnObiLhHi9PtyeoCMGVh0shMWlWrovQiLJisttof5CatdRmgiHmLC3wgu2EJy4czD71BSNTf5RuHnSdl4zH+AE+RKkRWrRa46pIyZD1kpU=
X-Sasl-enc: R8UaK1XGFml+of5vMR844iZxqQAjijC9kKOGBT09srFY 1271968223
Received: from localhost (p5DCC0786.dip0.t-ipconnect.de [93.204.7.134])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BF7E24B3507;
	Thu, 22 Apr 2010 16:30:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
In-Reply-To: <7v39yo53mt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145557>

edf563f (status: make "how to stage" messages optional, 2009-09-09)
introduced advice.statusHints without tests. Add a few tests to describe
and test the status quo.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7508-status.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 556d0fa..7409a06 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -69,6 +69,34 @@ test_expect_success 'status (2)' '
 '
 
 cat >expect <<\EOF
+# On branch master
+# Changes to be committed:
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#	modified:   dir1/modified
+#
+# Untracked files:
+#	dir1/untracked
+#	dir2/modified
+#	dir2/untracked
+#	expect
+#	output
+#	untracked
+EOF
+
+git config advice.statusHints false
+
+test_expect_success 'status (advice.statusHints false)' '
+
+	git status >output &&
+	test_cmp expect output
+
+'
+
+git config --unset advice.statusHints
+
+cat >expect <<\EOF
  M dir1/modified
 A  dir2/added
 ?? dir1/untracked
@@ -115,6 +143,23 @@ test_expect_success 'status (status.showUntrackedFiles no)' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+# On branch master
+# Changes to be committed:
+#	new file:   dir2/added
+#
+# Changed but not updated:
+#	modified:   dir1/modified
+#
+# Untracked files not listed (use -u option to show untracked files)
+EOF
+git config advice.statusHints false
+test_expect_success 'status -uno (advice.statusHints false)' '
+	git status -uno >output &&
+	test_cmp expect output
+'
+git config --unset advice.statusHints
+
 cat >expect << EOF
  M dir1/modified
 A  dir2/added
-- 
1.7.1.rc1.248.gcefbb
