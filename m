From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/34] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sun, 30 Nov 2014 15:24:30 +0700
Message-ID: <1417335899-27307-6-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzpW-0007IJ-0M
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaK3I0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:26:01 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36965 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbaK3I0A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:26:00 -0500
Received: by mail-pd0-f176.google.com with SMTP id y10so8921163pdj.35
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kb1mngDhV14vUu9Xh7k46FKa/SetymDkaxnAlZ3dqFk=;
        b=yxELE5HtmtV2vuNxHH37fnIYEvAxrv0oxyuv2ecyjTSAhRpd7sKByViSMTEyttKx5e
         Yzd7zKmJFQmvJCpixnYSFD6M0luaaKvxTopKZPBCOIDP7N0zdRvgBhJXyu886Pu5/4Y2
         LsqJ/mMQjaZBo7zpCwriyGzmlRfcgOKUfpPK46V/LVAZ5lMhYba6Sdlf2n5tpReoqY4t
         OA2ejreisLNKe7SVnmN+uSi7DGf/SnohvDkH6GKy6Ls/5SOY9soys8vXz3KiQW6fyozf
         /PSZ6bgz6hiwk+zw6klu/G6lF5ZN0p5k3bL6aNWltuot/8/BBPCg4d8KDzITGbYn90t6
         Fl2Q==
X-Received: by 10.66.157.196 with SMTP id wo4mr401864pab.156.1417335960203;
        Sun, 30 Nov 2014 00:26:00 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id h1sm14387669pat.6.2014.11.30.00.25.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:25:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:25:53 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260392>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 6991103..df0f75b 100644
--- a/path.c
+++ b/path.c
@@ -78,6 +78,16 @@ void strbuf_git_path(struct strbuf *sb, const char *=
fmt, ...)
 	va_end(args);
 }
=20
+const char *git_path(const char *fmt, ...)
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
 	struct strbuf path =3D STRBUF_INIT;
@@ -109,16 +119,6 @@ const char *mkpath(const char *fmt, ...)
 	return cleanup_path(pathname->buf);
 }
=20
-const char *git_path(const char *fmt, ...)
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
2.1.0.rc0.78.gc0d8480
