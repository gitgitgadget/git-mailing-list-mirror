Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB7C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F336064DF1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 01:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhA2B0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 20:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2B0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 20:26:14 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D231FC061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:25:33 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id v126so7351943qkd.11
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 17:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z9GWqPD7wFgBZ3/ICP9wDwN/OH3DhwXnGf3hYHbrALU=;
        b=l3Es5Pqejx/YGAQaupuQFLhQPRorulED6FOR8LPmWBxPTyJvmKRioZaETB/EuIMLWX
         RfbnMyb3eDK+hGX6flAWKJYpq7Hk9E8tDxvuBy+fFYEY6sslSyG20VRSZy6r2EN8CpA1
         mLr4YX/bmoKPaw0bQpiakQzIX6cOG13Lzq80g1XZtoqGuAz1A+V7kpysNxKseUrxCzZf
         dJmTjohUw38J9nb0bOeKobPsxbj6xflHTHphFsG1XTOmh4yLirTpLPXKcq/8QcDW9csk
         tCSGpanJsvrXkLmyuCLWsaQkBiua/T6QZJH2X1YvkYcxB8V/FZdkhkwCy+GQ6uj7mphq
         ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z9GWqPD7wFgBZ3/ICP9wDwN/OH3DhwXnGf3hYHbrALU=;
        b=TcIW7umtWds2nNwX02ywNqxVuFUfqBnwRjHp2vthwCILLd+wCJlEJhn3eUz1Exml4w
         Y/b6XkZ6hkLm/jVexwVqdxRjk4d5G+8vebBBkfPKeiuXU6740G3ldky1tfn1+zmX1Z00
         lFGbPJAENSHMMet8rAULQSkcAofcFYaDIGOrV0q9TOPKupx6jGxM6eM4/BV9ReAyiOxk
         XW1mBzmOoVweKhS2f+j4eWv8vEXb0Hr0U7CERpuW/khpdVqQscljM1MbDcufayBp1FUp
         flL3DkJU0x+XUhAPQ39yGj74iPNc5EjJrDvOVTD3yIKn3vdFbqw1hOGWW4804s+TlthH
         5c4A==
X-Gm-Message-State: AOAM530Nr2evYQHBsgmqCM9IZCr/ifStOsG+KcYe9OcCSGfZtFWdK7Y9
        1lErUqZQnPEU9HaEUKO5nMqLRQ==
X-Google-Smtp-Source: ABdhPJw41ljfaahzMHNi4SzQowcwdEJb8SbgiysLgNTVJwECDhDk+xReFwe5OtqaQW5WN8VYbY4aCg==
X-Received: by 2002:a37:57c7:: with SMTP id l190mr2084874qkb.487.1611883533090;
        Thu, 28 Jan 2021 17:25:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5d6b:9c45:5e60:e7b4])
        by smtp.gmail.com with ESMTPSA id 133sm4841040qkg.38.2021.01.28.17.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 17:25:32 -0800 (PST)
Date:   Thu, 28 Jan 2021 20:25:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v3 09/10] pack-revindex: ensure that on-disk reverse
 indexes are given precedence
Message-ID: <YBNkCsshbCkyC0w4@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <a66d2f9f7c20eeb813656e66b3ad9d42f2eecf34.1611617820.git.me@ttaylorr.com>
 <YBNcjmn5Jm/EmHwS@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNcjmn5Jm/EmHwS@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:53:34PM -0500, Jeff King wrote:
> On Mon, Jan 25, 2021 at 06:37:46PM -0500, Taylor Blau wrote:
>
> > When an on-disk reverse index exists, there is no need to generate one
> > in memory. In fact, doing so can be slow, and require large amounts of
> > the heap.
> >
> > Let's make sure that we treat the on-disk reverse index with precedence
> > (i.e., that when it exists, we don't bother trying to generate an
> > equivalent one in memory) by teaching Git how to conditionally die()
> > when generating a reverse index in memory.
> >
> > Then, add a test to ensure that when (a) an on-disk reverse index
> > exists, and (b) when setting GIT_TEST_REV_INDEX_DIE_IN_MEMORY, that we
> > do not die, implying that we read from the on-disk one.
>
> I don't love this kind of hackery, as it will have to live forever if we
> want to keep testing this feature. But I also don't know how else to
> tell in the regular test suite that we are avoiding the slow path.
>
> Would it be enough to instead add a t/perf test which checks the speed
> of:
>
>   echo HEAD | git cat-file --batch-check='%(objectsize:disk)'
>
> ? I hate relying on the perf suite, because it gets run way less often
> (and requires a lot of squinting to interpret the results). But it
> wouldn't require any extra code the binary, as it's observing the actual
> user-visible thing we care about: speed.
>
> (I guess we care as much or more about peak heap usage, but measuring
> that is a whole other can of worms).

Yeah, I think that the thing we care most about is peak RSS, but I agree
that I don't really want to wade into figuring out how to measure that
reliably during test time (I think there is a separate and less relevant
argument about whether that is something that we should be testing or
not).

But, getting back to your original comment, I think that I actually
prefer to have the GIT_TEST_XYZ_DIE stuff in the binary than I do
relying on the perf suite to catch stuff like this.

I understand your concern about the binary size. I guess you could
#ifdef this out and only build it in during the test suite, but then
you're testing a different binary, and so that calls into question the
integrity of the test suite itself, etc. etc.

So, I guess that's all to say that I while I do find this to be hack-y
and gross, I don't think that it's all that bad when you compare it to
the alternatives.

As usual, I'm happy to change it if you feel strongly that it should be
changed.

> -Peff

Thanks,
Taylor
