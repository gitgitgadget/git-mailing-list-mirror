From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] t/status-help: test "HEAD detached from"
Date: Tue, 18 Jun 2013 17:44:23 +0530
Message-ID: <1371557670-12534-2-git-send-email-artagnon@gmail.com>
References: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:17:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uour6-00080s-3y
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413Ab3FRMRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 08:17:37 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46531 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422Ab3FRMRg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:17:36 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so3857203pbb.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dBrkJhiYUcRv+22hxCJ4vmGcemqeuOf/9lmzOQqLqcI=;
        b=eW4tjn9IuphMwCH0NJBeXKrzUAISDTfOJavgRmlTWKsOaRGSwX2wCZITTFV8H3/7+z
         j2Nv7Fic11T8M6UFqdyLRQcTkJZyszkuMicGPgsWwEtrj0yT5LZWE81kJ8ub1ndEq5zY
         4dBU55RN5oaUoimvGPW2lh/wxhIQnfJf2/Y+3hVk0kROoD0EwGc4Ym7R1BW/xsAgfY+q
         HAnnGx+ilzz+lXAPmRpKSM0zXXbqTgRt9S1effdaImalz9g0+hxcoF5rkbN4E4AnfBkS
         2ls2BsQY+ndwMVEn9lc7TnkwFzwLCI3XlwTpHqmaG/zUJIg2hstiJUi3Rp+0FZ/BjMyN
         69AQ==
X-Received: by 10.68.251.234 with SMTP id zn10mr16894651pbc.188.1371557856166;
        Tue, 18 Jun 2013 05:17:36 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id fm2sm19398332pab.13.2013.06.18.05.17.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 05:17:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6
In-Reply-To: <1371557670-12534-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228206>

From: Junio C Hamano <gitster@pobox.com>

b397ea (status: show more info than "currently not on any branch",
2013-03-13) wanted to make sure that after a checkout to detach HEAD,
the user can see where the HEAD was originally detached from.  The last
test added by that commit to t/status-help shows one example,
immediately after HEAD is detached via a checkout.  Enhance that test to
test the "HEAD detached from" message is displayed when the user further
resets to another commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t7512-status-help.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index bf08d4e..bafa5e7 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -667,7 +667,7 @@ test_expect_success 'status when cherry-picking after resolving conflicts' '
 	test_i18ncmp expected actual
 '
 
-test_expect_success 'status showing detached from a tag' '
+test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
 	cat >expected <<-\EOF
@@ -675,6 +675,14 @@ test_expect_success 'status showing detached from a tag' '
 	nothing to commit (use -u to show untracked files)
 	EOF
 	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual &&
+
+	git reset --hard HEAD^ &&
+	cat >expected <<-\EOF
+	# HEAD detached from atag
+	nothing to commit (use -u to show untracked files)
+	EOF
+	git status --untracked-files=no >actual &&
 	test_i18ncmp expected actual
 '
 
-- 
1.8.3.1.456.gb7f4cb6
