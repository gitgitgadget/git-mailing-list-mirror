From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 01/45] setup.c: check that the pathspec magic ends with ")"
Date: Fri, 15 Mar 2013 13:06:16 +0700
Message-ID: <1363327620-29017-2-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO4B-0003Ql-8h
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab3COGYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:24:07 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46987 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab3COGYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:24:06 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so3996845ieb.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VWh3Y/enP7J0wtdBUn7GqmySvBiB8fS7cJpDFp85hjk=;
        b=hMmaWexTfoPeu/KGyzCbv5mmYDoj2+4XK8GF9K4nduxQu+C7yuG7r5Q9wO7U8cn9wr
         S3aPEE+D1D2QiUxYBxLGad/G0PoAlSNVBjouX3XuVaE9sPE2d8BVS/YuY0f2TQG/2E9z
         iT0XXrm/CvW0cebM84PV7XjnIuFomgKOS8xLPSXhmTGFWVU0fBqKuyxWTsaL2SX5doHf
         poa85isxzoA4TTJpMIVUTr/8RqbtnvR2t5iCUEL5NdVfK+KluBJoST6vUqhaDaU37s84
         OmPLZTWcJQjsG50Y3NylZSgjWRf5+A47H4VM2tGVpm9RKlqHD2RgsHjWJMYKgSE43t6j
         KE8w==
X-Received: by 10.42.54.5 with SMTP id p5mr3871674icg.49.1363328645809;
        Thu, 14 Mar 2013 23:24:05 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id g6sm620669ign.4.2013.03.14.23.24.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:24:04 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:07:07 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218188>

=46rom: Andrew Wong <andrew.kw.w@gmail.com>

The previous code did not diagnose an incorrectly spelled ":(top"
as an error.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 1dee47e..d0cd784 100644
--- a/setup.c
+++ b/setup.c
@@ -223,8 +223,9 @@ static const char *prefix_pathspec(const char *pref=
ix, int prefixlen, const char
 				die("Invalid pathspec magic '%.*s' in '%s'",
 				    (int) len, copyfrom, elt);
 		}
-		if (*copyfrom =3D=3D ')')
-			copyfrom++;
+		if (*copyfrom !=3D ')')
+			die("Missing ')' at the end of pathspec magic in '%s'", elt);
+		copyfrom++;
 	} else {
 		/* shorthand */
 		for (copyfrom =3D elt + 1;
--=20
1.8.0.rc0.19.g7bbb31d
