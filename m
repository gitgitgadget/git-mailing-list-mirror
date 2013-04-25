From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t5801: properly test the test shell
Date: Thu, 25 Apr 2013 12:09:51 +0200
Message-ID: <ff7ccf22012f069ceca054d90aa0f72666cc11c2.1366884583.git.git@drmicha.warpmail.net>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 12:09:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVJ7e-0001Gn-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 12:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab3DYKJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 06:09:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59426 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754630Ab3DYKJp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 06:09:45 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 30CDC20B5E;
	Thu, 25 Apr 2013 06:09:43 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Apr 2013 06:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=HdF2ScEbiV0TPTy/LzFsv/mNtgY=; b=kS/Lk61sBgvffPWZpSUh
	nVliXiWC9ECjEN14k+/0IbaDwTKODgaM0gQaGa4drWFEYHBjGABFZEfGh+R2fgjA
	0xhsYfWoFAK0If+0JZnVZjUdW8zcgU4u1LvSqiuXc27agmtqYPpo2k6Y6q9ZNp6w
	4B5s0+IUBH2Xc5VJN8NGuk4=
X-Sasl-enc: DFzSe1wjpkj0q5rKTJo54RXRVmmbvyEIBRimnZVyCdFI 1366884582
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id BA46CC80003;
	Thu, 25 Apr 2013 06:09:42 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.882.gefdb4b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222361>

fc407f9 (Add new simplified git-remote-testgit, 2012-11-28) introduced a
test which was meant to skip the test unless the test shell is bash.
Unfortunately, it tests for the availability of bash only. But users can
opt to use a different shell (using SHELL_PATH) for the tests even though
bash is available.

At least for dash,
21610d8 (transport-helper: clarify pushing without refspecs, 2013-04-17)
is the commit which actually introduces a test (pushing without refspec)
which fails to fail even though it is supposed to. It uses the
construct:

VAR=value function arguments

Make t5801 actually test whether the test shell is bash.

An even better alternative would be to make the test POSIX compliant, of
course.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t5801-remote-helpers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index ed962c4..c979863 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,7 +8,7 @@ test_description='Test remote-helper import and export commands'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-if ! type "${BASH-bash}" >/dev/null 2>&1; then
+if test $(basename "${SHELL_PATH}") != "bash"; then
 	skip_all='skipping remote-testgit tests, bash not available'
 	test_done
 fi
-- 
1.8.2.1.882.gefdb4b7
