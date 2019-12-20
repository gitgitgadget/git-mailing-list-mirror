Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A050C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0621655
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAGjSyo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfLTWF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:05:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37752 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfLTWFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:05:25 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so9853217edb.4
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5jXK0NxFrW0RhtPRb+zP4ffc0skGZ1HBnPaormCuV1o=;
        b=cAGjSyo/OWZYU66aI2VD4YjycdcN7xtaaviLTHc5dpR56BneNeQbYCLdk1HfIzwe1Z
         jXFk3dhsyHXGEaavBTVNJk7DbXKh3VmcXlUP4k48NcBithhRSHWO5N7P5jdC0FZZcVKb
         i1zhr4HzXuvHsKH8BjD7dKag9/pwGLx6UYRVzpJKQo8Hx/Vcugc9tphccif+iDMCUHoz
         Jnzmhs26szFrqRS5GI4PCuLzy0oA7qzk/FPsI4l9Oh1UNXsm6D4lJijUnJpdC7I2qsVg
         hILrOiE1hflh8gBppOJasGsdTuKfX/8GCNAPwWxOhkRFNiltUKCPlF0UXtw7/J8NZHZX
         epmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5jXK0NxFrW0RhtPRb+zP4ffc0skGZ1HBnPaormCuV1o=;
        b=alJbiPeNrn53COx7edhQp1XSW0Qej61J1+nbv1bpdTWd8PAEtHKM6ZYsAxwrqtrZZL
         DlKFzgslnM05Q8+w9xjgXXD4Perz3MTcABjiIanorptZjzyIMHMfGtNGhTZBwy4ODdEZ
         33044x8TAZrIIKIvg4z+dHR4jzftgDAFZP5zrDgXZ+e37U7YqDzPm0NrNhsMWA9zIqKP
         hE9FYs11BXZTeVBgvo3TlaD/L/yW5Yw5AqMR50F0+D1jYiw4egKgZfMib+AJ+hbZwnRx
         wavGY0NzKERzY9wk47d84wfv5+IP1mDwFrWU5IlPOmf/tlFgo/xN1EAxcHtdLhknW4kq
         MGvQ==
X-Gm-Message-State: APjAAAV2t8DDT3HklKGX9/FnSjIycWlkctK9MZYjy8A3RjNcfp9L2vQg
        QjDcRC3slD9REYVD7UPvt4+PjIUC
X-Google-Smtp-Source: APXvYqytVLAXAne0RkwRSVqete5NXMTMFNSSeWfjkfj+IolggZ+NI60ChMn19Hfr+ZMS7+Qx+5dDgA==
X-Received: by 2002:a17:906:ce2e:: with SMTP id sd14mr19037426ejb.190.1576879523262;
        Fri, 20 Dec 2019 14:05:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm89213ejl.5.2019.12.20.14.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 14:05:22 -0800 (PST)
Message-Id: <6bdde5e4f0ceb54546978e3e9cdde00045d45468.1576879520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 22:05:12 +0000
Subject: [PATCH 1/9] commit-graph: add --changed-paths option to write
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        jeffhost@microsoft.com, me@ttaylorr.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add --changed-paths option to git commit-graph write. This option will
soon allow users to compute bloom filters for the paths changed between
a commit and its first significant parent, and write this information
into the commit-graph file.

Note: This commit does not change any behavior. It only introduces
the option and passes down the appropriate flag to the commit-graph.

RFC Notes:
1. We named the option --changed-paths to capture what the option does,
   instead of how it does it. The current implementation does this
   using bloom filters. We believe using --changed-paths however keeps
   the implementation open to other data structures.
   All thoughts and suggestions for the name and this approach are
   welcome

2. Currently, a subsequent commit in this series will add tests that
   exercise this option. I plan to split that test commit across the
   series as appropriate.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Documentation/git-commit-graph.txt | 5 +++++
 builtin/commit-graph.c             | 9 +++++++--
 commit-graph.h                     | 3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index bcd85c1976..1efe6e5c5a 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -54,6 +54,11 @@ or `--stdin-packs`.)
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
+With the `--changed-paths` option, compute and write information about the
+paths changed between a commit and it's first parent. This operation can
+take a while on large repositories. It provides significant performance gains
+for getting file based history logs with `git log`
++
 With the `--split` option, write the commit-graph as a chain of multiple
 commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
 not already in the commit-graph are added in a new "tip" file. This file
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index e0c6fc4bbf..9bd1e11161 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@
 
 static char const * const builtin_commit_graph_usage[] = {
 	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-]progress]"),
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -19,7 +19,7 @@ static const char * const builtin_commit_graph_verify_usage[] = {
 };
 
 static const char * const builtin_commit_graph_write_usage[] = {
-	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options>"),
+	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progress] <split options>"),
 	NULL
 };
 
@@ -32,6 +32,7 @@ static struct opts_commit_graph {
 	int split;
 	int shallow;
 	int progress;
+	int enable_bloom_filters;
 } opts;
 
 static int graph_verify(int argc, const char **argv)
@@ -110,6 +111,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "changed-paths", &opts.enable_bloom_filters,
+			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
@@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+	if (opts.enable_bloom_filters)
+		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
 
diff --git a/commit-graph.h b/commit-graph.h
index 7f5c933fa2..952a4b83be 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -76,7 +76,8 @@ enum commit_graph_write_flags {
 	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
 	COMMIT_GRAPH_WRITE_SPLIT      = (1 << 2),
 	/* Make sure that each OID in the input is a valid commit OID. */
-	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3)
+	COMMIT_GRAPH_WRITE_CHECK_OIDS = (1 << 3),
+	COMMIT_GRAPH_WRITE_BLOOM_FILTERS = (1 << 4)
 };
 
 struct split_commit_graph_opts {
-- 
gitgitgadget

