Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62FFC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E07F20829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTwG23S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgG3WYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgG3WYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83BFC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7023473wmg.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VkMfmEWQ19rREUTd8nLWnILvhKOacPDW1DoUVs4XDpE=;
        b=KTwG23S3XhLut07OdeFvL5sagSiTgjwr5Lm1uQJfcsOSQaV8MKRZ500WekgkitQzeb
         d6PJV6J2mI2je+n4LZIbLRAdXqcox8NLVqqMDEI4zK+hNilFQEjbMwK0v3hfL/WZoFWJ
         7QG/L3VYYvRC6M6QTe+g+fPeVJMw/HJMofUGOIXReyk2MmjbMykkqZ5WWAhF8PQCjquH
         bc0v06gjcFa6gQ+9xpCEo1SYJWUicUkENIiSmXsn5/JsUjd7QwYNqQixB8slfvj6pdE4
         RNw0zBWc43+AbpNhnIFPvJdRfussZJf+waXssUotzU/nQy1j/s0KnIrdKrNifSlwL5np
         42lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VkMfmEWQ19rREUTd8nLWnILvhKOacPDW1DoUVs4XDpE=;
        b=lxqSEZ6dRvS765y5JizsFtf2VwrMCPN5qZ78g3WsHGTZ0T8XoZNvAMBBFVlM0Lzgdr
         nYi7x24Fa7ME6w7NEBbWAqg4yAGfHuz+7VFH8+PlVZNGPQ+rw+6cCBz86blGPO48fSAV
         DCQISqZVfSW8CTkmJ+xXy3EsMyW9n+cw2jHIv8uqjbPomjPQJ5SNvU/7MiwBUUwvB7A7
         vW1M4rDrudJuFkSiMXRRtXT9d2relMOxAk6y/d3n9ylGcyUHMsumRmLKZabpOfuM6GB9
         WVK8GG6UHUucCuxZ43IRfUWtt0Ao05VYFFxizjIKkI2JnlPMrMF5v89zVT8EPhUAJXjC
         SYUw==
X-Gm-Message-State: AOAM533ikB8c44OdQEbhAcIt3FpPdlVn417XHNiXqU1Lr3db3Nrrm31E
        c14q7goH253s4w2x4Zi7/378u5gR
X-Google-Smtp-Source: ABdhPJyPXrc3Cae/e0+4HFgt58XZ66n97RKfe8If4NkRjHzF54Iofgw8373Tiq3TXzbkVECJ0krdIg==
X-Received: by 2002:a05:600c:c7:: with SMTP id u7mr1138891wmm.135.1596147878200;
        Thu, 30 Jul 2020 15:24:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 111sm11795858wrc.53.2020.07.30.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:33 -0700 (PDT)
Message-Id: <12fe73bb72bf2193967979acf68f7645b339eaa2.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:07 +0000
Subject: [PATCH v3 01/20] maintenance: create basic maintenance runner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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
 Documentation/git-maintenance.txt | 57 +++++++++++++++++++++++++++++++
 builtin.h                         |  1 +
 builtin/gc.c                      | 56 ++++++++++++++++++++++++++++++
 git.c                             |  1 +
 t/t7900-maintenance.sh            | 19 +++++++++++
 6 files changed, 135 insertions(+)
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
index 10346e0465..be9557452e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -699,3 +699,59 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+
+static const char * const builtin_maintenance_usage[] = {
+	N_("git maintenance run [<options>]"),
+	NULL
+};
+
+static struct maintenance_opts {
+	int auto_flag;
+} opts;
+
+static int maintenance_task_gc(void)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_push(&child.args, "gc");
+
+	if (opts.auto_flag)
+		strvec_push(&child.args, "--auto");
+
+	close_object_store(the_repository->objects);
+	return run_command(&child);
+}
+
+static int maintenance_run(void)
+{
+	return maintenance_task_gc();
+}
+
+int cmd_maintenance(int argc, const char **argv, const char *prefix)
+{
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
+			return maintenance_run();
+	}
+
+	usage_with_options(builtin_maintenance_usage,
+			   builtin_maintenance_options);
+}
diff --git a/git.c b/git.c
index 832688ca23..5bb9645403 100644
--- a/git.c
+++ b/git.c
@@ -529,6 +529,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
+	{ "maintenance", cmd_maintenance, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
new file mode 100755
index 0000000000..0e864eaaed
--- /dev/null
+++ b/t/t7900-maintenance.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='git maintenance builtin'
+
+. ./test-lib.sh
+
+test_expect_success 'help text' '
+	test_expect_code 129 git maintenance -h 2>err &&
+	test_i18ngrep "usage: git maintenance run" err
+'
+
+test_expect_success 'run [--auto]' '
+	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
+	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
+	grep ",\"gc\"]" run-no-auto.txt  &&
+	grep ",\"gc\",\"--auto\"]" run-auto.txt
+'
+
+test_done
-- 
gitgitgadget

