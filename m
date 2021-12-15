Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F3C4332F
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhLONqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbhLONqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 08:46:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA2C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso1478182wmc.4
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 05:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5DKjb3WTYvXkZ27+dhQuJ7yDgaXYUlIgn/9ox8Zc5Y=;
        b=lj5X/XPO9p6NWcvaqFVPDrIED+TMklorIyczz7eTc/QPmPp56pUsmK8ghi4Dx9UJl6
         o/JS5zmraBA5E+YF/tsyPMdba0gW1+goEbvnihs3SvrEV8Qiy5+HYUDu6GamM7FH/ZmF
         GRbb7LXgg0TKWfmwv2RVgF7aXPJ3J9d//LKT6w6f1SHKV1DP4sIyvOwFz3FAZp4qHnmy
         opHem7xskxd91Fdb2QAOIBapcOero5/Ph1KEx71U5tqeiOkSTzMqYMlF5dSMg6Q8pZFT
         sH802vAVRRPKXl7lNxwtXC+uPU9v7sTpsexk0tiVPMtSciBB4Xca6uSrJpIiMSfuwxbk
         zWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5DKjb3WTYvXkZ27+dhQuJ7yDgaXYUlIgn/9ox8Zc5Y=;
        b=jiKlare30E4/ahIzeaiOgmftvG9USI57yWYKrk5Xf14h+ui01tM0dl+MD/qktfrTmv
         2cIX0qtvoRjE39VgOPYD2Q2UDPnsz8XGv9auVty/KskqujUTd1SXZZ6OB+e+J4DlcBAa
         4AQqtFNPSGPHZupJNVo+i3aZrBbY2N9IAFTgwrXoIxd5HKStBxJSByvxXH7sNzZtvS14
         1OAWCY0hTZboi4cVobK9BQ8Z/KBiOGhPU3iayMKn6N4VEiwnFdXpgtdwfM19viypYeT5
         oSLJDsgIAdKHy6MC9u9tcLigpbNP0JYyvHcsdRtAaDXehH5YDkZ4m0my+/NbiN191Jo8
         70RA==
X-Gm-Message-State: AOAM532cYIX75wGahnjjMnplQzOdqfJ3u6Qi3GVC5NoCGxiO4LofRiKH
        Oz1IFvL1IAcfPQIxXutxWVDlnec+EfH35g==
X-Google-Smtp-Source: ABdhPJykeLNIDdOVOgWM2TUHPGlnDj6aio3e3zh63pzW4vuITzIt6Z0mTD//CToKLtdOonmIfXu/cw==
X-Received: by 2002:a1c:9a89:: with SMTP id c131mr4574481wme.80.1639575970876;
        Wed, 15 Dec 2021 05:46:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r20sm1108745wmd.37.2021.12.15.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 05:46:10 -0800 (PST)
Message-Id: <a2fe867222ef32656acdd45f02e3157194154e57.1639575968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
References: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
        <pull.1069.v3.git.1639575968.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Dec 2021 13:46:07 +0000
Subject: [PATCH v3 2/3] sparse-checkout: fix OOM error with mixed patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add a test to t1091-sparse-checkout-builtin.sh that would result in an
infinite loop and out-of-memory error before this change. The issue
relies on having non-cone-mode patterns while trying to modify the
patterns in cone-mode.

The fix is simple, allowing us to break from the loop when the input
path does not contain a slash, as the "dir" pattern we added does not.

This is only a fix to the critical out-of-memory error. A better
response to such a strange state will follow in a later change.

Reported-by: Calbabreaker <calbabreaker@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  2 +-
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..9ccdcde9832 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -483,7 +483,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		char *oldpattern = e->pattern;
 		size_t newlen;
 
-		if (slash == e->pattern)
+		if (!slash || slash == e->pattern)
 			break;
 
 		newlen = slash - e->pattern;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c72b8ee2e7b..67ce24c9c83 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -103,6 +103,17 @@ test_expect_success 'clone --sparse' '
 	check_files clone a
 '
 
+test_expect_success 'switching to cone mode with non-cone mode patterns' '
+	git init bad-patterns &&
+	(
+		cd bad-patterns &&
+		git sparse-checkout init &&
+		git sparse-checkout add dir &&
+		git config core.sparseCheckoutCone true &&
+		git sparse-checkout add dir
+	)
+'
+
 test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 	git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
 	git -C clone_no_checkout sparse-checkout init --cone &&
-- 
gitgitgadget

