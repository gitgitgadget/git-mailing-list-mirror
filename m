Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD37C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CF964E05
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhBOSng (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhBOSmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:42:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12137C061786
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:45 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o10so4678200wmc.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 10:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9AiFw8miDGnjxIVOobuKc943zd2SsqJUqGjL4CbUds=;
        b=uZFyvBumXmgHbtqeXyvyZ1s7ULhUTVAZyJg5vR47yVwJ4fVSlncITb3ZZfgN4swxpv
         aiJgpecvjLJAx6f4h7/SVI91eWr2gLlErp/rQOM0I8cKjKCSm/J1HeTs5l0462zit1ip
         pYHO2MasQ/uGqhuzdp2JT55JZUQSULLsSt4IXuMBnR+5IinWXkPuahEK5aL5Wp4Z6xhN
         JoTEl95mTaQm+tZFYZu87ufOVSYsSypE10BB8QVQ01HIujku6pBRUcDmTumDYohCWoJL
         JJfMBWZR7Y5KKqZgB9jEXkPHbrm4hr6FlxLzvIn8hsTRGaHe6V7Q1wDxI30BgPFJCkPF
         6bPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9AiFw8miDGnjxIVOobuKc943zd2SsqJUqGjL4CbUds=;
        b=AMEhBU1eFSEu08CuevDl1W6utYQaAvrEoEIhlTx/K1c63xZZxrX5QGyBFkDTuokdTm
         /IAHJFy05kEu8LW4XjkfcEg2DftC4Vx/TIY74YmxaGGlHzDJKaVhd8mbTI45NaO990Vu
         fq+WOpklnjyG2+4XVujLZom5JuC/6lpyDE2f+CoVOvr9h608+enjhf7YrL0kFSehxuEk
         MCpysqvsFayqK+b0yf17R2PWXkbYYIdkctcfWHjCYiQ+murSBEj1Rx4buIUl3/NltnIg
         jhxOgJtMN0sN4aq0IIGk/k/aVj319LcNIcR/0nYYYM2CJCqy8JySi16HCYdN1bXO5DZV
         u7yw==
X-Gm-Message-State: AOAM5333P/5rP8Ibv4zmxPOx5YyyuL4PxMK72sZGzXPQhYcTKS5FEnH6
        iRqPWLSSZ7CPEt0XmMnl2Y4kT9KAavf21Q==
X-Google-Smtp-Source: ABdhPJxOziTnrTunui2cRfroE6wslUy5swukQR8Dkdh1NzOFPf21Qz9++MJt7EP+4X0elYWq28Nsfw==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr158461wmq.119.1613414503490;
        Mon, 15 Feb 2021 10:41:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v12sm11258979wrv.69.2021.02.15.10.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 10:41:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] commit-graph: use parse_options_concat()
Date:   Mon, 15 Feb 2021 19:41:16 +0100
Message-Id: <20210215184118.11306-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87r1lhb6z7.fsf@evledraar.gmail.com>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
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
 builtin/commit-graph.c | 43 ++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index baead04a03..a7718b2025 100644
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
@@ -75,22 +90,20 @@ static int graph_verify(int argc, const char **argv)
 	int fd;
 	struct stat st;
 	int flags = 0;
-
+	struct option *options = NULL;
 	static struct option builtin_commit_graph_verify_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			   N_("dir"),
-			   N_("the object directory to store the graph")),
 		OPT_BOOL(0, "shallow", &opts.shallow,
 			 N_("if the commit-graph is split, only verify the tip file")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_END(),
 	};
+	options = parse_options_dup(builtin_commit_graph_verify_options);
+	options = add_common_options(options);
 
 	trace2_cmd_mode("verify");
 
 	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_verify_options,
+			     options,
 			     builtin_commit_graph_verify_usage, 0);
 
 	if (!opts.obj_dir)
@@ -205,11 +218,8 @@ static int graph_write(int argc, const char **argv)
 	int result = 0;
 	enum commit_graph_write_flags flags = 0;
 	struct progress *progress = NULL;
-
+	struct option *options = NULL;
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
+	options = parse_options_dup(builtin_commit_graph_write_options);
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
2.30.0.284.gd98b1dd5eaa7

