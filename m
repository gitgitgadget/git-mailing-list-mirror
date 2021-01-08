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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3221C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C9023A80
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbhAHUEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbhAHUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE7C0612A7
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:03:10 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t30so10157011wrb.0
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tfHl/JvvFkcclxfk74hs+6J1R6G8s7cxlIqUHRLIFj4=;
        b=CyAPkxP061z2CASw6dZSCp+vGIZzPUOmXCBs8Ki11k4Sz8u/1QVSJXbrX85mOioU08
         c2bKThFPx/2R3g7gGwrSy5giqgfyzv0Wgpqlj5u5ARvMFYmNf/VLWXK2UBcceXp5Hn0W
         5zjcoXyftSSMi/z5HVWX6eTujDvkGbXsg/FqUJNGqywo2woFulmjW76FsN/RuCZk82zw
         RDybD+RYcBin3gw+XLRz1sSNDosQzUrPw50tr9KOO7Pj0eDLPVhoS4eEMx9e5zXHNHMl
         uRel25GqJc76iGFX9z68WKeEwsg9JPyGxVeU52ea4nLRxCHeuQLmZEezJt13qlyukHfQ
         2JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tfHl/JvvFkcclxfk74hs+6J1R6G8s7cxlIqUHRLIFj4=;
        b=Ff9fZYOixsmIM6ScpwyIVMCn7c9/0W+iabYVjvZyWMgaQXXJeqLbMrwR7/H0lH/L1v
         0szqROPJ80AyI1fAYzqwvbRXmqAhvi5RsM/oGb7Ieu9CyjO58TU1qHAJLwUGWN40QzFj
         fTP/dR1fBTHYBb8ycJkMNSL/xQstye9vbaHsEv5p/fdDQ2Q017NCCB3TbGT2HGWWmoET
         bkeT/aXHN0b2nm6SHzXN8u3BSoONwNDJBiSpKXl+Fozp8SiVsMVRfSdEVI4/EWp1J0Nm
         vF2j8LsZeGi++hqlODcqwr9TY3V/S4F35hhzU6AaQcHfj/Pb16oNyZVxsjYtTu89mQDa
         TJCQ==
X-Gm-Message-State: AOAM530KnYDLihmvWT2AiMbUwCVOtn8jYMDRfvWR7CplUt2FrAw++jYH
        x/o4M+wr6bKaBnrDe+Jw9BL8mynau3E=
X-Google-Smtp-Source: ABdhPJwtnlqsc+lLWTOc9Glg0cPE/hcuujvb+IhMIVpwE6gTWJWI0LnJnrCaWWX6PVw6c5OZ6co6UA==
X-Received: by 2002:adf:aad3:: with SMTP id i19mr5119101wrc.119.1610136189411;
        Fri, 08 Jan 2021 12:03:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm14492677wrj.8.2021.01.08.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:03:08 -0800 (PST)
Message-Id: <e9d4fa613a65e0fedde0648b5fbf71e16f8fe8a0.1610136177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
References: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
        <pull.830.v3.git.1610136177.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 08 Jan 2021 20:02:54 +0000
Subject: [PATCH v3 11/14] update-index: remove ce_match_stat(), all macros
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The final index compatibility macro to remove from the update-index
builtin is ce_match_stat(). Further, this is the last use of that macro
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
index 64feb47c97f..1c1cb8f8d4a 100644
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
@@ -276,7 +275,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	struct cache_entry *ce;
 
 	/* Was the old index entry already up-to-date? */
-	if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
+	if (old && !ce_stage(old) && !ie_match_stat(istate, old, st, 0))
 		return 0;
 
 	ce = make_empty_cache_entry(istate, len);
diff --git a/cache.h b/cache.h
index 8c091be6256..740bd0aa1dd 100644
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

