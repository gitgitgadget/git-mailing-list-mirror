From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 04/31] path.c: rename vsnpath() to do_git_path()
Date: Sun, 13 Jul 2014 11:50:41 +0700
Message-ID: <1405227068-25506-5-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bn0-0007eH-8A
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbaGMEx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:53:27 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:62965 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbaGMEx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:26 -0400
Received: by mail-pd0-f170.google.com with SMTP id g10so1269409pdj.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=evQ9G0by1iYQMJPkOGLNlpWH1NMNudo7Eu7Lu6hrVCc=;
        b=J5mFLyNurhprumo8Ran2Euajszs68X6yPQvp3kFRIfs1i5hFT17uWErepV9J2DQcz3
         oJVjYMy0KJ56s13wpWP2HUbQ75TC+0+OHPzMx/1aQOZHz83LrpNHWwJqqxZQ5aqOqAMV
         4fgfu7jRL8HjToGOAZy3SAwNEjjFzjpKMLp5k2emSfDlklRQH/hVOTN/FaoKT8ZnHyqS
         TdfaRg+OaC/2s3nQ5r1IBplImk39E/GLzEg1M8+zKT+YQCBDCzWD0t+JE473Ot3cUwsj
         fOWDKyGOmu4oj7m0wMNsjFYxlQIX7jCkmcXicz79ade0X5GNBc3NVYAdCDIk1jADUEwv
         QT4w==
X-Received: by 10.70.88.230 with SMTP id bj6mr8999839pdb.40.1405227206234;
        Sat, 12 Jul 2014 21:53:26 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id h10sm29004560pat.11.2014.07.12.21.53.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:26 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253407>

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
1.9.1.346.ga2b5940
