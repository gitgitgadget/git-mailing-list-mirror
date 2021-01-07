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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB26C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA96233EE
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbhAGUCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbhAGUCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805A3C0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so6791523wrm.11
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gO75Y2ITWHlP9keipCaly8dIgYl7zS22kQ7bUpxDDyE=;
        b=dPGFxvgaWi9iD2ards8gb7YZWc75e109esj98jNPdkjPdzlbYw7X8YcXfM/QB09qdG
         R/fjStVN40dQoD+SSArDehQNLnleRPkHlTkhmIUTUW8B2bYyRoQW7Pi8xa1+kufKBwcf
         LCgMm4pF8Ao77IEvazIMnlIXwcuxkORB1RvXRBbmuoKqR4vIy1DkKnT6H1rWCaxma6vn
         shFDwxpIikavg8dU1SxBPazS4dSZJnaaDN+oWdL1fdhDkP87AAev3NKgdriFdlSe/aBb
         Hu3adXMWQZp7ZAq5cLI2eHJjB6CuCxN5e/D1JyPz9wBbqLFxh1Kqjj3EnE/Rwv+nsdWP
         P0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gO75Y2ITWHlP9keipCaly8dIgYl7zS22kQ7bUpxDDyE=;
        b=aCAuclasVBnLycUIw+D9aGF+5vgO1xA5dboyBY2i7aXkyGrxbqQ1t99R5x6QRfVZ8L
         DlX2AN1RMMyG75kKqSEkyUBeqFiX62PXjFk/NrlwwoXyZ+9Tc2U9NR5a5tQhVmMH+LLn
         qoHJcBK2rDGADyNsO61dgesDoUll3IFaYd4lZWr6fDNhLMTClryZHGRuy4WxbUM7gdka
         p9V9djw1zFezsweoHTGDovXM+5D9Co07+wAJ8owmA8LEdBNApS8pm1xby0VkplK5tokd
         vFTuU6DSx22R5bieSAS0i96gqnsPvUFzC8JysQGs7Qbgxm1b5DI+Bj9yVpzVMr3Xsbd2
         AQBA==
X-Gm-Message-State: AOAM530rLZQYj16RU0zBFHpjPaboHQAQFqbeWRSx8weK4XaZyz1hrPVf
        Cib/gW+/lHWQKjx6shUPI4dblSDKavc=
X-Google-Smtp-Source: ABdhPJxSBU/NyK0eKROWxu+KNKVy664dph3nDiRMJoG9Uw5pAHSUyT2qZ8CxbWJoKeeL8X/QmBWc7A==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr302626wrv.132.1610049704942;
        Thu, 07 Jan 2021 12:01:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm10578903wrb.73.2021.01.07.12.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:44 -0800 (PST)
Message-Id: <551878bd84da895e0899eba620553f6efe60e100.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:26 +0000
Subject: [PATCH 17/18] merge-ort: fix a directory rename detection bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit 902c521a35 ("t6423: more involved directory rename
test", 2020-10-15), when we have a case where

  * dir/subdir/ has several files
  * almost all files in dir/subdir/ are renamed to folder/subdir/
  * one of the files in dir/subdir/ is renamed to folder/subdir/newsubdir/
  * the other side of history (that doesn't do the renames) adds a
    new file to dir/subdir/

Then for the majority of the file renames, the directory rename of
   dir/subdir/ -> folder/subdir/
is actually not represented that way but as
   dir/ -> folder/
We also had one rename that was represented as
   dir/subdir/ -> folder/subdir/newsubdir/

Now, since there's a new file in dir/subdir/, where does it go?  Well,
there's only one rule for dir/subdir/, so the code previously noted that
this rule had the "majority" of the one "relevant" rename and thus
erroneously used it to place the file in folder/subdir/newsubdir/.  We
really want the heavy weight associated with dir/ -> folder/ to also be
treated as dir/subdir/ -> folder/subdir/, so that we correctly place the
file in folder/subdir/.

Add a bunch of logic to make sure that we use all relevant renamings in
directory rename detection.

Note that testcase 12f of t6423 still fails after this, but it gets
further than merge-recursive does.  There are some performance related
bits in that testcase (the region_enter messages) that do not yet
succeed, but the rest of the testcase works after this patch.
Subsequent patch series will fix up the performance side.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 198 +++++++++++++++++++++-------------------------------
 1 file changed, 81 insertions(+), 117 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9e4ebd9c4d6..55a835f8b97 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -764,109 +764,6 @@ static char *apply_dir_rename(struct strmap_entry *rename_info,
 	return strbuf_detach(&new_path, NULL);
 }
 
-static void get_renamed_dir_portion(const char *old_path, const char *new_path,
-				    char **old_dir, char **new_dir)
-{
-	char *end_of_old, *end_of_new;
-
-	/* Default return values: NULL, meaning no rename */
-	*old_dir = NULL;
-	*new_dir = NULL;
-
-	/*
-	 * For
-	 *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
-	 * the "e/foo.c" part is the same, we just want to know that
-	 *    "a/b/c/d" was renamed to "a/b/some/thing/else"
-	 * so, for this example, this function returns "a/b/c/d" in
-	 * *old_dir and "a/b/some/thing/else" in *new_dir.
-	 */
-
-	/*
-	 * If the basename of the file changed, we don't care.  We want
-	 * to know which portion of the directory, if any, changed.
-	 */
-	end_of_old = strrchr(old_path, '/');
-	end_of_new = strrchr(new_path, '/');
-
-	/*
-	 * If end_of_old is NULL, old_path wasn't in a directory, so there
-	 * could not be a directory rename (our rule elsewhere that a
-	 * directory which still exists is not considered to have been
-	 * renamed means the root directory can never be renamed -- because
-	 * the root directory always exists).
-	 */
-	if (end_of_old == NULL)
-		return; /* Note: *old_dir and *new_dir are still NULL */
-
-	/*
-	 * If new_path contains no directory (end_of_new is NULL), then we
-	 * have a rename of old_path's directory to the root directory.
-	 */
-	if (end_of_new == NULL) {
-		*old_dir = xstrndup(old_path, end_of_old - old_path);
-		*new_dir = xstrdup("");
-		return;
-	}
-
-	/* Find the first non-matching character traversing backwards */
-	while (*--end_of_new == *--end_of_old &&
-	       end_of_old != old_path &&
-	       end_of_new != new_path)
-		; /* Do nothing; all in the while loop */
-
-	/*
-	 * If both got back to the beginning of their strings, then the
-	 * directory didn't change at all, only the basename did.
-	 */
-	if (end_of_old == old_path && end_of_new == new_path &&
-	    *end_of_old == *end_of_new)
-		return; /* Note: *old_dir and *new_dir are still NULL */
-
-	/*
-	 * If end_of_new got back to the beginning of its string, and
-	 * end_of_old got back to the beginning of some subdirectory, then
-	 * we have a rename/merge of a subdirectory into the root, which
-	 * needs slightly special handling.
-	 *
-	 * Note: There is no need to consider the opposite case, with a
-	 * rename/merge of the root directory into some subdirectory
-	 * because as noted above the root directory always exists so it
-	 * cannot be considered to be renamed.
-	 */
-	if (end_of_new == new_path &&
-	    end_of_old != old_path && end_of_old[-1] == '/') {
-		*old_dir = xstrndup(old_path, --end_of_old - old_path);
-		*new_dir = xstrdup("");
-		return;
-	}
-
-	/*
-	 * We've found the first non-matching character in the directory
-	 * paths.  That means the current characters we were looking at
-	 * were part of the first non-matching subdir name going back from
-	 * the end of the strings.  Get the whole name by advancing both
-	 * end_of_old and end_of_new to the NEXT '/' character.  That will
-	 * represent the entire directory rename.
-	 *
-	 * The reason for the increment is cases like
-	 *    a/b/star/foo/whatever.c -> a/b/tar/foo/random.c
-	 * After dropping the basename and going back to the first
-	 * non-matching character, we're now comparing:
-	 *    a/b/s          and         a/b/
-	 * and we want to be comparing:
-	 *    a/b/star/      and         a/b/tar/
-	 * but without the pre-increment, the one on the right would stay
-	 * a/b/.
-	 */
-	end_of_old = strchr(++end_of_old, '/');
-	end_of_new = strchr(++end_of_new, '/');
-
-	/* Copy the old and new directories into *old_dir and *new_dir. */
-	*old_dir = xstrndup(old_path, end_of_old - old_path);
-	*new_dir = xstrndup(new_path, end_of_new - new_path);
-}
-
 static int path_in_way(struct strmap *paths, const char *path, unsigned side_mask)
 {
 	struct merged_info *mi = strmap_get(paths, path);
@@ -952,6 +849,14 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 	return new_path;
 }
 
+static void dirname_munge(char *filename)
+{
+	char *slash = strrchr(filename, '/');
+	if (!slash)
+		slash = filename;
+	*slash = '\0';
+}
+
 static void increment_count(struct strmap *dir_rename_count,
 			    char *old_dir,
 			    char *new_dir)
@@ -973,6 +878,76 @@ static void increment_count(struct strmap *dir_rename_count,
 	strintmap_incr(counts, new_dir, 1);
 }
 
+static void update_dir_rename_counts(struct strmap *dir_rename_count,
+				     struct strset *dirs_removed,
+				     const char *oldname,
+				     const char *newname)
+{
+	char *old_dir = xstrdup(oldname);
+	char *new_dir = xstrdup(newname);
+	char new_dir_first_char = new_dir[0];
+	int first_time_in_loop = 1;
+
+	while (1) {
+		dirname_munge(old_dir);
+		dirname_munge(new_dir);
+
+		/*
+		 * When renaming
+		 *   "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
+		 * then this suggests that both
+		 *   a/b/c/d/e/ => a/b/some/thing/else/e/
+		 *   a/b/c/d/   => a/b/some/thing/else/
+		 * so we want to increment counters for both.  We do NOT,
+		 * however, also want to suggest that there was the following
+		 * rename:
+		 *   a/b/c/ => a/b/some/thing/
+		 * so we need to quit at that point.
+		 *
+		 * Note the when first_time_in_loop, we only strip off the
+		 * basename, and we don't care if that's different.
+		 */
+		if (!first_time_in_loop) {
+			char *old_sub_dir = strchr(old_dir, '\0')+1;
+			char *new_sub_dir = strchr(new_dir, '\0')+1;
+			if (!*new_dir) {
+				/*
+				 * Special case when renaming to root directory,
+				 * i.e. when new_dir == "".  In this case, we had
+				 * something like
+				 *    a/b/subdir => subdir
+				 * and so dirname_munge() sets things up so that
+				 *    old_dir = "a/b\0subdir\0"
+				 *    new_dir = "\0ubdir\0"
+				 * We didn't have a '/' to overwrite a '\0' onto
+				 * in new_dir, so we have to compare differently.
+				 */
+				if (new_dir_first_char != old_sub_dir[0] ||
+				    strcmp(old_sub_dir+1, new_sub_dir))
+					break;
+			} else {
+				if (strcmp(old_sub_dir, new_sub_dir))
+					break;
+			}
+		}
+
+		if (strset_contains(dirs_removed, old_dir))
+			increment_count(dir_rename_count, old_dir, new_dir);
+		else
+			break;
+
+		/* If we hit toplevel directory ("") for old or new dir, quit */
+		if (!*old_dir || !*new_dir)
+			break;
+
+		first_time_in_loop = 0;
+	}
+
+	/* Free resources we don't need anymore */
+	free(old_dir);
+	free(new_dir);
+}
+
 static void compute_rename_counts(struct diff_queue_struct *pairs,
 				  struct strmap *dir_rename_count,
 				  struct strset *dirs_removed)
@@ -980,19 +955,11 @@ static void compute_rename_counts(struct diff_queue_struct *pairs,
 	int i;
 
 	for (i = 0; i < pairs->nr; ++i) {
-		char *old_dir, *new_dir;
 		struct diff_filepair *pair = pairs->queue[i];
 
 		if (pair->status != 'R')
 			continue;
 
-		/* Get the old and new directory names */
-		get_renamed_dir_portion(pair->one->path, pair->two->path,
-					&old_dir,        &new_dir);
-		if (!old_dir)
-			/* Directory didn't change at all; ignore this one. */
-			continue;
-
 		/*
 		 * Make dir_rename_count contain a map of a map:
 		 *   old_directory -> {new_directory -> count}
@@ -1000,12 +967,9 @@ static void compute_rename_counts(struct diff_queue_struct *pairs,
 		 * the old filename and the new filename and count how many
 		 * times that pairing occurs.
 		 */
-		if (strset_contains(dirs_removed, old_dir))
-			increment_count(dir_rename_count, old_dir, new_dir);
-
-		/* Free resources we don't need anymore */
-		free(old_dir);
-		free(new_dir);
+		update_dir_rename_counts(dir_rename_count, dirs_removed,
+					 pair->one->path,
+					 pair->two->path);
 	}
 }
 
-- 
gitgitgadget

