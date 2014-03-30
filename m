From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 07/18] ls-files: add --column
Date: Sun, 30 Mar 2014 20:55:58 +0700
Message-ID: <1396187769-30863-8-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:56:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGDv-00032C-QY
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaC3N40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:56:26 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:57548 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807AbaC3N4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:56:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so6841370pdi.16
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UTumNiQrVd2O7zzz3GaE808jDRK8gXLjq/qAES261+0=;
        b=JNb9ewaWcHSC+jg74rWGRcZpMNDAQ3tiNN1R3iIKUch29dUFhGuZ9Bs90BlIPZtugr
         Hi2193g3ejKREH0AP03VfCUbcNbTADhBWDzpnk8t9izUIAZwjcIHZ62z/nKrjgh77gcl
         advGlrganPfNo6Ii7lHfX0s9Ga4Zb8GsLO6/egta1ovGlBLnqxi3Yi2MJPDj0fg49tI0
         R1SMVivvyWpbGQ4Xd8hsmJRCgGLqJ6KFkfXCBdakp0BquR3DZOykyG4U/o0mudZWAw+c
         ZWOstrhQDLqAHzHG6VZt0lwqT61UYg/r6FEttUldND9oWbhi9nabkwg6Md/VeZymY6yu
         t6VQ==
X-Received: by 10.66.142.132 with SMTP id rw4mr19640027pab.6.1396187782286;
        Sun, 30 Mar 2014 06:56:22 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id pp5sm37325315pbb.33.2014.03.30.06.56.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:56:21 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:57:19 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245470>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index f006fc1..a5a30c2 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -154,6 +154,12 @@ a space) at the start of each line:
 	`--color=3Dnever`. `--color` is equivalent to
 	`--color=3Dauto`.
=20
+--column[=3D<options>]::
+--no-column::
+	Display files in columns. See configuration variable column.ui
+	for option syntax. `--column` and `--no-column` without options
+	are equivalent to 'always' and 'never' respectively.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2857b38..a481c37 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "pathspec.h"
 #include "color.h"
+#include "column.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -29,6 +30,7 @@ static int show_valid_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
 static int use_color;
+static unsigned int colopts;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -39,6 +41,7 @@ static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
 static int exclude_args;
+static struct string_list output =3D STRING_LIST_INIT_NODUP;
=20
 static const char *tag_cached =3D "";
 static const char *tag_unmerged =3D "";
@@ -66,6 +69,10 @@ static void write_name(struct strbuf *sb, const char=
 *name)
=20
 static void strbuf_fputs(struct strbuf *sb, FILE *fp)
 {
+	if (column_active(colopts)) {
+		string_list_append(&output, strbuf_detach(sb, NULL));
+		return;
+	}
 	fwrite(sb->buf, sb->len, 1, fp);
 }
=20
@@ -552,6 +559,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
 			N_("pretend that paths removed since <tree-ish> are still present")=
),
 		OPT__COLOR(&use_color, N_("show color")),
+		OPT_COLUMN(0, "column", &colopts, N_("show files in columns")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -596,6 +604,18 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	if (dir.exclude_per_dir)
 		exc_given =3D 1;
=20
+	finalize_colopts(&colopts, -1);
+	if (explicitly_enable_column(colopts)) {
+		if (!line_terminator)
+			die(_("--column and -z are incompatible"));
+		if (show_resolve_undo)
+			die(_("--column and --resolve-undo are incompatible"));
+		if (debug_mode)
+			die(_("--column and --debug are incompatible"));
+	}
+	if (column_active(colopts))
+		line_terminator =3D 0;
+
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
@@ -638,6 +658,14 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	if (show_resolve_undo)
 		show_ru_info();
=20
+	if (column_active(colopts)) {
+		struct column_options copts;
+		memset(&copts, 0, sizeof(copts));
+		copts.padding =3D 2;
+		print_columns(&output, colopts, &copts);
+		string_list_clear(&output, 0);
+	}
+
 	if (ps_matched) {
 		int bad;
 		bad =3D report_path_error(ps_matched, &pathspec, prefix);
--=20
1.9.1.345.ga1a145c
