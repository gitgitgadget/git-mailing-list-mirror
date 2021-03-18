Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187FCC433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B9F64EFD
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 20:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhCRUuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRUuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 16:50:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93813C06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 13:50:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u5so6096581ejn.8
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LfxOWDlzxSjusfoAoFb4p3oD6BEpgWrp9J7P1sI24do=;
        b=ifBNwGxb8WqU8T8qTIYHhsnzIQ4RE9a+ba2TbRSUBO5yvxcU/4yHuHs0S90Zgz4sNe
         1Mvbj9/R7L185MbMK38jOukW6gADKe/h5vXFOtKfNEaOQ/8bu3on+8VNfmFtW4SalXW3
         iqXdZkRA/8Wy4U0iMhpX5at3KnbgDFjtZSC7y1ZYbWap8GlxdaxeWs69K4yKrqSVdRdR
         j4lTaOlsuUZ7tjdCS9i0MBk+kApUU5FQpVb8KgS6eyOsdjgez/ztNs6m5XvFTuUINEO5
         /Z4rfbRD0TpiCBGOWWy84wt+TLErcuEwLoL83teMz3m8+X0qFaqlMfGpjafEswL/Zc/I
         54rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LfxOWDlzxSjusfoAoFb4p3oD6BEpgWrp9J7P1sI24do=;
        b=GGNgrbdfxpb1wlAzXhPKF+r7dN0i+G8vY3fzos5TIJ4mjvcpNkqchkni0V5IDLdVoG
         XN7hW3XJ4Y1lOdAjdvMKcQqla5hfZ8QbpOVaYuTBgj/8op9cNpIWZjJi3ciNMQufIcdt
         ahFk2HZ+YIgQcp146fDFtXOHFpWoOUj7VoaLGa6Rfr+KH4ctgcg3pqkHPup792jvKUr7
         H5PFqjco9oKvXQc7vq/dYkpl1U0GA38vTkDBYv3hTt+xwIPrD9usg2fY3GYIRCisGOPw
         090wnYfwMvZGAU0vQwsiTawVZaxdrTCkcHPbz4nF1xShYo08+aJG5bLa/oNAMWaFlXcK
         QOMQ==
X-Gm-Message-State: AOAM530PNxkVbeLrRXGkswO92K+fPKFSbQioQ0/jRfqUY44cSPRWqwim
        rKj4pVG0SqMMSPvmfyRtsmoqWjRihBU=
X-Google-Smtp-Source: ABdhPJwjQA0mbmHmzke9OPyNja48ZE2DzQ3zo/U9zuHFNVOkkxVFbFQXauC2lugltNnnoQH0EvgEaQ==
X-Received: by 2002:a17:907:7355:: with SMTP id dq21mr464322ejc.159.1616100602413;
        Thu, 18 Mar 2021 13:50:02 -0700 (PDT)
Received: from szeder.dev (94-21-58-21.pool.digikabel.hu. [94.21.58.21])
        by smtp.gmail.com with ESMTPSA id hd8sm2411552ejc.92.2021.03.18.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:50:01 -0700 (PDT)
Date:   Thu, 18 Mar 2021 21:49:57 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/4] Makefile/coccicheck: use
 --include-headers-for-types
Message-ID: <20210318204957.GA1938@szeder.dev>
References: <20210305170724.23859-5-avarab@gmail.com>
 <20210306192525.15197-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210306192525.15197-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 06, 2021 at 08:25:25PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change the recently added --no-includes out for --all-includes
> --include-headers-for-types.
> 
> When I moved from --all-includes to --no-includes I missed that rules
> that use "type T" such as the one added dbc540c7a58 (add QSORT,
> 2016-09-29) won't work as intended. See [1] for a report of that.
> 
> So let's move back to --all-includes to potentially scour our includes
> for definitions, but supply --include-headers-for-types so we won't
> racily emit duplicate hunks. See [2] for more discussion about that
> issue.
> 
> This undoes most of the optimization we gained with --no-includes,
> using a very basic benchmark script [3] I get these results:
> 
>  * ~1m50s: --all-includes (before my recent patches)
>    38 files changed, 74 insertions(+), 78 deletions(-)
>  * ~55s:   --no-includes
>    27 files changed, 55 insertions(+), 57 deletions(-)
>  * ~1m35s: --all-includes --include-headers-for-types
>    38 files changed, 74 insertions(+), 78 deletions(-)
>  * ~1m20s: --local-includes --include-headers-for-types
>    36 files changed, 70 insertions(+), 72 deletions(-)
>  * ~1m20s: --local-includes --include-headers-for-types --no-loops
>    36 files changed, 70 insertions(+), 72 deletions(-)

Where do these changes come from?  I can't reproduce it running your
script below, and get empty contrib/coccinelle/*.patch files for each
sets of options.

> And only the "--all-includes --include-headers-for-types" gets the
> same results as the previous "--all-includes", even with
> "--local-includes" we miss out on some definitions.
> 
> 1. https://lore.kernel.org/git/3aac381e-2ce9-e35e-498c-9c26df235aed@web.de/
> 2. https://lore.kernel.org/git/YENdUMLTM+cerfqJ@coredump.intra.peff.net/
> 3.
>    for flags in \
>        '--all-includes' \
>        '--no-includes' \
>        '--all-includes --include-headers-for-types' \
>        '--local-includes --include-headers-for-types' \
>        '--local-includes --include-headers-for-types --no-loops'
>    do
>    	git reset --hard &&
>            git clean -dxfq contrib/
>    	time make -j8 coccicheck SPATCH_FLAGS="$flags --patch ." SPATCH_XARGS="xargs -P 8 -n 16" 2>&1 | grep -v SPATCH
>    	cat contrib/coccinelle/*.patch | git apply
>    	git --no-pager diff --shortstat
>    	git --no-pager diff | git patch-id
>    done
