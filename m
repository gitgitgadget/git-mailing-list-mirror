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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0CC4332B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D17235FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 21:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbhAGVhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbhAGVhh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 16:37:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A293C061290
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 13:36:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c133so6278187wme.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 13:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xk6I5P6DqHm/qwpFbAbA7RHflfrmgcuc6HeGgd6g7G4=;
        b=cYYc9ChdTdgrWEZeVyfEeqpjivI3n0HG7Mnh3P5we6vXTucYtErmve2bGeNiGBYBIX
         RxGVcy64QVNUYBy0wgkSEsPaWwVLtdgLt1QkwG9NvV0o0zQc5l8MUFEvQ8fv3Ug8tkFE
         iA9q7YB7X+DqAtLJA9xvaz6Z1vYwkSfAUuk9jQz8+z+pAPmyPKMb9BMSfUaHb4ErqUz3
         NqofY4OBfwSwqxHy38OWBPssH+YlkwUv5LR2FJLpXWnw6RRKzg1Cn6TKFcud1IFDo9t0
         7y7pmI3FZyEeuLYAgKZ4Z8OpWGL8UM1dWSVTNPJhLM4aL3Ek4fyfMyl/2YnqMYEPeH1C
         Iv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xk6I5P6DqHm/qwpFbAbA7RHflfrmgcuc6HeGgd6g7G4=;
        b=kv3u1MWlgS9pBzPSRE5PpshopWxsG7vDaNzaKLUFZdXkB7n72z0GOmeMLAoWm6MFmp
         fluQrE7VBEPDpCW6jScJpiAUwmNGzWZQEfI1Z1khWU05g0zgscAvJVkjq3ZgCEAewP/l
         FX3SfjpJfAPS8e0DA3nfTdTd4WDxthHVF3uj8F+yvLrQwbskdog/I9zC0nAaissc0PvL
         7xEgm+s5XmFuQsGA88CwktN2xXA4ZLFeWtDbNe+ZjeQrzBhERbtSNi64wH8gtKDjaauB
         F/47HA+XuTRWPd9jsCfzUODDBhll56rUhQCJrJLM4FtPggMKIJnQTdzzLXz+N51h/W0s
         xWPA==
X-Gm-Message-State: AOAM533gS/k5kc2LQiUNbzIhnEbcdA7gjZdNSlPP5AYwewisfjJmTPGq
        mD18UfRwbxLUmEP0kveKMDnpI1y70NY=
X-Google-Smtp-Source: ABdhPJxU4MQGnIL4vawRBrh4QgnOADU5o4bcT68DNlG6rpjjyCPxj7EkSJJhBxAlm+rvjUD+nNJ3gg==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr423411wmc.14.1610055378066;
        Thu, 07 Jan 2021 13:36:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm11316142wro.16.2021.01.07.13.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:36:17 -0800 (PST)
Message-Id: <9a06c698857d4067ea34f9ae9dd610b999b907b8.1610055365.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
        <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 21:35:58 +0000
Subject: [PATCH v2 10/17] merge-ort: implement compute_collisions()
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

