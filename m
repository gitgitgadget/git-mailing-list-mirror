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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A0C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DD364EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhBZB76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 20:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhBZB7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 20:59:47 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEDDC061793
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o10so164307wmc.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q6xWCoRaUIGWN/Uc2QszN/U0R7nKxwitKJAHg6/2FOs=;
        b=ZKhACnnWnQJXcEVV1+4BYrNhb8TsQdE0nkq9T8X6i/fuF208BQ2xXM+RuFV2I3NHl1
         HUDxO9PAuEDiqpaMFidreagwcl38tssPGZID9EtOuF39chOf39FSZQYom/y8Jg9rFSCn
         +tfuPUl4Yx+slhrAQacwfBUi+X7lmFNm1IEdeYzjNYcJmwSE4vjzVX++OxUl9hHUSikL
         +68qD9SsZyuuHp/+ORVOpGl60LjWkynuV7qo88ph7+QbFZ/7K4t9opwW2qqLwRAgP0yj
         nyDYA3Ig5W5ilqaXkzQZcOCgRKZcuY5/QyNyDd3e/F/DVr4AFlp3QNEhyFbvKr9R3r4d
         wS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q6xWCoRaUIGWN/Uc2QszN/U0R7nKxwitKJAHg6/2FOs=;
        b=B/fpD5vcdMrpaWgQfFNZSzJJkCi4PpObAkl7206OHGV0OeK7hzZANjTn6dH5iC+p3l
         WcLBYyXD4eoNwmea8qx5Tj5vEn+k3Spf0Z0wyEctOJxxVahDtRr+4IGLOBe4GJwMjmKM
         Z7dAuo3PSQk/xfFVElEAFHXqsotkjQzZysA0TOIcPhwpA04MRxfURdWpeioyaRsrC5g2
         TgLTP1159IAucBBOKtnIDS3qQyadvGJg6eEz722GLXS0Sb8M2x4AOnPDyPGkVotxkujB
         LGsCDGqgPrePG9EDJNJj8fILkho8UcfhdSvIV0dQZgjcfScwmNo/FsGHCityKYzG6mzU
         7ElQ==
X-Gm-Message-State: AOAM533SIKFz9SdvHS5hYGwGmqvTiKcKR+EIVrnxmEc+HMgx6EPMAB8F
        6zoHBwAqXOKBBBI51u/qyE1KX+Etswg=
X-Google-Smtp-Source: ABdhPJyLuCzGCoBmjKididXc3Cbiu/huiO0XZJsFrxqjM8pHJZDP3KUSn/FoJkcxsLw1KDpTqoLLtQ==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr432680wmd.36.1614304707479;
        Thu, 25 Feb 2021 17:58:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm11144753wrt.89.2021.02.25.17.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 17:58:27 -0800 (PST)
Message-Id: <bd50d9e53804c0cf9b0a428455e9eeea100f26b2.1614304700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
        <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Feb 2021 01:58:16 +0000
Subject: [PATCH v3 07/10] diffcore-rename: extend cleanup_dir_rename_info()
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

