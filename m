Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB830C636CD
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A9861179
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 07:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhGRIBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhGRIBP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:01:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6EC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so10790369wmb.3
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZH5QINsK1mL1+JJQ+Ys8lLQMOPyZFa/VFhit+5CLixo=;
        b=Ab12d36QAmuGQ/szrpTxLQSbe0Py0TJP9ZqaOnI5ROh/VxqEBRHsOpHuNVaEd1GBhZ
         LXABCxfOB96R9QST+X/Rh6ba5SpTQeeXojvT0zDR819mrTfITZK4RAljpb+1FJrbzq3f
         vs7WOK5D04kmK3UGDkaepjniZVf4fnVAOHeQUo5FICgFFotR1janehCUyHw2DwV9vml7
         2/3jAmzMLsHq17CpXsVVtffEV+ggD4vyh0jDV81b1z5ggqwqLOTmO6oP1guG3GaNVKoI
         d52Aj8j/Y6PujIriMvxypx6PNZJR1jtH50vZppmdmx8yuFPd5hJ6OT4hKc+I1X2uWk1Q
         nnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZH5QINsK1mL1+JJQ+Ys8lLQMOPyZFa/VFhit+5CLixo=;
        b=ZQaqzsB9EX5rzOqjHB8BQKIupVxozcz9UBWZGP1syKK0V9/3RS16p1bthbLNx6UOuV
         AOWqAT/A3m4VAhWaLxl4g2PhGYYXNCoFpTVADkDa2B8q9d/v1qvwRyNyuN/l+GS1DLZ1
         6J1GOLkjN/A+tPobYLOTz5sJx+c0dgHowHWhrFvm4HzxcAI8fJwGNSxQyZYmWPPIfZVG
         usgf+PGdeQ9QMDWIaxnrth6Uye7XL+CyN8B1yfMkUhdvWHQlrZWdrduTGaMBDs6v5DjH
         34K0K708f1A7YsVYAs1NjH5ZL/fuHkwSII7RPFo3nXFGhUBXiUAg6E9p4vu74YV+4/8M
         T1qg==
X-Gm-Message-State: AOAM530W9vEHybfpZ5/2ao00J2nc8tM7xCLJw0M3JciKKFNOBq7zKP/J
        mPTAlGSOLmMoNqvu6ZfGNhYWQ6yeZ+5jEw==
X-Google-Smtp-Source: ABdhPJxsaapgvvy7TZMjyIbbnVN9KK9+uxVG0uaZLHsxFJFg2LCEUxDasLEVSVsZv47n3RXm39s6wA==
X-Received: by 2002:a05:600c:cb:: with SMTP id u11mr19530831wmm.66.1626595095607;
        Sun, 18 Jul 2021 00:58:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm15904685wrt.55.2021.07.18.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 00:58:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] commit-graph: use parse_options_concat()
Date:   Sun, 18 Jul 2021 09:58:07 +0200
Message-Id: <patch-3.5-2e7d9b0b8e4-20210718T074936Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.873.g94a0c75983d
In-Reply-To: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the parse_options_concat() so we don't need to copy/paste
common options like --object-dir. This is inspired by a similar change
to "checkout" in 2087182272
(checkout: split options[] array in three pieces, 2019-03-29).

A minor behavior change here is that now we're going to list both
--object-dir and --progress first, before we'd list --progress along
with other options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index baead04a03b..ff125adf2d5 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -44,6 +44,21 @@ static struct opts_commit_graph {
 	int enable_changed_paths;
 } opts;
 
+static struct option *add_common_options(struct option *prevopts)
+{
+	struct option options[] = {
+		OPT_STRING(0, "object-dir", &opts.obj_dir,
+			   N_("dir"),
+			   N_("the object directory to store the graph")),
+		OPT_BOOL(0, "progress", &opts.progress,
+			 N_("force progress reporting")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(options, prevopts);
+	free(prevopts);
+	return newopts;
+}
+
 static struct object_directory *find_odb(struct repository *r,
 					 const char *obj_dir)
 {
@@ -77,20 +92,18 @@ static int graph_verify(int argc, const char **argv)
 	int flags = 0;
 
 	static struct option builtin_commit_graph_verify_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			   N_("dir"),
-			   N_("the object directory to store the graph")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_END(),
 	};
+	struct option *options = parse_options_dup(builtin_commit_graph_verify_options);
+	options = add_common_options(options);
 
 	trace2_cmd_mode("verify");
 
 	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_verify_options,
+			     options,
 			     builtin_commit_graph_verify_usage, 0);
 
 	if (!opts.obj_dir)
@@ -207,9 +220,6 @@ static int graph_write(int argc, const char **argv)
 	struct progress *progress = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			N_("dir"),
-			N_("the object directory to store the graph")),
 		OPT_BOOL(0, "reachable", &opts.reachable,
 			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -220,7 +230,6 @@ static int graph_write(int argc, const char **argv)
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
@@ -236,6 +245,8 @@ static int graph_write(int argc, const char **argv)
 			0, write_option_max_new_filters),
 		OPT_END(),
 	};
+	struct option *options = parse_options_dup(builtin_commit_graph_write_options);
+	options = add_common_options(options);
 
 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
@@ -249,7 +260,7 @@ static int graph_write(int argc, const char **argv)
 	git_config(git_commit_graph_write_config, &opts);
 
 	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_write_options,
+			     options,
 			     builtin_commit_graph_write_usage, 0);
 
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
@@ -312,12 +323,8 @@ static int graph_write(int argc, const char **argv)
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
-	static struct option builtin_commit_graph_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			N_("dir"),
-			N_("the object directory to store the graph")),
-		OPT_END(),
-	};
+	struct option *no_options = parse_options_dup(NULL);
+	struct option *builtin_commit_graph_options = add_common_options(no_options);
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
-- 
2.32.0.873.g94a0c75983d

