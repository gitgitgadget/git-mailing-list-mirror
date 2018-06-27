Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C79511F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965456AbeF0NZs (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35504 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:37 -0400
Received: by mail-qt0-f195.google.com with SMTP id z6-v6so1585566qti.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8qdtnL0ofvZewbvJW4JviUoJ6AHIdSyrz5rRwnKIGQ=;
        b=YPoNLYZQREHCyhkaN2KUawnJ3AuTh0rT1Cpce1+5+Ya0jYDjzAeO6RDb732uFgVmEx
         WhvTOhtMB4v1UdnL5pSmddHvqrVDkYUAbX11DXsOpwQjbsW/KhxcwIcalaNH7cCqNTWA
         Z1NOEReenyQcu21y6dNX9raeIK/Y14rkdFHiVvHpSZ+b1+n/Mv7T7aKJ/VPGdQO+bZO5
         Q+Ja0ZvZMrk+npWrmZMr+yT9CZxcAlkqDS9Tv6YK5h+C7fZrq3vEgbTr//YnQdYGYn+3
         Ifrr9bs4hA53OWBUybJCbp3e2ae9gJPRWDCNujtF0yYl7nvt8T4pGLXQwQgEku+XE9pJ
         Wzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8qdtnL0ofvZewbvJW4JviUoJ6AHIdSyrz5rRwnKIGQ=;
        b=B/iSAgS+3rRttY9rK99ZCcC+qyBrjt3pIR8VGLR1CADqoJ3M67lJHFOCwlnpUFhkOe
         cNDYwavFrKc5TBL7rZiM5LyEAqTwOrVE7Dyu1l6Qq81iqtopJBzylJF7OumZMd7jFjHu
         tKfuIviW/YIGcCrWQseiuS6WSg7eYXoqs9fYGsWCA6z4sTv13MnHVi0onYu+oJP1UBJs
         Lmv22FN5dGpSh/6Bz6Ui10Lb3apHmIAWYim4Xnd+fJX3R59OUq3W5+P4LrtU0vW7Tbtl
         eqiKLGS4m6srGqM/H4x2Q4OL1y8FBQzN671N4IGcNx7fvZ3UmLGeQ3x1rVTM5cofXZKD
         dofQ==
X-Gm-Message-State: APt69E31VkSrw+iUm4pMW8pBITqMgCGQXCdKqRLiKUkZNOAAVK7pfzi6
        HBLR61/etf7AiCgcf71AT6nU/jNxrHA=
X-Google-Smtp-Source: AAOMgpd+iwWT0eISNwz755PT3+5COB61nvW+tiJU8ANllQ2fL1J/uUlfe507i4EHDzpZvunho4T93Q==
X-Received: by 2002:aed:3fc8:: with SMTP id w8-v6mr5331418qth.262.1530105936157;
        Wed, 27 Jun 2018 06:25:36 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:35 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 21/22] gc: automatically write commit-graph files
Date:   Wed, 27 Jun 2018 09:24:46 -0400
Message-Id: <20180627132447.142473-22-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file is a very helpful feature for speeding up git
operations. In order to make it more useful, make it possible to
write the commit-graph file during standard garbage collection
operations.

Add a 'gc.commitGraph' config setting that triggers writing a
commit-graph file after any non-trivial 'git gc' command. Defaults to
false while the commit-graph feature matures. We specifically do not
want to have this on by default until the commit-graph feature is fully
integrated with history-modifying features like shallow clones.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt |  9 ++++++---
 Documentation/git-gc.txt |  4 ++++
 builtin/gc.c             |  6 ++++++
 t/t5318-commit-graph.sh  | 14 ++++++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..978deecfee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -904,9 +904,12 @@ core.notesRef::
 This setting defaults to "refs/notes/commits", and it can be overridden by
 the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
-core.commitGraph::
-	Enable git commit graph feature. Allows reading from the
-	commit-graph file.
+gc.commitGraph::
+	If true, then gc will rewrite the commit-graph file when
+	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
+	'--auto' the commit-graph will be updated if housekeeping is
+	required. Default is false. See linkgit:git-commit-graph[1]
+	for details.
 
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 24b2dd44fe..f5bc98ccb3 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -136,6 +136,10 @@ The optional configuration variable `gc.packRefs` determines if
 it within all non-bare repos or it can be set to a boolean value.
 This defaults to true.
 
+The optional configuration variable `gc.commitGraph` determines if
+'git gc' should run 'git commit-graph write'. This can be set to a
+boolean value. This defaults to false.
+
 The optional configuration variable `gc.aggressiveWindow` controls how
 much time is spent optimizing the delta compression of the objects in
 the repository when the --aggressive option is specified.  The larger
diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..b7dd206f41 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -20,6 +20,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "commit.h"
+#include "commit-graph.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "pack.h"
@@ -40,6 +41,7 @@ static int aggressive_depth = 50;
 static int aggressive_window = 250;
 static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
+static int gc_write_commit_graph = 0;
 static int detach_auto = 1;
 static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
@@ -129,6 +131,7 @@ static void gc_config(void)
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
+	git_config_get_bool("gc.writecommitgraph", &gc_write_commit_graph);
 	git_config_get_bool("gc.autodetach", &detach_auto);
 	git_config_get_expiry("gc.pruneexpire", &prune_expire);
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
@@ -641,6 +644,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (pack_garbage.nr > 0)
 		clean_pack_garbage();
 
+	if (gc_write_commit_graph)
+		write_commit_graph_reachable(get_object_directory(), 0);
+
 	if (auto_gc && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2208c266b5..5947de3d24 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -245,6 +245,20 @@ test_expect_success 'perform fast-forward merge in full repo' '
 	test_cmp expect output
 '
 
+test_expect_success 'check that gc computes commit-graph' '
+	cd "$TRASH_DIRECTORY/full" &&
+	git commit --allow-empty -m "blank" &&
+	git commit-graph write --reachable &&
+	cp $objdir/info/commit-graph commit-graph-before-gc &&
+	git reset --hard HEAD~1 &&
+	git config gc.writeCommitGraph true &&
+	git gc &&
+	cp $objdir/info/commit-graph commit-graph-after-gc &&
+	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
+	git commit-graph write --reachable &&
+	test_cmp commit-graph-after-gc $objdir/info/commit-graph
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
-- 
2.18.0.24.g1b579a2ee9

