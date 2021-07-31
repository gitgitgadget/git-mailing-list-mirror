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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03713C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA26961050
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 17:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhGaR1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 13:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhGaR1v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 13:27:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F734C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso9482211wms.1
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4W9WNGrc3ipNQPgdDdR8WMqa8vuANw1l/AK9OiUX2hw=;
        b=E+x2eig+Q4QHyQw33euTietB2TUouaN3oZNeHIuZ3C44nO6Dr+W5LOG2Tt+zQ2D9Ke
         bZbTiv2fMYsTbtqJp/rMBLB7LR3A8kF6R3D24hnP+hGwvx+50Ie3mTrc7IIxKH26/BCM
         rPdY9jn2FwqSeao7/dxEKD/CsWS5SedKyIE3zpxQjCK8B0A1Qs3CG9Ppq63Awp1GWQA9
         YhBZINFCQVAWLScqKNLHOZXUOH5BHyv7hUPiBrwlLazBLhSmovuoadotpgRnXtQ4W0vo
         +zac5NxtQKEX5s6f1hFyS1FnvM0TBolXP5uj2oL8WOX5LknpdaGqQxzK6vvWUcP4ZsR4
         5F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4W9WNGrc3ipNQPgdDdR8WMqa8vuANw1l/AK9OiUX2hw=;
        b=gZPi14k7phQDX2E1bHu/Q/QqbJMMyvviiF9UF6naUvN4XiEPueQ6F8A65I2bxgw5ct
         9GSGX3zu3EI40Lr1fWMkSMedftn/yKTqaY02EnLY8LMKx8dd8MB60fAxzB6NAcN4+dWJ
         OS5HiEpdgWRBfCBNCVxC0I4kXVfLqNXZ4ah+44EQZBl3zANcdfDLVmMhOwGSWFsTB4JQ
         JL0Uu0vyMRRxB32+r1yb0VMXLa94ihe8E53tF+qJDaD7i5fDFUsfqOz0uIBhUKuJoXQ4
         3utdCc6B1QPJcyN4LnM1Dnim1lNG1Mq8U6MhibddZB9UYUxPbVfUiw5OLCTFA28qDKDp
         qSdA==
X-Gm-Message-State: AOAM532vR/A/sL8sCcga0Y4EyMnp3Te30ZYHC/iTSB/igNTl3zaw/tjH
        boOPiJOZ8tGWN0bYn1f/ftJM4fnOwzc=
X-Google-Smtp-Source: ABdhPJz1mAz5Fdu+35MZ/sIghEGi1U71x5qcYw6rM0AxqdfmYWtBt5nn0grZAQ2LZ74lHE2Gdbc6aQ==
X-Received: by 2002:a7b:c7d1:: with SMTP id z17mr8964591wmk.50.1627752462795;
        Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm5394983wmi.46.2021.07.31.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 10:27:42 -0700 (PDT)
Message-Id: <2c0b90eaba5bbf03553c8ac2487b57b66a6ed18e.1627752458.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
References: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
        <pull.990.v4.git.1627752458.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 31 Jul 2021 17:27:32 +0000
Subject: [PATCH v4 3/9] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make the code more flexible so that it can handle both being run with or
without a memory pool by adding utility functions which will either call
    xmalloc, xcalloc, xstrndup
or
    mem_pool_alloc, mem_pool_calloc, mem_pool_strndup
depending on whether we have a non-NULL memory pool.  A subsequent
commit will make use of these.

(We will actually be dropping these functions soon and just assuming we
always have a memory pool, but the flexibility was very useful during
development of merge-ort so I want to be able to restore it if needed.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 401a40247a3..63f67246d3d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -664,6 +664,30 @@ static void path_msg(struct merge_options *opt,
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

