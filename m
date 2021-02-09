Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45577C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00E964ED7
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhBINp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhBINnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:43:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BAC061788
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:42:34 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id g10so21857118wrx.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yFp1XTjvHQxcMPHbhdWE9yRT59wXZWm/2ZDVLjNmWi8=;
        b=fJZFlDM4h379Aer8MtDMKOxD/1lOMlPyfO7f4fk4i8J9gKz4AjnlpEQoTu9ebyCkQo
         qWqxYBpZxzXrXAxdcuhkpBBmbiQlxsOsyD8MNDtg6uzh0iiDpDOSOvVqbdqrmzw8Co/s
         Kr3WuBBfS20MgKG+efcTKfObj5DkbHTrynXIU1wccLnFaPMczpGI3pmjPj0UXKEp5WMc
         dU9MuVGg4rVrJxF3Uhpn9lhB3FNke4uMe32R977iCOLMKLE1SG1rU/tDngy9MMd6j+YN
         1zKE5HOmcnoUW1vivS+ZEM1mRNnlSGOfCPDPjvaKbNYNUkoQqmkMHGq/6iErlQsiLoEF
         inYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yFp1XTjvHQxcMPHbhdWE9yRT59wXZWm/2ZDVLjNmWi8=;
        b=m/Moz5H6/CodpUmVV+pM7CvrGeZlLpGBoj02M9I6GPbAR8EGepZVll6K5ZQ3iGJ70H
         3VHYUYJTzqp0C0hgrxjivQLn05V/LbnQdX247vEAkSuNPvcejd9GhYuparoIJbIk1zcJ
         QmxwiilRJuUcfrxlMnljZcyTe0565Dbq4d5A1+X8b0l4HxWJHPwBIVw5aOo3WWeN1H8o
         +j7TdHaro0mcd5qv8DDJpeTTMynyX1+VDfao0JC5Nwvy/oCfeSmIZlhPJ69VYp0zXb2w
         prQKaLNztuSCZhTR5Bt0NZvFy8AYmPOzFtGt74G5DLIvMO0AMZX9rkGZk5rmyqBswozW
         +wdQ==
X-Gm-Message-State: AOAM532fIpbLda6tVjoCLriQy7/S0OYBbXegHb51WaTmP1zqOAfw8oCL
        3CSGVoz8MG1hAAFewD1rsbLRpSDs/jc=
X-Google-Smtp-Source: ABdhPJz6ik09bjomG7I3jFZlTruwfMcfVE3LCMio56syVtVZI3WMNK1IBJjXTMLDb+nPOVX+be/RZQ==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr25450979wrq.76.1612878153280;
        Tue, 09 Feb 2021 05:42:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16sm35619065wrr.59.2021.02.09.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:42:32 -0800 (PST)
Message-Id: <bedaeb548b06eeb3d8b00e4facdfaccf123855c2.1612878149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
References: <pull.871.git.1612795943.gitgitgadget@gmail.com>
        <pull.871.v2.git.1612878149.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 13:42:28 +0000
Subject: [PATCH v2 1/2] maintenance: add pack-refs task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It is valuable to collect loose refs into a more compressed form. This
is typically the packed-refs file, although this could be the reftable
in the future. Having packed refs can be extremely valuable in repos
with many tags or remote branches that are not modified by the local
user, but still are necessary for other queries.

For instance, with many exploded refs, commands such as

	git describe --tags --exact-match HEAD

can be very slow (multiple seconds). This command in particular is used
by terminal prompts to show when a detatched HEAD is pointing to an
existing tag, so having it be slow causes significant delays for users.

Add a new 'pack-refs' maintenance task. It runs 'git pack-refs --all
--prune' to move loose refs into a packed form. For now, that is the
packed-refs file, but could adjust to other file formats in the future.

This is the first of several sub-tasks of the 'gc' task that could be
extracted to their own tasks. In this process, we should not change the
behavior of the 'gc' task since that remains the default way to keep
repositories maintained. Creating a new task for one of these sub-tasks
only provides more customization options for those choosing to not use
the 'gc' task. It is certainly possible to have both the 'gc' and
'pack-refs' tasks enabled and run regularly. While they may repeat
effort, they do not conflict in a destructive way.

The 'auto_condition' function pointer is left NULL for now. We could
extend this in the future to have a condition check if pack-refs should
be run during 'git maintenance run --auto'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  6 ++++++
 builtin/gc.c                      | 21 +++++++++++++++++----
 t/t7900-maintenance.sh            | 12 ++++++++++++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 3b432171d608..80ddd33ceba0 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -145,6 +145,12 @@ incremental-repack::
 	which is a special case that attempts to repack all pack-files
 	into a single pack-file.
 
+pack-refs::
+	The `pack-refs` task collects the loose reference files and
+	collects them into a single file. This speeds up operations that
+	need to iterate across many references. See linkgit:git-pack-refs[1]
+	for more information.
+
 OPTIONS
 -------
 --auto::
diff --git a/builtin/gc.c b/builtin/gc.c
index 4c40594d660e..41bec4f177b3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -54,7 +54,6 @@ static const char *prune_worktrees_expire = "3.months.ago";
 static unsigned long big_pack_threshold;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
-static struct strvec pack_refs_cmd = STRVEC_INIT;
 static struct strvec reflog = STRVEC_INIT;
 static struct strvec repack = STRVEC_INIT;
 static struct strvec prune = STRVEC_INIT;
@@ -163,6 +162,15 @@ static void gc_config(void)
 	git_config(git_default_config, NULL);
 }
 
+struct maintenance_run_opts;
+static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
+{
+	struct strvec pack_refs_cmd = STRVEC_INIT;
+	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
+
+	return run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+}
+
 static int too_many_loose_objects(void)
 {
 	/*
@@ -518,8 +526,8 @@ static void gc_before_repack(void)
 	if (done++)
 		return;
 
-	if (pack_refs && run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD))
-		die(FAILED_RUN, pack_refs_cmd.v[0]);
+	if (pack_refs && maintenance_task_pack_refs(NULL))
+		die(FAILED_RUN, "pack-refs");
 
 	if (prune_reflogs && run_command_v_opt(reflog.v, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.v[0]);
@@ -556,7 +564,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
-	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
 	strvec_pushl(&prune, "prune", "--expire", NULL);
@@ -1224,6 +1231,7 @@ enum maintenance_task_label {
 	TASK_INCREMENTAL_REPACK,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
+	TASK_PACK_REFS,
 
 	/* Leave as final value */
 	TASK__COUNT
@@ -1255,6 +1263,11 @@ static struct maintenance_task tasks[] = {
 		maintenance_task_commit_graph,
 		should_write_commit_graph,
 	},
+	[TASK_PACK_REFS] = {
+		"pack-refs",
+		maintenance_task_pack_refs,
+		NULL,
+	},
 };
 
 static int compare_tasks_by_selection(const void *a_, const void *b_)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 78ccf4b33f87..4a8a78769bd6 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -343,6 +343,18 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	test_subcommand git multi-pack-index write --no-progress <trace-B
 '
 
+test_expect_success 'pack-refs task' '
+	for n in $(test_seq 1 5)
+	do
+		git branch -f to-pack/$n HEAD || return 1
+	done &&
+	GIT_TRACE2_EVENT="$(pwd)/pack-refs.txt" \
+		git maintenance run --task=pack-refs &&
+	ls .git/refs/heads/ >after &&
+	test_must_be_empty after &&
+	test_subcommand git pack-refs --all --prune <pack-refs.txt
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_i18ngrep "at most one" err
-- 
gitgitgadget

