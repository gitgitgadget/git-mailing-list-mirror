Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F3C2211B4
	for <e@80x24.org>; Mon,  3 Dec 2018 19:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbeLCTYh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 14:24:37 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:60151 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeLCTYh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 14:24:37 -0500
Received: by mail-it1-f201.google.com with SMTP id t143so9758953itc.9
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 11:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rNdCQYNjrxNzaIcvAxtmUJYLTglrAW0SN8p1ySmH/pk=;
        b=nUce8e0XVb5nZxFg8R3OaiGrYIqRzKFTpki1UwBNlvSbB0tPt/LegZyIjxOtmzgge+
         A6UIrrOcwQx5LFLRsJLFRHTPiwgix953kvvaf/twjP0FuMtwiP+1FTaVazn16WtjcQph
         B3kj0B+z0nPPtxa0/oVlxoQAyxEHZmW/PUX58VDrg7BZcI1kmWKx2ofnTMembcHE1Qsm
         K/eJ1D09S/7LXeEvP5zGjeGJOsTuikh7oPpnmthMOid08NfUOHUzNODBRUNK1lwVerqf
         2MDGow57MarVu2sLw2l7VyZEtxDtsSg10fk5Oh3GoZ5xUnvadcZyCRRLTjd+Hw+MPRXa
         YVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rNdCQYNjrxNzaIcvAxtmUJYLTglrAW0SN8p1ySmH/pk=;
        b=k/iD5UNosrdbGLWg8mO344pxUARFhECgkBg9Lk+0KBtWyELCyNp1/L/4ouT+DVGyCZ
         7X5PfkTeybPs2rsHRC70nWyRd5FAQD3EGggj/U0BGLX236I7oF7nSns+FpFK+U2KYhaH
         KSWk84tOi1VdUh4rF2RuTrOkkmrfILMu2DdIGjhlFs/Fx6fA7XmftJ8XcyfGqJUM5o24
         mtNb+QWZ/AfV8716z3vfd++iotPvEVse0odTjdlCjiA17eWVsq6+Wa8DfXjtL4GIgN9H
         taSrzijsU1BgbuXbF5qszCraJlpCD34vBLFgqkO2w2Ta0XMig5nOX7In92zfJLqzbjeX
         nASQ==
X-Gm-Message-State: AA+aEWYr4WNbojQxboo+HxTF2Ldo14WOAtDEhK/ZZFxR6rYs5Ji7dA7V
        4HPGzHBG09ohB1kFvdV6vk6HRLY5G18=
X-Google-Smtp-Source: AFSGD/UeCHi5klSQ3vAtdXup9ChBs9GK8QXwmp9jE9w/ylwPbCORANkkNVlyFsv1G7rx7wsqTNpUoPApXyra
X-Received: by 2002:a24:5cc5:: with SMTP id q188mr4459043itb.35.1543865072290;
 Mon, 03 Dec 2018 11:24:32 -0800 (PST)
Date:   Mon,  3 Dec 2018 11:23:56 -0800
In-Reply-To: <20181201194424.GB28918@sigill.intra.peff.net>
Message-Id: <20181203192356.51432-1-matvore@google.com>
Mime-Version: 1.0
References: <20181201194424.GB28918@sigill.intra.peff.net>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
Subject: [PATCH] revisions.c: put promisor option in specialized struct
From:   Matthew DeVore <matvore@google.com>
To:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Cc:     Matthew DeVore <matvore@google.com>, pclouds@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Put the allow_exclude_promisor_objects flag in setup_revision_opt. When
it was in rev_info, it was unclear when it was used, since rev_info is
passed to functions that don't use the flag. This resulted in
unnecessary setting of the flag in prune.c, so fix that as well.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 builtin/pack-objects.c |  7 +++++--
 builtin/prune.c        |  1 -
 builtin/rev-list.c     |  6 ++++--
 revision.c             | 10 ++++++----
 revision.h             |  4 ++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 24bba8147f..b22c99f540 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3084,14 +3084,17 @@ static void record_recent_commit(struct commit *commit, void *data)
 static void get_object_list(int ac, const char **av)
 {
 	struct rev_info revs;
+	struct setup_revision_opt s_r_opt;
 	char line[1000];
 	int flags = 0;
 	int save_warning;
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	revs.allow_exclude_promisor_objects_opt = 1;
-	setup_revisions(ac, av, &revs, NULL);
+
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.allow_exclude_promisor_objects = 1;
+	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
diff --git a/builtin/prune.c b/builtin/prune.c
index e42653b99c..1ec9ddd751 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -120,7 +120,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	save_commit_buffer = 0;
 	read_replace_refs = 0;
 	ref_paranoia = 1;
-	revs.allow_exclude_promisor_objects_opt = 1;
 	repo_init_revisions(the_repository, &revs, prefix);
 
 	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3a2c0c23b6..c3095c6fed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -362,6 +362,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	struct rev_list_info info;
+	struct setup_revision_opt s_r_opt;
 	int i;
 	int bisect_list = 0;
 	int bisect_show_vars = 0;
@@ -375,7 +376,6 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
-	revs.allow_exclude_promisor_objects_opt = 1;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
 	revs.do_not_die_on_missing_tree = 1;
 
@@ -407,7 +407,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	memset(&s_r_opt, 0, sizeof(s_r_opt));
+	s_r_opt.allow_exclude_promisor_objects = 1;
+	argc = setup_revisions(argc, argv, &revs, &s_r_opt);
 
 	memset(&info, 0, sizeof(info));
 	info.revs = &revs;
diff --git a/revision.c b/revision.c
index 13e0519c02..f6b32e6a42 100644
--- a/revision.c
+++ b/revision.c
@@ -1791,7 +1791,8 @@ static void add_message_grep(struct rev_info *revs, const char *pattern)
 }
 
 static int handle_revision_opt(struct rev_info *revs, int argc, const char **argv,
-			       int *unkc, const char **unkv)
+			       int *unkc, const char **unkv,
+			       const struct setup_revision_opt* opt)
 {
 	const char *arg = argv[0];
 	const char *optarg;
@@ -2151,7 +2152,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->limited = 1;
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing = 1;
-	} else if (revs->allow_exclude_promisor_objects_opt &&
+	} else if (opt && opt->allow_exclude_promisor_objects &&
 		   !strcmp(arg, "--exclude-promisor-objects")) {
 		if (fetch_if_missing)
 			BUG("exclude_promisor_objects can only be used when fetch_if_missing is 0");
@@ -2173,7 +2174,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const char * const usagestr[])
 {
 	int n = handle_revision_opt(revs, ctx->argc, ctx->argv,
-				    &ctx->cpidx, ctx->out);
+				    &ctx->cpidx, ctx->out, NULL);
 	if (n <= 0) {
 		error("unknown option `%s'", ctx->argv[0]);
 		usage_with_options(usagestr, options);
@@ -2391,7 +2392,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				continue;
 			}
 
-			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+			opts = handle_revision_opt(revs, argc - i, argv + i,
+						   &left, argv, opt);
 			if (opts > 0) {
 				i += opts - 1;
 				continue;
diff --git a/revision.h b/revision.h
index 7987bfcd2e..7d6e050569 100644
--- a/revision.h
+++ b/revision.h
@@ -161,7 +161,6 @@ struct rev_info {
 			do_not_die_on_missing_tree:1,
 
 			/* for internal use only */
-			allow_exclude_promisor_objects_opt:1,
 			exclude_promisor_objects:1;
 
 	/* Diff flags */
@@ -297,7 +296,8 @@ struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
 	const char *submodule;	/* TODO: drop this and use rev_info->repo */
-	int assume_dashdash;
+	int assume_dashdash : 1;
+	int allow_exclude_promisor_objects : 1;
 	unsigned revarg_opt;
 };
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

