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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A49C433E6
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685F42255F
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhADXvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbhADXvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:51:02 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76641C06179E
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 15:50:40 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q25so27699989otn.10
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bMKGIkWjChas4gmQd1Tpi1mi8PGOvDQ31SZeYXakCw=;
        b=FB6wuj1VDLdVOAhjiu4gd68xaWtV9+ZfH1b0/MlCZ+cI7cNT6dHYrhwSPZ27xJ+i0n
         UVFxiTwnL+VEHM39vksF4i0RJAzm/nfVKd5cgJDuvXcseGzVo4CIozswN8s9Elevr8vI
         0J3SKFfV1yEwnUYXWWDSQXwFWduy2FOR8hAVCJZSeB/XzetOYL9mOXpDTiLNwa6qb7/I
         ii6coNqfxXPhrFv7zlJYwvehSdI+0wK/xO1EPFOINLlaQ9yh4OswiInLBML6FKEtyuSt
         UST9kzYCnfUP4LSkk5cxCiFFS9ZAGYyMsykAv6XHruVHRCIialre5xO+48++L6Jo7Gqi
         VNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bMKGIkWjChas4gmQd1Tpi1mi8PGOvDQ31SZeYXakCw=;
        b=RSdx2ZhrQb3C06yHHMtgz/Ww9RopFhQ17SCdVo7sJqq+1eNSn2QvwTeGZBmCK51yFM
         PAfpVeQ7d48ZXqh7Eu5GJKP6VeHSJLmHoAdcndW1eNPQ0HY0Dc+IKR0g5WxfqWobcedf
         bW69uSdmK73w3izrjybraAAQ8twTmQUPp860CCeQsuvGBYWFTdu1K32dkCBzZ+Ab/ZHH
         HMhqbDb52oNXC6a6YnAzxr95HA93zZ3D3RRqccsa0WqvGLvL9wU8Rs+03BlJnmxuHvk2
         +CtSY7MyU3lQpCSWH2DrNBr6cV5cizTXRYEP2S4DcZQErxfAd5Ynf0UtT9j03E7Wq15/
         4Lxw==
X-Gm-Message-State: AOAM533dsdDSRmZiAlZRCpzKPbr0nfZSkl9LbDF4Yu5lV0U8uVwpchPC
        Lo56kLCZvaC9jgHYwYSsyIElIWvXBAw=
X-Google-Smtp-Source: ABdhPJyuX6h3KRt0JBsoN/7p0SZUr8FXVu7jPiIr4INUvpywbpMl2b/6f6XlKfnwni4UvyYvDjBdqg==
X-Received: by 2002:a9d:2035:: with SMTP id n50mr52430625ota.44.1609804239699;
        Mon, 04 Jan 2021 15:50:39 -0800 (PST)
Received: from tiger.attlocal.net ([2600:1700:bae0:2de0::26])
        by smtp.gmail.com with ESMTPSA id o135sm13359600ooo.38.2021.01.04.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 15:50:39 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/17] merge-ort: implement compute_collisions()
Date:   Mon,  4 Jan 2021 15:49:59 -0800
Message-Id: <20210104235006.2867404-11-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.106.g3ff750dc32.dirty
In-Reply-To: <20210104235006.2867404-1-newren@gmail.com>
References: <20210104235006.2867404-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
index a52905c4ee..9c9be645ea 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1144,6 +1144,19 @@ struct collision_info {
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
@@ -1383,11 +1396,64 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
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
2.29.1.106.g3ff750dc32.dirty

