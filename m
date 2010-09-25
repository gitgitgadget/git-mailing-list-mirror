From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/3] rev-parse: add tests for git rev-parse --flags.
Date: Sat, 25 Sep 2010 21:22:42 +1000
Message-ID: <1285413763-25082-3-git-send-email-jon.seymour@gmail.com>
References: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 13:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzSni-0002GO-6L
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 13:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab0IYLUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 07:20:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55544 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531Ab0IYLUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 07:20:01 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1012477pxi.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JuZY2UgjYPAW3+2wWpSGmVlQ6GKFULbO4Bp2YEFfBl8=;
        b=F9TIHqd2BrjMg03wt+2NuRDZaGj0eYry6IfXJBiAf7BXg9ma5cu2WeubMZL9bu4Bh7
         mhv7Ez8IRiYAN2OQDiZJgqIxs5wSCzS0VCy9UXq41OXI53LxyhLJ9HjlW2SDOKKgIaLI
         Ym5qxsKiBwu88yCZIXCGzeqJ4YCbU2pUGNT5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aasMnVRA2XqPlFf5yMGRzyGMRXQsKzhSXtsp0BRUSdVVGTrVoov+hxJVTFq4mR2lbM
         mgAiyqCteqdFRIpymPPwIfgARrbmgpgC/T3l3PATOSKtaHRy9xo8s9pdUjdRZRjAdpq8
         MbQOBt6Tc6cmrdFN6hw8v/qQMKGpQx/Zti1h8=
Received: by 10.143.32.14 with SMTP id k14mr3919699wfj.265.1285413601327;
        Sat, 25 Sep 2010 04:20:01 -0700 (PDT)
Received: from localhost.localdomain ([120.16.63.67])
        by mx.google.com with ESMTPS id o16sm3755003wfh.7.2010.09.25.04.19.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 04:20:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2.g216ca.dirty
In-Reply-To: <1285413763-25082-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157146>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1510-rev-parse-flags.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
new file mode 100755
index 0000000..53002df
--- /dev/null
+++ b/t/t1510-rev-parse-flags.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='test git rev-parse --flags'
+. ./test-lib.sh
+
+test_commit "A"
+
+test_expect_success 'git rev-parse --flags -> ""' \
+'
+	: >expected &&
+	git rev-parse --flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags X -> ""' \
+'
+	: >expected &&
+	git rev-parse --flags X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
+'
+	: >expected &&
+	git rev-parse --no-revs --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"' \
+'
+	echo HEAD > expected &&
+	git rev-parse --symbolic --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -> ""' \
+'
+	: >expected &&
+	git rev-parse --flags -- >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- X -> ""' \
+'
+	: >expected &&
+	git rev-parse --flags -- X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -X -> ""' \
+'
+	: >expected &&
+	git rev-parse --flags -- -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -q --> ""' \
+'
+	: >expected &&
+	git rev-parse --flags -- -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -> "-X"' \
+'
+	echo -X > expected &&
+	git rev-parse --flags -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -q -> "-q"' \
+'
+	echo -q > expected &&
+	git rev-parse --flags -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -- Y -Z -> "-X"' \
+'
+	echo -X > expected &&
+	git rev-parse --flags -X -- Y -Z >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags --no-flags -> "--no-flags"' \
+'
+	echo --no-flags > expected &&
+	git rev-parse --flags --no-flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-flags --flags -X -> ""' \
+'
+	: >expected &&
+	git rev-parse --no-flags --flags -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --symbolic --no-flags --flags HEAD -> "HEAD"' \
+'
+	echo HEAD >expected &&
+	git rev-parse --symbolic --no-flags --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.3.2.g216ca.dirty
