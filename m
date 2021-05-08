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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CCC433ED
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8776C613CE
	for <git@archiver.kernel.org>; Sat,  8 May 2021 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhEHUAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 16:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhEHUAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 16:00:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8DC06175F
        for <git@vger.kernel.org>; Sat,  8 May 2021 12:59:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so278383wmq.0
        for <git@vger.kernel.org>; Sat, 08 May 2021 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jfg7DtvxwaYxLLEO3mU5FjVoM0D5rAkthKhgOWMvmfs=;
        b=TSAFUkYD0pSw6I5D5sxkfUgGxOopYhwHsb7uKN2r+1wMJgafby/CaqMmsPmDQxU6XM
         AmJyGeT9gF44VQqDJmoMWrphlas5nDFlYNGMc2fjmTAQTOB0CxTWq0K6+MEnrlhlweaS
         dWQEDs9FvioHTT5PvyX9fXV9gqt/FGnHPYM0x4yvG7A4JnSWte7hadYMMNPfjnTRaeLM
         6pq3CVO6RqjTsdnW0UXiOkukL+ww7Ay2cOZXMJVB0v3bu//GBogAn2/14GIZc0Kxl4bP
         T9FzgejsaUe5scir0Md/wwHeYhHoxpCMMamOtHzkcDpmcQPQPHsivVK0sDzGWsXO2Z4j
         mS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jfg7DtvxwaYxLLEO3mU5FjVoM0D5rAkthKhgOWMvmfs=;
        b=CPHo52KfxaE6zvbP5f9fVo5QXsIH8HbtLS1pXtuvNgOqItINKCzCSzCKwCOytTgimV
         fnb+fjwA5Cw07FwxnS8m0Lz7zSDWRV+03yv9SIcKe6KM9qg9wHYos79LjBA/8SgkGgoG
         1+2gEDUFJdelph4xr7M2yp6Rqk279K7XhglFSASQkxjkxMapeauT1xUebsaIaq+SbQ5g
         3usVEbs7DrSRjQ1yjBuxlHvdCbbK7vk8SxaB/LTRZI/9Qs6a/6fEXuMqQ4mF9HUX5YP0
         9sC87Dis9NWXK0eI5/XidfEYWGF77uQgLKhK3TMH3obsBSoJ+DFNxuURBnsvKb5A+EBi
         Lpmw==
X-Gm-Message-State: AOAM533idrQvaysag973m64VvgyhWjpPmGScQUFLgNlSynN79+wNeRDD
        nf6HTruVE8DHuZSs5Pugnhb/OGEnz5I=
X-Google-Smtp-Source: ABdhPJwFT8Y3Iko0Ui2k3TcMQ6Q9uoqvht1g4WS8Zbs5WdqKFEifUWFY7DSN8dEwA25Lwjx20XS1Mg==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr28227658wmj.63.1620503949265;
        Sat, 08 May 2021 12:59:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm12179032wmk.39.2021.05.08.12.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 12:59:08 -0700 (PDT)
Message-Id: <8b511f228af8e047d8b38159da658b10174c40e8.1620503945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 19:58:58 +0000
Subject: [PATCH v3 2/8] [RFC] dir: report number of visited directories and
 paths with trace2
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
 t/t7063-status-untracked-cache.sh | 1 +
 3 files changed, 13 insertions(+)

diff --git a/dir.c b/dir.c
index 9f7c8debeab3..dfb174227b36 100644
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
@@ -2763,6 +2765,10 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
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
@@ -2783,6 +2789,8 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
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
-- 
gitgitgadget

