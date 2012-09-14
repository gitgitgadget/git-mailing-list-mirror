From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 11/11] t7810-grep: test --all-match with multiple --grep and --author options
Date: Fri, 14 Sep 2012 11:46:43 +0200
Message-ID: <155f30ede8a788c599189af677936b15fabf041b.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUd-0007Hv-9c
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab2INJrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:47:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37682 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754172Ab2INJrD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:47:03 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7D5B0207AC;
	Fri, 14 Sep 2012 05:47:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 14 Sep 2012 05:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=PS
	3r7mhIQGkdGwR8BzbDH81fuLo=; b=fj0I9sKMLVqD93+ZAuueyTdeIrEqIFhOj5
	dcWuFRTGIn8Lj6g02k7tsoK0zau8W2Rx2mLPlMbPqh/NRnARhNgApxrxKJA58DwE
	1338Xr/78ea4QpjDSk4pcpDP5ecmE6DnXNG72v1/ppg4NCx5AKx2HJQBNEqz4+5D
	FePB2h5zg=
X-Sasl-enc: sGysb4IBDwiGOCiDUwxtt6ITr8onWADjGjiF0qQOyLxM 1347616021
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DF24E8E03D9;
	Fri, 14 Sep 2012 05:47:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205474>

--all-match is ignored with multiple author options on purpose but
requires all --grep to be matched on some line.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f6edb4d..b5c488e 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -531,6 +531,16 @@ test_expect_success 'log --grep --grep --author takes union of greps and interse
 	test_cmp expect actual
 '
 
+test_expect_success 'log ---all-match -grep --author --author still takes union of authors and intersects with grep' '
+	# grep matches only initial and third
+	# author matches all but second
+	git log --all-match --author="Thor" --author="Night" --grep=i --format=%s >actual &&
+	{
+	    echo third && echo initial
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep --author --author takes union of authors and intersects with grep' '
 	# grep matches only initial and third
 	# author matches all but second
@@ -541,6 +551,16 @@ test_expect_success 'log --grep --author --author takes union of authors and int
 	test_cmp expect actual
 '
 
+test_expect_success 'log --all-match --grep --grep --author takes intersection' '
+	# grep matches only third
+	# author matches only initial and third
+	git log --all-match --author="A U Thor" --grep=i --grep=r --format=%s >actual &&
+	{
+		echo third
+	} >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-- 
1.7.12.592.g41e7905
