From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/17] ls-files: add --column
Date: Wed, 26 Mar 2014 20:48:07 +0700
Message-ID: <1395841697-11742-8-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoC2-0008Oh-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbaCZNsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:31 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36169 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCZNsa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:30 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so1947878pab.24
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JeWglNEy91UfxBJDp9bmBxfSanDwN3pj2kRW/NEaOCc=;
        b=e5IUrg4lf6NlQrC+5U12lnmAsz1f6XFDQDKuQkvXGdXeageRk4ZKCRU8tNrjN6kbXw
         7WZUTT4yr3kMAhSXYKxmaCCpoek89wbgGDkDrnHL0S3/1+geuVOs/2Cq906/eSADoOzF
         Ibfe3zGCFr6N5vDvlVQgNmIJS8r0YlmGfq9jf0aLuZoLy07TSyQmAdaG9exZNG62H0H0
         NzDrBfd0OwYuDYxZNesLASHU68lKYs7XaKN0R4UjIyoBux5bwFMq2k8gtU8iWYR1mpNK
         Ety6KlEf1+VPQcTvkxsz23SCv1kxk0M9VVyj49XDWHrRD2r1PTd5ooMaYP7IhxhvobPE
         mNyA==
X-Received: by 10.66.232.40 with SMTP id tl8mr4745843pac.137.1395841709816;
        Wed, 26 Mar 2014 06:48:29 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id qq5sm58541629pbb.24.2014.03.26.06.48.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:20 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245186>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |  6 ++++++
 builtin/ls-files.c             | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index 5c1b7f3..cd52461 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -156,6 +156,12 @@ a space) at the start of each line:
 	default to color output, same as `--color=3Dnever`. This is the
 	default.
=20
+--column[=3D<options>]::
+--no-column::
+	Display files in columns. See configuration variable column.ui
+	for option syntax.`--column` and `--no-column` without options
+	are equivalent to 'always' and 'never' respectively.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2857b38..335d3b0 100644
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
@@ -638,6 +658,11 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 	if (show_resolve_undo)
 		show_ru_info();
=20
+	if (column_active(colopts)) {
+		print_columns(&output, colopts, NULL);
+		string_list_clear(&output, 0);
+	}
+
 	if (ps_matched) {
 		int bad;
 		bad =3D report_path_error(ps_matched, &pathspec, prefix);
--=20
1.9.1.345.ga1a145c
