From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/27] t1400: test one mistake at a time
Date: Mon,  7 Apr 2014 15:48:07 +0200
Message-ID: <1396878498-19887-17-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:49:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9vO-0002x0-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbaDGNtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:49:16 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:57538 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755377AbaDGNs5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:57 -0400
X-AuditID: 12074411-f79ab6d000002f0e-de-5342acc72523
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 3B.AF.12046.7CCA2435; Mon,  7 Apr 2014 09:48:55 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaN026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:53 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHt8jVOwwd3T3BY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oynv1azFfzmrNi/dQFLA2MjRxcjJ4eEgInE8YcP
	WSBsMYkL99azdTFycQgJXGaU2DvvJxOEc4xJ4lTPWmaQKjYBXYlFPc1MILaIgJrExLZDLCBF
	zAJXGCWufNwONkpYwFpi68RNYA0sAqoS/T+PMYLYvAKuEjNnHmCEWCcncfLYZFYQmxMoPuPQ
	LbC4kICLxP01x1gmMPIuYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRES
	fII7GGeclDvEKMDBqMTDu+KQY7AQa2JZcWXuIUZJDiYlUd7ny5yChfiS8lMqMxKLM+KLSnNS
	iw8xSnAwK4nwcq0GyvGmJFZWpRblw6SkOViUxHn5lqj7CQmkJ5akZqemFqQWwWRlODiUJHjX
	gzQKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg6IjvhgYHyApHqC9c8H2Fhck5gJF
	IVpPMSpKifOWgCQEQBIZpXlwY2Ep5RWjONCXwrwbQKp4gOkIrvsV0GAmoMGGrmCDSxIRUlIN
	jGuXSCRPOv13Ka8116MQdd7pRV4Z7nZ2kkqz58iucJqh9ZZlV4+SmOORnPPz+w21Vu/becfr
	euFypZ/cR11czs1m3eHv7BcuvL+jKPjSuujW+SIB+8I5Wpbt3vD0/6lTNxKnu8js 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245846>

This case wants to test passing a bad refname to the "update" command.
But it also passes too few arguments to "update", which muddles the
situation: which error should be diagnosed?  So split this test into
two:

* One that passes too few arguments to update

* One that passes all three arguments to "update", but with a bad
  refname.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1400-update-ref.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 2d61cce..6b21e45 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -724,8 +724,14 @@ test_expect_success 'stdin -z fails update with no ref' '
 	grep "fatal: update line missing <ref>" err
 '
 
+test_expect_success 'stdin -z fails update with too few args' '
+	printf $F "update $a" "$m" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: update $a missing <oldvalue>" err
+'
+
 test_expect_success 'stdin -z fails update with bad ref name' '
-	printf $F "update ~a" "$m" >stdin &&
+	printf $F "update ~a" "$m" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
 	grep "fatal: invalid ref format: ~a" err
 '
-- 
1.9.1
