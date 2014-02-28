From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 12:04:18 +0900
Message-ID: <1393556659-32717-1-git-send-email-modocache@gmail.com>
Cc: modocache <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 04:04:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJDkb-0007U6-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 04:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbaB1DEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 22:04:33 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47372 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaB1DEc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 22:04:32 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so145126pad.28
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 19:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kkw9OK/2GV7wvIwqEzgEDG+i9Mu+kQGof0+rnG1HL2g=;
        b=NYzCa0t7Vr9ufU5IAt72SeP430qxgldUDGhG+80IxWovmlee4sSQSuk8M2NZLp7U3a
         GlzwtCw2EYy+U/xWhqOEEPbHdjkk+zxGITleS9/lS57qBIiwKIzcaR8Ue3oz1lksgtrA
         VqN7iiCgIFRdovrn/QDCuE1keaZwlOuHeeGp+Bj8vQil9lq3sqQyw+TnopsTu2H1IO16
         9wqwwPQnmE7SGFXt2CHA57DPQ7gjqeP5uHQ6TYbOSJyOGJNos/NelYty5nOiXgZ+dScn
         k84brbGXdG2vtzRT3Mb68uKn20BPUKFSUffz40JD1F47NRNlyh9Muo5m/gNwNOcXvclI
         cNEw==
X-Received: by 10.68.211.164 with SMTP id nd4mr674871pbc.44.1393556671978;
        Thu, 27 Feb 2014 19:04:31 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id qw8sm797392pbb.27.2014.02.27.19.04.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 19:04:31 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242882>

From: modocache <modocache@gmail.com>

No test asserts that "git branch -u refs/heads/my-branch my-branch"
emits a warning. Add a test that does so.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 t/t3200-branch.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fcdb867..f70b96f 100755
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
+	test_cmp expected actual
+'
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 $_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.8.3.4 (Apple Git-47)
