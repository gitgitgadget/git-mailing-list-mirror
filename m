From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/27] transport-helper.c: refactor set_helper_option()
Date: Fri, 10 Jun 2016 19:26:49 +0700
Message-ID: <20160610122714.3341-3-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:30:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXk-0000OZ-QZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbcFJM2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:04 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35177 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbcFJM2C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:02 -0400
Received: by mail-pa0-f68.google.com with SMTP id gp3so5023424pac.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtsBWLaOJe+Suog9zOZjODbE7eKZaGiMKPEattRsrj8=;
        b=GTVbuiw4TC0n1t0/3QS9EH7eW93HMFgoniBzqVlCjWVrHk0pIs09Fx7M5enK/77+i4
         yz+CyBYpmvELzl+rYUBmU/VY3VP6D19k/H2/KhrJSZa2Yej1GDn53ZcB5yC5oDs1ZiX6
         3y4PuDob0otX4iTmcfGGdahh3hQSqndC5db5Qx2cseKhgNZJv2JumqASueoABvUMRXp7
         w6eFoASsPcL7oQUq2hj6lp7sX8HU2QGINsRz6TUZbP9CHW3CLHATK0kjz5wcJ+yPsJzS
         kgJw+Bo/xejSiYh6H6SVgzYXxKwVAtPcPn3G2pABY2s0L+2IdmgFOOTF/6/lPd0Mcqa6
         eFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtsBWLaOJe+Suog9zOZjODbE7eKZaGiMKPEattRsrj8=;
        b=ahyK9icfjJAMBgFVUg7PW3IFhCY3BdzdoM2m8r4PBDeviecd+iSW+nwwd9oAQhNIUI
         ZPENE3gsU7FSv0QpM65sK6Lq4QWf/HBioV08vB1MtWb8q0adfdDW+eSTXu59AlzWoSUs
         Ch+nqaALVp7KN6ySSNqrhHmFC12HB8CnLZkyclax0M1OrHgr1Cu34N8IUNrWyNTlZyM3
         ENqlb1WpjQKn0u5zkBF3Ny6eqqx4ORyh5F4divgmuO+8NH0j5v8n8IfIUnMd3ILRerCp
         3Rk+3RG/t+6/H1ayy61vNa9zHqOY1o5GXYK6pNZcOoQwXSy0fssMGXSIXXm6gJh4dQMA
         snSQ==
X-Gm-Message-State: ALyK8tLD8dkhS97GzNzV08R4YuC4ZZn4qJZvHOcEDRvQnXaDkCm+zV1IXufR6KtSHpjGMw==
X-Received: by 10.66.47.133 with SMTP id d5mr2163048pan.48.1465561681183;
        Fri, 10 Jun 2016 05:28:01 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id d8sm17471551pfg.72.2016.06.10.05.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:27:56 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296982>

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
