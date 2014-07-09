From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 05/32] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Wed,  9 Jul 2014 14:32:50 +0700
Message-ID: <1404891197-18067-6-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mO7-00035H-5h
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbaGIHdz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:33:55 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:51367 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbaGIHdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:33:54 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so8576872pdb.11
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WfHcohEWr1BcAZuMQqP9Ifb1Y2YLLHAlHijLEdVE6/I=;
        b=FnP/vpGWpphXEcOvZupsLswMDbwlc2tI/pgX4PlfbQSNc5PRgn3JIhFkJdI/E+5jhW
         LTgk5dARcEJWesPWGfypsoNXTAy4YYWromiGgZPG7NTstTksgzlMRo7JS7FQFZ7Dc7st
         JC7I7+uW9Gu8C5pIB8ScK8YNl1riN75pdafUKHfc93GjLywk1fodgAVVTf+taO9SJSI+
         PcmVPXRmO5HKqifUPeOtqLEFMpSU03pzpXgKD+NwXMKNSdpnE20BKFoRd0CMlEHThYU+
         K8DrwLdf3xCTdW/JKqspM1lngQhyaYfDZtCQVt9xnL1Rxky1x9rUSL3fEUMhtLfQO5ED
         QK8w==
X-Received: by 10.70.39.37 with SMTP id m5mr586310pdk.131.1404891234186;
        Wed, 09 Jul 2014 00:33:54 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id fx5sm57925089pbb.62.2014.07.09.00.33.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:33:53 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:33:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253080>

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
