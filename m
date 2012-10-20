From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] New "git status" format with --alternate
Date: Sat, 20 Oct 2012 16:36:31 +0700
Message-ID: <1350725791-10396-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 20 11:36:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPVUB-00032S-85
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 11:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab2JTJgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2012 05:36:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53833 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab2JTJgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 05:36:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so978650pbb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=+ZmctyPZk/0J/3wU1t84nGKO/CKX7L/CyN05X57RQfI=;
        b=cWmP9HmWvu2vNGrIWV0s1Te7x062MW8exjcjSdISGMDS/4Mmq/HWm7Ea0pJ27cHCLS
         kU/NKDDGkuLUZxKDs39PMSIPkDXcIwCW8PfxImeDsUNEOjRBQsFrgcr5UlxhxblB16yn
         KvJYKmuRhXVxAAi7oJwTGUiU1RePek1j5q5xe7vlgivDrdEqLG9QvJN1BndrIEfazT1c
         wdFtSxVZKgpNNcEARczb8zv5uwZMSJNvKMr2QUAeOD1WOTOJlZYet9dHP0fc/7zzZHwj
         pUL9j0W4iJbZSB8dTKAwEdc8CRj829o0oSe0TiaJ42/fO3Dkn93MTlIxv9RLJW1BpKST
         vQoA==
Received: by 10.68.218.226 with SMTP id pj2mr14276332pbc.33.1350725797403;
        Sat, 20 Oct 2012 02:36:37 -0700 (PDT)
Received: from lanh ([115.74.57.39])
        by mx.google.com with ESMTPS id h6sm2497233paw.12.2012.10.20.02.36.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 02:36:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Oct 2012 16:36:32 +0700
X-Mailer: git-send-email 1.8.0.rc2.25.gf0e8e5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208084>

Another UI experiment, thrown at git@vger to see if it sticks. I've
been using this for a week and it feels good in general. But it may be
too specific to my taste to be useful for more people.

This format utilizes the screen estate as much as possible. It relies
on colors, so monochrome users are stuck with default format. In
short, it's a "GNU ls"-like output with footnotes:

 - entries of all kinds (untracked, modified, cached...) are sorted in
   a single list, laid out in columns
 - different kinds of files have different colors, more on this later
 - square brackets around a tracked file means differences between
   index and HEAD (aka "git diff --cached").
 - square brackets on untracked file means ignored file
 - more information such as renames, unmerged tyes... is added in form
   of footnotes

On a clean repository, "git status" prints nothing. Branch state
(rebasing/am-ing/....) is also printed.

This format is denser than the default format and easier to read (to
me) as there is only one table. Colors and brackets are the visual
clues. All the use of colors and brackets are explained in footnotes,
so new users should have no problems with it (provided that they know
basic concepts).

About colors, untracked files have no colors. Tracked files always do
(to catch your eyes). Added/Removed/Modified/Unmerged have different
colors. Text color reflects the changes between worktree and index
(aka "git diff"). Bracket color reflects changes between index and
HEAD (aka "git diff --cached").

If you see all magenta (modified) text without brackets, "git commit -a=
"
is your friend. If you see all yellow text (unmodified worktree)
and magenta brackets, "git commit" to go. A mix of magenta text and
brackets mean you need to do "git diff --cached" and "git diff" to
know what changes you are going to commit.

The merge of untracked/tracked files could be annoying if you don't
keep your repository clean, though. Not sure if mering is a good idea,
or just split them into two tables.

=46inal note: messy and incomplete implementation.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c |  11 ++
 wt-status.c      | 339 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++---
 wt-status.h      |   1 +
 3 files changed, 338 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a17a5df..758cf11 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -114,6 +114,7 @@ static struct strbuf message =3D STRBUF_INIT;
 static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
+	STATUS_FORMAT_ALTERNATE,
 	STATUS_FORMAT_PORCELAIN
 } status_format =3D STATUS_FORMAT_LONG;
=20
@@ -451,6 +452,9 @@ static int run_status(FILE *fp, const char *index_f=
ile, const char *prefix, int
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(s);
 		break;
+	case STATUS_FORMAT_ALTERNATE:
+		wt_altstatus_print(s);
+		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(s);
 		break;
@@ -1154,6 +1158,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_SET_INT('s', "short", &status_format,
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
+		OPT_SET_INT(0, "alternate", &status_format,
+			    N_("show status concisely"), STATUS_FORMAT_ALTERNATE),
 		OPT_BOOLEAN('b', "branch", &s.show_branch,
 			    N_("show branch information")),
 		OPT_SET_INT(0, "porcelain", &status_format,
@@ -1188,6 +1194,8 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
=20
 	if (s.null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
+	if (s.null_termination && status_format =3D=3D STATUS_FORMAT_ALTERNAT=
E)
+		die(_("--alternate does not work with -z"));
=20
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
@@ -1213,6 +1221,9 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	case STATUS_FORMAT_SHORT:
 		wt_shortstatus_print(&s);
 		break;
+	case STATUS_FORMAT_ALTERNATE:
+		wt_altstatus_print(&s);
+		break;
 	case STATUS_FORMAT_PORCELAIN:
 		wt_porcelain_print(&s);
 		break;
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..7502591 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -928,34 +928,40 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
 	wt_status_print_trailer(s);
 }
=20
-static void wt_status_print_state(struct wt_status *s)
+static void wt_status_get_state(struct wt_status *s,
+				struct wt_status_state *state)
 {
-	const char *state_color =3D color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
 	struct stat st;
-
-	memset(&state, 0, sizeof(state));
+	memset(state, 0, sizeof(*state));
=20
 	if (!stat(git_path("MERGE_HEAD"), &st)) {
-		state.merge_in_progress =3D 1;
+		state->merge_in_progress =3D 1;
 	} else if (!stat(git_path("rebase-apply"), &st)) {
 		if (!stat(git_path("rebase-apply/applying"), &st)) {
-			state.am_in_progress =3D 1;
+			state->am_in_progress =3D 1;
 			if (!stat(git_path("rebase-apply/patch"), &st) && !st.st_size)
-				state.am_empty_patch =3D 1;
+				state->am_empty_patch =3D 1;
 		} else {
-			state.rebase_in_progress =3D 1;
+			state->rebase_in_progress =3D 1;
 		}
 	} else if (!stat(git_path("rebase-merge"), &st)) {
 		if (!stat(git_path("rebase-merge/interactive"), &st))
-			state.rebase_interactive_in_progress =3D 1;
+			state->rebase_interactive_in_progress =3D 1;
 		else
-			state.rebase_in_progress =3D 1;
+			state->rebase_in_progress =3D 1;
 	} else if (!stat(git_path("CHERRY_PICK_HEAD"), &st)) {
-		state.cherry_pick_in_progress =3D 1;
+		state->cherry_pick_in_progress =3D 1;
 	}
 	if (!stat(git_path("BISECT_LOG"), &st))
-		state.bisect_in_progress =3D 1;
+		state->bisect_in_progress =3D 1;
+}
+
+static void wt_status_print_state(struct wt_status *s)
+{
+	const char *state_color =3D color(WT_STATUS_HEADER, s);
+	struct wt_status_state state;
+
+	wt_status_get_state(s, &state);
=20
 	if (state.merge_in_progress)
 		show_merge_in_progress(s, &state, state_color);
@@ -1224,6 +1230,313 @@ void wt_shortstatus_print(struct wt_status *s)
 	}
 }
=20
+static int cmp_items(const void *a, const void *b)
+{
+	const struct string_list_item *const *one =3D a;
+	const struct string_list_item *const *two =3D b;
+	return strcmp((*one)->string, (*two)->string);
+}
+
+static const char *col_unmerged =3D GIT_COLOR_CYAN;
+static const char *col_added =3D GIT_COLOR_GREEN;
+static const char *col_deleted =3D GIT_COLOR_RED;
+static const char *col_updated =3D GIT_COLOR_MAGENTA;
+static const char *col_tracked =3D GIT_COLOR_YELLOW;
+static const char *col_reset =3D GIT_COLOR_RESET;
+
+#define SHOW_TRACKED		8
+#define SHOW_UNMERGED		9
+#define SHOW_ADDED		10
+#define SHOW_DELETED		11
+#define SHOW_UPDATED		12
+#define SHOW_WORKTREE_DELETED	13
+#define SHOW_WORKTREE_UPDATED	14
+#define SHOW_UNTRACKED		15
+#define SHOW_IGNORED		16
+
+static void wt_altstatus_unmerged(struct wt_status *s,
+				  const char *name,
+				  struct wt_status_change_data *d,
+				  struct strbuf *out,
+				  struct string_list *footnotes,
+				  int *shown_how)
+{
+	struct strbuf onebuf =3D STRBUF_INIT;
+	const char *one;
+	const char *how =3D "";
+
+	switch (d->stagemask) {
+	case 1: how =3D "DD"; break; /* both deleted */
+	case 2: how =3D "AU"; break; /* added by us */
+	case 3: how =3D "UD"; break; /* deleted by them */
+	case 4: how =3D "UA"; break; /* added by them */
+	case 5: how =3D "DU"; break; /* deleted by us */
+	case 6: how =3D "AA"; break; /* both added */
+	case 7: how =3D "UU"; break; /* both modified */
+	}
+
+	if (!shown_how[d->stagemask]) {
+		const char *legend =3D NULL;
+		shown_how[d->stagemask] =3D 1;
+		switch (d->stagemask) {
+		case 1: legend =3D "[DD] deleted by both"; break;
+		case 2: legend =3D "[AU] added by us"; break;
+		case 3: legend =3D "[UD] deleted by them"; break;
+		case 4: legend =3D "[UA] added by them"; break;
+		case 5: legend =3D "[DU] deleted by us"; break;
+		case 6: legend =3D "[AA] added by both"; break;
+		case 7: legend =3D "[UU] modified by both"; break;
+		}
+		if (legend)
+			string_list_append(footnotes, xstrdup(legend));
+	}
+
+	if (!shown_how[SHOW_UNMERGED]) {
+		struct strbuf legend =3D STRBUF_INIT;
+		strbuf_addf(&legend, "%sfile%s -> unmerged entry",
+			    col_unmerged, col_reset);
+		string_list_append(footnotes, strbuf_detach(&legend, NULL));
+		shown_how[SHOW_UNMERGED] =3D 1;
+	}
+
+	one =3D quote_path(name, -1, &onebuf, s->prefix);
+	if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
+		putchar('"');
+		strbuf_addch(&onebuf, '"');
+		one =3D onebuf.buf;
+	}
+	strbuf_addf(out," %s%s%s [%s]", col_unmerged, one, col_reset, how);
+	strbuf_release(&onebuf);
+}
+
+static void wt_altstatus_tracked(struct wt_status *s,
+				 const char *name,
+				 struct wt_status_change_data *d,
+				 struct strbuf *out,
+				 struct string_list *footnotes,
+				 int *shown_how)
+{
+	struct strbuf onebuf =3D STRBUF_INIT;
+	const char *one;
+	const char *color;
+
+	one =3D quote_path(name, -1, &onebuf, s->prefix);
+	if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
+		putchar('"');
+		strbuf_addch(&onebuf, '"');
+		one =3D onebuf.buf;
+	}
+
+	switch (d->worktree_status) {
+	case DIFF_STATUS_DELETED:
+		color =3D col_deleted;
+		if (!shown_how[SHOW_WORKTREE_DELETED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%s[  ]%s -> removed from worktree",
+				    col_deleted, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_WORKTREE_DELETED] =3D 1;
+		}
+		break;
+	case 0:
+		color =3D col_tracked;
+		if (!shown_how[SHOW_TRACKED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%sfile%s -> worktree same as in index",
+				    col_tracked, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_TRACKED] =3D 1;
+		}
+		break;
+	default:
+		color =3D col_updated;
+		if (!shown_how[SHOW_WORKTREE_UPDATED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%sfile%s -> modified in worktree",
+				    col_updated, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_WORKTREE_UPDATED] =3D 1;
+		}
+	}
+
+	switch (d->index_status) {
+	case DIFF_STATUS_ADDED:
+		strbuf_addf(out, "%s[ %s%s%s ]%s",
+			    col_added, color, one,
+			    col_added, col_reset);
+		if (!shown_how[SHOW_ADDED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%sfile%s -> added to index",
+				    col_added, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_ADDED] =3D 1;
+		}
+		break;
+	case DIFF_STATUS_DELETED:
+		strbuf_addf(out, "%s[ %s%s%s ]%s",
+			    col_deleted, color, one,
+			    col_deleted, col_reset);
+		if (!shown_how[SHOW_DELETED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%sfile%s -> removed from index",
+				    col_deleted, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_DELETED] =3D 1;
+		}
+		break;
+	case 0:
+		strbuf_addf(out, "  %s%s%s", color, one, col_reset);
+		break;
+	default:
+		strbuf_addf(out, "%s[ %s%s%s ]%s",
+			    col_updated, color, one,
+			    col_updated, col_reset);
+		if (!shown_how[SHOW_UPDATED]) {
+			struct strbuf legend =3D STRBUF_INIT;
+			strbuf_addf(&legend, "%s[  ]%s -> changes in index",
+				    col_updated, col_reset);
+			string_list_append(footnotes, strbuf_detach(&legend, NULL));
+			shown_how[SHOW_UPDATED] =3D 1;
+		}
+	}
+
+	strbuf_release(&onebuf);
+
+	/* extra things at the end */
+	switch (d->worktree_status) {
+	case DIFF_STATUS_ADDED:
+	case DIFF_STATUS_DELETED:
+		break;
+	case DIFF_STATUS_TYPE_CHANGED:
+		/* FIXME */
+		strbuf_addf(out, "%s+x%s", GIT_COLOR_YELLOW,
+			    GIT_COLOR_RESET);
+		break;
+	case 0:
+		break;
+	}
+
+	if (d->head_path) {
+		struct strbuf tmp =3D STRBUF_INIT;
+		int id =3D footnotes->nr + 1;
+		strbuf_addf(out, " [%d]", id);
+		one =3D quote_path(d->head_path, -1, &onebuf, s->prefix);
+		if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
+			putchar('"');
+			strbuf_addch(&onebuf, '"');
+			one =3D onebuf.buf;
+		}
+		strbuf_addf(&tmp, "[%d] renamed from %s", id, onebuf.buf);
+		strbuf_release(&onebuf);
+		string_list_append(footnotes, strbuf_detach(&tmp, NULL));
+	}
+}
+
+void wt_altstatus_print(struct wt_status *s)
+{
+	int i, n;
+	struct string_list_item **all, **p;
+	struct string_list footnotes =3D STRING_LIST_INIT_NODUP;
+	struct string_list output =3D STRING_LIST_INIT_NODUP;
+	struct column_options copts;
+	struct wt_status_state state;
+	int shown_how[17];
+
+	n =3D s->untracked.nr + s->ignored.nr + s->change.nr;
+	p =3D all =3D xmalloc(sizeof(*all) * n);
+
+	for (i =3D 0; i < s->change.nr; i++)
+		*p++ =3D s->change.items + i;
+	for (i =3D 0; i < s->untracked.nr; i++)
+		*p++ =3D s->untracked.items + i;
+	for (i =3D 0; i < s->ignored.nr; i++)
+		*p++ =3D s->ignored.items + i;
+	qsort(all, n, sizeof(*all), cmp_items);
+
+	wt_status_get_state(s, &state);
+	if (state.merge_in_progress)
+		printf("%s(Merge in progress)%s\n",
+		       GIT_COLOR_YELLOW,
+		       GIT_COLOR_RESET);
+	else if (state.am_in_progress)
+		printf("%s(git-am in progress)%s\n",
+		       GIT_COLOR_YELLOW,
+		       GIT_COLOR_RESET);
+	else if (state.rebase_in_progress || state.rebase_interactive_in_prog=
ress)
+		printf("%s(Rebase in progress)%s\n",
+		       GIT_COLOR_YELLOW,
+		       GIT_COLOR_RESET);
+	else if (state.cherry_pick_in_progress)
+		printf("%s(Cherry-pick in progress)%s\n",
+		       GIT_COLOR_YELLOW,
+		       GIT_COLOR_RESET);
+	if (state.bisect_in_progress)
+		printf("%s(Bisect in progress)%s\n",
+		       GIT_COLOR_YELLOW,
+		       GIT_COLOR_RESET);
+
+	memset(shown_how, 0, sizeof(shown_how));
+
+	memset(&copts, 0, sizeof(copts));
+	copts.padding =3D 1;
+
+	for (i =3D 0; i < n; i++) {
+		struct string_list_item *it =3D all[i];
+		struct strbuf out =3D STRBUF_INIT;
+
+		if (it >=3D s->change.items &&
+		    it < s->change.items + s->change.nr) {
+			struct wt_status_change_data *d;
+
+			d =3D it->util;
+			if (d->stagemask)
+				wt_altstatus_unmerged(s, it->string, d, &out, &footnotes, shown_ho=
w);
+			else
+				wt_altstatus_tracked(s, it->string, d, &out, &footnotes, shown_how=
);
+		} else {
+			struct strbuf onebuf =3D STRBUF_INIT;
+			const char *one;
+
+			one =3D quote_path(it->string, -1, &onebuf, s->prefix);
+			if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
+				putchar('"');
+				strbuf_addch(&onebuf, '"');
+				one =3D onebuf.buf;
+			}
+
+			if (it >=3D s->untracked.items &&
+				 it < s->untracked.items + s->untracked.nr) {
+				strbuf_addf(&out, "  %s", one);
+				if (!shown_how[SHOW_UNTRACKED]) {
+					string_list_append(&footnotes, xstrdup("file -> untracked file"))=
;
+					shown_how[SHOW_UNTRACKED] =3D 1;
+				}
+			} else if (it >=3D s->ignored.items &&
+				 it < s->ignored.items + s->ignored.nr) {
+				strbuf_addf(&out, "[ %s ]", one);
+				if (!shown_how[SHOW_IGNORED]) {
+					string_list_append(&footnotes, xstrdup("[file] -> ignored file"))=
;
+					shown_how[SHOW_IGNORED] =3D 1;
+				}
+			} else
+				die("Where does this item come from?");
+
+			strbuf_release(&onebuf);
+		}
+		string_list_append(&output, strbuf_detach(&out, NULL));
+	}
+	print_columns(&output, s->colopts, &copts);
+	string_list_clear(&output, 0);
+
+	if (footnotes.nr) {
+		printf("\n");
+		memset(&copts, 0, sizeof(copts));
+		copts.padding =3D 3;
+		print_columns(&footnotes, s->colopts, &copts);
+	}
+	string_list_clear(&footnotes, 0);
+}
+
 void wt_porcelain_print(struct wt_status *s)
 {
 	s->use_color =3D 0;
diff --git a/wt-status.h b/wt-status.h
index 236b41f..8804400 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -86,6 +86,7 @@ void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
=20
 void wt_shortstatus_print(struct wt_status *s);
+void wt_altstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
=20
 void status_printf_ln(struct wt_status *s, const char *color, const ch=
ar *fmt, ...)
--=20
1.8.0.rc2.25.gf0e8e5d
