From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 24/48] remote-hg: add test to push new bookmark
Date: Fri, 24 May 2013 21:29:40 -0500
Message-ID: <1369449004-17981-25-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4I2-00029y-Vh
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab3EYCc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64671 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3EYCc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:56 -0400
Received: by mail-ob0-f174.google.com with SMTP id fb19so6227389obc.19
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xXntPaoUXPX7augzzsWV7BHwRjBE1+5z8oDbrzpwYAs=;
        b=qwYqb/+xn3j32NaAbzR/987GEV3jS/efmBMMlU0/MOh2aG95HErAJdt2zA6FHfM/wQ
         dgnZsF6KJwPIp4WNzHYwLi3KIYWmd8qVkSlcZwCnZJbuorh1eeXNkOfVXwuVnokKYeEQ
         CdxPWGiYxIbQKeBNFcShT6vgtcZgVHxNAzIoQ6w7Yg9jILe21f7T6aBNAqB+xev9Zz3F
         zRQnj+zRJO1xo2hVjByAQqu3Z/Q/EvpQn3AI+3S0FDlcF1YEV2OgbRa/aZQAQVPf8HIl
         Yewq7a1Khb3CM3x93jkS99geLiKXIcDmurtoGCUD7vsxk65b1ZPTCj3vYQcIkrERWnJu
         vfng==
X-Received: by 10.60.121.106 with SMTP id lj10mr13774640oeb.128.1369449175738;
        Fri, 24 May 2013 19:32:55 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wz1sm6623566obc.3.2013.05.24.19.32.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225436>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index d927495..8b5e191 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -117,6 +117,21 @@ test_expect_success 'update bookmark' '
 	check_bookmark hgrepo devel devel
 '
 
+test_expect_success 'new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
 # cleanup previous stuff
 rm -rf hgrepo
 
@@ -288,4 +303,19 @@ test_expect_success 'remote update bookmark' '
 	check_bookmark hgrepo devel devel
 '
 
+test_expect_success 'remote new bookmark' '
+	test_when_finished "rm -rf gitrepo*" &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git checkout --quiet -b feature-b &&
+	echo feature-b > content &&
+	git commit -a -m feature-b &&
+	git push --quiet origin feature-b
+	) &&
+
+	check_bookmark hgrepo feature-b feature-b
+'
+
 test_done
-- 
1.8.3.rc3.312.g47657de
