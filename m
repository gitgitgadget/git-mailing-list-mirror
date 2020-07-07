Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F3C433E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5802073E
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 14:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nurKB6Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGOVq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgGGOVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 10:21:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A7C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 07:21:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so46663744wmo.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CjtKqazwyBaC1GT/9S5K6OTBUb4TEnXMzuuhIgUAxgo=;
        b=nurKB6QqvZTzoecYFeLfVDokPzo2i2Rosk4SbjezC2fwpDG1ZS0d+ofh7edn0UUYhL
         Fh11q0vHi1zUU1kHSn0xX64W8C5H80MIFyaD9Ic5AmvnJqsotIn5FwFoQkVX0IGBIDIT
         AnnSEHLyJ04sYdPoTbSw+LYb+Z8oeHcuNUxuljfKewhXf27c95jf9YExUgQ2obDquAw3
         +B8AUsO2edSfWhYaipdIFIlBDigKgcsv2M2MnxwM0Fv3s8xLQE5RBDZ5jpoeqXa+Ja3i
         qBZopkc4gYKCbUCighCF0JJB0deu7BT1AGTRJ2ztJlEEDB45h7JKpd23wK+zs9pbdKfg
         RsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CjtKqazwyBaC1GT/9S5K6OTBUb4TEnXMzuuhIgUAxgo=;
        b=CARuPPKTDr3dI66MFMSVp/wlAiextfPxJCKKXj30EJpEH9VeB4W5VzgZ4TD8U9Oh2Q
         0DXu3NEOVUvNJMo53bBUQQSLhw9yWpGbSVe3GGz6sYHV+TuIeF1YxvLmvb4au61ATsTu
         faE4mHGv/PME+P3PYLKaMRAVmWhmR9f/Kv1v9ZCGTFN6e7aE7FNPmUWviyc+ZRNIu4i7
         t/70MjgplNdPeDj1glL9Jr7vGbJsqQ95RBPEkb6tt2yYpfi9QdVORmCZgC1sxK2Hm52v
         mc2/WjuAnTqpzrxG1Y5vhWFYXCf2felsiba082tLWeX8+af9RO2rfka1bxFbAK/z/+Yh
         1Ntw==
X-Gm-Message-State: AOAM532TlQ+DJwIvgBduGTv2pxUKEjIH1HrSiqGBzJRXVtJ56wKx9ApK
        RNgMQFY4logoJG9w8vnbDH704Bzu
X-Google-Smtp-Source: ABdhPJxAkTJCNnJoA0WBBbGfWuZL4F6zehh45MM6OC8zU11DyR29Iesl8SMSi39bnQVL2k+lhVhFgg==
X-Received: by 2002:a1c:4343:: with SMTP id q64mr4479272wma.20.1594131700936;
        Tue, 07 Jul 2020 07:21:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12sm1248891wrv.41.2020.07.07.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:21:40 -0700 (PDT)
Message-Id: <5f89e0ec9b9c9a02deed5b79b35253e0462dc87c.1594131695.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.git.1594131695.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jul 2020 14:21:19 +0000
Subject: [PATCH 05/21] maintenance: create basic maintenance runner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'gc' builtin is our current entrypoint for automatically maintaining
a repository. This one tool does many operations, such as repacking the
repository, packing refs, and rewriting the commit-graph file. The name
implies it performs "garbage collection" which means several different
things, and some users may not want to use this operation that rewrites
the entire object database.

Create a new 'maintenance' builtin that will become a more general-
purpose command. To start, it will only support the 'run' subcommand,
but will later expand to add subcommands for scheduling maintenance in
the background.

For now, the 'maintenance' builtin is a thin shim over the 'gc' builtin.
In fact, the only option is the '--auto' toggle, which is handed
directly to the 'gc' builtin. The current change is isolated to this
simple operation to prevent more interesting logic from being lost in
all of the boilerplate of adding a new builtin.

Use existing builtin/gc.c file because we want to share code between the
two builtins. It is possible that we will have 'maintenance' replace the
'gc' builtin entirely at some point, leaving 'git gc' as an alias for
some specific arguments to 'git maintenance run'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                        |  1 +
 Documentation/git-maintenance.txt | 57 +++++++++++++++++++++++++++++
 builtin.h                         |  1 +
 builtin/gc.c                      | 61 +++++++++++++++++++++++++++++++
 git.c                             |  1 +
 t/t7900-maintenance.sh            | 22 +++++++++++
 6 files changed, 143 insertions(+)
 create mode 100644 Documentation/git-maintenance.txt
 create mode 100755 t/t7900-maintenance.sh

diff --git a/.gitignore b/.gitignore
index ee509a2ad2..a5808fa30d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -90,6 +90,7 @@
 /git-ls-tree
 /git-mailinfo
 /git-mailsplit
+/git-maintenance
 /git-merge
 /git-merge-base
 /git-merge-index
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
new file mode 100644
index 0000000000..34cd2b4417
--- /dev/null
+++ b/Documentation/git-maintenance.txt
@@ -0,0 +1,57 @@
+git-maintenance(1)
+==================
+
+NAME
+----
+git-maintenance - Run tasks to optimize Git repository data
+
+
+SYNOPSIS
+--------
+[verse]
+'git maintenance' run [<options>]
+
+
+DESCRIPTION
+-----------
+Run tasks to optimize Git repository data, speeding up other Git commands
+and reducing storage requirements for the repository.
++
+Git commands that add repository data, such as `git add` or `git fetch`,
+are optimized for a responsive user experience. These commands do not take
+time to optimize the Git data, since such optimizations scale with the full
+size of the repository while these user commands each perform a relatively
+small action.
++
+The `git maintenance` command provides flexibility for how to optimize the
+Git repository.
+
+SUBCOMMANDS
+-----------
+
+run::
+	Run one or more maintenance tasks.
+
+TASKS
+-----
+
+gc::
+	Cleanup unnecessary files and optimize the local repository. "GC"
+	stands for "garbage collection," but this task performs many
+	smaller tasks. This task can be rather expensive for large
+	repositories, as it repacks all Git objects into a single pack-file.
+	It can also be disruptive in some situations, as it deletes stale
+	data.
+
+OPTIONS
+-------
+--auto::
+	When combined with the `run` subcommand, run maintenance tasks
+	only if certain thresholds are met. For example, the `gc` task
+	runs when the number of loose objects exceeds the number stored
+	in the `gc.auto` config setting, or when the number of pack-files
+	exceeds the `gc.autoPackLimit` config setting.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin.h b/builtin.h
index a5ae15bfe5..17c1c0ce49 100644
--- a/builtin.h
+++ b/builtin.h
@@ -167,6 +167,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix);
 int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 int cmd_mailsplit(int argc, const char **argv, const char *prefix);
+int cmd_maintenance(int argc, const char **argv, const char *prefix);
 int cmd_merge(int argc, const char **argv, const char *prefix);
 int cmd_merge_base(int argc, const char **argv, const char *prefix);
 int cmd_merge_index(int argc, const char **argv, const char *prefix);
diff --git a/builtin/gc.c b/builtin/gc.c
index 58a00be5af..07cc5f46ae 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -704,3 +704,64 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+
+static const char * const builtin_maintenance_usage[] = {
+	N_("git maintenance run [<options>]"),
+	NULL
+};
+
+struct maintenance_opts {
+	int auto_flag;
+} opts;
+
+static int maintenance_task_gc(struct repository *r)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&cmd, "gc", NULL);
+
+	if (opts.auto_flag)
+		argv_array_pushl(&cmd, "--auto", NULL);
+
+	close_object_store(r->objects);
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	argv_array_clear(&cmd);
+
+	return result;
+}
+
+static int maintenance_run(struct repository *r)
+{
+	return maintenance_task_gc(r);
+}
+
+int cmd_maintenance(int argc, const char **argv, const char *prefix)
+{
+	struct repository *r = the_repository;
+
+	static struct option builtin_maintenance_options[] = {
+		OPT_BOOL(0, "auto", &opts.auto_flag,
+			 N_("run tasks based on the state of the repository")),
+		OPT_END()
+	};
+
+	memset(&opts, 0, sizeof(opts));
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_maintenance_usage,
+				   builtin_maintenance_options);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_maintenance_options,
+			     builtin_maintenance_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (argc == 1) {
+		if (!strcmp(argv[0], "run"))
+			return maintenance_run(r);
+	}
+
+	usage_with_options(builtin_maintenance_usage,
+			   builtin_maintenance_options);
+}
diff --git a/git.c b/git.c
index 2f021b97f3..ff56d1df24 100644
--- a/git.c
+++ b/git.c
@@ -527,6 +527,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
+	{ "maintenance", cmd_maintenance, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
new file mode 100755
index 0000000000..d00641c4dd
--- /dev/null
+++ b/t/t7900-maintenance.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='git maintenance builtin'
+
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_MULTI_PACK_INDEX=0
+
+. ./test-lib.sh
+
+test_expect_success 'help text' '
+	test_must_fail git maintenance -h 2>err &&
+	test_i18ngrep "usage: git maintenance run" err
+'
+
+test_expect_success 'gc [--auto]' '
+	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
+	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
+	grep ",\"gc\"]" run-no-auto.txt  &&
+	grep ",\"gc\",\"--auto\"]" run-auto.txt
+'
+
+test_done
-- 
gitgitgadget

