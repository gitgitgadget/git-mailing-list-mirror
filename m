From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/25] ls_colors.c: highlight submodules like directories
Date: Mon,  6 Apr 2015 20:52:13 +0700
Message-ID: <1428328354-14897-5-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:53:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Sc-0004sn-OL
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbbDFNxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:53:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34094 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbDFNxC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:53:02 -0400
Received: by pacyx8 with SMTP id yx8so44794778pac.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=secSjEnwJU0CDDpcjcAfRv769k6OS0MoxdiErdrZiMM=;
        b=Eqq/zE7sqYZYKwBfpGvS1O78BM6SZ9yuBox/b43EdFxYwYcJ3SV1DD/QDh2328jsxd
         YzWv1+wvRQRj+fmE62aCToSKXKQnYyanLnXIxxL/FmD2De7YW7pdI1qAZdJVYh7JK+vm
         JyM7OvbkC8VzcvfamecipqZsbOz1D9OtS4zIdt2BXRWV33kT0dvcYCu33nKs9zwqnL8f
         lqj1NuE6ausQJovw+G0JP4CzyJbNSH7bup3ebyOJFAUJMM1hm7T3VSGDagVTAc2ze1Vr
         iBrbe90raWpICAFcNvrJ9TZmr6TgkIXZnMTBvi6n1qPsRnUsxtNLyIbED/o89BWOHOsL
         3iFA==
X-Received: by 10.68.251.227 with SMTP id zn3mr23852307pbc.157.1428328381634;
        Mon, 06 Apr 2015 06:53:01 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id sl9sm4838410pac.41.2015.04.06.06.52.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:53:12 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266849>

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
