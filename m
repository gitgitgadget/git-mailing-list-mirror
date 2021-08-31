Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598EFC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E5661051
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 18:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhHaSuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbhHaSt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 14:49:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A875C061764
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:49:01 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id n24so26361463ion.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=puTOtmfh+BA5wlaocV66eUfmACQGD3K5lonciak7SuA=;
        b=uoAlzWrcLVeONyZdNCjRMHVruWZVMN2RTQbQ9e9J0yxNGgY/+vG05EH/uqzXqHtH6v
         64Xf1/l76bnDd+wfj0rck1sOWitmg6Ib05zOoDbfX+rdl/nRBK6XTVXlo4j/hPRJq/e9
         IOQVksPhtux9VzZ5ppohnX65odozDDEu8RUlgxs/9ZMrsnBXiXMiCzN9HVTo/VAd4vna
         naAGTH2isMmOAZijUxLsPHyFO77OsnzWoN/B+O5sUKZCNXevCdM/0C4nEYYWY5HboYx+
         bg7OxkIJ0RgWXx1QjayBPUgmHyaAy8F68qsjrvn3lPFmVKoBTWO40sS3jBdnT098X/1d
         NFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=puTOtmfh+BA5wlaocV66eUfmACQGD3K5lonciak7SuA=;
        b=bDUvo9DT/Nk0S3nJr38ZN+JCOf4/UY+XMZvtkVHNegAY9sRJ38o7PkSMtQwutRS8Gm
         QbtKdIwKJP8SRQFA8ssiqaOHBH95d00zAepwTFOR44Moa9ADouJu7avv6rD81rubC+Ml
         5MJWYoG6I6ve0CQBygeIuTXUh6PLqd2QJxjWdbxdrS5xL9y41f1D1sysoYxjFAgJcH5s
         zCGA/ODCKGYIQoN+cppq6s8yukAzV3IBRgzLv/4GMV/8OP7SLEU/5fAQF/Ii1Vriu2An
         uTvn1G6t6eQ5l3TNdFX6L5wbolgqWP2dfqTvaFfUE+O1vtGtSn3WHNWEmUknSZar6lJQ
         QhKg==
X-Gm-Message-State: AOAM532H8+6IKmoN450aI+MI/9AgXQXpY+hHTXJrxJV8i6PZ5XMgg1t+
        3+me/o0+wh4vs+4aESVYdRsyNA==
X-Google-Smtp-Source: ABdhPJyNb/yyzpXP9Y3H5NpCd3aNWsEVjNZdgDJ1SCLto6cCUANh3WyrNowBfg5uanHWEvxSNJqN4g==
X-Received: by 2002:a05:6638:3805:: with SMTP id i5mr4201227jav.72.1630435740988;
        Tue, 31 Aug 2021 11:49:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r18sm10561110ioa.13.2021.08.31.11.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:49:00 -0700 (PDT)
Date:   Tue, 31 Aug 2021 14:48:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
Message-ID: <YS55m5touOZdzZ7g@nand.local>
References: <xmqq4kb797xc.fsf@gitster.g>
 <YSwhNxqAS8JajA7p@nand.local>
 <xmqqfsur7otx.fsf@gitster.g>
 <YSwpsp/hQsPFnj+I@nand.local>
 <YS1XOMtj94BcI9HM@camp.crustytoothpaste.net>
 <xmqqmtoy1s9s.fsf@gitster.g>
 <YS1croR3etCfMQhR@nand.local>
 <xmqqmtoxwpad.fsf@gitster.g>
 <YS5bWMcXbODi+KmS@nand.local>
 <xmqq8s0hv795.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8s0hv795.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 10:44:38AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > After (the rerolled version of) this series, we'll be in a state where:
> >
> >   - `git multi-pack-index` will not run when outside of a Git
> >     repository.
> >   - The `--object-dir` argument will only recognize object directories
> >     belonging to an alternate of the current repository.
> >   - Using `--object-dir` to point to a repository which uses a
> >     different hash than the repository in the current working directory
> >     will continue to not work (as was the case before this series).
>
> Hmph, re-reading the document for midx:
>
>     --object-dir=<dir>::
>             Use given directory for the location of Git objects. We check
>             `<dir>/packs/multi-pack-index` for the current MIDX file, and
>             `<dir>/packs` for the pack-files to index.
>
> why does it matter if we are in a repository in the first place?
> It's not like we combine the objects from the specified object dir
> and our local object store (if that were the case, these two object
> stores must be compatible).

It shouldn't matter, but the use-case is described in [1] by Stolee.  He
explains it in detail, but I do think we have to live with
`--object-dir` in one way or another. He does say it'd be OK to only
be able to invoke it from within a repository, and to only be able to
reference alternates, though.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/d23bca9b-9da2-984f-065c-6cf60a80ddef@gmail.com/
