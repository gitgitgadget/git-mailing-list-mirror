Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C371F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeGaTmR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39156 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbeGaTmR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so4100055wmb.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQpEnu0cUIM4OA6lWhKsJCbmgUKYkeJaIoOYloBzFqg=;
        b=fpuCXGX6XFAVIwhRgPziFtDLEiOVLO67hy7uX9dV+2ebmEwSYV0+32r/kBotVb8r+p
         82mcbh+KhF5qxJEpeK+wIZh0N9zHxZlq64fO6NHt4ZFTNNvtejnfyafT6ATURecHcGe9
         oy/mz+e/NmAFl2JvgrsOKCQEglxpO1KlfvnE++Mi9kG8I1LrvFDRA+Cuz3nuxHTXDlnz
         C9lg75vUgQ3ekRj4G5Y7cPJHpxds3bL/Kc+pQMQKWxRAPzpXsgnI3Ehz7gc2a3vhoSNU
         LesD41QIiDCgxni8D3jM1M8iGxQ6NdND/N64rCUXf3ombFAghxCXjYPJse6s7vd1h5mm
         pX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQpEnu0cUIM4OA6lWhKsJCbmgUKYkeJaIoOYloBzFqg=;
        b=nAVvczV3WlwnMWIZOt6/giniSaon25qUeIc+6vjvqbklTruaT1UMKtEcEMq6FEfaZz
         TUx0o+xRFviSLnOxjxo17dpUoEixfvMVIQy9FOnJHjRUjhN7LQ3g6myuHhlIzusMf4Uj
         /5mh5Po4zaQ6RnfMKPzMn6RBoQCwtHW7V+sFd7wyfYr7UhqATWcZUWE3U98ftm6ryloN
         U1LbcvzdH2/iOFDT2lSfyypEerUS1UtvUoXJef+Kjw76v1wGgzxEWIel4G7zX7zbQGtm
         3mbn8z5lFYe/eWicUxEJzq7JOh5npO9Gg3MkdA59J6frQ/XTjY9BhgA6P0dLToeKIPuh
         cH2A==
X-Gm-Message-State: AOUpUlF2+7bnmL2dUTao5aG4FG0+xY9tmrBiubF+djzy2PlQukiHrBhn
        RxHC/DSKMQiL/9maAiwljIivL1un
X-Google-Smtp-Source: AAOMgpddX5Ftomj207zZ/znvoxXaovgNKVMIVLzfEM//e33x1wvHSwN/Lc2IngdngutmenR0BQnj3Q==
X-Received: by 2002:a1c:864c:: with SMTP id i73-v6mr520394wmd.40.1533060047069;
        Tue, 31 Jul 2018 11:00:47 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:46 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 17/20] rebase -i: implement the main part of interactive rebase as a builtin
Date:   Tue, 31 Jul 2018 20:00:00 +0200
Message-Id: <20180731180003.5421-18-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the part of interactive rebase which initializes the
basic state, make the script and complete the action, as a buitin, named
git-rebase--interactive2 for now.  Others modes (`--continue`,
`--edit-todo`, etc.) will be rewritten in the next commit.

git-rebase--interactive.sh is modified to call git-rebase--interactive2
instead of git-rebase--helper.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 .gitignore                     |   1 +
 Makefile                       |   1 +
 builtin.h                      |   1 +
 builtin/rebase--interactive2.c | 200 +++++++++++++++++++++++++++++++++
 git-rebase--interactive.sh     |  41 +++----
 git.c                          |   1 +
 6 files changed, 226 insertions(+), 19 deletions(-)
 create mode 100644 builtin/rebase--interactive2.c

diff --git a/.gitignore b/.gitignore
index 3284a1e9b1..404c9a8472 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
+/git-rebase--interactive2
 /git-rebase--merge
 /git-rebase--preserve-merges
 /git-receive-pack
diff --git a/Makefile b/Makefile
index 909a687857..71f8f45fe5 100644
--- a/Makefile
+++ b/Makefile
@@ -1060,6 +1060,7 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase--interactive2.o
 BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index 0362f1ce25..ed89b4f495 100644
--- a/builtin.h
+++ b/builtin.h
@@ -202,6 +202,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase--interactive2.c b/builtin/rebase--interactive2.c
new file mode 100644
index 0000000000..e89ef71499
--- /dev/null
+++ b/builtin/rebase--interactive2.c
@@ -0,0 +1,200 @@
+#include "builtin.h"
+#include "cache.h"
+#include "config.h"
+#include "parse-options.h"
+#include "sequencer.h"
+#include "rebase-interactive.h"
+#include "argv-array.h"
+#include "refs.h"
+#include "rerere.h"
+#include "run-command.h"
+
+static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
+static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
+static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
+
+static int get_revision_ranges(const char *upstream, const char *onto,
+			       const char **head_hash,
+			       char **revisions, char **shortrevisions)
+{
+	const char *base_rev = upstream ? upstream : onto, *shorthead;
+	struct object_id orig_head;
+
+	if (get_oid("HEAD", &orig_head))
+		return error(_("no HEAD?"));
+
+	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
+
+	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
+
+	if (upstream) {
+		const char *shortrev;
+		struct object_id rev_oid;
+
+		get_oid(base_rev, &rev_oid);
+		shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
+
+		*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
+	} else
+		*shortrevisions = xstrdup(shorthead);
+
+	return 0;
+}
+
+static int init_basic_state(struct replay_opts *opts, const char *head_name,
+			    const char *onto, const char *orig_head)
+{
+	FILE *interactive;
+
+	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
+		return error_errno(_("could not create temporary %s"), path_state_dir());
+
+	delete_reflog("REBASE_HEAD");
+
+	interactive = fopen(path_interactive(), "w");
+	if (!interactive)
+		return error_errno(_("could not mark as interactive"));
+	fclose(interactive);
+
+	return write_basic_state(opts, head_name, onto, orig_head);
+}
+
+static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
+				 const char *switch_to, const char *upstream,
+				 const char *onto, const char *onto_name,
+				 const char *squash_onto, const char *head_name,
+				 const char *restrict_revision, char *raw_strategies,
+				 const char *cmd, unsigned autosquash)
+{
+	int ret;
+	const char *head_hash = NULL;
+	char *revisions = NULL, *shortrevisions = NULL;
+	struct argv_array make_script_args = ARGV_ARRAY_INIT;
+	FILE *todo_list;
+
+	if (prepare_branch_to_be_rebased(opts, switch_to))
+		return 1;
+
+	if (get_revision_ranges(upstream, onto, &head_hash,
+				&revisions, &shortrevisions))
+		return 1;
+
+	if (raw_strategies)
+		parse_strategy_opts(opts, raw_strategies);
+
+	if (init_basic_state(opts, head_name, onto, head_hash)) {
+		free(revisions);
+		free(shortrevisions);
+
+		return 1;
+	}
+
+	if (!upstream && squash_onto)
+		write_file(path_squash_onto(), "%s\n", squash_onto);
+
+	todo_list = fopen(rebase_path_todo(), "w");
+	if (!todo_list) {
+		free(revisions);
+		free(shortrevisions);
+
+		return error_errno(_("could not open %s"), rebase_path_todo());
+	}
+
+	argv_array_pushl(&make_script_args, "", revisions, NULL);
+	if (restrict_revision)
+		argv_array_push(&make_script_args, restrict_revision);
+
+	ret = sequencer_make_script(todo_list,
+				    make_script_args.argc, make_script_args.argv,
+				    flags);
+	fclose(todo_list);
+
+	if (ret)
+		error(_("could not generate todo list"));
+	else {
+		discard_cache();
+		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
+				      head_hash, cmd, autosquash);
+	}
+
+	free(revisions);
+	free(shortrevisions);
+	argv_array_clear(&make_script_args);
+
+	return ret;
+}
+
+static const char * const builtin_rebase_interactive_usage[] = {
+	N_("git rebase--interactive [<options>]"),
+	NULL
+};
+
+int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
+{
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
+	int abbreviate_commands = 0, rebase_cousins = -1;
+	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
+		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
+		*switch_to = NULL, *cmd = NULL;
+	char *raw_strategies = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
+		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
+		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
+			 N_("allow commits with empty messages")),
+		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
+		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
+			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits that begin with squash!/fixup!")),
+		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
+		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
+		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
+		OPT_STRING(0, "restrict-revision", &restrict_revision,
+			   N_("restrict-revision"), N_("restrict revision")),
+		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
+			   N_("squash onto")),
+		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
+			   N_("the upstream commit")),
+		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
+		OPT_STRING('S', "gpg-sign", &opts.gpg_sign, N_("gpg-sign"),
+			   N_("GPG-sign commits")),
+		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
+			   N_("rebase strategy")),
+		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
+			   N_("strategy options")),
+		OPT_STRING(0, "switch-to", &switch_to, N_("switch-to"),
+			   N_("the branch or commit to checkout")),
+		OPT_STRING(0, "onto-name", &onto_name, N_("onto-name"), N_("onto name")),
+		OPT_STRING(0, "cmd", &cmd, N_("cmd"), N_("the command to run")),
+		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
+		OPT_END()
+	};
+
+	sequencer_init_config(&opts);
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
+
+	opts.action = REPLAY_INTERACTIVE_REBASE;
+	opts.allow_ff = 1;
+	opts.allow_empty = 1;
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
+
+	opts.gpg_sign = xstrdup_or_null(opts.gpg_sign);
+
+	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
+	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
+	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+
+	if (rebase_cousins >= 0 && !rebase_merges)
+		warning(_("--[no-]rebase-cousins has no effect without "
+			  "--rebase-merges"));
+
+	return !!do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
+				       onto_name, squash_onto, head_name, restrict_revision,
+				       raw_strategies, cmd, autosquash);
+}
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 761be95ed1..e87d708a4d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -58,24 +58,27 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
+	test -n "$keep_empty" && keep_empty="--keep-empty"
+	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
+	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
+	test -n "$autosquash" && autosquash="--autosquash"
+	test -n "$verbose" && verbose="--verbose"
+	test -n "$force_rebase" && force_rebase="--no-ff"
+	test -n "$restrict_revisions" && restrict_revisions="--restrict-revisions=^$restrict_revisions"
+	test -n "$upstream" && upstream="--upstream=$upstream"
+	test -n "$onto" && onto="--onto=$onto"
+	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
+	test -n "$onto_name" && onto_name="--onto-name=$onto_name"
+	test -n "$head_name" && head_name="--head-name=$head_name"
+	test -n "$strategy" && strategy="--strategy=$strategy"
+	test -n "$strategy_opts" && strategy_opts="--strategy-opts=$strategy_opts"
+	test -n "$switch_to" && switch_to="--switch-to=$switch_to"
+	test -n "$cmd" && cmd="--cmd=$cmd"
 
-	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
-		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
-		${verbose:+--verbose} ${strategy:+--strategy "$strategy"} \
-		${strategy_opts:+--strategy-opts="$strategy_opts"} \
-		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff" || exit
-
-	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		${rebase_merges:+--rebase-merges} \
-		${rebase_cousins:+--rebase-cousins} \
-		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"} \
-		${squash_onto:+--squash-onto "$squash_onto"} \
-		${restrict_revision:+--restrict-revision ^"$restrict_revision"} >"$todo" ||
-	die "$(gettext "Could not generate todo list")"
-
-	exec git rebase--helper --complete-action "$onto_name" "$cmd" \
-		$allow_empty_message ${autosquash:+--autosquash} ${verbose:+--verbose} \
-		${keep_empty:+--keep-empty} ${force_rebase:+--no-ff} \
-		${upstream:+--upstream "$upstream"} ${onto:+--onto "$onto"}
+	exec git rebase--interactive2 "$keep_empty" "$rebase_merges" "$rebase_cousins" \
+		"$upstream" "$onto" "$squash_onto" "$restrict_revision" \
+		"$allow_empty_message" "$autosquash" "$verbose" \
+		"$force_rebase" "$onto_name" "$head_name" "$strategy" \
+		"$strategy_opts" "$cmd" "$switch_to" \
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff"
 }
diff --git a/git.c b/git.c
index 3fded74519..8309fb24a6 100644
--- a/git.c
+++ b/git.c
@@ -518,6 +518,7 @@ static struct cmd_struct commands[] = {
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
+	{ "rebase--interactive2", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
 	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
-- 
2.18.0

