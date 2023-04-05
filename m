Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EC5C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbjDEPWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjDEPWU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:22:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051CDE5
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:22:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v6-20020a05600c470600b003f034269c96so11973285wmo.4
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680708135;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcatT263DOhvNCtAiVZikVBoftCVSx6t9jACkDD5x8o=;
        b=UoItyc8oYr2W0oj1jAScNCkVdUlTA5snkT+9OPT2hrVhcZBxWw+Zcy4Hs1lymMAnHU
         /1n8Fld04XrF8D1QXKQtEvQ75A0v7KAbsCjwmyAnam7xzPd8l7PPQoVvsIopdIWAQsVg
         SfDMLrQgFicdL4D7/vBnxlF62saPN7WTO5pEHtBV4y9uZeDXnfTHi9qOK6tg4Fnjh99v
         0gGJOEZLkshZAi0GSGJbipkFYcPCEf6QXZGNrPxa863jy6R/54+6tQUMgyf+DPLzMePo
         tpg9506etz+sAkvPg3jhRvEHXB2v69MyOWaKrsGiy0nFm9XEo1HWlLhJR2kG0nLa06un
         fs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708135;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcatT263DOhvNCtAiVZikVBoftCVSx6t9jACkDD5x8o=;
        b=KVuqUhXbaAThzuvWSexpUAFdE8EHMsqgJ1u8GFTeLTv7oVNF2pkV0QZJokRYsRADht
         aB6yrJkbJhzGqaSrM5jyp56Q5Jgtldbjt1dgHaQrSHCueKkxQbb4VCcWcEYNVB1UR5hr
         2UEcEYwwamE+b5HecFgsMoAmS5S89skwcyRm9+u9XxTk0n8WmvN+yytN6Y2XLBspwhy+
         yn2N1Iy8li1Yzb/CAVQ1jgefX7/dYGTx+cXdIiABm+R3+Vp0c6h4C+NIHNtpv21eaxxg
         G9pNMfBLLoLtXHo3bxOsMGJw6NyOawAmx6KsWQRZjg13/ebqE2/rmPSR3DlF5RKzJMoE
         NV6g==
X-Gm-Message-State: AAQBX9e0OYyxXXMft/Vakkxczxt8EPHzTBy/THFIPx+hAFsbWcIWA3bo
        iqvWoDr74hl2OT93lL/+WhmLAzDYB6g=
X-Google-Smtp-Source: AKy350YXTJoEec92v0a3q+ctZqxoYoeS4ehwhFN0sIwpfO51LEJ+ZDj5FQf4XZyhyeTGBSu3HXlcQg==
X-Received: by 2002:a1c:f216:0:b0:3ee:4ff0:83d6 with SMTP id s22-20020a1cf216000000b003ee4ff083d6mr5113003wmc.40.1680708135220;
        Wed, 05 Apr 2023 08:22:15 -0700 (PDT)
Received: from localhost.localdomain ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003edc11c2ecbsm2515610wmj.4.2023.04.05.08.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:22:14 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/5] sequencer: use struct strvec to store merge strategy options
Date:   Wed,  5 Apr 2023 16:21:45 +0100
Message-Id: <dd7b82cdd54cc962385dff8a1adab4c1d4fb2167.1680708043.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.40.0.670.g64ef305212.dirty
In-Reply-To: <cover.1680708043.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1680708043.git.phillip.wood@dunelm.org.uk>
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

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/revert.c   | 20 +++-----------------
 parse-options-cb.c | 16 ++++++++++++++++
 parse-options.h    | 10 ++++++++++
 sequencer.c        | 47 ++++++++++++++++++++--------------------------
 sequencer.h        | 11 ++++++++---
 5 files changed, 57 insertions(+), 47 deletions(-)

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
index c35a67e104..6e2f3357c8 100644
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
@@ -2920,22 +2917,21 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
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
 }
 
@@ -3055,8 +3051,8 @@ static void write_strategy_opts(struct replay_opts *opts)
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (i = 0; i < opts->xopts_nr; ++i)
-		strbuf_addf(&buf, " --%s", opts->xopts[i]);
+	for (i = 0; i < opts->xopts.nr; ++i)
+		strbuf_addf(&buf, " --%s", opts->xopts.v[i]);
 
 	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
 	strbuf_release(&buf);
@@ -3080,7 +3076,7 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
 		write_file(rebase_path_strategy(), "%s\n", opts->strategy);
-	if (opts->xopts_nr > 0)
+	if (opts->xopts.nr > 0)
 		write_strategy_opts(opts);
 
 	if (opts->allow_rerere_auto == RERERE_AUTOUPDATE)
@@ -3464,13 +3460,10 @@ static int save_opts(struct replay_opts *opts)
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
@@ -3880,7 +3873,7 @@ static int do_merge(struct repository *r,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
-	const char *strategy = !opts->xopts_nr &&
+	const char *strategy = !opts->xopts.nr &&
 		(!opts->strategy ||
 		 !strcmp(opts->strategy, "recursive") ||
 		 !strcmp(opts->strategy, "ort")) ?
@@ -4063,9 +4056,9 @@ static int do_merge(struct repository *r,
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
2.40.0.670.g64ef305212.dirty

