Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E03C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F8264DF5
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 00:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhB0Aci (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhB0AcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 19:32:17 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DADBC061793
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p3so8674160wmc.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jcp+2po5eYalNBBHgg5x93G8rLL4n6w/mFVuCzoRZ3s=;
        b=QDZQUKpQlY7PtLvvII0sPnd3Swh5ZRaKfCVVP5Ci7BTU6f/3JRs9OkTcAvSWw+WLmp
         kZE+6U4t0qErfG53exyx67ezBMzDsX5H+3rbYZc9vwp8lBIGeg58r7nvKyuJkamIZnMV
         llTh2RHn8BSUsqBQfIkx9Dux1AEU2FhYXizplZgGJJwAC06uoe4PGHr28sgQ7bGH72o9
         S78Soq+HQqTgI3VSaKJK0XHpM5uSPjqmEDDM9vvD4JB3yBsNaFuq9Eiv1XbXtqt/rY5A
         jX6DKGb/teF3kd7A35jINrqqFmI1cc/SIRA/fU0NLcr830tcma6meG/h2/OZ41xFK+YW
         kq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jcp+2po5eYalNBBHgg5x93G8rLL4n6w/mFVuCzoRZ3s=;
        b=K4Boqj0y7bk6txD+fSl/cfGfHuvZI/BQnDKr/tmU9o+Mu30843NKnWb9uXk6Fcx1MP
         PJbOK/URmUvrSebmljwJRPWnMtIhshwVTLfbo7zhn9zgkwDfb6iY/Y8NvMPL+YaP6N9d
         6fBfI8paKELz2Jl2Xq/LVSp9rOYCSgrLqjSRAjY5/DxumXCutDr2eTpka7AsIaKTLq+W
         w6o0hcp8F7mN0HQ0sl55Eihc/IMb9GVVIc9rFbSNTDUr6WkyX9CxMRxuc3RSxPY0oY/k
         zfAV6c5HQcNu2pcLMFvxHuhEGObNz00UDBSRES/TtVwZWamsalGppa4bIn8a+7PJzd2P
         HZVA==
X-Gm-Message-State: AOAM530dhTe949XgXgzT5oxXa9QNusqCZs3WXpz+pq4YiS2hgTIfDLqo
        ioicJRzqzEeHwfrG2PZ2f6kQ6tXwZ6U=
X-Google-Smtp-Source: ABdhPJwtzR1XGqcl3rzyAyVVyHrS9Py/RUAUO8/zk53hP2rikds+9GJEhN1yZ6dZxJvG4M2GHoXhjg==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr5181608wmb.14.1614385855408;
        Fri, 26 Feb 2021 16:30:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm16401847wru.64.2021.02.26.16.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 16:30:55 -0800 (PST)
Message-Id: <9c3436840534266ab257ab59e04364722bf3f6e9.1614385849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
References: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
        <pull.844.v4.git.1614385849.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Feb 2021 00:30:45 +0000
Subject: [PATCH v4 07/10] diffcore-rename: extend cleanup_dir_rename_info()
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

When diffcore_rename_extended() is passed a NULL dir_rename_count, we
will still want to create a temporary one for use by
find_basename_matches(), but have it fully deallocated before
diffcore_rename_extended() returns.  However, when
diffcore_rename_extended() is passed a dir_rename_count, we want to fill
that strmap with appropriate values and return it.  However, for our
interim purposes we may also add entries corresponding to directories
that cannot have been renamed due to still existing on both sides.

Extend cleanup_dir_rename_info() to handle these two different cases,
cleaning up the relevant bits of information for each case.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index a1ccf14001f5..2cf9c47c6364 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -543,8 +543,15 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
 	strmap_partial_clear(dir_rename_count, 1);
 }
 
-static void cleanup_dir_rename_info(struct dir_rename_info *info)
+static void cleanup_dir_rename_info(struct dir_rename_info *info,
+				    struct strset *dirs_removed,
+				    int keep_dir_rename_count)
 {
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list to_remove = STRING_LIST_INIT_NODUP;
+	int i;
+
 	if (!info->setup)
 		return;
 
@@ -555,8 +562,33 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info)
 	strmap_clear(&info->dir_rename_guess, 1);
 
 	/* dir_rename_count */
-	partial_clear_dir_rename_count(info->dir_rename_count);
-	strmap_clear(info->dir_rename_count, 1);
+	if (!keep_dir_rename_count) {
+		partial_clear_dir_rename_count(info->dir_rename_count);
+		strmap_clear(info->dir_rename_count, 1);
+		FREE_AND_NULL(info->dir_rename_count);
+		return;
+	}
+
+	/*
+	 * Although dir_rename_count was passed in
+	 * diffcore_rename_extended() and we want to keep it around and
+	 * return it to that caller, we first want to remove any data
+	 * associated with directories that weren't renamed.
+	 */
+	strmap_for_each_entry(info->dir_rename_count, &iter, entry) {
+		const char *source_dir = entry->key;
+		struct strintmap *counts = entry->value;
+
+		if (!strset_contains(dirs_removed, source_dir)) {
+			string_list_append(&to_remove, source_dir);
+			strintmap_clear(counts);
+			continue;
+		}
+	}
+	for (i = 0; i < to_remove.nr; ++i)
+		strmap_remove(info->dir_rename_count,
+			      to_remove.items[i].string, 1);
+	string_list_clear(&to_remove, 0);
 }
 
 static const char *get_basename(const char *filename)
@@ -1218,7 +1250,7 @@ void diffcore_rename_extended(struct diff_options *options,
 		if (rename_dst[i].filespec_to_free)
 			free_filespec(rename_dst[i].filespec_to_free);
 
-	cleanup_dir_rename_info(&info);
+	cleanup_dir_rename_info(&info, dirs_removed, dir_rename_count != NULL);
 	FREE_AND_NULL(rename_dst);
 	rename_dst_nr = rename_dst_alloc = 0;
 	FREE_AND_NULL(rename_src);
-- 
gitgitgadget

