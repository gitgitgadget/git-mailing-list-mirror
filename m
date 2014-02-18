From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/25] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Tue, 18 Feb 2014 20:39:53 +0700
Message-ID: <1392730814-19656-5-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkun-0006NW-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbaBRNkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:40:40 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:42063 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbaBRNki (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:38 -0500
Received: by mail-pa0-f52.google.com with SMTP id bj1so16749691pad.11
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iWDmvw09Nbl/XidwXWrwAPsWgiM658tsSako3GSLr9g=;
        b=qXjzvqdD3jbCJaeVspWpeSTwkbS5XWK8Xw2P6Is6kFRl+REnCYcY9vl8BtNJitbSjF
         XmlG3m4Qeo4Y/VxvdQK+9vN9kbj0Omz7EfzCNEclTSkOUUYAWe2wxMJPxI+U/MM63+Q+
         +scbKLHGWHNRiD8KD03BHyDnj6ZpCPSWC49nWMp/Yus0Imu7CCz5N1+d+vDl298sZtCv
         umkXo3EFqeO1BFf8THqYl3pW9WPVc3A6TD4WWMYU14+WlHE50WGMAAkX0gfOcFhGjE04
         Ru3bFw4uSMjFK6bxAMam/0KiSMM9nBP8gt6+neJdDFklevxlySXq4vGVfKLL0ph1/DKq
         VLQA==
X-Received: by 10.68.37.42 with SMTP id v10mr32907860pbj.127.1392730838132;
        Tue, 18 Feb 2014 05:40:38 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id os1sm142645768pac.20.2014.02.18.05.40.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:40:51 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242304>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 635ec41..e088c40 100644
--- a/path.c
+++ b/path.c
@@ -78,6 +78,16 @@ void strbuf_git_path(struct strbuf *sb, const char *=
fmt, ...)
 	va_end(args);
 }
=20
+char *git_path(const char *fmt, ...)
+{
+	struct strbuf *pathname =3D get_pathname();
+	va_list args;
+	va_start(args, fmt);
+	do_git_path(pathname, fmt, args);
+	va_end(args);
+	return pathname->buf;
+}
+
 char *git_pathdup(const char *fmt, ...)
 {
 	struct strbuf *path =3D get_pathname();
@@ -109,16 +119,6 @@ char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
=20
-char *git_path(const char *fmt, ...)
-{
-	struct strbuf *pathname =3D get_pathname();
-	va_list args;
-	va_start(args, fmt);
-	do_git_path(pathname, fmt, args);
-	va_end(args);
-	return pathname->buf;
-}
-
 void home_config_paths(char **global, char **xdg, char *file)
 {
 	char *xdg_home =3D getenv("XDG_CONFIG_HOME");
--=20
1.8.5.2.240.g8478abd
