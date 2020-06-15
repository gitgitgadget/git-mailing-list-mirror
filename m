Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41CC433E8
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5156206F1
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 20:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGuh+Yu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgFOUPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbgFOUPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 16:15:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1DC05BD43
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x6so18412456wrm.13
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eBro0dZlAf+xWzI+P3W14Gh2xUWwXtxsQkFEOxqSBFo=;
        b=KGuh+Yu6rWyDRZq5+/J1/yZrdY9gln4mdQIL6ywG7RvaqF+GhXnJYul8aV92Ozxi+W
         JX+Tbc7xat+OIoJZ3jB8U0uAwMkopSX4RvVNC+cPvcYFC3BahoikhuWDGecfBFvBMM/c
         4uB1UK3K+qUIMRVSTZcEmtPHG0BzgoOD+Y1E4Rbd/+PCbAadbzDDWp2CaxVm5OlW0c6T
         rxUIjogafs05r95I+1nrp+t8c0jgg0l0kGGUJnCkQdKtIM5NK7ykgu/DeyNmwj0Ai7zN
         2cUV1YJqDk7/amons36/ikjcPiVI2rydNbQYYQSkYA4avCUMpni6eM+k4V24+Sqpj/zn
         2ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eBro0dZlAf+xWzI+P3W14Gh2xUWwXtxsQkFEOxqSBFo=;
        b=VQ4Xw7SjGOcUoXbDN6MVNgzYdQPsI+pQ4I91o9Q2uZqMKeuduA8WIcAZ3Jes+U8X6J
         QiXU3OHWtoYMCRQQtMoyAynPAQO/MFc/0tpxd7jqpmLYB2euwLDgjP5oIVL5AjVdBT9I
         wug1cavLwEzhbsdTCy1CJACMNGySssefM3RyQ7csqbHdvrGKadracSdEX3KsKbBwjMQM
         sLtEE2SiJPIPvmGhPj8XNTtSP4hTIUh7j2Z1SmHwd/7COaMFCohxLsPZdu2DbSdpSz4Q
         dn8W31j70L3bD/2i5fLUgYXjhRZDlu6MjmPhv5YvStugCGpc6RohfjgVhuEwiWO1PFDQ
         Jp3A==
X-Gm-Message-State: AOAM533NSYjaKUkM6ME9ZI8DPRmINC+Wl6dvV5SOSa15bQtbD9SaZdT2
        d6zQrkd1P0t2JJ1YhcKWNeT66AXO
X-Google-Smtp-Source: ABdhPJzOM39KtCOf1rMsmy/QiNfqqm8yN+7s35dSdCKYCcrL8n8PNB9f/YOnEVRbPFF+YMM5Evxrgg==
X-Received: by 2002:adf:9286:: with SMTP id 6mr30900479wrn.361.1592252100759;
        Mon, 15 Jun 2020 13:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm856915wma.23.2020.06.15.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:15:00 -0700 (PDT)
Message-Id: <60bbc15d24a8de17757d1cb287f5bb2d77c41a72.1592252093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.git.1592252093.gitgitgadget@gmail.com>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 20:14:52 +0000
Subject: [PATCH 7/8] commit-graph: change test to die on parse, not load
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, szeder.dev@gmail.com,
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
index 5c8f210cada..3a64e3b382d 100644
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
index 881c9b46e57..f0fb13e3f28 100644
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
index 1073f9e3cf2..5ec01abdaa9 100755
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

