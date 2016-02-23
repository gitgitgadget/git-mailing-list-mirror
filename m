From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/25] t5500, t5539: tests for shallow depth excluding a ref
Date: Tue, 23 Feb 2016 20:45:00 +0700
Message-ID: <1456235103-26317-23-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDJA-0001NO-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcBWNrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:15 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35723 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcBWNrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:47:08 -0500
Received: by mail-pf0-f181.google.com with SMTP id c10so116401072pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PnH/ZrZB98MIfTt5X45JYav+Pb5A9s+mqlLgyuEO8UY=;
        b=bN1TgtlPh4Y/GTyzsjaQNYDKp1tUkKeDsxq0h4hIC1Rjcr5yQWECmmY6cajrxlESj1
         6VL388VaZPAD8OD57gRWR4gdZ7Dh9Amw648Bki2gvii+0mPL6C9THdelOy9aBchIVUJf
         +SAkzpRoqMPG2h5vhCsi7o+vBL5vq8OGvzDi6PNmupeHX/zMCdNk5soBJFjeQuegjg0x
         mMEn7oUUgEB3gRlvKwlXmE7L9HmumpUTztQ5PrjdcdwR91qHZoVteYUa4rcupCvBqtXh
         jdl2GrpFVFFhlz0MpIFSYYizvtkIL9EqxazV6gfzaq4yc9HidvHP/4xJ4Mi+fAdJ5TCU
         U2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PnH/ZrZB98MIfTt5X45JYav+Pb5A9s+mqlLgyuEO8UY=;
        b=DFw5KuSMXUV7nXce5OTeYCMjBeVJn6v1QiLbI7D9aOTIsQbatyVfSD6Ojh5LFKo5GM
         IlQwxsA6jHi2aKrQdcVGZM1nw/30lT1jYs+PWnSQQOWypnH6ADlASlYourAQ1eb4AOE+
         2o2yFCPVEUhWXsE6nBVo+7ooCQG04hPGeuUJG/BgAzU477p54C5ANjBkz4+y+ta6Ueqx
         bJFFwygCxsSTO2FE2qSUUjviGVoLpF61557A6zyS/XHN52MScRJDgfXRgb+qrdFMsc+o
         Pcb+MIl3HlmuSuqwLmgeo/oxGdD7S86S9jDjzj+yDMR8lTcJDdSn4QtQZ4Loi8L5syWN
         PJhQ==
X-Gm-Message-State: AG10YOT8maeIZUfSsgaoAWF7mEVhC7HlY1nBGb8sXg12Sy4CFtnVD5dH+RfXPvsYvNCtlg==
X-Received: by 10.98.69.78 with SMTP id s75mr46785481pfa.102.1456235228314;
        Tue, 23 Feb 2016 05:47:08 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id w9sm30871681pfa.21.2016.02.23.05.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:47:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:37 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287074>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 22 ++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 26f050d..a3fe5ca 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -661,4 +661,26 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --shallow-exclude two "file://$(pwd)/." ../shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow=
=2Esh
index 6d77ca7..f71573d 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -98,6 +98,28 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'shallow clone exclude tag two' '
+	test_create_repo shallow-exclude &&
+	(
+	cd shallow-exclude &&
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-exclude.git" &&
+	git clone --shallow-exclude two $HTTPD_URL/smart/shallow-exclude.git =
=2E./shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+	)
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --shallow-exclude one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
=20
 stop_httpd
 test_done
--=20
2.7.1.532.gd9e3aaa
