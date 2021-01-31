Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE0C433E0
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F72564E1F
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhAaUDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhAaTs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 14:48:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC40C061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 09:21:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so20620731ejf.11
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 09:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EAD1dZBVvjZbcalFpp3gkSz8vp/ZT2zPCwthb9iATes=;
        b=iaoF+Eh6fmHi6uJuVfSfZWLYUINug82Q5UXgmHhzb+ouFQr//j7wRecOxE9F/tazDv
         XiADqCXbNnz2w1U6z+w1Ooxmjo9Gcwf+gDmScarZfIHp+LgjekfLjBGzJJfRHNvmwV9e
         xDkM0NKZdp9E4tzlGZRXrF7/wLZZbcUFpq27T/yhZueMkPmrFcB7knnPcIvvcHO6Lfj6
         tPT0rmi6FsAvbkx5zMEz93HELigp+I4sVUgZMfjUqQeB/xhZDV3t/rKAmu5HaAWtXLqh
         wYw6PTi9wIvh+mTvchaytwxxNUMfbuZlthHY71LqCflOkUF9aH9Ld9Bczz9t1LTdKJYC
         OG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EAD1dZBVvjZbcalFpp3gkSz8vp/ZT2zPCwthb9iATes=;
        b=epL06SBGIgYfyB8f3BDCTLXYoIT/52J9+eBeNLuvQhPnRWYv9V27SuebH1hh+EKJQz
         SF1sZ0eEwXqiS3ZD+YDkJgLNBBp5GyZXrsSYuuH2brXigOWlF+Y+QlrbiVsCNKHl/+N1
         eqcqn4VavoYz2BwiftmQbH6Qm7BRDj2Sm0Z+H3Faj4CjVaj0wsKxgvT7Am5Irhov7FRN
         1c99PUrNK25CZfNMteUeagBaF9bM6/zqj/w3YrtEFVC8CphMd2bB9VwPgbfcfIioNiYG
         L/Q4MQ/gjOOVxz9rb56U1RHOHfhL27j08moPq/HMBHteZyw5Tw3QGpmj26sIrOW9Bn+D
         NUHg==
X-Gm-Message-State: AOAM531RjEUfjluUw7MN+gdlPzl5GKCqS13+TZSZ0pkaDsQ2MTWPWvOC
        7eIZT2jkPGwMuqix42wq138=
X-Google-Smtp-Source: ABdhPJzIPJQim0rEZ6cF5RoS47B07boEAGu2BnjpdEJwGOW+M4qnE6NOuP/JlIPA36MnLi4YHYG/Jg==
X-Received: by 2002:a17:907:f81:: with SMTP id kb1mr14221012ejc.412.1612113674909;
        Sun, 31 Jan 2021 09:21:14 -0800 (PST)
Received: from szeder.dev (84-236-109-63.pool.digikabel.hu. [84.236.109.63])
        by smtp.gmail.com with ESMTPSA id j2sm2127870ejx.99.2021.01.31.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:21:14 -0800 (PST)
Date:   Sun, 31 Jan 2021 18:21:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
Message-ID: <20210131172107.GA2091@szeder.dev>
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsg6infev.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 04:00:56PM -0800, Junio C Hamano wrote:
> [Stalled]
> 
> * sg/t7800-difftool-robustify (2021-01-09) 1 commit
>  - t7800-difftool: don't accidentally match tmp dirs
> 
>  Test fix.
> 
>  Not working on Windows.
>  cf. https://github.com/git/git/runs/1660588243?check_suite_focus=true#step:7:4186

I think v2 of this patch fixed the test failure on Windows.

