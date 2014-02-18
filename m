From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/25] path.c: rename vsnpath() to do_git_path()
Date: Tue, 18 Feb 2014 20:39:52 +0700
Message-ID: <1392730814-19656-4-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:40:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkun-0006NW-7U
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbaBRNke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:40:34 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43895 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581AbaBRNkc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:40:32 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so15933963pdb.10
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qdtkc9h84QivlYgZfWm6npsQak/5KMI8xcIuhammkVU=;
        b=nCzjUp80ZarkhskxsmhIWiROvmfd90nf3t85j91PCDH10H6/aLnOP27+2+wXfHjQdF
         XANzzTiw6SzDjGTYORAtW6gwEjDPuIejvgzJwErMBt23SEQy82UJhtzvIhCt3PXr9Ld7
         /dFKtTA8Z9JcAKgosBGAFTjXIn3ujrAIJGkLnmoW6R/mWLhRf0L4SAH/Y3mLLYntaQl5
         1pRBMjr7WBq32Uzw1+AuSr746BipyKP0bnOube7tGJ7a30c5l6rX7wK/B9EHwokIZ2jb
         n/OVZjfpjKa6Csk4awSIQ6HkEBdktuySKQgba+1dG5faWeY1d5C3nR2c1irbnAiZlqVV
         1TxQ==
X-Received: by 10.66.25.241 with SMTP id f17mr32965486pag.127.1392730832334;
        Tue, 18 Feb 2014 05:40:32 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id g6sm142557923pat.2.2014.02.18.05.40.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:40:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:40:43 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242302>

The name vsnpath() gives an impression that this is general path
handling function. It's not. This is the underlying implementation of
git_path(), git_pathdup() and strbuf_git_path() which will prefix
$GIT_DIR in the result string.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/path.c b/path.c
index fe3f844..635ec41 100644
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
 	struct strbuf *path =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(path, fmt, args);
+	do_git_path(path, fmt, args);
 	va_end(args);
 	return strbuf_detach(path, NULL);
 }
@@ -114,7 +114,7 @@ char *git_path(const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	vsnpath(pathname, fmt, args);
+	do_git_path(pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
--=20
1.8.5.2.240.g8478abd
