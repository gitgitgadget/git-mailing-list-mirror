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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7F6C433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A2423447
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbhAGUCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbhAGUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F28C061282
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so6848363wrt.2
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xk6I5P6DqHm/qwpFbAbA7RHflfrmgcuc6HeGgd6g7G4=;
        b=NcGbF/Teqc16f+dDkiUXnywawOTCa8LMa92cFHacyB5KXmhfACxUBGjqngLviEEIQW
         Db3/tCsE2nepoTXI9RnSbiEt9xXRci0JM5ozkErphIO1MFm1/90UHbVkt27BqBrqPgSn
         cjVfYMQ3Gf9WqT3GUFmixNKfySlSh2vK0SPAmrQhmidvUf2PuFXMMAH3ojYjHlQF605O
         iRFBHKpiusak97yqr28BYEz1bPDsNOtIicVYWph6fEuUI4DZyp+Ijqky4QU+Q/Lp3Izq
         Y5GHDcaBn6kC2Sv4zdl4uFmLJP1SiAhM0GfzpvlPfWSc0EPvAHOqD3Gifs3rVojbmrxG
         Ifvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xk6I5P6DqHm/qwpFbAbA7RHflfrmgcuc6HeGgd6g7G4=;
        b=KopSlqHE4bgg2+tkOjEj1g0aqydhoQHhAKG6O7tFCBZhvdm3rgESAILB5aPNxUSsC+
         +gVc2dzj3aO6z7rmSLXEQiRgL8RlED8wGDCZa9kvdQcEnVyUj2RkISVaB9fAdh6jJBIE
         05PB77bkuCGIHelQhqGtlCRZiTs0XMPnTLfBTqgTWWRQprOJXNYoYiC/8CMOuAJQMo3h
         beqDqmupZTqVnjjAM1GKHxvYkQh/OKAd4jEwEQAn1aJ6PmvUFZQZdDMfpA3MFklVvM8F
         9TVgX+Gsrcy8gO0EE60hep4lONlK5x3LNDQox7P6DU+KDV+JBjaJv1Iuns12ut2KMeSH
         XmDg==
X-Gm-Message-State: AOAM530Zu0FyOtsUwmn6mM5bU239J3tnMJLKmruvzzsrlbAtcXa9qhvo
        werU9XFteCTFNiF68EiBX3leE3+k6Y8=
X-Google-Smtp-Source: ABdhPJwgG/iAaWKSh2iaRz6VYgoV/XxBfu8MRAteS9fBrhB8TdsuZ1QBf+COvIFSDucqN3BfvAUeaw==
X-Received: by 2002:adf:fb85:: with SMTP id a5mr249460wrr.331.1610049698415;
        Thu, 07 Jan 2021 12:01:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u66sm9171233wmg.30.2021.01.07.12.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:37 -0800 (PST)
Message-Id: <9a06c698857d4067ea34f9ae9dd610b999b907b8.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:19 +0000
Subject: [PATCH 10/18] merge-ort: implement compute_collisions()
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

This is nearly a wholesale copy of compute_collisions() from
merge-recursive.c, and the logic remains the same, but it has been
tweaked slightly due to:

  * using strmap.h API (instead of direct hashmaps)
  * allocation/freeing of data structures were done separately in
    merge_start() and clear_or_reinit_internal_opts() in an earlier
    patch in this series
  * there is no non_unique_new_dir data field in merge-ort; that will
    be handled a different way

It does depend on two new functions, apply_dir_rename() and
check_dir_renamed() which were introduced with simple
die-not-yet-implemented shells and will be implemented in subsequent
patches.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index f7ecd76c479..e436418d0d2 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -726,6 +726,19 @@ struct collision_info {
 	unsigned reported_already:1;
 };
 
+/*
+ * Return a new string that replaces the beginning portion (which matches
+ * rename_info->key), with rename_info->util.new_dir.  In perl-speak:
+ *   new_path_name = (old_path =~ s/rename_info->key/rename_info->value/);
+ * NOTE:
+ *   Caller must ensure that old_path starts with rename_info->key + '/'.
+ */
+static char *apply_dir_rename(struct strmap_entry *rename_info,
+			      const char *old_path)
+{
+	die("Not yet implemented!");
+}
+
 static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 				    char **old_dir, char **new_dir)
 {
@@ -965,11 +978,64 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 	string_list_clear(&duplicated, 0);
 }
 
+static struct strmap_entry *check_dir_renamed(const char *path,
+					      struct strmap *dir_renames)
+{
+	die("Not yet implemented!");
+}
+
 static void compute_collisions(struct strmap *collisions,
 			       struct strmap *dir_renames,
 			       struct diff_queue_struct *pairs)
 {
-	die("Not yet implemented.");
+	int i;
+
+	strmap_init_with_options(collisions, NULL, 0);
+	if (strmap_empty(dir_renames))
+		return;
+
+	/*
+	 * Multiple files can be mapped to the same path due to directory
+	 * renames done by the other side of history.  Since that other
+	 * side of history could have merged multiple directories into one,
+	 * if our side of history added the same file basename to each of
+	 * those directories, then all N of them would get implicitly
+	 * renamed by the directory rename detection into the same path,
+	 * and we'd get an add/add/.../add conflict, and all those adds
+	 * from *this* side of history.  This is not representable in the
+	 * index, and users aren't going to easily be able to make sense of
+	 * it.  So we need to provide a good warning about what's
+	 * happening, and fall back to no-directory-rename detection
+	 * behavior for those paths.
+	 *
+	 * See testcases 9e and all of section 5 from t6043 for examples.
+	 */
+	for (i = 0; i < pairs->nr; ++i) {
+		struct strmap_entry *rename_info;
+		struct collision_info *collision_info;
+		char *new_path;
+		struct diff_filepair *pair = pairs->queue[i];
+
+		if (pair->status != 'A' && pair->status != 'R')
+			continue;
+		rename_info = check_dir_renamed(pair->two->path, dir_renames);
+		if (!rename_info)
+			continue;
+
+		new_path = apply_dir_rename(rename_info, pair->two->path);
+		assert(new_path);
+		collision_info = strmap_get(collisions, new_path);
+		if (collision_info) {
+			free(new_path);
+		} else {
+			collision_info = xcalloc(1,
+						 sizeof(struct collision_info));
+			string_list_init(&collision_info->source_files, 0);
+			strmap_put(collisions, new_path, collision_info);
+		}
+		string_list_insert(&collision_info->source_files,
+				   pair->two->path);
+	}
 }
 
 static char *check_for_directory_rename(struct merge_options *opt,
-- 
gitgitgadget

