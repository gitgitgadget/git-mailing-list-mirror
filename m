From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 10/12] status: add --column
Date: Sat,  4 Feb 2012 22:59:14 +0700
Message-ID: <1328371156-4009-11-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:56:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthyT-0006zB-Dw
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab2BDP4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:56:20 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753Ab2BDP4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:56:19 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so3553938dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PYVIPO07868bth30vdry/OPHOIoymUi2q+UuivF7pyw=;
        b=xXw8e+A5v8l5Xu1SUSZQrxKKeoJ/cCcQNSeekQnkCZJ2OD2eGREk3tGbuFVFPlNltH
         mu1OqmAJNE46uYiHuJkxWktAhfik4caYYWydHSo4Xe7B8SZ8DmXs+iUgMkRvo5/Ys+TL
         50V+vMI6wO1ulP5TXyk3hQD5Si1LUyg3i/qcc=
Received: by 10.68.228.6 with SMTP id se6mr25689796pbc.80.1328370977678;
        Sat, 04 Feb 2012 07:56:17 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id a5sm22399140pbh.15.2012.02.04.07.56.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:56:16 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 23:00:43 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189883>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-status.txt |    7 +++++++
 Makefile                     |    2 +-
 builtin/commit.c             |    8 ++++++++
 t/t7508-status.sh            |   24 ++++++++++++++++++++++++
 wt-status.c                  |   28 ++++++++++++++++++++++++++--
 wt-status.h                  |    1 +
 7 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c14db27..ebb210c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -851,6 +851,10 @@ column.branch::
 	Specify whether to output branch listing in `git branch` in columns.
 	See `column.ui` for details.
=20
+column.status::
+	Specify whether to output untracked files in `git status` in columns.
+	See `column.ui` for details.
+
 commit.status::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 3d51717..2f87207 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -77,6 +77,13 @@ configuration variable documented in linkgit:git-con=
fig[1].
 	Terminate entries with NUL, instead of LF.  This implies
 	the `--porcelain` output format if no other format is given.
=20
+--column[=3D<options>]::
+--no-column::
+	Display untracked files in columns. See configuration variable
+	column.status for option syntax.`--column` and `--no-column`
+	without options are equivalent to 'always' and 'never'
+	respectively.
+
=20
 OUTPUT
 ------
diff --git a/Makefile b/Makefile
index 061f6e5..b2644bc 100644
--- a/Makefile
+++ b/Makefile
@@ -2116,7 +2116,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-builtin/branch.o column.o help.o pager.o: column.h
+builtin/branch.o builtin/commit.o column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..b73211c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -27,6 +27,7 @@
 #include "quote.h"
 #include "submodule.h"
 #include "gpg-interface.h"
+#include "column.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	"git commit [options] [--] <filepattern>...",
@@ -88,6 +89,7 @@ static int quiet, verbose, no_verify, allow_empty, dr=
y_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
+static unsigned int colopts;
=20
 /*
  * The default commit message cleanup mode will remove the lines
@@ -1138,7 +1140,11 @@ static int parse_status_slot(const char *var, in=
t offset)
 static int git_status_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s =3D cb;
+	int status;
=20
+	status =3D git_column_config(k, v, "status", &colopts);
+	if (status <=3D 0)
+		return status;
 	if (!strcmp(k, "status.submodulesummary")) {
 		int is_bool;
 		s->submodule_summary =3D git_config_bool_or_int(k, v, &is_bool);
@@ -1204,6 +1210,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, "whe=
n",
 		  "ignore changes to submodules, optional when: all, dirty, untracke=
d. (Default: all)",
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
+		OPT_COLUMN(0, "column", &colopts, "list untracked files in columns" =
),
 		OPT_END(),
 	};
=20
@@ -1217,6 +1224,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
+	s.colopts =3D colopts;
=20
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index fc57b13..8f5cfac 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -59,6 +59,30 @@ test_expect_success 'status (1)' '
 	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" outpu=
t
 '
=20
+test_expect_success 'status --column' '
+	COLUMNS=3D50 git status --column=3D"column dense" >output &&
+	cat >expect <<\EOF &&
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	new file:   dir2/added
+#
+# Changes not staged for commit:
+#   (use "git add <file>..." to update what will be committed)
+#   (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
+#
+#	modified:   dir1/modified
+#
+# Untracked files:
+#   (use "git add <file>..." to include in what will be committed)
+#
+#	dir1/untracked dir2/untracked untracked
+#	dir2/modified  output
+EOF
+	test_cmp expect output
+'
+
 cat >expect <<\EOF
 # On branch master
 # Changes to be committed:
diff --git a/wt-status.c b/wt-status.c
index 9ffc535..63ce7c9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -11,6 +11,7 @@
 #include "remote.h"
 #include "refs.h"
 #include "submodule.h"
+#include "column.h"
=20
 static char default_wt_status_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
@@ -641,6 +642,8 @@ static void wt_status_print_other(struct wt_status =
*s,
 {
 	int i;
 	struct strbuf buf =3D STRBUF_INIT;
+	static struct string_list output =3D STRING_LIST_INIT_DUP;
+	struct column_options copts;
=20
 	if (!l->nr)
 		return;
@@ -649,12 +652,33 @@ static void wt_status_print_other(struct wt_statu=
s *s,
=20
 	for (i =3D 0; i < l->nr; i++) {
 		struct string_list_item *it;
+		const char *path;
 		it =3D &(l->items[i]);
+		path =3D quote_path(it->string, strlen(it->string),
+				  &buf, s->prefix);
+		if (s->colopts & COL_ENABLED) {
+			string_list_append(&output, path);
+			continue;
+		}
 		status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 		status_printf_more(s, color(WT_STATUS_UNTRACKED, s),
-			"%s\n", quote_path(it->string, strlen(it->string),
-					    &buf, s->prefix));
+				   "%s\n", path);
 	}
+
+	strbuf_release(&buf);
+	if ((s->colopts & COL_ENABLED) =3D=3D 0)
+		return;
+
+	strbuf_addf(&buf, "%s#\t%s",
+		    color(WT_STATUS_HEADER,s),
+		    color(WT_STATUS_UNTRACKED, s));
+	memset(&copts, 0, sizeof(copts));
+	copts.padding =3D 1;
+	copts.indent =3D buf.buf;
+	if (want_color(s->use_color))
+		copts.nl =3D GIT_COLOR_RESET "\n";
+	print_columns(&output, s->colopts, &copts);
+	string_list_clear(&output, 0);
 	strbuf_release(&buf);
 }
=20
diff --git a/wt-status.h b/wt-status.h
index 682b4c8..6dd7207 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -56,6 +56,7 @@ struct wt_status {
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
+	int colopts;
=20
 	/* These are computed during processing of the individual sections */
 	int commitable;
--=20
1.7.8.36.g69ee2
