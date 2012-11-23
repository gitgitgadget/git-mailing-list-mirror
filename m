From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/6] git p4 test: display unresolvable host error
Date: Fri, 23 Nov 2012 17:35:37 -0500
Message-ID: <1353710139-16207-5-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1s7-0005s3-QA
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab2KWWhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:37:03 -0500
Received: from honk.padd.com ([74.3.171.149]:35232 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab2KWWhC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:37:02 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 58A8DE9A;
	Fri, 23 Nov 2012 14:37:02 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 026A427578; Fri, 23 Nov 2012 17:36:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210278>

This test passes already.  Make sure p4 diagnostic errors are displayed.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4-basic.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 05797c3..8c59796 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -183,6 +183,18 @@ test_expect_success 'initial import time from top change time' '
 	)
 '
 
+test_expect_success 'unresolvable host in P4PORT should display error' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		P4PORT=nosuchhost:65537 &&
+		export P4PORT &&
+		test_expect_code 1 git p4 sync >out 2>err &&
+		grep "connect to nosuchhost" err
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.8.0.276.gd9397fc
