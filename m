Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C6DCD37A9
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 20:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjIOU3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjIOU3X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 16:29:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48CDA8
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 13:29:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so2928814a12.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694809756; x=1695414556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VCdC+Utbdot2G4VfMqsuOJ0pNYpiXJhbDA2AaH+JqbE=;
        b=OC+PxIBwqebRU0JtpediYgTOgCfkMxMca+/zXclmYB7AfwZfLS/+z1R71D+6m2ij1D
         Dq8jiejPMFfxQ4CYSdyB5FR9HyqzEQbUSVwwEUAz324x4ZwYTl1Wo+XrmT/ErbrCHDAb
         BPQKo4boGLAVCq9EFSqfkqL2XVyWZNKJ12XO5wuzx1sRyABg1pBhlayuiEbSJCp9vQnl
         G5Ccbby7ZRIj83nW1ku6DNesW7A+xkwQ8U5ggOg2yQRlcOJqkyR/ZkGybscek0U1xvQR
         400frjSt5Y7Uc6PxE0Ppbt/+ApbI1PmwMZXcrNZwnZdvyNLcF/FJ1OGP7CI5YMfjr2CV
         V+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694809756; x=1695414556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCdC+Utbdot2G4VfMqsuOJ0pNYpiXJhbDA2AaH+JqbE=;
        b=ouRyuUbm4PlKZbGwkAdvWLPzNIlslnpwdi2Z4BqvkB6wtuoPvW3WfIU2cXWjCLs2Yl
         4CBZt2UkV9z8D+XvNJJ79fbpirhy0BrJKiyCjjN9LpX5v3Ok0VAsLPjx7Z5yJ2jdad29
         Z+a5450BLoLtjQB3irBXYpigMbUQFPJIuV+jVfB7OjNHIBkZemwc+SO5PBRepQ4qFgKg
         emm5yHPaxbn4kyozeGPVRE3HSodw7xQoLwqwDJp/14l2/91FOFfuepW1+8XaprGsNo75
         R/9fvcgDj9R84axgVb9pPFJFoWEFO7mqjrN0mUdXu2VVbpaxJ5eHVahGJLVabvYjfwEg
         wc5g==
X-Gm-Message-State: AOJu0YzH0N7TulL6IBxcRDYvBX7Uis/iPzazl7QU6HpnUFoFFDCMOEj1
        iVtrfWjaQz5R0sBVwcBe8arGM3HF470=
X-Google-Smtp-Source: AGHT+IFPiZy6A8GhEx87xFZYVsW4dIWucvHXz7iiY2h7kW2pj1rJhTdGtySvt0D00Wrkj2tHDJhM4Q==
X-Received: by 2002:a17:906:8441:b0:9a4:dd49:da3e with SMTP id e1-20020a170906844100b009a4dd49da3emr2073107ejy.68.1694809755916;
        Fri, 15 Sep 2023 13:29:15 -0700 (PDT)
Received: from localhost (94-21-23-29.pool.digikabel.hu. [94.21.23.29])
        by smtp.gmail.com with ESMTPSA id cw17-20020a170906c79100b009a1a5a7ebacsm2820874ejb.201.2023.09.15.13.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:29:14 -0700 (PDT)
Date:   Fri, 15 Sep 2023 22:29:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, derrickstolee@github.com
Subject: Re: [RFC PATCH] Not computing changed path filter for root commits
Message-ID: <20230915202912.GA8705@szeder.dev>
References: <20230911223157.446269-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911223157.446269-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 03:31:56PM -0700, Jonathan Tan wrote:
> SZEDER Gábor suggested [2] that we change the revision walk to read
> changed path filters also for root commits, but I don't think that's
> possible - we have to tie reading changed path filters to when we read
> trees, and right now, we don't seem to read trees when evaluating root
> commits (rev_compare_tree() in revision.c is in the only code path that
> uses changed path filters, and it itself is only called per-parent and
> thus not called for root commits).

When encountering a root commit during a pathspec-limited revision
walk we call rev_same_tree_as_empty() instead of rev_compare_tree().
All that's missing there is checking the Bloom filter and accounting
for false positives.

