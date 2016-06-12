From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/27] transport-helper.c: refactor set_helper_option()
Date: Sun, 12 Jun 2016 17:53:44 +0700
Message-ID: <20160612105409.22156-3-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC32j-0002wW-29
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbcFLKy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:54:58 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35396 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcFLKy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:54:57 -0400
Received: by mail-pa0-f65.google.com with SMTP id hf6so604624pac.2
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7RDa9Sdw4AMqDrXW+tXT5HD4w2HuYQpUSd588n2/Xk=;
        b=fTCIsgvFZSxdH4I9H2YspsoDtYmyebOEabcwe9C6Q5pYtjTOY9MK/8vPQ23mDBDmMw
         cgJ5FaCWdPWSXaFDEgAaAvGouMuFjCKDlxwhYv9J4DCTy04NCXPLY5AKbbLr1TJd1FR7
         eYa/wDcG7lwmJePy+FcMjJ9/QutIqq2YHc/QPzBvpIZlVObkEbrLz4lOHZIC9oQVeFom
         iGAC+/lm9GdSE2qqnd3NMtiJFnBpU5kqn2fadtOIOwRTgJ1og6kvbOsv5tlBXUGf5nEo
         rhpSY++HZ+goPFiMtF7m9eiS3wX+UXtUgozIZYiFh2uEn4m16rRnWn78Uy0I/hmEnYv+
         jMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7RDa9Sdw4AMqDrXW+tXT5HD4w2HuYQpUSd588n2/Xk=;
        b=aZ64Qqg6pUOlSRcmIw4xEky6TEdQb8N6hP0gpN9efCFi2p3/MDYQs6VWRxkmC4idzY
         ufjzt2Ny3Gqo7lhqIgeAjyZOV1hEerEPvLPZQjOZMfIW9LSGvVE8D5ABNpnzn1FKuTAI
         EU5pNwuTiE/LwjzgeklnfjE9/OqF5uRagj3gmgoq8vRv703N9fWnY+4FkGtNrVMi2RcL
         WRyxkSCNQZcPNUg37efsJRSQssTZlhqr6ZYLPgQJWhO+263U/oXOVoImwGGM/9y4ACo/
         Pjy9KtL+9C4I4gE1HhQ2JlU1DH/Wu3gLdo80Xlz3j/JOtFNfeFmQ0bxZnCJLnTvtRPEV
         E/WQ==
X-Gm-Message-State: ALyK8tK1Nq8IR0lQC8Yl174FwJv+Z5B8vlaJdrn5S2Cu7VqJRFDIXM8YHmlrLt4Nr3EukQ==
X-Received: by 10.66.234.5 with SMTP id ua5mr14668085pac.115.1465728896470;
        Sun, 12 Jun 2016 03:54:56 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id o193sm10044359pfo.12.2016.06.12.03.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:54:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:54:51 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297109>

=46or now we can handle two types, string and boolean, in
set_helper_option(). Later on we'll add string_list support, which does
not fit well. The new function strbuf_set_helper_option() can be reused
for a separate function that handles string-list.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index a6bff8b..27a34e9 100644
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
+	else if (starts_with(buf->buf, "error"))
+		ret =3D -1;
+	else if (!strcmp(buf->buf, "unsupported"))
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
2.8.2.524.g6ff3d78
