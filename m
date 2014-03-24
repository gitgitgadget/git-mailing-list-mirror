From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/27] t1400: Add some more tests involving quoted arguments
Date: Mon, 24 Mar 2014 18:56:37 +0100
Message-ID: <1395683820-17304-5-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS985-00018N-V8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaCXR5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:20 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52486 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753747AbaCXR5S (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:18 -0400
X-AuditID: 12074412-f79d46d000002e58-68-533071fdf67e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 43.AE.11864.DF170335; Mon, 24 Mar 2014 13:57:17 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xa028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:16 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqPu30CDY4Od1Q4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aOky+ZC9bwV3TducLcwHiAp4uRk0NCwERi3+Wb
	zBC2mMSFe+vZuhi5OIQELjNKnPg/iQnCOcEkcbTzCQtIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBJXPm4HKxIW8JfYfXA6excjBweLgKrE1ocBIGFeAReJlZv2sUBsk5OY8nsBO4jNKeAq
	sbX9MNgVQkA1Oz72Mk1g5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQT
	IyT0hHYwrj8pd4hRgINRiYd3g6lBsBBrYllxZe4hRkkOJiVRXrZcoBBfUn5KZUZicUZ8UWlO
	avEhRgkOZiURXstwoBxvSmJlVWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgTv
	7QKgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQbMQXA6MDJMUDtJejEGRvcUFi
	LlAUovUUo6KUOO81kLkCIImM0jy4sbCE8opRHOhLYd5PIFU8wGQE1/0KaDAT0ODwJj2QwSWJ
	CCmpBkat8rrZ82cyvZgbevmxq9hC0auRruzG6gkCz3rEi4/rqlnmiab3PnifpxA+fbmft1fM
	8R3bmWR+W4emLa6S5ZlTO1d9aVL+Jt/8ro8Vi1/I/P3JdJPjhD9TXvbS8C/ldy+t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244836>

Previously there were no good tests of C-quoted arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 774f8c5..00862bc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -350,12 +350,18 @@ test_expect_success 'stdin fails on unknown command' '
 	grep "fatal: unknown command: unknown $a" err
 '
 
-test_expect_success 'stdin fails on badly quoted input' '
+test_expect_success 'stdin fails on unbalanced quotes' '
 	echo "create $a \"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
+test_expect_success 'stdin fails on invalid escape' '
+	echo "create $a \"ma\zter\"" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: badly quoted argument: \\\"ma\\\\zter\\\"" err
+'
+
 test_expect_success 'stdin fails on junk after quoted argument' '
 	echo "create \"$a\"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -458,6 +464,24 @@ test_expect_success 'stdin create ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin succeeds with quoted argument' '
+	git update-ref -d $a &&
+	echo "create $a \"$m\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin succeeds with escaped character' '
+	git update-ref -d $a &&
+	echo "create $a \"ma\\163ter\"" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $a >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin update ref creates with zero old value' '
 	echo "update $b $m $Z" >stdin &&
 	git update-ref --stdin <stdin &&
-- 
1.9.0
