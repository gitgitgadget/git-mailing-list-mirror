Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C5B20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCHJ6t (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHJ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so13788748pfo.6
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2s0Pro9+dAFqGCAd29YpkLXyQmG7xEHiYxC6qNHHYc=;
        b=eacx/lFPwsau14aakP31H1JNWqiyIgDfaNgMRLDaX1bnypi+vpizBPH3SHm2d+4qki
         DPNL1dSv7onJWVQLrZpWS/vO1/BIZHKT2t6Q/a3qVEUmbHF0mYY7Sbs5pQwlCuQ6If0v
         CGBlV4u6cbgZ8J2uIk2PQ4vUZ8NAHUCzATUDZk7+TwEpiaL89+XJpqjjnkrwAhzW+A4r
         DEBAlalYAuX8j9jlEVkPniPMROjSgWuVFrvSp97sUfvccHauWtzRXoTMW9+24DkDEbgJ
         gaXRy+yvkin9wHT2LyeK3AbXSzcDL3yW9yhsQFkguXmsMr4/o6VudaXo1mX3Z4iERC+W
         ePng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2s0Pro9+dAFqGCAd29YpkLXyQmG7xEHiYxC6qNHHYc=;
        b=p8VVF+qrqN6QSiFOyvZuXwHao4lSBrhD3tcwI48HdTEU3JNJp6KJT5UJJYj/euOMW/
         GWINhWbv8plIs9lGgBu4pcTjLfzW70r5cJ24W+F/5VpfxUiNQZX38ycl57oxnEfmGwGF
         fccVWlc/Q5RsOvT3VQw4BGQL7xalLQRuXfhTzC8MdbV1wXy9nHxOeb1Vyb8YwJHnq/Ng
         17DFkJY0D73wOlddHX7iKoQA+domcJLvDAEid/kl/S68awEoeklojoigE4zMmidtQaM2
         v+IYm7ymaagjdUBHumATxt7gVTwqY8Fgt80beW8UAsbquzvd1H+UI2GVlfucKfyQEM34
         TSSw==
X-Gm-Message-State: APjAAAVQpWuXhrNoiprKUakfdBulpQk132kDc7ff9lF6XmOooKk5Vi64
        8kEwElPUotaVq3Gb/mMQ20M=
X-Google-Smtp-Source: APXvYqxRAnlIn7s9uODKWafOkJFyTjnz4WUdH9YWIy5QzO5AyQBKL7ySkQdgQRsLsSvUKPGUgiDhkA==
X-Received: by 2002:a63:5702:: with SMTP id l2mr16078044pgb.2.1552039127760;
        Fri, 08 Mar 2019 01:58:47 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e14sm23690990pga.61.2019.03.08.01.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 09/21] checkout: split options[] array in three pieces
Date:   Fri,  8 Mar 2019 16:57:40 +0700
Message-Id: <20190308095752.8574-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
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
---
 builtin/checkout.c | 82 +++++++++++++++++++++++++++++++++-------------
 parse-options-cb.c | 17 ++++++++++
 parse-options.h    |  1 +
 3 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4b43433941..7d23083282 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1342,15 +1342,31 @@ static int checkout_branch(struct checkout_opts *opts,
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
@@ -1360,34 +1376,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1401,6 +1432,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = parse_options_dup(options);
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..caaeed896f 100644
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
index 7d83e2971d..9a90c332a5 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -257,6 +257,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 int parse_options_end(struct parse_opt_ctx_t *ctx);
 
+struct option *parse_options_dup(const struct option *a);
 struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
-- 
2.21.0.rc1.337.gdf7f8d0522

