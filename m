Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C1EC43461
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9C06188B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhEKSfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhEKSfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:35:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D38C06174A
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x5so21103665wrv.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sTx9lSBDuZng0Z3nvmpUgnf6o5I0UJrmkdo4kHUxzlI=;
        b=sYTdNbSu5pX0jTTh9/BgPWU3/hVz6kU4+HnnnjJr6YoWgyV6iqh2ZoRggZzOwiIVuU
         1dseCL4EUI5RrwGXFdB9F/TqVQP53RpckkpOv0J9BV3dZWIk2OjuWBWSOEU0noNYzJmq
         n9zkfLcFpu7VJ7FMHxn7yQWZFoBvzugHKrd7r4EmD2sPlX+CzJQ5RTchwiu5VR6/A3L/
         g26Tn+DPEdqVpELcC3SjNA/xOUMckFip1+V0xbrf+yAuLfKM9qYAVaZqilMpr3SUdtQf
         KMncIOV7Vxjg0U//RxJfucJqIuH3OwmrGkeK4z1QuKeehZNy8j94ngNtwJ9vPLTIhZ7S
         5h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sTx9lSBDuZng0Z3nvmpUgnf6o5I0UJrmkdo4kHUxzlI=;
        b=PYb6yeBA2jLh1r1yBpKfrBGYjYc9Omkx9DZldPNmX6XQKZENtvBgsTcWKJ/fVtSBCG
         HpyC4iH6EsCtRaoiUrHsecwBev13cIBFr8ZfUEomG2ewbtGKFlOb8eXQRB5cmXz3kfDI
         5I661s04XHZAvIkHXABmkjZXBGG/9wbb7PZXDVZpHW/v4fII2BXfB4eW+eL35/1TpjfR
         fYw+IzehePeo9WBb1dVx038HGqCQrkjZDk2MOroJuhzzO6LFABu7gyjVPAbfKMHuB1HR
         WePmcvIjjXMlxwLw4ze+dY+V2WyswqTafgXFxukootckf/89Fr3l42/6Y6MT+h/HAY8H
         VePQ==
X-Gm-Message-State: AOAM532D6TKW+845EG/PukiNqcXlNvqoH3G7wP4IjpIWZytM1zIrNxNb
        YObxb7UovHJF+A6wdfE7Dj9ruT7jZF0=
X-Google-Smtp-Source: ABdhPJy3MNV9TOlZdH3h/VVmAJvFI2RrW+qWkuFpl4eNgSSTv4cu9YhmMJDhdwJjW3Kgpx+eYNNwYA==
X-Received: by 2002:a05:6000:cb:: with SMTP id q11mr40337268wrx.13.1620758052260;
        Tue, 11 May 2021 11:34:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9sm24580467wmb.35.2021.05.11.11.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:34:11 -0700 (PDT)
Message-Id: <6939253be825f7c79dc5fb5fa13e420b876950d7.1620758049.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 May 2021 18:34:02 +0000
Subject: [PATCH v4 2/8] dir: report number of visited directories and paths
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
 dir.c                             | 8 ++++++++
 dir.h                             | 4 ++++
 t/t7063-status-untracked-cache.sh | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 122fcbffdf89..69b8c9d7f9fb 100644
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
@@ -2764,6 +2766,10 @@ static void trace2_read_directory_statistics(struct dir_struct *dir,
 					     struct repository *repo,
 					     const char *path)
 {
+	trace2_data_intmax("read_directory", repo,
+			   "directories-visited", dir->visited_directories);
+	trace2_data_intmax("read_directory", repo,
+			   "paths-visited", dir->visited_paths);
 	if (!dir->untracked)
 		return;
 	trace2_data_string("read_directory", repo, "path", path);
@@ -2785,6 +2791,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
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

