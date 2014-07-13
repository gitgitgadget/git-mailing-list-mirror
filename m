From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 05/31] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sun, 13 Jul 2014 11:50:42 +0700
Message-ID: <1405227068-25506-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jul 13 06:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bn7-0007ox-Nl
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbaGMExd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:53:33 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57013 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbaGMExc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:53:32 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so3197145pab.16
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WfHcohEWr1BcAZuMQqP9Ifb1Y2YLLHAlHijLEdVE6/I=;
        b=kjbA2BUuSVJ/k6e3tO0JY2+H5HxuMQwm+PL8ewaIsYcN13BGWXcqzeABshdYO7cs5I
         Ix6iLObUKzRhApDRvwP/mmD6NCDXX8j5QV90G6frECtvxq8MmfSc9CGiaZDxyxuJu/A4
         YDzZrjbsDm/R5wYSOpSqrmxbxyv9z/TmrFIpFkrKg4yJ4k0AYALW3DGyCId02080F0xv
         XsMmtqfI5+kDd1ayPxuG15wc+kTLBzu2SFLERg0s1ZVNjR40f8wQZ4LSyAUBDGWblaw1
         DDptZlvPhu8hQOe37kkMJESoRY+RXCFMknyscFk4u/PWCn+pV12AAKB/tbWH3CDvG0qg
         7ZHQ==
X-Received: by 10.70.43.170 with SMTP id x10mr3765704pdl.9.1405227212150;
        Sat, 12 Jul 2014 21:53:32 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id da10sm9076700pdb.60.2014.07.12.21.53.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:53:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:53:32 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253408>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 2cb2e61..65881aa 100644
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
1.9.1.346.ga2b5940
