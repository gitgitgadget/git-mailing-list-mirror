Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BF5C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F302076C
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwCNE+8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgHYSd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYSdw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC9C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f7so13874234wrw.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZfkgU/gH4H5W+CFiXAoafxfJn1w3A8mviczuXnMlgbE=;
        b=pwCNE+8t53SMw9u5ahi9nYOe5R8baqzuvpOohH7Te2kTNsjwpcT+xhhrfsQ2qpQGF3
         toCDKlVuD4r2IBRWBHkBc+IOR3t9xKH3T5+DwgENf+xxuH2nrESuj4ITEtCD6yz/ybaT
         sFvQGDpPAy7eCwTBZkSUioLOHumn2czhCT12ShKrNym90FLA/pg250TSw0DaScEUy7/n
         cCtXukAwatItd0WaeZctaXsD02T88kHVJtxCAzHVm943xJHWmQs8w4oyWQ6ZjkOKEgVY
         Da1JKKT+NmyBKJqckZ5gIOj9iYhG1jG9N0q7vn5VU3IIklo5TTebcm3EoIAbG8RH+euy
         nHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZfkgU/gH4H5W+CFiXAoafxfJn1w3A8mviczuXnMlgbE=;
        b=L8zo5iTuZY5Z04O1O7r16jxI11d8F4jxZnLtzpPt8QLc868v54WnPkfet6oV7iuQx/
         4eOgqG6ltGKZTRDKMOy8j8F9jIZv90opguu/Kucm27siQ/Yaxnxo8CdA0rKqHxa2VAye
         brsZq1yw0HYGMdKdnKcXFM2kkAGgXV96MQ9wYejKLN97mNIQ0PNHy4UsdNYarSZ2aqph
         d6Gq5JJqzBRJGrMzRstgabJtbt65yCZ4xYlKJN5sTUL5mMWVJW74PkL1s5kaoAUhLxcn
         8lkSym5y8mlIZiWFCUMjI8BKFsG61+32M0lGN1cQ1tTcnApDiQS1PYLZ8eosnx7rEo7r
         V7cw==
X-Gm-Message-State: AOAM533nTo2JQnODgVZgKdqAJLwHFnnaHs2yoi3oA7z5eGfCQG1AGUSr
        6ExZdnPuG+TME5X3qbeW7ROGYD6u2f4=
X-Google-Smtp-Source: ABdhPJx1Sjjh5yUES6g/CP8zVkLjW+t/J4LzC3DLR83hVzm4baUwnCnZzhoj8PjgSdxKezxXvkHs0A==
X-Received: by 2002:adf:8405:: with SMTP id 5mr11776862wrf.393.1598380429315;
        Tue, 25 Aug 2020 11:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm33272499wrm.52.2020.08.25.11.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:48 -0700 (PDT)
Message-Id: <aa961af387b7f458f75ad60b9a2a45da4bb43794.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:36 +0000
Subject: [PATCH v3 01/11] maintenance: create basic maintenance runner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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

Create a new test_subcommand helper that allows us to test if a certain
subcommand was run. It requires storing the GIT_TRACE2_EVENT logs in a
file. A negation mode is available that will be used in later tests.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                        |  1 +
 Documentation/git-maintenance.txt | 57 +++++++++++++++++++++++++++++++
 builtin.h                         |  1 +
 builtin/gc.c                      | 57 +++++++++++++++++++++++++++++++
 command-list.txt                  |  1 +
 git.c                             |  1 +
 t/t7900-maintenance.sh            | 21 ++++++++++++
 t/test-lib-functions.sh           | 33 ++++++++++++++++++
 8 files changed, 172 insertions(+)
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
index 0000000000..ff47fb3641
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
+
+Git commands that add repository data, such as `git add` or `git fetch`,
+are optimized for a responsive user experience. These commands do not take
+time to optimize the Git data, since such optimizations scale with the full
+size of the repository while these user commands each perform a relatively
+small action.
+
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
+	Clean up unnecessary files and optimize the local repository. "GC"
+	stands for "garbage collection," but this task performs many
+	smaller tasks. This task can be expensive for large repositories,
+	as it repacks all Git objects into a single pack-file. It can also
+	be disruptive in some situations, as it deletes stale data. See
+	linkgit:git-gc[1] for more details on garbage collection in Git.
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
index aafa0946f5..7f2771e786 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -699,3 +699,60 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 	return 0;
 }
+
+static const char * const builtin_maintenance_run_usage[] = {
+	N_("git maintenance run [--auto]"),
+	NULL
+};
+
+struct maintenance_run_opts {
+	int auto_flag;
+};
+
+static int maintenance_task_gc(struct maintenance_run_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_push(&child.args, "gc");
+
+	if (opts->auto_flag)
+		strvec_push(&child.args, "--auto");
+
+	close_object_store(the_repository->objects);
+	return run_command(&child);
+}
+
+static int maintenance_run(int argc, const char **argv, const char *prefix)
+{
+	struct maintenance_run_opts opts;
+	struct option builtin_maintenance_run_options[] = {
+		OPT_BOOL(0, "auto", &opts.auto_flag,
+			 N_("run tasks based on the state of the repository")),
+		OPT_END()
+	};
+	memset(&opts, 0, sizeof(opts));
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_maintenance_run_options,
+			     builtin_maintenance_run_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 0)
+		usage_with_options(builtin_maintenance_run_usage,
+				   builtin_maintenance_run_options);
+	return maintenance_task_gc(&opts);
+}
+
+static const char builtin_maintenance_usage[] = N_("git maintenance run [<options>]");
+
+int cmd_maintenance(int argc, const char **argv, const char *prefix)
+{
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage(builtin_maintenance_usage);
+
+	if (!strcmp(argv[1], "run"))
+		return maintenance_run(argc - 1, argv + 1, prefix);
+
+	die(_("invalid subcommand: %s"), argv[1]);
+}
diff --git a/command-list.txt b/command-list.txt
index e5901f2213..0e3204e7d1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -117,6 +117,7 @@ git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
+git-maintenance                         mainporcelain
 git-merge                               mainporcelain           history
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
diff --git a/git.c b/git.c
index 8bd1d7551d..24f250d29a 100644
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
index 0000000000..14aa691f19
--- /dev/null
+++ b/t/t7900-maintenance.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='git maintenance builtin'
+
+. ./test-lib.sh
+
+test_expect_success 'help text' '
+	test_expect_code 129 git maintenance -h 2>err &&
+	test_i18ngrep "usage: git maintenance run" err &&
+	test_expect_code 128 git maintenance barf 2>err &&
+	test_i18ngrep "invalid subcommand: barf" err
+'
+
+test_expect_success 'run [--auto]' '
+	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" git maintenance run &&
+	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" git maintenance run --auto &&
+	test_subcommand git gc <run-no-auto.txt &&
+	test_subcommand git gc --auto <run-auto.txt
+'
+
+test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6a8e194a99..d805e73f45 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1628,3 +1628,36 @@ test_path_is_hidden () {
 	case "$("$SYSTEMROOT"/system32/attrib "$1")" in *H*?:*) return 0;; esac
 	return 1
 }
+
+# Check that the given command was invoked as part of the
+# trace2-format trace on stdin.
+#
+#	test_subcommand [!] <command> <args>... < <trace>
+#
+# For example, to look for an invocation of "git upload-pack
+# /path/to/repo"
+#
+#	GIT_TRACE2_EVENT=event.log git fetch ... &&
+#	test_subcommand git upload-pack "$PATH" <event.log
+#
+# If the first parameter passed is !, this instead checks that
+# the given command was not called.
+#
+test_subcommand () {
+	local negate=
+	if test "$1" = "!"
+	then
+		negate=t
+		shift
+	fi
+
+	local expr=$(printf '"%s",' "$@")
+	expr="${expr%,}"
+
+	if test -n "$negate"
+	then
+		! grep "\[$expr\]"
+	else
+		grep "\[$expr\]"
+	fi
+}
-- 
gitgitgadget

