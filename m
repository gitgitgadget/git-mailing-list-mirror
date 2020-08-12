Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BF2C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C818520656
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCMsB+xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgHLHMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLHMk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 03:12:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A864C06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r2so1005169wrs.8
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Yfqp4naPssX0mkUlMGbxkHmt1BKN/3mroQyInQ22IKY=;
        b=QCMsB+xnUabPRAD0LkrgNQCkUpDdp91j/PlwQoqcWx0wM5DJ+X3AahN7frCfqBui4C
         yrr6+s9Tdukex/TdiSJdOA6IOaRmjE8h7QRMY5pAcsNgurZITjfKPaLmWeysZqhx0GKp
         rESIFwwTwmfC+y9ujbjjvHWCK7LNlnGsyxfAzqAWb3UtpyAF53ZxgOPTbePivJ+nk+YG
         u2SFnXKDafsEJYyuZdukLhKRHbMEDa5IXBfvMKe/Hj6ANmalCi4ZQQtgjIbxTMdnWzF/
         DFgH5yVbVs+R+folgc3P/Sfpbsx6fMMA32XI3LS2EummjSRKNoWOopwHgfVkEtFzazY8
         cwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Yfqp4naPssX0mkUlMGbxkHmt1BKN/3mroQyInQ22IKY=;
        b=BU6W7N8XQ1jp0nVnGGOAYGYoN90xWVIXoQlcljfc1TuF3S4+xFFZzNBKrndM/stFgH
         WqzDqR9bhRMYNJWUDGi1YOHEVM5X0kVg5LCEFScQRL+iiFGov9Y54508xoMZP8pFldYU
         UdN+M8khRbLtdaQ2q0tJMb9AuCyhhumPcjEIJi/N7OnZdyQO0YAdlE4BiUFgsH6VYMsB
         InIa1wmoRm8uKntXdNrj7tzAdS717ZfY2PuwQqvGfNp+DCxjasq13oyo9Y/juq0MQDzZ
         D217JgxFgn0sgOxPVtVI2659PIXIWJ2a6ibIFXgqw0ayTjAuD451xUbtwhYBG7lXDZ0l
         Rr4Q==
X-Gm-Message-State: AOAM531QOAfr/0YpMuujupjo3wXVTdftx97oWar5FJNl2KZ3bZi4mF8K
        wUORe/opwBTgv08fbaDZy0IUChS3
X-Google-Smtp-Source: ABdhPJx4ZmAIRkdayjCj4PscjuplXiYNRqEz/cLH4weX5UDcsLlS1SroVNJfad2sXjCOwaWUAq9oRg==
X-Received: by 2002:a5d:6345:: with SMTP id b5mr35369970wrw.204.1597216358593;
        Wed, 12 Aug 2020 00:12:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14sm2621530wre.44.2020.08.12.00.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 00:12:38 -0700 (PDT)
Message-Id: <8a2a0b6c9adea54bd5d10c37bbc6965eb5cb120b.1597216356.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.git.git.1597216356.gitgitgadget@gmail.com>
References: <pull.829.git.git.1597216356.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Aug 2020 07:12:35 +0000
Subject: [PATCH 1/2] t3000: fix some test description typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is no such flag as --o; it is either --others or -o.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3000-ls-files-others.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index ffdfb16f58..1b9327b780 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -152,7 +152,7 @@ test_expect_success 'ls-files -o --directory with mix dir/file pathspecs' '
 	)
 '
 
-test_expect_success 'ls-files --o --directory with glob filetype match' '
+test_expect_success 'ls-files -o --directory with glob filetype match' '
 	(
 		cd nested &&
 
@@ -168,7 +168,7 @@ test_expect_success 'ls-files --o --directory with glob filetype match' '
 	)
 '
 
-test_expect_success 'ls-files --o --directory with mix of tracked states' '
+test_expect_success 'ls-files -o --directory with mix of tracked states' '
 	(
 		cd nested &&
 
@@ -184,7 +184,7 @@ test_expect_success 'ls-files --o --directory with mix of tracked states' '
 	)
 '
 
-test_expect_success 'ls-files --o --directory with glob filetype match only' '
+test_expect_success 'ls-files -o --directory with glob filetype match only' '
 	(
 		cd nested &&
 
@@ -198,7 +198,7 @@ test_expect_success 'ls-files --o --directory with glob filetype match only' '
 	)
 '
 
-test_expect_success 'ls-files --o --directory to get immediate paths under one dir only' '
+test_expect_success 'ls-files -o --directory to get immediate paths under one dir only' '
 	(
 		cd nested &&
 
-- 
gitgitgadget

