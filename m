Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576E81F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfA3JtM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44240 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfA3JtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so10804995plt.11
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQH3hqjxsDKVTc/CSA4hRuj+mYNkHhNGyPng4PDcIio=;
        b=pH63gX663E1TynEmAlrp8ZrxqnoPneHzHMXtDAB2YnvpFmnLWwr7aslsFgjHIIyQ67
         aaf4NINVvFqyrKCQNTdj8TFncIWErSixvlxhl9GuoLJ1LI3uNad8X7bH0d2SAqYZV3KH
         3kW0RZiD46gcSYowCf3r+xUVvQqrgd1fLhJ6Xia6qdsa/wG9ho3mMxDgi6D/hP1+DtfB
         mJlORb+7vTrpIRsJ9ZSrK1GwJ2/r8Qv6IqseIsrWC2uGN8nRYeLD6LO0LjBgYmATN6Jd
         1RMw1QYHXtS76nadZNnSHw8iiJneJxOlHbbYQPjFYT1MciaL+tJn0anAuwoLmljKMdhO
         4Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQH3hqjxsDKVTc/CSA4hRuj+mYNkHhNGyPng4PDcIio=;
        b=i6x+3p4QlhmdJKQv/elLSL8na6J6HoV5R3s3NWZBNcorheCLOjLIKjvKerYZPtHwb/
         Xnuss3kRqp1T9YthGzEhRP0f7LhufwWafSEiqUS1KzTfVFgL1uAfIv42dppqVVNccwZO
         JPeWfwTYKw0L5QnU8tKtvWLgFG92r/9HnmC4jw6k26pFvobsHkYms41HGIwvo0kTL//x
         BM6I6b9evCzIlcba8y433t4UskG9h9rTrp4jg+pigtODUKbYLICFdzS18Y5zz5bMQ3Ck
         yGUCxCp3XLtlCouJwnmMwvSW37UsZZwXZQd6ZMHlCuVHG2lfADKNxXiMGra1/88gJcHe
         pQRg==
X-Gm-Message-State: AJcUukfASjfR3AvAiB0zxnMvHQQ2eUSSiOpAjyyUnC5oRAHZy5pO8Gwd
        Vn2U/HWbSrxXwq049sWctDEUhjhm
X-Google-Smtp-Source: ALg8bN5gFCvgEYtNXeDSrIMNbl1e06vV0E2HTxpJLEwyGZyU+LooMzo2ugnPR8Titk2yZqdWK9D1hw==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12mr29137359plb.46.1548841751229;
        Wed, 30 Jan 2019 01:49:11 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v12sm1526665pgg.41.2019.01.30.01.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/19] checkout: split options[] array in three pieces
Date:   Wed, 30 Jan 2019 16:48:19 +0700
Message-Id: <20190130094831.10420-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
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
 builtin/checkout.c | 82 +++++++++++++++++++++++++++++++++-------------
 parse-options-cb.c | 17 ++++++++++
 parse-options.h    |  3 +-
 3 files changed, 78 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5914dd3619..8ea1349cce 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1327,15 +1327,31 @@ static int checkout_branch(struct checkout_opts *opts,
 	return switch_branches(opts, new_branch_info);
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static struct option *add_common_options(struct checkout_opts *opts,
+					 struct option *prevopts)
 {
-	struct checkout_opts real_opts;
-	struct checkout_opts *opts = &real_opts;
-	struct branch_info new_branch_info;
-	int dwim_new_local_branch;
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
@@ -1345,34 +1361,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
+			   N_("update ignored files (default)"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
+			 N_("second guess 'git checkout <no-such-branch>'")),
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
-		OPT_BOOL(0, "no-guess", &opts->no_dwim_new_local_branch,
-			 N_("do not second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL(0, "overlay", &opts->overlay_mode, N_("use overlay mode (default)")),
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
+	int dwim_new_local_branch;
+	struct option *options = NULL;
 
 	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
@@ -1386,6 +1417,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = parse_options_dup(options);
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index e2f3eaed07..76eb5c211b 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -122,6 +122,23 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
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
+	ALLOC_ARRAY(opts, nr + 1);
+	memcpy(opts, o - nr, sizeof(*o) * nr);
+	memset(opts + nr, 0, sizeof(*opts));
+	opts[nr].type = OPTION_END;
+	return opts;
+}
+
 struct option *parse_options_concat(struct option *a, struct option *b)
 {
 	struct option *ret;
diff --git a/parse-options.h b/parse-options.h
index 14fe32428e..6846a5b1e0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -237,7 +237,8 @@ extern int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 extern int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-extern struct option *parse_options_concat(struct option *a, struct option *b);
+struct option *parse_options_dup(const struct option *a);
+struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-- 
2.20.1.682.gd5861c6d90

