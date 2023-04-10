Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D905FC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDJJJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDJJI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 05:08:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967E2107
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:52 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o6-20020a05600c4fc600b003ef6e6754c5so122678wmq.5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681117731;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9TV5xTOxxtQiNEoRnznl6JOx1rqM9SkB54xmzHp5aY=;
        b=XwgbIoyC8l5Q4X/LyFfewifOBGbOWaXO1XBKNC9e/1hYECdL3niVsz4Um1ED25MHmu
         7DUGJLNUbqCiWieVuH89cBvWMkfAkeVPNexOVbpr2R+vWR8JnHkld4zKkHiozegTTzdS
         /mnqwLVjonAyvtjrdDQRZAp+pKN2qJtouZQ8crJB/Y6mmzo0vVhf8WPPLYdk0Sn4QtkB
         K1QCX4jfKa7L41wgQuU8i5FAagQLZoXWk4VGLu1WQ9VkAdi4XzUJs/EZ1PoVOmsBkpmx
         AlM6FHKQbXUd78YrccNcjJw4/4WdOg2CyPI9X7TWzCQ7VvXU3OQ1aQCsbAXnFQJvp4ol
         65hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681117731;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9TV5xTOxxtQiNEoRnznl6JOx1rqM9SkB54xmzHp5aY=;
        b=qYTtoz/wAFs89quL1cntF8XpKEUHDlV3cpZHIk7GZQG8Ipn+nPDMLGE4al6o9UmecI
         5U94wr8mSPdbO0r1PZG/WzEBb9DEpaOKuDpwEJxzqLQuSKMqKuL9amAzS1e9smEvdFz4
         jjwkXkAX8xlA9KBIyjfv9IO7eYcGece8kd5+B6xT8vPjvCDRSKnmv06Uy1KpqJVMMDUy
         7VZ/5xNm7kMYNUzp3bc5nv5y9te+nkNe431Xoo7Wel6KfU6cUG9d+PGheyXOYwvbVqzS
         ZFzUfR2bx/sx7X/kokDnfDF9awKlmPWaeXZUeRSThLNPGCfeuTJkZNNaavnu07MZy1P1
         8vGg==
X-Gm-Message-State: AAQBX9du16gySQQ5S7yLpdIMg3vU+qz99AQLJe9FGE81LVjEVmkFFtsY
        3koUTvq95MCrxf7UfvX2IvI1BkFhMCA=
X-Google-Smtp-Source: AKy350bqpAbNDNu0kQSa5mGmE7pM06dB1R+9IatXEC2KFQThK30x5fFRPPqmS5MoAYBWZ1QEG5Lc4A==
X-Received: by 2002:a05:600c:2316:b0:3ef:6fee:803a with SMTP id 22-20020a05600c231600b003ef6fee803amr6483600wmo.35.1681117730999;
        Mon, 10 Apr 2023 02:08:50 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003f034c76e85sm17232568wmg.38.2023.04.10.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:08:50 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/5] sequencer: use struct strvec to store merge strategy options
Date:   Mon, 10 Apr 2023 10:08:28 +0100
Message-Id: <4b288e883d803a75ecd032058d14e9d20eaac9c8.1681117706.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.672.gbd2d2ac924
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The sequencer stores the merge strategy options in an array of strings
which allocated with ALLOC_GROW(). Using "struct strvec" avoids manually
managing the memory of that array and simplifies the code.

Aside from memory allocation the changes to the sequencer are largely
mechanical, changing xopts_nr to xopts.nr and xopts[i] to xopts.v[i]. A
new option parsing macro OPT_STRVEC() is also added to collect the
strategy options.  Hopefully this can be used to simplify the code in
builtin/merge.c in the future.

Note that there is a change of behavior to "git cherry-pick" and "git
revert" as passing “--no-strategy-option” will now clear any previous
strategy options whereas before this change it did nothing.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/revert.c   | 20 +++----------------
 parse-options-cb.c | 16 ++++++++++++++++
 parse-options.h    | 10 ++++++++++
 sequencer.c        | 48 ++++++++++++++++++++--------------------------
 sequencer.h        | 11 ++++++++---
 5 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 62986a7b1b..362857da65 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -44,20 +44,6 @@ static const char * const *revert_or_cherry_pick_usage(struct replay_opts *opts)
 	return opts->action == REPLAY_REVERT ? revert_usage : cherry_pick_usage;
 }
 
-static int option_parse_x(const struct option *opt,
-			  const char *arg, int unset)
-{
-	struct replay_opts **opts_ptr = opt->value;
-	struct replay_opts *opts = *opts_ptr;
-
-	if (unset)
-		return 0;
-
-	ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
-	opts->xopts[opts->xopts_nr++] = xstrdup(arg);
-	return 0;
-}
-
 static int option_parse_m(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -114,8 +100,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
 		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
-		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
-			N_("option for merge strategy"), option_parse_x),
+		OPT_STRVEC('X', "strategy-option", &opts->xopts, N_("option"),
+			N_("option for merge strategy")),
 		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END()
@@ -176,7 +162,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				"--signoff", opts->signoff,
 				"--mainline", opts->mainline,
 				"--strategy", opts->strategy ? 1 : 0,
-				"--strategy-option", opts->xopts ? 1 : 0,
+				"--strategy-option", opts->xopts.nr ? 1 : 0,
 				"-x", opts->record_origin,
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
diff --git a/parse-options-cb.c b/parse-options-cb.c
index d346dbe210..8eb96c5ca9 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -208,6 +208,22 @@ int parse_opt_string_list(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+int parse_opt_strvec(const struct option *opt, const char *arg, int unset)
+{
+	struct strvec *v = opt->value;
+
+	if (unset) {
+		strvec_clear(v);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	strvec_push(v, arg);
+	return 0;
+}
+
 int parse_opt_noop_cb(const struct option *opt, const char *arg, int unset)
 {
 	return 0;
diff --git a/parse-options.h b/parse-options.h
index 26f19384e5..2d1d4d052f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -285,6 +285,15 @@ struct option {
 	.help = (h), \
 	.callback = &parse_opt_string_list, \
 }
+#define OPT_STRVEC(s, l, v, a, h) { \
+	.type = OPTION_CALLBACK, \
+	.short_name = (s), \
+	.long_name = (l), \
+	.value = (v), \
+	.argh = (a), \
+	.help = (h), \
+	.callback = &parse_opt_strvec, \
+}
 #define OPT_UYN(s, l, v, h) { \
 	.type = OPTION_CALLBACK, \
 	.short_name = (s), \
@@ -478,6 +487,7 @@ int parse_opt_commits(const struct option *, const char *, int);
 int parse_opt_commit(const struct option *, const char *, int);
 int parse_opt_tertiary(const struct option *, const char *, int);
 int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_strvec(const struct option *, const char *, int);
 int parse_opt_noop_cb(const struct option *, const char *, int);
 enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const struct option *,
diff --git a/sequencer.c b/sequencer.c
index c35a67e104..50d469812a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -355,9 +355,7 @@ void replay_opts_release(struct replay_opts *opts)
 	free(opts->reflog_action);
 	free(opts->default_strategy);
 	free(opts->strategy);
-	for (size_t i = 0; i < opts->xopts_nr; i++)
-		free(opts->xopts[i]);
-	free(opts->xopts);
+	strvec_clear (&opts->xopts);
 	strbuf_release(&opts->current_fixups);
 	if (opts->revs)
 		release_revisions(opts->revs);
@@ -693,8 +691,8 @@ static int do_recursive_merge(struct repository *r,
 	next_tree = next ? get_commit_tree(next) : empty_tree(r);
 	base_tree = base ? get_commit_tree(base) : empty_tree(r);
 
-	for (i = 0; i < opts->xopts_nr; i++)
-		parse_merge_opt(&o, opts->xopts[i]);
+	for (i = 0; i < opts->xopts.nr; i++)
+		parse_merge_opt(&o, opts->xopts.v[i]);
 
 	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
 		memset(&result, 0, sizeof(result));
@@ -2325,7 +2323,7 @@ static int do_pick_commit(struct repository *r,
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
 		res |= try_merge_command(r, opts->strategy,
-					 opts->xopts_nr, (const char **)opts->xopts,
+					 opts->xopts.nr, opts->xopts.v,
 					common, oid_to_hex(&head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
@@ -2898,8 +2896,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	else if (!strcmp(key, "options.gpg-sign"))
 		git_config_string_dup(&opts->gpg_sign, key, value);
 	else if (!strcmp(key, "options.strategy-option")) {
-		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
-		opts->xopts[opts->xopts_nr++] = xstrdup(value);
+		strvec_push(&opts->xopts, value);
 	} else if (!strcmp(key, "options.allow-rerere-auto"))
 		opts->allow_rerere_auto =
 			git_config_bool_or_int(key, value, &error_flag) ?
@@ -2920,23 +2917,23 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
 	int i;
 	int count;
+	const char **argv;
 	char *strategy_opts_string = raw_opts;
 
 	if (*strategy_opts_string == ' ')
 		strategy_opts_string++;
 
-	count = split_cmdline(strategy_opts_string,
-			      (const char ***)&opts->xopts);
+	count = split_cmdline(strategy_opts_string, &argv);
 	if (count < 0)
 		die(_("could not split '%s': %s"), strategy_opts_string,
 			    split_cmdline_strerror(count));
-	opts->xopts_nr = count;
-	for (i = 0; i < opts->xopts_nr; i++) {
-		const char *arg = opts->xopts[i];
+	for (i = 0; i < count; i++) {
+		const char *arg = argv[i];
 
 		skip_prefix(arg, "--", &arg);
-		opts->xopts[i] = xstrdup(arg);
+		strvec_push(&opts->xopts, arg);
 	}
+	free(argv);
 }
 
 static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
@@ -3055,8 +3052,8 @@ static void write_strategy_opts(struct replay_opts *opts)
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (i = 0; i < opts->xopts_nr; ++i)
-		strbuf_addf(&buf, " --%s", opts->xopts[i]);
+	for (i = 0; i < opts->xopts.nr; ++i)
+		strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
 
 	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
 	strbuf_release(&buf);
@@ -3080,7 +3077,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
 		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
-	if (opts->xopts_nr > 0)
+	if (opts->xopts.nr > 0)
 		write_strategy_opts(opts);
 
 	if (opts->allow_rerere_auto == RERERE_AUTOUPDATE)
@@ -3464,13 +3461,10 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->gpg_sign)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.gpg-sign", opts->gpg_sign);
-	if (opts->xopts) {
-		int i;
-		for (i = 0; i < opts->xopts_nr; i++)
-			res |= git_config_set_multivar_in_file_gently(opts_file,
-					"options.strategy-option",
-					opts->xopts[i], "^$", 0);
-	}
+	for (size_t i = 0; i < opts->xopts.nr; i++)
+		res |= git_config_set_multivar_in_file_gently(opts_file,
+				"options.strategy-option",
+				opts->xopts.v[i], "^$", 0);
 	if (opts->allow_rerere_auto)
 		res |= git_config_set_in_file_gently(opts_file,
 				"options.allow-rerere-auto",
@@ -3880,7 +3874,7 @@ static int do_merge(struct repository *r,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
-	const char *strategy = !opts->xopts_nr &&
+	const char *strategy = !opts->xopts.nr &&
 		(!opts->strategy ||
 		 !strcmp(opts->strategy, "recursive") ||
 		 !strcmp(opts->strategy, "ort")) ?
@@ -4063,9 +4057,9 @@ static int do_merge(struct repository *r,
 			strvec_push(&cmd.args, "octopus");
 		else {
 			strvec_push(&cmd.args, strategy);
-			for (k = 0; k < opts->xopts_nr; k++)
+			for (k = 0; k < opts->xopts.nr; k++)
 				strvec_pushf(&cmd.args,
-					     "-X%s", opts->xopts[k]);
+					     "-X%s", opts->xopts.v[k]);
 		}
 		if (!(flags & TODO_EDIT_MERGE_MSG))
 			strvec_push(&cmd.args, "--no-edit");
diff --git a/sequencer.h b/sequencer.h
index 33dbaf5b66..8a79d6b200 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -2,6 +2,7 @@
 #define SEQUENCER_H
 
 #include "strbuf.h"
+#include "strvec.h"
 #include "wt-status.h"
 
 struct commit;
@@ -60,8 +61,7 @@ struct replay_opts {
 	/* Merge strategy */
 	char *default_strategy;  /* from config options */
 	char *strategy;
-	char **xopts;
-	size_t xopts_nr, xopts_alloc;
+	struct strvec xopts;
 
 	/* Reflog */
 	char *reflog_action;
@@ -80,7 +80,12 @@ struct replay_opts {
 	/* Private use */
 	const char *reflog_message;
 };
-#define REPLAY_OPTS_INIT { .edit = -1, .action = -1, .current_fixups = STRBUF_INIT }
+#define REPLAY_OPTS_INIT {			\
+	.edit = -1,				\
+	.action = -1,				\
+	.current_fixups = STRBUF_INIT,		\
+	.xopts = STRVEC_INIT,			\
+}
 
 /*
  * Note that ordering matters in this enum. Not only must it match the mapping
-- 
2.40.0.672.gbd2d2ac924

