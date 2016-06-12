From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 20/27] refs: add expand_ref()
Date: Sun, 12 Jun 2016 17:54:02 +0700
Message-ID: <20160612105409.22156-21-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 12 12:56:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC349-0003xo-Pw
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcFLK40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:56:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34545 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLK4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:56:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id 66so6638088pfy.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8BJz/OVuYuaDN2/LD+gykERaRaiH3rMqFJj+A+WzhE=;
        b=Vz5fII0To2TBUPgkayyMexliGqI1HG4jcxr8ZKO5VkrS8cNma9hZi5QB1sNR6Xcp47
         eMqiYkv9vxp9pnCu9pfvlG8r/gSMo80MOfgmOe0dAPXo2/umWQajQfZGFcYTHceSWUvB
         yctJfSnIPy1q3ldXvS/wEvT9spf6dNmGyQu82+LkkpO6q639RFIMC5SCvejDuCqmxGSw
         D6QnLTlNi1iOdLK0IH4CJ7CU5hQoQgImjQ8ZBJ3yrmzTI2PTWQ03Y6vddURECo+flsYg
         54sbnj9XgwfdMEi645nZBgxgwKUPcvy1WkoNMHjNIwQaqrgFcNBfTjahY+hfYNVzosT5
         /toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8BJz/OVuYuaDN2/LD+gykERaRaiH3rMqFJj+A+WzhE=;
        b=Ry1rimODp2sWIi9dCRVI18oEl5GRYe6Zrnx+WAHjN2y/d3Ta2qnzeX/Z50nudhWCOJ
         kKFNnjXRvSV55bt/xCoQ11be5SpgH1fW1t86rQh0bL0/5NYmzeHfCnyhtsgv6jUdqcST
         5Q7OR/wqpMVK6kAejN/okk89z/b81O09b68vMi90N7v+souoAPXTFZG5ZY3KeoIW6K6U
         y3ybDhsR0bYlMLusJ9w8tVevJN9cS0WNuh91q/LvKKyKdFyEsG3EsStNJnV8mFOPB6hP
         RDUVSqCy4a7n1N1eHo8eUmRtEQMBQ6TvDRAL/FXbg1psgGcMRQNUxQgKSmtFkbgRElji
         xlZw==
X-Gm-Message-State: ALyK8tJE5e9NDK+ouIVhzdcM1ybVAEyOj8dBvpJx7rZrP5j4QY46GEH/qUEx4wBLXLDTVg==
X-Received: by 10.98.12.143 with SMTP id 15mr14963406pfm.12.1465728984220;
        Sun, 12 Jun 2016 03:56:24 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id c2sm2564345paw.45.2016.06.12.03.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:56:23 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:56:19 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297126>

This is basically dwim_ref() without @{} support. To be used on the
server side where we want to expand abbreviated to full ref names and
nothing else. The first user is "git clone/fetch --shallow-exclude".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 8 +++++++-
 refs.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e2d34b2..842e4d8 100644
--- a/refs.c
+++ b/refs.c
@@ -392,6 +392,13 @@ static char *substitute_branch_name(const char **s=
tring, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref=
)
 {
 	char *last_branch =3D substitute_branch_name(&str, &len);
+	int   refs_found  =3D expand_ref(str, len, sha1, ref);
+	free(last_branch);
+	return refs_found;
+}
+
+int expand_ref(const char *str, int len, unsigned char *sha1, char **r=
ef)
+{
 	const char **p, *r;
 	int refs_found =3D 0;
=20
@@ -417,7 +424,6 @@ int dwim_ref(const char *str, int len, unsigned cha=
r *sha1, char **ref)
 			warning("ignoring broken ref %s.", fullref);
 		}
 	}
-	free(last_branch);
 	return refs_found;
 }
=20
diff --git a/refs.h b/refs.h
index 3c3da29..31a2fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -90,6 +90,7 @@ extern int resolve_gitlink_ref(const char *path, cons=
t char *refname, unsigned c
  */
 extern int refname_match(const char *abbrev_name, const char *full_nam=
e);
=20
+extern int expand_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
=20
--=20
2.8.2.524.g6ff3d78
