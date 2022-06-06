Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA578C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 22:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiFFW5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiFFW5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 18:57:18 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F055B4
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 15:57:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id j8so8702744qtn.13
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 15:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SuA6xizpn4i5KjSjNzsbvaDf1ERq0xi+1ILDggRmXJg=;
        b=ZthEyV8ISU99gRZd0Jr2OYa5WEDHuWTR+v19iDbe5ZU3wyt/WMIlP9EjaE2gQoaXEM
         bEXTaCCj+A2NwsDyIooSUI0IZJC4Q3PlKXu2xDdD+Yk//PgDB8IY2l6OSjcjvZs/I6mu
         miGaKZcDietUx4qZ/b0qyq88bhpE0iqSya33VSWqvrAyTCjIPbwobcSsHZ27+ogmPkf3
         fEbpJYtELTdmEzN4uYS5lcYR0lxH5k1TR/y0uUWmvhxFzX1tEqm5/TAJJJdDkl3Wpf5u
         tU8jnGjslgx+THuFKhXjlJYOh9Z/rTEbuNhzsIcsLxNy6aGZuS4HYX7C5zKjxVY39jP9
         22GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SuA6xizpn4i5KjSjNzsbvaDf1ERq0xi+1ILDggRmXJg=;
        b=1GbeJr1J/oOQhdKv1mO2pxdzt4J3w9SMcVBinT7RhNDKkRGapceqBFgDjdwxvUCD+E
         ota9TuOZfXHDNAr8jpR/z0RhSSUsgIBdAkBQN1zu4KxRnVOGmtom2vzy6W+DiFKhqkWN
         +YWFKjJq4TKbTQP2vRjNyx3pTn2tVItcXuW9UtOylK5PJP6YB1h+F4C9m+6tCw7mJa25
         F07KQWfIQbEyzuAf7whIQX5fROjdjM48PceC4lQ6ZhyoOTIF+3M+5QFM0yqe1/9L3Yyt
         2p5XddUdr5bdAmzc1eRFQKWoIsV9FPW6/MRk/NzPvU1jmKV/UDROaeRjpuz5ND2TP0nT
         yNBg==
X-Gm-Message-State: AOAM530ULwcWtf872SGJxUhKTixnqmoTntpt2yc74aUYtha4lgKs1RO2
        0689Arm7uS8R19rUcnij85Q8dw==
X-Google-Smtp-Source: ABdhPJxRd8RlNTukKzBmMOXh2+edrmyBstjke/iP6UOUUhkC2otGoUs6ZYk1hjrGRbsX8CPsCBce7A==
X-Received: by 2002:ac8:5c47:0:b0:302:bc9:6001 with SMTP id j7-20020ac85c47000000b003020bc96001mr20614447qtj.246.1654556230687;
        Mon, 06 Jun 2022 15:57:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f32-20020a05622a1a2000b00301a475d8c8sm11989367qtb.75.2022.06.06.15.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 15:57:10 -0700 (PDT)
Date:   Mon, 6 Jun 2022 18:57:09 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
Message-ID: <Yp6GRccc5UElNrZb@nand.local>
References: <cover.1654552560.git.me@ttaylorr.com>
 <xmqqo7z54d7g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo7z54d7g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 06, 2022 at 03:52:19PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > This short patch series adds support for a new `--count` argument for limiting
> > the output of `show-ref` (à-la the `for-each-ref` option by the same name).
>
> It makes me wonder why we limit this to show-ref.
>
>     $ git --pipe-to-head-N=3 any-command args...
>
> IOW, having to add an option like this feels absurd.

I don't disagree. But `--pipe-to-head-N=3` feels like too broad a
stroke. This series at least imitates `for-each-ref`'s `--count`
option, which makes it feel acceptable to me (if not a little silly).

> > This is useful in contexts where a caller wants to avoid enumerating more
> > references than necessary (e.g., they only care whether a tag exists, but not
> > how many or what they are called) but doesn't have control of the output stream
> > (e.g., they are in Ruby and can't pipe the output to `head -n 1`).
>
> Are you saying that Ruby is incapable of run a command line like
>
>    av[0] = "sh"
>    av[1] = "-c"
>    av[2] = "git show-ref blah | head -n 1"
>    av[3] = NULL

No, Ruby is perfectly capable of doing that. But it involves an extra
process (two, if `head` isn't a shell builtin) and the additional
overhead of creating a pipe and passing data through it instead of
writing directly to stdout.

That isn't a complete show-stopper in most cases, but in
ultra-latency-sensitive applications like GitHub is using show-ref for,
being able to shave an extra process or so off matters.

If you're strongly opposed to having `show-ref` match `for-each-ref`'s
`--count` option, I won't be too sad. But I'm not in a huge rush to
replace this series with `git --pipe-to-head-N=<n>` either, FWIW.

Thanks,
Taylor
