From: David Greene <greened@obbligato.org>
Subject: [PATCH 2/5] Add test for cherry-pick --skip-redundant-commits
Date: Sun, 10 Jan 2016 23:00:18 -0600
Message-ID: <1452488421-26823-3-git-send-email-greened@obbligato.org>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
Cc: gitster@pobox.com, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 06:01:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIUbN-0005FY-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 06:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbcAKFAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 00:00:41 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:53953 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbcAKFAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 00:00:38 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aIUbx-0005H8-RA; Sun, 10 Jan 2016 23:01:45 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1452488421-26823-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283635>

From: "David A. Greene" <greened@obbligato.org>

Test that --skip-redundant commits suppresses an abort when
cherry-picking a redundant commit.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 t/t3514-cherry-pick-redundant.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100755 t/t3514-cherry-pick-redundant.sh

diff --git a/t/t3514-cherry-pick-redundant.sh b/t/t3514-cherry-pick-redundant.sh
new file mode 100755
index 0000000..c433344
--- /dev/null
+++ b/t/t3514-cherry-pick-redundant.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='git cherry-pick tests for redundant commits
+
+This test runs git cherry-pick and tests handling of redundant commits.
+'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three
+'
+
+test_expect_success 'cherry-pick redundant commit fails' '
+	git branch test-start &&
+	git reset --hard HEAD~2 &&
+	git cherry-pick test-start &&
+	test_must_fail git cherry-pick test-start
+'
+
+test_expect_success 'cherry-pick with --skip-redundant-commits' '
+	git cherry-pick --skip-redundant-commits test-start
+'
+
+test_done
-- 
2.6.1
