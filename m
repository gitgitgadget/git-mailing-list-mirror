From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/10] Add three convenient format printing functions with \n automatically appended
Date: Mon, 23 Apr 2012 19:30:22 +0700
Message-ID: <1335184230-8870-3-git-send-email-pclouds@gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 14:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMITF-0005NV-Rd
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462Ab2DWMeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 08:34:17 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:33527 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab2DWMeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 08:34:16 -0400
Received: by mail-pz0-f51.google.com with SMTP id z8so15499270dad.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DuEKZSpOrm7tYVxFmexiJRZnxN6wsqsY9e2uN9WELXU=;
        b=YS39yet69OGVT3Cca33TiVum8k+c4VZ+O93BQatEswyggoEWstvHxUlLP3z/1s/KDu
         hgEEx5qCIhv/+l1oFjyXZMH83Lo0RkSa93RXIAfUuWi+ULwXn1McTGUn2l/3xrxYCZLd
         aUIgBOPGeZTNUbET9SxFQY6Z99X3m6LDl9UpJpV69B4WKcfQI9TSmNBhUh15lnp99jvR
         hKDlnk+65OqllNfJVDsOVcXnu+0WTvuWZj7fbw50uwBA0My3fNkuUpJcrWqgmhUYShyM
         jMrlrgR4+2Ql2DOlT3wxeLKnvlXrwaACNVWNLA1KKWgcisLHR3E8iqwaF/QkX4eO3Uwv
         2jVw==
Received: by 10.68.233.199 with SMTP id ty7mr9155792pbc.77.1335184456671;
        Mon, 23 Apr 2012 05:34:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.59.47])
        by mx.google.com with ESMTPS id x1sm14283770pbp.50.2012.04.23.05.34.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 05:34:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 23 Apr 2012 19:30:54 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196116>

These functions are helpful when we do not want to expose \n to
translators. For example

    printf("hello world\n");

can be converted to

    printf_ln(_("hello world"));

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 strbuf.c |   33 +++++++++++++++++++++++++++++++++
 strbuf.h |    7 +++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 5135d59..82d1fa2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -464,3 +464,36 @@ void strbuf_addstr_urlencode(struct strbuf *sb, co=
nst char *s,
 {
 	strbuf_add_urlencode(sb, s, strlen(s), reserved);
 }
+
+void strbuf_addf_ln(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+	strbuf_addch(sb, '\n');
+}
+
+int printf_ln(const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	ret =3D vprintf(fmt, ap);
+	va_end(ap);
+	if (ret >=3D 0)
+		ret +=3D printf("\n");
+	return ret;
+}
+
+int fprintf_ln(FILE *fp, const char *fmt, ...)
+{
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	ret =3D vfprintf(fp, fmt, ap);
+	va_end(ap);
+	if (ret >=3D 0 && fputc('\n', fp) !=3D EOF)
+		ret++;
+	return ret;
+}
diff --git a/strbuf.h b/strbuf.h
index 3effaa8..b888d40 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -99,6 +99,8 @@ __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 __attribute__((format (printf,2,0)))
 extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list a=
p);
+__attribute__((format (printf,2,3)))
+extern void strbuf_addf_ln(struct strbuf *sb, const char *fmt, ...);
=20
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, co=
nst char *buf, size_t size);
=20
@@ -129,4 +131,9 @@ extern void strbuf_add_urlencode(struct strbuf *, c=
onst char *, size_t,
 extern void strbuf_addstr_urlencode(struct strbuf *, const char *,
 				    int reserved);
=20
+__attribute__((format (printf,1,2)))
+extern int printf_ln(const char *fmt, ...);
+__attribute__((format (printf,2,3)))
+extern int fprintf_ln(FILE *fp, const char *fmt, ...);
+
 #endif /* STRBUF_H */
--=20
1.7.8.36.g69ee2
