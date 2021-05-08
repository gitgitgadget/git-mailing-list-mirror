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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD261C433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852676145D
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhEHAJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhEHAJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F377C061763
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t11-20020a05600c198bb02901476e13296aso5754251wmq.0
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jESdGkKuLXbijtDvf5e2HewiIfotNeXrl5Hx64zKT1g=;
        b=pEmI5zCdrSAWjlyKMdDRuG+brRomTnBdoUfbYt6tu44s0qylSEJ6HfBRE26H/Npx+4
         N0QNR9GQ8UMeNxFM41QdyDbH7UHNtmpOGtunCfO+ii513MWHc7yaarhi63HqXwGFulsF
         6dPjdzH3lDleKx7y+LZFy2foh4OI0CXiGBO8noujQXa20simdu9gclSXssATenoVS3zU
         haOH0rXLnzY4MF9ZHUt3xnndt9BzTKU/TCMYGauD+ctCdHXT3/LNPkuBecacduosRK6Q
         iBfqNKya7BbIQ5y3+WRgP6lpmBrW+CVm+40x4pvHuHKQDaFWk+EJ3AhccxVGfI+FOhiD
         bzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jESdGkKuLXbijtDvf5e2HewiIfotNeXrl5Hx64zKT1g=;
        b=EgQjVS+MwxBOC0Y0rY8ON4IReIpEM2ZryOY7O5GiUtLJaeaIsi9WlHLIVMmTbwn8Wb
         pBk5JSdvl7I9SxCeUXx11keZ5R9JPYZW0x0HbNC8jEKwvSiwVmu8G7Irh+cUKLXPv+2X
         ISpTwh6oOu7aEb9WaCVVrly6wUkKCy8ARDyqk8Auc2984nsxnSYAAPsI1vJPb8q7LvS1
         t4CqdgFGcOns2z6qhEqN6wL8pWh0vogD+Z/plWq9SgXvPjFHENdYRyqLxk5W67Xrg2uQ
         ih3VCkRDvwSv7WwH+JgMAe+lqI+FOA3jPJ/v74Ds5a1q7D6QxYB36LqoIEFKjgGsjf7E
         PbYA==
X-Gm-Message-State: AOAM531QJ46h89meYyh2SFsaoJBXfkS8i8hJh03Ir4b2L93leSuhH1ci
        NPDWNE+IoBubYbAcdFtcnPb8bv0C1HQ=
X-Google-Smtp-Source: ABdhPJzkuMbf1alFg4+T2izfkOf5reantovmwWdiM1bgNPRifVJGWvzVKoEO2Ct23PpdqbMGWzmTxA==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr12448234wmk.25.1620432506927;
        Fri, 07 May 2021 17:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm10655639wrp.29.2021.05.07.17.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:26 -0700 (PDT)
Message-Id: <fba4d65b78c724eba7ae1fbc286ac29a210d6ac8.1620432501.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
        <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:20 +0000
Subject: [PATCH v2 8/8] [RFC] dir: reported number of visited directories and
 paths with trace2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Previously, tests that wanted to verify that we don't traverse into a
deep directory hierarchy that is ignored had no easy way to verify and
enforce that behavior.  Record information about the number of
directories and paths we inspect while traversing the directory
hierarchy in read_directory(), and when trace2 is enabled, print these
statistics.

Make use of these statistics in t7300 to simplify (and vastly improve
the performance of) the "avoid traversing into ignored directories"
test.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                             |  8 ++++++
 dir.h                             |  4 +++
 t/t7063-status-untracked-cache.sh |  1 +
 t/t7300-clean.sh                  | 46 ++++++++++---------------------
 4 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/dir.c b/dir.c
index 23c71ab7e9a1..896a9a62b2c7 100644
--- a/dir.c
+++ b/dir.c
@@ -2455,6 +2455,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	if (open_cached_dir(&cdir, dir, untracked, istate, &path, check_only))
 		goto out;
+	dir->visited_directories++;
 
 	if (untracked)
 		untracked->check_only = !!check_only;
@@ -2463,6 +2464,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* check how the file or directory should be treated */
 		state = treat_path(dir, untracked, &cdir, istate, &path,
 				   baselen, pathspec);
+		dir->visited_paths++;
 
 		if (state > dir_state)
 			dir_state = state;
@@ -2778,6 +2780,10 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 static void trace2_read_directory_statistics(struct dir_struct *dir,
 					     struct repository *repo)
 {
+	trace2_data_intmax("read_directory", repo,
+			   "directories-visited", dir->visited_directories);
+	trace2_data_intmax("read_directory", repo,
+			   "paths-visited", dir->visited_paths);
 	if (!dir->untracked)
 		return;
 	trace2_data_intmax("read_directory", repo,
@@ -2798,6 +2804,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	struct untracked_cache_dir *untracked;
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
+	dir->visited_paths = 0;
+	dir->visited_directories = 0;
 
 	if (has_symlink_leading_path(path, len)) {
 		trace_performance_leave("read directory %.*s", len, path);
diff --git a/dir.h b/dir.h
index 04d886cfce75..22c67907f689 100644
--- a/dir.h
+++ b/dir.h
@@ -336,6 +336,10 @@ struct dir_struct {
 	struct oid_stat ss_info_exclude;
 	struct oid_stat ss_excludes_file;
 	unsigned unmanaged_exclude_files;
+
+	/* Stats about the traversal */
+	unsigned visited_paths;
+	unsigned visited_directories;
 };
 
 /*Count the number of slashes for string s*/
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 6bce65b439e3..1517c316892f 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -65,6 +65,7 @@ get_relevant_traces() {
 	INPUT_FILE=$1
 	OUTPUT_FILE=$2
 	grep data.*read_directo $INPUT_FILE \
+	    | grep -v visited \
 	    | cut -d "|" -f 9 \
 	    >$OUTPUT_FILE
 }
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index c2a3b7b6a52b..2c10a7b64f11 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -747,42 +747,24 @@ test_expect_success 'clean untracked paths by pathspec' '
 '
 
 test_expect_success 'avoid traversing into ignored directories' '
-	test_when_finished rm -f output error &&
+	test_when_finished rm -f output error trace.* &&
 	test_create_repo avoid-traversing-deep-hierarchy &&
 	(
 		cd avoid-traversing-deep-hierarchy &&
 
-		>directory-random-file.txt &&
-		# Put this file under directory400/directory399/.../directory1/
-		depth=400 &&
-		for x in $(test_seq 1 $depth); do
-			mkdir "tmpdirectory$x" &&
-			mv directory* "tmpdirectory$x" &&
-			mv "tmpdirectory$x" "directory$x"
-		done &&
-
-		git clean -ffdxn -e directory$depth >../output 2>../error &&
-
-		test_must_be_empty ../output &&
-		# We especially do not want things like
-		#   "warning: could not open directory "
-		# appearing in the error output.  It is true that directories
-		# that are too long cannot be opened, but we should not be
-		# recursing into those directories anyway since the very first
-		# level is ignored.
-		test_must_be_empty ../error &&
-
-		# alpine-linux-musl fails to "rm -rf" a directory with such
-		# a deeply nested hierarchy.  Help it out by deleting the
-		# leading directories ourselves.  Super slow, but, what else
-		# can we do?  Without this, we will hit a
-		#     error: Tests passed but test cleanup failed; aborting
-		# so do this ugly manual cleanup...
-		while test ! -f directory-random-file.txt; do
-			name=$(ls -d directory*) &&
-			mv $name/* . &&
-			rmdir $name
-		done
+		mkdir -p untracked/subdir/with/a &&
+		>untracked/subdir/with/a/random-file.txt &&
+
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
+		git clean -ffdxn -e untracked &&
+
+		grep data.*read_directo.*visited ../trace.output \
+			| cut -d "|" -f 9 >../trace.relevant &&
+		cat >../trace.expect <<-EOF &&
+		 directories-visited:1
+		 paths-visited:4
+		EOF
+		test_cmp ../trace.expect ../trace.relevant
 	)
 '
 
-- 
gitgitgadget
