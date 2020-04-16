Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B7C38A2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C4721BE5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfmF7G1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgDPUT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730055AbgDPUTx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 16:19:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC413C061BD3
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:08 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id j20so9697567edj.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HZSarQ/bggYZtQCrXIoBP0jXCyfnrUtiFP2a4OeRkcI=;
        b=lfmF7G1uFxJpgZY2457ghYDBBf1l+EkyiJSdzQtFtD1Obto688UdmZQM+S6RzONQTc
         A551YrtQeC/ChPDk9a+0MPS+r/GNwdwyBJHy2O2YTafyilva8K8zJarLKoJ8qhOTl6mz
         svOp6I38TfwUq0ooBvAtwnUrZv91qx715Nmn92WYrzfjloKr3cm5zrXwovERA9kxyuxi
         3No0VHIfNx2Ih01VGfS4Lpcsq+rWQpHSLtR8JbXf9xoB5EoUnQFCxuJFylSobjpnE/5v
         O0eKSE/A5u+sVRaCiphYibL8WiRv11uHc7JncpcVLLyvs6F9JFZVhQm0QeguBPQca3kp
         axOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HZSarQ/bggYZtQCrXIoBP0jXCyfnrUtiFP2a4OeRkcI=;
        b=knvYsrnV15n+s31hZvAWbDBVFZovLgRyOpVv2qyuJaCV7a8vv1rT4hRQj3b/QAHDPy
         rrESvIOTaSWIrZNQvA0so3gL2FPIZZ5OPswuUpgfAzZNh3wvaeD+4sgZes+W+NuMQ5Zi
         aX2jZIa8xezeM6WD5qRmw6S/rqDghZ4o2pfbblVYTvDF8wF/uDKOPCHt7yElY1uU+CjB
         26ckr4Y05ehE1gFDYCCAYRNPDwLEO6A6U9F/QuGxxLrhJ0pEj/2EMIweU9FRFlhqoq0S
         DCXEhJk9UKz8Z0SnH62k8S2HaiRMEglsdRlltnN4oV6FzCY1MrCNlfmwbPPvs+SyUzs0
         Exog==
X-Gm-Message-State: AGi0PuZ0jqM3OZybQhGNvN/3KS+ML6XGqUptL+2Pbsi7iYKVvEg/wCdn
        2HAED5hAMpP+ZYzwa2OhoqRsXhHr
X-Google-Smtp-Source: APiQypJUd2eWJlhpoep+ntrvxWV8xPGyrecje0dSLTLwcZFvKKplScjIwotv1jW0KHKwR2QvvaCCCg==
X-Received: by 2002:a50:9d42:: with SMTP id j2mr31136962edk.249.1587068047225;
        Thu, 16 Apr 2020 13:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ce16sm3052710ejc.74.2020.04.16.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:14:06 -0700 (PDT)
Message-Id: <4073c8fe42ffbf32288c598abda527342d21bf67.1587068044.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
References: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
        <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 20:14:03 +0000
Subject: [PATCH v3 2/3] tests: write commit-graph with Bloom filters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The GIT_TEST_COMMIT_GRAPH environment variable updates the commit-
graph file whenever "git commit" is run, ensuring that we always
have an updated commit-graph throughout the test suite. The
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variable was
introduced to write the changed-path Bloom filters whenever "git
commit-graph write" is run. However, the GIT_TEST_COMMIT_GRAPH
trick doesn't launch a separate process and instead writes it
directly.

To expand the number of tests that have commits in the commit-graph
file, add a helper method that computes the commit-graph and place
that helper inside "git commit" and "git merge".

In the helper method, check GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS
to ensure we are writing changed-path Bloom filters whenever
possible.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c |  4 +---
 builtin/merge.c  |  7 +++++--
 commit-graph.c   | 14 ++++++++++++++
 commit-graph.h   |  9 +++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d3e7781e658..27d4ff6b790 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1700,9 +1700,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "new_index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git restore --staged :/\" to recover."));
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
-	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
-		return 1;
+	git_test_write_commit_graph_or_die();
 
 	repo_rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
diff --git a/builtin/merge.c b/builtin/merge.c
index d127d2225f8..db11af5b1cd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -40,6 +40,7 @@
 #include "branch.h"
 #include "commit-reach.h"
 #include "wt-status.h"
+#include "commit-graph.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -1673,9 +1674,11 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				   head_commit);
 	}
 
-	if (squash)
+	if (squash) {
 		finish(head_commit, remoteheads, NULL, NULL);
-	else
+
+		git_test_write_commit_graph_or_die();
+	} else
 		write_merge_state(remoteheads);
 
 	if (merge_was_ok)
diff --git a/commit-graph.c b/commit-graph.c
index 77668629e27..0809f34f8d3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,20 @@
 #include "bloom.h"
 #include "commit-slab.h"
 
+void git_test_write_commit_graph_or_die(void)
+{
+	int flags = 0;
+	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
+		return;
+
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
+		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
+	
+	if (write_commit_graph_reachable(the_repository->objects->odb,
+					 flags, NULL))
+		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
+}
+
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
diff --git a/commit-graph.h b/commit-graph.h
index 8655d064c14..39484482cc1 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,15 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
+/*
+ * This method is only used to enhance coverage of the commit-graph
+ * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
+ * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
+ * call this method oustide of a builtin, and only if you know what
+ * you are doing!
+ */
+void git_test_write_commit_graph_or_die(void);
+
 struct commit;
 struct bloom_filter_settings;
 
-- 
gitgitgadget

