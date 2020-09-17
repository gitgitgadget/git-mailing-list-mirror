Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF237C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8473821973
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5mJJrr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIQSO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIQSNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 14:13:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB8C06178C
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so2993698wmk.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vNtWHBN7M0cYUSQ8zQboy/d2MWOPkS9i3tmUGka7CzU=;
        b=A5mJJrr2mSYkYw9fJICFdGwiWH0GOyUvdQgFK+uDnpln22ff1WlOIlGCC/3P1WhpVJ
         ZhjiodmuYT6o7BbqA52Gprv46Nf+6E6P+6HZhuZk7Z6A7hNuXTKznwdizOtltB3GC7Id
         wTaVRFM8jSINZJMyBGRD1z8d+ReSUb5wfomyNAqruS8nSsCJwJUbFaD17m9Jgde6xudZ
         PaikEoqJOkonN1OPJqZPtVv2dobAjCDH8vphzKXNK7EXO+3OoaVdI/rBVLdqB2QjQ6l7
         EFouUy9FR0It5agNu4eyIkBwItBmCkUbjKQ8hQUC90/oevG/YVINb9+A9IFT5fWTutUC
         E2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vNtWHBN7M0cYUSQ8zQboy/d2MWOPkS9i3tmUGka7CzU=;
        b=A4FripClTwQdbE1WLv0iqNhfk0OAA0r5v9+WZox/gkbG2kg6XzvgSAk2Ses3PeDnn8
         HRMMTFXnb+DhrkzXg/+M4gp8dWIJ6bIKJNgLPNA19wDcxRTXYqkznnlqtN0MEB1AN1J3
         FKB7AoD4Cu8cw/zdB0o2zepH2rLkogpU0wD6MQXwpYok9mNuN+6z1nXAZiEw90mKobDr
         LjWjd9kkx/kd97s4vfXC2QbBYJYEcOxIwMYQ951qdwI0tR7+lgCL3w8QvwZTVkfkoXTp
         qZSYChRKIn9uaAFR3z2p1+0kSucs2NfYgh0fQ9eh8LUJuifE3TqXRcJ+zzfkxlM8IQ1E
         MNgw==
X-Gm-Message-State: AOAM531AQTkQTs3ahWUmVmiZO5WVaON6rwhT2EoIjeid7gBilKxuzDoc
        /aw1R3asP61GrqMTGjlawJZdEEb2/2o=
X-Google-Smtp-Source: ABdhPJypXObR8MlQuDovOpboMi+mb3t0i2fnidrGo1WSeDs0pn/5TPKU7hEAvIlV9MBXTUGCJlKVig==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr11499908wml.42.1600366315288;
        Thu, 17 Sep 2020 11:11:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm363842wmg.23.2020.09.17.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 11:11:54 -0700 (PDT)
Message-Id: <00a0d63508be1010df547a0ac56c73ec5df116b9.1600366313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
References: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
        <pull.695.v5.git.1600366313.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Sep 2020 18:11:42 +0000
Subject: [PATCH v5 01/11] maintenance: create basic maintenance runner
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                        |  1 +
 Documentation/git-maintenance.txt | 57 ++++++++++++++++++++++++++++++
 builtin.h                         |  1 +
 builtin/gc.c                      | 58 +++++++++++++++++++++++++++++++
 command-list.txt                  |  1 +
 git.c                             |  1 +
 t/t7900-maintenance.sh            | 23 ++++++++++++
 t/test-lib-functions.sh           | 33 ++++++++++++++++++
 8 files changed, 175 insertions(+)
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
index aafa0946f5..ec064e8686 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -699,3 +699,61 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
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
+	if (argc < 2 ||
+	    (argc == 2 && !strcmp(argv[1], "-h")))
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
index 0000000000..c2f0b1d0c0
--- /dev/null
+++ b/t/t7900-maintenance.sh
@@ -0,0 +1,23 @@
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
+	test_i18ngrep "invalid subcommand: barf" err &&
+	test_expect_code 129 git maintenance 2>err &&
+	test_i18ngrep "usage: git maintenance" err
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

