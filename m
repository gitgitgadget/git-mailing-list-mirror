From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/21] ls_colors.c: highlight submodules like directories
Date: Sun, 25 Jan 2015 19:37:39 +0700
Message-ID: <1422189476-7518-5-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:27:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMHg-0001kN-Ug
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbbAYM1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:27:17 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57800 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbAYM1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:27:15 -0500
Received: by mail-pd0-f175.google.com with SMTP id fl12so6842222pdb.6
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EpfHECV8dofkcaTgj5bDEfJ9quLI7vUXx6uxQt/CZEs=;
        b=XilsTnDDPhHkzklNtQcsDFx2sAylnkimPfUBbcgP+Qn0pD+jh+GbCWQKxOKDfHzfD/
         vSwdkGeErokh2K74DsJKfeUOwEmCxcwmqjuyEOFFL6wqGrD/kUSrxhReprlKLOH21nd6
         4eoaKO6vBdkAvv52SbHDEMntJDFbhg+05uC/ICZ8AW9LKQVW5AWKv7qASt5Ak+wHCcNv
         YqX41s+1uK2wKFvCsRYdXWHsDPgOxL1Oh6UW2VbsOWajxJea/a2g0g9lTs7Xq/acV0ho
         zQgV3I2AF16JnQCW63wBe59hTBA11QWzdxYRuHrMIVvRqLGkHHzJKSS09L22oSUIM/co
         fT+g==
X-Received: by 10.68.132.229 with SMTP id ox5mr26635616pbb.94.1422188835155;
        Sun, 25 Jan 2015 04:27:15 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id wk2sm7231840pac.12.2015.01.25.04.27.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:27:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:38:40 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263001>

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
index 7d2e2e0..9259ad3 100644
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
@@ -448,6 +452,8 @@ void color_filename(struct strbuf *sb, const char *=
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
2.2.0.84.ge9c7a8a
