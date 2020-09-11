Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DCC43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C7B21D81
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 17:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1d+riXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgIKRto (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgIKRt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 13:49:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADB3C061786
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a65so5164915wme.5
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LJaF+KBq6DinuUhew6phz3UG9LLuWbKh+8DAyadGgBc=;
        b=M1d+riXoKMGkP7Ul1HrRZ5KvYKi4hN28eo5aP9TDAAhhe9YcXTpgb0q7gA4yT2vbHO
         cOzY0uTNDVAZGOO5lkMjmi1NXFFUIyODQetsAUakHFzvY52EC9Rn83J9ilNbQIxxOBgl
         +vHsnPBbL/0oBYDi1y6IkbUqrceGX1TsMGj46GXXRSp+t/j/jXLiUVr/RaIOHnAeAF5w
         NlUg+eI2MIyeffl3kc6vxYknRejHSC0UB4AegY96C0/PFWcE66jgBqkLgk1d2Sp79ZuE
         vXqTub265xYSpdLljRoCOk8t2tZpEa6R/8Ynw8j9RGLoEErIh5LJSO5glRhSkVk2ehT+
         i0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LJaF+KBq6DinuUhew6phz3UG9LLuWbKh+8DAyadGgBc=;
        b=rFuDvn9G539+dVTt8LPzc8zbqUJlbf46vY4qUh36EVd5xX/wj91SAJG8kbTn2q5qDt
         XM+VLHiJCuiWxNhLl0TjkF+jVDEm/nLf1HwO8fNasi9t6MGPieIDXsgjrTJ1/coYkkhl
         uww55exnrsCnN9giq4LLwmNVbzJFqdC7ocPumBEgGC6DxlbL4+LSOctex+B5GuAueN6e
         x6WoF2pRkq3Ovh/fqy1juCqH7MJKEhZtJ/4RAq4MnIRJWp2LQ5vzCGdxib95ogQ+Lwvt
         XeEvrBTDZoQ0VsEvXKoYHmMy85ObqNv57Ah+nigRePGCu0eRHF6Vr2Tca6yyUdm6KOcP
         tc4w==
X-Gm-Message-State: AOAM531aFC1U3osMKnxHc+uYEIouP03okvv2aZAdXrvaTTzsQ3lQQjJl
        1iIqJqp3ZrZMsMyyt5ZXIXphB0kmu/k=
X-Google-Smtp-Source: ABdhPJyLwadbInpZp2N2mrb9d5L6Q/jOlffofqHxLy9q7wX1l7ave6O9iNSrzXollcKF0ULeMuloVA==
X-Received: by 2002:a05:600c:204e:: with SMTP id p14mr3172551wmg.182.1599846564856;
        Fri, 11 Sep 2020 10:49:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s67sm6014949wmf.38.2020.09.11.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 10:49:24 -0700 (PDT)
Message-Id: <41a346dfbb5b4173ddea39f6eabd13f84b8f09cd.1599846561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
        <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 17:49:16 +0000
Subject: [PATCH v2 3/7] for-each-repo: run subcommands on configured repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, jonathantanmy@google.com, sluongng@gmail.com,
        congdanhqx@gmail.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
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

