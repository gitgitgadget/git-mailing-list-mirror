From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] t7609-merge-co-error-msgs: test non-fast forward case too.
Date: Fri,  3 Sep 2010 17:25:33 +0200
Message-ID: <1283527533-16736-1-git-send-email-Matthieu.Moy@imag.fr>
References: <8762ymewq5.fsf@meyering.net>
Cc: Jim Meyering <jim@meyering.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 03 17:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrYJh-0007h3-OR
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 17:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab0ICPgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 11:36:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41091 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab0ICPgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 11:36:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o83FDeYS031219
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 Sep 2010 17:13:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OrY96-0006ql-T5; Fri, 03 Sep 2010 17:25:40 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OrY96-0004Mc-PV; Fri, 03 Sep 2010 17:25:40 +0200
X-Mailer: git-send-email 1.7.2.2.284.g95cc.dirty
In-Reply-To: <8762ymewq5.fsf@meyering.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 Sep 2010 17:13:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o83FDeYS031219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1284131623.43887@gvQSBoiuvoVQNXu9uIB/7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155249>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This comes on top of the patch serie, and adds a test to make sure the
bug doesn't come back.

I did check manually that the git of git.git doesn't pass this (while
the one after the patch serie does).

 t/t7609-merge-co-error-msgs.sh |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index 1a109b4..6b58299 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -34,9 +34,17 @@ error: The following untracked working tree files would be overwritten by merge:
 Please move or remove them before you can merge.
 EOF
 
-test_expect_success 'untracked files overwritten by merge' '
+test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
 	test_must_fail git merge branch 2>out &&
-	test_cmp out expect
+	test_cmp out expect &&
+	git commit --allow-empty -m empty &&
+	(
+		GIT_MERGE_VERBOSITY=0 &&
+		export GIT_MERGE_VERBOSITY &&
+		test_must_fail git merge branch 2>out2
+	) &&
+	test_cmp out2 expect &&
+	git reset --hard HEAD^	
 '
 
 cat >expect <<\EOF
-- 
1.7.2.2.284.g95cc.dirty
