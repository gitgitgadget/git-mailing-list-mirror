From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 1/3] t7503/4: Add failing testcases for revert/cherry-pick --no-verify
Date: Wed,  3 Sep 2014 16:03:52 +0200
Message-ID: <1409753034-9459-2-git-send-email-johan@herland.net>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
Cc: =?UTF-8?q?Lars=20Gullik=20Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 16:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPBJi-0005c5-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 16:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbaICONk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 10:13:40 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:16540 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589AbaICONj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 10:13:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AioFAK8eB1StJV2T/2dsb2JhbABZgw1TV8hKh1ABgQsWd4QEAQV5EFFXGYhCvWgBF49NBxaENgWVYJwbghuBSDsvgQYkgSUBAQE
X-IronPort-AV: E=Sophos;i="5.04,457,1406592000"; 
   d="scan'208";a="74567763"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-5.cisco.com with ESMTP; 03 Sep 2014 14:04:04 +0000
Received: from jherland.rd.tandberg.com ([10.47.39.59])
	by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id s83E41HB005685;
	Wed, 3 Sep 2014 14:04:03 GMT
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1409753034-9459-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256393>

The revert/cherry-pick machinery currently exercises the pre-commit
and commit-msg hooks. However, where commit accepts a --no-verify
option to temporarily disable these hooks, the revert and cherry-pick
commands have no such option.

This patch adds some testcases demonstrating how the --no-verify
option is supposed when it is added to revert and cherry-pick
(in the next patch).

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7503-pre-commit-hook.sh | 24 ++++++++++++++++++++++++
 t/t7504-commit-msg-hook.sh | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..adc892b 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -60,6 +60,18 @@ test_expect_success 'with failing hook' '
 
 '
 
+test_expect_success 'revert with failing hook' '
+
+	test_must_fail git revert HEAD
+
+'
+
+test_expect_success 'cherry-pick with failing hook' '
+
+	test_must_fail git cherry-pick --no-verify HEAD^
+
+'
+
 test_expect_success '--no-verify with failing hook' '
 
 	echo "stuff" >> file &&
@@ -68,6 +80,18 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_failure 'revert --no-verify with failing hook' '
+
+	git revert --no-verify HEAD
+
+'
+
+test_expect_failure 'cherry-pick --no-verify with failing hook' '
+
+	git cherry-pick --no-verify HEAD^
+
+'
+
 chmod -x "$HOOK"
 test_expect_success POSIXPERM 'with non-executable hook' '
 
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 1f53ea8..4f8b9fe 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -109,6 +109,18 @@ test_expect_success 'with failing hook' '
 
 '
 
+test_expect_success 'revert with failing hook' '
+
+	test_must_fail git revert HEAD
+
+'
+
+test_expect_success 'cherry-pick with failing hook' '
+
+	test_must_fail git cherry-pick --no-verify HEAD^
+
+'
+
 test_expect_success 'with failing hook (editor)' '
 
 	echo "more another" >> file &&
@@ -126,6 +138,18 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_failure 'revert --no-verify with failing hook' '
+
+	git revert --no-verify HEAD
+
+'
+
+test_expect_failure 'cherry-pick --no-verify with failing hook' '
+
+	git cherry-pick --no-verify HEAD^
+
+'
+
 test_expect_success '--no-verify with failing hook (editor)' '
 
 	echo "more stuff" >> file &&
-- 
2.0.0.rc4.501.gdaf83ca
