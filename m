Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0ABC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00368207D4
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQIfHcH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgETOow (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETOov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:44:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787FDC061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:44:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id m185so3146315wme.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2jRJ/l9Jcw+tUDSYoI3GFSAlEmoEVFrHoGnLMPJoVJg=;
        b=eQIfHcH9SJWct+SGfAbVfd+ShoUcYXrfR2SPm5u+8omd/SSVKJOCImkBU9f7bExM8G
         Jyl7o9khduH7wYhIOYkXzQKSySUmpuLZHkOaTB9SHKSJhsrIvy8RxUZoWH1++45Paj5i
         A7P3OtGQohQkQ4j3WMIVxOrMf9/EeTcFMlXddlQa/qNmRPU4EA3gH8qoqv4lScpe0bOp
         jwYXlIaP5Ngy5xn5PKLvOJ2YPIQcfUeC9qKslJwQ8GSDUilPmTjc8cq5kYN/2ip0iyUH
         f5s8kgP5hBVb88P4+LlwQZeMUKXYin65p4Nxm9i0nR/4KivYep3enKCqqliQN/3hdYqY
         tboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2jRJ/l9Jcw+tUDSYoI3GFSAlEmoEVFrHoGnLMPJoVJg=;
        b=CFcw+zPrqODNp52C4vCOu3ZddqJqgFxC/BkLSeTBdK9Km6AdA6pxcShYmyD2v4COp7
         oEWnens1QPpkk9+GU6bYuV64iP9myP3MYcT0r7KlomAbO8mMuMHHpbTKPug7dP7oMLc1
         aYPA+mzq27+mnqYSSzZB09XX+/Yq8Y+W6vBJXwDUymfwxKRMj95fqoMlDh3SXhBcEdSo
         89jBoxzMZM4V84ytwFDvU9w0/kqbF/MLq1/G+OAcd4VRKSRKXfvTbIsCimPcO9Y8o6q3
         DqbPuHx223EzZn6flgD93tvi4WvkKWU3fx08HhXz4FEa76FyxXW/gdoNZN6h4kalsCeR
         gFyg==
X-Gm-Message-State: AOAM530Gloz5YMQwZ/fCYK3qlyj1ynfFzXcjg6zEvNxRuire0U92NIs8
        zO8EOYeJjlJZrTwNYM5SC5syAsLo
X-Google-Smtp-Source: ABdhPJyQ97Nq3io2uwHD0Aea5pyplJCf32RO7807aSToX6M7S6bt+ErpnjJUpB9NrUVZmLkpzH6lhw==
X-Received: by 2002:a05:600c:2258:: with SMTP id a24mr4785075wmm.111.1589985890027;
        Wed, 20 May 2020 07:44:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21sm3296111wml.5.2020.05.20.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:44:49 -0700 (PDT)
Message-Id: <pull.639.git.1589985889076.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 14:44:48 +0000
Subject: [PATCH] command-list.txt: add gitfaq to the list of guides
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When 'gitfaq.txt' was added in 2149b6748f (docs: add a FAQ, 2020-03-30),
it was added to the Makefile but not to command-list.txt.

Add it there also, so that the new FAQ is listed in the output of
`git help --guides`.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    command-list.txt: add gitfaq to the list of guides
    
    The new FAQ is not listed in command-list.txt, so it does not show up in 
    git help --guides.
    
    I think this should be included in 2.27.0.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-639%2Fphil-blain%2Flist-faq-in-guides-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-639/phil-blain/list-faq-in-guides-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/639

 command-list.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/command-list.txt b/command-list.txt
index 185e5e3f05f..cbb960c8436 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -198,6 +198,7 @@ gitcore-tutorial                        guide
 gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
+gitfaq                                  guide
 gitglossary                             guide
 githooks                                guide
 gitignore                               guide

base-commit: efcab5b7a3d2ce2ae4bf808b335938098b18d960
-- 
gitgitgadget
