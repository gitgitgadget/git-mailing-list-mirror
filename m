From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 04/27] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sat,  1 Mar 2014 19:12:40 +0700
Message-ID: <1393675983-3232-5-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:21:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJiuv-0001mT-6X
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbaCAMVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:16 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37704 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:14 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so1920527pad.14
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Szu6u4D4Dq88ZKVnYmLSdtTaNsvV/PSjwjQX6Pm9aqA=;
        b=Xygir7DD7LjnlfF4waS9oVIZQliwojzTVpcCQiPW2yu0YanYtz4GhqCTKQJ8McoOUp
         DIuZYqMbo5o79rGPRo+JPM9RwXCeooPkj5Y658lzT8QYm4kY/cROjQUrzp2pqyU4Mzyn
         M3UCkhxFqST1QxsTIVddYwNlkZ3aEFc7CPtmQcUN5NkeWdxNBkRlsODtZp6O4cc/L0xE
         S5VSrSXVLS2/85B8ClUj8KyWiayU1i2Xf8MzizeapkxSwVhhGgFz9Zc25Avjm5WEp3Fu
         VfSZ6fCcS0DR/ArIhxzBpGQIYzk5fdV4HEkIpNxgl6uI5P2dgjdI1ZqCIqTH5hrCJHCO
         3BZw==
X-Received: by 10.68.197.99 with SMTP id it3mr9149150pbc.37.1393676474141;
        Sat, 01 Mar 2014 04:21:14 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id iq10sm15911415pbc.14.2014.03.01.04.21.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:21:39 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243069>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 29048fe..ccd7228 100644
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
 	struct strbuf path =3D STRBUF_INIT;
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
1.9.0.40.gaa8c3ea
