From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: [PATCH v4 2/6] t9001: check email address is in Cc: field
Date: Wed,  8 Jun 2016 15:01:38 +0200
Message-ID: <20160608130142.29879-3-samuel.groot@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Cc: samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, gitster@pobox.com, aaron@schrab.com,
	e@80x24.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:04:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAd9N-0003Kf-Nh
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 15:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425498AbcFHNDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 09:03:50 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:59562 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425335AbcFHNDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 09:03:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 023B92591;
	Wed,  8 Jun 2016 15:03:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jacVesWKu2Dp; Wed,  8 Jun 2016 15:03:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E57312415;
	Wed,  8 Jun 2016 15:03:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E25382066;
	Wed,  8 Jun 2016 15:03:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKi-qiEig1vQ; Wed,  8 Jun 2016 15:03:46 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 764EF2064;
	Wed,  8 Jun 2016 15:03:46 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.667.gf43de12
In-Reply-To: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296789>

Check if the given utf-8 email address is in the Cc: field.

Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 56ad8ce..943e6b7 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -888,8 +888,8 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	--to=nobody@example.com \
 	--smtp-server="$(pwd)/fake.sendmail" \
 	outdir/*.patch &&
-	grep "^	" msgtxt1 |
-	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	echo "$cc_adr" | fgrep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
 '
 
 test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
-- 
2.8.2.537.gb153d2a
