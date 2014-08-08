From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] mv: remove an "if" that's always true
Date: Fri,  8 Aug 2014 20:10:59 +0700
Message-ID: <1407503462-32632-6-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjxL-0000sR-WF
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbaHHNLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:36 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53028 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbaHHNLf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:35 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so7262809pac.4
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TOy9ncx99pC+88Eh5rScXAU1Lbr+MZ9y2qJt2FKiAHk=;
        b=BhoYBhJkWHfKXKQdMYCwkoKeu4N4IlXJ+ZxeiojgZz2uP5MIngMkQ8xGztwol4DXo/
         PAgC2M3cjGoevuHl1MpfUirfVtuzXQBVo0v0LVGF2gbqVSeXJCNT5aWuAFfKNFma53sR
         P60/5zELaIrQLrrDrMrEtVtsoCOf/IU/AGE03Kg5OghytcI848+wrgKIWjaU8k7Nb0x3
         6QqB5dG3pGYbWYWKx79J4yvau2R3pcpsHA73qxHXK030LxgN/p8u3N0Su1dllrTMzDWk
         qwD/b1mZnmJw2eCtLvA068DIZ1lOxtp5qs1BG/FirGOuOYXZIpk23ptcXhqgTF0ZXAzv
         mhwQ==
X-Received: by 10.67.24.73 with SMTP id ig9mr20469263pad.67.1407503494809;
        Fri, 08 Aug 2014 06:11:34 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id tu10sm2995054pbc.43.2014.08.08.06.11.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:35 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255011>

This is inside an "else" block of "if (last - first < 1)", so we know
that "last - first >=3D 1" when we come here. No need to check
"last - first > 0".

While at there, save "argc + last - first" to a variable to shorten
the statements a bit.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index e192f2d..a45226e 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -179,22 +179,14 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 				if (last - first < 1)
 					bad =3D _("source directory is empty");
 				else {
-					int j, dst_len;
+					int j, dst_len, n;
=20
-					if (last - first > 0) {
-						source =3D xrealloc(source,
-								(argc + last - first)
-								* sizeof(char *));
-						destination =3D xrealloc(destination,
-								(argc + last - first)
-								* sizeof(char *));
-						modes =3D xrealloc(modes,
-								(argc + last - first)
-								* sizeof(enum update_mode));
-						submodule_gitfile =3D xrealloc(submodule_gitfile,
-								(argc + last - first)
-								* sizeof(char *));
-					}
+					n =3D argc + last - first;
+					source =3D xrealloc(source, n * sizeof(char *));
+					destination =3D xrealloc(destination, n * sizeof(char *));
+					modes =3D xrealloc(modes, n * sizeof(enum update_mode));
+					submodule_gitfile =3D
+						xrealloc(submodule_gitfile, n * sizeof(char *));
=20
 					dst =3D add_slash(dst);
 					dst_len =3D strlen(dst);
--=20
2.1.0.rc0.78.gc0d8480
