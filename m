Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7027C43460
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0A61105
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 02:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhDJCEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 22:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDJCEL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 22:04:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F83EC061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 19:03:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so3560024wrt.5
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BKZMXuN/+p8qrPdSacUofbQM5WONxi8AP2yKhlLmgCo=;
        b=eXJlHXWpZfiGYGIc5qd1jevwlTcm/y5MvhuD3ZcREvhmbTm76mJLzv7v/G2tYBjafs
         Xk/7AD9lADUqchhWOcbrlGR/UY/wYYp7p3jKsWuHk2ybRpY8CAhIxF4yV4mw7WoxStjm
         0lMbLD3oChBDsQQUInzYxfA7GEDsL91HkVixqScF/0oQPq/D2rXE7i1jZY/r3oLB0DkS
         jEaafPzSvZyk77M5kuP42880ZbX6lRqoS6emF67/rRVKiH4dd69cEoihIsl9bx+2/iPm
         E9WVIh/dqeX3NPiz1DBNhYkQdIRp7Rrv8WRntQ/QkIcX5kLj2ZIisg8lTgqZ0OspSklK
         ZBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BKZMXuN/+p8qrPdSacUofbQM5WONxi8AP2yKhlLmgCo=;
        b=KwFktYyKpSdgcV6jND7FehaA/myfWpwGoUUoznXvG95v/ShFugT82k3t6sPLhY16FC
         SYRqHLJWMsLVOMfJN6C0/AJo+/5BpFQfY4fBn0DvS+cn44vyuuF1Jg9CfDzeQqfxG/NS
         SRXGPszBeLaWkAVunMNpN0k0qvaVPwWzrWLFRQcPAggZMku4ltz7GunGcuZmtVwV/ZyN
         Ug61OXS/hs77xqvI9bE3hxCAO1GlJce4HkfwPCu3uqyweZUEo7Gq6bm67/ZkG9OxCZcc
         jkpLwdLnilTSEPp58Anq7G4A1XP1ZI6t+H+dB27hNU7MvBvj6W5UmF1KgGVqj/01yuo8
         Wkpw==
X-Gm-Message-State: AOAM530wImj5M5epctnFZ6MS/McjSgPpVeDgPAtV4mbU+qSkWNG1cBhN
        ehTyAdudvEG/iNSQfjfeqe+ZO4HtP/Y=
X-Google-Smtp-Source: ABdhPJxn0sGfT1hVTmT0GKA6Q8bMN/453OXD7nvNo105or+7hz02l/ob13GxsM93rhkFNmrbP5K6/Q==
X-Received: by 2002:a5d:5681:: with SMTP id f1mr16392855wrv.32.1618020228713;
        Fri, 09 Apr 2021 19:03:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm3151179wrc.85.2021.04.09.19.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 19:03:48 -0700 (PDT)
Message-Id: <ed055d772452f2cd445d4b8d42ea6b92f363466e.1618020226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
        <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Apr 2021 02:03:45 +0000
Subject: [PATCH v3 3/3] maintenance: use 'git fetch --prefetch'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     tom.saeger@oracle.com, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'prefetch' maintenance task previously forced the following refspec
for each remote:

	+refs/heads/*:refs/prefetch/<remote>/*

If a user has specified a more strict refspec for the remote, then this
prefetch task downloads more objects than necessary.

The previous change introduced the '--prefetch' option to 'git fetch'
which manipulates the remote's refspec to place all resulting refs into
refs/prefetch/, with further partitioning based on the destinations of
those refspecs.

Update the documentation to be more generic about the destination refs.
Do not mention custom refspecs explicitly, as that does not need to be
highlighted in this documentation. The important part of placing refs in
refs/prefetch/ remains.

Reported-by: Tom Saeger <tom.saeger@oracle.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt |  6 ++----
 builtin/gc.c                      |  7 +++----
 t/t7900-maintenance.sh            | 14 +++++++-------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 80ddd33ceba0..1e738ad39832 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -92,10 +92,8 @@ commit-graph::
 prefetch::
 	The `prefetch` task updates the object directory with the latest
 	objects from all registered remotes. For each remote, a `git fetch`
-	command is run. The refmap is custom to avoid updating local or remote
-	branches (those in `refs/heads` or `refs/remotes`). Instead, the
-	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
-	not updated.
+	command is run. The configured refspec is modified to place all
+	requested refs within `refs/prefetch/`. Also, tags are not updated.
 +
 This is done to avoid disrupting the remote-tracking branches. The end users
 expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
diff --git a/builtin/gc.c b/builtin/gc.c
index fa8128de9ae1..9d35f7da50d8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -879,15 +879,14 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	child.git_cmd = 1;
-	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
+	strvec_pushl(&child.args, "fetch", remote->name,
+		     "--prefetch", "--prune", "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
-		     "--refmap=", NULL);
+		     NULL);
 
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 
-	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
-
 	return !!run_command(&child);
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c006..eadb800c08cc 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -141,15 +141,15 @@ test_expect_success 'prefetch multiple remotes' '
 	test_commit -C clone1 one &&
 	test_commit -C clone2 two &&
 	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
-	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
-	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
-	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
+	fetchargs="--prefetch --prune --no-tags --no-write-fetch-head --recurse-submodules=no --quiet" &&
+	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
 	test_path_is_missing .git/refs/remotes &&
-	git log prefetch/remote1/one &&
-	git log prefetch/remote2/two &&
+	git log prefetch/remotes/remote1/one &&
+	git log prefetch/remotes/remote2/two &&
 	git fetch --all &&
-	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
-	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
+	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
+	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
 
 	test_cmp_config refs/prefetch/ log.excludedecoration &&
 	git log --oneline --decorate --all >log &&
-- 
gitgitgadget
