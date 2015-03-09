From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/16] list-files: add --color
Date: Mon,  9 Mar 2015 17:18:26 +0700
Message-ID: <1425896314-10941-9-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUumn-00023S-JP
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbbCIKTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:19:43 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42527 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbbCIKTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:19:41 -0400
Received: by pdbfl12 with SMTP id fl12so62749323pdb.9
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EZkTESmmJI9rf6T9HzvZZ2xvxCGJnA5f4VCUEXcBxs8=;
        b=pBcPFVX4PhcfJpeID4xDxNI6mrKiA2iriIeBxm0M8p4i2ePr9awOu+hkJmrpoEYX9k
         V7Gc0aQW3QYuAIbXDOKHaCMk4KQc0vjtCiACGkuYb+xkr+BTzOr1P5Qys//03H4rqTB7
         aeTq975tC0d+hfQZdFyKKk2WKCszncscUQbTbQiz/Mw7Rp6PQ58ABoA+I7kqnKVzBiRq
         Ew7o+2xON70/+yWzMYPuDvTfSL0kbaBNk4cwO49S6XnKrnZ9UqA4BwtTcubPDITun8Dv
         alCARobS1GiefP8Bb6F6xum9q3w+Lh2MkHoYrKV0UEjSyYU6towquFH0+3erldxX2PVi
         5DpQ==
X-Received: by 10.66.218.10 with SMTP id pc10mr52093034pac.116.1425896381263;
        Mon, 09 Mar 2015 03:19:41 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id fu14sm18539402pad.44.2015.03.09.03.19.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:36 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265149>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index dc865a1..316f59c 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -5,6 +5,7 @@
 #include "dir.h"
 #include "quote.h"
 #include "column.h"
+#include "color.h"
=20
 static struct pathspec pathspec;
 static struct pathspec recursive_pathspec;
@@ -13,6 +14,7 @@ static int prefix_length;
 static unsigned int colopts;
 static int max_depth;
 static int show_dirs;
+static int use_color =3D -1;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -28,16 +30,23 @@ struct option ls_options[] =3D {
 	  NULL, 1 },
 	OPT_SET_INT('R', "recursive", &max_depth,
 		    N_("shortcut for --max-depth=3D-1"), -1),
+	OPT__COLOR(&use_color, N_("show color")),
 	OPT_END()
 };
=20
-static void add_one(struct string_list *result, const char *name,
+static void add_one(struct string_list *result, const char *name, int =
mode,
 		    const char *tag)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	struct string_list_item *item;
=20
 	quote_path_relative(name, prefix_length ? prefix : NULL, &sb);
+	if (want_color(use_color)) {
+		struct strbuf quoted =3D STRBUF_INIT;
+		strbuf_swap(&sb, &quoted);
+		color_filename(&sb, name, quoted.buf, mode, 1);
+		strbuf_release(&quoted);
+	}
 	strbuf_insert(&sb, 0, "   ", 3);
 	sb.buf[0] =3D tag[0];
 	sb.buf[1] =3D tag[1];
@@ -56,7 +65,7 @@ static int add_directory(struct string_list *result,
 		strbuf_setlen(&sb, p - sb.buf);
 		if (!match_pathspec(&pathspec, sb.buf, sb.len, 0, NULL, 1))
 			continue;
-		add_one(result, sb.buf, "  ");
+		add_one(result, sb.buf, S_IFDIR, "  ");
 		/*
 		 * sb.buf is leaked, but because this command is
 		 * short-lived anyway so it does not matter much
@@ -101,7 +110,7 @@ static void populate_cached_entries(struct string_l=
ist *result,
 		if (!matched(result, ce->name, ce->ce_mode))
 			continue;
=20
-		add_one(result, ce->name, "  ");
+		add_one(result, ce->name, ce->ce_mode, "  ");
 	}
=20
 	if (!show_dirs)
@@ -164,7 +173,11 @@ static int ls_config(const char *var, const char *=
value, void *cb)
 {
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "listfiles", &colopts);
-	return git_default_config(var, value, cb);
+	if (!strcmp(var, "color.listfiles")) {
+		use_color =3D git_config_colorbool(var, value);
+		return 0;
+	}
+	return git_color_default_config(var, value, cb);
 }
=20
 int cmd_list_files(int argc, const char **argv, const char *cmd_prefix=
)
@@ -187,6 +200,9 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
+	if (want_color(use_color))
+		parse_ls_color();
+
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       (max_depth !=3D -1 ? PATHSPEC_MAXDEPTH_VALID : 0) |
--=20
2.3.0.rc1.137.g477eb31
