Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36747C432BE
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5666109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbhHMIX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238598AbhHMIXr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9208C0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4so6336405wms.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=mvK+HeAjgr1n8XD6NpALfu+NoZmsas8y4ToSjk5Cif8Y/eJiocBVcHxxIcdIUh/L6i
         6XceF3ygfEr9GxYnguh52ISBhHrFHuQ1XYJy4BeLegBYfX4G1Y/jNz9qGXJz+6h7jnyf
         zy4hMrgzJgqro6bAoLWiiV16UYkzpaGqGylQgAT4r3Kp1iWPMVUKS0aONqfAjgCRf3xr
         Hb3A2Q+Yz4Pnu62pVm+qst1UCdnic7sIm15qbvBTVElpMaNOiO1LIaePs9hscH7wE5eq
         fl77dtEY0d7WtkGIvNYE8JwaFwBJvk0YrprqrHoY2FMSHmiq479ZdyPBot8/ZziC8RBR
         lxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=TnFH4IiULXRgPykYApD2SOwXJ3q12x2Bs5lHBkh/ZLMU3mRRYLR2zIi4GMA0qx4la4
         0Uc11CcUjFnEAdJGsW/h1Dgx/JR3iaJV+pLg+dkkc/AIfM3IMoyJFPXBeSbCIArNR8Y+
         SKZOZb6dc2GtztHiwYCCowKCcKdzEE+3Obcalvo1KBzIQeOesfYAyk9QwHrEtTNVPV2B
         v8bxaepX2TJgd9HnBqPPVFU94JnXzEbzNs8QR0tpHR8sJJ+kw9HBYTYEUbCmGaeLK3p9
         o1NlfGTkCJcdqTzHbd6Pc6NeW9DQL7ILf/UGkx+jzOQPHMTvZAy9THMs62Xtge0AFdf5
         /8ow==
X-Gm-Message-State: AOAM533mHE68lxrvFF+wi/QEE+ws1nY13EHdFx8iaW0cISMnMy6fNzM1
        luQF2UWieC2yg/5+rFAQ993pSdpd7II=
X-Google-Smtp-Source: ABdhPJw2b+dbu6DAc5JVy1PaKqW8CxhuveBfHYU4I7fGXdxQ60pD5sSA8nMt9bkv1Kld99QmVpIQjw==
X-Received: by 2002:a05:600c:198e:: with SMTP id t14mr1381423wmq.167.1628842999421;
        Fri, 13 Aug 2021 01:23:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm928696wrq.81.2021.08.13.01.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:19 -0700 (PDT)
Message-Id: <1f72eb6e4e0f0e5eaeef2b45deebc81f2b611357.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:55 +0000
Subject: [PATCH 12/27] [GSOC] cat-file: create p1006-cat-file.sh
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
        Philip Oakley <philipoakley@iee.email>,
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

