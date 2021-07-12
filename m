Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86332C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 730C060C3F
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhGLLuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhGLLuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:50:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A19C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j34so11193909wms.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=ePZ922AJEWNWQyfkc3pf+bVIma+DxiTmINgCI/zWOTf4nEX8qTY1XpvBNVbqc4KjYO
         UprOhcUZdoSlfB4PMAFz5GB0d7XsMEQdwvDlNJEsPdLSGpZclHZ8ZS4TfAog7bmKfPUc
         pitZouTr0QKRkBcYGalzR54o7ZTbu9TQEP5RRM8BhhZ1BXImuGGhp0Vkj4axTigjOSAc
         +f6FB3FtT0Kb7DNJwWfsdqeErMmffiKM0CvnvRdDhRORBfFF7jBsguD0KB85EVnn7vQF
         cP5EvAfzGJjGL1nS0+Zx6gK3t/GAR2wgLI9y+ZefvL7FOSzR/BEXmdKa4GmAVHuRLxuQ
         pADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=b6H8EJAakQV1zWKtDVd0p1bC2h/7oUW2NrImP/XtA6TytirSsryo5rxV7iw4XJn5Ph
         GXRJEum80c3PUzNzPBSo9Os+i4JKLK6r3D3NuXySXx2cPqKSWFvx4AGvVuts8nP9tPSA
         ByVuSc4vEr38/ZiAQppPK7Nxo8jGCbs+MtcbTPjtzusWNefXD9pQCSK+D56gpK8qj2Xq
         gmLu16wznOR1X2NJkhs6qrGIp9n7xEoIQyzdf0Lh3RVpbYuy9gdV09IcW+8dZRzcmKQd
         P0qrNCLKG6p3TpWdqcRJxDH4GCKHqvTfSNFpO3EDY5RO5GM3NDI1DJxSDGsgPrA2keKn
         oO5w==
X-Gm-Message-State: AOAM531RH1ZPvxUFNc8+y7/ObLPD7NO4YuBf5BfIftu0gp63Ex4gGj/F
        w8Mn3PyR/vQ5TG4tKYICQUy3OvC+u+A=
X-Google-Smtp-Source: ABdhPJwfsvCvLVqO15yHC5HmDSqOoUKtORn0lfCf0XrtSLgVSi7+TpyDBaykKPfacOTicZn/18IIvA==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr7000913wmk.102.1626090431110;
        Mon, 12 Jul 2021 04:47:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm13678921wrw.19.2021.07.12.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:10 -0700 (PDT)
Message-Id: <2edca9dc46538d85bc32a206e71c3336e384df41.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:58 +0000
Subject: [PATCH 18/19] [GSOC] cat-file: create p1006-cat-file.sh
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Create p1006-cat-file.sh to provide performance testing for
`git cat-file --batch` and `git cat-file --batch-check`. This
will help us compare the performance changes after we let
cat-file reuse the ref-filter logic.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 t/perf/p1006-cat-file.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
new file mode 100755
index 00000000000..b84ac31f9cc
--- /dev/null
+++ b/t/perf/p1006-cat-file.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Basic sort performance tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git rev-list --all >rla
+'
+
+test_perf 'cat-file --batch-check' '
+	git cat-file --batch-check <rla
+'
+
+test_perf 'cat-file --batch-check with atoms' '
+	git cat-file --batch-check="%(objectname) %(objecttype)" <rla
+'
+
+test_perf 'cat-file --batch' '
+	git cat-file --batch <rla
+'
+
+test_perf 'cat-file --batch with atoms' '
+	git cat-file --batch="%(objectname) %(objecttype)" <rla
+'
+
+test_done
-- 
gitgitgadget

