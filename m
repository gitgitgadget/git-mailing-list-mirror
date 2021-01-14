Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32959C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B7C23A6C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbhANXgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhANXgF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:36:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146A6C061757
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so3834396wrx.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrlmDhaXitHjSwJidneoso6MzPAP2tybnOvoL/rA8oM=;
        b=I65FHuxSyZj11oY2FirycQH+0h13ZxFYik79gPNUoGiJej9U8prqu+hNGn8VPCtoFM
         lwABXY/qYXh1IYof3ylRkZy/q50cnOVVkmZcs+KyxnxxKj3Lj5m9oDpIt5qpK97oWSJw
         q30IbwPkBJWpIxQDmSdAAvg5SVoCtKgqWr1Bk6SNo3BCQTVMnnWh0z37AK9Mu2vEIN4K
         /NuAT59Wn/YZ+HXa4E8KLj+kGpUR4a/tdIM1etr08wL3SfvZhnRIav4i8Vs6zW5SPk24
         fbDtOQmIXQBvppnXzT7i4qdugSj5yyMsla8zal09czm18xu61MpC+ay2wp9qHYBSfRGH
         6Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrlmDhaXitHjSwJidneoso6MzPAP2tybnOvoL/rA8oM=;
        b=LpmEgkV434Y0Kh1kAoye7HA4BOVEnkmQifQE0D0B1EcEy4A+tp6rjPZz8plFrh6f2W
         nnwqX0CarAgHkUbEut0Tx9uShnf6gAaEL2u/OmJ0spHdHmfZd9jsykEtYaVNdbpZuH5i
         FgdnJnpaV4u0MrAUSZQ/7w0HM8bmgGfjwNBpK9qVVMM9DakUOKKwOm8ToD7gT1RY5zjm
         4o3kGiE1hYq1qrNf17AQjfIqsYWnkm+Y3rhKZwk3aBQLz0GspS7r8XB9bI74K3o0VEVS
         CtRjO6EzMlcu+627HFBAUHAtBFpvJ4aV+rnnvGheJwG+BoNht6SYUn0mc9Ojeo/j9kPt
         pRVQ==
X-Gm-Message-State: AOAM532GsVX0i49Nqqfb8YQqIasvdk/tzrl6X+rubk2Pc68R/Qfgg/Iv
        AdXMBSozWJaMZc7vlV6XGmvok5MVaHMUrg==
X-Google-Smtp-Source: ABdhPJzCLDtBQHxNtTUZdhCSswl4YuGh0bvgUfMutNWuZzXqhKVnthZap5O32XRkC0/hI8s4g6ks5A==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr10225157wrr.230.1610667323582;
        Thu, 14 Jan 2021 15:35:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d13sm12352118wrx.93.2021.01.14.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:35:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] test-lib: add tests for test_might_fail
Date:   Fri, 15 Jan 2021 00:35:10 +0100
Message-Id: <20210114233515.31298-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20191115040909.GA21654@sigill.intra.peff.net>
References: <20191115040909.GA21654@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This trivial sibling command of test_must_fail added in
fdf1bc48ca (t7006: guard cleanup with test_expect_success, 2010-04-14)
didn't have any tests. Let's add at least a basic one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index f4ba2e8c85..f90c375fe9 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1326,4 +1326,10 @@ test_expect_success 'test_must_fail rejects a non-git command with env' '
 	grep -F "test_must_fail: only '"'"'git'"'"' is allowed" err
 '
 
+test_expect_success 'test_might_fail is like test_must_fail ok=' '
+	! test_must_fail git version &&
+	! test_must_fail ok= git version &&
+	test_might_fail git version
+'
+
 test_done
-- 
2.29.2.222.g5d2a92d10f8

