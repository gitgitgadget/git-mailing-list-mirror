From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/32] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Thu, 11 Sep 2014 05:41:41 +0700
Message-ID: <1410388928-32265-6-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:42:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqax-0001FI-01
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaIJWmb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:42:31 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47311 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbaIJWma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:42:30 -0400
Received: by mail-pd0-f173.google.com with SMTP id ft15so9964822pdb.18
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NLCcgjkNY3SHfYx7r3LU9/gN/EE3UpEghD+IRPSO82U=;
        b=HwNU8As8JjUCYvuJf3MrxPDgXQPi29ENTDoTg/JWKCCmzTdDhrjF1ZtbI9ie9eywOd
         PmzcUhtaAu3euGZBv/D8txN1PDILm7/biM+vCinLTrRgxBb/tPG6A90DeyO5/2mWmkJh
         GMncPUcKjiaiUNK/WnaMGC85k71in2Y/uQSagloikIFW2MT1sI9jPVfp3NPCOEvdGc2U
         1OP1QX+5LJyEp/vG1yVO/dra8kKPRFn4eGMgbymtSRZ8olDEFXkzPUbJ/BCU+0oP6Fl0
         W/4O7jUckRwwcyCEDVRzlXZkDwio6HzgHTTrzrjF2TMCrBvMi773pHPbj/6ZbM9Gjt1y
         GAyg==
X-Received: by 10.68.89.36 with SMTP id bl4mr42293222pbb.17.1410388950126;
        Wed, 10 Sep 2014 15:42:30 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id dg5sm16349308pac.12.2014.09.10.15.42.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:42:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:42:49 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256782>

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
