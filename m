From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/21] ls_colors.c: parse color.ls.* from config file
Date: Sun, 25 Jan 2015 19:37:37 +0700
Message-ID: <1422189476-7518-3-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:27:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMHU-0001Ve-1y
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbbAYM1D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:27:03 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:64528 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbAYM1C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:27:02 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so6822601pdj.9
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vWM7tlX5ChLfqWNMMxFY+dttNpEvNutoPHEp7KJgHVk=;
        b=jRCwFQoTRsK12OTB7sYAn/z149aZx7JAJgPLhcUrNOUKvcf3tT8mNxJNGrvRPYrmFq
         twjyO4SrYIYbM/Dmrnp3snK2JzAxyv00K6k05z+10A176p5NLSOIOd4CeP4pVSZNVUS8
         g5Wtud+ntqcU7mVRmxVZ45itiIdbR8vxGnB3/QyNQ5XHQygh1v8MO0bcuhgnzIw4k0Wm
         fKTBtjaOIZQ7AO4UgdHHAAdRmySS+hETB2eDfUgeLoc9EphmfKvsdMzBvSG0nMydq+v9
         tM4uGbF4iumQ0oD1p2ZSDCSUecqkr7kL+vmYn5BzU+qmkKz8ov973OcZT25cCoyo6dO+
         KAaQ==
X-Received: by 10.66.163.137 with SMTP id yi9mr26000050pab.58.1422188821380;
        Sun, 25 Jan 2015 04:27:01 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id ir9sm7143121pbc.3.2015.01.25.04.26.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:27:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:38:26 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262999>

This is the second (and preferred) source for color information. This
will override $LS_COLORS.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 11 +++++++++++
 ls_colors.c              | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index e743315..08e7068 100644
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
@@ -395,4 +420,5 @@ void parse_ls_color(void)
=20
 	if (!strcmp(ls_colors[LS_LN], "target"))
 		color_symlink_as_referent =3D 1;
+	git_config(ls_colors_config, NULL);
 }
--=20
2.2.0.84.ge9c7a8a
