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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB595C433DB
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9580564E23
	for <git@archiver.kernel.org>; Sun, 14 Feb 2021 08:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBNIBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 03:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBNIAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 03:00:30 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B1C061793
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w4so3491206wmi.4
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 23:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d8rKxuBLiSni/HR5WuT2zLq1YB82P0UW4xQ3B2kXB28=;
        b=Ie1Udvvwpg9cacC2dNBTexcz9MgyWiPMhS5yKkELHFvFGJcUmPOM+ExZOJmA3fQxcN
         dLKwMfU794GeMPbEavd9pxMQKpeZn/YzqZX8ob/qEZEQ4DSNEvip98JIS6qQHCwIWFPI
         A9NPsc4Lt7cdHkfkcZvePQdq472pwyk6RTwZvHfvQ5VfH9ntvm+xZK7fNeU7ZuvJJ/KE
         HZCNmUdS2Kt4pmhdGUjxl7Y3C/6t2tCatXNtdrwzNARiQ3VQQhh9Rd2hOLC5UsemBDsg
         YR/yg9A/b/b2cyWBS6OZ6TvxjyIzdQxwaEn0PtOz+8OTUcz/M/14Bbjz6udG8jHhwHgM
         JTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d8rKxuBLiSni/HR5WuT2zLq1YB82P0UW4xQ3B2kXB28=;
        b=tew+lzBFvOAIKKk4PhCm8tKJYRBRoVtNcVP+61gim2/4NmODm0oZXn/keeUhxHeEnF
         6wJ3YbFdFVZNTmmogYQkKfsRsQTyrWZWOXMj8FhLR1zsE7UFISdRlEqZLLsYeywARCDD
         /5PHuk625SsBhmEzuYi6a4rex4y7uwD8XLIK0yuUCRiSIj/zwhE9ekvUqvo5dY44M5yV
         Mza32zbZv9gkUVonC2HfY1VeZ5ywQl6q3Y8jGtx1nF8rnTEZEukhEM/N+afPdK68RSUV
         2Y1E7ZvweUe2KeF1sRogW967sTE3osdw5lkYBCGsp9cclrW7AI7f+xM9cQrmocJnQZih
         OPdA==
X-Gm-Message-State: AOAM530j3W+XDFcUYv3Cv6r3CO59g9pE2x+69y7MPDYNYlI7ys5WJJ1P
        sbl6M/jNGUZS7/ZRF8jFVoAmyb3CzUY=
X-Google-Smtp-Source: ABdhPJxgeoXE4YOlXczZa9oDmAA3hASmPfmpBoYIdBzQhpZz/0JItiD8WQAPoIAb+89zTqJh/1N5MQ==
X-Received: by 2002:a05:600c:2e48:: with SMTP id q8mr6277589wmf.88.1613289549766;
        Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm3659566wrv.9.2021.02.13.23.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 23:59:09 -0800 (PST)
Message-Id: <cbd055ab33998962cb7712906cdad5dff3390660.1613289544.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.git.1613289544.gitgitgadget@gmail.com>
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Feb 2021 07:59:01 +0000
Subject: [PATCH 08/10] diffcore-rename: add a new idx_possible_rename function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

find_basename_matches() is great when both the remaining set of possible
rename sources and the remaining set of possible rename destinations
have exactly one file each with a given basename.  It allows us to match
up files that have been moved to different directories without changing
filenames.

When basenames are not unique, though, we want to be able to guess which
directories the source files have been moved to.  Since this is the job
of directory rename detection, we employ it.  However, since it is a
directory rename detection idea, we also limit it to cases where we know
there could have been a directory rename, i.e. where the source
directory has been removed.  This has to be signalled by dirs_removed
being non-NULL and containing an entry for the relevant directory.
Since merge-ort.c is the only caller that currently does so, this
optimization is only effective for merge-ort right now.  In the future,
this condition could be reconsidered or we could modify other callers to
pass the necessary strset.

Anyway, that's a lot of background so that we can actually describe the
new function.  Add an idx_possible_rename() function which combines the
recently added dir_rename_guess and idx_map fields to provide the index
within rename_dst of a potential match for a given file.

Future commits will add checks after calling this function to compare
the resulting 'likely rename' candidates to see if the two files meet
the elevated min_basename_score threshold for marking them as actual
renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index d24f104aa81c..1e4a56adde2c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -374,6 +374,12 @@ struct dir_rename_info {
 	unsigned setup;
 };
 
+static char *get_dirname(const char *filename)
+{
+	char *slash = strrchr(filename, '/');
+	return slash ? xstrndup(filename, slash-filename) : xstrdup("");
+}
+
 static void dirname_munge(char *filename)
 {
 	char *slash = strrchr(filename, '/');
@@ -651,6 +657,81 @@ static const char *get_basename(const char *filename)
 	return base ? base + 1 : filename;
 }
 
+MAYBE_UNUSED
+static int idx_possible_rename(char *filename, struct dir_rename_info *info)
+{
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
+	 * The conditions/steps in (1)-(3) are handled via setting up
+	 * dir_rename_count and dir_rename_guess in
+	 * initialize_dir_rename_info().  Steps (0) and (5) are handled by
+	 * the caller of this function.
+	 */
+	char *old_dir, *new_dir, *new_path;
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
+	new_path = xstrfmt("%s/%s", new_dir, get_basename(filename));
+
+	idx = strintmap_get(&info->idx_map, new_path);
+	free(new_path);
+	return idx;
+}
+
 static int find_basename_matches(struct diff_options *options,
 				 int minimum_score,
 				 struct dir_rename_info *info,
-- 
gitgitgadget

