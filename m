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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A5AC64E7B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B981D246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRDZtPqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgKRXpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgKRXpD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:45:03 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40633C0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:03 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so4248982wrr.13
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J+FkEqdWQyeA+Uuinwe5UQ9jWwtd8F5Vj6XzhQpv5IQ=;
        b=QRDZtPqBRQCRYlZl2/zITHsmq8joqMmazXc2dKosxgqtlH4aEPymu0iTUwBWHqi4oH
         oqGDBBfNadB5dxCnveeTxDYZciIfipfnOsv30Jyu6RWK7Tv4yeEhL4suqb/ej1s7jxL4
         IsYEOGRP5iETd0pLbN0P1z0mGTkIdJth7awYrXNB656b+27DKLYUid1VWRsQyHfq/5zu
         b+QpgLNQbDslfm3M5TJu8asS5sAZifk2HLWLZfYgte5Mobcfv5jxkvrvscEkbDqJDiM5
         vvceM/4pKqzkEpBjdwAU+bmuyt92n8efeMpVjVLIP/sItdrNx8nMHyabSNibwk+kQ8HG
         3kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J+FkEqdWQyeA+Uuinwe5UQ9jWwtd8F5Vj6XzhQpv5IQ=;
        b=pEH2CMGufOd6o2RQAuBwMZK5bfnnCs50WUAmSKRTCt/kuuY2NZvwMIl20yhTiur++E
         IVEPzFfgiPe1RxFn4l6iD1BuSYMlfSjXQPJijvtak8mDVZRr+d7E0qtfl/NMPOqpDQQT
         oZG1J2H4AdqBRdbhejhYvHdWm3fZVxIQu/1qpxerqs6KB2ThpewnAuktZ0LsSwhOVKwK
         Vs0JGqiozrM2U6bxLKKhO1IrcX795d9PEWoee475V+jqXFKkKtLDVsDXtBoTVyunwbxq
         bbPpVMbMjhg0NQYIkHIc008tDZlkMbVQYQNM5S0IIT1HNUj7bnih37GfkjHKSCyTHT1n
         VE2Q==
X-Gm-Message-State: AOAM533BtGDYT8TypXAxwE5N0GjXtyIZVEuuzsaYb3HgFHyP/m3043tq
        ZS5rH6E4yMThCJyDZAZtZx+xIy0wAlM=
X-Google-Smtp-Source: ABdhPJy90a61W36O2NcaDK2fw+sdCo8BB4gzSAJiwmduFT25hz+uMocIbPYy10aVetB1Nlb+ZlQwlw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr7604221wrp.156.1605743101894;
        Wed, 18 Nov 2020 15:45:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm3381733wrx.93.2020.11.18.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:45:01 -0800 (PST)
Message-Id: <f7a9bc07c7a2ee702082aedb58ccc8c540286ec9.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:30 +0000
Subject: [PATCH v3 12/28] t5503: prepare aligned comment for replacing
 `master` with `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In an upcoming commit, we will use `main` as the default branch name in
t5503 instead of `master`. This will require extra padding in ASCII-art
commit graphs, which we hereby add preemptively.

By doing this preemptively rather than after the commit applying the
search-and-replace, it is more obvious that we caught all aligned
comments that are affected by the latter commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index cd1f407174..525dd21ecb 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -14,7 +14,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 #   L - A ------ O ------ B
 #    \   \                 \
 #     \   C - origin/cat    \
-#      origin/master         master
+#      origin/master           master
 
 test_expect_success setup '
 	test_tick &&
-- 
gitgitgadget

