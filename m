Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DDBC433E2
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25F3206D4
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 17:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHoF+Y1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbgFWRrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732549AbgFWRrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 13:47:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BC9C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so9697274wrw.5
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UiCtqTJGVEULmS7sPq1CCgWHFh2xZ9/Kbd4Wgi4nLYI=;
        b=cHoF+Y1KtYEzyWlkH2HA32I0VkomZd6vrelTAfxvTmhoWz5+nf7Ig/TcQOMeUfo0nS
         8r8f3+E13hQfcCFkoArog9OlCcQuWkHSgPYVzcYdUZbKtokBwHIqtByH9+qqEMOUQu3w
         0rq4gvOkGedm2Rbg2iDAT7YkS5nkYlqB9E2uBcnMEKDSJyWWwO+6ZKZoEamtyjFsHnfP
         e3GZT0bO4GKgiGXHTEdmUGmoNq1Yq+kvkyZjWRap/kvYLoNZCr/F1Iv2GY9yuQ3ZFoWY
         8nxbbnnbrqsqd9mWaQmS80qmI5iiXhZYv7erIb7CnpPk/dI+PJlC/6ue0jSoWAAhEBXf
         eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UiCtqTJGVEULmS7sPq1CCgWHFh2xZ9/Kbd4Wgi4nLYI=;
        b=pqUkeiHphugFH+XURMPsM7ISoRb2FW6jRZEIq6pUvmWqMkalaua1kKaSAQ9cx5iWIB
         M3mcWrFale9H/qllku3ttoAzsOeUhTeonxoqnDPeeHo7KfZRU7gXdHJsmLYM4K1GsKrs
         AAoAoXuxQmAMz86evMwAGlf4xzp6D2OMXnY7iyv9EoD2tdPX/UhOcWi1vE/l6sEABvyj
         yxEAzOtYzuelFzRG4W7Aewzf+61i9y+jmhLGxcd8ImEgN8bSJD0F+g5rBMbI8IP6FfOf
         KXPfDgaiUltl2jgXXUU8G0vVaceG9Uqova1Wf8GLPG0ZvYRviXzL9/xDBDTEypwujnrF
         hcqg==
X-Gm-Message-State: AOAM5336kITvpPjzSyQbByiPDbcOf9b9wPhi51/ca4gxiFKesQkdVmkd
        JD+cMTJuSIMhkrFd5XOug9dpl2Z1
X-Google-Smtp-Source: ABdhPJwyR5ddMAyG9eEPAjR72Xh5LyvEcfEYsOmYq51O5a/fZNdtlYLu0PC6NqpwCKrUwPPcvpZ2hA==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr26819030wro.317.1592934433670;
        Tue, 23 Jun 2020 10:47:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm4665437wmb.24.2020.06.23.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:47:13 -0700 (PDT)
Message-Id: <6b63f9bd8a2a7e18d7ac1be7066d4bcd1df2a729.1592934430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:47:01 +0000
Subject: [PATCH v2 02/11] commit-graph: change test to die on parse, not load
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

43d3561 (commit-graph write: don't die if the existing graph is corrupt,
2019-03-25) introduced the GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD environment
variable. This was created to verify that commit-graph was not loaded
when writing a new non-incremental commit-graph.

An upcoming change wants to load a commit-graph in some valuable cases,
but we want to maintain that we don't trust the commit-graph data when
writing our new file. Instead of dying on load, instead die if we ever
try to parse a commit from the commit-graph. This functionally verifies
the same intended behavior, but allows a more advanced feature in the
next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 12 ++++++++----
 commit-graph.h          |  2 +-
 t/t5318-commit-graph.sh |  2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index d0fedcd9b1..6a28d4a5a6 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -564,10 +564,6 @@ static int prepare_commit_graph(struct repository *r)
 		return !!r->objects->commit_graph;
 	r->objects->commit_graph_attempted = 1;
 
-	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
-		die("dying as requested by the '%s' variable on commit-graph load!",
-		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
-
 	prepare_repo_settings(r);
 
 	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
@@ -790,6 +786,14 @@ static int parse_commit_in_graph_one(struct repository *r,
 
 int parse_commit_in_graph(struct repository *r, struct commit *item)
 {
+	static int checked_env = 0;
+
+	if (!checked_env &&
+	    git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE, 0))
+		die("dying as requested by the '%s' variable on commit-graph parse!",
+		    GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE);
+	checked_env = 1;
+
 	if (!prepare_commit_graph(r))
 		return 0;
 	return parse_commit_in_graph_one(r, r->objects->commit_graph, item);
diff --git a/commit-graph.h b/commit-graph.h
index 881c9b46e5..f0fb13e3f2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -5,7 +5,7 @@
 #include "object-store.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
-#define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
+#define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
 /*
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1073f9e3cf..5ec01abdaa 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -436,7 +436,7 @@ corrupt_graph_verify() {
 		cp $objdir/info/commit-graph commit-graph-pre-write-test
 	fi &&
 	git status --short &&
-	GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD=true git commit-graph write &&
+	GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE=true git commit-graph write &&
 	git commit-graph verify
 }
 
-- 
gitgitgadget

