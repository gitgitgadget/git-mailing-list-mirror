Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA558C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB07604DB
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhHWMbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbhHWMbL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658DC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x12so26001565wrr.11
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NPFxgggzbsmqdgg+j2gZfx6qsTT1pjjh1Kd79dU8ggo=;
        b=DYOlHM5D9ZmWkINQ9RhNErg81nXiOKF7rJ1rYgS2yBjyDtdjnYIKYvt01alFgZo+rp
         31pW1LTzpQTpXQz/rKD1b/RC2d/NpkPCcut/EXw31K9Z9ha8COeCMW2v8Webo+MX5UbU
         LVL8HoHtxKJfa0plx/lsNbfuyTWP66SQx+vx5MfVfRVPdSnFe2BeG2kkL1JFmPhAXkAt
         1dfJqIYAkTteFIPSBPFDMQhybkNfFu3jRkSgqMq7WPFsm8LLidQAtt2mZBPjxYb9KRks
         zfXBSBupAiLSTKg3OhY8Z6tTsMK8cimqazRUYYZA6gNiT3ZHNus8UtJQIkLPPQboyI6J
         ki6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NPFxgggzbsmqdgg+j2gZfx6qsTT1pjjh1Kd79dU8ggo=;
        b=YYvkH8xC3VE1vw1Fa79r9DFvP6enE5P8W4HlkDhBJOSpNk/To8h4f1yfrBArWAU4YF
         wxPErCjfDnSIw7HjFHdyyPtexUTtGt+UYNRPvOXtzHi0XYOzRGTYO3Z5uNPTJC/9BoSC
         FKPidixH3V6c4E0/8ie8rfmrstm5750IHdd+as/aNsDAD7RNdhYMDpJoKJWFA7pyFNT8
         FJoo5x2Ywm9eM6v+d6EoFQHujBA2TLJeyKwzbNdlImmqzr027A1g+pDBKoFDC6aGtVzh
         bVmXZD6DVu8QsrjVrNsN9pCcRcaErqO2sr/aT8dhGmHG0TBo/hsWF0RZfqpsjVisx0vq
         +n/g==
X-Gm-Message-State: AOAM533DmkARihbWhJ7Mhlu11q3opOIiwAbF4kd1tlHsVBcsYcE6HDoc
        BcuwiO0klIifWKF44ZHKzMicK5i0fzobhDlV
X-Google-Smtp-Source: ABdhPJy7v128PM067Rj71YU5fcKaDrXJS2aHQ7mZOT6s51kAf8oamGdZF8R0eB7Vm46t2l7YEoDMbQ==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr8391318wrm.198.1629721827004;
        Mon, 23 Aug 2021 05:30:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l9sm14762430wrt.95.2021.08.23.05.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:30:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/7] commit-graph: use parse_options_concat()
Date:   Mon, 23 Aug 2021 14:30:17 +0200
Message-Id: <patch-v4-3.7-32cc0d1c7bc-20210823T122854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbc81f8cbdca
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
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
2.33.0.662.gbc81f8cbdca

