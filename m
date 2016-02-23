From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/25] transport-helper.c: refactor set_helper_option()
Date: Tue, 23 Feb 2016 20:44:40 +0700
Message-ID: <1456235103-26317-3-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDH1-00088m-I7
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcBWNpB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:01 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35919 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbcBWNo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:44:59 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so110639733pab.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=42gPbUZkFxYwazNd7ftt8KJgvbIY3Cy8t/1P65cOr6Q=;
        b=kZgGwid/id7suE+MR6wjgxrICEB3P4hZXfs5Zu4s5qYVTlRPWjz2M66gEgmds1wjMA
         E6GYX0KpGz0zlliTcgGlZes0JVpc4SgZXGQLPUu3m0CsPZgfMDz/n7M7ELXbHQ28z6vI
         TT/efueG6n2gzboTQPNzy0YE66pNKKaZUTVIFRdOLCxiwAbHQh4KbVyCbXqG/wTZ5aVl
         qu2DUbo9iPv+fPe/de3f1Aoz0xSZ6JAG0I4HQu0ith5ZSaMNRQtygNrvaqaGfY7CHNlF
         78/DRG6K2JH+Wn2xYamuJQfgyghJufLe5t8MIudtNtxjFpkWFe0c80roci5q/zcT+UrS
         uKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=42gPbUZkFxYwazNd7ftt8KJgvbIY3Cy8t/1P65cOr6Q=;
        b=bk/RZgoDVEGfwvUzxiPzpH5r/Qa+6kPLCAHnty5fwyP4OiTUqndrv4ZvKr/CqL9y0p
         zdaEDG6KIjOmY6QzOfuuwBg/n36WiWGkAsiLf9DAGDbcsOjsZmw4QI+4APf64Rq40MOQ
         kZ7mWv1xsTEsuWQHqOWGuZWsKIPBwfYBTsbDQ4iz8Pz6EWf8zfY53Guh9dwx22oyNN2P
         djF+Rq6mgvqh+cKgXd5rK9SVtU6g4eJ467yYxvNVDKKwC0MHcK9Vgi6OxlzF0nAZ+zOP
         LgFRhs/yvqs9zrTyK9kJw713NPq4QZcHLsSRl9OFn8jrW5Ue9U4wEkmdl+Yf4XWPBE3S
         2MYw==
X-Gm-Message-State: AG10YOQ7l991+O3HasKQ0zEzwEnUz1NNyay3LIEANDZl2xUNF/gMAh5PMMAnPZeMjSVQgg==
X-Received: by 10.66.100.196 with SMTP id fa4mr46236950pab.37.1456235098944;
        Tue, 23 Feb 2016 05:44:58 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x12sm44396604pfi.88.2016.02.23.05.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:44:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:27 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287054>

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
2.7.1.532.gd9e3aaa
