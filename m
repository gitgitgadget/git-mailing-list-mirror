From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/21] ls_colors.c: highlight submodules like directories
Date: Sun,  8 Feb 2015 16:01:22 +0700
Message-ID: <1423386099-19994-5-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:02:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNlQ-0005pi-Ib
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbbBHJCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:02:43 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37429 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbbBHJCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:02:41 -0500
Received: by pdbfp1 with SMTP id fp1so24369363pdb.4
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=secSjEnwJU0CDDpcjcAfRv769k6OS0MoxdiErdrZiMM=;
        b=yjtYFF5eVZB1TyEmZwuNmLUwmz1NBxp2RpYwUeaVuOg+fGWeb6Npabsq9UQvvQAdrW
         9j/SwkfU11m8GCNyznaCLke/rUeya4tUpLFpR9ZR4zJlg1yG3ctY1zmkwvd832mHgdlr
         ZnvBCtpCeR0CR63BOLz356uad8iKz8209aC9BFCGpmpN/HuGzhozxEGGA7PkVL7/in+Z
         xFfKRiSZBgXKEj7lpKuml9N+S1lwSRi/xsL9bnbZXflD6nljDSQbXQ6mpHhfAE8b1Rw+
         3osND0OTECpcqhvWfF5KLRrwLfHPVixFDEoLSSkvqbS1Hf5axws18k54A/YYuKAcDLpv
         GwRA==
X-Received: by 10.70.88.39 with SMTP id bd7mr19127839pdb.83.1423386161099;
        Sun, 08 Feb 2015 01:02:41 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ul5sm13048843pab.36.2015.02.08.01.02.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:02:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:02:48 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263491>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 3 ++-
 ls_colors.c              | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2090866..2290c47 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -944,7 +944,8 @@ color.ls.<slot>::
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
index f84ef0f..011a8b9 100644
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
@@ -73,6 +76,7 @@ static const char * const config_name[] =3D {
 	"fifo", "socket", "block", "char", "missing", "orphan", "executable",
 	"door", "setuid", "setgid", "sticky", "otherwritable",
 	"stickyotherwritable", "cap", "multihardlink", "",
+	"submodule",
 	NULL
 };
=20
@@ -450,6 +454,8 @@ void color_filename(struct strbuf *sb, const char *=
name,
 			type =3D LS_DI;
 	} else if (S_ISLNK(mode))
 		type =3D (!linkok && *ls_colors[LS_OR]) ? LS_OR : LS_LN;
+	else if (S_ISGITLINK(mode))
+		type =3D LS_SUBMODULE;
 	else if (S_ISFIFO(mode))
 		type =3D LS_PI;
 	else if (S_ISSOCK(mode))
--=20
2.3.0.rc1.137.g477eb31
