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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB353C43331
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970D322210
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhAANIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbhAANIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 08:08:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E8C0617A0
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 05:07:21 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q18so22009624wrn.1
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 05:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tfFlqYDYIPEygmGKvGhRH28V9rbc3TaFh6cEhIiC+bY=;
        b=AKvSkq2VKHjbunWG9y2sS2V2U8rtHHXm6UR8TUNSqTOFwHW8Ml5OeUuw5nxaqEfRs6
         Bw8jmvB+OicqC90jMN5ZUfOptcCqJ8IcyxaqsUu3Q40i61XJcKvOSoItOqQrU7fX8nSP
         0cjDcXhRIpzg+wxdhUW5bCPhlM1lOQgf+lV4XeAVJBE4MrZBBv75TKqwueo9sRYuN7uc
         upnkHo6k/paIVC9myP4ilEStx5LBg0fysO8vU0Lu3rLAKLQb2snlaJBg3jjEDkCdHGMq
         ADJom0u3MlIyVDTT6WrjKrgTjX38A5wI6MlBK63Y4hnDqJsAzebyswOwreFCbGUfrcXx
         SKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tfFlqYDYIPEygmGKvGhRH28V9rbc3TaFh6cEhIiC+bY=;
        b=Vc1Un1nAXbWD6bavFWSg+8TBa+W4T9K1bGHgN5h4O1tyNyN65TfDaVzf+eY5gdJ2mK
         KAT3EUhmSk1rRfMtLletIZJ/trWEZwEmiFL9UBkajsrVLlqb8+TZSG2Z0J9IOyXm6HzD
         PbzUgGceKuqvJDJ9zZpdSYkN5wf9WygFoRb/TAa4V4/e9bqy0HVsn3gs6UObS4ivjHj0
         X/Ox3rwk9g9SZ+UNU1EuMLwnP+2EKBwuAQ9DCltX2hsMARRPPTlsKG/m483+6+DADOdk
         Bl6QDQsMf1UlatcA6AKeuHwtacwAZXQaCchM0YJtuLEKmntE5eIpdL0p1gHMqfqUxM7+
         XIqQ==
X-Gm-Message-State: AOAM530Dgin+PgEuBXSBXQjlcrKYOP2Ux8T/34ScJEOD5/0nfmKLVvly
        mLFWDxTZKy3MHI9FN9MqDMWNSdLBpr8=
X-Google-Smtp-Source: ABdhPJzgozJHhLxe8XPjiLKSXxoUryYF8YMu0wcgQSjn+C8x3yevdnBnGnEGkCvhq2iGrcLKarYi8A==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr69173310wrs.58.1609506440007;
        Fri, 01 Jan 2021 05:07:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 125sm16717775wmc.27.2021.01.01.05.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 05:07:19 -0800 (PST)
Message-Id: <8fb307c3bee9a33ad408bba6c422e992fb1e2656.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.1609506428.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 13:07:08 +0000
Subject: [PATCH 12/12] update-index: remove ce_match_stat(), all macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The final index compatibility macro to remove from the update-index
builtin is ce_match_state(). Further, this is the last use of that macro
anywhere, so it should be removed.

There are some remaining references in the racy-git.txt technical
document that are updated to ie_match_stat().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/racy-git.txt | 6 +++---
 builtin/update-index.c               | 3 +--
 cache.h                              | 1 -
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index ceda4bbfda4..65188e04559 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -26,7 +26,7 @@ information obtained from the filesystem via `lstat(2)` system
 call when they were last updated.  When checking if they differ,
 Git first runs `lstat(2)` on the files and compares the result
 with this information (this is what was originally done by the
-`ce_match_stat()` function, but the current code does it in
+`ie_match_stat()` function, but the current code does it in
 `ce_match_stat_basic()` function).  If some of these "cached
 stat information" fields do not match, Git can tell that the
 files are modified without even looking at their contents.
@@ -102,7 +102,7 @@ timestamp as the index file itself.
 
 The callers that want to check if an index entry matches the
 corresponding file in the working tree continue to call
-`ce_match_stat()`, but with this change, `ce_match_stat()` uses
+`ie_match_stat()`, but with this change, `ie_match_stat()` uses
 `ce_modified_check_fs()` to see if racily clean ones are
 actually clean after comparing the cached stat information using
 `ce_match_stat_basic()`.
@@ -128,7 +128,7 @@ Runtime penalty
 ---------------
 
 The runtime penalty of falling back to `ce_modified_check_fs()`
-from `ce_match_stat()` can be very expensive when there are many
+from `ie_match_stat()` can be very expensive when there are many
 racily clean entries.  An obvious way to artificially create
 this situation is to give the same timestamp to all the files in
 the working tree in a large project, run `git update-index` on
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4da0c169dc7..256df43ecbd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define USE_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "config.h"
 #include "lockfile.h"
@@ -277,7 +276,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	struct cache_entry *ce;
 
 	/* Was the old index entry already up-to-date? */
-	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
+	if (old && !ce_stage(old) && !ie_match_stat(istate, old, st, 0))
 		return 0;
 
 	ce = make_empty_cache_entry(istate, len);
diff --git a/cache.h b/cache.h
index dfcbc4923e2..2925bf050b8 100644
--- a/cache.h
+++ b/cache.h
@@ -416,7 +416,6 @@ extern struct index_state the_index;
 #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
 #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
 #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
-#define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
 #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
 #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
 #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))
-- 
gitgitgadget
