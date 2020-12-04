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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3512C4167B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE96322CF8
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgLDUtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbgLDUti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:49:38 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E36C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:48:24 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so8172822wmb.5
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hll+1QbjL01rZ2JGt6n4wIIvpciV503XWM1AnIHMyy0=;
        b=iYz/oqI5qcmn7U2nvHhxOrEx9PRhMz9NQJGGu0jkLgWVFBpTOyDtwEm4JdtMD7+wZR
         ZAAFn/c0vcRwvm4z1IRAhqmVIARl0yRoc4LrEs1cdO8yiFN6i7GQxZaAGyiz5Ys632XQ
         7mW82CV8xq21q5w5piC4Gz7etd7VGG3Qlp5US3S1+JWtBMv1E8f1176zSmmd2V7iaTxg
         3E02C8am7WexugGcVi0Ogs95IXJkGxgzzQPljKO4NjZP5VJ++A0CygyvalULCh6S+NTO
         U9aPA1hBMtGyQp2xbvwyKjpw8agIudpkqg1fupskKG22429yXqJksFLieF3gnYhrDq54
         Bswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hll+1QbjL01rZ2JGt6n4wIIvpciV503XWM1AnIHMyy0=;
        b=lw5jDBmTLLvBd+DjAxVVdkdy0q6XX0JpPVLDCerdTW94btMNhgBsldYTJwZR6J9YRg
         e5PfIakLbbIgy/9HX6feSS29Vm0zXcS3vQszXS671+YPGz6T7SmMWWqc5stJsC5lDUsR
         s/kiez4AJ3cM7zmB1wMSE1+m8TWD2hYzDMOboJ/eUknS2AydK8PcmYAWvbzMe0+GB7Hu
         kfPEtFU2cWpOXHHOU2I4GMSZNlSnqG+A4D5zMMdmTR5JqQrzF+fQVY2ldutZnB+DHN+v
         NQE+mJMDJHNQmZxXyKksxsMomSGfBh7fTN/CBy3cCY/byKiXxOz2Sjip1k08BL+U9Esh
         0XHQ==
X-Gm-Message-State: AOAM533OlbAW8d479DEQmpQ8vOhvdUxk5NNGmE9ijTylG14RLehQVa7B
        nBJeOACWlXMeNDxCoVO3S2UyMQRu/N0=
X-Google-Smtp-Source: ABdhPJxZ2SUBSqElPLHkp+n5CUY1qTaU4to1B8yKlyUPJ3wvkyvraPCGJ7zM0mE0yR8W/GuHhkeqCw==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr6224553wml.50.1607114903442;
        Fri, 04 Dec 2020 12:48:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm4767253wrr.2.2020.12.04.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:48:22 -0800 (PST)
Message-Id: <86c661fe1eebf692b5b6cbb6379d12303f16cde0.1607114891.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
References: <pull.923.git.git.1606635803.gitgitgadget@gmail.com>
        <pull.923.v2.git.git.1607114890.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Dec 2020 20:48:00 +0000
Subject: [PATCH v2 10/20] merge-ort: avoid recursing into identical trees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When all three trees have the same oid, there is no need to recurse into
these trees to find that all files within them happen to match.  We can
just record any one of the trees as the resolution of merging that
particular path.

Immediately resolving trees for other types of trivial tree merges (such
as one side matches the merge base, or the two sides match each other)
would prevent us from detecting renames for some paths, and thus prevent
us from doing three-way content merges for those paths whose renames we
did not detect.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 007c6fc067..2dd52ab426 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -340,6 +340,19 @@ static int collect_merge_info_callback(int n,
 	fullpath = xmalloc(len + 1);
 	make_traverse_path(fullpath, len + 1, info, p->path, p->pathlen);
 
+	/*
+	 * If mbase, side1, and side2 all match, we can resolve early.  Even
+	 * if these are trees, there will be no renames or anything
+	 * underneath.
+	 */
+	if (side1_matches_mbase && side2_matches_mbase) {
+		/* mbase, side1, & side2 all match; use mbase as resolution */
+		setup_path_info(opt, &pi, dirname, info->pathlen, fullpath,
+				names, names+0, mbase_null, 0,
+				filemask, dirmask, 1);
+		return mask;
+	}
+
 	/*
 	 * Record information about the path so we can resolve later in
 	 * process_entries.
-- 
gitgitgadget

