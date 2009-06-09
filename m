From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/5] t5516: Check pushurl config setting
Date: Tue,  9 Jun 2009 18:01:35 +0200
Message-ID: <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3lt-00008m-9r
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbZFIQBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZFIQBp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36053 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754990AbZFIQBn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7521E35E4C1;
	Tue,  9 Jun 2009 12:01:45 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 09 Jun 2009 12:01:45 -0400
X-Sasl-enc: Ze97DeaJqRkjSi0E/vzuVxBtOC9O6PEQYskMwDBCDMSL 1244563304
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9C3E2F07F;
	Tue,  9 Jun 2009 12:01:44 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121181>

Check whether the new remote.${remotename}.pushurl setting is obeyed
and whether it overrides remote.${remotename}.url.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t5516-fetch-push.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 89649e7..2d2633f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -419,6 +419,19 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 git config --remove-section remote.there
 git config --remove-section branch.master
 
+test_expect_success 'push with config remote.*.pushurl' '
+
+	mk_test heads/master &&
+	git checkout master &&
+	git config remote.there.url test2repo &&
+	git config remote.there.pushurl testrepo &&
+	git push there &&
+	check_push_result $the_commit heads/master
+'
+
+# clean up the cruft left with the previous one
+git config --remove-section remote.there
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
-- 
1.6.3.2.278.gb6431.dirty
