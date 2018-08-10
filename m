Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16791F405
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeHJTXU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32979 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbeHJTXU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so8890460wrp.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yk2EtssYf2vuPsuAqWEkf5rzaDvPWgrj/3k9n3mf+Mg=;
        b=sANCrThZnnmkiPASlP6CUb0LwBboLndSDfyK9zAqiMoeGLJZ7p9ADQjGeWuT+qIbqW
         zPTGGjW8QTAXJrrWawxuzkfkK92rBfXevbZ5AoBp1V5vl8UO87OUsfIyIo3blspFBUdP
         3x4GYin5sgdGakHuTUyLIIP+QVgrqNyGA1UHtT9vjL4J+P13e2YuglDQXEJ4kzbQp///
         x+CS2rmt1Z9UiwXnwcDu0xh6CxBCL4bewtwSruCPrqVu/CkJBlXntO7mUK4MiMVZpow0
         t4pzJOI+JoM0ZfPr5o7i73TWTczs/mmMI6uupUZ6ihjvios4WzjvruKt+jW0oOkNGF/A
         jtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yk2EtssYf2vuPsuAqWEkf5rzaDvPWgrj/3k9n3mf+Mg=;
        b=H7GJmgZD1Aud3z2TsE5atNSGHOzjrbXJsuw/YGW7mTwuEB258Vbk2lO1Jg+rclVa/G
         uYhJGJKIRAXXAEWEc+eJFjp3p+colgLQ9qdwKtviP8Y8HNH9fe3q64PCPQhhkat//0/0
         JhBWHsV+iJD+dIp/fcpwAh7138eEG/YLFyogBCDluq9qpKrxTsDduaAHuLukzJRdXVlj
         NldElmYlRjIUcErnM7fxHMwBDcuM/RYxWAqe1Nes436T0OWnutuaBm/MSV2iL0EnETT0
         Bo45NDcHPuTSDVAB5/RhZPk2lZrln8EsNPACvV56kpTTEp2gFsSq8myUGMHTTcY8Iw2D
         oh0w==
X-Gm-Message-State: AOUpUlE/iUuw/z6YbnXTPT9gJyignORzYDucvQy0HZnXYj73qgm2TECj
        WpCCrfvAXNDHPy8Vw3j210wUHOQI
X-Google-Smtp-Source: AA+uWPyB86pIPvDQEumsT7aOaFmkgnuJ+BuRjdwShnbURgz9CNskB+fOx37MpnVAcrid29JHrFXdtw==
X-Received: by 2002:adf:e24d:: with SMTP id n13-v6mr4880038wri.205.1533919959251;
        Fri, 10 Aug 2018 09:52:39 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:38 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 15/20] rebase -i: rewrite write_basic_state() in C
Date:   Fri, 10 Aug 2018 18:51:42 +0200
Message-Id: <20180810165147.4779-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites write_basic_state() from git-rebase.sh in C.  This is the
first step in the conversion of init_basic_state(), hence the mode in
rebase--helper.c is called INIT_BASIC_STATE.  init_basic_state() will be
converted in the next commit.

The part of read_strategy_opts() that parses the stategy options is
moved to a new function to allow its use in rebase--helper.c.

Finally, the call to write_basic_state() is removed from
git-rebase--interactive.sh, replaced by a call to `--init-basic-state`.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v5.

 builtin/rebase--helper.c   | 28 +++++++++++++-
 git-rebase--interactive.sh |  7 +++-
 sequencer.c                | 77 ++++++++++++++++++++++++++++++++------
 sequencer.h                |  4 ++
 4 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 0716bbfd78..63c5086e42 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -5,6 +5,8 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "argv-array.h"
+#include "rerere.h"
+#include "alias.h"
 
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 
@@ -53,11 +55,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1, ret;
 	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
-		*squash_onto = NULL, *upstream = NULL;
+		*squash_onto = NULL, *upstream = NULL, *head_name = NULL;
+	char *raw_strategies = NULL;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
-		COMPLETE_ACTION
+		COMPLETE_ACTION, INIT_BASIC_STATE
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -69,6 +72,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			 N_("keep original branch points of cousins")),
 		OPT_BOOL(0, "autosquash", &autosquash,
 			 N_("move commits that begin with squash!/fixup!")),
+		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
@@ -93,6 +97,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "complete-action", &command,
 			    N_("complete the action"), COMPLETE_ACTION),
+		OPT_CMDMODE(0, "init-basic-state", &command,
+			    N_("initialise the rebase state"), INIT_BASIC_STATE),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -100,6 +106,14 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			   N_("squash onto")),
 		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
 			   N_("the upstream commit")),
+		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
+		OPT_STRING('S', "gpg-sign", &opts.gpg_sign, N_("gpg-sign"),
+			   N_("GPG-sign commits")),
+		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
+			   N_("rebase strategy")),
+		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
+			   N_("strategy options")),
+		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
 		OPT_END()
 	};
 
@@ -176,6 +190,16 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		free(shortrevisions);
 		return !!ret;
 	}
+	if (command == INIT_BASIC_STATE) {
+		if (raw_strategies)
+			parse_strategy_opts(&opts, raw_strategies);
+
+		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, NULL);
+		if (ret)
+			return ret;
+
+		return !!write_basic_state(&opts, head_name, onto, head_hash);
+	}
 
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 08e9a21c2f..6367da66e2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -57,7 +57,6 @@ init_basic_state () {
 	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
 	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-	write_basic_state
 }
 
 git_rebase__interactive () {
@@ -70,6 +69,12 @@ git_rebase__interactive () {
 	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
+	git rebase--helper --init-basic-state ${upstream:+--upstream "$upstream"} \
+		${onto:+--onto "$onto"} ${head_name:+--head-name "$head_name"} \
+		${verbose:+--verbose} ${strategy:+--strategy "$strategy"} \
+		${strategy_opts:+--strategy-opts="$strategy_opts"} \
+		"$allow_rerere_autoupdate" "$gpg_sign_opt" "$signoff" || exit
+
 	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
 		${rebase_merges:+--rebase-merges} \
 		${rebase_cousins:+--rebase-cousins} \
diff --git a/sequencer.c b/sequencer.c
index 3800439c10..beff749904 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -144,7 +144,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
 
 /*
  * The following files are written by git-rebase just after parsing the
- * command-line (and are only consumed, not modified, by the sequencer).
+ * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
@@ -156,6 +156,7 @@ static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
 static GIT_PATH_FUNC(rebase_path_strategy, "rebase-merge/strategy")
 static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
 static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
+static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 
 static int git_sequencer_config(const char *k, const char *v, void *cb)
 {
@@ -2205,21 +2206,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
+void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
 	int i;
-	char *strategy_opts_string;
+	char *strategy_opts_string = raw_opts;
 
-	strbuf_reset(buf);
-	if (!read_oneliner(buf, rebase_path_strategy(), 0))
-		return;
-	opts->strategy = strbuf_detach(buf, NULL);
-	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
-		return;
-
-	strategy_opts_string = buf->buf;
 	if (*strategy_opts_string == ' ')
 		strategy_opts_string++;
+
 	opts->xopts_nr = split_cmdline(strategy_opts_string,
 				       (const char ***)&opts->xopts);
 	for (i = 0; i < opts->xopts_nr; i++) {
@@ -2230,6 +2224,18 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
 	}
 }
 
+static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
+{
+	strbuf_reset(buf);
+	if (!read_oneliner(buf, rebase_path_strategy(), 0))
+		return;
+	opts->strategy = strbuf_detach(buf, NULL);
+	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
+		return;
+
+	parse_strategy_opts(opts, buf->buf);
+}
+
 static int read_populate_opts(struct replay_opts *opts)
 {
 	if (is_rebase_i(opts)) {
@@ -2297,6 +2303,55 @@ static int read_populate_opts(struct replay_opts *opts)
 	return 0;
 }
 
+static void write_strategy_opts(struct replay_opts *opts)
+{
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+
+	for (i = 0; i < opts->xopts_nr; ++i)
+		strbuf_addf(&buf, " --%s", opts->xopts[i]);
+
+	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
+	strbuf_release(&buf);
+}
+
+int write_basic_state(struct replay_opts *opts, const char *head_name,
+		      const char *onto, const char *orig_head)
+{
+	const char *quiet = getenv("GIT_QUIET");
+
+	if (head_name)
+		write_file(rebase_path_head_name(), "%s\n", head_name);
+	if (onto)
+		write_file(rebase_path_onto(), "%s\n", onto);
+	if (orig_head)
+		write_file(rebase_path_orig_head(), "%s\n", orig_head);
+
+	if (quiet)
+		write_file(rebase_path_quiet(), "%s\n", quiet);
+	else
+		write_file(rebase_path_quiet(), "\n");
+
+	if (opts->verbose)
+		write_file(rebase_path_verbose(), "");
+	if (opts->strategy)
+		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
+	if (opts->xopts_nr > 0)
+		write_strategy_opts(opts);
+
+	if (opts->allow_rerere_auto == RERERE_AUTOUPDATE)
+		write_file(rebase_path_allow_rerere_autoupdate(), "--rerere-autoupdate\n");
+	else if (opts->allow_rerere_auto == RERERE_NOAUTOUPDATE)
+		write_file(rebase_path_allow_rerere_autoupdate(), "--no-rerere-autoupdate\n");
+
+	if (opts->gpg_sign)
+		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
+	if (opts->signoff)
+		write_file(rebase_path_signoff(), "--signoff\n");
+
+	return 0;
+}
+
 static int walk_revs_populate_todo(struct todo_list *todo_list,
 				struct replay_opts *opts)
 {
diff --git a/sequencer.h b/sequencer.h
index 02e3d7940e..aab280f276 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -119,3 +119,7 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
 void print_commit_summary(const char *prefix, const struct object_id *oid,
 			  unsigned int flags);
 #endif
+
+void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
+int write_basic_state(struct replay_opts *opts, const char *head_name,
+		      const char *onto, const char *orig_head);
-- 
2.18.0

