From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/21] ls_colors.c: parse color.ls.* from config file
Date: Sun,  8 Feb 2015 16:01:20 +0700
Message-ID: <1423386099-19994-3-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNlD-0005jo-7n
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbbBHJCb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:02:31 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:40270 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbBHJCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:02:30 -0500
Received: by pdev10 with SMTP id v10so6989879pde.7
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sBaf657aDGsG+hMBD4zRkPluXGLz18CmTsfdKF43o74=;
        b=ld6qVNuaeGg7wmDOc+FvkVt0qW6fejR0sfv2kOP7xck59Bpw1OZI5eiUZUHSXfZVAa
         uVJhvvSFWq7jnnuOYTKyvC7QCexkIR9MBxp+LLS+dKl1427PdvxpnZWHapjWl/c3dQ8f
         YNhuvavX+8fFHhrA8SgwXeYjWxzAhypDol5ohOnbu13hFbu3W1DouDEloIiV8XLdsCoJ
         dEwBRaQIJcu5algPSK0pPrz5ADXzAti6ZzWeH7WYuOlOO3vlRyowZFFdWYYCCaIwvg3i
         lyc970rwHePbriOKR56Y+gRDgqnoxUMtVV1uySNM2a7JruDSdTMPtNY6EKx9Mo6bphFL
         OeAg==
X-Received: by 10.70.48.33 with SMTP id i1mr19144710pdn.153.1423386149839;
        Sun, 08 Feb 2015 01:02:29 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id rf12sm3993149pdb.29.2015.02.08.01.02.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:02:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:02:37 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263488>

This is the second (and preferred) source for color information. This
will override $LS_COLORS.

Helped-by: Michael Blume <blume.mike@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 11 +++++++++++
 ls_colors.c              | 30 +++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..2090866 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -940,6 +940,17 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
=20
+color.ls.<slot>::
+	Use customized color for file name colorization. If not set
+	and the environment variable LS_COLORS is set, color settings
+	from $LS_COLORS are used. `<slot>` can be `normal`, `file`,
+	`directory`, `symlink`, `fifo`, `socket`, `block`, `char`,
+	`missing`, `orphan`, `executable`, `door`, `setuid`, `setgid`,
+	`sticky`, `otherwritable`, `stickyotherwritable`, `cap`,
+	`multihardlink`. The values of these variables may be
+	specified as in color.branch.<slot>.
+
+
 color.ui::
 	This variable determines the default value for variables such
 	as `color.diff` and `color.grep` that control the use of color
diff --git a/ls_colors.c b/ls_colors.c
index e743315..2dc2d39 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -68,6 +68,14 @@ static const char *const indicator_name[] =3D {
 	NULL
 };
=20
+static const char * const config_name[] =3D {
+	"", "", "", "", "normal", "file", "directory", "symlink",
+	"fifo", "socket", "block", "char", "missing", "orphan", "executable",
+	"door", "setuid", "setgid", "sticky", "otherwritable",
+	"stickyotherwritable", "cap", "multihardlink", "",
+	NULL
+};
+
 struct bin_str {
 	size_t len;			/* Number of bytes */
 	const char *string;		/* Pointer to the same */
@@ -285,6 +293,23 @@ static int get_funky_string(char **dest, const cha=
r **src, int equals_end,
 	return state !=3D ST_ERROR;
 }
=20
+static int ls_colors_config(const char *var, const char *value, void *=
cb)
+{
+	int slot;
+	if (!starts_with(var, "color.ls."))
+		return 0;
+	var +=3D 9;
+	for (slot =3D 0; config_name[slot]; slot++)
+		if (!strcasecmp(var, config_name[slot]))
+			break;
+	if (!config_name[slot])
+		return 0;
+	if (!value)
+		return config_error_nonbool(var);
+	color_parse(value, ls_colors[slot]);
+	return 0;
+}
+
 void parse_ls_color(void)
 {
 	const char *p;			/* Pointer to character being parsed */
@@ -297,8 +322,10 @@ void parse_ls_color(void)
 	char *start;
 	size_t len;
=20
-	if ((p =3D getenv("LS_COLORS")) =3D=3D NULL || *p =3D=3D '\0')
+	if ((p =3D getenv("LS_COLORS")) =3D=3D NULL || *p =3D=3D '\0') {
+		git_config(ls_colors_config, NULL);
 		return;
+	}
=20
 	ext =3D NULL;
 	strcpy(label, "??");
@@ -395,4 +422,5 @@ void parse_ls_color(void)
=20
 	if (!strcmp(ls_colors[LS_LN], "target"))
 		color_symlink_as_referent =3D 1;
+	git_config(ls_colors_config, NULL);
 }
--=20
2.3.0.rc1.137.g477eb31
