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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F08C433E9
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CFC664F0D
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 01:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBZB7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBZB7F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:05 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49775C061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so5867829wml.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S7QhOKpNedye8XWJ7lDyzA6byKu3rQgRqrWL9c0l/V4=;
        b=iD3ZbdCQXBx6iGJQSSlFoOjmJBOfLiqBtKCegiZYFRyVYa6WkQARGbo1Ullk36XdaM
         8qXHBmbU4pCxr+wMiOa8Wc6omYodg1MzFPtLFnZ4f3xSpb1ezxHyBY+9A4V0mnaOaI3d
         /HWQPLfwGPryB5BDQFx8HiRtRequUZYyUbGFQSiGLvfBMdII9Mc7EC4NBTRw6joW3emJ
         ZAZl/yBdcFi8e444qNwSUX4zzZeOc2w+RCG/iSEy9GLVDdGWDL95eIGUet4p/I22o/d9
         Q/45is9dszMdqNpirR/46bC06DoCQStaViKFsiOm1G5hJTArM5H7rSxTRvJ+zKY647nk
         u8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S7QhOKpNedye8XWJ7lDyzA6byKu3rQgRqrWL9c0l/V4=;
        b=S3XqHSuEtvfm+WJuQqQZmqEILjKzO3XjzPqNcbsck5N3N2qgcNMs2S3ipUDtaXCRES
         djUREnM23ScbqIo/4v4VqvHLyv1bfljqlp1jzYRrHMdrps3aAYssqo+Q+jxP+GVznltr
         BfXvcmXL0E/Pl57+fRn3zdyA9ajZIFUxIHo/GhezEmU9JPaCaQXUJmJHRIBdHSc6ytMZ
         6QaTMVvCZWNc6ylS7/MHgvLaV9Ge4TtlmWsXSr5JIg9rLMQMoHgqnRHIY7tlDh6TJI6o
         FQjnBUqH/7llOVxhP85CuMlu4EpI/sP2qtBbp/n0vGnDa3h4fN6KyLmnRPR/d8f2kFih
         xuYw==
X-Gm-Message-State: AOAM531AggdcHOIsB7v5aO3Vj/NNNuIwPmVRSRqfkg11HdUb7O8wrUBh
        L7b8jfcD1nvEgESczOwshkPvddUGDZE=
X-Google-Smtp-Source: ABdhPJzly4Zk7ww6VsK3x3TAAs+xsuEKn/kxyUuPCgxeI75zZGPvy2Q2T0imCvV3NXB/c2i3khooPw==
X-Received: by 2002:a1c:f30a:: with SMTP id q10mr400039wmq.159.1614304704015;
        Thu, 25 Feb 2021 17:58:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r18sm11072632wro.7.2021.02.25.17.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:23 -0800 (PST)
Message-Id: <40f57bcc2055773a7dd35bde50c54354a643d07a.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:11 +0000
Subject: [PATCH v3 02/10] diffcore-rename: add a new idx_possible_rename
 function
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

