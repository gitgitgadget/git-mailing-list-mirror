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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FC2C2BA17
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3085F20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5eIam3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgDCUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39077 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgDCUsT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id e9so9193605wme.4
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1JgnQCENXnxSxTBQ+dou4+ONms+UDuFcC9VU5XVFBhw=;
        b=O5eIam3cqyYBAunijAXvjzxw4fX2LML4OzJfXUqLZZeOdCZkWXxff7pGtj0V6ARirx
         unU7qT2MkPrqB8PfzYKN3PmSWkNBPEMfsrF+r6UKGGbwPYqYaz0Q3DQy52gGkpEbyD+a
         31WISvi8QCV7zidTjBtz+KcdMhIt8s1oYlB1agoIdhiFIxO8MWUOR8dXQHfEb4uYAwa8
         db6GX8IpHUuLvYTBBSBEJY6ibqsCtaHRvIbf8zG33EEphVE5Q2q93oInimNXQLhHkhq+
         c4PkKBJ/PzrMDIq31Aiy4KCXI9USsOro0B7I4sfHky0JwQKQhwYBm6rCxBnqYKKHR0aM
         C45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1JgnQCENXnxSxTBQ+dou4+ONms+UDuFcC9VU5XVFBhw=;
        b=r9ocjAxoW1FRfL/7Smt5En2Z+fXh4meo72vSamNjRd8vahNMUB72Byep4UTqqm20Xs
         yqI1sNR9KV6VP/vUWcfrBl2j1LKXwTFUo8KBiGM8nQ+PhmMX2cRl4fbqOqTkaMWzcjcm
         5HT6n/2RWwiy0oWsIW+kqvOi4zdlrDGxPp8rDvGkLEm6i3xvw7K6z08XLe9NsjVMoxt6
         9Dxp5cEoN5ADxu1RO9zm0HDeUC9y2Ds6dfwknOsbIVNFeX19c+ZzBfOX89M+ttrWfg5A
         glXnM5AuoEtF+EUU1X0QkuqbMIUFCgt5dZzCRntbvlHXZRtS2qqn7C2dUyHxrDVuDt1z
         hvpA==
X-Gm-Message-State: AGi0PuZBxf34YKUizFJWkS6HMg1OkSEYCRRgoXqKcTqg2Row55j9jukW
        Au2yKB7a84QnBE4/MvSxtKgTBXRX
X-Google-Smtp-Source: APiQypIoSbSHbwFZWuX7ep332ZsctAr5mu6JWjVpweZYjp9X5KPzbDEMMZySjehFJSUZn5RoYWOWDA==
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr10308529wme.18.1585946897161;
        Fri, 03 Apr 2020 13:48:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c85sm12795160wmd.48.2020.04.03.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:16 -0700 (PDT)
Message-Id: <cd3facd1e03923204bd2259ff0635a5bbf68d700.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:01 +0000
Subject: [PATCH 02/15] run-job: implement commit-graph job
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

The first job to implement in the 'git run-job' command is the
'commit-graph' job. It is based on the sequence of events in the
'commit-graph' job in Scalar [1]. This sequence is as follows:

1. git commit-graph write --reachable --split
2. git commit-graph verify --shallow
3. If the verify succeeds, stop.
4. Delete the commit-graph-chain file.
5. git commit-graph write --reachable --split

By writing an incremental commit-graph file using the "--split"
option we minimize the disruption from this operation. The default
behavior is to merge layers until the new "top" layer is less than
half the size of the layer below. This provides quick writes "most"
of the time, with the longer writes following a power law
distribution.

Most importantly, concurrent Git processes only look at the
commit-graph-chain file for a very short amount of time, so they
will verly likely not be holding a handle to the file when we try
to replace it. (This only matters on Windows.)

If a concurrent process reads the old commit-graph-chain file, but
our job expires some of the .graph files before they can be read,
then those processes will see a warning message (but not fail).
This could be avoided by a future update to use the --expire-time
argument when writing the commit-graph.

By using 'git commit-graph verify --shallow' we can ensure that
the file we just wrote is valid. This is an extra safety precaution
that is faster than our 'write' subcommand. In the rare situation
that the newest layer of the commit-graph is corrupt, we can "fix"
the corruption by deleting the commit-graph-chain file and rewrite
the full commit-graph as a new one-layer commit graph. This does
not completely prevent _that_ file from being corrupt, but it does
recompute the commit-graph by parsing commits from the object
database. In our use of this step in Scalar and VFS for Git, we
have only seen this issue arise because our microsoft/git fork
reverted 43d3561 ("commit-graph write: don't die if the existing
graph is corrupt" 2019-03-25) for a while to keep commit-graph
writes very fast. We dropped the revert when updating to v2.23.0.
The verify still has potential for catching corrupt data across
the layer boundary: if the new file has commit X with parent Y
in an old file but the commit ID for Y in the old file had a
bitswap, then we will notice that in the 'verify' command.

[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/CommitGraphStep.cs

RFC QUESTIONS:

1. Are links like [1] helpful?

2. Can anyone think of a way to test the rewrite fallback?
   It requires corrupting the latest file between two steps of
   this one command, so that is a tricky spot to inject a fault.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-run-job.txt | 21 ++++++++++--
 builtin/run-job.c             | 60 ++++++++++++++++++++++++++++++++++-
 commit-graph.c                |  2 +-
 commit-graph.h                |  1 +
 t/t7900-run-job.sh            | 32 +++++++++++++++++++
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index 0627b3ed259..8bf2762d650 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
 SYNOPSIS
 --------
 [verse]
-'git run-job <job-name>'
+'git run-job commit-graph'
 
 
 DESCRIPTION
@@ -28,7 +28,24 @@ BEHAVIOR MAY BE ALTERED IN THE FUTURE.
 JOBS
 ----
 
-TBD
+'commit-graph'::
+
+The `commit-graph` job updates the `commit-graph` files incrementally,
+then verifies that the written data is correct. If the new layer has an
+issue, then the chain file is removed and the `commit-graph` is
+rewritten from scratch.
++
+The verification only checks the top layer of the `commit-graph` chain.
+If the incremental write merged the new commits with at least one
+existing layer, then there is potential for on-disk corruption being
+carried forward into the new file. This will be noticed and the new
+commit-graph file will be clean as Git reparses the commit data from
+the object database.
++
+The incremental write is safe to run alongside concurrent Git processes
+since it will not expire `.graph` files that were in the previous
+`commit-graph-chain` file. They will be deleted by a later run based on
+the expiration delay.
 
 
 GIT
diff --git a/builtin/run-job.c b/builtin/run-job.c
index 2c78d053aa4..dd7709952d3 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -1,12 +1,65 @@
 #include "builtin.h"
 #include "config.h"
+#include "commit-graph.h"
+#include "object-store.h"
 #include "parse-options.h"
+#include "repository.h"
+#include "run-command.h"
 
 static char const * const builtin_run_job_usage[] = {
-	N_("git run-job"),
+	N_("git run-job commit-graph"),
 	NULL
 };
 
+static int run_write_commit_graph(void)
+{
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&cmd, "commit-graph", "write",
+			 "--split", "--reachable", "--no-progress",
+			 NULL);
+
+	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+}
+
+static int run_verify_commit_graph(void)
+{
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+
+	argv_array_pushl(&cmd, "commit-graph", "verify",
+			 "--shallow", "--no-progress", NULL);
+
+	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+}
+
+static int run_commit_graph_job(void)
+{
+	char *chain_path;
+
+	if (run_write_commit_graph()) {
+		error(_("failed to write commit-graph"));
+		return 1;
+	}
+
+	if (!run_verify_commit_graph())
+		return 0;
+
+	warning(_("commit-graph verify caught error, rewriting"));
+
+	chain_path = get_chain_filename(the_repository->objects->odb);
+	if (unlink(chain_path)) {
+		UNLEAK(chain_path);
+		die(_("failed to remove commit-graph at %s"), chain_path);
+	}
+	free(chain_path);
+
+	if (!run_write_commit_graph())
+		return 0;
+
+	error(_("failed to rewrite commit-graph"));
+	return 1;
+}
+
 int cmd_run_job(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_run_job_options[] = {
@@ -23,6 +76,11 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
 			     builtin_run_job_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	if (argc > 0) {
+		if (!strcmp(argv[0], "commit-graph"))
+			return run_commit_graph_job();
+	}
+
 	usage_with_options(builtin_run_job_usage,
 			   builtin_run_job_options);
 }
diff --git a/commit-graph.c b/commit-graph.c
index f013a84e294..6867f92d04a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -56,7 +56,7 @@ static char *get_split_graph_filename(struct object_directory *odb,
 		       oid_hex);
 }
 
-static char *get_chain_filename(struct object_directory *odb)
+char *get_chain_filename(struct object_directory *odb)
 {
 	return xstrfmt("%s/info/commit-graphs/commit-graph-chain", odb->path);
 }
diff --git a/commit-graph.h b/commit-graph.h
index e87a6f63600..8b7bd5a6cb1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -13,6 +13,7 @@
 struct commit;
 
 char *get_commit_graph_filename(struct object_directory *odb);
+char *get_chain_filename(struct object_directory *odb);
 int open_commit_graph(const char *graph_file, int *fd, struct stat *st);
 
 /*
diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
index 1eac80b7ed3..18b9bd26b3a 100755
--- a/t/t7900-run-job.sh
+++ b/t/t7900-run-job.sh
@@ -5,6 +5,8 @@ test_description='git run-job
 Testing the background jobs, in the foreground
 '
 
+GIT_TEST_COMMIT_GRAPH=0
+
 . ./test-lib.sh
 
 test_expect_success 'help text' '
@@ -12,4 +14,34 @@ test_expect_success 'help text' '
 	test_i18ngrep "usage: git run-job" err
 '
 
+test_expect_success 'commit-graph job' '
+	git init server &&
+	(
+		cd server &&
+		chain=.git/objects/info/commit-graphs/commit-graph-chain &&
+		git checkout -b master &&
+		for i in $(test_seq 1 15)
+		do
+			test_commit $i || return 1
+		done &&
+		git run-job commit-graph 2>../err &&
+		test_must_be_empty ../err &&
+		test_line_count = 1 $chain &&
+		for i in $(test_seq 16 19)
+		do
+			test_commit $i || return 1
+		done &&
+		git run-job commit-graph 2>../err &&
+		test_must_be_empty ../err &&
+		test_line_count = 2 $chain &&
+		for i in $(test_seq 20 23)
+		do
+			test_commit $i || return 1
+		done &&
+		git run-job commit-graph 2>../err &&
+		test_must_be_empty ../err &&
+		test_line_count = 1 $chain
+	)
+'
+
 test_done
-- 
gitgitgadget

