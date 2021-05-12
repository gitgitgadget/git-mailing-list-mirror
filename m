Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1DEC4363F
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE83B61166
	for <git@archiver.kernel.org>; Wed, 12 May 2021 17:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhELRoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbhELR3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 13:29:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E6C06175F
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a4so24447109wrr.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OD7n3L0qIorVlEic5lpEhxsSGS1aewtOJbk93/bYA1I=;
        b=HNUhZoYc0uVWOz+3ahQPgBSm0R6LFOJbqHnOai/ofaWWXMONdN9r9ry3pD1mXL+g2B
         CbdYZR9is2x3K6bZCUKm4JbtQVQE32gxrr+53+uAg3kKtBBBUS2XKd+uOxeXYLpVwI3K
         K5bl7HLBO8ybWjEdOZseGp2bwb3LQblilXmtqUE9Tl43KNXLp5Zn47kq1neFQLiq4zDF
         Gdhdq1FJmdhJEzstFQaktXLakMqSkc04cm9u0SEpQcrK8TpevrpFtAd57HdRbjbu5+RS
         wH6QQqufX318yjMutUe6sc0qIF1kkdoJKIeyh6T61NlJtoFC18MEHWZDyD3pMgUjgbqr
         6tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OD7n3L0qIorVlEic5lpEhxsSGS1aewtOJbk93/bYA1I=;
        b=A7De5JZekOj4OC5gWhQgFG9HCEwOuLvRDCEpKKImoctAEsKZxzfkUKykSPfomz0Zfv
         mDlV10wO6NmXXYpnDaVig/S13PC1fAxPGQt1p13e5/j6PFYq9gDg6ylkgcqF0JgGAAVw
         kshrMCTTsvlbRYAgfuuTirVfs5ysG1wjdQV8ga5ZdfyXNrW15f/8m5xd+kV570l5awIG
         /ytLkLkxAJd4w8h14IbaoyO5LTusXCRcTyxUmpZMW6991nv+37jhIzLPShMuUDqouVeu
         bqJkXykeb8Yo/KunmL6n6yq1rlXqAYonSC4XMiXt1G6xantqn63kY5Us2jUmd+ltXIoN
         b1HQ==
X-Gm-Message-State: AOAM5329/Pxz4NRqIj6ZJRNrSn4ULxXgsMMjWC6L0fOcvVIqq7fW4jcZ
        fW1dpEdbCPudQOr6GSVIHtgA4ntXpEo=
X-Google-Smtp-Source: ABdhPJy5wmSczJe+/QFFxIm5xW9PD7VZj54XUFjXP2X0zhvUNmR4SYPnAzfi0VPovtw9dLUqEAKxHA==
X-Received: by 2002:a5d:58d0:: with SMTP id o16mr10309602wrf.420.1620840507282;
        Wed, 12 May 2021 10:28:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s18sm287953wro.95.2021.05.12.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 10:28:26 -0700 (PDT)
Message-Id: <cfe2898b7a7e08e01ef5b71f913f6f34bebf38f0.1620840502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
References: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
        <pull.1020.v5.git.git.1620840502.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 May 2021 17:28:15 +0000
Subject: [PATCH v5 2/9] dir: report number of visited directories and paths
 with trace2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Provide more statistics in trace2 output that include the number of
directories and total paths visited by the directory traversal logic.
Subsequent patches will take advantage of this to ensure we do not
unnecessarily traverse into ignored directories.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c                             | 9 +++++++++
 dir.h                             | 4 ++++
 t/t7063-status-untracked-cache.sh | 3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index cf19a83d3e2c..f6dec5fd4a78 100644
--- a/dir.c
+++ b/dir.c
@@ -2440,6 +2440,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 
 	if (open_cached_dir(&cdir, dir, untracked, istate, &path, check_only))
 		goto out;
+	dir->visited_directories++;
 
 	if (untracked)
 		untracked->check_only = !!check_only;
@@ -2448,6 +2449,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* check how the file or directory should be treated */
 		state = treat_path(dir, untracked, &cdir, istate, &path,
 				   baselen, pathspec);
+		dir->visited_paths++;
 
 		if (state > dir_state)
 			dir_state = state;
@@ -2777,6 +2779,11 @@ static void emit_traversal_statistics(struct dir_struct *dir,
 		strbuf_release(&tmp);
 	}
 
+	trace2_data_intmax("read_directory", repo,
+			   "directories-visited", dir->visited_directories);
+	trace2_data_intmax("read_directory", repo,
+			   "paths-visited", dir->visited_paths);
+
 	if (!dir->untracked)
 		return;
 	trace2_data_intmax("read_directory", repo,
@@ -2797,6 +2804,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 	struct untracked_cache_dir *untracked;
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
+	dir->visited_paths = 0;
+	dir->visited_directories = 0;
 
 	if (has_symlink_leading_path(path, len)) {
 		trace2_region_leave("dir", "read_directory", istate->repo);
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
index 9710d33b3cd6..a0c123b0a77a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -65,7 +65,8 @@ get_relevant_traces () {
 	INPUT_FILE=$1
 	OUTPUT_FILE=$2
 	grep data.*read_directo $INPUT_FILE |
-	    cut -d "|" -f 9 \
+	    cut -d "|" -f 9 |
+	    grep -v visited \
 	    >"$OUTPUT_FILE"
 }
 
-- 
gitgitgadget

