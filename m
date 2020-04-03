Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF6C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E015E20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA4dpybI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDCUsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38340 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDCUsS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:18 -0400
Received: by mail-wr1-f50.google.com with SMTP id c7so10082841wrx.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=teXXy5BoYJHLBt4oWczXBfR6KQEw9SY7wGx5TkleWzY=;
        b=cA4dpybIVCRRiubJZeEDlYXqYqw/s0iABQLspytzhu2G0B26uv3kXScLXEKdVyxUhb
         XOyMe7qHk6BLOTrPyXDnmBGr1xPaVSUvPEZY3TBc+v1GSXToJTJ2l8DhFYCm5wE3gKD+
         /rWUuefIXGSThN6MiFRGtqk0IcoQkaCd6w00vuv9kzt9TY0aZ/bUVMjHiF1DVH9PT0UR
         917l1x06UG2Ore12/iRgHKrHNgFyxr3K2sKdaMAQ+RftlFUGktZh1bNC3q818AzhyB/h
         psz45V9SjjE6XOHfXED8SuVm3F3SUwCCe/i0KzxeiazLM1/Ht4RBnkLxpO7Ii50sGoor
         bEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=teXXy5BoYJHLBt4oWczXBfR6KQEw9SY7wGx5TkleWzY=;
        b=FwALjHSP1MDok0rlXt1tuCo5tBo4L31P+8s1sjYvl2TfGwH1VS0x8NCZvIvZ/D1luf
         KCphTxGy0dYSirZw0MtgUvDp9KnTZk7UsWwFgTXFACA+Yk7Ag7FxsaulAhtZbbfzuhOF
         9Oqb5Dm8Bk4mn4aDqfn+I/6ZIUHBhEddj1hE4zxZcOG6xLNnQlzSFNqbOt60oqD3f+fw
         r6KSc7XNJxNkjKHS8TUrE+owP8I2Fg48+iXOdJz/WUrO00l2ygXNyjiOAmwblS+JtZFq
         TsrMa+JPGGItVWT6YeKvVtoUUEXXAptr0gCYNrASC+4gS2KKhlb/dCHD4VE58qeTqT9Q
         LeIQ==
X-Gm-Message-State: AGi0PuYkpW6cCau1wDk0PtpnGOioJ5yslOFNxPkXLbSDVM1PbQV3u3V9
        6WH+KFEKwyJqYgt60BfLYCMgQnhI
X-Google-Smtp-Source: APiQypJ6/2g99jV5nXjAMDDUaTx92z/uMV0cFq+/nNMPY7cRXW+PK7zACUAh5ht8bgIdXB4CJ24IrA==
X-Received: by 2002:adf:e744:: with SMTP id c4mr10415854wrn.133.1585946896247;
        Fri, 03 Apr 2020 13:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm13447509wrq.26.2020.04.03.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:15 -0700 (PDT)
Message-Id: <665da239774419074a9bae49b9c92b340885bfa3.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:00 +0000
Subject: [PATCH 01/15] run-job: create barebones builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git run-job' command will be used to execute a short-lived set
of maintenance activities by a background job manager. The intention
is to perform small batches of work that reduce the foreground time
taken by repository maintenance such as 'git gc --auto'.

This change does the absolute minimum to create the builtin and show
the usage output.

Provide an explicit warning that this command is experimental. The
set of jobs may change, and each job could alter its behavior in
future versions.

RFC QUESTION: This builtin is based on the background maintenance in
Scalar. Specifically, this builtin is based on the "scalar run <job>"
command [1] [2]. My default thought was to make this a "git run <job>"
command to maximize similarity. However, it seems like "git run" is
too generic. Or, am I being overly verbose for no reason?

[1] https://github.com/microsoft/scalar/blob/master/docs/advanced.md#run-maintenance-in-the-foreground
[2] https://github.com/microsoft/scalar/blob/master/Scalar/CommandLine/RunVerb.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                    |  1 +
 Documentation/git-run-job.txt | 36 +++++++++++++++++++++++++++++++++++
 Makefile                      |  1 +
 builtin.h                     |  1 +
 builtin/run-job.c             | 28 +++++++++++++++++++++++++++
 command-list.txt              |  1 +
 git.c                         |  1 +
 t/t7900-run-job.sh            | 15 +++++++++++++++
 8 files changed, 84 insertions(+)
 create mode 100644 Documentation/git-run-job.txt
 create mode 100644 builtin/run-job.c
 create mode 100755 t/t7900-run-job.sh

diff --git a/.gitignore b/.gitignore
index 188bd1c3de1..5dea9d3b96b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -144,6 +144,7 @@
 /git-rev-parse
 /git-revert
 /git-rm
+/git-run-job
 /git-send-email
 /git-send-pack
 /git-serve
diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
new file mode 100644
index 00000000000..0627b3ed259
--- /dev/null
+++ b/Documentation/git-run-job.txt
@@ -0,0 +1,36 @@
+git-run-job(1)
+==============
+
+NAME
+----
+git-run-job - Run a maintenance job. Intended for background operation.
+
+
+SYNOPSIS
+--------
+[verse]
+'git run-job <job-name>'
+
+
+DESCRIPTION
+-----------
+
+Run a maintenance job on the current repository. This is available as a
+command for a few reasons. First, the background job feature can launch
+these commands on a schedule and each process will completely clear its
+memory when complete. Second, an expert user could create their own job
+schedule by running these jobs themselves.
+
+THIS COMMAND IS EXPERIMENTAL. THE SET OF AVAILABLE JOBS OR THEIR EXACT
+BEHAVIOR MAY BE ALTERED IN THE FUTURE.
+
+
+JOBS
+----
+
+TBD
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index ef1ff2228f0..f5f9c4d9e94 100644
--- a/Makefile
+++ b/Makefile
@@ -1125,6 +1125,7 @@ BUILTIN_OBJS += builtin/rev-list.o
 BUILTIN_OBJS += builtin/rev-parse.o
 BUILTIN_OBJS += builtin/revert.o
 BUILTIN_OBJS += builtin/rm.o
+BUILTIN_OBJS += builtin/run-job.o
 BUILTIN_OBJS += builtin/send-pack.o
 BUILTIN_OBJS += builtin/shortlog.o
 BUILTIN_OBJS += builtin/show-branch.o
diff --git a/builtin.h b/builtin.h
index 2b25a80cde3..3e0ddaaf67f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -220,6 +220,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix);
 int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 int cmd_revert(int argc, const char **argv, const char *prefix);
 int cmd_rm(int argc, const char **argv, const char *prefix);
+int cmd_run_job(int argc, const char **argv, const char *prefix);
 int cmd_send_pack(int argc, const char **argv, const char *prefix);
 int cmd_shortlog(int argc, const char **argv, const char *prefix);
 int cmd_show(int argc, const char **argv, const char *prefix);
diff --git a/builtin/run-job.c b/builtin/run-job.c
new file mode 100644
index 00000000000..2c78d053aa4
--- /dev/null
+++ b/builtin/run-job.c
@@ -0,0 +1,28 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+
+static char const * const builtin_run_job_usage[] = {
+	N_("git run-job"),
+	NULL
+};
+
+int cmd_run_job(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_run_job_options[] = {
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_run_job_usage,
+				   builtin_run_job_options);
+
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix,
+			     builtin_run_job_options,
+			     builtin_run_job_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	usage_with_options(builtin_run_job_usage,
+			   builtin_run_job_options);
+}
diff --git a/command-list.txt b/command-list.txt
index 20878946558..1cd2b415e46 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -156,6 +156,7 @@ git-revert                              mainporcelain
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           plumbinginterrogators
 git-rm                                  mainporcelain           worktree
+git-run-job                             plumbingmanipulators
 git-send-email                          foreignscminterface             complete
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
diff --git a/git.c b/git.c
index b07198fe036..db5a43c8687 100644
--- a/git.c
+++ b/git.c
@@ -566,6 +566,7 @@ static struct cmd_struct commands[] = {
 	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
 	{ "rm", cmd_rm, RUN_SETUP },
+	{ "run-job", cmd_run_job, RUN_SETUP },
 	{ "send-pack", cmd_send_pack, RUN_SETUP },
 	{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 	{ "show", cmd_show, RUN_SETUP },
diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
new file mode 100755
index 00000000000..1eac80b7ed3
--- /dev/null
+++ b/t/t7900-run-job.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+test_description='git run-job
+
+Testing the background jobs, in the foreground
+'
+
+. ./test-lib.sh
+
+test_expect_success 'help text' '
+	test_must_fail git run-job -h 2>err &&
+	test_i18ngrep "usage: git run-job" err
+'
+
+test_done
-- 
gitgitgadget

