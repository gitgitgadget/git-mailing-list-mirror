Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FDC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669DD652AB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCHSGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHSFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:05:48 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1613C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 10:05:48 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 2so5055107qvd.0
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5ENKnWMcgS+MzZ92Xjf/zXYEhg9yLhyh8UPEyVuNNs=;
        b=eOhKcOj6GD6PZ9i04R2F1T9MmH2jcj7ZWdGjlv6bpcY0X5dqXuu7PU7r8kgAAr1yKO
         Si90eba/ttGvTcKW3nALgixttFloTXxQQJT9JKrlUmb4kTsiyCr9FjFUMVpg3j24ecJt
         wDSeDGqRUU8LcKijj4xS02NDnTUpj4k+R8g7K1EDf6ORb4vlCI22x49CpwXw13CquMPH
         rZpG4ZmdLsA3Gyvdr3YDLGAd4L0vslf+KxFt2WIagXCZ/N74zyZISsz07nB9bXIXmo0V
         uJlzvx2G7I45jt64xEuXJ8HJEjivFaLlUmHbuYzdCQupfVarPnaJkm0QDg2hsOBFcERr
         uAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5ENKnWMcgS+MzZ92Xjf/zXYEhg9yLhyh8UPEyVuNNs=;
        b=fdVUg0SOD760f2UGqDXmPDObXb/mu4kmhpvJFkPqw7AiYHNqj0wge9kzK+vZfbls+o
         UdfHcDT2JKYEqH+pPUVVmk8NVENO0Lr5eqIq8FXVU2K8RnIXAuB0AcYRSJtp6pYCg6aM
         y+eLEemPP0fItp9MZ1w7eHb3QQ/s9Wen27ACwM1m+v6Sugw/uKUGB/uFM+wwFQ+/Usf8
         aG+QrEkNxz5kZNd1HX2SbNQP3Jbcmg03fAGBu2jWX85x6YkgGoOwjSvpnUYXTl4tR8eL
         xKAojhV53iOyJphy3Yz8nlx1ROZcovTGcuiRDb4N50jCKbdV7vJqWbVWN7Ai4vx914sG
         RSoA==
X-Gm-Message-State: AOAM531Q9/zgRQG4uw2QMBQNQ/dtyRK1zEVzQ5NS83wMBK59wdywHb31
        FoU8W6tev0Z35xrVsAGnRBsrHA==
X-Google-Smtp-Source: ABdhPJyxuqwucrZTWiu/zNLNLxcISR4rwhlyFGywuGlYUOyHf65jYCr//SajmgSk3u3uFk4zrqIZ1A==
X-Received: by 2002:a0c:e58e:: with SMTP id t14mr5633qvm.28.1615226747771;
        Mon, 08 Mar 2021 10:05:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d16b:b0bc:c9fc:2720])
        by smtp.gmail.com with ESMTPSA id r190sm8275285qke.26.2021.03.08.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:05:47 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Mon, 8 Mar 2021 13:05:46 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     HG King via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, HG King <hgmaxwellking@gmail.com>
Subject: Re: [PATCH] fix: added new BANNED_EXPL macro for better error
 messages, new parameter
Message-ID: <YEZnaeJVt8Rk6duv@nand.local>
References: <pull.896.git.1614991897210.gitgitgadget@gmail.com>
 <xmqq7dmi8zym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dmi8zym.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 07, 2021 at 12:34:57PM -0800, Junio C Hamano wrote:
> "HG King via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  #undef strcpy
> > -#define strcpy(x,y) BANNED(strcpy)
> > +#define strcpy(x,y) BANNED_EXPL(strcpy, buffer_overflow_risk)
>
> That does not help programmers that much (the above does not say
> what to use instead, for example), and the mechanism inherently
> does not give you sufficient space to give helpful guidance.

Trying to cram information like "why is this function unsafe?" and "what
function should I use instead?" seems ill-fitted to trying to a macro
which is supposed to have a field for each.

I'm certainly not opposed to making these banned functions clearer, but
I do not think that this is the way to do it.

> Adding a comment around each of these definition may be OK.  Upon
> seeing foo_is_a_banned_function, somebody new to the codebase would
> look for where it is banned, and find the above, so that is a good
> place to give guidance.

Perhaps, but all of this information is already covered accurately in
the patches that introduced each banned function. So I'm not sure that I
even agree that this information is difficult to discover to begin with,
but I may be biased.

Thanks,
Taylor
