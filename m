From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] clone: add test for push on an empty clone.
Date: Mon, 20 Apr 2009 13:09:37 +0200
Message-ID: <1240225777-31334-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 13:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrSv-0005Vs-Du
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbZDTLM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 07:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755120AbZDTLM7
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 07:12:59 -0400
Received: from imag.imag.fr ([129.88.30.1]:40434 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbZDTLM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 07:12:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3KB9kEY027609
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Apr 2009 13:09:46 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LvrNd-0000Fv-61; Mon, 20 Apr 2009 13:09:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LvrNd-00089v-3g; Mon, 20 Apr 2009 13:09:41 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Apr 2009 13:09:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116972>

Commit 55f0566 (get_local_heads(): do not return random pointer if
there is no head, 2009-04-17) fixed a segfault for git push, this
patch adds a test-case to avoid future regressions.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t5701-clone-local.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3559d17..f26b511 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -132,4 +132,14 @@ test_expect_success 'clone empty repository' '
 	 test $actual = $expected)
 '
 
+test_expect_success 'clone empty repository, and then push should not segfault.' '
+	cd "$D" &&
+	rm -fr empty/ empty-clone/ &&
+	mkdir empty &&
+	(cd empty && git init) &&
+	git clone empty empty-clone &&
+	cd empty-clone &&
+	test_must_fail git push
+'
+
 test_done
-- 
1.6.2.2.449.g92961.dirty
