From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH v2 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 15:41:02 +0900
Message-ID: <1393569662-68351-1-git-send-email-modocache@gmail.com>
Cc: git@vger.kernel.org, Brian Gesiak <modocache@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJH8I-0000VE-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbaB1GlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:41:14 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:65332 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaB1GlO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:41:14 -0500
Received: by mail-pa0-f43.google.com with SMTP id bj1so263513pad.16
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 22:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OLWVdx4oHM6wM93NfLGUk02UNFGf9zAflZDL2TVz5IQ=;
        b=FNLUVM+cHHZ+03N6kNq0ehLu85tY3siLsL52kFnGhaNA3tlqWa8hNF/FBPLkL8LrRC
         aNro0Zb0JkEuNYnG/+h+AeKnrEoWV9N3D96i6JWGoZ3ZkWBldEOb0J2D/fEbPsrhMRl2
         rTxixq+QWDPe4nqymF+epShFXABsOKHj9SSJFnf62viVLyvCCqEw6eXyxHEhJxahy2en
         3n3Aw+VJKCufl33tK7oIkN4kKaikvUZJT0XvfvXzAM3mlYfU7OlsCt1cp4nO05SBC9zh
         lw2EF+CKf6KWeEeOyFgJJdCoInZiQ5sNuZ4bd9psDuddtCVifvIoqpF6rYCt8g6QNl6h
         4rNA==
X-Received: by 10.68.242.68 with SMTP id wo4mr1678767pbc.32.1393569673606;
        Thu, 27 Feb 2014 22:41:13 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id eb5sm6089861pad.22.2014.02.27.22.41.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 22:41:13 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242891>

No test asserts that "git branch -u refs/heads/my-branch my-branch"
emits a warning. Add a test that does so.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 t/t3200-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..6164126 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -507,6 +507,14 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
+	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
+	cat >expected <<EOF &&
+warning: Not setting branch my13 as its own upstream.
+EOF
+	test_i18ncmp expected actual
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.8.3.4 (Apple Git-47)
