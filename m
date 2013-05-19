From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 8/9] for-each-ref: merge show_ref into show_refs
Date: Sun, 19 May 2013 17:27:14 +0700
Message-ID: <1368959235-27777-9-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pY-0006qt-No
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab3ESK1C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:27:02 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39440 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab3ESK06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:58 -0400
Received: by mail-pd0-f172.google.com with SMTP id 10so288528pdi.3
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gF0ZddqvQ/hF33LsmGzV5O87wFctpB/Fu6dBEXUkObw=;
        b=h60800lAOwLKEyVXVqW/zWca1mcAWEd60jC0EP+c1antAbz1WlSGWiLXwUnS2XaYkh
         Ja65L9VwG9tUYqSryHrgHJrczcX3fiVJP1QLCfAumxnZFa65gSiBvMrvdOKPJ6SlcJQe
         tJAXbLL/r7gsAfTS0SCZQQoh01hKDluHS5hrX6IthD04Fwy1ob9tW9pY4OCUZVWDfHUK
         hczt1/rmRyoOFsB9SQRopoXMnEZQOfea4fJof09nEPe3RpKD4XlH3+p5gPVRmsYUtmZv
         0pjbyILrf97+6MbXD47+b6PzBmoy9MFmDroA89UfhKKgQ9Y2F0OHhRyXwPYb3t6VxjlN
         kFuA==
X-Received: by 10.68.106.196 with SMTP id gw4mr55535207pbb.126.1368959218086;
        Sun, 19 May 2013 03:26:58 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id uv1sm19228912pbc.16.2013.05.19.03.26.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:28:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224846>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index a9d189c..1390da8 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -989,29 +989,12 @@ static void emit(struct strbuf *sb, const char *c=
p, const char *ep)
 	}
 }
=20
-static void show_ref(struct strbuf *sb, struct refinfo *info,
-		     const char *format, int quote_style)
-{
-	const char *cp, *sp, *ep;
-
-	for (cp =3D format; *cp && (sp =3D find_next(cp)); cp =3D ep + 1) {
-		ep =3D strchr(sp, ')');
-		if (cp < sp)
-			emit(sb, cp, sp);
-		print_value(sb, info, parse_atom(sp + 2, ep), quote_style);
-	}
-	if (*cp) {
-		sp =3D cp + strlen(cp);
-		emit(sb, cp, sp);
-	}
-	strbuf_addch(sb, '\n');
-}
-
 static void show_refs(struct refinfo **refs, int maxcount,
 		      const char *format, int quote_style)
 {
 	struct strbuf *sb;
-	int i;
+	const char *cp, *sp, *ep;
+	int i, atom;
=20
 	sb =3D xmalloc(sizeof(*sb) * maxcount);
 	for (i =3D 0; i < maxcount; i++) {
@@ -1022,8 +1005,24 @@ static void show_refs(struct refinfo **refs, int=
 maxcount,
 		}
 	}
=20
+	for (cp =3D format; *cp && (sp =3D find_next(cp)); cp =3D ep + 1) {
+		ep =3D strchr(sp, ')');
+		if (cp < sp) {
+			for (i =3D 0; i < maxcount; i++)
+				emit(sb + i, cp, sp);
+		}
+		atom =3D parse_atom(sp + 2, ep);
+		for (i =3D 0; i < maxcount; i++)
+			print_value(sb + i, refs[i], atom, quote_style);
+	}
+	if (*cp) {
+		sp =3D cp + strlen(cp);
+		for (i =3D 0; i < maxcount; i++)
+			emit(sb + i, cp, sp);
+	}
+
 	for (i =3D 0; i < maxcount; i++) {
-		show_ref(sb + i, refs[i], format, quote_style);
+		strbuf_addch(sb + i, '\n');
 		fputs(sb[i].buf, stdout);
 		strbuf_release(sb + i);
 	}
--=20
1.8.2.83.gc99314b
