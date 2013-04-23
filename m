From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/7] t4030: demonstrate behavior of show with textconv
Date: Tue, 23 Apr 2013 14:11:53 +0200
Message-ID: <8a6cbd3ca4e2cb1e5376262c3efa8e3a222767de.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc4k-00024f-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757Ab3DWMLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:11:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60039 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755361Ab3DWMLx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:11:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 77C7320D95;
	Tue, 23 Apr 2013 08:11:53 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 23 Apr 2013 08:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=hp
	zwAqpxkSorFWiNPo3CLW4xmNw=; b=Le9kNhLFoRHKk0L31YUHGi2iJIiGfBmitC
	3uZtefh6u21ihlnAakmt3G94GOicSjSoEQ4NcXpumLVxmwXrz3GJWub/VOfmxAOJ
	I4OgWJUMhU556ioYHu52k/U1XxvGMXlq+0QVp3VByVO5bKU76XVtAzd8VjAWjidh
	abRYzTXQY=
X-Sasl-enc: XMwV2GOneXHTBYaYNUuk4fP0ywej/0Yw6Kj53JoOC4BH 1366719113
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 09CA3C80003;
	Tue, 23 Apr 2013 08:11:52 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222147>

"git show <commit>" honors the textconv setting while "git show <blob>"
does not. Demonstrate this in the test.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t4030-diff-textconv.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 53ec330..260ea92 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -58,6 +58,12 @@ test_expect_success 'diff produces text' '
 	test_cmp expect.text actual
 '
 
+test_expect_success 'show commit produces text' '
+	git show HEAD >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.text actual
+'
+
 test_expect_success 'diff-tree produces binary' '
 	git diff-tree -p HEAD^ HEAD >diff &&
 	find_diff <diff >actual &&
@@ -84,6 +90,12 @@ test_expect_success 'status -v produces text' '
 	git reset --soft HEAD@{1}
 '
 
+test_expect_failure 'show blob produces text' '
+	git show HEAD:file >actual &&
+	printf "0\\n1\\n" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
 	echo one >expect &&
 	git log --root --format=%s -G0 >actual &&
-- 
1.8.2.1.799.g1ac2534
