From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/27] t1400: fix name and expected result of one test
Date: Mon,  7 Apr 2014 15:47:52 +0200
Message-ID: <1396878498-19887-2-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9ue-0002Rp-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbaDGNsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:30 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64168 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbaDGNs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:27 -0400
X-AuditID: 1207440f-f79326d000003c9f-ac-5342aca9ea4f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 57.40.15519.9ACA2435; Mon,  7 Apr 2014 09:48:25 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJa8026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:24 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLtyjVOwwelpBhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7ox/2z8xFmzkrjjT2cbWwNjJ2cXIySEhYCLxc8FJ
	VghbTOLCvfVsXYxcHEIClxklVixZzgThHGOSuL5oBiNIFZuArsSinmYmEFtEQE1iYtshFpAi
	ZoErjBJXPm5nAUkIC3hKLDy3nA3EZhFQlfi4aDNYnFfARWLxheUsEOvkJE4emwy2mlPAVWLG
	oVtgC4SAau6vOcYygZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQ
	4OPfwdi1XuYQowAHoxIP74pDjsFCrIllxZW5hxglOZiURHmfL3MKFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCy7UaKMebklhZlVqUD5OS5mBREudVX6LuJySQnliSmp2aWpBaBJOV4eBQkuB9
	CdIoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2zgXbW1yQmAsU
	hWg9xagoJc5bApIQAElklObBjYWllFeM4kBfCvM+B6niAaYjuO5XQIOZgAYbuoINLklESEk1
	MEq8/82xx8Wt+9qy9z9v70mo22Poc09XK8gnpb7xi6bm+qnd7yS8BW9eLZs3K/CMr+QeH7fH
	WyUMGy747v38r87oZKLFcl2dlKwpd0+GqxivWcaV3M608MHXa2UpR37eOXzodVjv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245836>

The test

    stdin -z create ref fails with zero new value

actually passes an empty new value, not a zero new value.  So rename
the test s/zero/empty/, and change the expected error from

    fatal: create $c given zero new value

to

    fatal: create $c missing <newvalue>

Of course, this makes the test fail now, because although "git
update-ref" tries to distinguish between these two errors, it does not
succeed in this situation.  Fixing it is more than a one-liner, so
mark the test test_expect_failure for now.  The failure will be fixed
later in this patch series.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6ffd82f..fa927d2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -827,10 +827,10 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
-test_expect_success 'stdin -z create ref fails with zero new value' '
+test_expect_failure 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c given zero new value" err &&
+	grep "fatal: create $c missing <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
-- 
1.9.1
