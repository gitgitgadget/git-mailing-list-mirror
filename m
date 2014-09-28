From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/32] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sun, 28 Sep 2014 08:22:19 +0700
Message-ID: <1411867366-3821-6-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Ct-0002B7-1a
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbaI1BXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:19 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46141 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbaI1BXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so4854440pad.15
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vs2mWrW9IAhenappUwxYhG8Aj2Le6qYiuvegFnZzu18=;
        b=Ncs/g5R2jcuuOAjv+YxFQIApFxGe1rk7yeiUTmqpsVqsW/zmYx2Oe6w8Yb4CEx0tjx
         +nI86yUsqTSG7e3O0ZPMp5KLBkWcYWlLyIAh0CDH/lVZByjKUXtNzna4P5NZeUmxEVFe
         my4jPEMPzn/tP+usa1i0VBODQSszHdonLudCDatvUOWZwmyGDv8jIPzYCmz5iSp1GbHS
         Zdu3gJ+76DK2nU2VT+qBNvq5G3BgCaiMof0/i38BpbhxWvgunlQyuWduFlH8odEeP9Da
         gU/6renvp6J0w5wzzTJVes4XxZIz5CqmVQ0SQJFw2Y0CHWZ6/Ohcys2IPRZWPT56tMH4
         EPRg==
X-Received: by 10.70.55.5 with SMTP id n5mr111301pdp.148.1411867397286;
        Sat, 27 Sep 2014 18:23:17 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id hz4sm8542050pbc.22.2014.09.27.18.23.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:20 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257564>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
