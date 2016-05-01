From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Sun,  1 May 2016 18:14:17 +0700
Message-ID: <1462101297-8610-2-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpLV-0006dd-Ep
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbcEALPV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:15:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36222 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbcEALPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:15:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so18813974pfb.3
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGCJBsKIRiiuJoWF/whpCal3TYw1ZaQrUU7kcgkzvjA=;
        b=Fo8c6pR/vXYNAen/tEGl3cqjbr0CgRoguTosRoI78qXdypkNdXGFFobdn6P03yrYU3
         Gprn0pxQn1Cm2U1kbGvOhbRTDABj7LlGI03G3A4SbPeLvHHv56ePEWphiHKCz6mWavqo
         nPbnxrJmIXU1HhwdsWMIPpPicv6X3mjwNaSYkllf1goHW3bjGld2FGvuvuciMhXl5Y0h
         jObHnTNzVCDrvQuIGalxW9OyBlNhnbWDGisrOgUXVaDuFOOqQMxh9+LWuE43x0Sen4OH
         tIW14ayL6XEXnpKrlBHC3nJ4p+HjC1Mi6EEsJ6S7P/tKpwLiLJwEdyeaPGPbx0cDVHoo
         da8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGCJBsKIRiiuJoWF/whpCal3TYw1ZaQrUU7kcgkzvjA=;
        b=cJir0O6WUZTjB+jqqP0r20jHXRKrJ9sRsLVP40JZVUnwHe5n8Glep+Sc96m1BTpW6w
         vB2X5O5TIX1RSdWq/8Mfi0vyKgMkJmghagsJO/I4xa8UOpMwupHM7TrA0SGDjoCd+/Z+
         2Xiz/VPc5jXHZ2ee1M1ekjDlVFYfQo04QHoZ7kj2KCTLO3PBO9Z62JFzgzRMNDaZyVhL
         Q9LAFo/ES2f+oNpos6ZFKo0UcxlNGUT9z280prpV/uPTqJjaer7J5VYCPQnjdnfQumGO
         X7fdddKlaiOPE6fIwVk+z+/Va+fLgCWX6kmrp1QGQez598VmeNRYtU6rrYK0CfZoghV1
         TRIg==
X-Gm-Message-State: AOPr4FXXeuNwz93uP9uREMSnKty+Zpv/pZ8hsG+aXOEOUMKV2zIeUEdwiB2cs6UXjUMQlw==
X-Received: by 10.98.34.141 with SMTP id p13mr43421998pfj.156.1462101318492;
        Sun, 01 May 2016 04:15:18 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id g84sm37061651pfj.42.2016.05.01.04.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:15:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:15:13 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293151>

fmt_with_err() will be shared with the coming error_errno() and
warning_errno().

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
