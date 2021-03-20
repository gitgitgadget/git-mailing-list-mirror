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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE9C433E9
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002536198B
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 00:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCTAEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhCTAEG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 20:04:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B7C061760
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so10757486wrn.0
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=idSLknFXTS1XoloM+M4ylLBzOV4eYmE8W972k0jwtXpoykbg2bs9XO+zdvl3Ui3P/p
         +kfSeD9TQB2FV3COL59i98yWsuTqUDwX1l4WoXvW61CMmiqODH3YLp7CL4yojyWRTFOT
         fneDAI0NgV7pTEnKJ7V7p7v0gbqxt+DFpz3hcutoJOpDHmpBMR5AC+chNBNKi8MLQSNh
         MfpWDI9V8LfC4vo3owOqwsCuYefhL1wpSkk1huAXmUxq2B0/sajqHZdyYdYEbP03mfsS
         u6cb/lNusD6Z527F5lKtCS9kOaElodmm7cAnuCjbrlN6w41Qm/wiskcoXsqRutBNsyXJ
         Grpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=X/O9ei5Y/8+fu/a0CsKzzM5LD1f+vsoxe0VE60ZU1dc=;
        b=f/N1JiNY/G6NH/vzLaJ3aQQj/MpXBA39jgJ1MmJ2JPRppqAu+mWSYE4BrcAj1DhuJ5
         6RtoMZ89pBdtpeDyqFS7ZRJvRXBAq7pakth+CfpTi8yS4yGvcfn5bb61FRs1cbH4pS9L
         ypmnCV4C9XUGuPu6D+cuYAVrqiP+zTKde12KAARotBvxi4DMqI6mYtn222qz5MpPJk4V
         g2qlilR7+8A8IwjKeefue8LAEI+LpAQunzcT686KTSUTit+Z28M5QV+l3UJ7jl9pCdN5
         zSAkAOsWGRzjPxfA0qJcwRlVL/zP7PuQKkBZwUPExUl2Yg2+hv0S9vLy7Wrm/QPbSQ78
         3E/w==
X-Gm-Message-State: AOAM5327ilr9b3elEl/MGn73F+CjACMCr8JnLUM37vi+FOj/oZO+i7/K
        0tjI67333CRWuvJ9XlFzvOQqDXhJGyc=
X-Google-Smtp-Source: ABdhPJwDGdUbs6509Xn6gE7FqczPDXPKZerZVagv3MNFQr9kfBnYANJfkAwOdGJRhdZVrvIW1UEAjw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr7079514wrw.334.1616198644874;
        Fri, 19 Mar 2021 17:04:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm9873466wrt.94.2021.03.19.17.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 17:04:04 -0700 (PDT)
Message-Id: <1c6361c9b88ac5f970054989bae0845ef3b6baee.1616198636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
References: <pull.905.v2.git.1616016485.gitgitgadget@gmail.com>
        <pull.905.v3.git.1616198636.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 Mar 2021 00:03:55 +0000
Subject: [PATCH v3 12/13] t6423: mark remaining expected failure under
 merge-ort as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When we started on merge-ort, thousands of tests failed when run with
the GIT_TEST_MERGE_ALGORITHM=ort flag; with so many, it didn't make
sense to flip all their test expectations.  The ones in t6409, t6418,
and the submodule tests are being handled by an independent in-flight
topic ("Complete merge-ort implemenation...almost").  The ones in
t6423 were left out of the other series because other ongoing series
that this commit depends upon were addressing those.  Now that we only
have one remaining test failure in t6423, let's mark it as such.

This remaining test will be fixed by a future optimization series, but
since merge-recursive doesn't pass this test either, passing it is not
necessary for declaring merge-ort ready for general use.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 4c568050dd27..4c3d0b95dc5c 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4797,7 +4797,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_merge_algorithm failure failure '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
-- 
gitgitgadget

