From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 13/27] t1400: test that stdin -z update treats empty <newvalue> as zeros
Date: Mon,  7 Apr 2014 15:48:04 +0200
Message-ID: <1396878498-19887-14-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9wC-0003at-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbaDGNuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:50:07 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64176 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755352AbaDGNsu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:50 -0400
X-AuditID: 1207440f-f79326d000003c9f-23-5342acc107e6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FA.40.15519.1CCA2435; Mon,  7 Apr 2014 09:48:49 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaK026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:47 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHtwjVOwwdJJEhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxva6czF0xmrzj54RJrA+Mz1i5GTg4JAROJ609+
	MUHYYhIX7q1n62Lk4hASuMwosfvIBEYI5xiTxKt128Cq2AR0JRb1NIPZIgJqEhPbDrGAFDEL
	XGGUuPJxOwtIQlggWuLf5g5GEJtFQFXizslP7CA2r4CrxN4f29gh1slJnDw2GewMTqD4jEO3
	wOqFBFwk7q85xjKBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJDg
	49/B2LVe5hCjAAejEg/vikOOwUKsiWXFlbmHGCU5mJREeZ8vcwoW4kvKT6nMSCzOiC8qzUkt
	PsQowcGsJMLLtRoox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4H0J
	0ihYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPio74YmB8gKR4gPbOBdtbXJCYCxSF
	aD3FqCglzlsCkhAASWSU5sGNhaWUV4ziQF8K8z4HqeIBpiO47ldAg5mABhu6gg0uSURISTUw
	NsS4Wr0IPxITs6LP7OxymYxP73yyb7dZNtb7Lp1qYaGpd8lzw+njgYeN7pROm7/1YYYri/f7
	8lWf73wXatx5X2BD7afQ72f58wtL6v0/TZynxDTnxY2X2/oKgl9brjBnz7Ob4Cf0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245860>

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
1.9.1
