From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/17] ls-files: add --color to highlight file names
Date: Wed, 26 Mar 2014 20:48:06 +0700
Message-ID: <1395841697-11742-7-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoBv-0008FB-0G
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbaCZNsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:23 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:41899 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaCZNsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:22 -0400
Received: by mail-pa0-f42.google.com with SMTP id fb1so1962563pad.29
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3WGWmS3u/BRkggJ3q7jcDSLLuRJtlq5mTKk4vqcZLng=;
        b=E1SKBwYNGxoj/DzuLI5Ca3tqiCOydUfbZTseaix8iQ1AtQ9Hzr1gfwpAYm9SoTqmCh
         m5CDfSLons0jQ2Jf2m7HIGfyusYxBH/cdJ64w3I3RzF4VuvPa8iYbAdjJJn6XUjxYDU8
         zuEWVxhrLULgaK8Ud3CzuGnK4onWrrwlJB7+tCspWmRVMY2NAXHhYpBzyY2f1ITgVjfF
         FRtWvAnQNETJYq+UxFBJMUbc7VfPT3t2crliJy6Q9SLvPL9yzkw6EkX7Rhb0nGbMVEh+
         X7jJDSxVQq8tIRLPUdf2H/0sqXI+763tte/UmQ2DFKPpUW/rmsEZEK24woYRFzOkk6iW
         LmWQ==
X-Received: by 10.68.11.199 with SMTP id s7mr87695689pbb.12.1395841701352;
        Wed, 26 Mar 2014 06:48:21 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id hc4sm58535757pbc.29.2014.03.26.06.48.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:08 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245185>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |  9 +++++++++
 builtin/ls-files.c             | 38 ++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index c0856a6..5c1b7f3 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -147,6 +147,15 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
=20
+--color[=3D<when>]::
+	Color file names. The value must be always (default), never,
+	or auto.
+
+--no-color::
+	Turn off coloring, even when the configuration file gives the
+	default to color output, same as `--color=3Dnever`. This is the
+	default.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6e30592..2857b38 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "string-list.h"
 #include "pathspec.h"
+#include "color.h"
=20
 static int abbrev;
 static int show_deleted;
@@ -27,6 +28,7 @@ static int show_killed;
 static int show_valid_bit;
 static int line_terminator =3D '\n';
 static int debug_mode;
+static int use_color;
=20
 static const char *prefix;
 static int max_prefix_len;
@@ -60,7 +62,6 @@ static void write_name(struct strbuf *sb, const char =
*name)
 		strbuf_release(&sb2);
 	} else
 		quote_path_relative(name, real_prefix, sb);
-	strbuf_addch(sb, line_terminator);
 }
=20
 static void strbuf_fputs(struct strbuf *sb, FILE *fp)
@@ -68,6 +69,21 @@ static void strbuf_fputs(struct strbuf *sb, FILE *fp=
)
 	fwrite(sb->buf, sb->len, 1, fp);
 }
=20
+static void write_dir_entry(struct strbuf *sb, const struct dir_entry =
*ent)
+{
+	struct strbuf quoted =3D STRBUF_INIT;
+	struct stat st;
+	if (stat(ent->name, &st))
+		st.st_mode =3D 0;
+	write_name(&quoted, ent->name);
+	if (want_color(use_color))
+		color_filename(sb, ent->name, quoted.buf, st.st_mode, 1);
+	else
+		strbuf_addbuf(sb, &quoted);
+	strbuf_addch(sb, line_terminator);
+	strbuf_release(&quoted);
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
@@ -81,7 +97,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
=20
 	strbuf_reset(&sb);
 	strbuf_addstr(&sb, tag);
-	write_name(&sb, ent->name);
+	write_dir_entry(&sb, ent);
 	strbuf_fputs(&sb, stdout);
 }
=20
@@ -146,6 +162,18 @@ static void show_killed_files(struct dir_struct *d=
ir)
 	}
 }
=20
+static void write_ce_name(struct strbuf *sb, const struct cache_entry =
*ce)
+{
+	struct strbuf quoted =3D STRBUF_INIT;
+	write_name(&quoted, ce->name);
+	if (want_color(use_color))
+		color_filename(sb, ce->name, quoted.buf, ce->ce_mode, 1);
+	else
+		strbuf_addbuf(sb, &quoted);
+	strbuf_addch(sb, line_terminator);
+	strbuf_release(&quoted);
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *c=
e)
 {
 	static struct strbuf sb =3D STRBUF_INIT;
@@ -186,7 +214,7 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 			    find_unique_abbrev(ce->sha1,abbrev),
 			    ce_stage(ce));
 	}
-	write_name(&sb, ce->name);
+	write_ce_name(&sb, ce);
 	strbuf_fputs(&sb, stdout);
 	if (debug_mode) {
 		const struct stat_data *sd =3D &ce->ce_stat_data;
@@ -523,6 +551,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
 			N_("pretend that paths removed since <tree-ish> are still present")=
),
+		OPT__COLOR(&use_color, N_("show color")),
 		OPT__ABBREV(&abbrev),
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
@@ -570,6 +599,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
+	if (want_color(use_color))
+		parse_ls_color();
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
--=20
1.9.1.345.ga1a145c
