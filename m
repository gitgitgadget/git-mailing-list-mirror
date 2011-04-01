From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] t/t1411: test reflog with formats
Date: Fri,  1 Apr 2011 11:20:32 +0200
Message-ID: <60228d6916ed82bb45429fb4fed80f39f4e92a6b.1301649372.git.git@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 11:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5aan-0001Hg-2s
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab1DAJYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 05:24:15 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44403 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754772Ab1DAJYM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:24:12 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 388F6203C1;
	Fri,  1 Apr 2011 05:24:12 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 01 Apr 2011 05:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=LcdzTPuibWOYva4BeK2BZs4t90g=; b=Xk8TAj4w9jqZAd7kh82Zgc8FiYHPmU6ce0A1WHB2nlJyDtT/VA6oCUi7f4djGIA4M328MFlzIJ7wnoQrZG5MPxLAzXbWhMESjgET0iLFbEgNEFRvO/fF+DKMCE+/VjqDdmaxkVxyGKCWiYa3a6QzyKT5B2jP3QqBM9j0rQWQnaE=
X-Sasl-enc: UCTyBezhsvvYxwrSxTvaTR3ax4XI1Zg2M+f+ntnYucAO 1301649851
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B0806405202;
	Fri,  1 Apr 2011 05:24:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1301649372.git.git@drmicha.warpmail.net>
References: <cover.1301649372.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170569>

"git reflog --format=short" does not work because "reflog" overrides the
format option. This is documented in code. Document this by a test
(known failure) also.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t1411-reflog-show.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index ba25ff3..88dc6a7 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -28,6 +28,24 @@ test_expect_success 'oneline reflog format' '
 	test_cmp expect actual
 '
 
+test_expect_success 'reflog default format' '
+	git reflog -1 >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+commit e46513e
+Reflog: HEAD@{0} (C O Mitter <committer@example.com>)
+Reflog message: commit (initial): one
+Author: A U Thor <author@example.com>
+
+    one
+EOF
+test_expect_failure 'override reflog default format' '
+	git reflog --format=short -1 >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<'EOF'
 Reflog: HEAD@{Thu Apr 7 15:13:13 2005 -0700} (C O Mitter <committer@example.com>)
 Reflog message: commit (initial): one
-- 
1.7.4.2.668.gba03a4
