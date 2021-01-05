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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C73C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8C122838
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 04:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbhAEEoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 23:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbhAEEoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 23:44:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50B8C0617A4
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:43:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i9so34887030wrc.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 20:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gKsL1Z5Y55+Y1PL5GuxJoS7EBIhj0OmqHFfz9/ukPzQ=;
        b=mmJKaDY07livWdrY/kQPxy4g4jj9fjc6G7VoG0e23bQv8h1VIBaR4ju9n9o+ITiBdH
         i8S2MJfIzpnV2MrGiwfwv1xDDxztzDzxBUQ9GbzJMr28nKsiURywC56H4oyrAZd2qJc3
         4zvNA2d8gGaSVDy4tu9q9fXx/d9gApieknlfv54KBLwTLP3Ps6NgzjA/aDLx2qACXq38
         o0JNGUdrrFy/CEpGOUVQXAndxYDYHhENeJigsa8zVDKB05WB7pndZdGsu/nJPaG7HB81
         pcvIQCvHPPO68+S6ijDEKpE3NRmM/oFKcBxqqcOltwDdEOehXxlDyxgkT3cEzJ/OacFl
         9Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gKsL1Z5Y55+Y1PL5GuxJoS7EBIhj0OmqHFfz9/ukPzQ=;
        b=umxqbHHE3tK1y002N9vDuHu7Jy/WT9UQcb89dXTqHSjfjpfIgW27B0y1bdfYkLuTRb
         sALz01ryzAoik5Ct0o+//d97TSAnQme8Du9WVhHV9kpdAXc/O5ah7pXUzl7pbMi9enPt
         W3Ntw5VlbAlbY5O1MS0/eG7zaTL6roE8LKdfETcsOH0MwGONkcEZE6FndBXbNYwXMJPe
         IOVIQVq+xJvNBankb7T0QaooycO/F9HZQwfRNnNf0ehhkZgzlt0h1L2tkSKMjBpZfoFY
         ufdXJvQNXdUWR/umbyDMi+dE1qUYBZhBQ6fahHYhKpo/co2r1tfGwP/Gky0Ms+dbjcGC
         Bosg==
X-Gm-Message-State: AOAM5316GZaEMBb/cPgqNerkxSk+NdP8ropV2/53dQUDNobZ14DRBtPz
        JifJltlipkKG8pBuUIoF7zKtgxG9yvk=
X-Google-Smtp-Source: ABdhPJw8pEv1LI7t15FZCnFUbm6BMiXRve/9jZ8CTqEgeBDz0cpfA5Pn0PsZpMyNv6TvZrVZbHwQnA==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr81484684wrr.69.1609821794482;
        Mon, 04 Jan 2021 20:43:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t188sm2101167wmf.9.2021.01.04.20.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 20:43:13 -0800 (PST)
Message-Id: <f1cffe2b4552378b79c501d52dc67711d8d1e21c.1609821783.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <pull.830.v2.git.1609821783.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jan 2021 04:43:00 +0000
Subject: [PATCH v2 11/14] update-index: remove ce_match_stat(), all macros
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
index dd8e0acc52e..8fc680090be 100644
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

