From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add a test to check that git ls-tree sets non-zero exit code on error.
Date: Sat, 23 Jul 2011 22:27:30 +1000
Message-ID: <1311424051-29644-2-git-send-email-jon.seymour@gmail.com>
References: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 14:27:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkbJH-0004cp-FL
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 14:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab1GWM1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 08:27:51 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48185 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab1GWM1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 08:27:50 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so5170930pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/bnwn1oMP14tpIuN0C611KoKM0oMnu37+zKIItk/7b0=;
        b=E+XU+TA8B24y30kjo8oL20ljc4EkwXOxmeRfmMN6npYMXvJlVXkMs9xS312kkADCaL
         UrDnQV8jbjTN1kc1Avqd+J0ofZG08pO6c+HyyKQf4CgIOdSUXYUDXFwVeWK+SyfTw9mK
         QLAz1tFY7Ux8m46ulGPpdZmefDqR90ykN2/Aw=
Received: by 10.68.62.40 with SMTP id v8mr3984970pbr.129.1311424070108;
        Sat, 23 Jul 2011 05:27:50 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id q2sm2683647pbj.3.2011.07.23.05.27.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 05:27:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g6a5a9c
In-Reply-To: <1311424051-29644-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177692>

Fails at this commit, fixed by subsequent commit.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 t/t3103-ls-tree-missing-tree.sh

diff --git a/t/t3103-ls-tree-missing-tree.sh b/t/t3103-ls-tree-missing-tree.sh
new file mode 100755
index 0000000..365ac07
--- /dev/null
+++ b/t/t3103-ls-tree-missing-tree.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='ls-tree exits with non-zero status if it also reports an error'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir a &&
+	touch a/one &&
+	git add a/one &&
+	git commit -m test
+'
+
+test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
+	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	test_must_fail git ls-tree -r HEAD
+'
+
+test_done
-- 
1.7.6.347.g6a5a9c
