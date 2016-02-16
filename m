From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/26] usage.c: move format processing out of die_errno()
Date: Tue, 16 Feb 2016 20:29:02 +0700
Message-ID: <1455629367-26193-2-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:29:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfh2-00027l-Gl
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbcBPN3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:19 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33433 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcBPN3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:18 -0500
Received: by mail-pa0-f42.google.com with SMTP id fl4so91702699pad.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3Afi9cDyYGVcBasUJn6ZFLbtmcceDZWXuJzSCOucgOM=;
        b=mQvaEe/CUTcxWIkKhrcyCb2h74veTYMySAuF9i0OzE1P3z2J6mmM3bdR8uDnXVD45I
         2oizjnm6MPkLq2gaz2P7FC0J5bTkNAX486LaO7ME5G9xoMxXNG5rUelRMrcbnfQHxENc
         CBQxMCB6WCHeWG0zVE01Eexaw8FLh2ExcmEp1lHe+oCIus01Myz1+Npqjdd2ToAgLI5L
         LoD6zmGYv4Eto8CuY/QD+grPzunwkbr1M9Fh9PrOGpcP/KKOx5EWBC3q7MzNQZatFdwb
         u6KI4uqePUTrjeIOqPVj6gR6l7ImF4REbAAbQM0ahCxxToOIIYNsImTIuZRUxwY05rLd
         M1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3Afi9cDyYGVcBasUJn6ZFLbtmcceDZWXuJzSCOucgOM=;
        b=GmzG06xYok5NeoR3rsphUEoew0o3tRZ9YO46fi5sZHfu0gX2JkloER9UDZYknbfVhs
         nOoxQGduKfLSDS7MMw6QYIPmRO027HjLfe+j8wc8mnjRh8Re2EEePaXUpZMw+CwVzYM4
         RaOKlaORAItsL2YlxKXCP1akRyU7ZwAh4Occ6lmULNtNr85cI/iMegFetXb6wnhYgGSL
         dXU9ki4ewVheyy8FlVVqjSjRN/nEgXqyB92x4QB+KhjgAuY6Fv8AlwvPNYRMiBwQ4Xy0
         4azh0tPcTTAlAew6oJbBFvpwCWCP7zNMSjDTXu5AQcughj+ArDUL4uXRLdER8JWnIfWz
         pJqg==
X-Gm-Message-State: AG10YOSRMRjXPFLe3O0nlA7zGr0hXA5Z4+LiHw5EBKA1cLUvGT5Qej8KX6V8tvYxpfC+ag==
X-Received: by 10.66.254.168 with SMTP id aj8mr31390460pad.18.1455629358275;
        Tue, 16 Feb 2016 05:29:18 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t12sm45943465pfa.54.2016.02.16.05.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:29:40 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286361>

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
2.7.0.377.g4cd97dd
