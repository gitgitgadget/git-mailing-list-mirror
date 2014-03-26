From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/17] ls_colors.c: highlight submodules like directories
Date: Wed, 26 Mar 2014 20:48:04 +0700
Message-ID: <1395841697-11742-5-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoBf-0007zk-KA
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbaCZNsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:05 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59258 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbaCZNsD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:03 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so1953517pab.18
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8pDxKGQDT9XwLPlt4OijhJkIp7OLT0imqyLkf6FFLws=;
        b=mU5MTu/B8s64BGfwyTiLxq/P/AGz4ZrpMPeubuC7rQb0/FUGiLy9sAwG8afzfOTkH0
         iycivVV66UdMkaRYspX0yQeD/eBsraWQEnnbsWsjXqGjpEGCHzI5qiBjU0iOsVyHLLjI
         Cst9WK/Qu4ElziMt48TOKUCraiM2A3cH+AhWnCEZxvI5merwTCz9rPQeAV2oS8aCtKxe
         hBsX1FpK0AsJMCmMjHtUx00UOquUjsaJznDlYN1Pt/aA66zDR5QwQ7cYgnkm8d+RSb66
         Qlk6dcs/sbRJOBVVmXXdlKAf/98VIx9J4310Qzo5bqzZF+Ps6evluQjYLhN22A2Bq/lZ
         e/Vw==
X-Received: by 10.66.121.164 with SMTP id ll4mr4785866pab.129.1395841683045;
        Wed, 26 Mar 2014 06:48:03 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id x1sm52247372pbk.47.2014.03.26.06.48.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:48:56 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245183>

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
