From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] Test for local branches being followed with --track
Date: Thu, 26 Mar 2009 21:53:24 +0100
Message-ID: <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
 <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 21:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmwbs-0000q8-MV
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757479AbZCZUxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbZCZUxc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:53:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42363 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109AbZCZUxc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 16:53:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 475622FF284;
	Thu, 26 Mar 2009 16:53:30 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Mar 2009 16:53:30 -0400
X-Sasl-enc: u+ljHBBO4hUK2i5niXMxgPI2qbtZl9h/+W1xCnj8SOuH 1238100809
Received: from localhost (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 86D1D511C;
	Thu, 26 Mar 2009 16:53:29 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114817>

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
