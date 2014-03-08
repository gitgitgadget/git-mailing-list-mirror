From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 04/28] path.c: rename vsnpath() to do_git_path()
Date: Sat,  8 Mar 2014 09:47:56 +0700
Message-ID: <1394246900-31535-5-git-send-email-pclouds@gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
 <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 03:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM7Jg-0004zH-1Q
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 03:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaCHCsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 21:48:35 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:61113 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbaCHCsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 21:48:18 -0500
Received: by mail-pb0-f44.google.com with SMTP id rp16so4957562pbb.31
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 18:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ct8l5pFpEKNs/31EK/qXYNxYlGvFkQLVoyGp8yEpvMo=;
        b=MLVgeEhsN0UvDGQiaotl6q9VHmpqhF0b8SPgYvyY5LTUj4lvSTvz0Q0DYj7tewNCSt
         YNehAuvYq7bQSk3G9+cAypy2oyBXs1/S0AxWLZ0JUZjPMMOc/9nrET0OswsOnkNV6gDc
         +UQYE1Tvt1QbzNMzMQInh3dg8k7pXgezv/W2TQL/5X1g4WV9GG9P18Req4J9sCIefEoN
         pupicWGhDS+9h+4pS/8fmPcF8q0XAq3rhE0MjrbDCD/gAS8etZ8Y+7qAITqIyM2dS05c
         +MOgfk5Oqg1ECq96qSz3c4HeThzguMqJs9m8pOosBVdvux3XhzRwRsuIttAMJ2IoLD5S
         4qEg==
X-Received: by 10.66.146.229 with SMTP id tf5mr26271514pab.50.1394246898279;
        Fri, 07 Mar 2014 18:48:18 -0800 (PST)
Received: from lanh ([115.73.205.153])
        by mx.google.com with ESMTPSA id oz7sm42642196pbc.41.2014.03.07.18.48.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Mar 2014 18:48:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Mar 2014 09:48:51 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394246900-31535-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243644>

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
index 417df76..987fdec 100644
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
1.9.0.40.gaa8c3ea
