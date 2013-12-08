From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] i18n: move the trailing space out of translatable strings
Date: Sun,  8 Dec 2013 09:11:44 +0700
Message-ID: <1386468704-18339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 08 03:07:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpTmT-00025C-G6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 03:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab3LHCHC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 21:07:02 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38897 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015Ab3LHCHB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 21:07:01 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so3141987pdj.11
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 18:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=LMpoTTjFR4ImCOJkqrZNJ6LAk2E6zWK5UFtYSfbxlhw=;
        b=j5hNPPHo5PUFhX6OWvc+/5TQ0Nramo2Dd9PF8hUUBZG82iaVUBsQZdgraHhIPwrWab
         jhwQE2dcPyIEuatsq6SMfy1lTTjMJQ9Mnf6nqZUrx+bcQ25mIyWo8JhSY8yL9kx8fUQ1
         9iOjcrcw8gWLQho551GG7YbeQNfVie0eSdRaA/9hXdXApfOTJjS9W/1QEnOoxtCrf+us
         7aU3Mtx+za4Ie4+H+V+1F6HYD466tJ62U4OmggJiVWYVfFniL3fQnaKIXDwzpz2l7OLI
         7m4cYfqFhm4toCgYAVU5LMCWNjVwwe/ygz/Ll5mXc8EQJ6cQswITaJsL9RAN87xhwhyR
         hPdQ==
X-Received: by 10.68.99.162 with SMTP id er2mr12972117pbb.10.1386468420597;
        Sat, 07 Dec 2013 18:07:00 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id vh3sm7614585pbc.8.2013.12.07.18.06.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Dec 2013 18:06:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Dec 2013 09:11:46 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239029>

I've got this with Vietnamese translation

    $ git status
    HEAD =C4=91=C6=B0=E1=BB=A3c t=C3=A1ch r=E1=BB=9Di t=E1=BB=ABorigin/=
master

One does not need to understand Vietnamese to see that a space is
missing before "origin/master" and this is because the original string
has a trailing space, but the translated one omits it.

I could fix vi.po alone, but it'd be better to avoid similar mistakes
for all translations by moving the trailing space out of all
translatable strings (*). This is inline with how we handle newlines
(e.g. *printf_ln wrappers) but it's not widespread enough to make new
*printf_space wrappers.

(*) the strings are detected by

    make pot; msgcat --no-wrap po/git.pot|grep 'msgid.* "$'

and if you do it after this patch, you will see maybe 3 matched lines
from git-bisect.sh and git-am.sh that I didn't bother to fix.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 BTW "msgcat...|grep 'msgid.*\n"$'" gives 159 matches. Low hanging
 fruit..

 builtin/clean.c |  5 +++--
 builtin/clone.c |  4 ++--
 wt-status.c     | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 615cd57..2b7e694 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -656,7 +656,7 @@ static int filter_by_patterns_cmd(void)
 			pretty_print_dels();
=20
 		clean_print_color(CLEAN_COLOR_PROMPT);
-		printf(_("Input ignore patterns>> "));
+		printf("%s ", _("Input ignore patterns>>"));
 		clean_print_color(CLEAN_COLOR_RESET);
 		if (strbuf_getline(&confirm, stdin, '\n') !=3D EOF)
 			strbuf_trim(&confirm);
@@ -754,7 +754,8 @@ static int ask_each_cmd(void)
 		/* Ctrl-D should stop removing files */
 		if (!eof) {
 			qname =3D quote_path_relative(item->string, NULL, &buf);
-			printf(_("remove %s? "), qname);
+			printf(_("remove %s?"), qname);
+			putchar(' ');
 			if (strbuf_getline(&confirm, stdin, '\n') !=3D EOF) {
 				strbuf_trim(&confirm);
 			} else {
diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..d48ccee 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -551,12 +551,12 @@ static void update_remote_refs(const struct ref *=
refs,
=20
 	if (check_connectivity) {
 		if (transport->progress)
-			fprintf(stderr, _("Checking connectivity... "));
+			fprintf(stderr, _("Checking connectivity..."));
 		if (check_everything_connected_with_transport(iterate_ref_map,
 							      0, &rm, transport))
 			die(_("remote did not send all necessary objects"));
 		if (transport->progress)
-			fprintf(stderr, _("done.\n"));
+			fprintf(stderr, " %s", _("done.\n"));
 	}
=20
 	if (refs) {
diff --git a/wt-status.c b/wt-status.c
index 4625cdb..3637656 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -330,11 +330,11 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 		if (d->new_submodule_commits || d->dirty_submodule) {
 			strbuf_addstr(&extra, " (");
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, _("new commits, "));
+				strbuf_addf(&extra, "%s, ", _("new commits"));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, _("modified content, "));
+				strbuf_addf(&extra, "%s, ", _("modified content"));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, _("untracked content, "));
+				strbuf_addf(&extra, "%s, ", _("untracked content"));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
@@ -1244,30 +1244,30 @@ void wt_status_print(struct wt_status *s)
 			    s->branch && !strcmp(s->branch, "HEAD"));
=20
 	if (s->branch) {
-		const char *on_what =3D _("On branch ");
+		const char *on_what =3D _("On branch");
 		const char *branch_name =3D s->branch;
 		if (!prefixcmp(branch_name, "refs/heads/"))
 			branch_name +=3D 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color =3D color(WT_STATUS_NOBRANCH, s);
 			if (state.rebase_in_progress || state.rebase_interactive_in_progres=
s) {
-				on_what =3D _("rebase in progress; onto ");
+				on_what =3D _("rebase in progress; onto");
 				branch_name =3D state.onto;
 			} else if (state.detached_from) {
 				unsigned char sha1[20];
 				branch_name =3D state.detached_from;
 				if (!get_sha1("HEAD", sha1) &&
 				    !hashcmp(sha1, state.detached_sha1))
-					on_what =3D _("HEAD detached at ");
+					on_what =3D _("HEAD detached at");
 				else
-					on_what =3D _("HEAD detached from ");
+					on_what =3D _("HEAD detached from");
 			} else {
 				branch_name =3D "";
 				on_what =3D _("Not currently on any branch.");
 			}
 		}
 		status_printf(s, color(WT_STATUS_HEADER, s), "");
-		status_printf_more(s, branch_status_color, "%s", on_what);
+		status_printf_more(s, branch_status_color, "%s ", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
@@ -1456,7 +1456,7 @@ static void wt_shortstatus_print_tracking(struct =
wt_status *s)
=20
 	branch =3D branch_get(s->branch + 11);
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, _("Initial commit on "));
+		color_fprintf(s->fp, header_color, "%s ", _("Initial commit on"));
=20
 	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
=20
@@ -1488,15 +1488,15 @@ static void wt_shortstatus_print_tracking(struc=
t wt_status *s)
 	if (upstream_is_gone) {
 		color_fprintf(s->fp, header_color, _("gone"));
 	} else if (!num_ours) {
-		color_fprintf(s->fp, header_color, _("behind "));
+		color_fprintf(s->fp, header_color, "%s ", _("behind"));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	} else if (!num_theirs) {
-		color_fprintf(s->fp, header_color, _("ahead "));
+		color_fprintf(s->fp, header_color, "%s ", _("ahead"));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
 	} else {
-		color_fprintf(s->fp, header_color, _("ahead "));
+		color_fprintf(s->fp, header_color, "%s ", _("ahead"));
 		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
-		color_fprintf(s->fp, header_color, _(", behind "));
+		color_fprintf(s->fp, header_color, ", %s ", _("behind"));
 		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);
 	}
=20
--=20
1.8.5.1.77.g42c48fa
