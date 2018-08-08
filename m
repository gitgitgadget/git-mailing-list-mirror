Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88BA1F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbeHIAz6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:55:58 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:44541 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeHIAz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:58 -0400
Received: by mail-it0-f73.google.com with SMTP id b124-v6so14039itb.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EhDhgEnLnCVLb9jkKyTg1aXEAndOEPw3c/hM4XWPchY=;
        b=mF+p03QmjJHubEfE8rmKoMytGvuoflkHAsH9RHEOJ8QBZrxQF/hPAl0N1NHovTg9Ns
         XHRSa6jZkdNw6bw8nlWAoBvkVXEbejmej+W84Z/lvJliJ7yQ/bi2rs1gZnQb3FV0LnDD
         q1a55zq9lttgKqhtPrfzYo36OR/I7ygb8i3ylPEqrsJpLVILpTf7Evqr8UArBBtSaKNW
         8OjFdEi6N2blRa6dJD8435+uMJOewvYI45bhiH/bE7tFcSUDB8cDu86wZ4Ke4UEhjbio
         EvDrBq5X5g3RtR5XiC4aedchZIwnqohXh1jFf4asq9L1xm0JYy6VwECoes6nfEL/72uw
         ifpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EhDhgEnLnCVLb9jkKyTg1aXEAndOEPw3c/hM4XWPchY=;
        b=VX1aX5JeNF4ldW0f7QhRgnjBpq/5fSQI7To0zTEIwrCmJNzK5hTvOqBqU6uBqeKj6Y
         s8/aTqIwM5f5qMH66xv9MLmRZ5O3PgdAF9hmZy+iO8H858ZyFXKlyfqP6qRoXToWCa1R
         y48SWK2rrl741e4URHKj0WjTdA7QjPwh/JdVqBoQaEfcAHoole+nETnS8clhmLZKmAKm
         HA8wFlcz4+jt3GJS2znza1zNyNj8+gNNeoXbKqGAZyBiPwy0EPwQGnZ6DpPZ4KPhm7s5
         075dpgJO7EPK50jQmBVapGyg+sBF84r0ttJB1/Fe0vXQ1JI707xt6MzNhu+IWeMDRSs7
         WqHg==
X-Gm-Message-State: AOUpUlGVuW0v8XrHTo8ECbt5j/J/ffFTiv5ZMDqDUVTtKmxaR3+WR/1L
        hV85IxLMID53ThRXC53vG1NEIujMc40TTmzPg9fMYAnXuZ5iPApugb2UYv1zOzCuj9gM6POZcEi
        +/gDJzQ0q6njKxI6QQo4JD/MuhHtCuiXuV8gtXvH0QkJAh76HQVlYwLPvjh8Dlfezref06sjnwj
        N1
X-Google-Smtp-Source: AA+uWPz7KwE19SMTdcIDoM54WuQFXoVCgTlidQ+Hx1GfZvwtyINIz65LoZ35WBFm4XECq+cbJuOG4FjMedZpC1u3fOop
X-Received: by 2002:a5e:860d:: with SMTP id z13-v6mr1948217ioj.1.1533767653054;
 Wed, 08 Aug 2018 15:34:13 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:34:05 -0700
In-Reply-To: <cover.1533767314.git.jonathantanmy@google.com>
Message-Id: <7dba07a3037c8134f755b4116788211dd5d6ef7f.1533767314.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com> <cover.1533767314.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 1/2] repack: refactor setup of pack-objects cmd
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch will teach repack to run pack-objects with some same
and some different arguments if repacking of promisor objects is
required. Refactor the setup of the pack-objects cmd so that setting up
the arguments common to both is done in a function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/repack.c | 99 +++++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 6c636e159..f8cae7d66 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -138,6 +138,47 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	strbuf_release(&buf);
 }
 
+struct pack_objects_args {
+	const char *window;
+	const char *window_memory;
+	const char *depth;
+	const char *threads;
+	const char *max_pack_size;
+	int no_reuse_delta;
+	int no_reuse_object;
+	int quiet;
+	int local;
+};
+
+static void prepare_pack_objects(struct child_process *cmd,
+				 const struct pack_objects_args *args)
+{
+	argv_array_push(&cmd->args, "pack-objects");
+	if (args->window)
+		argv_array_pushf(&cmd->args, "--window=%s", args->window);
+	if (args->window_memory)
+		argv_array_pushf(&cmd->args, "--window-memory=%s", args->window_memory);
+	if (args->depth)
+		argv_array_pushf(&cmd->args, "--depth=%s", args->depth);
+	if (args->threads)
+		argv_array_pushf(&cmd->args, "--threads=%s", args->threads);
+	if (args->max_pack_size)
+		argv_array_pushf(&cmd->args, "--max-pack-size=%s", args->max_pack_size);
+	if (args->no_reuse_delta)
+		argv_array_pushf(&cmd->args, "--no-reuse-delta");
+	if (args->no_reuse_object)
+		argv_array_pushf(&cmd->args, "--no-reuse-object");
+	if (args->local)
+		argv_array_push(&cmd->args,  "--local");
+	if (args->quiet)
+		argv_array_push(&cmd->args,  "--quiet");
+	if (delta_base_offset)
+		argv_array_push(&cmd->args,  "--delta-base-offset");
+	argv_array_push(&cmd->args, packtmp);
+	cmd->git_cmd = 1;
+	cmd->out = -1;
+}
+
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
 
@@ -165,15 +206,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int delete_redundant = 0;
 	const char *unpack_unreachable = NULL;
 	int keep_unreachable = 0;
-	const char *window = NULL, *window_memory = NULL;
-	const char *depth = NULL;
-	const char *threads = NULL;
-	const char *max_pack_size = NULL;
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
-	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
-	int quiet = 0;
-	int local = 0;
+	struct pack_objects_args po_args = {NULL};
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -183,14 +218,14 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
-		OPT_BOOL('f', NULL, &no_reuse_delta,
+		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
 				N_("pass --no-reuse-delta to git-pack-objects")),
-		OPT_BOOL('F', NULL, &no_reuse_object,
+		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
 		OPT_BOOL('n', NULL, &no_update_server_info,
 				N_("do not run git-update-server-info")),
-		OPT__QUIET(&quiet, N_("be quiet")),
-		OPT_BOOL('l', "local", &local,
+		OPT__QUIET(&po_args.quiet, N_("be quiet")),
+		OPT_BOOL('l', "local", &po_args.local,
 				N_("pass --local to git-pack-objects")),
 		OPT_BOOL('b', "write-bitmap-index", &write_bitmaps,
 				N_("write bitmap index")),
@@ -198,15 +233,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("with -A, do not loosen objects older than this")),
 		OPT_BOOL('k', "keep-unreachable", &keep_unreachable,
 				N_("with -a, repack unreachable objects")),
-		OPT_STRING(0, "window", &window, N_("n"),
+		OPT_STRING(0, "window", &po_args.window, N_("n"),
 				N_("size of the window used for delta compression")),
-		OPT_STRING(0, "window-memory", &window_memory, N_("bytes"),
+		OPT_STRING(0, "window-memory", &po_args.window_memory, N_("bytes"),
 				N_("same as the above, but limit memory size instead of entries count")),
-		OPT_STRING(0, "depth", &depth, N_("n"),
+		OPT_STRING(0, "depth", &po_args.depth, N_("n"),
 				N_("limits the maximum delta depth")),
-		OPT_STRING(0, "threads", &threads, N_("n"),
+		OPT_STRING(0, "threads", &po_args.threads, N_("n"),
 				N_("limits the maximum number of threads")),
-		OPT_STRING(0, "max-pack-size", &max_pack_size, N_("bytes"),
+		OPT_STRING(0, "max-pack-size", &po_args.max_pack_size, N_("bytes"),
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
@@ -238,7 +273,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	sigchain_push_common(remove_pack_on_signal);
 
-	argv_array_push(&cmd.args, "pack-objects");
+	prepare_pack_objects(&cmd, &po_args);
+
 	argv_array_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
 		argv_array_push(&cmd.args, "--honor-pack-keep");
@@ -251,20 +287,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--indexed-objects");
 	if (repository_format_partial_clone)
 		argv_array_push(&cmd.args, "--exclude-promisor-objects");
-	if (window)
-		argv_array_pushf(&cmd.args, "--window=%s", window);
-	if (window_memory)
-		argv_array_pushf(&cmd.args, "--window-memory=%s", window_memory);
-	if (depth)
-		argv_array_pushf(&cmd.args, "--depth=%s", depth);
-	if (threads)
-		argv_array_pushf(&cmd.args, "--threads=%s", threads);
-	if (max_pack_size)
-		argv_array_pushf(&cmd.args, "--max-pack-size=%s", max_pack_size);
-	if (no_reuse_delta)
-		argv_array_pushf(&cmd.args, "--no-reuse-delta");
-	if (no_reuse_object)
-		argv_array_pushf(&cmd.args, "--no-reuse-object");
 	if (write_bitmaps)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
 
@@ -292,17 +314,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd.args, "--incremental");
 	}
 
-	if (local)
-		argv_array_push(&cmd.args,  "--local");
-	if (quiet)
-		argv_array_push(&cmd.args,  "--quiet");
-	if (delta_base_offset)
-		argv_array_push(&cmd.args,  "--delta-base-offset");
-
-	argv_array_push(&cmd.args, packtmp);
-
-	cmd.git_cmd = 1;
-	cmd.out = -1;
 	cmd.no_stdin = 1;
 
 	ret = start_command(&cmd);
@@ -320,7 +331,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (ret)
 		return ret;
 
-	if (!names.nr && !quiet)
+	if (!names.nr && !po_args.quiet)
 		printf("Nothing new to pack.\n");
 
 	/*
@@ -441,7 +452,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			if (!string_list_has_string(&names, sha1))
 				remove_redundant_pack(packdir, item->string);
 		}
-		if (!quiet && isatty(2))
+		if (!po_args.quiet && isatty(2))
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
 	}
-- 
2.18.0.597.ga71716f1ad-goog

