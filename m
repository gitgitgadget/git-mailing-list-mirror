Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7738D1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeK1DwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36282 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbeK1DwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so20714209ljk.3
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/nf+jUR8CWRte6uj5zdCHr3bOgxkxHpatbZyBtnm020=;
        b=msW/x+TKqOMpq6GCz1X9dmfgu/X5l1uZ8obLqKbCclMMtMZp1PgTzRfh7I1tyUj0VQ
         vRXWUlZwb14bh5lWVRzHniy6CcyzDpEoWC6WYv/iEFo9ZuJNTHmtIHmtF1MP+Cu+owcX
         FfFQxLqPWZkfeP96BzNR0Jf3X/7Qyl224IR75NKz5oDA3nwW4KcBvhaDcdsWxNvIGk1s
         s/OJAL5tyoBSGnhS1NuY4wKu8RF1VBHPLb2zvXC/QuAKU1ueyRtCUYLq4Vh2dNh1ZAVy
         18SJTsDJ0QHxuv8TqDfD/WtZHVWTEn4G7zzyBlacR2eVpJ+KZmd1IptfBGGULpKOUbem
         bDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nf+jUR8CWRte6uj5zdCHr3bOgxkxHpatbZyBtnm020=;
        b=HgNAUzucYVXYNOMWhYhMEecdmQ3fIbsHFo1iaXysRo5meecKTG7ZwbBNOiF1x6m9hc
         CNWjnGU8DM2hbYoDI4qzAorD40NORoIJcmT51zKyyrypoxI0TigAfUPr7IsXoTdzW+v9
         ITaJqVnuRgmO6VadGOzc50/3lIkvNrbuzlO5ZprnE4fRvrLDyewDlSpQ0dEZPwEa+6K3
         1dmo84n0D2vCHB1N/reRRcf23i1kHIiCeRS/q8fg39KM+p5Fg4xhG9Oc62MmqxsHlmJR
         GoEjo3gi1q1XbVtxE5zcdpfWg9x2U6jq0LmsRZh+SUypHQ/sH1lnNQugwtIHP3AUkMZF
         RcUw==
X-Gm-Message-State: AA+aEWbDpSRcruOCIhbdwAc56A4py+icWgBvd37RTp0pQvBmY95A3l8x
        O0BwzgZ+DAqAuJeC9sJmtC4=
X-Google-Smtp-Source: AFSGD/XKH3cHFIpgCW7g3IA9i0qV9UNBebF4efkr2g245yjs3mLjM+hW9mjJuzV/XUdSS+B4hJX7nw==
X-Received: by 2002:a2e:9dcb:: with SMTP id x11-v6mr947055ljj.158.1543337613501;
        Tue, 27 Nov 2018 08:53:33 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:32 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 5/7] checkout: split options[] array in three pieces
Date:   Tue, 27 Nov 2018 17:52:09 +0100
Message-Id: <20181127165211.24763-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
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
 builtin/checkout.c | 80 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a50c51f287..d9dbd2d40d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1226,14 +1226,32 @@ static int checkout_branch(struct checkout_opts *opts,
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
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
+			 N_("do not limit pathspecs to sparse entries only")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
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
@@ -1243,33 +1261,43 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
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
-		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
-			 N_("do not limit pathspecs to sparse entries only")),
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
@@ -1282,6 +1310,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
+	options = add_common_options(opts, options);
+	options = add_switch_branch_options(opts, options);
+	options = add_checkout_path_options(opts, options);
+
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-- 
2.19.1.1327.g328c130451.dirty

