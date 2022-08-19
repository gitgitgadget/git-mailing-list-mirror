Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90511C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353131AbiHSQd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353044AbiHSQa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E311C950
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so6177166edb.9
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7rRWMwg61+/akGSjM8WbBFWtRc5VkdgvCRV6hqHGpI0=;
        b=gjc3eO/8pnvby+tTE+k4Lyo/bm8KUlCtuU4uueDEkOsIEyymqky4Hd9kAEZ5vEHvXP
         bRRIjnodj+f2c/p9Nc+eTJrJ2/9oV0IM+SUvWwGqF9fYzx+NbZQdz6vbbwG+1yqVMACr
         m5sbD/7A8OO9+yt/kC6yJ2UylfDNvJnEpbUmoQYjEZUSf+p150XLJVUNuyA0Qbt45GGc
         tCMyNoFiCZKMTrPQKaszJW39WwdHUCk6cCKit0nuBzZmvzOJtMviyXi6mzq8VOUGcu43
         KnLrCKlzuBx+isFdpie9H2tXvDaXW1eveJwHn+Ki8CN34BvOeXs4KYSFkVKpng6lJqzx
         34DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7rRWMwg61+/akGSjM8WbBFWtRc5VkdgvCRV6hqHGpI0=;
        b=pw7aTthmE4y4a4smpdzouPk8Rakk2BOQ6GKUseOa8cybBlOYf4WdLjBMgkggiQSbi1
         EuKlZdbMSGgZcT2UIbmEXHN+67TKpX8A6nuDiUsFPLZFarSMj4QsC3Gg+87EF0owZv7s
         lbdZ1xcbtXfN+zkhtlqhSr5NDWK2Emdw6Y7ifisVbSPL77REI7xAFXBTDZXdOK6GlKMk
         eQNGcJzSPTLEHyBYkKvW7vNcydarF4OKM8NyVQzpkTdcaN/XSdHP5ypfB1qKee1vVa8a
         WHljB+sNSQDUptrSm3me8otPNhlVYNzubJeWEBxug8TSZGq/QgfNj+ftXN25F+yQGqPk
         N0vQ==
X-Gm-Message-State: ACgBeo3SfwVWIqxkq7l7bUhSTHn7Q+y35yIaIj/laYfND9u/s10PFTGt
        Ut988XyiOboaI0C8exFQpuz8wpEfmVo=
X-Google-Smtp-Source: AA6agR5OgrjrUW8ZUJvrM99+865jkFSwTlUYtSGcD2FOqVCbxiz0aSOArB5W5YBdbmKHtgb0oQ4sIw==
X-Received: by 2002:a05:6402:42cb:b0:43d:bf29:cf89 with SMTP id i11-20020a05640242cb00b0043dbf29cf89mr6518304edc.400.1660925083322;
        Fri, 19 Aug 2022 09:04:43 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id gg23-20020a170906e29700b00732a5b339afsm2567357ejb.92.2022.08.19.09.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/20] parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
Date:   Fri, 19 Aug 2022 18:03:57 +0200
Message-Id: <20220819160411.1791200-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of 'PARSE_OPT_KEEP_UNKNOWN' starts with "Keep unknown
arguments instead of erroring out".  This is a bit misleading, as this
flag only applies to unknown --options, while non-option arguments are
kept even without this flag.

Update the description to clarify this, and rename the flag to
PARSE_OPTIONS_KEEP_UNKNOWN_OPT to make this obvious just by looking at
the flag name.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/technical/api-parse-options.txt | 6 ++++--
 builtin/archive.c                             | 2 +-
 builtin/bisect--helper.c                      | 2 +-
 builtin/difftool.c                            | 2 +-
 builtin/env--helper.c                         | 2 +-
 builtin/fast-export.c                         | 2 +-
 builtin/log.c                                 | 4 ++--
 builtin/reflog.c                              | 4 ++--
 builtin/revert.c                              | 2 +-
 builtin/sparse-checkout.c                     | 4 ++--
 builtin/stash.c                               | 8 ++++----
 diff.c                                        | 2 +-
 parse-options.c                               | 6 +++---
 parse-options.h                               | 2 +-
 t/helper/test-parse-options.c                 | 6 +++---
 t/helper/test-serve-v2.c                      | 2 +-
 t/t0040-parse-options.sh                      | 8 ++++----
 17 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5a04f3daec..4412377fa3 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -90,8 +90,8 @@ Flags are the bitwise-or of:
 	Keep the first argument, which contains the program name.  It's
 	removed from argv[] by default.
 
-`PARSE_OPT_KEEP_UNKNOWN`::
-	Keep unknown arguments instead of erroring out.  This doesn't
+`PARSE_OPT_KEEP_UNKNOWN_OPT`::
+	Keep unknown options instead of erroring out.  This doesn't
 	work for all combinations of arguments as users might expect
 	it to do.  E.g. if the first argument in `--unknown --known`
 	takes a value (which we can't know), the second one is
@@ -101,6 +101,8 @@ Flags are the bitwise-or of:
 	non-option, not as a value belonging to the unknown option,
 	the parser early.  That's why parse_options() errors out if
 	both options are set.
+	Note that non-option arguments are always kept, even without
+	this flag.
 
 `PARSE_OPT_NO_INTERNAL_HELP`::
 	By default, parse_options() handles `-h`, `--help` and
diff --git a/builtin/archive.c b/builtin/archive.c
index 7176b041b6..f094390ee0 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -75,7 +75,7 @@ static int run_remote_archiver(int argc, const char **argv,
 
 #define PARSE_OPT_KEEP_ALL ( PARSE_OPT_KEEP_DASHDASH | 	\
 			     PARSE_OPT_KEEP_ARGV0 | 	\
-			     PARSE_OPT_KEEP_UNKNOWN |	\
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |	\
 			     PARSE_OPT_NO_INTERNAL_HELP	)
 
 int cmd_archive(int argc, const char **argv, const char *prefix)
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8a052c7111..7097750fc6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1324,7 +1324,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
diff --git a/builtin/difftool.c b/builtin/difftool.c
index b3c509b8de..8706f68492 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -716,7 +716,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	symlinks = has_symlinks;
 
 	argc = parse_options(argc, argv, prefix, builtin_difftool_options,
-			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN |
+			     builtin_difftool_usage, PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (tool_help)
diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 27349098b0..ea04c16636 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -50,7 +50,7 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, opts, env__helper_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 	if (env_default && !*env_default)
 		usage_with_options(env__helper_usage, opts);
 	if (!cmdmode)
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e1748fb98b..bf3c20dea2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1221,7 +1221,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.sources = &revision_sources;
 	revs.rewrite_parents = 1;
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
-			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
 	argc = setup_revisions(argc, argv, &revs, NULL);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875..fb84a0d399 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -199,7 +199,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	mailmap = use_mailmap_config;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_log_options, builtin_log_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (quiet)
@@ -1926,7 +1926,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 */
 	argc = parse_options(argc, argv, prefix, builtin_format_patch_options,
 			     builtin_format_patch_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4dd297dce8..b8b1f4f8ea 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -223,7 +223,7 @@ static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
 
 	parse_options(argc, argv, prefix, options, reflog_show_usage,
 		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
-		      PARSE_OPT_KEEP_UNKNOWN);
+		      PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	return cmd_log_reflog(argc, argv, prefix);
 }
@@ -410,7 +410,7 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, reflog_usage,
 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
-			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
 	/*
diff --git a/builtin/revert.c b/builtin/revert.c
index 2554f9099c..ee2a0807f0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -141,7 +141,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 
 	argc = parse_options(argc, argv, NULL, options, usage_str,
 			PARSE_OPT_KEEP_ARGV0 |
-			PARSE_OPT_KEEP_UNKNOWN);
+			PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f91e29b56a..a5e4b95a9d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -767,7 +767,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_add_options,
 			     builtin_sparse_checkout_add_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
 
@@ -813,7 +813,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_set_options,
 			     builtin_sparse_checkout_set_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (update_modes(&set_opts.cone_mode, &set_opts.sparse_index))
 		return 1;
diff --git a/builtin/stash.c b/builtin/stash.c
index 30fa101460..a14e832e9f 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -782,7 +782,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_stash_list_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (!ref_exists(ref_stash))
 		return 0;
@@ -873,7 +873,7 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 	init_revisions(&rev, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_show_usage,
-			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	strvec_push(&revision_args, argv[0]);
@@ -979,7 +979,7 @@ static int store_stash(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_stash_store_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (argc != 1) {
 		if (!quiet)
@@ -1795,7 +1795,7 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 	git_config(git_stash_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_stash_usage,
-			     PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_DASHDASH);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/diff.c b/diff.c
index 974626a621..dd68281ba4 100644
--- a/diff.c
+++ b/diff.c
@@ -5661,7 +5661,7 @@ int diff_opt_parse(struct diff_options *options,
 
 	ac = parse_options(ac, av, prefix, options->parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
-			   PARSE_OPT_KEEP_UNKNOWN |
+			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
diff --git a/parse-options.c b/parse-options.c
index edf55d3ef5..a0a2cf98fa 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -332,7 +332,7 @@ static enum parse_opt_result parse_long_opt(
 			rest = NULL;
 		if (!rest) {
 			/* abbreviated? */
-			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
+			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
 			    !strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option &&
@@ -515,7 +515,7 @@ static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
-	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
+	if ((flags & PARSE_OPT_KEEP_UNKNOWN_OPT) &&
 	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
 	    !(flags & PARSE_OPT_ONE_SHOT))
 		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
@@ -839,7 +839,7 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 unknown:
 		if (ctx->flags & PARSE_OPT_ONE_SHOT)
 			break;
-		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN))
+		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT))
 			return PARSE_OPT_UNKNOWN;
 		ctx->out[ctx->cpidx++] = ctx->argv[0];
 		ctx->opt = NULL;
diff --git a/parse-options.h b/parse-options.h
index 685fccac13..591df64191 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -30,7 +30,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_DASHDASH = 1 << 0,
 	PARSE_OPT_STOP_AT_NON_OPTION = 1 << 1,
 	PARSE_OPT_KEEP_ARGV0 = 1 << 2,
-	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
+	PARSE_OPT_KEEP_UNKNOWN_OPT = 1 << 3,
 	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
 	PARSE_OPT_ONE_SHOT = 1 << 5,
 	PARSE_OPT_SHELL_EVAL = 1 << 6,
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 88919785d3..99ad6fa4f0 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -232,9 +232,9 @@ static const struct option test_flag_options[] = {
 	OPT_BIT(0, "keep-argv0", &test_flags,
 		"pass PARSE_OPT_KEEP_ARGV0 to parse_options()",
 		PARSE_OPT_KEEP_ARGV0),
-	OPT_BIT(0, "keep-unknown", &test_flags,
-		"pass PARSE_OPT_KEEP_UNKNOWN to parse_options()",
-		PARSE_OPT_KEEP_UNKNOWN),
+	OPT_BIT(0, "keep-unknown-opt", &test_flags,
+		"pass PARSE_OPT_KEEP_UNKNOWN_OPT to parse_options()",
+		PARSE_OPT_KEEP_UNKNOWN_OPT),
 	OPT_BIT(0, "no-internal-help", &test_flags,
 		"pass PARSE_OPT_NO_INTERNAL_HELP to parse_options()",
 		PARSE_OPT_NO_INTERNAL_HELP),
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 28e905afc3..824e5c0a95 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -24,7 +24,7 @@ int cmd__serve_v2(int argc, const char **argv)
 	/* ignore all unknown cmdline switches for now */
 	argc = parse_options(argc, argv, prefix, options, serve_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
 
 	if (advertise_capabilities)
 		protocol_v2_advertise_capabilities();
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 8511ce24bb..264b737309 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -488,8 +488,8 @@ test_expect_success 'STOP_AT_NON_OPTION works' '
 	test_cmp expect actual
 '
 
-test_expect_success 'KEEP_UNKNOWN works' '
-	test-tool parse-options-flags --keep-unknown cmd --unknown=1 --opt=6 -u2 >actual &&
+test_expect_success 'KEEP_UNKNOWN_OPT works' '
+	test-tool parse-options-flags --keep-unknown-opt cmd --unknown=1 --opt=6 -u2 >actual &&
 	cat >expect <<-\EOF &&
 	opt: 6
 	arg 00: --unknown=1
@@ -515,8 +515,8 @@ do
 	"
 done
 
-test_expect_success 'KEEP_UNKNOWN | NO_INTERNAL_HELP works' '
-	test-tool parse-options-flags --keep-unknown --no-internal-help cmd -h --help --help-all >actual &&
+test_expect_success 'KEEP_UNKNOWN_OPT | NO_INTERNAL_HELP works' '
+	test-tool parse-options-flags --keep-unknown-opt --no-internal-help cmd -h --help --help-all >actual &&
 	cat >expect <<-\EOF &&
 	opt: 0
 	arg 00: -h
-- 
2.37.2.817.g36f84ce71d

