Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F187C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0E261494
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhGHK4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhGHK4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 06:56:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A1C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 03:53:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6402692wmh.4
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 03:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=er4KOSngB24mP0/7muZspZo7Q3eMoiHI2018IBlTURk=;
        b=Jrx1C+VXbPGYnCz/himJ1el61pCm9bH9WFHBfITQBcDnS37EZj4oQ3eYvN4XzL6sDu
         xoW97Ov8093iOg99YwgnK5Z3IYfbdIgJ5mGGscy9Um5zPvMXVY5Ou8gwbL4SZmOcbB0v
         n16XAqvaFqpswzLBFHQ9kxlXdORsJrbkukjJDOJQfVh7N5i7nqLuvcIvYP+AMLiRQUT4
         I+uTute8e2D2gi+89VckSGTy35E0Ob3EBuxFBcFGcpS+LkkdTVJv9pFDkXR2CJBzgT3m
         Y6JZKPXVxl0yac8VJEwbZu8KVnDM5jpBHQQmIrAqbSWUz0Wvz+v0VJFHbVJzROri4Ig9
         AlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=er4KOSngB24mP0/7muZspZo7Q3eMoiHI2018IBlTURk=;
        b=mSs4YLXQzXXtu38KYsHq2aGp4v2fuW6rakTBI4a8Y4yD0L8P8KnJlAZeC1tTqCbE4a
         qkOMnwye9SgkYekXlVmeT0I2XfFvUNQPhxPYMHeBudWD7nzXj00Uo72u0TFoe4Z++vlp
         7s9Bza7ybIQgAWJkybYcu9DxQEMOUvpHSpsr+msS5pWcytAwr5qXWQBPEc42nLKOGv+j
         6GxHhffc58nj8Pow9t7L1UheUR6xpKo/JXJTOs5Ue4McqPCNN6h1iRf9DL3XlDQWIukw
         eGZq8unlk0rqax81sqhvRqi/FWkzoo5uUsaF9vbSYNJtr6b+c5YHcpBt8Bn8qowC0W8c
         kM0Q==
X-Gm-Message-State: AOAM530vnUm0vWtrlz4niQt8UGLM3T6f6mmyADzSgQo0Xma5E9NpD605
        YapcXEW1SJtAnbkj0B0FrRolEKYlkVk=
X-Google-Smtp-Source: ABdhPJwcuXox1vmUNyRd53k6Z7pFMA0dWOHcmaoIlFRnWNW1Ncj6oTw1IbwyX6chgFNOMTCOj25bRg==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr4487594wmc.73.1625741597473;
        Thu, 08 Jul 2021 03:53:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15sm1838920wrp.29.2021.07.08.03.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 03:53:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] fetch: fix segfault, missing docs in --negotiate-only
Date:   Thu,  8 Jul 2021 12:53:12 +0200
Message-Id: <cover-0.3-00000000000-20210708T105034Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a segfault in recent code, per v1's:
https://lore.kernel.org/git/cover-0.3-00000000000-20210630T163329Z-avarab@gmail.com/

Fixes a stray "cat err" that snuck out of the lab and into the test,
spotted by Jonathan Tan.

Junio: You picked this up as ab/fetch-negotiate-segv-fix and it's
marked as "Will merge to 'next'", but it's not there yet. Hopefully
you'll see this before it's merged down. Sorry about the delay.

Ævar Arnfjörð Bjarmason (3):
  send-pack.c: move "no refs in common" abort earlier
  fetch: document the --negotiate-only option
  fetch: fix segfault in --negotiate-only without --negotiation-tip=*

 Documentation/config/fetch.txt  |  3 ++-
 Documentation/fetch-options.txt | 13 +++++++++++--
 builtin/fetch.c                 |  3 +++
 send-pack.c                     | 11 ++++++-----
 t/t5702-protocol-v2.sh          | 16 ++++++++++++++++
 5 files changed, 38 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  1cd8b98d3d6 = 1:  10375a6484e send-pack.c: move "no refs in common" abort earlier
2:  7ff734ed70a = 2:  f86f4fc0e6f fetch: document the --negotiate-only option
3:  38930024d95 ! 3:  491d72c35a0 fetch: fix segfault in --negotiate-only without --negotiation-tip=*
    @@ t/t5702-protocol-v2.sh: setup_negotiate_only () {
     +	test_must_fail git -c protocol.version=2 -C client fetch \
     +		--negotiate-only \
     +		origin 2>err.actual &&
    -+	cat err &&
     +	test_cmp err.expect err.actual
     +'
     +
-- 
2.32.0.636.g43e71d69cff

