Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F11A211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeK3JGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37523 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK3JGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id e5-v6so3165664lja.4
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6+O/Ls7+tqemAUu7fh0OtdUDBxBy3V8DzIG1vgioz8=;
        b=afv4yz992G8q63eREbNRjsk9PF6jLi2qs1xfqVVbUc7TZDwdeB95y8DFGtKv1Js4b1
         +QvbWdrWbHofO4oN6C093VzT95+QCUmEudWNh1OqS0unI52iVtIs7Ethw6d+wQGuiVHW
         7F7PyVi8eZWAbhunjaHVSfRtlgFmjnWXuzrsqHDHdRX/X9zxChJboJ+ILOy9N2uYxcD+
         4HZ7XoyxnrscoFbZUsDYMdbqhXTiD8GWH40WJUdkNP/Aqjhewvj5dSGYSEfPy+9Kzicv
         Z9ZR9ykmOfE6vPgT6uqiiLoRzurw2WGID1raGpbnBj1jOyppGht46JdQ3ekZ469frBK7
         G2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6+O/Ls7+tqemAUu7fh0OtdUDBxBy3V8DzIG1vgioz8=;
        b=tnZKqsQ61y3pEH2GMgMmxxd6kKzh8mRmuIv4fgi2fLtuDPYrcLyTYyZEhoKuj9nly6
         7RF3enoyTD+9qeEQhf5UP7La0qMkG7kcQgbIumG+8QTNZG52sP8Fn1IwaaWmXH3HZzgq
         wL0OkYbwrK0YHRsyrfSDN+z9Vnayf4zEFrBehTGNBshhBXmz6lh8mbDOsjBVUK5F+4qG
         V4kX4m07agHmRdjV8epfi4Re+EwLrjMKfpRQhtpspmV+JEQNJ/BCToCQ/DZ1C0hTw7BY
         xTadSnhSAvDgWYzjuDwM0eLeuJgvNVC7L7b7haPMftHDhGIirBi7jGPaGg7wjEGztsZ5
         x7XQ==
X-Gm-Message-State: AA+aEWawDgmfbN17b1K53iQaYcbSi70rhlhs1ZPu51dqPfQg8Jns0ik4
        rtxcOZNeYwKGkKRz/dcUDe4Iyw5R
X-Google-Smtp-Source: AFSGD/URltFWYrY5qkR2VidyVydGkdO9TMvCIg36pqpxbwPOABJzJ2FUbh40KdJbutbFm4qHbiNrWg==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr2444249lje.78.1543528759159;
        Thu, 29 Nov 2018 13:59:19 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:18 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 06/14] checkout: split options[] array in three pieces
Date:   Thu, 29 Nov 2018 22:58:41 +0100
Message-Id: <20181129215850.7278-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a preparation step for introducing new commands that do parts
of what checkout does. There will be two new commands, one is about
switching branches, detaching HEAD... one about checking out
paths. These share the a subset of command line options. The rest of
command line options are separate.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 77 +++++++++++++++++++++++++++++++++-------------
 parse-options-cb.c | 16 ++++++++++
 parse-options.h    |  3 +-
 3 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2423fdbf94..764e1a83a1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1237,14 +1237,31 @@ static int checkout_branch(struct checkout_opts *opts,
 	return switch_branches(opts, new_branch_info);
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static struct option *add_common_options(struct checkout_opts *opts,
+					 struct option *prevopts)
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
-	struct branch_info new_branch_info;
-	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
+			   N_("conflict style (merge or diff3)")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_switch_branch_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
 		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
@@ -1254,33 +1271,44 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
+				N_("second guess 'git checkout <no-such-branch>'")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_checkout_path_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
 		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
 			      N_("checkout our version for unmerged files"),
 			      2, PARSE_OPT_NONEG),
 		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
-		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
-			   N_("update ignored files (default)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
-				N_("second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
-		OPT_END(),
+		OPT_END()
 	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts real_opts;
+	struct checkout_opts *opts = &real_opts;
+	struct branch_info new_branch_info;
+	int dwim_remotes_matched = 0;
+	struct option *options = NULL;
 
 	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
@@ -1293,6 +1321,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = parse_options_dup(options);
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 8c9edce52f..f46b3cb0a4 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -121,6 +121,22 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct option *parse_options_dup(const struct option *o)
+{
+	struct option *opts;
+	int nr = 0;
+
+	while (o && o->type != OPTION_END) {
+		nr++;
+		o++;
+	}
+
+	CALLOC_ARRAY(opts, nr + 1);
+	memcpy(opts, o - nr, sizeof(*o) * nr);
+	opts[nr].type = OPTION_END;
+	return opts;
+}
+
 struct option *parse_options_concat(struct option *a, struct option *b)
 {
 	struct option *ret;
diff --git a/parse-options.h b/parse-options.h
index 6c4fe2016d..584cb521f5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -239,7 +239,8 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-extern struct option *parse_options_concat(struct option *a, struct option *b);
+struct option *parse_options_dup(const struct option *a);
+struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

