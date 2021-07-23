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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084EC432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D686B60E53
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbhGWMOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbhGWMO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 08:14:28 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A6C061760
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q3so2332879wrx.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RkWq14phDR24WVAryA/mtV62kaF3BxfXwFWp/I+rD+0=;
        b=hmOZlTUf3zt0/QQJN+5cllqC9ooC+3L0FaktQvCFXMlcxl64Zgtaao5Ph9wgjDtwPr
         ki08xZ/AmltFIVzLy+Sj/eztJmkg3OIRvcQh8L4vVTkESe5/EhJMIJnmUNo1Wy3gP8G1
         YQNxpUMPeCVOR/Wi3kv/lLEYef0meJXS8WnA7O56k4p3KT/S7Hg9qz0wryANsuVBbC4m
         5VJFhiSGCxRzh4HZTp84lbKSWmOYDqvnjrcU4BkpUF32VbzfaLlSj3NTs8AvhCdnpwEt
         Ea/byGDp2gEx4/aDDCTIwbCojA6vV4VZjtPc3C/p+bW9bUDHSjMJYbC1xqjReIP67dsK
         PNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RkWq14phDR24WVAryA/mtV62kaF3BxfXwFWp/I+rD+0=;
        b=aSwZE/L1/DVdqdNGtYTMdPBGff1mmxEreUVbbn73IHoC9bTd5z/U3n/s1ztX20tiaW
         e/O3MusbuHR2Zt5pUZNDl8nT5qL4Xc9pzG/8xAkG1L3UJVMyl+8ACSH5k75BhQj+KFwD
         Xngl9OHS8tz7p2D2fulA/LxeSVF65B2PwvpILvopmL5JF3qcE0U1NDxNdtC3LUBhU4fE
         HrM//4Dx3m30eCpgCPg7XbpF5Fyn47wv9nsIAQJl6/KSkDQb9Dxog8MDCCo+x1ZRo7qe
         q2AR4oB9Ns1SkXLdcLeomgS3m1/Zbar2NZVxaGdNAy8yjWg3jCQ3qyD3uwjlWy5Dwuw9
         +nZA==
X-Gm-Message-State: AOAM532UeDc4K5ETv+VT294Dh49/BRJwQGuxnLzmaWUeEMESymw1vUoF
        6DHEMNOYdTvdnXf+Si7riY9uB8WSOB0=
X-Google-Smtp-Source: ABdhPJytRJZ2jW8+s2atXmfBZLrsy9Nznq9/ZUKJOBt9sBwyUvddlCtEWTovSay358coNs2i0TpBAA==
X-Received: by 2002:adf:c102:: with SMTP id r2mr5166504wre.22.1627044900796;
        Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm5263672wmi.33.2021.07.23.05.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:55:00 -0700 (PDT)
Message-Id: <e30b8c8fea110b2475d00a4b37eb62a4883999c4.1627044897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.git.1627044897.gitgitgadget@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:54:53 +0000
Subject: [PATCH 3/7] merge-ort: add pool_alloc, pool_calloc, and pool_strndup
 wrappers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We need functions which will either call
    xmalloc, xcalloc, xstrndup
or
    mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
depending on whether we have a non-NULL memory pool.  Add these
functions; the next commit will make use of these.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index cb33c76760f..2bca4b71f2a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -683,6 +683,30 @@ static void path_msg(struct merge_options *opt,
 	strbuf_addch(sb, '\n');
 }
 
+MAYBE_UNUSED
+static void *pool_calloc(struct mem_pool *pool, size_t count, size_t size)
+{
+	if (!pool)
+		return xcalloc(count, size);
+	return mem_pool_calloc(pool, count, size);
+}
+
+MAYBE_UNUSED
+static void *pool_alloc(struct mem_pool *pool, size_t size)
+{
+	if (!pool)
+		return xmalloc(size);
+	return mem_pool_alloc(pool, size);
+}
+
+MAYBE_UNUSED
+static void *pool_strndup(struct mem_pool *pool, const char *str, size_t len)
+{
+	if (!pool)
+		return xstrndup(str, len);
+	return mem_pool_strndup(pool, str, len);
+}
+
 /* add a string to a strbuf, but converting "/" to "_" */
 static void add_flattened_path(struct strbuf *out, const char *s)
 {
-- 
gitgitgadget

