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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6FC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C46261165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhDSLig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhDSLic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 07:38:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6423C061761
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j5so32694661wrn.4
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BDIhZ20eJ0CY/vOcsJRq514DGumDOc0pePjgXTqiigw=;
        b=sBgkh/lBBbpBwK50+JHEB4gpxGesDs0R+mw7ZrO0c/daG52W5fqkQaTdGNRaJpnYY1
         824pGtdXOeHqI9sXhZZ/6T6+4Mjl1hWhxMebVAXX6Y0VmekPa4bRJxbqQC+nva1+3MzU
         wCuBHeCfhdzI5iub9Ai7LqMnw16RD4fLcsiLyydrLaDiHQEgeZdKTGHNjY2RQEIUp6Ma
         Agvi5QXdt7v51mtZnn4QG2VDOeKSOQh9ICE6YlFe03RyeSzStL/8p5clIU7jCa+p76se
         b47NrIpB1lK4NHUtgavztNIQbTHfiORAGfuEc17v+DyNZQxOy7UUsx4WNFceu+yk2foG
         hlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BDIhZ20eJ0CY/vOcsJRq514DGumDOc0pePjgXTqiigw=;
        b=VGQKGQvjzFL7MeIf9kJXMGQE1p2BuEdovx3Sa8z4rVw3FPj1Xs1BcAnIRFhmkEKho2
         JwoG4RZaaaT3GiIJKqGH9msD4eM0n82bRrEVmTUQUOwsPbTkx2Dq9MW3czlDY7otd/AV
         UXB9lKLouHaYz5n3fcQiGcmact+bO4+OkRu0x7ue0vkDf/m+U9Mrjt1vKifIw2/nEIMh
         xBo8X9gU/CctQyCQV/a/jkkYu72KtKQzjrNz4UMod8uJg8Tr/+1I/E7k8atYjcVl9lOM
         +OThRs3Gnk5V12NNHKyg3m3sI60y4/G+lusb92BbrK3qEVFrlqA+CjwncoFtptO714F4
         ZAIA==
X-Gm-Message-State: AOAM530A4ZXQjnFDEMY1OnDf/qnvFInrzylwe2BggQqgmjpW7W2PWYaR
        fAG2Y3Obxs8zg8UPhZffTU/sSDsYJ0Y=
X-Google-Smtp-Source: ABdhPJxnFPLfJD11lXhwWmigIdPrjIXLoBN4uYiHsqW+yJL0ig/lEGcSIHKiToHRVQfh/EvZ0CTn3g==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr13860730wrq.418.1618832280559;
        Mon, 19 Apr 2021 04:38:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm19460492wrx.88.2021.04.19.04.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:38:00 -0700 (PDT)
Message-Id: <554bb1ac3aed066eb578a305b7fe76f1660f6153.1618832277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 11:37:30 +0000
Subject: [PATCH v7 02/28] refs: document reflog_expire_fn's flag argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys g <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 546a6b965dcc..a31c1f465beb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -592,6 +592,10 @@ typedef int reflog_exists_fn(struct ref_store *ref_store, const char *refname);
 typedef int create_reflog_fn(struct ref_store *ref_store, const char *refname,
 			     int force_create, struct strbuf *err);
 typedef int delete_reflog_fn(struct ref_store *ref_store, const char *refname);
+
+/*
+ * `flags` accepts a bitmask of `expire_reflog_flags`.
+ */
 typedef int reflog_expire_fn(struct ref_store *ref_store,
 			     const char *refname, const struct object_id *oid,
 			     unsigned int flags,
-- 
gitgitgadget

