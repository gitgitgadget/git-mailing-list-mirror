From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/32] path.c: rename vsnpath() to do_git_path()
Date: Thu, 11 Sep 2014 05:41:40 +0700
Message-ID: <1410388928-32265-5-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqar-0001Cx-LV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbaIJWmZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:42:25 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32789 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbaIJWmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:25 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so4293642pdb.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U6ryIPvcPd3EGO6QeCqXV8uT/uyrA0V6SNjFj4vEJhw=;
        b=DYet6CuDMS7KwYfw+vn8dc3aviT2JhK+jXRiN9IB++CT6SyU+WcK4CAYEXdfib7oKN
         9iMNx0oSnQhAOljlpm42B00ojbXY7qiKPdefAr7U6Ey9sWBo5bqvNB3JM2vo8hHyjJr8
         sn4/P5CLoAMbKSz759uOsriZt16hUoIO9mmwPLTQITYjNdfLbF1i8vMRk/N/x+UzKIQP
         b+pvlm7q7zDgt2mjeNEknz04fzRCs6Ua9u5qvhi4wpeDcaCOXym2R2kZF8nWvSBfvzNE
         f1xW0g2Vt/W80rsOifvhjKvG/GHf9fdv16YHke9uijGfNPGvVyR+fJ+LMGunT4qvE9QR
         AOAQ==
X-Received: by 10.68.139.232 with SMTP id rb8mr41467329pbb.20.1410388944717;
        Wed, 10 Sep 2014 15:42:24 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id i10sm15613187pdn.26.2014.09.10.15.42.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:42:44 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256781>

The name vsnpath() gives an impression that this is general path
handling function. It's not. This is the underlying implementation of
git_path(), git_pathdup() and strbuf_git_path() which will prefix
$GIT_DIR in the result string.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 path.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index e545064..2cb2e61 100644
--- a/path.c
+++ b/path.c
@@ -60,7 +60,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, =
=2E..)
 	return cleanup_path(buf);
 }
=20
-static void vsnpath(struct strbuf *buf, const char *fmt, va_list args)
+static void do_git_path(struct strbuf *buf, const char *fmt, va_list a=
rgs)
 {
 	const char *git_dir =3D get_git_dir();
 	strbuf_addstr(buf, git_dir);
@@ -74,7 +74,7 @@ void strbuf_git_path(struct strbuf *sb, const char *f=
mt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(sb, fmt, args);
+	do_git_path(sb, fmt, args);
 	va_end(args);
 }
=20
@@ -83,7 +83,7 @@ char *git_pathdup(const char *fmt, ...)
 	struct strbuf path =3D STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(&path, fmt, args);
+	do_git_path(&path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -114,7 +114,7 @@ const char *git_path(const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(pathname, fmt, args);
+	do_git_path(pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
--=20
2.1.0.rc0.78.gc0d8480
