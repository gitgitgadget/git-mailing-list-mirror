From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t1010-mktree: Adjust expected result to code and documentation
Date: Thu, 15 Apr 2010 11:34:07 +0200
Message-ID: <09645aa273ba1215c6c34a5727ef97261ac0a149.1271323912.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 11:37:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2LVh-00079D-6y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 11:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab0DOJhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 05:37:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39782 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932069Ab0DOJhK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 05:37:10 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 25B3DEB307;
	Thu, 15 Apr 2010 05:37:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 15 Apr 2010 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=JtWcIifG+uWFhV0maAlqcOHL7CI=; b=qT4dgVVMNkRFIHXbpQS+eJ0wpiMbKbRcw+/wWVg5BJikx4FLo0Q8OQcMNCy6B/B3zR3pikx0ckXbPpvusOuJ45+1ZTGaOXx2XU0rnwuurm4H5hw1iUQGggCHuh9N6ea/i5FdF8+RkPIo+JGsSmUzsfxvVQo3p2xvX+zn9EjkG1M=
X-Sasl-enc: GWGC1UW9bgX66dnn8ul8RuYF2vXisv0nywLmTXhk2XAK 1271324228
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9162F4CF8E0;
	Thu, 15 Apr 2010 05:37:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.rc1.248.gcefbb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144967>

The last two tests here were always supposed to fail in the sense
that, according to code and documentation, mktree should read non-recursive
ls-tree output, but not recursive one, and therefore explicitely refuses
to deal with slashes.

Adjust the test (must_fail) so that it succeeds when mktree dies on
slashes.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
CC'ed to you, Junio, as the original test author, according
to the new guidelines :)

 t/t1010-mktree.sh |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 9956e3a..b946f87 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -58,14 +58,12 @@ test_expect_success 'allow missing object with --missing' '
 	test_cmp tree.missing actual
 '
 
-test_expect_failure 'mktree reads ls-tree -r output (1)' '
-	git mktree <all >actual &&
-	test_cmp tree actual
+test_expect_success 'mktree refuses to read ls-tree -r output (1)' '
+	test_must_fail git mktree <all >actual
 '
 
-test_expect_failure 'mktree reads ls-tree -r output (2)' '
-	git mktree <all.withsub >actual &&
-	test_cmp tree.withsub actual
+test_expect_success 'mktree refuses to read ls-tree -r output (2)' '
+	test_must_fail git mktree <all.withsub >actual
 '
 
 test_done
-- 
1.7.1.rc1.248.gcefbb
