From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/32] path.c: rename vsnpath() to do_git_path()
Date: Sun, 28 Sep 2014 08:22:18 +0700
Message-ID: <1411867366-3821-5-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Co-00029h-IV
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbaI1BXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:13 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36300 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbaI1BXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:12 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so3202291pdj.31
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XxFIFIoWnwnPHfaxLr+TsBcrrho33xo+7NjpG/xvcHw=;
        b=znCcGX76CopUtD8JHrJRc54VXcy/WnWBdW0/bN3xFCjRGWZizjuPE95rDKq/kI5aRC
         ypbwFosdSiNOD8Zy4p9Yi6JmepGGSQOd4uINSfVvXrpOZfykGzcPos314RoE4HtY+UwE
         Agw6aovOTSTLFZc2LQJnf5EJaokgXMUEF7+GwFCKA6wuPje+OdMEKNw3qR743HrVvJoC
         48BVPP0LGg6e+QAm2b6mbIB8BadwYHAnfkzzFfjf1zq4o3Hd1RlPrZtCdAKU9uJ/sjsC
         1YoDxLqaIt1OkWgBkftpIf3bdZBf7JdFBfRVpYphr2lmJr8j7HX4JahFxqNUSh99N9LV
         rAvQ==
X-Received: by 10.68.139.232 with SMTP id rb8mr11367653pbb.20.1411867391954;
        Sat, 27 Sep 2014 18:23:11 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id ca2sm8539226pbc.26.2014.09.27.18.23.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:14 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257563>

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
index 47753aa..6991103 100644
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
