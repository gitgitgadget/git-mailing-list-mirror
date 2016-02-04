From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 23/25] t5500, t5539: tests for shallow depth excluding a ref
Date: Thu,  4 Feb 2016 16:03:59 +0700
Message-ID: <1454576641-29615-24-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFsF-0007zZ-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965563AbcBDJGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:35 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33824 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965481AbcBDJG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:06:27 -0500
Received: by mail-pf0-f175.google.com with SMTP id o185so38454659pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Kstlhi7N4ibrInF7cJOE/UoEqwRBHyppBClTUy5fk4c=;
        b=lpM7YgQOIoX6Mcejh8ZVfkm73+4PawTSPbObwYuflEz/7LDwsAQrAnvY6KrIGQ+Yat
         nxIT0RpJQZO4tKOmZis/PdGDcII5T0nNg6kpn96by38QOUgar5MrqyvuIdzOPAOaeoFv
         cmei3us4ZP8nBNIShqdZp0eElO2HSIA0G0eencOWJ0/h4aJal9jS5x40e1yrhELVthig
         ileR5otSgqERPqGUt6zph0sU43MfXfJorpLYLxFlwxppzyr9mue1W88480gl2FWgOrwr
         mJsSLxMN2iMRJ2HKgZ3IPEm7pmP8Sj3z4U5708I1tNCKlktLWGEAbjU73MwosVZF+uDx
         cQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Kstlhi7N4ibrInF7cJOE/UoEqwRBHyppBClTUy5fk4c=;
        b=m+/m3CIfJOj3UgE2KyKCKillgLuX5wYE4nqSawNf0mLmyaqz/pnE9QOFLv0UB3489Q
         OAKpIR/QY2SURX0NMgQFIQX12Gq4IyeBtOkrJxlj4GKdIjy0xKcLlGM+8RQyuy24A0Q6
         XkHFCpz024oZPFkjiP/Tl23aNOIEs3bUvdrUElgXZfHNMHyM5OMTcNy2WNObRMWRUEJa
         c/AiBNsWeC8zOQTc7tlaj7re6hrGp6F3iFmmXBEKoOWyEn5ruXuTtfTzow+/cNo1ExXr
         TkJ9dCK29pshqs+bUmncvGkD+m8azZHRC/xUdYmRSNQhyWUx0Vj+Q1titcp7kzGv3i9p
         UvPg==
X-Gm-Message-State: AG10YOS8JiKoZ5iEOAn3OQWbFdufDzFBkqieavfoajlhk5jpdOX5yEyV6FNcMUXUQA+8Bw==
X-Received: by 10.98.9.27 with SMTP id e27mr9341695pfd.59.1454576787226;
        Thu, 04 Feb 2016 01:06:27 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id l14sm15343422pfb.73.2016.02.04.01.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:06:25 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:39 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285436>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh         | 22 ++++++++++++++++++++++
 t/t5539-fetch-http-shallow.sh | 22 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 453c571..53de68c 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -659,4 +659,26 @@ test_expect_success 'fetch shallow since ...' '
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
index 2a96ab3..95eaaff 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -96,6 +96,28 @@ test_expect_success 'fetch shallow since ...' '
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
2.7.0.377.g4cd97dd
