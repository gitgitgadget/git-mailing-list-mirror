From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/6] t4030: demonstrate behavior of show with textconv
Date: Fri, 19 Apr 2013 18:44:44 +0200
Message-ID: <a3162a9df3055532a818db264f43abc994325049.1366389739.git.git@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERQ-0008P3-5K
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816Ab3DSQpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50614 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968397Ab3DSQpf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:35 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5934920C80
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:35 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 19 Apr 2013 12:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=f7jinM0/BbQJHN6/bALQkbVwE
	Yw=; b=W4niFPXOayCwlMvAIAZwyXAwq/ott0KrmYsIB0RdKG9BvtX6ym4+Kr0XZ
	fjluTRlxQD2q9aJT0hq26q36tQdA9QHIuNH/AuYNSbt9OxhTi//jihlfPJeJJWHV
	pdKQH0Ig+42V4bxdGuo1tSVy9ooYfvXbNq8atbdbiLhW1rooVc=
X-Sasl-enc: rNBHQyKD2F6ECBHT72rYHGnitxCfy/DFh5Qbb4hryKQo 1366389934
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id D8B3CC8000B;
	Fri, 19 Apr 2013 12:45:34 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221771>

"git show <commit>" obeys the textconc setting while "git show <blob>"
does not. Demonstrate this in the test.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t4030-diff-textconv.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 53ec330..f314ced 100755
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
 
+test_expect_success 'show blob produces binary' '
+	git show HEAD:file >actual &&
+	printf "\\0\\n\\1\\n" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
 	echo one >expect &&
 	git log --root --format=%s -G0 >actual &&
-- 
1.8.2.1.728.ge98e8b0
