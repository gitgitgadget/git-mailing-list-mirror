Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58720C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C1221741
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBw+UTHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407564AbgJTNlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407508AbgJTNlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:41:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D33C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so2179847wrm.13
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=bBw+UTHyXojcFqFfUGsruHklH/d3LWkW4xUmpVXjJYNfk0XTCdqwQH5iMbYgo6fO5k
         MjVkI0jN8QPmrNzw/q7AiBYzRNkSB6TjZ0qeZNqlLec4/g8xJP/9VDXma4+slELKeEbs
         /MMxjVPDu8KdR28aqGRBBVqvqE2XmD45V7UNDp4qdKjHyXu9XDQ2nJ1LMwB+yGd4BiMJ
         HCuRv4qAgUYbJieMkGrRXLgnKGtr2dF2RVCPtMmO3arcLqygN2kk0e9GCmGZqMbuGAdz
         qipWFJafhgY7fRMPS7yjFEV1nyqTrOAGLRpOjC2iJQV42ZzIboFwePM7xt4geBH7a6fz
         Q/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YDGjg72DiBHMJo7ao0V16mKGbZgzL/e6IJE1LLIK85I=;
        b=OmIoA1uz+1e331f1IQ0Y9seOxdsNc80DJiyFess+qNfMv9ZiZoigmtKRNae3syGSzM
         Wt+694g72Qn7xLckh72Ufcf5veC3aKkWYduE8Nk8b8Vwz0PnabdtJ2kDoL/eN1O2GH4C
         C6IlskLXIGxJYP0gwmR6Mh8xZn4zggpgT/HAUzjOm8f8x7clXLtABG7INoBH1WCUzWxK
         6tERQpTb7ZyFoLU1vbm0JKDMi0hMXrCiHc/MXmDv30zxrdpfsn8Xnvacz78RyfvYctEg
         BAfqHKjs7ETIhMCiAGhHiUPrUT9a8BrtgDBPn7FDiNPKftJ7NE2QgMB9eHSNXn/gOvIf
         Bwlw==
X-Gm-Message-State: AOAM531ZMdY6fRou9r5btZlF1F90iwk8V6j48QEHGiVbm/cmXbPFeJ/Z
        1NjuODb0Jjz53WPYvzzDbAlKkRmUD34=
X-Google-Smtp-Source: ABdhPJyqFPcijN+RX/Cs35CZFW7ljqftgm+8dtVxi3edD8rF8RERzh8+Jt/gISHYKN5+2WnbHDlk9Q==
X-Received: by 2002:adf:e643:: with SMTP id b3mr3606539wrn.408.1603201268093;
        Tue, 20 Oct 2020 06:41:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm3342813wre.30.2020.10.20.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 06:41:07 -0700 (PDT)
Message-Id: <1c7876166f5d9262c44c9df0f613e7d0beb98722.1603201264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
        <pull.756.v4.git.1603201264.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Oct 2020 13:40:59 +0000
Subject: [PATCH v4 2/7] t/perf/README: elaborate on output format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/perf/README b/t/perf/README
index bd649afa97..fb9127a66f 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -28,6 +28,8 @@ the tests on the current git repository.
     7810.3: grep --cached, cheap regex       3.07(3.02+0.25)
     7810.4: grep --cached, expensive regex   9.39(30.57+0.24)
 
+Output format is in seconds "Elapsed(User + System)"
+
 You can compare multiple repositories and even git revisions with the
 'run' script:
 
-- 
gitgitgadget

