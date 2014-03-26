From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 02/17] ls_colors.c: parse color.ls.* from config file
Date: Wed, 26 Mar 2014 20:48:02 +0700
Message-ID: <1395841697-11742-3-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:47:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoBQ-0007iQ-CP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbaCZNrw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:47:52 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64334 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbaCZNrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:47:51 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so1905996pdb.0
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3p3/9Fa2CxpHkoAkzNJCYIr6DOHRg6D8hU31anv3ZGQ=;
        b=eMquHl03l0mQ7c7RFD0FenOMDIOWcCMimltwaE6zJ0dcv6QCL9dXXchmKwHsomusr1
         GIgGoRl3iBZIl09lZVsglOGeDbJwumIpg0pxv6TlB+njV+5DdAZ/Gmfydlm9XTiY6kba
         u15ZE7is3AsSAvDxJGNmO+Tv9vIoEsLZI9za/qttHVMvwqeTQyjFJaTPq73ApBYOICNK
         RijCS7F+VjzHXJpDFduiHXtnizReJNbwZnLQcMOY1AaAtx5eaTmO4ppvQuk9QB8FRSRk
         Cs3i8wHeA+0scFBoTYcOjqAswn/+9jR820LKuEunoXo5kwvPorzbQEPnXVzGfNk1eR+N
         sehQ==
X-Received: by 10.66.26.15 with SMTP id h15mr85115412pag.24.1395841670945;
        Wed, 26 Mar 2014 06:47:50 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id ge7sm58527801pbc.61.2014.03.26.06.47.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:47:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:48:44 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245181>

This is the second (and preferred) source for color information. This
will override $LS_COLORS.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt | 11 +++++++++++
 ls_colors.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 73c8973..3fb754e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -909,6 +909,17 @@ color.status.<slot>::
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
index eb944f4..cef5a92 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -68,6 +68,14 @@ static const char *const indicator_name[] =3D {
 	NULL
 };
=20
+static const char* const config_name[] =3D {
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
+	color_parse(value, var, ls_colors[slot]);
+	return 0;
+}
+
 void parse_ls_color(void)
 {
 	const char *p;			/* Pointer to character being parsed */
@@ -395,4 +420,5 @@ void parse_ls_color(void)
=20
 	if (!strcmp(ls_colors[LS_LN], "target"))
 		color_symlink_as_referent =3D 1;
+	git_config(ls_colors_config, NULL);
 }
--=20
1.9.1.345.ga1a145c
