From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/32] t2025: add a test to make sure grafts is working from a linked checkout
Date: Sat, 30 Aug 2014 15:34:02 +0700
Message-ID: <1409387642-24492-33-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe9U-0003cs-6P
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaH3Igq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:46 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:61941 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbaH3Igp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:45 -0400
Received: by mail-pa0-f51.google.com with SMTP id rd3so8232114pab.10
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UdEh6GB8T242VMgPcAT88kn7hBR7++cfqayaK9Hou5o=;
        b=M10FKskv7xVdh1KxMnBwtxF05inOFprrnPr30YspJRt5vVPcUPdYNKDCXeTlAkSUau
         DVFCIbwX9SkFlw2i6DcfN7GF6apv8lxuC9b9vXDu0EMTRIQUsUrQ/Jqp3RegjyMJfO9E
         Bjdpq0a1ID0gczmnmoU4Iaagk8jWWeSSY3Q3w68uEWG8ISIsy3OgUMqgrgniaAQptwnr
         xQUI2MRICrGsbbmSppEBHZfjt94Y2uJSkmKxXevvbV3hC8iHUHq+/hkiZsy7j6JxGxz7
         56RIktk1A3cwlYkmzztDM9X2mKai49qBzZhldBenw4vhyr7H2nroJzPC3Z870VHyLKvV
         VKzw==
X-Received: by 10.70.132.73 with SMTP id os9mr22473824pdb.63.1409387803980;
        Sat, 30 Aug 2014 01:36:43 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id bx6sm7480373pab.48.2014.08.30.01.36.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256242>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t2025-checkout-to.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index 9f701a1..aa24ea8 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -96,4 +96,22 @@ test_expect_success 'checkout from a bare repo witho=
ut --to' '
 	)
 '
=20
+test_expect_success 'checkout with grafts' '
+	test_when_finished rm .git/info/grafts &&
+	test_commit abc &&
+	SHA1=3D`git rev-parse HEAD` &&
+	test_commit def &&
+	test_commit xyz &&
+	echo "`git rev-parse HEAD` $SHA1" >.git/info/grafts &&
+	cat >expected <<-\EOF &&
+	xyz
+	abc
+	EOF
+	git log --format=3D%s -2 >actual &&
+	test_cmp expected actual &&
+	git checkout --detach --to grafted master &&
+	git --git-dir=3Dgrafted/.git log --format=3D%s -2 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.1.0.rc0.78.gc0d8480
