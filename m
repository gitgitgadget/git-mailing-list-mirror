Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD10FC433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD8D204EA
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 12:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm6PSqFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgFZMan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFZMam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 08:30:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A81C08C5DD
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so8678748wmg.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UiCtqTJGVEULmS7sPq1CCgWHFh2xZ9/Kbd4Wgi4nLYI=;
        b=Bm6PSqFS4SgpvI7pZKg+SFDOM0fK48MTjhe26vIN4UkJ8yUcbScUza1bvF7RcjhESd
         NXbIzw8PO9BpNyZN+65IT4cX5l+Rm7An9WrqbV9u+t+12/5akaSq8WHAPsxK2ufIVQ7Y
         sam/L6Ctxjcb0GTj1cboLMzGrKEss+YNvDeQmYFKlTIdiPJYPl6KadrKLcQSZeAIOtG7
         i8UKqMRusXzhXV3MzYnBOYoSMsUxZgPsIBkyrkfoseDgChXHFDNl3br5vsfZpFCEgYb6
         txES0L35u6ACiUbSouotgjRex8dO7Oh65BntXdDMmeg05kbwaf6sKe4VwMNStXHKpcJY
         wZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UiCtqTJGVEULmS7sPq1CCgWHFh2xZ9/Kbd4Wgi4nLYI=;
        b=CaMfT+rDjKrKZZ9GJdzLMiP+wf1DczcEC5VcMFP7YP+aB6W2B7ZJIm89xhRWYI03RG
         f577xiM2q2sJ/nmiTFSc41wqbuSjK88ikEY+c4DNjFHVRjVlc7s88iiJIVXwpQVT3zDO
         W1rykVo93zzkGtRKjQ6VKK1O5kM0pP5v3wYmpFRvw0LxRUYZdRYlbyVPSxDpkEmoSPUR
         ZxxC1oFkZlR53WaAV5Z+skTK2UdBMSz+2Q7Goxs0uSg46UR3/Im45h0EHx2cNRpcfkW9
         4ENA7/WxELVu7GLuYKich2DL7dj+yZFBnOuZOalziAbl1C8TLlZvlS4MBs5gObRuHOON
         9xkw==
X-Gm-Message-State: AOAM530T7vCiK2v8/jBCCR1paOMHay6o62CWkMjQCY+SlZW5yY0emtID
        WHq68vOQ8LUs4MClDevF6taUMNa4
X-Google-Smtp-Source: ABdhPJymB+kYQR57/wN7uzfF6Al/rzSUpU+niCsTz86q4hG/WYTsMHBcXsmJw/ZE0PdtJPrQwyG1qQ==
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr3075367wme.81.1593174640374;
        Fri, 26 Jun 2020 05:30:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm23293671wrw.62.2020.06.26.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:30:39 -0700 (PDT)
Message-Id: <6b63f9bd8a2a7e18d7ac1be7066d4bcd1df2a729.1593174637.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
References: <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Jun 2020 12:30:28 +0000
Subject: [PATCH v3 02/10] commit-graph: change test to die on parse, not load
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

