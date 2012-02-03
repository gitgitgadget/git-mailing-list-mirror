From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 11/13] status: add --column
Date: Fri,  3 Feb 2012 20:34:36 +0700
Message-ID: <1328276078-27955-12-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:32:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJFU-0008RW-6s
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab2BCNcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:32:12 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47389 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756414Ab2BCNcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:32:10 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so2900162pbd.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oRTW1tAO9jCsRteHifBXo+FMFDEyp5ko2y7P0AggKHs=;
        b=p6uH+q+yYrHcz+at+A02s/ltvpyvviH9PNcwgMHdONHjRJhKWqnNAzcAdvBgkBdz95
         7MnRBDMVq0+vGhxozEj1RRyHlWRS4HnBCRt+wHAKKt/i8LyCNC70Ceq29YLS1HboxWAU
         oQqSUDo06SmsGsUERTHfGiNUHe7eilM2udxYY=
Received: by 10.68.233.135 with SMTP id tw7mr7779981pbc.67.1328275929593;
        Fri, 03 Feb 2012 05:32:09 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id i10sm13122576pbg.10.2012.02.03.05.32.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:32:08 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:36:17 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189769>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt     |    4 ++++
 Documentation/git-status.txt |    7 +++++++
 Makefile                     |    2 +-
 builtin/commit.c             |   13 +++++++++++--
 wt-status.c                  |   38 ++++++++++++++++++++++++++++++++--=
----
 wt-status.h                  |    2 +-
 6 files changed, 56 insertions(+), 10 deletions(-)

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
index eba1377..8ce6a18 100644
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
+static int colopts;
=20
 /*
  * The default commit message cleanup mode will remove the lines
@@ -519,7 +521,7 @@ static int run_status(FILE *fp, const char *index_f=
ile, const char *prefix, int
 		wt_porcelain_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_LONG:
-		wt_status_print(s);
+		wt_status_print(s, 0);
 		break;
 	}
=20
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
@@ -1213,6 +1220,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_status_config, &s);
+	if (!colopts)
+		colopts =3D git_colopts | COL_ANSI;
 	determine_whence(&s);
 	argc =3D parse_options(argc, argv, prefix,
 			     builtin_status_options,
@@ -1251,7 +1260,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	case STATUS_FORMAT_LONG:
 		s.verbose =3D verbose;
 		s.ignore_submodule_arg =3D ignore_submodule_arg;
-		wt_status_print(&s);
+		wt_status_print(&s, colopts);
 		break;
 	}
 	return 0;
diff --git a/wt-status.c b/wt-status.c
index 9ffc535..86291e9 100644
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
@@ -637,10 +638,13 @@ static void wt_status_print_submodule_summary(str=
uct wt_status *s, int uncommitt
 static void wt_status_print_other(struct wt_status *s,
 				  struct string_list *l,
 				  const char *what,
-				  const char *how)
+				  const char *how,
+				  int colopts)
 {
 	int i;
 	struct strbuf buf =3D STRBUF_INIT;
+	static struct string_list output =3D STRING_LIST_INIT_DUP;
+	struct column_options copts;
=20
 	if (!l->nr)
 		return;
@@ -649,12 +653,32 @@ static void wt_status_print_other(struct wt_statu=
s *s,
=20
 	for (i =3D 0; i < l->nr; i++) {
 		struct string_list_item *it;
+		const char *path;
 		it =3D &(l->items[i]);
+		path =3D quote_path(it->string, strlen(it->string),
+				  &buf, s->prefix);
+		if (colopts & COL_ENABLED) {
+			add_cell_to_list(&output, colopts, path);
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
+	if ((colopts & COL_ENABLED) =3D=3D 0)
+		return;
+
+	strbuf_addf(&buf, "%s#\t%s",
+		    color(WT_STATUS_HEADER,s),
+		    color(WT_STATUS_UNTRACKED, s));
+	memset(&copts, 0, sizeof(copts));
+	copts.padding =3D 1;
+	copts.indent =3D buf.buf;
+	copts.nl =3D GIT_COLOR_RESET "\n";
+	print_columns(&output, colopts, &copts);
+	string_list_clear(&output, 0);
 	strbuf_release(&buf);
 }
=20
@@ -704,7 +728,7 @@ static void wt_status_print_tracking(struct wt_stat=
us *s)
 	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 }
=20
-void wt_status_print(struct wt_status *s)
+void wt_status_print(struct wt_status *s, int colopts)
 {
 	const char *branch_color =3D color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color =3D color(WT_STATUS_HEADER, s);
@@ -742,9 +766,11 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_submodule_summary(s, 1);  /* unstaged */
 	}
 	if (s->show_untracked_files) {
-		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
+		wt_status_print_other(s, &s->untracked,
+				      _("Untracked"), "add", colopts);
 		if (s->show_ignored_files)
-			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
+			wt_status_print_other(s, &s->ignored,
+					      _("Ignored"), "add -f", colopts);
 	} else if (s->commitable)
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%=
s"),
 			advice_status_hints
diff --git a/wt-status.h b/wt-status.h
index 682b4c8..4ab2799 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -69,7 +69,7 @@ struct wt_status {
 };
=20
 void wt_status_prepare(struct wt_status *s);
-void wt_status_print(struct wt_status *s);
+void wt_status_print(struct wt_status *s, int colopts);
 void wt_status_collect(struct wt_status *s);
=20
 void wt_shortstatus_print(struct wt_status *s, int null_termination, i=
nt show_branch);
--=20
1.7.8.36.g69ee2
