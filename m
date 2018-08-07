Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B335208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeHGW2p (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 18:28:45 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:38089 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGW2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 18:28:45 -0400
Received: by mail-qt0-f202.google.com with SMTP id e4-v6so14474324qtj.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x0TUbwAA60yTjp/CRuDBTKndyvXgBYASRVzhw44tvHE=;
        b=j6LXjT38/hH2rBKJkZ9yeNov9rY0yJjJoWR7l1xdoOPHsU6qD+u2k6CGIRmeJN2e7U
         RtEVDL+6for90A0n5SDm/8zrrRINPGtAyfaN/+hm0ouJKbRPDG0a5ELZ5GsoaT65xcig
         H41pF42zgT9TLTtE9NmdCumxaUm+mWy1AEWBz0oU7ysvhFH1ykJfkDqnaXbs7M+142pY
         vq/GMV6ZPj5p3JfFtF3BJmTqAzwNcJQBGmtw54VZpEOD+In3AAaOWv3hlHZYR59LWra8
         kycpPIVTQSE4otWwC3OOHQeztEcwYI2oB/FU9oEcym14wtnTBG1eFHR50AtSQlV+DDzo
         spgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x0TUbwAA60yTjp/CRuDBTKndyvXgBYASRVzhw44tvHE=;
        b=J3Y71Ebj8eIxFBy2XUlGcXsV1aqdXaZpFovDZL3iKS2EtnF6UD7u3rxy7A6unkkZR0
         fQwnWyUJbOOe7DifgZfkNHqeL/lekNf0rPfdb5QLNdshw/OASDRemGBUh9fsKhl7N04e
         XDkuRSAm+F566fWvoEDX67Iysf4nDX4a/vf5lUf/cMrfLQkT4XpGEVANsJczmpUpbAh0
         XpAjEbZPIox8e9yRPMVAdylnaAqFEkPVZCxkOhMkFyXWAQXswaL4kltkbRhDq4s8HV8b
         fFDbSIO+SvtiuUAvtJVe7BhfZihcTPMlikso7lldlGV5u6gBD/cqqJEvbtUVMJkgOata
         OUWw==
X-Gm-Message-State: AOUpUlEql20CnNqobVwKeuTUEoBO+ei1yLjLDFUWmNmp/ZBPWJ16gw1M
        OgNTnsO3r/2IHfXfv/PzlIaW6YlG3RWVt4YmzpuY1cd8uHx7KpyWbiy4pWE97PKpC9vbSAfZlMQ
        8DSLAiDg8E9leFVcTVsp4FsFLGVMb6g4zjqqfSNfXxkorhSNseK42irUg/19WJC1sW5x8GcauVj
        ns
X-Google-Smtp-Source: AAOMgpcTjEO0VfEsn13Skq29Gk8ZU+ytxrl8Fs8pcLersRdQmP5Hu73heO2hnvWskaYqhESnXkohohk5XfGBJHYPhqz1
X-Received: by 2002:ac8:1c2d:: with SMTP id a42-v6mr12707892qtk.44.1533672759548;
 Tue, 07 Aug 2018 13:12:39 -0700 (PDT)
Date:   Tue,  7 Aug 2018 13:12:31 -0700
In-Reply-To: <cover.1533672584.git.jonathantanmy@google.com>
Message-Id: <bff8576b1ec9168499dec3164a93344d6d36fa9c.1533672584.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1533672584.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 1/2] repack: refactor setup of pack-objects cmd
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index 6c636e159..ca695fa10 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -138,6 +138,47 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	strbuf_release(&buf);
 }
 
+struct packed_objects_args {
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
+static void prepare_packed_objects(struct child_process *cmd,
+				   const struct packed_objects_args *args)
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
+	struct packed_objects_args po_args = {NULL};
 
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
+	prepare_packed_objects(&cmd, &po_args);
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

