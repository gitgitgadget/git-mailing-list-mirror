From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 42/48] remote-hg: add setup_big_push() helper
Date: Fri, 24 May 2013 21:29:58 -0500
Message-ID: <1369449004-17981-43-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Iy-0002wk-MU
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab3EYCdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:53 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50003 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3EYCdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so6964135oag.19
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gZDLoPQqbDN98qh+Rlup1HrtojcNKzfOnh3syJkzQpk=;
        b=eBVPOO7Wuef8u2uo8n2vnIILKJ7QODABnsm6KRhgmtkLvdhSSQQN7FV9k+9+cRi8mw
         /8S7OD/nBXM2jbVgKxgRDCzrXnIaNUUGSMbbsJtFe5R46YoAk/wkHvLYjKOsvAh4sD9Z
         TkKgbqiOG3vc7WkxQpL00s+tSddwETsnnfyYpM+9ZlCqlYy78I5OS2Z7cH0O0gwfjr81
         JWm6wUoZUR9AEeja8vbs11+5zfpa2AHIsOmeo4kXKo/p6MUk0Cyx2SagmdPT5fvuj1ez
         UWv+KRx1/+feY20P9SyNhRCdbpdTeUXP98QdQmx4qPCP/M1hsgLdEcSPVQWa1aO4sxIW
         peHQ==
X-Received: by 10.60.133.240 with SMTP id pf16mr13829303oeb.28.1369449231915;
        Fri, 24 May 2013 19:33:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id hv3sm20073875obb.7.2013.05.24.19.33.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225454>

So we don't duplicate these commands.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 84df1c3..f594584 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -398,9 +398,7 @@ test_expect_success 'remote new bookmark multiple branch head' '
 # cleanup previous stuff
 rm -rf hgrepo
 
-test_expect_success 'remote big push' '
-	test_when_finished "rm -rf hgrepo gitrepo*" &&
-
+setup_big_push () {
 	(
 	hg init hgrepo &&
 	cd hgrepo &&
@@ -459,8 +457,17 @@ test_expect_success 'remote big push' '
 
 	git checkout -q -b branches/new_branch master &&
 	echo ten > content &&
-	git commit -q -a -m ten &&
+	git commit -q -a -m ten
+	)
+}
 
+test_expect_success 'remote big push' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
 	test_expect_code 1 git push origin master \
 		good_bmark bad_bmark1 bad_bmark2 new_bmark \
 		branches/good_branch branches/bad_branch \
-- 
1.8.3.rc3.312.g47657de
