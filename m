Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD340C43331
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1DD22519
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbhADXv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbhADXv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:26 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BEAC061794
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:47 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id x13so27700267oto.8
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxcelU7KFx1SjLKVAvfCWMiY5H/moK3W+j2QgFzzW1A=;
        b=bqBiMWpdYf0O/7sFAwNBsDp2hhueZkX3Lx7K1P/OGFmgR2JdeVZua/BbL14Nguh9th
         s0OOy6RsbZzAUbaQgF8MdAYYJXxPD8JEn0eAw/P/uhXVv80NYXTpMo4aoXfkG31mb12F
         ZDrsYNFCAM9PRpjjTnl4zS673vLaCB3LYFssljAmG7H1xc20HJPGm9T7F4iSpIYxGI1O
         LdubLlwz6TST8U5zFYMvs5OTXRPZS7ouXdoOpoVnhSCZUWHNRm9UVVLrcExUR5q5ZbLn
         7bBn49wIoliO5wrhwSNCXwsci0ye5CWPY6qAyTVk4+6EeGq+0zfPEjeRUbDPWPFevnh1
         Quqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxcelU7KFx1SjLKVAvfCWMiY5H/moK3W+j2QgFzzW1A=;
        b=bq7l5VFcVWhow6F81HOf7ESPWuhCyYD7OKuUhTRwv0Gpht4Cg4Dv2BWabHdcLV/ddZ
         8FTb/KrkBx6n9aIWLVVonod7R8TaPqOPIC4ALj/hOsE1KIZezGfyqRDtMgYZPEyeB3Ix
         +I+Ir6YRcxTq4onM7RI246tpibU+S9HrXqKbRS1z9STb0Cqx+0HR6rMPD9B3xMYb0qli
         rcyAVO+CJMEaMC8YL+oUsqOVrIxvi8IrHhQlw/34D3ogW62L2d7DTiCCbe1CysTxVguC
         8PAO+xrhZ/V9f7hEDCpxUQZRA0eof3p0+tJd/sxEpLbp388ilti1/sFch2Dgcb6iIDva
         F5VA==
X-Gm-Message-State: AOAM530+vYfX+gBac+nTI0ic/8oIpVy+1hNdMFtXCnL1cKsnVeGArwQS
        PNLLfOymB09XpKsUbUteytYVk+toPt8=
X-Google-Smtp-Source: ABdhPJyP6oIPVEkmWq/jNeGgNozLBrW8j4NqVDhYFv3APVCki+SgSDg9teeRLrgNF8JwhUN59rJMsA==
X-Received: by 2002:a9d:744a:: with SMTP id p10mr54487116otk.203.1609804247048;
        Mon, 04 Jan 2021 15:50:47 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:46 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 17/17] merge-ort: fix a directory rename detection bug
Date:   Mon,  4 Jan 2021 15:50:06 -0800
Message-Id: <20210104235006.2867404-18-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index 480f212cff..8f4ca4fe83 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1182,109 +1182,6 @@ static char *apply_dir_rename(struct strmap_entry *rename_info,
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
@@ -1370,6 +1267,14 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
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
@@ -1391,6 +1296,76 @@ static void increment_count(struct strmap *dir_rename_count,
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
@@ -1398,19 +1373,11 @@ static void compute_rename_counts(struct diff_queue_struct *pairs,
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
@@ -1418,12 +1385,9 @@ static void compute_rename_counts(struct diff_queue_struct *pairs,
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
2.29.1.106.g3ff750dc32.dirty

