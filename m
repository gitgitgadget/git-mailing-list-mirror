From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/12] utf8.c: move display_mode_esc_sequence_len() for use by other functions
Date: Sat, 16 Mar 2013 09:24:34 +0700
Message-ID: <1363400683-14813-4-git-send-email-pclouds@gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 03:25:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGgoY-0002Pl-CA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 03:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab3CPCZM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 22:25:12 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48268 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab3CPCZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 22:25:11 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so4561705pbb.32
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=IBal+T+NC1W4IefMg74Wmfy4mziDb4jAK42OGED1veM=;
        b=DVFwyiSBEa28H19QCeXzUM4GljcnD/shDuFNYbEktBUV6Q+mcwXawN3KDIcq8CzbEe
         b0TTAgWY22jISAr4xPj9iBbPmu5oVpBFVGLGE3AMXmJK3+xQBNI2EeKEJxU2fBbsENvm
         9W5yyDwqyhNh2GaAnl/h1Yh4uF4FF7V1DumUYKBWejht0FJGE0K8mjI9Rz4P8qWeBuvw
         s846psTGjbcKpF3aAZ1To83hO/chQmhXr7DEuv3hU0qEiY1nTL5HlSUOXiP1HP5mJwTi
         uJsefSDwsBUlJL8VmTCq9fVikynbA7kkZNkRl16xtglbXPKQryy7rBNxEh+osVMxF/I/
         xDGw==
X-Received: by 10.68.254.35 with SMTP id af3mr20995231pbd.176.1363400710618;
        Fri, 15 Mar 2013 19:25:10 -0700 (PDT)
Received: from lanh ([115.74.58.84])
        by mx.google.com with ESMTPS id kb3sm11507406pbc.21.2013.03.15.19.25.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 19:25:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Mar 2013 09:25:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218275>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 utf8.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utf8.c b/utf8.c
index 1087870..82c2ddf 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,6 +9,20 @@ struct interval {
   int last;
 };
=20
+static size_t display_mode_esc_sequence_len(const char *s)
+{
+	const char *p =3D s;
+	if (*p++ !=3D '\033')
+		return 0;
+	if (*p++ !=3D '[')
+		return 0;
+	while (isdigit(*p) || *p =3D=3D ';')
+		p++;
+	if (*p++ !=3D 'm')
+		return 0;
+	return p - s;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int =
max)
 {
@@ -303,20 +317,6 @@ static void strbuf_add_indented_text(struct strbuf=
 *buf, const char *text,
 	}
 }
=20
-static size_t display_mode_esc_sequence_len(const char *s)
-{
-	const char *p =3D s;
-	if (*p++ !=3D '\033')
-		return 0;
-	if (*p++ !=3D '[')
-		return 0;
-	while (isdigit(*p) || *p =3D=3D ';')
-		p++;
-	if (*p++ !=3D 'm')
-		return 0;
-	return p - s;
-}
-
 /*
  * Wrap the text, if necessary. The variable indent is the indent for =
the
  * first line, indent2 is the indent for all other lines.
--=20
1.8.2.83.gc99314b
