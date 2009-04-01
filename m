From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] Test for local branches being followed with --track
Date: Wed,  1 Apr 2009 23:42:48 +0200
Message-ID: <1238622169-5238-2-git-send-email-git@drmicha.warpmail.net>
References: <49CD0440.6010304@drmicha.warpmail.net>
 <1238622169-5238-1-git-send-email-git@drmicha.warpmail.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 23:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp8Em-0000Pm-05
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 23:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934576AbZDAVnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 17:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934731AbZDAVnH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 17:43:07 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51980 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934767AbZDAVnE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 17:43:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 292D530DAB6;
	Wed,  1 Apr 2009 17:43:01 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Apr 2009 17:43:01 -0400
X-Sasl-enc: KIs9noJ5jQM9fELhS/1sVDMIkCi3D7XfCPD+yuHSPwQR 1238622180
Received: from localhost (p4FC63601.dip0.t-ipconnect.de [79.198.54.1])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 63CDE45E23;
	Wed,  1 Apr 2009 17:43:00 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <1238622169-5238-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115418>

According to the documentation, it is perfectly okay to follow local
branches using the --track option. Introduce a test which checks whether
they behave the same. Currently 1 test fails.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6040-tracking-info.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ba90601..2a2b6b6 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -29,7 +29,9 @@ test_expect_success setup '
 		git checkout -b b4 origin &&
 		advance e &&
 		advance f
-	)
+	) &&
+	git checkout -b follower --track master &&
+	advance g
 '
 
 script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
@@ -56,6 +58,12 @@ test_expect_success 'checkout' '
 	grep "have 1 and 1 different" actual
 '
 
+test_expect_failure 'checkout with local tracked branch' '
+	git checkout master &&
+	git checkout follower >actual
+	grep "is ahead of" actual
+'
+
 test_expect_success 'status' '
 	(
 		cd test &&
-- 
1.6.2.1.507.g0e68d
