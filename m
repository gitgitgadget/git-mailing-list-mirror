Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF00C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6895F20732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdxtz09l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgDMOpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgDMOpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:45:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7630C008749
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w4so10544062edv.13
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CK8bi4vHfQDw1c0f+oMfXd4Pn0+O30qcnAMquqODCEk=;
        b=rdxtz09ls6a3lMyoFDVb1y2vOx3/pCJ+nWdfB1oyFNOlrmhxAiXhWR5x0eg/iE62R/
         4phzRi+1bplwJmubP6XpcB8pWXMNUkS3VDLOrSP6ItD9G5jyf2D0Z8o7ac/L78ZiZD8R
         /BV2f2U1xfmG1jrDNx/iwSv4GrI6J5vM0e6JjA7lche+h0MCDzYmqRMceha/Aq45Ai5x
         o7/L7/Eh4nHtJhNOPrJqQ3y0QKhJoY3JrIp28iiPNzVSdL/qfHinYVRrTGiXuyGziwbC
         iTOEJNPDY65P+5uHEXszkkKSkuHlw/vU2l3qCYXE33xnj88Wnpdw3M9wD33qIrN+Wh3N
         qj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CK8bi4vHfQDw1c0f+oMfXd4Pn0+O30qcnAMquqODCEk=;
        b=Ww53mpWhMsZb0abdQDv9GH/kshlzqRQhsr7+E+bkCcipNJ+/jxFoWFZrpiR/ARLjUx
         oWIZI5NNcnSNWpUGtez9U9defdWZKchmA/rcntoMHFV704ELfnIvjPMZ6kAYPHEsa7uf
         JezFioElmBqfnjJ5i8NYFiCd6k/HCgk5soWQKD8Uv/Pwwdy7G+FySV4+uS0dgar2O3K9
         KTqwPR36CCGWm7ofiqndu/nE7VQIIgNX4XGv7JNGacO25ujHxUhtHzuo0mkj6iu+jZAT
         z19jGOLzyn6Djgd4lA6hoWJ3uH06pIzO+m9iPAZoKm8sUEG0CnuArxx0WFqkhhBqOKEW
         lgFg==
X-Gm-Message-State: AGi0PuZHODM/SxKPaKni/TVNkDhA6rlAN3d6WS+2PNI9G+E5TZT9aMLp
        gXnzqCriLcAoVzDlYjTOzjFiE9Fr
X-Google-Smtp-Source: APiQypKil5Q4fEnj6ZbKps5CmV60/m2ImyWjUiSpv/gbqvonzNbkzOZSxwHZsYwfy79fL19iKvrVvw==
X-Received: by 2002:a17:907:aab:: with SMTP id bz11mr15819364ejc.311.1586789130194;
        Mon, 13 Apr 2020 07:45:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm1477005ejx.82.2020.04.13.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:45:29 -0700 (PDT)
Message-Id: <824f8ad067bd53e0283180ab8e3828662fcd1fd4.1586789126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
        <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 14:45:25 +0000
Subject: [PATCH v2 3/4] commit-graph: write commit-graph in more tests
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

The GIT_TEST_COMMIT_GRAPH test environment variable triggers
commit-graph writes during each "git commit" process. To expand
the number of tests that have commits in the commit-graph file,
add a helper method that computes the commit-graph and place
that helper inside "git commit" and "git merge".

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c | 4 +---
 builtin/merge.c  | 7 +++++--
 commit-graph.c   | 7 +++++++
 commit-graph.h   | 2 ++
 4 files changed, 15 insertions(+), 5 deletions(-)

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
index 3e8f36ce5c8..5d64cb5f09c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,13 @@
 #include "bloom.h"
 #include "commit-slab.h"
 
+void git_test_write_commit_graph_or_die(void)
+{
+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
+	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
+		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
+}
+
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
 #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
diff --git a/commit-graph.h b/commit-graph.h
index 8655d064c14..8f852a9bee2 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -11,6 +11,8 @@
 #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
 #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
 
+void git_test_write_commit_graph_or_die(void);
+
 struct commit;
 struct bloom_filter_settings;
 
-- 
gitgitgadget

