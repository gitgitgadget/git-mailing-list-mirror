From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/19] ls-files: add --column
Date: Sun, 30 Nov 2014 15:55:55 +0700
Message-ID: <1417337767-4505-8-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:57:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0Ju-0002tj-0d
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbaK3I5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:57:17 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40572 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaK3I5O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:57:14 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so9175677pab.30
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=n1Kskt46Wb2Laex/V4lBJJkdtlCz/yQyf7STEiFJ0UY=;
        b=mHxkVlh7ac5JmvhpgkK7cds+wzf7oezt60DMuTrkrze4FiA7EYPWm+I4byBoFnQPF5
         lKY6y6nXj3FfDEh522emC+TFoUflOvgxnXK45S/yXHrsznt7cGTqQQTJ2p/eqpzkDtAk
         zqODae7mdo0vUkCMzdvB+zsVnIA1nZAAbmqBbxJHwZqx8Dk/he4Pr0oF25/o4T/IFZZa
         pTNk7D3cOOcTY5wm4L/MYCG21i9A/t964kGlbaEllAQJVZpAOd2XytG1aSLWM8tSA/Aa
         p9RmyCjMBNBFnyOahVtIRXkSAmxHzk+1Sl+i+a+7hymDed8JehW2l5UQkrv6zGI+KNfP
         Df6Q==
X-Received: by 10.70.44.174 with SMTP id f14mr90205744pdm.38.1417337834519;
        Sun, 30 Nov 2014 00:57:14 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id qh4sm14324418pbb.35.2014.11.30.00.57.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:57:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:57:13 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260430>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 148f226..99328b9 100644
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
index 4ddd49f..79e1944 100644
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
2.2.0.60.gb7b3c64
