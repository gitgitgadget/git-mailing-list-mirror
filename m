From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/27] t1400: Test that stdin -z update treats empty <newvalue> as zeros
Date: Mon, 24 Mar 2014 18:56:46 +0100
Message-ID: <1395683820-17304-14-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS989-00018N-J8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbaCXR5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:38 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:43598 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753806AbaCXR5g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:36 -0400
X-AuditID: 1207440e-f79c76d000003e2c-f0-5330720f9fd7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 31.96.15916.F0270335; Mon, 24 Mar 2014 13:57:35 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xj028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:33 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqMtfZBBs8PKzisXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2P1y02sBZPZKw5072BrYHzG2sXIySEhYCLxc+Z9
	JghbTOLCvfVsXYxcHEIClxkl7l5+xgjhnGCSaJn1CKyKTUBXYlFPM5gtIqAmMbHtEAtIEbPA
	FUaJKx+3s4AkhAWiJbrf9zGD2CwCqhL9k98xgti8Aq4Sn7fuY4dYJycx5fcCMJsTKL61/TBY
	vZCAi8SOj71MExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQICT6+
	HYzt62UOMQpwMCrx8G4wNQgWYk0sK67MPcQoycGkJMrLlgsU4kvKT6nMSCzOiC8qzUktPsQo
	wcGsJMJrGQ6U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8N4uAGoU
	LEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VHfDEwPkBSPEB7OQpB9hYXJOYCRSFa
	TzEqSonzXgOZKwCSyCjNgxsLSymvGMWBvhTmXQ9SxQNMR3Ddr4AGMwENDm/SAxlckoiQkmpg
	LONuU3u+siTx3aX/Rw9P9JmcxxrjEio9194m//6dD/e38guYN2xn/HzULe2A/FsOdf+J3GHH
	nrYn3kp61N60TdV51Q695CWa3onxNpb/BMNLn+y7MFNc6ua5qZ+2F7RevXyio/ZY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244841>

This is the (slightly inconsistent) status quo; make sure it doesn't
change by accident.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a2015d0..208f56e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -730,6 +730,13 @@ test_expect_success 'stdin -z fails update with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
+test_expect_success 'stdin -z treats empty new value as zeros' '
+	git update-ref $a $m &&
+	printf $F "update $a" "" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q $a
+'
+
 test_expect_success 'stdin -z fails update with no new value' '
 	printf $F "update $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-- 
1.9.0
