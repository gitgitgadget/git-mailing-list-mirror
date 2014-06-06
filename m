From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 16/20] t/t5403-post-checkout-hook.sh: avoid "test <cond> -a/-o <cond>"
Date: Fri,  6 Jun 2014 07:55:59 -0700
Message-ID: <1402066563-28519-17-git-send-email-gitter.spiros@gmail.com>
References: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 16:56:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsvZO-0001vC-C3
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 16:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbaFFO4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 10:56:24 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36546 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbaFFO4X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 10:56:23 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so2582695pbb.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uhenjEa8Z8ww07YPgRh53haQGTgAeHzk0r0Aslk8lXo=;
        b=VRydHp1dNDPfySdv35CLVvxQSfwHuS6INl3ASsi6TPaip2nRlwxYeixcDk4vSkAin8
         0WqKnNa3jGKQSuDUYkm1xs4ROCdgouX8zUZtp8D5/5Qffx1tAVZ1GsiSCnsXo5CwJTdw
         g5cX3wzN2N/6iaq4iCPC1NxGt9hb8pwfX6/Mzhk/pKWcgY7iN4QZvSisjwZfoxrCE2yx
         hP8I6a5vrdnjWuRCwH7Ts7RiHWlyKTyoR4hhIvGW6VDlDyjOXfRdkNnZmJobgLEwnM6s
         ihf3IBuosFJAGvlu2Cqdhbl3mpFmNRSwH5yl/C7svxGg7RyMdjJuCKaj/JbxdyV6OS7S
         BNLw==
X-Received: by 10.68.231.196 with SMTP id ti4mr1691129pbc.48.1402066582836;
        Fri, 06 Jun 2014 07:56:22 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pu5sm36850769pbb.4.2014.06.06.07.56.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Jun 2014 07:56:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402066563-28519-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250928>

The construct is error-prone; "test" being built-in in most modern
shells, the reason to avoid "test <cond> && test <cond>" spawning
one extra process by using a single "test <cond> -a <cond>" no
longer exists.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t5403-post-checkout-hook.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1753ef2..fc898c9 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -39,7 +39,7 @@ test_expect_success 'post-checkout receives the right arguments with HEAD unchan
 	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 1
+	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
@@ -52,7 +52,7 @@ test_expect_success 'post-checkout args are correct with git checkout -b ' '
 	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 1
+	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
@@ -60,7 +60,7 @@ test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old != $new -a $flag = 1
+	test $old != $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
@@ -68,7 +68,7 @@ test_expect_success 'post-checkout receives the right args when not switching br
 	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
 	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
 	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old = $new -a $flag = 0
+	test $old = $new && test $flag = 0
 '
 
 if test "$(git config --bool core.filemode)" = true; then
-- 
1.7.10.4
