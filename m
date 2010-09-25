From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 2/4] rev-parse: add tests for git rev-parse --flags.
Date: Sat, 25 Sep 2010 23:33:51 +1000
Message-ID: <1285421633-22684-3-git-send-email-jon.seymour@gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 15:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUql-0002J2-ED
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab0IYNbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:31:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IYNbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:31:14 -0400
Received: by pzk34 with SMTP id 34so856009pzk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 06:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=EZDK3Cu9ekKxUur8Ydiwot2APW3HXV5ogINh0Q5lhqg=;
        b=VmfIb4VopmRoWH+SaSmcPkXixcB4vUQSVx4o4ht+y7AP+Q6as2IgFvXNR4JSa50mc4
         t8xXx0/Pg+Qa+h5KQsEAJVDzbBT5XaFQY7dZgvEwGWQasOoQHxG1Ux1MyAhyvX1oBj3N
         KQfc+94mDuQMcM8GFXQ76IOroQc/GqdiG6124=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bqYbieIgJZ9Xw9qPwHIeF6oJkv3vPjauHeA8I38GzekE8DuQWU9duzYAeJFQOfi4ct
         Q71Op0QXubqGkU3c2Wx0wXbA2zAMpoftC/xKz/7yDDT4qTPp+mVXQwUJpYT/pGGhbx/u
         Z2yWbwR/N4DzmNrKbwrkgisnyPEPQdL7hMVKc=
Received: by 10.142.132.11 with SMTP id f11mr4040607wfd.35.1285421474052;
        Sat, 25 Sep 2010 06:31:14 -0700 (PDT)
Received: from localhost.localdomain ([120.16.118.189])
        by mx.google.com with ESMTPS id l42sm3924235wfa.9.2010.09.25.06.31.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 06:31:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.ge900b
In-Reply-To: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157152>

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
1.7.3.3.gc4c52.dirty
