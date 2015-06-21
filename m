From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 3/7] verify-commit: add test for exit status on untrusted signature
Date: Sun, 21 Jun 2015 23:14:39 +0000
Message-ID: <1434928483-105916-4-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oSG-0006Af-98
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbbFUXPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51187 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321AbbFUXOz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:55 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DCF4828096;
	Sun, 21 Jun 2015 23:14:54 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272300>

verify-tag exits successfully if the signature is good but the key is
untrusted.  verify-commit exits unsuccessfully.  This divergence in
behavior is unexpected and unwanted.  Since verify-tag existed earlier,
add a failing test to have verify-commit share verify-tag's behavior.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t7510-signed-commit.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 13331e5..4fc376e 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -81,6 +81,13 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
+test_expect_failure GPG 'verify-commit exits success on untrusted signature' '
+	git verify-commit eighth-signed-alt 2>actual &&
+	grep "Good signature from" actual &&
+	! grep "BAD signature from" actual &&
+	grep "not certified" actual
+'
+
 test_expect_success GPG 'show signed commit with signature' '
 	git show -s initial >commit &&
 	git show -s --show-signature initial >show &&
-- 
2.4.0
