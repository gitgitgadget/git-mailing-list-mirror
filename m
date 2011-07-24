From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/2] Add a test to check that git ls-tree sets non-zero exit code on error.
Date: Mon, 25 Jul 2011 00:59:13 +1000
Message-ID: <1311519554-16587-2-git-send-email-jon.seymour@gmail.com>
References: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 16:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ql09f-0008BH-Ih
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab1GXO7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:59:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52528 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1GXO7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:59:33 -0400
Received: by gwaa18 with SMTP id a18so2259926gwa.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1ZndThzw8eXrSicbjoicI6cJlaWgHyeU1Z6weDu2Olk=;
        b=xTxAWxW2VeWCc+71VWks8bHdl89ah5hwyXEhFFIBdcuwknpLszGSx4eVyCE2CMN5Yo
         ScleLhsLEoYcACAHdiEGi4288VX2CpXQWwo6mR7U9Pj1o5WqVHsDFOOEGuedBufEc1gn
         h7yLWdefUTQLL1lGzaNWCSqQVtEyMVHmUmrMI=
Received: by 10.236.181.10 with SMTP id k10mr4547536yhm.516.1311519572614;
        Sun, 24 Jul 2011 07:59:32 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id v25sm3598186yhk.8.2011.07.24.07.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:59:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.gf855
In-Reply-To: <1311519554-16587-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177763>

Expected to fail at this commit, fixed by subsequent commit.

Additional tests of adhoc or uncategorised nature should be added to this
file.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3103-ls-tree-misc.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100755 t/t3103-ls-tree-misc.sh

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
new file mode 100755
index 0000000..c9c20f9
--- /dev/null
+++ b/t/t3103-ls-tree-misc.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='
+Miscellaneous tests for git ls-tree.
+
+	      1. git ls-tree fails in presence of tree damage.
+
+'
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
+test_expect_failure 'ls-tree fails with non-zero exit code on broken tree' '
+	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	test_must_fail git ls-tree -r HEAD
+'
+
+test_done
-- 
1.7.6.347.gf855
