From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 2/4] rev-parse: add tests for git rev-parse --flags.
Date: Sun, 26 Sep 2010 02:18:33 +1000
Message-ID: <1285431515-21321-3-git-send-email-jon.seymour@gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 18:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXPs-0000Zx-Nc
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab0IYQPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 12:15:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63719 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0IYQPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 12:15:38 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so864227pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U5444WCbkXkBhIsp80h1hCxvSjQv2RVTxfK51pCbV/U=;
        b=w1S+xemCI2+8g6FW96+VN8ITrRP04qgOM+ZWbkO8tfbMZwTwE5ryyzIGm8GlNsoj19
         uo2O1C+GLxQlA3tUd10U5Q0wRVRmSUIam94VVZdoZ7Ymp0VCdI8wYItOesOhYqm/7oJE
         sU7RPMQPKKd54cb9vkckVLp23Ud++5lIo1p2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DYD4Dnd2HG/eTNoy6bXO0k/c67Fi0QcNfin4zu0WsX9S29Kx+vL1+AI7p0rzSjC2/Z
         RsrzFb47y2CYrqhinZS9V/URl220juGbMLqNoybZAfSGL//N9de4EJOIK2vbZJAFPILh
         4RM7w0pVsmkyZShUr7mrc+MvqD9cdPfQUqgxE=
Received: by 10.114.52.17 with SMTP id z17mr5489848waz.71.1285431338408;
        Sat, 25 Sep 2010 09:15:38 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id c24sm6056766wam.7.2010.09.25.09.15.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 09:15:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.g73371.dirty
In-Reply-To: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157163>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1510-rev-parse-flags.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
new file mode 100755
index 0000000..ef0b4ad
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
+	>expected &&
+	git rev-parse --flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
+'
+	>expected &&
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
+	>expected &&
+	git rev-parse --flags -- >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -q --> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -> "-X"' \
+'
+	printf "%s\n" -X > expected &&
+	git rev-parse --flags -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -q -> "-q"' \
+'
+	printf "%s\n" -q > expected &&
+	git rev-parse --flags -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -- Y -Z -> "-X"' \
+'
+	printf "%s\n" -X > expected &&
+	git rev-parse --flags -X -- Y -Z >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags --no-flags -> "--no-flags"' \
+'
+	printf "%s\n" --no-flags > expected &&
+	git rev-parse --flags --no-flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-flags --flags -X -> ""' \
+'
+	>expected &&
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
1.7.3.4.g73371.dirty
