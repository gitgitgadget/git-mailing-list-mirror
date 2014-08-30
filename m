From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/32] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sat, 30 Aug 2014 15:33:35 +0700
Message-ID: <1409387642-24492-6-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:34:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe7F-0001Su-AE
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbaH3Ie0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:34:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50937 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaH3IeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:34:24 -0400
Received: by mail-pa0-f50.google.com with SMTP id kq14so8178399pab.37
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NLCcgjkNY3SHfYx7r3LU9/gN/EE3UpEghD+IRPSO82U=;
        b=FadJaES8hAnl4PaA725OTrdiutzyQxbyIg9sRNt+pEI+acUQbjtmLByluxiKArnK19
         duJ4EckFfr9XmL7nFTB9bmUJBXh5kXkr0B5tEEJLpu2vFbyqRAossXSNtUHG5t6unEdu
         SfiTWQf2Xb6GlG3S6mN87inay4iIZQ4C1kZrCi9znuw3sicDj67xZ/TzoG57GDmIUjbh
         +cwJoAKs07ieHBqULe5Rn1mNs1zuz+vl6kbvyGZB8uXReg1kgWYXKCO/FGUDc5QAHcjr
         POdFLCq/xFUFulMep9mxBnOfN6D0NYSj/pHHMHB92KzsJCrDIqu4fKYaFrzAYvbnEJ13
         HdMQ==
X-Received: by 10.70.129.162 with SMTP id nx2mr21271550pdb.73.1409387663579;
        Sat, 30 Aug 2014 01:34:23 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id mx3sm3123882pdb.81.2014.08.30.01.34.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:34:32 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256215>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
