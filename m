From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 05/28] path.c: group git_path(), git_pathdup() and strbuf_git_path() together
Date: Sat,  8 Mar 2014 09:47:57 +0700
Message-ID: <1394246900-31535-6-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7JY-0004u7-6z
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbaCHCsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:36 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:63849 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbaCHCsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:24 -0500
Received: by mail-pb0-f43.google.com with SMTP id um1so4938409pbc.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zYMAAj6W+Nh4iTKAgYJa5Rrhk8oh91LSATQ9sqzSaAE=;
        b=h3YW58yg6AXNPcmyj8q4svav6SM57l/6uxORmloWnt5kr06zMGe/XHe21AbXPpsr8o
         F+kXbH09BDnbY5xtKfTaIe5d5L3g1FaXz4Fd3A2hX1mePyDdBCCDB2JHgY1gzuCXvr2S
         OykzTW+cHyg+EU4jUAUXcTXQ5dzKJOgdSRBT9S+eM4nSN+2jLzIJubuYmasRCJLdKfUO
         fLan2lDFND44Qq0ofTOUOTOJDDMRFktGz77sTqgTDI6qUZSXt3gUV6OIFlxBR1c4onf4
         5tgWQEXlN8D9JrJ37zhuDemBnFtyabRkfpio4uCtyXpXHg6HOCtv3zvfH+IFX0iXr54x
         Yc2A==
X-Received: by 10.66.142.170 with SMTP id rx10mr26243842pab.117.1394246904484;
        Fri, 07 Mar 2014 18:48:24 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id ja8sm41565192pbd.3.2014.03.07.18.48.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:48:57 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243643>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 path.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 987fdec..1c0f160 100644
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
1.9.0.40.gaa8c3ea
