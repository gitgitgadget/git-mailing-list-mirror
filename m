From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Mon, 10 Mar 2014 13:46:20 +0100
Message-ID: <1394455603-2968-4-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzdP-0000Xv-KK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528AbaCJMq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:46:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47818 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMqz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:46:55 -0400
X-AuditID: 1207440e-f79c76d000003e2c-6e-531db43f685d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D5.C2.15916.F34BD135; Mon, 10 Mar 2014 08:46:55 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwR025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:46:53 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqGu/RTbYYMopZoud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8a9ye9YCg5wVlybVdvAeJm9i5GTQ0LARGLr8f0s
	ELaYxIV769m6GLk4hAQuM0pM37KcFSQhJHCCSaL/Wy2IzSagK7Gop5kJxBYRUJOY2HaIBaSB
	WeAKo8Tnr7/ApgoL+EgcfbMKbCqLgKrE9YmNYHFeAWeJGdumMENsk5OY8nsBWJxTwEVi+pUH
	7BDLnCVe7mlmncDIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrFebmaJXmpK6SZGSODx
	7WBsXy9ziFGAg1GJh/fAW5lgIdbEsuLK3EOMkhxMSqK8E9fKBgvxJeWnVGYkFmfEF5XmpBYf
	YpTgYFYS4c1cDJTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwHt4M
	1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPZuA2nnLS5IzAWK
	QrSeYlSUEuedA5IQAElklObBjYWlk1eM4kBfCvO2glTxAFMRXPcroMFMQIObj0uBDC5JREhJ
	NTCWxgfNmTLX92q9QYRMgE/Cw7uvZR78unBRqlhR8+h3hcCErMbMeZf2/dv8UffOtoe5U51d
	pws12D6ombaHXfKEcCjzjniNYhOPo9yMex5v/O/wo3qDHnO10q98B+7SaWVVYUec 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243754>

This test is trying to test a few ways to delete references using "git
update-ref -z --stdin".  The third line passed in is

    update SP /refs/heads/c NUL NUL <sha1> NUL

, which is not a correct way to delete a reference according to the
documentation (the new value should be zeros, not empty).  Pass zeros
instead as the new value to test the code correctly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29391c6..e2f1dfa 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -927,7 +927,7 @@ test_expect_success 'stdin -z update refs fails with wrong old value' '
 test_expect_success 'stdin -z delete refs works with packed and loose refs' '
 	git pack-refs --all &&
 	git update-ref $c $m~1 &&
-	printf $F "delete $a" "$m" "update $b" "$Z" "$m" "update $c" "" "$m~1" >stdin &&
+	printf $F "delete $a" "$m" "update $b" "$Z" "$m" "update $c" "$Z" "$m~1" >stdin &&
 	git update-ref -z --stdin <stdin &&
 	test_must_fail git rev-parse --verify -q $a &&
 	test_must_fail git rev-parse --verify -q $b &&
-- 
1.9.0
