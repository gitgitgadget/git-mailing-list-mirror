From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/41] usage.c: add warning_errno() and error_errno()
Date: Sun,  8 May 2016 16:47:22 +0700
Message-ID: <1462700881-25108-3-git-send-email-pclouds@gmail.com>
References: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
 <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 11:49:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLKX-00087A-0n
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 11:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbcEHJso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2016 05:48:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34811 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHJsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 05:48:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id 145so13759083pfz.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 02:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTlvgXplJlNEyQjowkiH2+nPN+u8hrcbdFjTMFjVKck=;
        b=rt7AwsJEuQCm8i4+DYHpFgNwfO5/kQxm3ds8jdI+rMPYHSaW3+ZTL9pCOcLVUdBaYl
         TEqBk++yKPo6oGbk3Id1Ey9rAEY8sFNDHQY4qTJc9TmwdVcfsc1XevTKoztUJ1XEeS2Y
         t1uG33YaSONNMJjCedcMU2F3ItfDlk7KS2DX2NM4zaHrVw1jcPkjXMjl7+mbY5j4bzPD
         byjtJiJC+W7Cl4OABdiwOVaV9TT1fuSH3vdFjvPFyL4d4fxsqZfvedHj8qVGUvvlkV/k
         t8UOJ46um+RaWsC2jGdyE9OllfEhwRwNJXuT2JxUHpXf1EXDy+v3rj73FN7ktIv6URkZ
         UGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTlvgXplJlNEyQjowkiH2+nPN+u8hrcbdFjTMFjVKck=;
        b=K4zdcCdteuW4kcxDLE4H9XwmnUfmkUZK/8V5I65lVPbmdDNSn4gomFayXt2Ay6MwXX
         XEcj6p9PnCxNvFx3CgHSvPq+cU15D3x0c9Fy5HpDYSGIXMQ6PwPFIpbjQrqviipqmERk
         /fMMmFIgDE+OmGlFDB4HyLUtnc/RG/Y4Lh4Pwc4agOOVVR3/nMZ77eOw/paBiF3ECfl1
         SYET0J8Ak9nV/2HYv1D+1pcvcc/ALjFjSiaD+6xp5DlNByrOT8WFw2C497cbBw19Ki7I
         e3/WPeWiZ2fX5RAsUfwdedSt1jUzsVVMBOx+sHp1f0Rcf63IR0JsRbOTgNlB111ptSWb
         lrOA==
X-Gm-Message-State: AOPr4FVZSN3UTucHumkjve3O3yJs8A+aJK0fV+1PyWNNCClhRZQtnt+aqj6P5/gSgTKQrw==
X-Received: by 10.98.88.4 with SMTP id m4mr41289479pfb.71.1462700922789;
        Sun, 08 May 2016 02:48:42 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id qb1sm32832421pac.44.2016.05.08.02.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 May 2016 02:48:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 May 2016 16:48:42 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462700881-25108-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293915>

Similar to die_errno(), these functions will append strerror()
automatically.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  2 ++
 usage.c           | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1f8b5f3..49d4029 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -409,7 +409,9 @@ extern NORETURN void usagef(const char *err, ...) _=
_attribute__((format (printf,
 extern NORETURN void die(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((fo=
rmat (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, =
1, 2)));
+extern int error_errno(const char *err, ...) __attribute__((format (pr=
intf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (print=
f, 1, 2)));
+extern void warning_errno(const char *err, ...) __attribute__((format =
(printf, 1, 2)));
=20
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 8675d72..1dad03f 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,17 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
=20
+int error_errno(const char *fmt, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	va_start(params, fmt);
+	error_routine(fmt_with_err(buf, sizeof(buf), fmt), params);
+	va_end(params);
+	return -1;
+}
+
 #undef error
 int error(const char *err, ...)
 {
@@ -159,6 +170,16 @@ int error(const char *err, ...)
 	return -1;
 }
=20
+void warning_errno(const char *warn, ...)
+{
+	char buf[1024];
+	va_list params;
+
+	va_start(params, warn);
+	warn_routine(fmt_with_err(buf, sizeof(buf), warn), params);
+	va_end(params);
+}
+
 void warning(const char *warn, ...)
 {
 	va_list params;
--=20
2.8.0.rc0.210.gd302cd2
