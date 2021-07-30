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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD1C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CFA06052B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 11:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhG3Lr5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhG3Lry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 07:47:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372CC061765
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a192-20020a1c7fc90000b0290253b32e8796so7080565wmd.0
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4W9WNGrc3ipNQPgdDdR8WMqa8vuANw1l/AK9OiUX2hw=;
        b=vTa/5UoXfMij8+vu4zNPedivi9c+If6uMK4aIRIsrYd1XrWk1wwsoR5nyOkg24ZgcV
         bpH3+0QPE6xrqb/6uOb1phekN17EwXAsco7x5R1dwLtThm/uHUUN2v61PTqtCenVUEpF
         SyRQ8//tTvS4ZEN+J3wGZq66YF+W0+SttPLyFEl0ThbGiPb8oGEWKJvA5ELO5xOF4rmp
         GFdBUIftv0KRY0/8S8OB9R2HKq2qrz4Q3AbPKaeFe6D3fCY32xVxktXUgY3Nkn9VobFy
         XbjAbxdw8zG58IW1RIB4uYVHelWfzi6FDcVrGVRqiRBYTxxsDXiyhGgDvDh5NycAx9Jk
         g2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4W9WNGrc3ipNQPgdDdR8WMqa8vuANw1l/AK9OiUX2hw=;
        b=m9nG6FybbDwS+ffUxoWmNOyal76f+T1wfu4k3ERzHO2LAcwYB5rGCsesdYxVxWsUeO
         Sx78MIHcmnr+sxdcWz1CfaTkHVyGLPpf9rfZItsPvF/UPS2IPLgPwPdMjvSoRfC/su6D
         j1nyxwedicecflbXfvo3qiKvV3j4UB5gSmir16ImSysjctcUSPKSRdOf36uflVKMvkuT
         /fyrgtFdMHfY/WanhGtzbsLDcAJhoTkrR7O3oYEUfvZ4W7BzAUY3h+2b6pgEjKwvHQo3
         Y3OIuPWcOvT3BHo+UhprL/yQg8s2QLkgf1OjdZMwU5O1ycYNf4iIRABcLprO3pEoUHcD
         aWFQ==
X-Gm-Message-State: AOAM531EmJvDiJdTfCjCgM0FjFmdRXqHaPDa9fBcxNwOo5mW8+9zwsRL
        /RnSdow4hknoYNfrh9mo29Ks0NuRQr0=
X-Google-Smtp-Source: ABdhPJxkkEJUOCcLPYza8u9QcpYWF9YOpVb/pybV2Jy9hN7yt0ABthkUyASMRVafZ2RdsJdXl4AoLQ==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr2466043wme.76.1627645668670;
        Fri, 30 Jul 2021 04:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm1584217wri.39.2021.07.30.04.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 04:47:48 -0700 (PDT)
Message-Id: <2c0b90eaba5bbf03553c8ac2487b57b66a6ed18e.1627645664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
References: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
        <pull.990.v3.git.1627645664.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Jul 2021 11:47:38 +0000
Subject: [PATCH v3 3/9] merge-ort: add pool_alloc, pool_calloc, and
 pool_strndup wrappers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

