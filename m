Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF2C2D0F0
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC52E206DB
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 00:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5zZpeb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgC3Aby (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:31:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39532 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgC3Abx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 20:31:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id e9so7855793wme.4
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pg2pmkJfOHr9lfHzYyqsIOuMzCf7SUS5JtSNcQKLUIU=;
        b=t5zZpeb7MsM28f+2iDXLRA0ACeheY4wNRd9ct13gYHOs+9AiwDf6VEovbv9wzounh9
         EE8rw71q4A1i5nGnl1izh4f8yJro8OGfXkeF/jqiofa+84GPLS7b8aOo8eYAGNI7+tN/
         ZUYMqrXwi2BHnqxsiwwkrI5IBlZCsmrBBfD9L7ol0ft1KHH4g18zzGwGaYq+RBUzWBKB
         5LhqzOPf3hh/3qK0EX72obNRndEMDI7qZk/xFJMZFaSZJMX52jSLVQTa8sjrzMXHAs3K
         AN5hrs8CbZLh0HhmKeEPiNq8v4YhYc/3QpUkaDw43FJZ8mz91yaZzyRmPKz9oO0I3Twu
         8LGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pg2pmkJfOHr9lfHzYyqsIOuMzCf7SUS5JtSNcQKLUIU=;
        b=fu9NMpz32s539JSH3e8xHJPEdxlpIFu6WYTgylg7sz8TM03Q+ISlsO7GQhsRbgUdro
         yOf/VYB0iyhi6lWnmL3iWthI+4rRmlHlEZfDSFtGmBlQOcqfC8PUEVeDdr59zQ6IzmJB
         aER8llehUr7A7Y1jAT6xjNDJDQk8hGse8Lch09N/vEq/09cR5T+XgTnZBDJMKT3CZLw6
         kYmgVgxU0SNzJ6yMwuEC9zLyTO5/akeyGmCcw3W1IPLK0/FQ3Ajzu0TmIuayWYMz2GL8
         XecwiGMVKnx7RAhjUj4e6Vn8IK6XYsXbnN9+nwcXtPae/2xzwvgpPYZK5SU6cz1/tw29
         uQ9w==
X-Gm-Message-State: ANhLgQ23zcEEw2IiimxTTQwNRvz6cryD28JC4qohfDw9eYWHxFEeGQV5
        FJX3oHaiXz8BrJwNfE7xMrYBLp+r
X-Google-Smtp-Source: ADFU+vsSRk/Hy9Z7qtmK+b+qAlVkqyfFMnghLRG4f3DgRPaOXqTJjUHwMve31FgjLyBTjad10ZJGBQ==
X-Received: by 2002:a1c:a982:: with SMTP id s124mr6525469wme.105.1585528310226;
        Sun, 29 Mar 2020 17:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v129sm16098836wmg.1.2020.03.29.17.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 17:31:49 -0700 (PDT)
Message-Id: <7e450e452363d32927a4afd979b5c544ac541fcc.1585528299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
References: <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Mar 2020 00:31:34 +0000
Subject: [PATCH v3 12/16] commit-graph: add --changed-paths option to write
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add --changed-paths option to git commit-graph write. This option will
allow users to compute information about the paths that have changed
between a commit and its first parent, and write it into the commit graph
file. If the option is passed to the write subcommand we set the
COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
commit-graph logic.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 Documentation/git-commit-graph.txt | 5 +++++
 builtin/commit-graph.c             | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index 28d1fee5053..f4b13c005b8 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -57,6 +57,11 @@ or `--stdin-packs`.)
 With the `--append` option, include all commits that are present in the
 existing commit-graph file.
 +
+With the `--changed-paths` option, compute and write information about the
+paths changed between a commit and it's first parent. This operation can
+take a while on large repositories. It provides significant performance gains
+for getting history of a directory or a file with `git log -- <path>`.
++
 With the `--split` option, write the commit-graph as a chain of multiple
 commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
 not already in the commit-graph are added in a new "tip" file. This file
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index d1ab6625f63..cacb5d04a80 100644
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
+	int enable_changed_paths;
 } opts;
 
 static struct object_directory *find_odb(struct repository *r,
@@ -135,6 +136,8 @@ static int graph_write(int argc, const char **argv)
 			N_("start walk at commits listed by stdin")),
 		OPT_BOOL(0, "append", &opts.append,
 			N_("include all commits already in the commit-graph file")),
+		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
+			N_("enable computation for changed paths")),
 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
 		OPT_BOOL(0, "split", &opts.split,
 			N_("allow writing an incremental commit-graph file")),
@@ -168,6 +171,8 @@ static int graph_write(int argc, const char **argv)
 		flags |= COMMIT_GRAPH_WRITE_SPLIT;
 	if (opts.progress)
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
+	if (opts.enable_changed_paths)
+		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	read_replace_refs = 0;
 	odb = find_odb(the_repository, opts.obj_dir);
-- 
gitgitgadget

