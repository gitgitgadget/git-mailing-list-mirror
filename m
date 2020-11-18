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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC89DC6379D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A04C246BB
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6fiyTQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKRXpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgKRXo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:57 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F68C0617A7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:57 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so4764720wmi.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yZH1qS27mjp+HA6snRxLwhmsWm9S1IFfBeurbQFtCDw=;
        b=V6fiyTQkzbIbzoBr8QPp0JB0T5/NfsemgwKx/egCqGdhLYraW7yoprer9WazBc7Yx0
         5PBNBRSIn3cVv5Tq7eqt7HnIcUqIrr3DAzrLaT+0iwUwgaoqykL+zq40PoNsM9CS+PTV
         h3+i0pGjZ0p5V54MqaROvWmjjOEgQEIaQdUZBwOebiYM31p9qk7uGkGg5DyKKeHvGzUE
         NLfuiIGYo8LcEti/HDGV6Me8AxxToexMW2Zs0lL8iHWeWYa/s0Zl401K1NdRi5eCbxG3
         KqLia6lfJtymHcMyf+m9NsZ/sCh62twYXmHSTFao76K3tVM5dSstYiGjU0cBczOHbwqn
         wfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yZH1qS27mjp+HA6snRxLwhmsWm9S1IFfBeurbQFtCDw=;
        b=TyNCH8TO8EzQ2qrCiNCO/Olik587vg0Hr6E9n81efgpyVIEOI/F5cf0XZNeAcWj3D/
         G3UScgBuvkIGSqXvEH19OhnZf5djXh9oA1BweXUCj4Dik0LI80ph0les7g2fi3jKexF5
         7O9snljtnMI2ujccg281VKtghh23Ny5/PK9Q7aub2D+g/yyGBp8e559rodEKwJ6SMSkT
         1Z/ljo9p6jjxhMb6YE5QM3l63IOI3jLpxyA2PqWnE17KssA+61WdSHzyY5KYyYTK9cgN
         YzHBTzNCSxqMgpQMHmw7eTKA1qrcwJJPOxC7ntIAeB/uk4R3FFydnx5yKbSO8OtZaWY6
         xEYw==
X-Gm-Message-State: AOAM530tg7SlFD6iDG9fVT5fQ0Jfht9cDXg/1LYj2tlsDusUGdPsmL3+
        Qs0YsH5pBWuFm0g4rgCGZ8a0dTTPxsQ=
X-Google-Smtp-Source: ABdhPJwasbky82OaXBJjc3OreYRcizw3qOF8lH5bP+xti6Tya3oNDHu85XGe6GeIKWiQxzSU9wjiIw==
X-Received: by 2002:a1c:964d:: with SMTP id y74mr1423643wmd.129.1605743096161;
        Wed, 18 Nov 2020 15:44:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm36943822wrx.9.2020.11.18.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:55 -0800 (PST)
Message-Id: <c8494f4602c5b0047c40039f65ca17e6d6be4605.1605743087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
References: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
        <pull.762.v3.git.1605743086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:44:24 +0000
Subject: [PATCH v3 06/28] t3416: preemptively adjust alignment in a comment
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

We are about to adjust t3416 for the new default branch name `main`.
This name is two characters shorter and therefore needs two spaces more
padding to align correctly.

Adjusting the alignment before the big search-and-replace makes it
easier to verify that the final result does not leave any misaligned
lines behind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3416-rebase-onto-threedots.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 0f5b814aaf..d0476fbb28 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -15,7 +15,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 #
 #	    F---G topic                             G'
 #	   /                                       /
-# A---B---C---D---E master      -->       A---B---C---D---E
+# A---B---C---D---E master        -->       A---B---C---D---E
 #      \   \ /
 #	\   x
 #	 \ / \
-- 
gitgitgadget

