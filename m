From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/25] transport-helper.c: refactor set_helper_option()
Date: Thu,  4 Feb 2016 16:03:38 +0700
Message-ID: <1454576641-29615-3-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFq9-0005VK-VK
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbcBDJEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:31 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36861 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965381AbcBDJEX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:23 -0500
Received: by mail-pf0-f175.google.com with SMTP id n128so38136733pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rzFZd0DeQzlpwbKIizYEfOjfZ65+7DT7BhRNgMlD2b4=;
        b=xRDc1MRva7OQtvMRE5FUAgOiHAb7TfPDqoxzZJnfxkJrWsMiWJOvfKpmRNoJ0OS+jX
         M4hS176FwRppWp/rI4alNo8KnPh8U3vD+nblso7t9EhC5NLtffAI8plqROdzxdx3sPTt
         hf0bobRQkhLO7zpoAo40LYVFUuWufTWOKG6mTakLUlED5tdLx1l4VgpcNpVJzdAnEVK8
         p8W9NSLwQbg7UGvfOK/nCOANogpjNmtj8KeS49seiXU2XPqjeDcc4Jz+mwhvBXtVK2zS
         xML0MzaSaoGrS8mgWm84uDnz94rlzw+a6cCM4xwugQ45qCOvh0ztMUXOO5CMgkTVwG+U
         5CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rzFZd0DeQzlpwbKIizYEfOjfZ65+7DT7BhRNgMlD2b4=;
        b=SAwxHcVMY+UoGDBIzXNlC8l2Bw66h1rQKo4x5yq9jm99WB+pO4m1TP1xH2u0FcTC28
         JVZsPX9xNHPSVMu2Z+ij8t/iKSvOx/usE7q4mKAcJPCs+2ehgNB7+PaIUZi9UbZqfCD1
         FhYG1iChGbSnSHO5K0bMEAYVrC7WivSZ3isbFeg0oOyD9BLSicwHtS3ywK9kxh3R4Y3+
         BhlpRt9GGKDP3Bi4P3PEBRLQFRL0qW9dxMhVUlqUVktpYKNxgB7vsk4/MIJDxhOrQsVt
         bLVJYND5wfJ14l+ojCarPh1QogeSxBvBCOPSRXw+ymeI5PqPbN/phtmI+8Zp0SPEBzcE
         lKFQ==
X-Gm-Message-State: AG10YORSQJsFnWe/A+cBHqL5u2bpQVE/sD16rHoC96J4KjXiRolN15OumoIBhqV0tJbl6Q==
X-Received: by 10.98.14.199 with SMTP id 68mr9355662pfo.35.1454576662967;
        Thu, 04 Feb 2016 01:04:22 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id p8sm15384154pfi.34.2016.02.04.01.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:35 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285416>

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
2.7.0.377.g4cd97dd
