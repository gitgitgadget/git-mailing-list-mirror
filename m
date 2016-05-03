From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/41] usage.c: add warning_errno() and error_errno()
Date: Tue,  3 May 2016 19:03:35 +0700
Message-ID: <1462277054-5943-3-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 14:06:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZ5z-00084x-CL
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 14:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbcECMG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 08:06:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35985 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932462AbcECMG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 08:06:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id bt5so8679493pac.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 05:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTlvgXplJlNEyQjowkiH2+nPN+u8hrcbdFjTMFjVKck=;
        b=pn/mhYQaVedbKN15cG66vJAIK7kMaECE1N+8PpwNnjExe8hP0CSsr6pXtmUBjY8Nyi
         vt6sHEd8yAkeUQEc1XqkNDRLtY3Uw+107D2w4LnGhG1MLF3fU+0c+wU22Vrk4HC6Kkft
         O5Ps/recY97LB3LGHEhKPUX7fnfZGW/Nobx1wbufPSVH9SA/qUyJQT8J1bAMJVbKO07i
         rJJpDQJzxjAqr/X3O7eKD40u0rT9j4aoNIMJErZBNXdJ0nxTOi3B/w/i0AlkujLjkD+X
         /WGZJAQBq/6ICZCsOd3Ui2+HRxsectePP6Z2bNUme+gpAUyf/RBRyuSuANlOyiEbHoy+
         2QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTlvgXplJlNEyQjowkiH2+nPN+u8hrcbdFjTMFjVKck=;
        b=gD/W2uClvrgwPqu3RJGAbQtcBA6kl6NUZr3sJ/Vk98HE+JRCHWOi7hBhTZeCsH3n6r
         T7TQeIpkxgZwOjyoP4sVJC1suO1dgTLU4ho1P9O5um+xHgywlzcLZighoPFcM1w15XTP
         pCKrEVxkAf3dHHzgqXDUAcJ7YgkrnOIHSidQpR37QPHS6JAXjr0mKSWxFKOszFUiP++N
         okF2PDM82+kFIWrIizrbalidchkeHPeH/6gnbBdQ3H2C6NYN5GAFJW2o8Tmyu5AK/Nz9
         MFtSmQ/a+jbr2G2KaLl/dDIviZQhreJJ8csD/5/9aYrjacbKBISe+wptAMc60ysRkOVx
         c7pA==
X-Gm-Message-State: AOPr4FUtIj8GEL+tkSfWIqK2cqLdszAuxtlazCaxKAu60VlVcnzgRdl3TvQxqbdzNgbf8A==
X-Received: by 10.66.25.243 with SMTP id f19mr2881173pag.11.1462277185574;
        Tue, 03 May 2016 05:06:25 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id v185sm5475705pfb.72.2016.05.03.05.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 May 2016 05:06:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 03 May 2016 19:06:21 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462277054-5943-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293355>

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
