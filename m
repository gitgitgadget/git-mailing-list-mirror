From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/21] ls-files: add --color to highlight file names
Date: Sun,  8 Feb 2015 16:01:24 +0700
Message-ID: <1423386099-19994-7-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:02:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNla-0005tO-CE
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbbBHJCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:02:54 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:50801 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941AbbBHJCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:02:52 -0500
Received: by mail-pa0-f54.google.com with SMTP id kx10so11830913pab.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7X1bGZ4gW1xdG3IxP8f323SUXxux27MxqAOkeg/raZk=;
        b=jwMbLT1Ljp/iF5m1kpDW5kL+R0qrK27826NJmfcDin/m47Y5gDcRgblp6CuJAr6Pnk
         v3EMnBr58hw0Uep1ZOa/HI2cupeQm8ixhdS46Jrje3x3ii+DGvDeEI6PqgH8XsZGkwxH
         58qqW+cSFYBK/v4+nSFclN77ujUIsRMN8tSdYH8V2CbIWBDY1ct7Hyr3HoYMI3iBkjiu
         9+rsCy6VCYTgI8QqrASINMPaVvkyeWX7LIGsohdpnCME4DYeb8+0KfFXc+WsAooz/YYq
         u8r4rPyGwU3VdiQovfl+SchR19dn2z90jwmMA2iNMgvsgPZQi81lFjjqdO4PFmezI7fA
         GLyQ==
X-Received: by 10.70.132.39 with SMTP id or7mr19352705pdb.90.1423386172097;
        Sun, 08 Feb 2015 01:02:52 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id fu14sm13051275pad.44.2015.02.08.01.02.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:02:51 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:02:59 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263493>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt |  7 +++++++
 builtin/ls-files.c             | 38 ++++++++++++++++++++++++++++++++++=
+---
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index e26f01f..148f226 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -147,6 +147,13 @@ a space) at the start of each line:
 	possible for manual inspection; the exact format may change at
 	any time.
=20
+--color[=3D<when>]::
+--no-color::
+	Color file names. The value must be `always`, `never`, or
+	`auto`. `--no-color` is equivalent to
+	`--color=3Dnever`. `--color` is equivalent to
+	`--color=3Dauto`.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6f0d9f..0ee4f19 100644
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
 			    find_unique_abbrev(ce->sha1, abbrev),
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
2.3.0.rc1.137.g477eb31
