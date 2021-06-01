Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B74C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14D2613AE
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 14:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhFAOhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAOhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 10:37:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA1C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 07:36:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1737913wmh.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FvO9SlHLHzmwtg2Z7NSF7rM7C0GIBzIwBzMQyxbAZdw=;
        b=ZXqsb2oF020prs7CwrBmQCbh2x6iZjlxHhwIi4bYFjv26jhGU6gCIzpAvjriJAjsM3
         /17PpnykFfYbWGqKOG/mjdGus/zpnqwIAKK68igY18qpUTGG/oQfyGidBMJ4wOn0GnhR
         EhooigMhmygCjz1COc+KqAscHU8FT6UKe7eU16ltGm2MgklbzVHYB4gXTgaOtdmasz2f
         sr/3CC3ZR9Tfvch9TGp3luf6Mc3HOsabIyoT8bMGZk5NINeZDfsWwvpn6UGyN+aBhKV/
         FHATx6djoajKPZehzaTaSlr0QG2fGDu8J/R7+IsfJSQpBZ1h5HlFFZBs+IhWlhWFD3P+
         FL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FvO9SlHLHzmwtg2Z7NSF7rM7C0GIBzIwBzMQyxbAZdw=;
        b=dfSQH064xB4Qq9llsVSnS6KJRPtBCNLM5+/W/9M8a49GJ+C5QqcbWAr2zP86Bwk1tv
         AqDvwM7rxxZ+QOjPWRwBZSZ52w5kaF3P10QKoGUsh4aYRIIPT0zDHt+y7s3hickPT7fA
         gcrtGRCIAQEGu5RWxn+dAp1M8FzBGxSOe910m1VKdVM8akct0qUaXbbKFchwdbcc386d
         KPxXgWTrtvlQn3HBQ+TGUSaEWi1/thtd6xh2YdnKHd+wyZmfD4GtM3xF5kjpHE3gzM5p
         AndEqPKgvTuEe3M9L258MiTfibNCUE70kkf/hMMphmkZpDduvlffY0ShAB81tw01CJn0
         br3w==
X-Gm-Message-State: AOAM532e3E2qzvUwbMCwQuv0HX5CPoEDm2Hh3DOmyoOVh8mGegRMOmqO
        pdzk29pM9AidgxX2uoSOc0xXB289B8A=
X-Google-Smtp-Source: ABdhPJxjsVNmPKSCcY9um+is1c5oOf/kvtJ5LxdH3PHHo1+d1QXlwWFoJm4njPprC6gIf9AJiKq0pw==
X-Received: by 2002:a1c:193:: with SMTP id 141mr250153wmb.106.1622558158914;
        Tue, 01 Jun 2021 07:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f20sm22231238wmh.41.2021.06.01.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:35:58 -0700 (PDT)
Message-Id: <pull.967.git.1622558157.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Jun 2021 14:35:55 +0000
Subject: [PATCH 0/2] [GSOC] cat-file: fix --batch report changed-type bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change from last version:

 1. Use Peff's processing method.
 2. Add tests for atoms %(objectname), %(rest), and modified the test
    method.
 3. Merge two check block into one.

ZheNing Hu (2):
  [GSOC] cat-file: fix --batch report changed-type bug
  [GSOC] cat-file: merge two block into one

 builtin/cat-file.c  | 10 ++++------
 t/t1006-cat-file.sh | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)


base-commit: 5d5b1473453400224ebb126bf3947e0a3276bdf5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-967%2Fadlternative%2Fcat-file-batch-bug-fix-v2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-967/adlternative/cat-file-batch-bug-fix-v2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/967
-- 
gitgitgadget
