Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CF420259
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932378AbcLHPg2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:63942 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932353AbcLHPg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfGo0-1czHi73qSu-00omYQ; Thu, 08
 Dec 2016 16:36:20 +0100
Date:   Thu, 8 Dec 2016 16:36:19 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 4/7] read_early_config(): special-case `init` and
 `clone`
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <fcc3262f1245b6fe846f434ae9d500aa953e39f7.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:imzqR8Rffu9Q7RB9oQuRXIlmXScw2ZYfos7o8qu7kYI6F1uVhP5
 ZaJZ+IRmT3kaxhqWo6wAIpCZCEiaPlb6sowBLFl3pvrPqZQAW/0kpbR8h2HXs99aDq/5+NE
 XJM0tfJC6GYWVRnY+xBZEoDLk4prqK7WtR2/cV9lT8ZhFuuF53nPxrXqKaLRQcEtmtOS9Ae
 YheMVIdYf+305VrC0k1PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0GKFyhoFWnI=:s3j4YeT6w8UsiA2kn4ttUa
 9uDDLsO+fXwS8IDomAmWPe1Zc+ALtKldrobXF87O0s70ECdIJsXOLB6nzZ9hBk9QX43W2II/K
 tKnLnIpCY0R0RKzE99MKhQHkl1uic4kX1Qu9w1AUp8zuYUghcI6wgxf1wblV7oufl6Vvf5LD1
 qi5B4gegv4IgzOTbCNpjZxEvr2Z7L1V0hErxnym6p8LgOCSKWcW4jhyql4z8Y0CZkOxxl/8wJ
 NqxMqRTDOO1Y6QFJqdrZNvnDDdEV1AORC5WLbYgyFE/MZ55JrmT6dKJfeJwCaxIf+3SogSnr0
 M1TbCxmUEg018sI4CfIVeOc/O7aRx2y01CPiL1LvzJ0V+4S6G/lmKitYHbbMgOPdPPHzzDRjk
 gjehd54ToWfYx4sZ9oRRkS2zULdF2CGyRgXRDR4ShyX0ZBuNKv4mZVNVbjuUynGaN0geYjN6G
 v9BXusIpmOCeVH4fDKAardAsJyfuGa3jAkjY3lCwKtbpocU0dVx1+ZcDBb6Xeb5UsCAQGgKM8
 RyXK8UrSfdpv0d+Tif5k6mTX0iMTmR6a1v8ieG1OExdv9Nu8gh+zeHx5zkqBoNLdFMiqWBa3m
 Kcg/wlHBaK2iDMzIQ2q1oryx4/jAJAvRfoHT8xm54cxlOl1Ln7HvCiQmVpy6KQpEpTjE5upnG
 hqjOQRyiZWBqdUhbC1Cf9ox+48/K4OI1Xk9twNywenve+zydtiEd9dBUPDF+yMs8oMsNh9hih
 B01aCuVG1RzHLsIZ1lbklFFgkVzCVdBWroQ9VWZ1XzSZjm79pOCAJKMVS8PFx4AZchKVH4Hcf
 YqkULy7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `init` and `clone` commands create their own .git/ directory,
therefore we must be careful not to read any repository config when
determining the pager settings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c    |  2 +-
 builtin/blame.c |  2 +-
 builtin/grep.c  |  4 ++--
 builtin/log.c   |  4 ++--
 builtin/var.c   |  2 +-
 cache.h         |  9 +++++----
 config.c        |  4 ++--
 diff.c          |  4 ++--
 git.c           | 16 ++++++++--------
 pager.c         | 13 +++++++------
 10 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 6981f42ce9..e6c2ee01bc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1791,7 +1791,7 @@ static int do_interactive(struct am_state *state)
 			}
 			strbuf_release(&msg);
 		} else if (*reply == 'v' || *reply == 'V') {
-			const char *pager = git_pager(1);
+			const char *pager = git_pager(1, 1);
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			if (!pager)
diff --git a/builtin/blame.c b/builtin/blame.c
index 4ddfadb71f..5b7daa3686 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2913,7 +2913,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	assign_blame(&sb, opt);
 
 	if (!incremental)
-		setup_pager();
+		setup_pager(1);
 
 	free(final_commit_name);
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 8887b6addb..363a753369 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -800,7 +800,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_in_pager == default_pager)
-		show_in_pager = git_pager(1);
+		show_in_pager = git_pager(1, 1);
 	if (show_in_pager) {
 		opt.color = 0;
 		opt.name_only = 1;
@@ -896,7 +896,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!show_in_pager && !opt.status_only)
-		setup_pager();
+		setup_pager(1);
 
 	if (!use_index && (untracked || cached))
 		die(_("--cached or --untracked cannot be used with --no-index."));
diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc2d8..96618d38cb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->line_level_traverse)
 		line_log_init(rev, line_cb.prefix, &line_cb.args);
 
-	setup_pager();
+	setup_pager(1);
 }
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
@@ -1600,7 +1600,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!use_stdout)
 		output_directory = set_outdir(prefix, output_directory);
 	else
-		setup_pager();
+		setup_pager(1);
 
 	if (output_directory) {
 		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
diff --git a/builtin/var.c b/builtin/var.c
index aedbb53a2d..879867b842 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -19,7 +19,7 @@ static const char *editor(int flag)
 
 static const char *pager(int flag)
 {
-	const char *pgm = git_pager(1);
+	const char *pgm = git_pager(1, 1);
 
 	if (!pgm)
 		pgm = "cat";
diff --git a/cache.h b/cache.h
index 96e0cb2523..6627239de8 100644
--- a/cache.h
+++ b/cache.h
@@ -1325,7 +1325,7 @@ extern const char *fmt_name(const char *name, const char *email);
 extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
-extern const char *git_pager(int stdout_is_tty);
+extern const char *git_pager(int stdout_is_tty, int discover_git_dir);
 extern int git_ident_config(const char *, const char *, void *);
 extern void reset_ident_date(void);
 
@@ -1692,7 +1692,8 @@ extern int git_config_from_mem(config_fn_t fn, const enum config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern void read_early_config(config_fn_t cb, void *data);
+extern void read_early_config(config_fn_t cb, void *data,
+			      int discover_git_dir);
 extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
@@ -1888,12 +1889,12 @@ __attribute__((format (printf, 2, 3)))
 extern void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
-extern void setup_pager(void);
+extern void setup_pager(int discover_git_dir);
 extern int pager_in_use(void);
 extern int pager_use_color;
 extern int term_columns(void);
 extern int decimal_width(uintmax_t);
-extern int check_pager_config(const char *cmd);
+extern int check_pager_config(const char *cmd, int discover_git_dir);
 extern void prepare_pager_args(struct child_process *, const char *pager);
 
 extern const char *editor_program;
diff --git a/config.c b/config.c
index 104c3c3dcd..4c756edca1 100644
--- a/config.c
+++ b/config.c
@@ -1385,7 +1385,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	}
 }
 
-void read_early_config(config_fn_t cb, void *data)
+void read_early_config(config_fn_t cb, void *data, int discover_git_dir)
 {
 	git_config_with_options(cb, data, NULL, 1);
 
@@ -1407,7 +1407,7 @@ void read_early_config(config_fn_t cb, void *data)
 	 * valid repository), and would rarely make things worse (i.e., you do
 	 * not generally have a .git/config file sitting around).
 	 */
-	if (!have_git_dir()) {
+	if (discover_git_dir && !have_git_dir()) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
diff --git a/diff.c b/diff.c
index ec8728362d..0769c0590a 100644
--- a/diff.c
+++ b/diff.c
@@ -5267,6 +5267,6 @@ void setup_diff_pager(struct diff_options *opt)
 	 * --exit-code" in hooks and other scripts, we do not do so.
 	 */
 	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
-	    check_pager_config("diff") != 0)
-		setup_pager();
+	    check_pager_config("diff", 1) != 0)
+		setup_pager(1);
 }
diff --git a/git.c b/git.c
index 61df78afc8..2b007b83ec 100644
--- a/git.c
+++ b/git.c
@@ -61,13 +61,13 @@ static void restore_env(int external_alias)
 	}
 }
 
-static void commit_pager_choice(void) {
+static void commit_pager_choice(int discover_git_dir) {
 	switch (use_pager) {
 	case 0:
 		setenv("GIT_PAGER", "cat", 1);
 		break;
 	case 1:
-		setup_pager();
+		setup_pager(discover_git_dir);
 		break;
 	default:
 		break;
@@ -261,7 +261,7 @@ static int handle_alias(int *argcp, const char ***argv)
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
 
-			commit_pager_choice();
+			commit_pager_choice(1);
 			restore_env(1);
 
 			child.use_shell = 1;
@@ -349,7 +349,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		}
 
 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
-			use_pager = check_pager_config(p->cmd);
+			use_pager = check_pager_config(p->cmd, !(p->option & CREATES_GIT_DIR));
 		if (use_pager == -1 && p->option & USE_PAGER)
 			use_pager = 1;
 
@@ -357,7 +357,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
 			trace_repo_setup(prefix);
 	}
-	commit_pager_choice();
+	commit_pager_choice(!(p->option & CREATES_GIT_DIR));
 
 	if (!help && get_super_prefix()) {
 		if (!(p->option & SUPPORT_SUPER_PREFIX))
@@ -584,8 +584,8 @@ static void execv_dashed_external(const char **argv)
 		die("%s doesn't support --super-prefix", argv[0]);
 
 	if (use_pager == -1)
-		use_pager = check_pager_config(argv[0]);
-	commit_pager_choice();
+		use_pager = check_pager_config(argv[0], 1);
+	commit_pager_choice(1);
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);
 
@@ -688,7 +688,7 @@ int cmd_main(int argc, const char **argv)
 		skip_prefix(argv[0], "--", &argv[0]);
 	} else {
 		/* The user didn't specify a command; give them help */
-		commit_pager_choice();
+		commit_pager_choice(1);
 		printf("usage: %s\n\n", git_usage_string);
 		list_common_cmds_help();
 		printf("\n%s\n", _(git_more_info_string));
diff --git a/pager.c b/pager.c
index 73ca8bc3b1..16b3cbe232 100644
--- a/pager.c
+++ b/pager.c
@@ -43,7 +43,7 @@ static int core_pager_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
-const char *git_pager(int stdout_is_tty)
+const char *git_pager(int stdout_is_tty, int discover_git_dir)
 {
 	const char *pager;
 
@@ -53,7 +53,8 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			read_early_config(core_pager_config, NULL);
+			read_early_config(core_pager_config, NULL,
+					  discover_git_dir);
 		pager = pager_program;
 	}
 	if (!pager)
@@ -100,9 +101,9 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	setup_pager_env(&pager_process->env_array);
 }
 
-void setup_pager(void)
+void setup_pager(int discover_git_dir)
 {
-	const char *pager = git_pager(isatty(1));
+	const char *pager = git_pager(isatty(1), discover_git_dir);
 
 	if (!pager)
 		return;
@@ -208,7 +209,7 @@ static int pager_command_config(const char *var, const char *value, void *vdata)
 }
 
 /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
-int check_pager_config(const char *cmd)
+int check_pager_config(const char *cmd, int discover_git_dir)
 {
 	struct pager_command_config_data data;
 
@@ -216,7 +217,7 @@ int check_pager_config(const char *cmd)
 	data.want = -1;
 	data.value = NULL;
 
-	read_early_config(pager_command_config, &data);
+	read_early_config(pager_command_config, &data, discover_git_dir);
 
 	if (data.value)
 		pager_program = data.value;
-- 
2.11.0.rc3.windows.1


