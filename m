From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 1/2] t1503: test rev-parse --verify --quiet with deleted reflogs
Date: Sun, 14 Sep 2014 12:03:01 -0700
Message-ID: <1410721382-97751-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 21:03:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTF4q-0005iu-S8
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbaINTDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 15:03:07 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49607 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbaINTDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 15:03:06 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so4951549pab.10
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=foC6kxnCtySfBVmLNMD7pucvHE7DVZazSgo1aFoSIWo=;
        b=OYK3nBmHDv/wsHqkOc902GBA+/rpdO9DJvggz+LkJJC1gl688qmGKJxcm34oWK/vuU
         TnYVZukAZbWKNO4PCS4feKjoMb5LFLCUZXR4MSKruRBIqgAR8uOV5xCt0B9rL980iStR
         MsR+oPD+iLGZgFclH9hXNJZT2CmxBBraKHZiGT5eLz/AMWcN7feJfEeGbR33lJVYWXLR
         JXf7RMcyKztkjMVq0CQuRahUwfOBs1dKFfpQx0lioNYlyG9WqAOVxgzUTFjTWPrZzntt
         KUYRZ8GtZ7CV2N/SiVlzDPqiPhmqd3ij4SBAkNEFJD/xNU20TrdTuxcQ/ZZiNhRJ1S0T
         vz5A==
X-Received: by 10.66.136.12 with SMTP id pw12mr31994369pab.71.1410721385436;
        Sun, 14 Sep 2014 12:03:05 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id x3sm9431337pdq.10.2014.09.14.12.03.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 12:03:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257023>

Ensure that rev-parse --verify --quiet is silent when asked
about deleted reflog entries.

Helped-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
Changes since last time:

Use "git branch test" instead of low-level plumbing commands.
Capture both stdout and stderr in the test.

 t/t1503-rev-parse-verify.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..ab9878d 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -83,6 +83,13 @@ test_expect_success 'fails silently when using -q' '
 	test -z "$(cat error)"
 '
 
+test_expect_success 'fails silently when using -q with deleted reflogs' '
+	git branch test &&
+	git reflog delete --updateref --rewrite test@{0} &&
+	test_must_fail git rev-parse -q --verify test@{0} >error 2>&1 &&
+	test -z "$(cat error)"
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.30.g05c535b.dirty
