From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t9119-git-svn-info.sh: test with svn 1.6.* as well
Date: Wed,  3 Mar 2010 18:08:24 +0100
Message-ID: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 18:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nms6A-0006NR-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 18:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0CCRK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 12:10:57 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45893 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751831Ab0CCRK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 12:10:56 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CEB30E226E;
	Wed,  3 Mar 2010 12:10:55 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 03 Mar 2010 12:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=XbcDk2PhXJ9XmuBwQETA8axR2fI=; b=l3CiqNU8IleuVcOwa8oUDgpPifw7edQqlHsFcqn+his543lO7ibaKs6LutZG+/TRCUGcUxpIxAdNQaVEcDiDbx/0RskUJTnlgG0TdiwK1aS5mv19BhlYJsyA2Fd71SKPqOwfgEyCyuTgbsBCF71llOZ7QkMFkfSfRg6vW+4MuxE=
X-Sasl-enc: tZHixFB68KywNCJCJn5rq19bMVA+NMoFrhANrVWldhXN 1267636255
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 256DE4CA08A;
	Wed,  3 Mar 2010 12:10:54 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141458>

All tests in t9119 were disabled for subversion versions other than
1.[45].*. Adjust the single test where svn 1.6.* output is slightly
different to ignore the differing line, and make the test script
run with subversion 1.[456].*.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t9119-git-svn-info.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 95741cb..eff4ae2 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -7,9 +7,10 @@ test_description='git svn info'
 . ./lib-git-svn.sh
 
 # Tested with: svn, version 1.4.4 (r25188)
+# Tested with: svn, version 1.6.[12345689]
 v=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
 case $v in
-1.[45].*)
+1.[456].*)
 	;;
 *)
 	say "skipping svn-info test (SVN version: $v not supported)"
@@ -166,7 +167,7 @@ test_expect_success 'info added-directory' "
 		git add added-directory &&
 	cd .. &&
 	(cd svnwc; svn info added-directory) \
-		> expected.info-added-directory &&
+		| grep -v \"Repository UUID\" > expected.info-added-directory &&
 	(cd gitwc; git svn info added-directory) \
 		> actual.info-added-directory &&
 	test_cmp expected.info-added-directory actual.info-added-directory
-- 
1.7.0.1.241.g6604f
