Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E35C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED4622254
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCSqPAUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404917AbgJORWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404910AbgJORWL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 13:22:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F3C0613D3
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so3994999wmf.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LJaF+KBq6DinuUhew6phz3UG9LLuWbKh+8DAyadGgBc=;
        b=qCSqPAUn8rMb/7SKQZramiryFa0Ead9keF23w3VNwb3WNtNFnMGSoVnA9Slzr15IZi
         rnWD0/YghxzEojyCJHdzxy1Yuno5ZKrx3qOddO12peXc/iYPHO6qRNnqJGyuWfbIYodM
         DXKtroBJLs3E+qr89vAe1gEU02v8mAs9TSroLpwA8Rgo5o2WOXexbANC131R52ru1IjZ
         oOV8BJi7+rpy5Sfx/yibUwaCi7UajyB1ER3QvF5yIqiflEN1YVbdLUc06Z2adHL/vb7m
         td1NAmk/zYOeDNa7J6dmU7ZMcpi4e671/LOWDwmdrvDvX1Ij2rzV11NdepWMNCySASAK
         paUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LJaF+KBq6DinuUhew6phz3UG9LLuWbKh+8DAyadGgBc=;
        b=P2ESsg45tSchmI0nEhvyHJPFoHrAFCL4FcPdZZm/0H4dIuRbEusEY1SGgn3oiP4aKx
         2LVCCPVJL46BSnxcEDYOCbQU9X+uzPaxWe1ujsEyEYZk5Cu79usk5g+Vm0K3hrozcgnw
         dPBVgfHEtMFMEsmORVS9+jN0RQXfG/q8a30DNAzANbPKHzUZ/AtW7T0GMcrQfQR8zSOn
         dZwQSY1/QB+NnkHqlTruUqNinGhIGcVzoBlTnro1XjtqLLtUA1WgxJEHhqm6RaOsXpvA
         OEJXxr7zxawc/jJHzgM3zt/m5vgPLvuW/GjQtm3kdhFLHKape6HPYm/jC4ZIbhu+x6II
         ogag==
X-Gm-Message-State: AOAM532ATb1E3HG9VQhItlMV1ZSvk5bJ1ZOU3Fv4cYiKWWm7OdrulJ5j
        S9mdtLEYO3amZvg1nXcFPSrKrCS5tOs=
X-Google-Smtp-Source: ABdhPJw8ptnblE8AwJKPhgY7UKt+AT8CyqNU8EdFObzxo1wbOELWZwEMFCQOzuzSYKfXp8j+MMl1/g==
X-Received: by 2002:a1c:4056:: with SMTP id n83mr5062525wma.186.1602782527923;
        Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm5482746wmn.28.2020.10.15.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:22:07 -0700 (PDT)
Message-Id: <dd9237927395ef69663ab376a2da74da4654c495.1602782524.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
        <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Oct 2020 17:21:59 +0000
Subject: [PATCH v4 3/8] for-each-repo: run subcommands on configured repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

It can be helpful to store a list of repositories in global or system
config and then iterate Git commands on that list. Create a new builtin
that makes this process simple for experts. We will use this builtin to
run scheduled maintenance on all configured repositories in a future
change.

The test is very simple, but does highlight that the "--" argument is
optional.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                          |  1 +
 Documentation/git-for-each-repo.txt | 59 +++++++++++++++++++++++++++++
 Makefile                            |  1 +
 builtin.h                           |  1 +
 builtin/for-each-repo.c             | 58 ++++++++++++++++++++++++++++
 command-list.txt                    |  1 +
 git.c                               |  1 +
 t/t0068-for-each-repo.sh            | 30 +++++++++++++++
 8 files changed, 152 insertions(+)
 create mode 100644 Documentation/git-for-each-repo.txt
 create mode 100644 builtin/for-each-repo.c
 create mode 100755 t/t0068-for-each-repo.sh

diff --git a/.gitignore b/.gitignore
index a5808fa30d..5eb2a2be71 100644
--- a/.gitignore
+++ b/.gitignore
@@ -67,6 +67,7 @@
 /git-filter-branch
 /git-fmt-merge-msg
 /git-for-each-ref
+/git-for-each-repo
 /git-format-patch
 /git-fsck
 /git-fsck-objects
diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
new file mode 100644
index 0000000000..94bd19da26
--- /dev/null
+++ b/Documentation/git-for-each-repo.txt
@@ -0,0 +1,59 @@
+git-for-each-repo(1)
+====================
+
+NAME
+----
+git-for-each-repo - Run a Git command on a list of repositories
+
+
+SYNOPSIS
+--------
+[verse]
+'git for-each-repo' --config=<config> [--] <arguments>
+
+
+DESCRIPTION
+-----------
+Run a Git command on a list of repositories. The arguments after the
+known options or `--` indicator are used as the arguments for the Git
+subprocess.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+For example, we could run maintenance on each of a list of repositories
+stored in a `maintenance.repo` config variable using
+
+-------------
+git for-each-repo --config=maintenance.repo maintenance run
+-------------
+
+This will run `git -C <repo> maintenance run` for each value `<repo>`
+in the multi-valued config variable `maintenance.repo`.
+
+
+OPTIONS
+-------
+--config=<config>::
+	Use the given config variable as a multi-valued list storing
+	absolute path names. Iterate on that list of paths to run
+	the given arguments.
++
+These config values are loaded from system, global, and local Git config,
+as available. If `git for-each-repo` is run in a directory that is not a
+Git repository, then only the system and global config is used.
+
+
+SUBPROCESS BEHAVIOR
+-------------------
+
+If any `git -C <repo> <arguments>` subprocess returns a non-zero exit code,
+then the `git for-each-repo` process returns that exit code without running
+more subprocesses.
+
+Each `git -C <repo> <arguments>` subprocess inherits the standard file
+descriptors `stdin`, `stdout`, and `stderr`.
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 65f8cfb236..7c588ff036 100644
--- a/Makefile
+++ b/Makefile
@@ -1071,6 +1071,7 @@ BUILTIN_OBJS += builtin/fetch-pack.o
 BUILTIN_OBJS += builtin/fetch.o
 BUILTIN_OBJS += builtin/fmt-merge-msg.o
 BUILTIN_OBJS += builtin/for-each-ref.o
+BUILTIN_OBJS += builtin/for-each-repo.o
 BUILTIN_OBJS += builtin/fsck.o
 BUILTIN_OBJS += builtin/gc.o
 BUILTIN_OBJS += builtin/get-tar-commit-id.o
diff --git a/builtin.h b/builtin.h
index 17c1c0ce49..ff7c6e5aa9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -150,6 +150,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix);
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix);
 int cmd_format_patch(int argc, const char **argv, const char *prefix);
 int cmd_fsck(int argc, const char **argv, const char *prefix);
 int cmd_gc(int argc, const char **argv, const char *prefix);
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
new file mode 100644
index 0000000000..5bba623ff1
--- /dev/null
+++ b/builtin/for-each-repo.c
@@ -0,0 +1,58 @@
+#include "cache.h"
+#include "config.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "string-list.h"
+
+static const char * const for_each_repo_usage[] = {
+	N_("git for-each-repo --config=<config> <command-args>"),
+	NULL
+};
+
+static int run_command_on_repo(const char *path,
+			       void *cbdata)
+{
+	int i;
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct strvec *args = (struct strvec *)cbdata;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "-C", path, NULL);
+
+	for (i = 0; i < args->nr; i++)
+		strvec_push(&child.args, args->v[i]);
+
+	return run_command(&child);
+}
+
+int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
+{
+	static const char *config_key = NULL;
+	int i, result = 0;
+	const struct string_list *values;
+	struct strvec args = STRVEC_INIT;
+
+	const struct option options[] = {
+		OPT_STRING(0, "config", &config_key, N_("config"),
+			   N_("config key storing a list of repository paths")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, for_each_repo_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (!config_key)
+		die(_("missing --config=<config>"));
+
+	for (i = 0; i < argc; i++)
+		strvec_push(&args, argv[i]);
+
+	values = repo_config_get_value_multi(the_repository,
+					     config_key);
+
+	for (i = 0; !result && i < values->nr; i++)
+		result = run_command_on_repo(values->items[i].string, &args);
+
+	return result;
+}
diff --git a/command-list.txt b/command-list.txt
index 0e3204e7d1..581499be82 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -94,6 +94,7 @@ git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
+git-for-each-repo                       plumbinginterrogators
 git-format-patch                        mainporcelain
 git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
diff --git a/git.c b/git.c
index 24f250d29a..1cab64b5d1 100644
--- a/git.c
+++ b/git.c
@@ -511,6 +511,7 @@ static struct cmd_struct commands[] = {
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
 	{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
+	{ "for-each-repo", cmd_for_each_repo, RUN_SETUP_GENTLY },
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
new file mode 100755
index 0000000000..136b4ec839
--- /dev/null
+++ b/t/t0068-for-each-repo.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='git for-each-repo builtin'
+
+. ./test-lib.sh
+
+test_expect_success 'run based on configured value' '
+	git init one &&
+	git init two &&
+	git init three &&
+	git -C two commit --allow-empty -m "DID NOT RUN" &&
+	git config run.key "$TRASH_DIRECTORY/one" &&
+	git config --add run.key "$TRASH_DIRECTORY/three" &&
+	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
+	git -C one log -1 --pretty=format:%s >message &&
+	grep ran message &&
+	git -C two log -1 --pretty=format:%s >message &&
+	! grep ran message &&
+	git -C three log -1 --pretty=format:%s >message &&
+	grep ran message &&
+	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
+	git -C one log -1 --pretty=format:%s >message &&
+	grep again message &&
+	git -C two log -1 --pretty=format:%s >message &&
+	! grep again message &&
+	git -C three log -1 --pretty=format:%s >message &&
+	grep again message
+'
+
+test_done
-- 
gitgitgadget

