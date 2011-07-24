From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 1/2] Add a test to check that git ls-tree sets non-zero exit code on error.
Date: Sun, 24 Jul 2011 11:07:49 +1000
Message-ID: <1311469670-15392-2-git-send-email-jon.seymour@gmail.com>
References: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 03:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QknB6-0000ki-Lf
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 03:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab1GXBIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 21:08:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57057 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab1GXBIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 21:08:05 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so5971353pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 18:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Hv4a3TU2QSE7m0cScz69xdVOcGC68+Z1xc5qhV1dwYU=;
        b=uwA2Ms7envucxMxULmlmWFWt79siza8AlsA0jvzP9Yw11Y3ZQNmXnPfBOT7/rRVMjl
         XzX8LTXpV3nYe6xq6tsqr5BuQq5RIyWNS9Xp7PGj+LKDgTMTN5qfkKB9uJMupqOEbnHj
         j03r+MnY78Llvo9ZD27bp7VUb6a0ytEBwItrg=
Received: by 10.68.13.105 with SMTP id g9mr5293170pbc.135.1311469685434;
        Sat, 23 Jul 2011 18:08:05 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id d1sm3160283pbj.72.2011.07.23.18.08.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 18:08:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b
In-Reply-To: <1311469670-15392-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177708>

Expected to fail at this commit, fixed by subsequent commit.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3103-ls-tree-missing-tree.sh |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 t/t3103-ls-tree-missing-tree.sh

diff --git a/t/t3103-ls-tree-missing-tree.sh b/t/t3103-ls-tree-missing-tree.sh
new file mode 100755
index 0000000..cd17fa7
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
+test_expect_failure 'ls-tree fails with non-zero exit code on broken tree' '
+	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	test_must_fail git ls-tree -r HEAD
+'
+
+test_done
-- 
1.7.6.347.g96e0b
