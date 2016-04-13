From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/26] transport-helper.c: refactor set_helper_option()
Date: Wed, 13 Apr 2016 19:54:46 +0700
Message-ID: <1460552110-5554-3-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKO-0003vB-G5
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966081AbcDMMzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:21 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34098 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965750AbcDMMzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:20 -0400
Received: by mail-pa0-f66.google.com with SMTP id hb4so3885735pac.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORi2j2maZ/9C01r/FgHy3OtkpIRUB3LnLIwE7rIx9Y0=;
        b=eom7Qu/vwnHIR2CplJnXt6i8fTiaIha10+MLwzVx1AIbWkYuU6bnyrwHE6CKvL1wiR
         XE6G4psacPnpglQkN5D1+r8QtlZSEHoh0Oi5OhorMC5ryzbx8rLl4P8AIRvI45YwO+xv
         fwGX9CZRhCI+zMtyNHuHJg1Fg2lOd0rBYZaGNy1OyMS4iJW4vqmlKEzCR7OGZ6jN1AeW
         Xs/NZ6rLepxjXETDobGK1kaIH5shBhpJ8OtC7BA9lHeY89jlBebyt8rr3PGh6xXxyNFV
         wSrqy45+ypzxDOt8p9+HO+Ri3Xz6iSVscLdxLHsIrpe71aPBeGItkPbstJpF5ZP2Sn5O
         toZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORi2j2maZ/9C01r/FgHy3OtkpIRUB3LnLIwE7rIx9Y0=;
        b=GP06D480sp1TSpVhmU2oTHWRX8DQeLiSTQm/NC9f/anB0io59iSnH6gX5JDY/Ev8Pq
         dDBMfOd4LTFGh3GL/2zbWDUXMT1bi/l2NL4pfiXfCEht/n8/ok41tuIlZYDJfB5vSnRW
         BYz0JL7eICGNmJlOLo/UqUj2Uo2QhXPO4dQk2nmSPI+AOm//9cWnYBJEsQKTP2vn38q4
         dN+z1w4UyzkUDzXWUCVQeXOxUCfN+7xpLLgCR/wz5gOngUxiTpVCi7ArVG48V2WiE0g0
         RZAz0ngcexfkya/dUG2kriwFcgywg/sBKtnjtVjqaLJ+x376TBiKdSBDGHpqz/DgEUIT
         uwGg==
X-Gm-Message-State: AOPr4FVF6R+AGi8h31eBDad1cq1QmSVN8Djaq6bMhXq8Htn3wSEVbh1tagF1kzgLBNNM5Q==
X-Received: by 10.66.174.134 with SMTP id bs6mr12565670pac.53.1460552119187;
        Wed, 13 Apr 2016 05:55:19 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id p189sm30545781pfb.51.2016.04.13.05.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291396>

=46or now we can handle two types, string and boolean, in
set_helper_option(). Later on we'll add string_list support, which does
not fit well. The new function strbuf_set_helper_option() can be reused
for a separate function that handles string-list.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport-helper.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index a6bff8b..35023da 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -260,6 +260,28 @@ static const char *boolean_options[] =3D {
 	TRANS_OPT_FOLLOWTAGS,
 	};
=20
+static int strbuf_set_helper_option(struct helper_data *data,
+				    struct strbuf *buf)
+{
+	int ret;
+
+	sendline(data, buf);
+	if (recvline(data, buf))
+		exit(128);
+
+	if (!strcmp(buf->buf, "ok"))
+		ret =3D 0;
+	else if (starts_with(buf->buf, "error")) {
+		ret =3D -1;
+	} else if (!strcmp(buf->buf, "unsupported"))
+		ret =3D 1;
+	else {
+		warning("%s unexpectedly said: '%s'", data->name, buf->buf);
+		ret =3D 1;
+	}
+	return ret;
+}
+
 static int set_helper_option(struct transport *transport,
 			  const char *name, const char *value)
 {
@@ -291,20 +313,7 @@ static int set_helper_option(struct transport *tra=
nsport,
 		quote_c_style(value, &buf, NULL, 0);
 	strbuf_addch(&buf, '\n');
=20
-	sendline(data, &buf);
-	if (recvline(data, &buf))
-		exit(128);
-
-	if (!strcmp(buf.buf, "ok"))
-		ret =3D 0;
-	else if (starts_with(buf.buf, "error")) {
-		ret =3D -1;
-	} else if (!strcmp(buf.buf, "unsupported"))
-		ret =3D 1;
-	else {
-		warning("%s unexpectedly said: '%s'", data->name, buf.buf);
-		ret =3D 1;
-	}
+	ret =3D strbuf_set_helper_option(data, &buf);
 	strbuf_release(&buf);
 	return ret;
 }
--=20
2.8.0.rc0.210.gd302cd2
