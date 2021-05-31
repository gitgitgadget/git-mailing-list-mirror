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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6BC47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F82061108
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhEaRmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhEaRk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629E4C008753
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so331173wmc.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=uL61cA1LUyFw1EOOjylTHhglnmWmN3p8G2BJCEYz3cc=;
        b=tru5jFGIueIN6ruymLy5qHD0bgfmPlJqqVm9Zzx+dL/kjSir3YPwtfsu15Gn6s9AiQ
         frdkV9j/WrLNs6JxtWwYye8sg2fIH8Cv+aM3mR+fByQwt0ILCuHf5FvqdAtDzOhOleIl
         5YNZlGhu6xSQwvVF9kF4Qc+V8xI5HChwGTNTaTjMy/+4wP9igpefe+tCYrBWjPbrGDLG
         BqBde8XC6ovM+w+N6P3agv6p3Z4FvpIyb5K7H3W1YXjPxk2l2wG7ZEMHL7IuT3T7X4iY
         UsTMeUgqUVLuJP+uNLiCgG12TwYgc15YNMEFXlMd0KnFOVM2vfYocZohsIlrAY5t59MQ
         FmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=uL61cA1LUyFw1EOOjylTHhglnmWmN3p8G2BJCEYz3cc=;
        b=SawohEgeeMH2pofLwEv1ksYn7ki4Fg3olSuAiRGpP6HHPMB3gFlQpEwEZRbZtkbflD
         ZpxYQ/4Ul8dCtbCLhEi9oraU+4yIwOY7rR36c3eIr5C969y2FUHK1y22gjHm2rnM2b2s
         ndD/m17vV2XJbxgYnC/5cPQ/Zxi+f3v+XXV31D+aIQ59RdPHGyttlsVTOnU8WXVJrwmG
         LLT6OBWnb7AOOleUCaBCTplJmpuyHdWdpd7W2NwUZZJnYDVS6ddjPEjtbIr/Ujady5IE
         M4SWhdMvMjOEidz/TGg/PJmhEyywlMEXoVFb0y0CFTTjvFsw59YxCiacfdpFxiSiRmSd
         vqEw==
X-Gm-Message-State: AOAM531FWDS4XvSfE3JCPi+56SrECWYYkImMC+oLeAilBJtUvS6AIu2g
        IgdQgyp66pMFKwaCMdWeuH4drp24Nt8=
X-Google-Smtp-Source: ABdhPJwi7P07n+BuXNQK7cfwlE+Y7/uU+bTb7baVuv5ELtG4+NNdb6Yx8hCgUWXs7JFhnNBySWF5uQ==
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr15760440wmo.92.1622480208115;
        Mon, 31 May 2021 09:56:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm275497wrb.77.2021.05.31.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:47 -0700 (PDT)
Message-Id: <496796d4e0845516bcd971312e060507d1db3d41.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:32 +0000
Subject: [PATCH v3 17/22] t2017: mark --orphan/logAllRefUpdates=false test as
 REFFILES
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In reftable, there is no notion of a per-ref 'existence' of a reflog. Each
reflog entry has its own key, so it is not possible to distinguish between
{reflog doesn't exist,reflog exists but is empty}. This makes the logic
in log_ref_setup() (file refs/files-backend.c), which depends on the existence
of the reflog file infeasible.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t2017-checkout-orphan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index c7adbdd39ab9..88d6992a5e1f 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -76,7 +76,7 @@ test_expect_success '--orphan makes reflog by default' '
 	git rev-parse --verify delta@{0}
 '
 
-test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
+test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-- 
gitgitgadget

