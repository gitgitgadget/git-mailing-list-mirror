Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3C8C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbhLJPVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbhLJPVt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:21:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7FFC0617A2
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so15441214wrw.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N5DKjb3WTYvXkZ27+dhQuJ7yDgaXYUlIgn/9ox8Zc5Y=;
        b=b8PsBAUM4OlhrQVAvDOy0znGMALe1DXStv6G/JmPuu5ZRtosIiSuJHMS/vL8l/iLkD
         HwLoOiuEr0iAF1eXCmvfcI0NaKf+a4w1xYaUOIrTODjhfKJUCBY4sMv0Y90v9Xlt2PRn
         Ewqiz+zGGPO5Qu3atyxcxA62bjLU93g4LWRDAxbDbsmXGVkoOyfRJDm3SYmqNYnUBNMK
         WyHQ4tTGSM4oUimuxi1mKm4b0rd0T1JADU55MsqnV7mqao8tyquITwoiXD1D0I4q9M8J
         BrpO3Lbw4J/NUMHDfowOQgc8rmmdg9MiBpgnVxWMWbZz8GWc0xGr5fPt8eK5utDMjad2
         NTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N5DKjb3WTYvXkZ27+dhQuJ7yDgaXYUlIgn/9ox8Zc5Y=;
        b=lUlM9G6Srg4pnFbhfCiFS1fWFANWQpQaxNvWSIioxwcpOUydPxD04LLWZ9HLrV+ZCY
         SgL9JKxZfmlPXeoyCDlxcCTP4nbgWtUs6dp1Ma8ZEQr+X/xgTkufKtXqHLcAZZNfAX/4
         0LU09JPNxOLl4i+5pGZ2YJX9hSHJU+TQZ763CQwqhEciQphqK+HN1YPVc+Zkr9lyEUQZ
         YB7Ff/ebE5LjHvYBGSdZNyQDddn9ubCQc/RCbx0Op3SaCjTVtweGWKyKibUNZrB/h1O9
         LoNpg7Yhxrju0PmSWJu5O8CS9rSst4NR7S9g+u1vXBFN+t6GGyDbRhx4pDsBg98h/CwL
         Y33Q==
X-Gm-Message-State: AOAM533aMC9hEYd0RiHt5+y8H8hWLnVL5HQgjySwBN59vlMUufp7wEy4
        YIRgLXvtg1IurPf2Lxv+9CP5ZmqMK4k=
X-Google-Smtp-Source: ABdhPJznHQEIIkZACikCBZBMpde6k7Y/uPS5MKk6ipgp1twp+I+dYetWcNf8IfDJru12m4vmvAN1pg==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr14315413wrp.428.1639149492958;
        Fri, 10 Dec 2021 07:18:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm2763081wrb.2.2021.12.10.07.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:18:12 -0800 (PST)
Message-Id: <86fbf130c039b2c087974b213e12919f7809e05b.1639149490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
References: <pull.1069.git.1638907336.gitgitgadget@gmail.com>
        <pull.1069.v2.git.1639149490.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:18:09 +0000
Subject: [PATCH v2 2/4] sparse-checkout: fix OOM error with mixed patterns
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

