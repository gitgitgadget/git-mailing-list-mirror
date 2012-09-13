From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 5/6] t7810-grep: test --all-match with multiple --grep and --author options
Date: Thu, 13 Sep 2012 16:04:43 +0200
Message-ID: <fec86dc5c7b7cfbc99b887d90dac7519ddd0ba1f.1347544259.git.git@drmicha.warpmail.net>
References: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 16:05:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCA2c-00073N-AZ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 16:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab2IMOEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 10:04:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37070 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab2IMOEx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 10:04:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8D99220A42;
	Thu, 13 Sep 2012 10:04:53 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 13 Sep 2012 10:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=4X
	Fp+iYGCPURRuY90VUoyTpFt80=; b=h+nF5HsWZQRYVH8V7zZQJ1C6++w68FRb60
	8klou5vCsFw+vUua1C6tMt4HMXwZJv9l7B7OCHeLiFYZdY7jzwUCQnVC2U3/HXeJ
	HEbR77Y0CApT9Y1xSYBzJC0v8URaf1qd79cujubA4LISjpKTwYMxB26zw793Pjt/
	GoweDGKeA=
X-Sasl-enc: pdLMd5Fu4ufOpb1JiC0Bkr/ty6VQ31J4FL85kljqEsBJ 1347545093
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 30C568E0215;
	Thu, 13 Sep 2012 10:04:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
In-Reply-To: <7v7grzdue6.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347544259.git.git@drmicha.warpmail.net>
References: <cover.1347544259.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205378>

--all-match is ignored with multiple author options on purpose.
It is also ignored with multiple --grep options when an --author option
is present. Mark this as known failure.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t7810-grep.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f98f3f6..fa2845f 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -598,6 +598,16 @@ test_expect_success 'log --grep --grep --author takes union of greps and interse
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
@@ -608,6 +618,16 @@ test_expect_success 'log --grep --author --author takes union of authors and int
 	test_cmp expect actual
 '
 
+test_expect_failure 'log --all-match --grep --grep --author takes intersection' '
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
1.7.12.463.gbd9d638
