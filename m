From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sat,  4 Feb 2012 21:50:23 +0200
Message-ID: <1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 20:51:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtleP-0005Zw-Ss
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab2BDTvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:51:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34029 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754495Ab2BDTv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 14:51:26 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so2380696lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4Nbn9rwEisNpy4c1Qh0AqhvJ4D6e0OHiYSymL1o9gzo=;
        b=D+b+XaM0OcOIDCwTL3+M8L21V0cnRNqKkMJQTzEhddI4UaET73GJjRrZNMPzCRRbhO
         xFJWHhX110PzJh+7f6TAHMKDR5xmh1GXqHXpoiz4ZfdQrKxIJOATKYznJ0XFhCkvGMEa
         d+y1Hq+HF+upxQWcJJOrYV+zAhzw+Q7ahHcvo=
Received: by 10.152.148.230 with SMTP id tv6mr6163772lab.12.1328385086028;
        Sat, 04 Feb 2012 11:51:26 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id pt3sm8278838lab.9.2012.02.04.11.51.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 11:51:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
In-Reply-To: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189898>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4203-mailmap.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..b1bc521 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -255,4 +255,22 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+# git blame
+cat >expect <<\EOF
+^OBJI (<author@example.com>       DATE 1) one
+OBJID (<some@dude.xx>             DATE 2) two
+OBJID (<other@author.xx>          DATE 3) three
+OBJID (<other@author.xx>          DATE 4) four
+OBJID (<santa.claus@northpole.xx> DATE 5) five
+OBJID (<santa.claus@northpole.xx> DATE 6) six
+OBJID (<cto@company.xx>           DATE 7) seven
+EOF
+test_expect_success 'Blame output (complex mapping)' '
+	git blame -e one >actual &&
+	cp actual /tmp &&
+	cp internal_mailmap/.mailmap /tmp &&
+	fuzz_blame actual >actual.fuzz &&
+	test_cmp expect actual.fuzz
+'
+
 test_done
-- 
1.7.9.1.g97f7d
