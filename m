From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/21] path.c: move git_path() closer to similar functions git_pathdup()
Date: Sat, 14 Dec 2013 17:54:49 +0700
Message-ID: <1387018507-21999-4-git-send-email-pclouds@gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
 <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 14 11:51:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrmos-0000qe-0Y
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 11:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443Ab3LNKvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 05:51:33 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59574 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3LNKv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 05:51:27 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so3519594pdi.10
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xiOG6L0K4r7MMC7mnow2aqlte4fI9eAoMaE1LpJG1mY=;
        b=Zo89IhnZJdI9o17z6gTKSxIF334vqaPQlAm3jvJaVg3oxd4HBBv8RDhGhgbGkN75Vd
         baPGh6GsPyNvHGvH0lJxFrfCGltMpeJS8z6bfuiNse2sQ9oOtV2+D27qD5M2r837zkSz
         Ry9JjlpXZtby2R7PkoUnnU8xAZDIdfjg7gQr77IrS9E1TPVFkTCg5ByBCJM1Uf3xzeGe
         4CvqkceWrGB8YBkNaNoemVWFPkGzN86TkYWKHF9BMuSIODZ4cnYQoeEj7ow2arFHQiWE
         ElnZFwBKtS+DHIhMEKUsxj8pDuUe5H36yBim9n+f02qispKWxCDcBrqkIHy2UXp9ZW2u
         XGvw==
X-Received: by 10.66.8.66 with SMTP id p2mr8593066paa.129.1387018286991;
        Sat, 14 Dec 2013 02:51:26 -0800 (PST)
Received: from lanh ([115.73.245.131])
        by mx.google.com with ESMTPSA id xv2sm11398192pbb.39.2013.12.14.02.51.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 14 Dec 2013 02:51:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 14 Dec 2013 17:56:19 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239284>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/path.c b/path.c
index 06863b7..08aa213 100644
--- a/path.c
+++ b/path.c
@@ -80,6 +80,19 @@ char *git_snpath(char *buf, size_t n, const char *fm=
t, ...)
 	return ret;
 }
=20
+char *git_path(const char *fmt, ...)
+{
+	size_t len;
+	char *pathname =3D get_pathname(&len);
+	va_list args;
+	char *ret;
+
+	va_start(args, fmt);
+	ret =3D git_vsnpath(pathname, len, fmt, args);
+	va_end(args);
+	return ret;
+}
+
 char *git_pathdup(const char *fmt, ...)
 {
 	char path[PATH_MAX], *ret;
@@ -120,19 +133,6 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname);
 }
=20
-char *git_path(const char *fmt, ...)
-{
-	size_t len;
-	char *pathname =3D get_pathname(&len);
-	va_list args;
-	char *ret;
-
-	va_start(args, fmt);
-	ret =3D git_vsnpath(pathname, len, fmt, args);
-	va_end(args);
-	return ret;
-}
-
 void home_config_paths(char **global, char **xdg, char *file)
 {
 	char *xdg_home =3D getenv("XDG_CONFIG_HOME");
--=20
1.8.5.1.77.g42c48fa
