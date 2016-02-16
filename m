From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/26] usage.c: add sys_error() that prints strerror() automatically
Date: Tue, 16 Feb 2016 20:29:03 +0700
Message-ID: <1455629367-26193-3-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:29:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfh3-00027l-3Y
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbcBPN3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:25 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34810 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcBPN3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:24 -0500
Received: by mail-pf0-f174.google.com with SMTP id x65so105389900pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cO9UBYBypAbYyOOtD4G6O0JNj3WJoHfUeXNlfMfH0f4=;
        b=q2maaimkhdryI2a5AsHN2lCBbrZ6WXp/kbjlrCHjPMa1UtEZr9/0GBmyhRBmugyucH
         QDVjbRos7IZIkL7tx60HdQskd6kn033YDQXzpJUJIV9g2/mjdur05JvuTnFdPbjyigAN
         C5PS8UgPRuXI0IpWDChgjAVfODVriUdJctMB0goHlr0MaEuWh/K62kHWYdfj8hhF9xoB
         OXiPPvYN7VtqHlHFBAQwooHJiYZzKpYczFD+BrmeFE/6bMIcixkUSRwSMjVZNsTPLgxD
         rwZIICJPf6EoZcGXxbvLu3lAHwSSHl9t4vLVhf06Bo/8qyn5eAbrnEeICZcCxxNs+Exy
         bHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cO9UBYBypAbYyOOtD4G6O0JNj3WJoHfUeXNlfMfH0f4=;
        b=K8wrl9+PeUDmLPJwSSNTFaCMtGQItM7fqBKZn5AvnRHS9Qsb97jEDtkk//99O6JRbl
         P6EJhvs6XQ1W5ww6wEVip+NAvc6QC6DtdXm4xHuoYrsOfuUitBRNJYuYZsbT1GbTvB+h
         dTxz0YEa9elRR4jPqJ+z3bkJHe8jQqVn5IgosBE2Dve3khk4vLssJ2mlntGHLBaTVATh
         7DT52P7ty0VLe+SqFnzeaOdimbG5S1F91PquIKI2BBt4djelgQ0W5MFUmEI8C+DBxihn
         ufxR3E0RTmxyb2lcU3gSbcXiMFoih+JzcqMYFEeopkER1DEjeVk9lJ1me8d2O5HQqTQg
         5I0Q==
X-Gm-Message-State: AG10YOSKGv02Bg5523f3bKHyvMDbxkp9cFQycOmLmKSHNtAwlrx1u5h4S555mHVKEIALOA==
X-Received: by 10.98.9.219 with SMTP id 88mr31556120pfj.0.1455629363570;
        Tue, 16 Feb 2016 05:29:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id xm10sm46069552pab.12.2016.02.16.05.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:29:47 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286363>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  1 +
 usage.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 693a336..fd1d374 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -408,6 +408,7 @@ extern NORETURN void usagef(const char *err, ...) _=
_attribute__((format (printf,
 extern NORETURN void die(const char *err, ...) __attribute__((format (=
printf, 1, 2)));
 extern NORETURN void die_errno(const char *err, ...) __attribute__((fo=
rmat (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, =
1, 2)));
+extern int sys_error(const char *err, ...) __attribute__((format (prin=
tf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (print=
f, 1, 2)));
=20
 #ifndef NO_OPENSSL
diff --git a/usage.c b/usage.c
index 0dba0c5..e7c37f2 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,16 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
=20
+int sys_error(const char *fmt, ...)
+{
+	va_list params;
+
+	va_start(params, fmt);
+	error_routine(fmt_with_err(fmt), params);
+	va_end(params);
+	return -1;
+}
+
 #undef error
 int error(const char *err, ...)
 {
--=20
2.7.0.377.g4cd97dd
