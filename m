Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D618C433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DFE64DD9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhA1VNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA1VNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 16:13:33 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0000C061756
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 13:12:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id r77so6752457qka.12
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWy8zecXMekruYV+7Epy0cntJ8E9FTkab+tH75f7vi0=;
        b=FSAMqoE/y9uzD+GALy85Cm0mKv037uO4bmV99gc6Tw2a0j6TSrYRTBKniYrqzvhqyR
         r1K2a/4m5NRhyED8boyE73thaQyHN6guulAfHBrfD+EVISM6G4vv0611+eEAuf0E92vI
         7zFuj0y1PxUJvVCbpJxjEr6N4k3vGvlFdKeQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWy8zecXMekruYV+7Epy0cntJ8E9FTkab+tH75f7vi0=;
        b=kgybxdLUM1iiM1iI/hQvF7becr1HdGI+76BAzAiStiqgOUMX82ft8NRMBX6u4PEJCy
         HGJvjViDrBNGub5+bQErMC8bpAX67bJwln4felONujDGWtd7Z6oLJGb6KCIPEEP+lXee
         e1w7ogL1L+oo3Syi6ePr+0zBRZgpC27qVrWZtmANaVEQ0SGMRWBvHfByjrtBeM3L2UIv
         xfMsntYOhAK6JH1Addagu8/HswgT5lWR810C0FSYoNa2xWT81mjgRZHsC92zRRWFFxUb
         vIY7QfW+KZNBp477jszT2SYCtrW/w1Vs0yPvSIMTE2QBgWqIS/VGnLgbSagohjMO1qsa
         jazQ==
X-Gm-Message-State: AOAM532QNDGxb5bfhw2iIo3IhaxAB4Md18gIvIVFK4OJe7VjhXJbFzLu
        2vTsjcLG7tvjCHhE1f0pmYfR0EOBRivcQqYXesfPYg==
X-Google-Smtp-Source: ABdhPJw1nZ+tWly57aMTZwIVKoNuLGcpf6etqap0sxYqDil+4hf8NY6L01OgI/e5iEHP2hh3IzbZ398w323owWQXbOM=
X-Received: by 2002:a05:620a:98e:: with SMTP id x14mr1200474qkx.353.1611868372855;
 Thu, 28 Jan 2021 13:12:52 -0800 (PST)
MIME-Version: 1.0
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net> <20210128160453.79169-1-jacob@gitlab.com>
 <xmqqmtwsx4d9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtwsx4d9.fsf@gitster.c.googlers.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Thu, 28 Jan 2021 22:12:42 +0100
Message-ID: <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
Subject: Re: [PATCH v4] upload-pack.c: fix filter spec quoting bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 8:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>  * As readers know "clone" would get not just the current branch,
>    the way this rev-list traverses only from HEAD makes them wonder
>    if you are trying to exclude refs other than the current branch
>    for a reason.  Better write it as
>
>         git -C dst.git rev-list --objects --missing=print --all >objects &&

Good point!

>  * The above says that we are happy if we can clone without erroring
>    out, as long as some objects are missing, but we could go a bit
>    stronger than that: among the objects we have, none should be a
>    blob object.  Is that something we can easily check?
>
>    Something along the lines of...
>
>         grep -v "^?" objects |
>         git -C dst.git cat-file --batch-check="%(objecttype)" >types &&
>         sed -e '/^commit/d' -e '/^tag/d' -e '/^tree/d' types >actual &&
>         test_must_be_empty actual
>
>    ... to ensure everything is either commit, tag or tree, perhaps?

Makes sense, I started down that route at first but I bumped my head
against needing --missing to prevent the lazy fetching, and stopped
once I had the question mark grep.

Now that we're talking about the test, I was wondering about something else.

In my original patch, I purposely did not add a test. Why? Because
--filter is just one option of several that upload-pack passes to
pack-objects (think of --shallow-file and --include-tag, for
instance). Why is --filter special? If the original quoting bug had
not happened, would we be testing various permutations of clone
options in combination with packObjectsHook?

As a reader looking at t5544, unless I know the backstory of the bug,
I do not understand why --filter gets a test but those other things do
not.

I am not saying this to push back on going back and improving the
test, I'm quite happy to. It's more that deleting the test may be the
ultimate improvement. Thanks in advance for humoring this contrarian
suggestion. :)

Cheers, Jacob
