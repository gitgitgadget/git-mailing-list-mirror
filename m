Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A08EC4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9D1207E8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDM/8jom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbgKJXm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgKJXmY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:24 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453BEC0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:23 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so126608wmg.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 15:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=lDM/8jomBtkqjzTE2BgdOvmoNuJp+RpnGPznk/wwx6aOmNsasx1fJ5+nu5vsFz6zpd
         BVYfVZmj7Z4I7IE4a7cOcHf/VP2FmPlH0zBW1aDHaRWu8lpA85TRMeyQZfTudnn0ovNZ
         zGDvDh8YWiyFEfaBGtnK1MtQdjBquLSlLErAk2WsqyE+mFGW+euGm/kavIF6uAhPv0qu
         9z9kFZwE/LWcEZACNrp3u28Y5VYzCniLEzovTrZjIwdcFkj5nlylUoGHT4ioo/gYrwH5
         BVXu5M/rkZFEQwmtE0Rv6TWFp2m5M4gSMK3ryTtmTcOQ2IoGvo1ZD3fy0QtPu2tKCVvv
         vTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=js8oUsMHl21kgw69PYKoHcc81MiST6F1XqDnN0kNdcM=;
        b=LeoX3Rbe8fBVL6NdeQbkl6BCOKLh9I58MNVD0/NuRG6o7NvJxf1NYelS+E0Sb7+kJA
         8FFCM4Swq1w73pPJrYwU7cTxICe8Iek/hIkKVhvU69P9PlTMu1zibLfpfHWmRrsNA5El
         wJxZ/b6dgJwfOn3EUy1+VHTQwbptwumav+CeA4IAnfoH+6wnOpNDm8NiZd9lXLkkx6ZT
         EytNGr3pJuWivzQyg5Gwf8HrZnRDlzlhYdnhYnCkrbJ41MTBopVq65X6gexwKSnz0Ppp
         Fw+d25RPmhU4/dXySoei1yJKm/ufn9uLwYmeU1zXLqsZ+J5/CDvV2iywP7AlV0Fijn9j
         B+mA==
X-Gm-Message-State: AOAM530TVzQHBie502ZNF5Cr3YofZfkGFyZmkYO6r2GNkVxzlEfUhRdO
        dHtr6Jl+wts9NUusYSRMu9gznXl6Wcs=
X-Google-Smtp-Source: ABdhPJyEfIUlyVVl2nHqjKG/is6CabCWsG4PGeqU1rZY0FVcmcyEy9sj7GoHWdbhAoaAaniS3x9eZQ==
X-Received: by 2002:a1c:a555:: with SMTP id o82mr578977wme.188.1605051741433;
        Tue, 10 Nov 2020 15:42:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n67sm389494wmf.25.2020.11.10.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 15:42:21 -0800 (PST)
Message-Id: <6152122c04aacf8c3e3f1aae7b73995da6b9e354.1605051739.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.785.git.1605051739.gitgitgadget@gmail.com>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Nov 2020 23:42:11 +0000
Subject: [PATCH 1/9] add -i (built-in): do show an error message for incorrect
 inputs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There is a neat feature in `git add -i` where it allows users to select
items via unique prefixes.

In the built-in version of `git add -i`, we specifically sort the items
(unless they are already sorted) and then perform a binary search to
figure out whether the input constitutes a unique prefix. Unfortunately,
by mistake this code misidentifies matches even if the input string is
not actually a prefix of any item.

For example, in the initial menu, where there is a `status` and an
`update` command, the input `tadaa` was mistaken as a prefix of
`update`.

Let's fix this by looking a bit closer whether the input is actually a
prefix of the item at the found insert index.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 555c4abf32..8ca503d803 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -194,7 +194,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 	else if (index + 1 < list->sorted.nr &&
 		 starts_with(list->sorted.items[index + 1].string, string))
 		return -1;
-	else if (index < list->sorted.nr)
+	else if (index < list->sorted.nr &&
+		 starts_with(list->sorted.items[index].string, string))
 		item = list->sorted.items[index].util;
 	else
 		return -1;
-- 
gitgitgadget

