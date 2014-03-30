From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/18] ls_colors.c: highlight submodules like directories
Date: Sun, 30 Mar 2014 20:55:55 +0700
Message-ID: <1396187769-30863-5-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGDk-0002ts-8O
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaC3N4M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:12 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:52901 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaC3N4G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:06 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so7037587pbc.37
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8pDxKGQDT9XwLPlt4OijhJkIp7OLT0imqyLkf6FFLws=;
        b=LjlOO3O7A7dUJYdUfJ3Pkb12MfF1iBVzGws9z8qcqbjakuFnYPe+2ZBgfwU34FLAlW
         Z4WnJTHXUtqcCXDkjYgHm2+BnKdR997nE/wWEPhoDsZkWJ/KQklOgbRA5wO7G6u/4TzE
         V3nhpfCNXgy4sXiob4gkC9kF4nyregLYcZByYmFEN11dZhPIoVUp00S/sCpf4hCBknHV
         AcEOemy6ck5o9yREE4q28hlPzYD9fBXTNlDRJ21zvjNEJKzF1Wvn3S1lD586RorTFAn4
         zw+CUvlY8qtRNU74trM/NiyXPmHWDLzXLpPTGrtY6MpuY6vE+flZcXBIIa85Oiwft2/g
         iQUQ==
X-Received: by 10.66.243.131 with SMTP id wy3mr19600019pac.32.1396187765823;
        Sun, 30 Mar 2014 06:56:05 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id gg3sm37327212pbc.34.2014.03.30.06.56.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:02 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245466>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 3 ++-
 ls_colors.c              | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3fb754e..6bca55e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -913,7 +913,8 @@ color.ls.<slot>::
 	Use customized color for file name colorization. If not set
 	and the environment variable LS_COLORS is set, color settings
 	from $LS_COLORS are used. `<slot>` can be `normal`, `file`,
-	`directory`, `symlink`, `fifo`, `socket`, `block`, `char`,
+	`directory`, `submodule`,
+	`symlink`, `fifo`, `socket`, `block`, `char`,
 	`missing`, `orphan`, `executable`, `door`, `setuid`, `setgid`,
 	`sticky`, `otherwritable`, `stickyotherwritable`, `cap`,
 	`multihardlink`. The values of these variables may be
diff --git a/ls_colors.c b/ls_colors.c
index 1125329..0cc4e9b 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -29,6 +29,8 @@ enum color_ls {
 	LS_MH,			/* multi hardlink */
 	LS_CL,			/* clear end of line */
=20
+	LS_SUBMODULE,
+
 	MAX_LS
 };
=20
@@ -58,7 +60,8 @@ static char ls_colors[MAX_LS][COLOR_MAXLEN] =3D {
 	GIT_COLOR_BLACK_ON_GREEN,
 	"",
 	"",
-	""
+	"",
+	GIT_COLOR_BOLD_BLUE
 };
=20
 static const char *const indicator_name[] =3D {
@@ -73,6 +76,7 @@ static const char* const config_name[] =3D {
 	"fifo", "socket", "block", "char", "missing", "orphan", "executable",
 	"door", "setuid", "setgid", "sticky", "otherwritable",
 	"stickyotherwritable", "cap", "multihardlink", "",
+	"submodule",
 	NULL
 };
=20
@@ -448,6 +452,8 @@ void color_filename(struct strbuf *sb, const char *=
name,
 			type =3D LS_DI;
 	} else if (S_ISLNK (mode))
 		type =3D (!linkok && *ls_colors[LS_OR]) ? LS_OR : LS_LN;
+	else if (S_ISGITLINK(mode))
+		type =3D LS_SUBMODULE;
 	else if (S_ISFIFO (mode))
 		type =3D LS_PI;
 	else if (S_ISSOCK (mode))
--=20
1.9.1.345.ga1a145c
