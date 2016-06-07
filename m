From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 2/6] t9001: check email address is in Cc: field
Date: Tue,  7 Jun 2016 16:01:44 +0200
Message-ID: <20160607140148.23242-3-tom.russello@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Tom RUSSELLO <tom.ressullo@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 16:02:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHaV-0005VW-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbcFGOCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:02:23 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:50131 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbcFGOCV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:02:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B5616256B;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GsIEnGQa0R3R; Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A5D4424F3;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A31AF2066;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nCW0x4n7sIRS; Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8C1682064;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc0.40.g1232aeb.dirty
In-Reply-To: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296682>

Check if the given utf-8 email address is in the Cc: field.

Signed-off-by: Tom RUSSELLO <tom.ressullo@grenoble-inp.org>
Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 4558e0f..7fdc876 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -888,8 +888,8 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	--to=nobody@example.com \
 	--smtp-server="$(pwd)/fake.sendmail" \
 	outdir/*.patch &&
-	grep "^	" msgtxt1 |
-	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
+	cc_adr=$(awk "/^Cc: /{flag=1}/^Subject: /{flag=0} flag {print}" msgtxt1) &&
+	echo "$cc_adr" | grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
 '
 
 test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
-- 
2.8.3
