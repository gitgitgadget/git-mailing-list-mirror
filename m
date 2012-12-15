From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH v2 7/7] test: Add test for --use-mailmap option
Date: Sat, 15 Dec 2012 19:05:54 +0100
Message-ID: <1355594754-27589-8-git-send-email-apelisse@gmail.com>
References: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 19:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjw8G-0001Hn-It
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab2LOSGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 13:06:25 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61037 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab2LOSGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 13:06:10 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1888867wgb.1
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 10:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6G7EAg7yPJwKgnMwuhygjhN1Lq2VtwSToUYkmFzybpM=;
        b=WkfBrDVf1qY0LlBpvUfuXmiWew+4EH2pvj4ECCj43zCdHsCfksVnsUrV2yGzh5A5lJ
         ukXNLsihUthpX8zYgJhjAzQgIjGEglO8D/abPdqKysTXqPejrhxiKfaLOr5CWp0I+D4k
         k+5dsvuYkpYGpXZpYxZQE/3ywclPEY7Yh3UwpaIxHO7XqwH7Nzq/CEd85zT/in7ESurD
         K6dHp21/kOqDJS+2GVy6j/xmsb0jze7tWxRBt1l6F/C7oPxf/pYWSvfdgX6y/5+U2h7N
         eZfdX56qnzo3fMpCNaS298LcNBvybnaKE1i31IiCt+qbz+wP+sDxO2NdQrKV5WNriZQJ
         lqCQ==
Received: by 10.194.179.34 with SMTP id dd2mr9501667wjc.1.1355594769422;
        Sat, 15 Dec 2012 10:06:09 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id bd7sm3570983wib.8.2012.12.15.10.06.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 10:06:08 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1355594754-27589-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211547>

The new option '--use-mailmap' can be used to make
sure that mailmap file is used to convert name
when running log commands.

The test is simple and checks that the Author line
is correctly replaced when running log.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 t/t4203-mailmap.sh |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..db043dc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -239,6 +239,20 @@ test_expect_success 'Log output (complex mapping)' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Author: CTO <cto@company.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Other Author <other@author.xx>
+Author: Other Author <other@author.xx>
+Author: Some Dude <some@dude.xx>
+Author: A U Thor <author@example.com>
+EOF
+test_expect_success 'Log output with --use-mailmap' '
+	git log --use-mailmap | grep Author >actual &&
+	test_cmp expect actual
+'
+
 # git blame
 cat >expect <<\EOF
 ^OBJI (A U Thor     DATE 1) one
-- 
1.7.9.5
