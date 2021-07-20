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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E10C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C1C6113C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 11:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhGTLAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbhGTK73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 06:59:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6478C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r11so25622440wro.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjUJV4naweGoHAw6GWtAUNF1QdMatwY4PNcC7RelCEc=;
        b=rDG9EFGR7QzUF+b5czDejk6I+CQC+70GMAHrm1KDOo0Vgw1NziZmyvzg9OrPS1X0CC
         cJD637/yg3tNRMMqvfIu4Qc5J0yNHk7We/RsFSnosSmEHe9Fs69kauUxGJjQsXQ7BEuL
         TG9vqi9j+FAy8e/K8LCXl6OvX9b93IQkZkXRFzef0Pg8tgonWFFqT3B5PuQSEDLoKaE0
         qGlLNbL+vrLhrLCUtvlbePPHdA4UB/2G2mffkeCiqfgBUbSAxFRx9Bshj3ljzBCAqTrJ
         U6oDwCWcYZVKwfj+mC8u9kjNRjXf287oKnQqirt3SPC2M2kr5MBcvxOV71K1C1lzq9ft
         jKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjUJV4naweGoHAw6GWtAUNF1QdMatwY4PNcC7RelCEc=;
        b=umVfnMsZrd5lOcj84MiRhg/UpRBnaiNbCEERft7fPZut0WqN5JNaiIsxqygY6LeVYp
         mAZOPqNB5MhW6RIxFLIf5oWLxQcRfxAPhVKawUzUSPMyO9oMUp9aCYk2MrSkLMLh0xKo
         55hjWA4O/WOiuJDfg8giTo97vQt2MCqXc1jBM6TdbsZggY6rWaB352hg57xHBnkTT0Ul
         mbQnsoidjLKojezuVgxwe6URHvHEmYZPaDJLkWxbQdqhtyeQyfT2nupRwyKS3wayrDEY
         MQb/Q16N8mbzReGQY3FWTVVRGD6KKSDCY4Ve5nBp33KilgPW1fGKe4xUEGYDEQfn7WIT
         Vyew==
X-Gm-Message-State: AOAM532WNBECdDMQouMrZjDuZeMGAobNvmn82uiGtEkYY3xgyrqt9n90
        j3Hz742+gNvLVTIRqqZVlJVY9Kx+MjeLWA==
X-Google-Smtp-Source: ABdhPJykASa7Cu36ZabrOes5FFQoEo8Ti+/4Y2SbWumFtbGpMXIlfLxCotlKNCzWiI5hL1Gk2qvt0w==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr36237250wrp.109.1626781205258;
        Tue, 20 Jul 2021 04:40:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y66sm19683595wmy.39.2021.07.20.04.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:40:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] commit-graph: use parse_options_concat()
Date:   Tue, 20 Jul 2021 13:39:42 +0200
Message-Id: <patch-3.6-f02da994363-20210720T113707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com> <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the parse_options_concat() so we don't need to copy/paste
common options like --object-dir.

This is inspired by a similar change to "checkout" in 2087182272
(checkout: split options[] array in three pieces, 2019-03-29), and the
same pattern in the multi-pack-index command, see
60ca94769ce (builtin/multi-pack-index.c: split sub-commands,
2021-03-30).

A minor behavior change here is that now we're going to list both
--object-dir and --progress first, before we'd list --progress along
with other options.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 3cf18dc5345..6e49184439f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -46,6 +46,20 @@ static struct opts_commit_graph {
 	int enable_changed_paths;
 } opts;
 
+static struct option common_opts[] = {
+	OPT_STRING(0, "object-dir", &opts.obj_dir,
+		   N_("dir"),
+		   N_("the object directory to store the graph")),
+	OPT_BOOL(0, "progress", &opts.progress,
+		 N_("force progress reporting")),
+	OPT_END()
+};
+
+static struct option *add_common_options(struct option *to)
+{
+	return parse_options_concat(common_opts, to);
+}
+
 static struct object_directory *find_odb(struct repository *r,
 					 const char *obj_dir)
 {
@@ -79,20 +93,17 @@ static int graph_verify(int argc, const char **argv)
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
+	struct option *options = add_common_options(builtin_commit_graph_verify_options);
 
 	trace2_cmd_mode("verify");
 
 	opts.progress = isatty(2);
 	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_verify_options,
+			     options,
 			     builtin_commit_graph_verify_usage, 0);
 
 	if (!opts.obj_dir)
@@ -109,6 +120,7 @@ static int graph_verify(int argc, const char **argv)
 		die_errno(_("Could not open commit-graph '%s'"), graph_name);
 
 	FREE_AND_NULL(graph_name);
+	FREE_AND_NULL(options);
 
 	if (open_ok)
 		graph = load_commit_graph_one_fd_st(the_repository, fd, &st, odb);
@@ -209,9 +221,6 @@ static int graph_write(int argc, const char **argv)
 	struct progress *progress = NULL;
 
 	static struct option builtin_commit_graph_write_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			N_("dir"),
-			N_("the object directory to store the graph")),
 		OPT_BOOL(0, "reachable", &opts.reachable,
 			N_("start walk at all refs")),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -222,7 +231,6 @@ static int graph_write(int argc, const char **argv)
 			N_("include all commits already in the commit-graph file")),
 		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
 			N_("enable computation for changed paths")),
-		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
@@ -238,6 +246,7 @@ static int graph_write(int argc, const char **argv)
 			0, write_option_max_new_filters),
 		OPT_END(),
 	};
+	struct option *options = add_common_options(builtin_commit_graph_write_options);
 
 	opts.progress = isatty(2);
 	opts.enable_changed_paths = -1;
@@ -251,7 +260,7 @@ static int graph_write(int argc, const char **argv)
 	git_config(git_commit_graph_write_config, &opts);
 
 	argc = parse_options(argc, argv, NULL,
-			     builtin_commit_graph_write_options,
+			     options,
 			     builtin_commit_graph_write_usage, 0);
 
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
@@ -307,6 +316,7 @@ static int graph_write(int argc, const char **argv)
 		result = 1;
 
 cleanup:
+	FREE_AND_NULL(options);
 	string_list_clear(&pack_indexes, 0);
 	strbuf_release(&buf);
 	return result;
@@ -314,12 +324,7 @@ static int graph_write(int argc, const char **argv)
 
 int cmd_commit_graph(int argc, const char **argv, const char *prefix)
 {
-	static struct option builtin_commit_graph_options[] = {
-		OPT_STRING(0, "object-dir", &opts.obj_dir,
-			N_("dir"),
-			N_("the object directory to store the graph")),
-		OPT_END(),
-	};
+	struct option *builtin_commit_graph_options = common_opts;
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix,
-- 
2.32.0.874.ge7a9d58bfcf

