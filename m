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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218DAC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C988A2310D
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392277AbhAST4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392091AbhASTzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:55:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53830C061794
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so890700wmz.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w2/HSScYSrG8aAG3GHWx2M+5Qf4iHoRWPTPJjAhD8So=;
        b=PHBrjhHshBa9UI7S/Jmo4b7VMf+T58cHtxHYqs2O0MqSNrYHOYrUkSIeMfYGxtfpDN
         bbasUb8nDSg+YFQEAhrXMs0Xaa0apvd74jBjClHqTme5E1HpjFufqTOCFQ1vZ8UzJ+EP
         XS3RB2+5tSxRFe+TAVBgAtWLpi3KmRGly/BcRqT0MyQ+5TsWeBSKkTmToDElpJDXiP2Z
         3fG2UXdRIhy6NVmU1C4V84tGGeMIrvfFiM2+0vdL6ijdLqI+x2LZSBVRVPZozDRSwwQ6
         9uVAqGzd6DVEn+8ZJf/Y44eCngDuMdSTGglCj7JW/ne5jBKVsbOvEH0p/ft2dFYP7Pa5
         RJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w2/HSScYSrG8aAG3GHWx2M+5Qf4iHoRWPTPJjAhD8So=;
        b=WnikWAzWxDCWiJPrihVTGd4kidvH3N8AC9A9LvQ7fYcI07hlnB5zdYoZKcUZNeNZ93
         rKdBp/jqngyvSsWxMz35T0xe3wXobWr6j0fsm9ZnpJVyBOSjCCRFbGQoibtB0hIv3ZOi
         7Opm+/WN3mc2DthdhGjKScyKf8uEp7pr+1KK0WhEdba9sJSK0QKUP1U4j0cWA2pZETX/
         261qjQ7Eqn3AW3Ne8g/38JStbmuyyWDXdlxvXYXzYZzkZmI427Xx60if77XKgpk2OMfz
         78TqZRWayrSJXJRS7akQFDXWoabHzQU8+VvAp3bCZmI9GkOP5910KgUPjIKNNaxE7Lvk
         VLHg==
X-Gm-Message-State: AOAM530uf5/xjPJEE/5Oq/y39cPSRYtMif9UVMwLn6eleaSn9fss41Pt
        1XAWrxqDeEo/o/RRORW52b1aN3kYHiA=
X-Google-Smtp-Source: ABdhPJx2ZSPrYIDI/Pyx7d83mkH+7itoRultgBzh+00Y7Y9O+dGF01CvMR93prUkpFnEgdG48OjbEw==
X-Received: by 2002:a7b:cb4f:: with SMTP id v15mr1083892wmj.123.1611086043919;
        Tue, 19 Jan 2021 11:54:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s19sm35965025wrf.72.2021.01.19.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:54:03 -0800 (PST)
Message-Id: <28ae21bcb46d2b582183db62b346f5d1998b4e52.1611086033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
References: <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
        <pull.835.v3.git.1611086033.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jan 2021 19:53:46 +0000
Subject: [PATCH v3 10/17] merge-ort: implement compute_collisions()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
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
index c86ed85b097..22028d57f3d 100644
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
@@ -964,11 +977,64 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
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

