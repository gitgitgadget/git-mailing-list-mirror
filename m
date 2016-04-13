From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/25] usage.c: move format processing out of die_errno()
Date: Wed, 13 Apr 2016 20:15:22 +0700
Message-ID: <1460553346-12985-2-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeD-0003lX-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760408AbcDMNPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:15:54 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34556 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760192AbcDMNPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:15:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id d184so4101703pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9YzkZ9PTX9bgMnfH47Plm+EJkeIlQxZOum9JIBNp3M=;
        b=H+QJs9GrT3GoRuwczP7bouzgYBkUWzPVA7LejBzK+Tgp27utniZaQMZ6MgMtFefIa6
         Y7ZPbT9+u8rFkijbwBd55Jz/HaG/+QgJP6Qx4dZUwmx+LjZNv1DnFYGKFWs1gAY2PNkS
         uWRbDgPIvEsTv9Ql6970SxxLHXusdXyOFU7WzJuCp5r4R70dOqQYLgdznNMYFm1BcbNa
         ViKrcFDmhpwc2qxz6wCFEyk7ALhKkHZkzk7ntnW7650lf/VdL+O1ksk7qhUOOHxzvVSQ
         ciRBQG0vXrSBa/Xfx+YOPWeYLphWQ9glZN/DEnnh+VDQkFdxcIV+1MFk3oxcyUiUZrsg
         KGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9YzkZ9PTX9bgMnfH47Plm+EJkeIlQxZOum9JIBNp3M=;
        b=dzc7iy/fqtlfsbz5ZXOtrWygT+DBv4cmKbarJsF/B4iGQxmVYT2xyJBpVDXGIv4AOa
         5oKnR1Hf9GZqrljagplkuWs1uXeHJ1f9Ksa/vDLxnYVXAq41Dl29SkEBrnSErDHjD1UB
         3U+gcti3D5SIdltsWJc8fBL+pbUtWTrWfqtVlLor5PBSkB1X54n5wTX9ZJW1ySGBYnrs
         oEsgPMbMnffQowRuSHheKSYMQks9nfcCz4ou2fJh0ilxty5vh7oWRraXI48ZiOirBYe7
         5D8uvCJvnb2O4WGK91WL96OopFIgCmd0vD2/Tkj2+iI/imXvVsPurZKAIMaFX5RgZle1
         4V+g==
X-Gm-Message-State: AOPr4FW9bWfoTcvN+5zGsQCfvCRTRiKggVKtlE/H/viBGsjp7PyX3jnOtFRlcs0IOnc7IQ==
X-Received: by 10.98.74.74 with SMTP id x71mr12819385pfa.25.1460553352553;
        Wed, 13 Apr 2016 06:15:52 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ak9sm51299839pac.13.2016.04.13.06.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:15:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:15:58 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291422>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 usage.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/usage.c b/usage.c
index 82ff131..0dba0c5 100644
--- a/usage.c
+++ b/usage.c
@@ -109,19 +109,12 @@ void NORETURN die(const char *err, ...)
 	va_end(params);
 }
=20
-void NORETURN die_errno(const char *fmt, ...)
+static const char *fmt_with_err(const char *fmt)
 {
-	va_list params;
-	char fmt_with_err[1024];
+	static char fmt_with_err[1024];
 	char str_error[256], *err;
 	int i, j;
=20
-	if (die_is_recursing()) {
-		fputs("fatal: recursion detected in die_errno handler\n",
-			stderr);
-		exit(128);
-	}
-
 	err =3D strerror(errno);
 	for (i =3D j =3D 0; err[i] && j < sizeof(str_error) - 1; ) {
 		if ((str_error[j++] =3D err[i++]) !=3D '%')
@@ -137,9 +130,21 @@ void NORETURN die_errno(const char *fmt, ...)
 	}
 	str_error[j] =3D 0;
 	snprintf(fmt_with_err, sizeof(fmt_with_err), "%s: %s", fmt, str_error=
);
+	return fmt_with_err;
+}
+
+void NORETURN die_errno(const char *fmt, ...)
+{
+	va_list params;
+
+	if (die_is_recursing()) {
+		fputs("fatal: recursion detected in die_errno handler\n",
+			stderr);
+		exit(128);
+	}
=20
 	va_start(params, fmt);
-	die_routine(fmt_with_err, params);
+	die_routine(fmt_with_err(fmt), params);
 	va_end(params);
 }
=20
--=20
2.8.0.rc0.210.gd302cd2
