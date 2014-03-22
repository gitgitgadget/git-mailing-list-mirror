From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 04/10] t4209: use helper functions to test --grep
Date: Sat, 22 Mar 2014 18:15:54 +0100
Message-ID: <1395508560-19893-5-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXM-00025U-NW
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbaCVRQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:41 -0400
Received: from mout.web.de ([212.227.15.14]:62203 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaCVRQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:33 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MbQLE-1Whpv41APM-00IpXl; Sat, 22 Mar 2014 18:16:18
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:+6G5MfjYxBdHSJXuJTX01+hgffCNbqtDfZ6mnZzKmUYssiXgh8e
 xbRwWL6XJfSTta6bbNodvf7DuIBLg6ORITtBp2DdvnAzAcZpWs2TsjS7tBYdisoE1lG0/r3
 bHm4ELhF/W9eRuFhW4iZMJHrv7SDEaVJKKV0SmUVWnB+G8agR0HBDPZCVfbngDN5eXET4+F
 RLhLjNuZQQ89UeZKDs/dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244773>

Also add tests for non-matching cases.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4209-log-pickaxe.sh | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index dd911c2..873a10e 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -46,20 +46,10 @@ test_expect_success setup '
 	git rev-parse --verify HEAD >expect_second
 '
 
-test_expect_success 'log --grep' '
-	git log --grep=initial --format=%H >actual &&
-	test_cmp expect_initial actual
-'
-
-test_expect_success 'log --grep --regexp-ignore-case' '
-	git log --regexp-ignore-case --grep=InItial --format=%H >actual &&
-	test_cmp expect_initial actual
-'
-
-test_expect_success 'log --grep -i' '
-	git log -i --grep=InItial --format=%H >actual &&
-	test_cmp expect_initial actual
-'
+test_log	expect_initial	--grep initial
+test_log	expect_nomatch	--grep InItial
+test_log_icase	expect_initial	--grep InItial
+test_log_icase	expect_nomatch	--grep initail
 
 test_expect_success 'log --author --regexp-ignore-case' '
 	git log --regexp-ignore-case --author=person --format=%H >actual &&
-- 
1.9.1
