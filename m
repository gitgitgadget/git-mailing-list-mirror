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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D18C2BA1E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CD764FAE
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhCPVSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhCPVRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499CC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so163938wmj.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nVR9QIt3G8SqS33LGo7OBuLf5EVGbwLAPJdPR9tVwV4=;
        b=ez4xsoMuLJL9keWqUztvzQK9hyRvnUyKG5RmzIZFleQC+NgrLLWuNv+NPk35nF8dtj
         CspHjznwSq9+SMwKNWYbnek2fWYN+j2BQ8uMEecEkAPa0yaTVvzM+iFR9v+UwP2O/QWx
         fMIfWrkWAKlc3YAm4yAZIrWdrktS3wRUI1NWgDIn/ZUBC/ki5kE5YYFg7Hxz3mJrmICF
         XtrsS3hNL5G0W3VAY2PL6JCI7Vm5AmXpa/mBZUeY8UxBM46UhmRVvSvLve5dEZgoJh+N
         Wa2V3NENHugLHm7c5pDXFmTiGD7ZY5pj79NhsBW9G9l72+GdMTsZ3h0sGLybaiKXOXWg
         PfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nVR9QIt3G8SqS33LGo7OBuLf5EVGbwLAPJdPR9tVwV4=;
        b=AnG0JFLRIMMQXsDYCAUcLD0u6wH7YiY8x2dabyHTD1JVVaPr/7x0uHa315pVHwcxAq
         pUkXCjRsv3q5h/vwRlT1WLjZ4Dk19LlxiEWjYYEhdCC26bKBNCUEkLOLk0j88Ldl0563
         KsParr1JpWeWybrKMnsPC7oxt931G6+Awdn+PcZlKHybLbRzF9sUt/zDR8Yb8xxmC2kB
         WnfDgbLivGEoGakaeHGFVo8kXhYovct0bPOm5jzKAvVf6RAHBHl7wpB0T81OcfIcwIuN
         DMPO0EMX4Q2hyR5kAIcWEQpx/QTeIiQoS8rrXHiF2Grq4dSYsKorFWESdQ3YOjyRE5/l
         H8Tw==
X-Gm-Message-State: AOAM530cQYa2m2f298uebxgHfOAYTbBnUfYNzdIRpJGyOol/gVv1Yu1i
        m1lk5lllkBErAO511byX045mCYzImYg=
X-Google-Smtp-Source: ABdhPJwu/7h7iSC3PXswmc9+MH6GHcPX+MSoVcPp2cFLnrH2AVuAlyxswgx6YG3ATdR9edhZAh0ppQ==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr653379wmg.81.1615929448635;
        Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm476894wmd.21.2021.03.16.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:28 -0700 (PDT)
Message-Id: <45bbed6150a2a9f9e9446edc9a613f027da73957.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:05 +0000
Subject: [PATCH 17/27] diff-lib: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 diff-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff-lib.c b/diff-lib.c
index b73cc1859a49..41d6fcec1a81 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -102,6 +102,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
+
 	entries = istate->cache_nr;
 	for (i = 0; i < entries; i++) {
 		unsigned int oldmode, newmode;
-- 
gitgitgadget

