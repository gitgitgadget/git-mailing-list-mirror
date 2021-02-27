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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF56C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C9E64E33
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhB0Abj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhB0Abf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:31:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62993C061786
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m1so9179163wml.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YH98+MPTpshmL/MR1C63NS+khcjsnv9sR7WApFpBRiM=;
        b=fQUs9uS5Qg1wITRRNSVbDZGzUg6AFm9QBEco7U0xpVu21a2sdFugrsDUCqblGBj+fa
         FKkP/dTefR7u7lUNN5r37wAB8gwxIe4+iyfekFfbjBP9Jzvy3hTwhshcy4WE9MaJ+Fs+
         j58sdR8uNydXRyNgP1URLDVCfBzxJ9cb9ZGKCy+7b8lk58QvvoonHw3VDArKIPsBDcR8
         38IxEE/fXyY8ZQOhyGKAYHhFNxNtGL5NK/seHCddvRxRVfQR2tl+MZGkwNQWVuTgIz2Q
         F9qiyZ1bM4+VIfn0OEgoZr5lsaRllmtmDb53HdST5mAQQEIsB8QEzxragmoTlWf590Ok
         GNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YH98+MPTpshmL/MR1C63NS+khcjsnv9sR7WApFpBRiM=;
        b=WLMuAi1F1OKitYOHcexLlHYuchWVlgFBwBIN/k1JhAYlMJLLCcA07sozHGBqfq+vAn
         xv2Mw5IBka2HT2UbGOFYiELrszX24bxI07SRr1JxF7wvCuXiJaK+gSCJw+KdV1ia/rLP
         tgo3r+2OqbH1sHkILcAI+fe0G452z1H7/EojlTA/JJdjEwDAdpZl2U03dc1svzSSz8wv
         1WDzIkjtMbZdPVCDy0jSG2QhqSB07gpkNxTv1ZaHUOSb104tuZ4JYXWLKrPh1B+WjBF/
         T6vtU2A3cN5DrzdGhs2u2xPAGgL2UNvjFgraC+lVHaroqfPsLmhAWVrxWsMTf7Iq0CVX
         ebjQ==
X-Gm-Message-State: AOAM5320xvxHsn2U88RzNXL9/jfOuaij7A9r+srGMvljtJdKLjG9jT7O
        bKWYHPw01FHjRda2zJ/5nBDfixvIQtI=
X-Google-Smtp-Source: ABdhPJyOBehR2QOZW9v3cmvhSfPYIVZ6iC49DhvUmGJ9cxRz6oCz0Vt9V5brD6Ia8Px5qqj2HzKbGw==
X-Received: by 2002:a7b:c412:: with SMTP id k18mr4981307wmi.37.1614385852074;
        Fri, 26 Feb 2021 16:30:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm13257574wmc.13.2021.02.26.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:51 -0800 (PST)
Message-Id: <2dde621d7de596d7aa0bb31245b04683de2fa3d9.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:40 +0000
Subject: [PATCH v4 02/10] diffcore-rename: provide basic implementation of
 idx_possible_rename()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add a new struct dir_rename_info with various values we need inside our
idx_possible_rename() function introduced in the previous commit.  Add a
basic implementation for this function showing how we plan to use the
variables, but which will just return early with a value of -1 (not
found) when those variables are not set up.

Future commits will do the work necessary to set up those other
variables so that idx_possible_rename() does not always return -1.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 100 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index b3055683bac2..edb0effb6ef4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -367,6 +367,19 @@ static int find_exact_renames(struct diff_options *options)
 	return renames;
 }
 
+struct dir_rename_info {
+	struct strintmap idx_map;
+	struct strmap dir_rename_guess;
+	struct strmap *dir_rename_count;
+	unsigned setup;
+};
+
+static char *get_dirname(const char *filename)
+{
+	char *slash = strrchr(filename, '/');
+	return slash ? xstrndup(filename, slash - filename) : xstrdup("");
+}
+
 static const char *get_basename(const char *filename)
 {
 	/*
@@ -379,14 +392,86 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
-static int idx_possible_rename(char *filename)
+static int idx_possible_rename(char *filename, struct dir_rename_info *info)
 {
-	/* Unconditionally return -1, "not found", for now */
-	return -1;
+	/*
+	 * Our comparison of files with the same basename (see
+	 * find_basename_matches() below), is only helpful when after exact
+	 * rename detection we have exactly one file with a given basename
+	 * among the rename sources and also only exactly one file with
+	 * that basename among the rename destinations.  When we have
+	 * multiple files with the same basename in either set, we do not
+	 * know which to compare against.  However, there are some
+	 * filenames that occur in large numbers (particularly
+	 * build-related filenames such as 'Makefile', '.gitignore', or
+	 * 'build.gradle' that potentially exist within every single
+	 * subdirectory), and for performance we want to be able to quickly
+	 * find renames for these files too.
+	 *
+	 * The reason basename comparisons are a useful heuristic was that it
+	 * is common for people to move files across directories while keeping
+	 * their filename the same.  If we had a way of determining or even
+	 * making a good educated guess about which directory these non-unique
+	 * basename files had moved the file to, we could check it.
+	 * Luckily...
+	 *
+	 * When an entire directory is in fact renamed, we have two factors
+	 * helping us out:
+	 *   (a) the original directory disappeared giving us a hint
+	 *       about when we can apply an extra heuristic.
+	 *   (a) we often have several files within that directory and
+	 *       subdirectories that are renamed without changes
+	 * So, rules for a heuristic:
+	 *   (0) If there basename matches are non-unique (the condition under
+	 *       which this function is called) AND
+	 *   (1) the directory in which the file was found has disappeared
+	 *       (i.e. dirs_removed is non-NULL and has a relevant entry) THEN
+	 *   (2) use exact renames of files within the directory to determine
+	 *       where the directory is likely to have been renamed to.  IF
+	 *       there is at least one exact rename from within that
+	 *       directory, we can proceed.
+	 *   (3) If there are multiple places the directory could have been
+	 *       renamed to based on exact renames, ignore all but one of them.
+	 *       Just use the destination with the most renames going to it.
+	 *   (4) Check if applying that directory rename to the original file
+	 *       would result in a destination filename that is in the
+	 *       potential rename set.  If so, return the index of the
+	 *       destination file (the index within rename_dst).
+	 *   (5) Compare the original file and returned destination for
+	 *       similarity, and if they are sufficiently similar, record the
+	 *       rename.
+	 *
+	 * This function, idx_possible_rename(), is only responsible for (4).
+	 * The conditions/steps in (1)-(3) will be handled via setting up
+	 * dir_rename_count and dir_rename_guess in a future
+	 * initialize_dir_rename_info() function.  Steps (0) and (5) are
+	 * handled by the caller of this function.
+	 */
+	char *old_dir, *new_dir;
+	struct strbuf new_path = STRBUF_INIT;
+	int idx;
+
+	if (!info->setup)
+		return -1;
+
+	old_dir = get_dirname(filename);
+	new_dir = strmap_get(&info->dir_rename_guess, old_dir);
+	free(old_dir);
+	if (!new_dir)
+		return -1;
+
+	strbuf_addstr(&new_path, new_dir);
+	strbuf_addch(&new_path, '/');
+	strbuf_addstr(&new_path, get_basename(filename));
+
+	idx = strintmap_get(&info->idx_map, new_path.buf);
+	strbuf_release(&new_path);
+	return idx;
 }
 
 static int find_basename_matches(struct diff_options *options,
-				 int minimum_score)
+				 int minimum_score,
+				 struct dir_rename_info *info)
 {
 	/*
 	 * When I checked in early 2020, over 76% of file renames in linux
@@ -494,7 +579,7 @@ static int find_basename_matches(struct diff_options *options,
 			dst_index = strintmap_get(&dests, base);
 			if (src_index == -1 || dst_index == -1) {
 				src_index = i;
-				dst_index = idx_possible_rename(filename);
+				dst_index = idx_possible_rename(filename, info);
 			}
 			if (dst_index == -1)
 				continue;
@@ -677,8 +762,10 @@ void diffcore_rename(struct diff_options *options)
 	int num_destinations, dst_cnt;
 	int num_sources, want_copies;
 	struct progress *progress = NULL;
+	struct dir_rename_info info;
 
 	trace2_region_enter("diff", "setup", options->repo);
+	info.setup = 0;
 	want_copies = (detect_rename == DIFF_DETECT_COPY);
 	if (!minimum_score)
 		minimum_score = DEFAULT_RENAME_SCORE;
@@ -774,7 +861,8 @@ void diffcore_rename(struct diff_options *options)
 		/* Utilize file basenames to quickly find renames. */
 		trace2_region_enter("diff", "basename matches", options->repo);
 		rename_count += find_basename_matches(options,
-						      min_basename_score);
+						      min_basename_score,
+						      &info);
 		trace2_region_leave("diff", "basename matches", options->repo);
 
 		/*
-- 
gitgitgadget

