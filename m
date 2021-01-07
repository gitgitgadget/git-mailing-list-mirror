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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6329C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B95623444
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbhAGUCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbhAGUCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:02:18 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10258C0612FE
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 12:01:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id e25so6594490wme.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HFooLETrm6cM084s80tGP8huAtkbI3KV88B3jfO86ys=;
        b=muBC3zn1iuIYNWCMRX49W5yvQYEd4Mr914GzMofcwCL2Rav6oQYlaA2E9/JUr8AyGk
         +ihE7wMHRUJuyGZa8StuzASdvA9QNz6QqsiD9MFASGBaisXKHUoondFSDbnys3Owkigd
         7eoumoYcYaNCBZGTIG3/AzSDxDr4x6JIqQQskRyUO7dIwyHFBDa5O4GLP6X5bbHsxmRf
         WLl48h82oR7J9VO0bMj9S4V7eD5cC2G/OkPEeU2ZWxKGwZPg0ZqCr5eBdsOGfJVi2D0A
         /Cie4TpzACyjvCOnMmxVk0r2p5OYRu5zc9+UaiQq+0GpaKr4FNnQpXqawkfXZltv4njP
         Oiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HFooLETrm6cM084s80tGP8huAtkbI3KV88B3jfO86ys=;
        b=Z9n9X0KnS9oKnzgbZhqOjU3UQX7R3O+8HTJI83BYEmgVOVbumSQfvU0PYZ4+heK3VK
         Jg7AtiI7gdpMflp/4DANgqpHkdiLW3RWJ2I6wEeBwt159X8Aclqo1LxBg9XejdaRWaCY
         +uZc74SxLcCe4TgnbN20VNz2IwZICNyfghh8hRRzrT6ck9MidmnWYmLvA/ugE4o7fNaG
         nlVGvvZbGmdiH+bA8GMltqCvol5uZ65I7zW1iu0Z8NTuRFUE1Io8E/St3P9q9pMFcfgb
         O9hB95JqNugeXl4/0lt0tsGn7VvDkYI1M8UsQ/OUELySkhmXsrdqpNd7AC01A4VQBopm
         j7mA==
X-Gm-Message-State: AOAM531UMazx5+BsZZLX0XKj3idlGdH2j4WsUArAca5CI9nTAByM+5Q2
        KMRmgE3fx9EGpOSv9pETMHIkMDoYnoA=
X-Google-Smtp-Source: ABdhPJyhjGaOuqkyM7/BH1v/J+tMrqriDO+Iz2E6ujnR7I+gNmfuzPpBH0rWYDIveS8291DL+cJ9sg==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr158416wmd.41.1610049696587;
        Thu, 07 Jan 2021 12:01:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t188sm8812140wmf.9.2021.01.07.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:01:36 -0800 (PST)
Message-Id: <f6efa4350d621cd955965e13329f15f4d1b91bb4.1610049687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.git.1610049687.gitgitgadget@gmail.com>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 20:01:17 +0000
Subject: [PATCH 08/18] merge-ort: implement handle_directory_level_conflicts()
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

This is modelled on the version of handle_directory_level_conflicts()
from merge-recursive.c, but is massively simplified due to the following
factors:
  * strmap API provides simplifications over using direct hashamp
  * we have a dirs_removed field in struct rename_info that we have an
    easy way to populate from collect_merge_info(); this was already
    used in compute_rename_counts() and thus we do not need to check
    for condition #2.
  * The removal of condition #2 by handling it earlier in the code also
    obviates the need to check for condition #3 -- if both sides renamed
    a directory, meaning that the directory no longer exists on either
    side, then neither side could have added any new files to that
    directory, and thus there are no files whose locations we need to
    move due to such a directory rename.

In fact, the same logic that makes condition #3 irrelevant means
condition #1 is also irrelevant so we could drop this function.
However, it is cheap to check if both sides rename the same directory,
and doing so can save future computation.  So, simply remove any
directories that both sides renamed from the list of directory renames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index a8fcc026031..feeb838231a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -941,7 +941,23 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 
 static void handle_directory_level_conflicts(struct merge_options *opt)
 {
-	die("Not yet implemented!");
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	struct string_list duplicated = STRING_LIST_INIT_NODUP;
+	struct strmap *side1_dir_renames = &opt->priv->renames.dir_renames[1];
+	struct strmap *side2_dir_renames = &opt->priv->renames.dir_renames[2];
+	int i;
+
+	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
+		if (strmap_contains(side2_dir_renames, entry->key))
+			string_list_append(&duplicated, entry->key);
+	}
+
+	for (i=0; i<duplicated.nr; ++i) {
+		strmap_remove(side1_dir_renames, duplicated.items[i].string, 0);
+		strmap_remove(side2_dir_renames, duplicated.items[i].string, 0);
+	}
+	string_list_clear(&duplicated, 0);
 }
 
 /*** Function Grouping: functions related to regular rename detection ***/
-- 
gitgitgadget

