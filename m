Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507EBC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCE3608FE
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhKHUo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhKHUoz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:44:55 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA26C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 12:42:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id e144so20492029iof.3
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KcWgeIxRrdQC1uT0ybzinF4BJnyZ2iBtE3neqLhmH44=;
        b=JnIF59u+sjikEPeRnb5tVdMPlXErOrwkx+IS9cs1Nbk/gG9gsZo1Y8xSyeOVoi061G
         p9PlsUrVftoGj69RFFWhh6W6/Mx72IIJgFBK19g2Sc5Fejc2lsdvH/Cqq5WZFkrqS5Gv
         bKBUO5dFyo7QLKodMlz76n6LKGiMUiDFkLz3tdKSW7s7puZ/ymDhSn4OZBAsBtTT0TSE
         wWtgB3W5MmPmAgvlyW0eDBRbO6bBhr/Vj9fAyFhzpdOgI7KdZPsPplGIHiIlWL4HIZXR
         RWwZdpkfo3puz0qQMF+XfdL7dx/5LrQkMu1FZyz1HYvA5XNNJqxenf6kclMCRtGwmmjj
         TuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KcWgeIxRrdQC1uT0ybzinF4BJnyZ2iBtE3neqLhmH44=;
        b=GhEx5jzXILa7ccDbhEYZJK9dgoTrfV3E7CI51sIjUVeRqt+LohSm1E4Jp+MFxQWEwp
         U/hKjkegzYcn0EsQGYMSj2O8aLwc/+97+kOYsFEhFTF/4m342st9y6dJo2Wv+SljwDB1
         Qkh5zQouozwRVlEO0xM75iRA7E7KPazWmZ7ZDqMwHFHQ3D2emY00AceBfZeC8V3PSohn
         j80ExqxHtywgrBlzsoidNyMvFeM/67NdupGINhc540B9/YlHXznMVYIurhOI6pGoH+tA
         +Pv5iaujcj2dNH8+aY8+yjQSzZeNGlvOPJOSKGn7l94QajMJq3keOOZi9MU6HdL9PE8R
         qxAQ==
X-Gm-Message-State: AOAM532NILD9a0X69u1QSaDRaWMtUSaDn385ifRGju5vA9qWxtgycbDG
        lYfgaWymCVo9xnrZKCjlad6ZkWu30nBQfB2K
X-Google-Smtp-Source: ABdhPJx1OpxITCcEC7nE9Q64NAtGKEMhtpuL4VcgvuhPzICcZ4u1yaKNP0CUYm6MbWv8e0mCj8KAXg==
X-Received: by 2002:a05:6638:410a:: with SMTP id ay10mr1490737jab.120.1636404130044;
        Mon, 08 Nov 2021 12:42:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a9sm3590543ilp.60.2021.11.08.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:42:09 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:42:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 3/8] grep: remove unused "prefix_length" member
Message-ID: <YYmLoTGTKO3VbSXu@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-3.8-3338cc95b81-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.8-3338cc95b81-20211106T210711Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 10:10:49PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Remove the "prefix_length" member, which we compute with a strlen() on
> the "prefix" argument to grep_init(), but whose strlen() hasn't been
> used since 493b7a08d80 (grep: accept relative paths outside current
> working directory, 2009-09-05).

OK, so now we *are* relying on the assumption that prefix is either NULL
or a non-empty string.

I assume that the last patch was along the lines of "let's clean up this
redundant check before calling strlen()" and "prepare to not call
strlen() at all and just check the string itself for NULL". To be
honest, I imagine that it would have been much easier to review if these
two had been squashed into one, since I was a little surprised to see
the line I had just been commenting on in the previous patch removed.

Perhaps I should have looked a little further in the series before
commenting there, but I think it would have been even easier for
reviewers to see these two patches together.

> When this code was added in 0d042fecf2f (git-grep: show pathnames
> relative to the current directory, 2006-08-11) we used the length, but
> since 493b7a08d80 we haven't used it for anything except a boolean
> check that we could have done on the "prefix" member itself.
>
> Before a preceding commit we also used to guard the strlen() with
> "prefix && *prefix", but as that commit notes the RHS of that && chain
> was also redundant.

Everything in this patch looks fine to me, assuming that prefix is
indeed always NULL or non-empty (which I haven't verified myself).

Thanks,
Taylor
