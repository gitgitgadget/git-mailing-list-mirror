From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/20] usage.c: add sys_error() that prints strerror() automatically
Date: Wed,  3 Feb 2016 16:35:32 +0700
Message-ID: <1454492150-10628-3-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 10:36:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtrA-0004yu-6D
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbcBCJgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:36:08 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32949 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCJgF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 04:36:05 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so10847925pac.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ziHHoXklC+y3oayWvwhzfzOMGyhjx9CkB93EVS91OoA=;
        b=akuzMwkOjnuOlRfvGxXRHjVsd2n+pfivRt8TkXL5B6agFlUbUNy07ZY5J+/OzHxd6M
         9bjGWBL+9Iwu9UxSlc0Mh+oODkqE9WDKh+sI1QhBKQ7HmWL9NaPIMYUmxkHZDPMP7RKo
         e/bofk/mTvTD3AiKzM2wKkdjFV8YTQgmSx7no3JWp7H9ct82cRqzd3Wjx3Cat/R/TUYp
         2RdGgsjuw2ZxDPoTw6h/yPxrMy+tGeDSm3qJsf8wFGan/evaxaYc6il3ysMdJO5dM82C
         us00Fmjm/REKywvk1sjXeeUPYNQ/tOI9KcFvZkBj5EBVUq0AUMYWTSu1TGsahA9UivRu
         drBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=ziHHoXklC+y3oayWvwhzfzOMGyhjx9CkB93EVS91OoA=;
        b=IrfEHg+kILqJ/qAd43QppPekEbHo1IeEw0cn2BRDPgHJxZEGMQjPuerFFybmax+ZE1
         Mr3A8z3zANDqtqkDbUeHwr9YDv1XTw9hFFbRepKD01skaOotL2SsuLVo+b50HyqnWgK5
         mjurM8z4p31JzpmEI/nUZp8xrPo0jIoRJ/3OizN8PD0Kf/otVDDilgk6yVaOkRIplIUU
         fjf5vntuaWiILKEcMk3NoEjpzsfWmj3N/kjeHwWI++oKy4VAoBoaTe6vKmslW60HeftN
         e+fBzJp/ErR46eOxCt+BhZqQ8PfsMqo0PSHJoGyyLyqdDTsnUXo+EkUDVkp8C5NdPpqp
         NOEQ==
X-Gm-Message-State: AG10YOQ+5h/jlkgnrkOrOeMDqmJgzFRIKCpAE0KKtZuXtj8v6LbI7FvqrG1I6OVezxvCug==
X-Received: by 10.66.232.74 with SMTP id tm10mr714579pac.128.1454492164511;
        Wed, 03 Feb 2016 01:36:04 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id d8sm8397084pas.14.2016.02.03.01.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 01:36:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 03 Feb 2016 16:36:15 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285345>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-compat-util.h |  1 +
 usage.c           | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e8f2867..f2bd775 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -398,6 +398,7 @@ extern NORETURN void usagef(const char *err, ...) _=
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
