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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C860C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3FE60231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhEaRmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbhEaRlD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:41:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E0C008755
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z17so11553094wrq.7
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=CCtcrmQpghDYfxtA502AvpYUDL4oMd5ZPY1rTH3TLwI=;
        b=CasW6mzTrHm8SG9U7BrmLnEYlcA83w4q1G9W1HQM+mBbN5qDg5GwJcnQPMbrN7JEd8
         hRbYBqlp5PK0qC4f6NR1/2dFoJ8gSCiGP96hPeNTGGd53/CfmXBkbRV92YDObjpkiwYd
         CZ9aua8TWG2+37bPbLv2XS1bFPvi9beo6oJk3d938xx+rmneOP42mjPsj2G5I9z8mFpS
         4TDnZkRr8FsNK4DN2hCNsOIWhO3IMZNNlIcoXnrdGRaV4UzDXtbJdJItHOwITv48+kqQ
         bxoZ0yJ5YnDd4Wq+XZldYd/oO9/stNuFzCLgOWoJTVvzpqrs3b8QKu430pGFDrqeqwre
         sPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=CCtcrmQpghDYfxtA502AvpYUDL4oMd5ZPY1rTH3TLwI=;
        b=DIFpIFfstE9HTtbVRoeWSVT0+rg3eiGoJZTW6UbJqSmh20jj6TUHHHVBVsIxrCubUZ
         fvlsfiVbuSgU/ZZtv3b8xZPkrQqiNveg/WflxuklRJpKMur0DNrITidVJibs6tkgRHsu
         cHj4V8n1P7f7eqTzUNKpfXYw97w81Aph7rC0zfo5wmXIBw0K4V1HF9uccHWL2nF3AY84
         WTeYlF3eTOUFu11w/mJc+ChxOq7VcBNFzVF/2LeVY/JiBQ+yrFQdns6bcum4ueS4Qe6P
         AZSHpIKibapsElEntf4ujJ1/8aD9PJUZ1yWtXKtPPvz7wxY8SPCvdZ/9qVJGC/EpHcX4
         ePLA==
X-Gm-Message-State: AOAM533mBkEzjSctimrU7xu9i2HC41FaozUR/cHCWvYq3QBgqwjKX0Hp
        Li+NN3xI2c+Di2OKyszPq7+fOvZW7/I=
X-Google-Smtp-Source: ABdhPJyWskfo/91P4RkVYqOeYqHheDi9gQ+qmmrklOdB8bKXHLpFV7EHLmvBFnMF9QnLFaxBjCggkg==
X-Received: by 2002:adf:f907:: with SMTP id b7mr23006891wrr.357.1622480209072;
        Mon, 31 May 2021 09:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j18sm15309665wmq.27.2021.05.31.09.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:48 -0700 (PDT)
Message-Id: <6919c15e5f9800c6f52e575f8b62993c000843ea.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:34 +0000
Subject: [PATCH v3 19/22] t7900: stop checking for loose refs
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

Given that git-maintenance simply calls out git-pack-refs, it seems superfluous
to test the functionality of pack-refs itself, as that is covered by
t3210-pack-refs.sh.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7900-maintenance.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index b93ae014ee58..58f46c77e666 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -356,8 +356,6 @@ test_expect_success 'pack-refs task' '
 	done &&
 	GIT_TRACE2_EVENT="$(pwd)/pack-refs.txt" \
 		git maintenance run --task=pack-refs &&
-	ls .git/refs/heads/ >after &&
-	test_must_be_empty after &&
 	test_subcommand git pack-refs --all --prune <pack-refs.txt
 '
 
-- 
gitgitgadget

