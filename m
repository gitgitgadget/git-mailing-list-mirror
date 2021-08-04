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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D8C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C9260EFD
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhHDXvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbhHDXvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C9FC061798
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso4982751wmq.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rOVfpWtI+ZurzMLAaD+5QTFcUiP5+UNqUmR05BHOY2E=;
        b=NVmE2LLIx/RD2jik21oDkp0t+XNOJscq+sVfnzL4upTObQx8WEZ6ls3JOvbzg1vbSJ
         aV3w7wvgxOQBOySFCysYqMDcaHhkO6tmvZCwZETGf7b3b2u/aJjvsSzbhWomMiPfQfuL
         9soroLahWYJz6mpzbRcXOtmkatU/KEIHzpDt9DJCqbOeBxN82dWZ4pgVs1YsqjH6lfJp
         mmfSik3FBWWo1bbZn5z0+3uOa8ly/yp+bL6le8/AOCG58mawyyOQW1eRzFrkELt1m8Wu
         8DS3VU6nSxLI43gzkUOfz2K4zLbFyz2PPitHJs4m1mBqbJ3aWhYRCpRFrMU+Zv7l9zTi
         MM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rOVfpWtI+ZurzMLAaD+5QTFcUiP5+UNqUmR05BHOY2E=;
        b=PMkACT/4mzqlAeM57rkMTiz20eNQ6mRCzXTRqxc8T6qyhEkdbY2lxZ8KUB5OU2enpG
         Rv0xr8gE0iHIYnE8AKTZ8MVZKlioKjqyQ/BRJ8HzCTKCkO0iKPJx3rtvqhg9rzxpJ2am
         nSdgWAFz3al39yyKWoHSXkypZbp92/WDMZa2Kr6dlqie1gvQSG03zhVz803kp8x2wL07
         O2vBtXfM7Wk/wnseTrVCzl4Yiq7PwAHghwyHCfuDimhE5As3xBAvkpLAnIg6hGc21lyc
         4Oa2L3GFalukS2BYLIj6lYD9+g4JcA90SPv28b2tveNT01rdIHtgDptvNidZ4+FI4U3e
         /QeA==
X-Gm-Message-State: AOAM530H2CsKjJmnvVWx0cMSL6YCUr2jwtOzrEZLBJggLSdV7Zm9ak1c
        VKCsojeIzZ8AFoglGTcZFBlatcSHeKY=
X-Google-Smtp-Source: ABdhPJyr0T6SmGS/eO7qh5VFanwq2qCqZXHPwlIgmTFghpFLszHDwy/Ue5M/hXn3IfUvCx+zCOrQSw==
X-Received: by 2002:a1c:2904:: with SMTP id p4mr1807282wmp.178.1628121058701;
        Wed, 04 Aug 2021 16:50:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b20sm4109290wmj.48.2021.08.04.16.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:58 -0700 (PDT)
Message-Id: <81a3092b9b0509906d3b9d4d85c8f706c7492200.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:48 +0000
Subject: [PATCH v3 04/10] merge-strategies.txt: update wording for the resolve
 strategy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It is probably helpful to cover the default merge strategy first, so
move the text for the resolve strategy to later in the document.

Further, the wording for "resolve" claimed that it was "considered
generally safe and fast", which might imply in some readers minds that
the same is not true of other strategies.  Rather than adding this text
to all the strategies, just remove it from this one.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 5d707e952aa..f100fad1e43 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -6,13 +6,6 @@ backend 'merge strategies' to be chosen with `-s` option.  Some strategies
 can also take their own options, which can be passed by giving `-X<option>`
 arguments to `git merge` and/or `git pull`.
 
-resolve::
-	This can only resolve two heads (i.e. the current branch
-	and another branch you pulled from) using a 3-way merge
-	algorithm.  It tries to carefully detect criss-cross
-	merge ambiguities and is considered generally safe and
-	fast.
-
 recursive::
 	This can only resolve two heads using a 3-way merge
 	algorithm.  When there is more than one common
@@ -106,6 +99,12 @@ subtree[=<path>];;
 	is prefixed (or stripped from the beginning) to make the shape of
 	two trees to match.
 
+resolve::
+	This can only resolve two heads (i.e. the current branch
+	and another branch you pulled from) using a 3-way merge
+	algorithm.  It tries to carefully detect criss-cross
+	merge ambiguities.  It does not handle renames.
+
 octopus::
 	This resolves cases with more than two heads, but refuses to do
 	a complex merge that needs manual resolution.  It is
-- 
gitgitgadget

