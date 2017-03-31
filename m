Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951301FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 13:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbdCaN7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 09:59:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51678 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbdCaN7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 09:59:20 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LeS5t-1cMGLY2aDN-00qDP2; Fri, 31
 Mar 2017 15:59:17 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH] status: show in-progress info for short status
Date:   Fri, 31 Mar 2017 15:59:17 +0200
Message-Id: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.739.gfc3eb97820
X-Provags-ID: V03:K0:7NB5yOipjlrlcDJFCWFbjc/XoOFB91DJfoY50X0Sn9/uH5PUH8e
 OWivP6Rd8vGCHkHfr3XUSyW2ir4pq85A1EHgvkaZcIsAvFeRpJ69H1oYe/rijlKlvXkN+Xt
 IY0DzxfgmYaI4Ry0qSrtRg/nLC4MHbmtZxv1edK2M6CQ/b+LkXYdoQ/Y9fHxpOSyaYp/X/S
 2m5YYe5cj8Hvt2TJoqxzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dNTP2lB7mAw=:u19tdT6YWncxH1T999zGDk
 BWYzX0Uhe5T6FM5m4E+JpftTHQ3LTDq0ZiAnxZHImUXpoqd9EyBHkGZfMTnuO83PigSHvhSGK
 VZuujpFX71Wzz7mXSr4q0+jFmsjHEZoXXLYM/CNrnYEUJqfqB6sK0ls/GBDVyoRAG6//i6z1P
 ub3m8omnEJUocremywWBTuBAopMFueghbSO0rhE6FbWPt51pAFJVAmh9NjYwE7x0vHaQ52icd
 h6X09zZ+uuY7VgIMUat89PizkOPl4oPGVvScgzVExbuoyJ+whuxTczLjFLZG6gnughLpz7w2r
 Y/PscJEhwmMypeYTXblX1U6wowpkdL0EZwhcU4N1Ph0vpjQpxeLila0UXrUGfKaonWR6tDczo
 3tr5/CgVGmBW0pLvewive/l4YesQFCh68lMyzvSJU++E9EXP2vOXlQ9ibRsy3CFP46vU4gMuX
 PJ6SN5ghUVf5yJn7HZ4DiKpYPdVzGzKPEftKh9FMce7HsVQAo5qLQK7QPBIBr9EyUf5tTzeZU
 hreUe7VqR2p8gUlcIe4sb91VqdS1fprPaLMVGPUnNceN0yhz6OjTZkPYLjnwuSaA8KaxJC2rp
 JwBptbJcwZ+t43ZsqNCWB+sYuyao0d/mcLOraQJ9GXIXAQ/0NbFDivLwYHFESFuCTP5jzAcgV
 a9y6ut/QCPQmhxaQcCkAC6hm/I0SjKhHwAWBaFQnQ/6TrutbF/7ehKrSEGUUOkZhPYiE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ordinary (long) status shows information about bisect, revert, am,
rebase, cherry-pick in progress, and so does git-prompt.sh. status
--short currently shows none of this information.

Introduce an `--inprogress` argument to git status so that, when used with
`--short --branch`, in-progress information is shown next to the branch
information. Just like `--branch`, this comes with a config option.

The wording for the in-progress information is taken over from
git-prompt.sh.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
When used with --porcelain, this gives an easy way to amend the powerline-gitstatus
prompt for example (in use locally here), and certainly others.

I don't touch --porcelain=v2 - that one reads in-progress state but does not seem
to display it. I don't know which parts are supposed to be stable for v2. 

 Documentation/config.txt     |  4 +++
 Documentation/git-status.txt |  5 ++++
 builtin/commit.c             | 13 ++++++++++
 t/t7512-status-help.sh       | 58 ++++++++++++++++++++++++++++++++++++++++----
 wt-status.c                  | 32 +++++++++++++++++++++---
 wt-status.h                  |  1 +
 6 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..3adc65f9d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2957,6 +2957,10 @@ status.branch::
 	Set to true to enable --branch by default in linkgit:git-status[1].
 	The option --no-branch takes precedence over this variable.
 
+status.inprogress::
+	Set to true to enable --inprogress by default in linkgit:git-status[1].
+	The option --no-inprogress takes precedence over this variable.
+
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index ba873657cf..4fac073247 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,6 +32,11 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
+-p::
+--inprogress::
+	When showing branch and tracking info in short-format,
+	show in-progress information (BISECTING, MERGING etc.), too.
+
 --porcelain[=<version>]::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
diff --git a/builtin/commit.c b/builtin/commit.c
index 4e288bc513..6176dd2c2f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1105,8 +1105,10 @@ static const char *read_commit_message(const char *name)
 static struct status_deferred_config {
 	enum wt_status_format status_format;
 	int show_branch;
+	int show_inprogress;
 } status_deferred_config = {
 	STATUS_FORMAT_UNSPECIFIED,
+	-1, /* unspecified */
 	-1 /* unspecified */
 };
 
@@ -1133,6 +1135,10 @@ static void finalize_deferred_config(struct wt_status *s)
 		s->show_branch = status_deferred_config.show_branch;
 	if (s->show_branch < 0)
 		s->show_branch = 0;
+	if (use_deferred_config && s->show_inprogress < 0)
+		s->show_inprogress = status_deferred_config.show_inprogress;
+	if (s->show_inprogress < 0)
+		s->show_inprogress = 0;
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -1291,6 +1297,10 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "status.inprogress")) {
+		status_deferred_config.show_inprogress = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		s->use_color = git_config_colorbool(k, v);
 		return 0;
@@ -1339,6 +1349,8 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
 			 N_("show branch information")),
+		OPT_BOOL('p', "inprogress", &s.show_inprogress,
+			 N_("show in-progress information")),
 		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
 		  N_("version"), N_("machine-readable output"),
 		  PARSE_OPT_OPTARG, opt_parse_porcelain },
@@ -1612,6 +1624,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
+		OPT_BOOL(0, "inprogress", &s.show_inprogress, N_("show in-progress information")),
 		OPT_SET_INT(0, "porcelain", &status_format,
 			    N_("machine-readable output"), STATUS_FORMAT_PORCELAIN),
 		OPT_SET_INT(0, "long", &status_format,
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 458608cc1e..103e006249 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -74,7 +74,6 @@ test_expect_success 'prepare for rebase conflicts' '
 
 
 test_expect_success 'status when rebase in progress before resolving conflicts' '
-	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
 	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
 	cat >expected <<EOF &&
@@ -96,6 +95,15 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status when rebase in progress' '
+	test_when_finished "git rebase --abort" &&
+	cat >expected <<EOF &&
+## HEAD (no branch); REBASE-m
+UU main.txt
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
 
 test_expect_success 'status when rebase in progress before rebase --continue' '
 	git reset --hard rebase_conflicts &&
@@ -133,7 +141,6 @@ test_expect_success 'prepare for rebase_i_conflicts' '
 
 
 test_expect_success 'status during rebase -i when conflicts unresolved' '
-	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short rebase_i_conflicts) &&
 	LAST_COMMIT=$(git rev-parse --short rebase_i_conflicts_second) &&
 	test_must_fail git rebase -i rebase_i_conflicts &&
@@ -159,6 +166,16 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status during rebase -i when conflicts unresolved' '
+	test_when_finished "git rebase --abort" &&
+	cat >expected <<EOF &&
+## HEAD (no branch); REBASE-i
+UU main.txt
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
+
 
 test_expect_success 'status during rebase -i after resolving conflicts' '
 	git reset --hard rebase_i_conflicts_second &&
@@ -613,7 +630,6 @@ test_expect_success 'prepare am_session' '
 
 test_expect_success 'status in an am session: file already exists' '
 	git checkout -b am_already_exists &&
-	test_when_finished "rm Maildir/* && git am --abort" &&
 	git format-patch -1 -oMaildir &&
 	test_must_fail git am Maildir/*.patch &&
 	cat >expected <<\EOF &&
@@ -629,6 +645,14 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status in an am session: file already exists' '
+	test_when_finished "rm Maildir/* && git am --abort" &&
+	cat >expected <<\EOF &&
+## am_already_exists; AM
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
 
 test_expect_success 'status in an am session: file does not exist' '
 	git reset --hard am_session &&
@@ -681,7 +705,6 @@ test_expect_success 'status when bisecting' '
 	test_commit one_bisect main.txt one &&
 	test_commit two_bisect main.txt two &&
 	test_commit three_bisect main.txt three &&
-	test_when_finished "git bisect reset" &&
 	git bisect start &&
 	git bisect bad &&
 	git bisect good one_bisect &&
@@ -697,6 +720,14 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status when bisecting' '
+	test_when_finished "git bisect reset" &&
+	cat >expected <<EOF &&
+## HEAD (no branch); BISECTING
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
 
 test_expect_success 'status when rebase conflicts with statushints disabled' '
 	git reset --hard master &&
@@ -736,7 +767,6 @@ test_expect_success 'prepare for cherry-pick conflicts' '
 
 
 test_expect_success 'status when cherry-picking before resolving conflicts' '
-	test_when_finished "git cherry-pick --abort" &&
 	test_must_fail git cherry-pick cherry_branch_second &&
 	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
 	cat >expected <<EOF &&
@@ -756,6 +786,15 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status when cherry-picking before resolving conflicts' '
+	test_when_finished "git cherry-pick --abort" &&
+	cat >expected <<EOF &&
+## cherry_branch; CHERRY-PICKING
+UU main.txt
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
 
 test_expect_success 'status when cherry-picking after resolving conflicts' '
 	git reset --hard cherry_branch &&
@@ -827,6 +866,15 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'short status while reverting commit (conflicts)' '
+	cat >expected <<EOF &&
+## master; REVERTING
+UU to-revert.txt
+EOF
+	git status --untracked-files=no --short --branch --inprogress >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'status while reverting commit (conflicts resolved)' '
 	echo reverted >to-revert.txt &&
 	git add to-revert.txt &&
diff --git a/wt-status.c b/wt-status.c
index 308cf3779e..f4606d27c8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1715,6 +1715,7 @@ static void wt_shortstatus_other(struct string_list_item *it,
 static void wt_shortstatus_print_tracking(struct wt_status *s)
 {
 	struct branch *branch;
+	struct wt_status_state state;
 	const char *header_color = color(WT_STATUS_HEADER, s);
 	const char *branch_color_local = color(WT_STATUS_LOCAL_BRANCH, s);
 	const char *branch_color_remote = color(WT_STATUS_REMOTE_BRANCH, s);
@@ -1738,7 +1739,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	if (!strcmp(s->branch, "HEAD")) {
 		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
 			      LABEL(N_("HEAD (no branch)")));
-		goto conclude;
+		goto inprogress;
 	}
 
 	skip_prefix(branch_name, "refs/heads/", &branch_name);
@@ -1749,7 +1750,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
 		if (!base)
-			goto conclude;
+			goto inprogress;
 
 		upstream_is_gone = 1;
 	}
@@ -1760,7 +1761,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	free((char *)base);
 
 	if (!upstream_is_gone && !num_ours && !num_theirs)
-		goto conclude;
+		goto inprogress;
 
 	color_fprintf(s->fp, header_color, " [");
 	if (upstream_is_gone) {
@@ -1779,6 +1780,31 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	}
 
 	color_fprintf(s->fp, header_color, "]");
+
+ inprogress:
+	if (!s->show_inprogress)
+		goto conclude;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state,
+			    s->branch && !strcmp(s->branch, "HEAD"));
+	if (state.merge_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("MERGING")));
+	else if (state.am_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("AM")));
+	else if (state.rebase_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-m")));
+	else if (state.rebase_interactive_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-i")));
+	else if (state.cherry_pick_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("CHERRY-PICKING")));
+	else if (state.revert_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REVERTING")));
+	if (state.bisect_in_progress)
+		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("BISECTING")));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+
  conclude:
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
 }
diff --git a/wt-status.h b/wt-status.h
index 54fec77032..8f6c9e0e62 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,6 +77,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int show_inprogress;
 	int hints;
 
 	enum wt_status_format status_format;
-- 
2.12.2.739.gfc3eb97820

