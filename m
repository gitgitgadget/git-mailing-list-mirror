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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D2C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A633223447
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAGUCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGUCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54BC061290
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so6832419wrj.7
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NHnapn2YaP8WvGrSYN719MNz1Vbq/U0fN5T5UuDmtNM=;
        b=YxL2XM8hYzrPB7Sg9jKT477f3lblKLZK2vDEz9W9Y4Fk6O+NFqKjC9QjUv4kS0Qm6t
         oU9xq/AhlI+uKRTCbX4IZ8wLTCAPdfwfDiIyEtqwqR7zBlZRDl9FDOX/aJIg0FKLC6mj
         wEmf0mpSfo8xiozkUFa7y8mi2XvwAO0kzXFEOxMbI4fiVeCutCRHO/19wGttcyyRCK/b
         v0WKkMYnNnRp0icMkKFL9BOtlGOwkOyzt86NqUf5dtuHVqXiU3zdf9k3POSbTJ5S3ejJ
         rgMvRnqv0WNuYuGPfjcLB+/VwqNZ4NJROfAKDiZdGI6tDLnPgkmoVEgMtNL5m5NmCGxq
         Babg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NHnapn2YaP8WvGrSYN719MNz1Vbq/U0fN5T5UuDmtNM=;
        b=Z4vCGP7skNDC+Hfrr/XxXUySqbc+NpqebAl43QY+/WPZ/M2lp7kH0KNCy2suFZGZHs
         eLJ6fK7MajjEW24u3lcICHNhQJCchuXGGhc7BT7T2YjEXpkX6EGaqbwTSCMP+kp8ieKr
         j34saySB7kUiyuF+d2VPdV5TOHMgpdltXGd99I2JKI2eC8Qt9mL1sEZvfoUhDmUiiVe1
         J8/ORf59RB3lyNJl4TLn/zoQTXQ1buK4wsRgpeR6UQ88Io9iaT3mTERlF/VYj30CUHzK
         OBlfEc+U1ZFCXBwbA+ODpRCMxsjdxLilY8svoZJyBt6PwILNEWAbT2GNiEopji06ESmc
         rWtw==
X-Gm-Message-State: AOAM532n1Ap4ObJidGK5qkrl0fmE1J41O4aBvz9IP7wvXXofId/8IdMk
        63k16nx1Ku3lBfkjI5DPEtWTmrqqHJQ=
X-Google-Smtp-Source: ABdhPJz8YM0q6/4VA4xH1dQYfM7lZKSTuwADABYQb4PO8EkM1J1q9wP6OZT36pa17V57huzk35Z7Xw==
X-Received: by 2002:adf:bb0e:: with SMTP id r14mr271826wrg.159.1610049700379;
        Thu, 07 Jan 2021 12:01:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm8952840wme.4.2021.01.07.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:39 -0800 (PST)
Message-Id: <cbfdf4d9ba04aeec6b83699e6294b2d9dc352574.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:21 +0000
Subject: [PATCH 12/18] merge-ort: implement check_for_directory_rename()
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

This is copied from merge-recursive.c, with minor tweaks due to using strmap
API and the fact that it can use opt->priv->paths to get all pathnames that
exist instead of taking a tree object.

This depends on a new function, handle_path_level_conflicts(), which
just has a placeholder die-not-yet-implemented implementation for now; a
subsequent patch will implement it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 8ee9c685c7b..6823f812c28 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -864,6 +864,21 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+/*
+ * See if there is a directory rename for path, and if there are any file
+ * level conflicts on the given side for the renamed location.  If there is
+ * a rename and there are no conflicts, return the new name.  Otherwise,
+ * return NULL.
+ */
+static char *handle_path_level_conflicts(struct merge_options *opt,
+					 const char *path,
+					 unsigned side_index,
+					 struct strmap_entry *rename_info,
+					 struct strmap *collisions)
+{
+	die("Not yet implemented");
+}
+
 static void increment_count(struct strmap *dir_rename_count,
 			    char *old_dir,
 			    char *new_dir)
@@ -1079,7 +1094,57 @@ static char *check_for_directory_rename(struct merge_options *opt,
 					struct strmap *collisions,
 					int *clean_merge)
 {
-	die("Not yet implemented.");
+	char *new_path = NULL;
+	struct strmap_entry *rename_info;
+	struct strmap_entry *otherinfo = NULL;
+	const char *new_dir;
+
+	if (strmap_empty(dir_renames))
+		return new_path;
+	rename_info = check_dir_renamed(path, dir_renames);
+	if (!rename_info)
+		return new_path;
+	/* old_dir = rename_info->key; */
+	new_dir = rename_info->value;
+
+	/*
+	 * This next part is a little weird.  We do not want to do an
+	 * implicit rename into a directory we renamed on our side, because
+	 * that will result in a spurious rename/rename(1to2) conflict.  An
+	 * example:
+	 *   Base commit: dumbdir/afile, otherdir/bfile
+	 *   Side 1:      smrtdir/afile, otherdir/bfile
+	 *   Side 2:      dumbdir/afile, dumbdir/bfile
+	 * Here, while working on Side 1, we could notice that otherdir was
+	 * renamed/merged to dumbdir, and change the diff_filepair for
+	 * otherdir/bfile into a rename into dumbdir/bfile.  However, Side
+	 * 2 will notice the rename from dumbdir to smrtdir, and do the
+	 * transitive rename to move it from dumbdir/bfile to
+	 * smrtdir/bfile.  That gives us bfile in dumbdir vs being in
+	 * smrtdir, a rename/rename(1to2) conflict.  We really just want
+	 * the file to end up in smrtdir.  And the way to achieve that is
+	 * to not let Side1 do the rename to dumbdir, since we know that is
+	 * the source of one of our directory renames.
+	 *
+	 * That's why otherinfo and dir_rename_exclusions is here.
+	 *
+	 * As it turns out, this also prevents N-way transient rename
+	 * confusion; See testcases 9c and 9d of t6043.
+	 */
+	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
+	if (otherinfo) {
+		path_msg(opt, rename_info->key, 1,
+			 _("WARNING: Avoiding applying %s -> %s rename "
+			   "to %s, because %s itself was renamed."),
+			 rename_info->key, new_dir, path, new_dir);
+		return NULL;
+	}
+
+	new_path = handle_path_level_conflicts(opt, path, side_index,
+					       rename_info, collisions);
+	*clean_merge &= (new_path != NULL);
+
+	return new_path;
 }
 
 static void apply_directory_rename_modifications(struct merge_options *opt,
-- 
gitgitgadget

