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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29634C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92C323444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAGUCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbhAGUCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40AEC0612A0
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e25so6594670wme.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uJLyoB/uoq2MmvnDWAoRFFOhn647HBz0bQTBAePKgmM=;
        b=ubNtddEjK2pswsc3+eg/OxjO+Zr5V80dfMG4rzuKMwOGuwciGMECjljZyq/NLZyHRy
         snD/NTY4ZI0P6ZLJxCPZ3WuGKKZL9qgta92VjyjoA6dbSSLqpURWE96diHUzpUtxluLw
         9fRlR7NACpxarneB0S+9x1s+Kuq0XkKEJppVdpySlljo45H5iyrzAddBW5lGGoKQMnD8
         K2wT9zWJgo/ZMgwp5JF3Pr1DQtY0eNa/obeWhNnFYabERFkv/25AFTub8BnO9MJLhtn6
         xiELr0vF6AjSp9Kz/U3dplkgQoWI3ZOepR2R20l+RBr9boRimWoCkSHPqciSn5KUSWzp
         WFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uJLyoB/uoq2MmvnDWAoRFFOhn647HBz0bQTBAePKgmM=;
        b=r7pQ5pbsbKISUBHW1ZWcoUlRLAOzhxpvBt60fPb1uP81sehgywbYWz7PoSzGD7iaJ5
         2dMxvSujF4EdpEFi/69DafNAspMLjhIuDa4SUDa8Thytl4tXfuTrgBFGirPp300kmB4Y
         sEN4890PGQE1GIBh5JzRmPLrTQmTpqk5wbL3fAeIJsczSQN2up14fOp21j156M3m4KvQ
         SVs8e7iYpJWLvqAsAaUA3RZbQFTRc7Xe95N2hD2lhhr0C0WOPUtYBusFAmhUMzTVTccc
         AXIVCOG5AiUNQO+/ASqiw9pmNiihiWO+zU/KuX2b3cRFCf2HKxyLDvIS9b6bwmV0/cDi
         c40g==
X-Gm-Message-State: AOAM533JEzyNArcBfhYjQy/Uu+oZCx1BNBVR6kAuTMsF7gOggeBmZvA9
        kz536PgwmvZSu0p7wOoIWlw7M/Vvh+w=
X-Google-Smtp-Source: ABdhPJzx3AX8AhGbUgMJdHoy7qk776TVlujIYW0gk+uEtq7lNkwzal28NJRsKMWmSzafCaA3+zO+BQ==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr177763wme.76.1610049701269;
        Thu, 07 Jan 2021 12:01:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v65sm4747483wme.23.2021.01.07.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:40 -0800 (PST)
Message-Id: <734891cb3153f9e1982721257b766ed9c10b9676.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:22 +0000
Subject: [PATCH 13/18] merge-ort: implement handle_path_level_conflicts()
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

This is copied from merge-recursive.c, with minor tweaks due to:
  * using strmap API
  * merge-ort not using the non_unique_new_dir field, since it'll
    obviate its need entirely later with performance improvements
  * adding a new path_in_way() function that uses opt->priv->paths
    instead of doing an expensive tree_has_path() lookup to see if
    a tree has a given path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6823f812c28..43cfee29bd0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -864,6 +864,16 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 	*new_dir = xstrndup(new_path, end_of_new - new_path);
 }
 
+static int path_in_way(struct strmap *paths, const char *path, unsigned side_mask)
+{
+	struct merged_info *mi = strmap_get(paths, path);
+	struct conflict_info *ci;
+	if (!mi)
+		return 0;
+	INITIALIZE_CI(ci, mi);
+	return mi->clean || (side_mask & (ci->filemask | ci->dirmask));
+}
+
 /*
  * See if there is a directory rename for path, and if there are any file
  * level conflicts on the given side for the renamed location.  If there is
@@ -876,7 +886,67 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 					 struct strmap_entry *rename_info,
 					 struct strmap *collisions)
 {
-	die("Not yet implemented");
+	char *new_path = NULL;
+	struct collision_info *c_info;
+	int clean = 1;
+	struct strbuf collision_paths = STRBUF_INIT;
+
+	/*
+	 * entry has the mapping of old directory name to new directory name
+	 * that we want to apply to path.
+	 */
+	new_path = apply_dir_rename(rename_info, path);
+	if (!new_path)
+		BUG("Failed to apply directory rename!");
+
+	/*
+	 * The caller needs to have ensured that it has pre-populated
+	 * collisions with all paths that map to new_path.  Do a quick check
+	 * to ensure that's the case.
+	 */
+	c_info = strmap_get(collisions, new_path);
+	if (c_info == NULL)
+		BUG("c_info is NULL");
+
+	/*
+	 * Check for one-sided add/add/.../add conflicts, i.e.
+	 * where implicit renames from the other side doing
+	 * directory rename(s) can affect this side of history
+	 * to put multiple paths into the same location.  Warn
+	 * and bail on directory renames for such paths.
+	 */
+	if (c_info->reported_already) {
+		clean = 0;
+	} else if (path_in_way(&opt->priv->paths, new_path, 1 << side_index)) {
+		c_info->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &c_info->source_files);
+		path_msg(opt, new_path, 0,
+			 _("CONFLICT (implicit dir rename): Existing file/dir "
+			   "at %s in the way of implicit directory rename(s) "
+			   "putting the following path(s) there: %s."),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	} else if (c_info->source_files.nr > 1) {
+		c_info->reported_already = 1;
+		strbuf_add_separated_string_list(&collision_paths, ", ",
+						 &c_info->source_files);
+		path_msg(opt, new_path, 0,
+			 _("CONFLICT (implicit dir rename): Cannot map more "
+			   "than one path to %s; implicit directory renames "
+			   "tried to put these paths there: %s"),
+		       new_path, collision_paths.buf);
+		clean = 0;
+	}
+
+	/* Free memory we no longer need */
+	strbuf_release(&collision_paths);
+	if (!clean && new_path) {
+		free(new_path);
+		return NULL;
+	}
+
+	return new_path;
 }
 
 static void increment_count(struct strmap *dir_rename_count,
-- 
gitgitgadget

