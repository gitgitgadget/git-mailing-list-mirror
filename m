Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CACC56201
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A332083B
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 00:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuJiC3nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbgKFAZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 19:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732854AbgKFAZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 19:25:09 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE6C0613D2
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 16:25:08 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id v5so3272595wmh.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 16:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=egrP2YxGIqUqE7lI0Iu1Sp/CnRg8F1CK39E/Ny45G70=;
        b=PuJiC3nwFGGkdnYhE0qqe1gdYhon0Jcc6K5vXWxQuo539dap7QFVH5MR23tis3Vczp
         XYVfib87B+kRS2KA0VlJC/mlZhttcUsZVDRSJ+P/Za4wyihL06zEEJdFMxT+A4UKmtMk
         Vk2D2W1WmwWIe8c/paybMjVFVqxDY5sgXtcgSo3wxGh8oryc8YzmL+Z9FYCRgIl23zen
         Ytx8cWFeqEztl4c4xdOdF0oa4kHaiw5B9aVUfMQSjaIo7EcAlI8VINcGDN8xxCo6FU6H
         RB3Z27Z+FfUNAi0FiUizAqWVVw3vo9pyTfmTygDx2UtcAn8bWL0/JwUbz9au3Wg83e59
         /Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=egrP2YxGIqUqE7lI0Iu1Sp/CnRg8F1CK39E/Ny45G70=;
        b=ds4nGN0xKDV/lTlJuitFEXOD/bqPexFTIEEvWRFYKH2rNfOhQbtOpJhtMPLp5MVWop
         ROJgNGkkiJEMqgcuYwi/63fLQnoViWXxIQkMsFaBvGTwm5JeqytIGoDlPVtOkPMw1D3m
         lokKIw5rs7ipilb6Fa6tAoQZFLm2zClgW+gOx2dS2J96f5FxUm5r/6QG+R/A0UQ/ujAV
         3v2RYwgVqKVe0CLULcI2VXnZRhEYlmD/+K5pn01En/BGifckHhIcNKNf/DwEbRiu4tZL
         km93ZvIPkosyD2TKNs148OxQ1CTHxV06HHkq0qmsuWFgTLoGupTmtgatt/GHHRd+7d8F
         VWhg==
X-Gm-Message-State: AOAM5306xpqdmMQDHcnWvJbY/YUee4SUVEFnoQKp14aSJYScpiNgdv/v
        D2ZLmyMVx20ZDWYV6U8jDDCxNVzN2Lo=
X-Google-Smtp-Source: ABdhPJybXMT7XgG4yBZPr82pw+BEmpG093RRWYJRYwb7fLCIc2bx5vParXBPaOy4JodcL4QJ6bqPDw==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr5120627wmh.44.1604622306967;
        Thu, 05 Nov 2020 16:25:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm4889658wru.94.2020.11.05.16.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 16:25:06 -0800 (PST)
Message-Id: <fd96e9fc8df23851022edf3799012441cd4c8728.1604622299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
References: <pull.835.v4.git.git.1604535765.gitgitgadget@gmail.com>
        <pull.835.v5.git.git.1604622298.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Nov 2020 00:24:51 +0000
Subject: [PATCH v5 08/15] strmap: enable faster clearing and reusing of
 strmaps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When strmaps are used heavily, such as is done by my new merge-ort
algorithm, and strmaps need to be cleared but then re-used (because of
e.g. picking multiple commits to cherry-pick, or due to a recursive
merge having several different merges while recursing), free-ing and
reallocating map->table repeatedly can add up in time, especially since
it will likely be reallocated to a much smaller size but the previous
merge provides a good guide to the right size to use for the next merge.

Introduce strmap_partial_clear() to take advantage of this type of
situation; it will act similar to strmap_clear() except that
map->table's entries are zeroed instead of map->table being free'd.
Making use of this function reduced the cost of
clear_or_reinit_internal_opts() by about 20% in mert-ort, and dropped
the overall runtime of my rebase testcase by just under 2%.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strmap.c | 6 ++++++
 strmap.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/strmap.c b/strmap.c
index 829f1bc095..c410c5241a 100644
--- a/strmap.c
+++ b/strmap.c
@@ -64,6 +64,12 @@ void strmap_clear(struct strmap *map, int free_values)
 	hashmap_clear(&map->map);
 }
 
+void strmap_partial_clear(struct strmap *map, int free_values)
+{
+	strmap_free_entries_(map, free_values);
+	hashmap_partial_clear(&map->map);
+}
+
 void *strmap_put(struct strmap *map, const char *str, void *data)
 {
 	struct strmap_entry *entry = find_strmap_entry(map, str);
diff --git a/strmap.h b/strmap.h
index f74bc582e4..c14fcee148 100644
--- a/strmap.h
+++ b/strmap.h
@@ -42,6 +42,12 @@ void strmap_init_with_options(struct strmap *map,
  */
 void strmap_clear(struct strmap *map, int free_values);
 
+/*
+ * Similar to strmap_clear() but leaves map->map->table allocated and
+ * pre-sized so that subsequent uses won't need as many rehashings.
+ */
+void strmap_partial_clear(struct strmap *map, int free_values);
+
 /*
  * Insert "str" into the map, pointing to "data".
  *
-- 
gitgitgadget

