Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4CC433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiEJTz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiEJTz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:55:27 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92470297418
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:55:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id fu47so14379851qtb.5
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T716y21aleInA86Hv81f+YaYIhD/00Rs6UuTP4eQnzI=;
        b=1/CqV2qKSy+Yi2/sMAHoF88ou9AvdWHxlt5D1ASHW6WGjc+qMc/Vwn9PhPrNrLHwwF
         0uGweac1LTuSicikVMbMI3d+hquDw+lPcWSpW1NQiJBEDruRsOYnAmU3kKB4L2nQ/cWU
         6dsRwm2tv4Cgw5xl7npc0Gmpwhg0MKkyS3e5Yk0s7FvaKAKGWOd7l9PlGvN3Aj6DAtpR
         lkfqD/Fc1HjwnW3RI1LL+i81jCmrgMtZd2bbW5E8vUxIOdR8wNpvlIgGY8qMsNtZodNW
         93XKKYuoTnau9k+wFJ7vF0DXqBY8HwkFSiafOkDaC8XQqplNWRZG/bsjtTR/74bPSjeb
         MAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T716y21aleInA86Hv81f+YaYIhD/00Rs6UuTP4eQnzI=;
        b=qV97UBxdkoM28acrQwqYwUyKDDLoHq2f2Alud9pTyuNMmzBax1lJ/P4xNBPOme3YBN
         xNc34uaVjaBYxg6J87SjQOwkQ9w6OH1dcGGiJaJ81i70o8zCbKNn4tRtsLqfdougeOm8
         Okxg5jAqF/QAq8dg24IrT3LYXgOyqZ6U4N6wzCK3snmDfy0GyQNpV2hY1TlwD99PD/Bp
         eRjwuNiMmkyqHmxyabNu8HWeL94V3TZZxnjwJur1MhsaLC1BO69F+Xgs6UHCQH9iPmuU
         tjA6Z3u2JEgPAUekFmtHyYwCFBFFGyoP/p5svywrETYLC5v28dYSsbDT4bKCOV6/w0Ex
         6xvg==
X-Gm-Message-State: AOAM533850OEwSlUHHt5LCUOobrdhauKyExgUHgHX5VRy4osDpinJX/E
        CCM8uGHYl1gQK/3dwPW3T/U6dQ==
X-Google-Smtp-Source: ABdhPJwn8oeYVHJ+3Q+VgecoSxk47ZEITTtZ98FMq0hh9OyIIf6+IWCT98tKiKZprVfS9ZKQaY8/ug==
X-Received: by 2002:ac8:5b86:0:b0:2e2:72c:9e06 with SMTP id a6-20020ac85b86000000b002e2072c9e06mr21185566qta.113.1652212524733;
        Tue, 10 May 2022 12:55:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a05620a014d00b0069fc13ce23esm9238301qkn.111.2022.05.10.12.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:55:24 -0700 (PDT)
Date:   Tue, 10 May 2022 15:55:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] t0033-safe-directory: check when 'safe.directory' is
 ignored
Message-ID: <YnrDK0wCV6taY1QX@nand.local>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <20220427170649.4949-1-szeder.dev@gmail.com>
 <20220427170649.4949-3-szeder.dev@gmail.com>
 <xmqqr15il0uo.fsf@gitster.g>
 <a44b4f0e-038c-9bcd-80d6-f53c87bd7f2d@github.com>
 <xmqq8rrndb6h.fsf@gitster.g>
 <20220429190625.GA1626@szeder.dev>
 <b6deba3f-9019-fb6f-7bb3-cc2f647dcff6@github.com>
 <20220510183321.GA4408@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510183321.GA4408@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 08:33:21PM +0200, SZEDER Gábor wrote:
> On Fri, Apr 29, 2022 at 03:19:01PM -0400, Derrick Stolee wrote:
> > > And we do need a subshell to set the
> > > config, because without unsetting GIT_TEST_ASSUME_DIFFERENT_OWNER 'git
> > > config' would refuse to touch the config file.
> >
> > Ah yes, of course.
> >
> > > I think something like
> > >
> > >   test_when_finished "(
> > >         unset GIT_TEST_ASSUME_DIFFERENT_USER &&
> > >         git config --unset safe.directory
> > >         )"
> > >
> > > would work, though.
> >
> > Would it be simpler to use this?
> >
> > 	GIT_TEST_ASSUME_DIFFERENT_USER=0 git config --unset safe.directory
>
> Oh, wow.  This is so obvious, no wonder it didn't occur to me :)

Don't we consider this one-shot environment variable to be sticky on
some shells (i.e., that it persists beyond just the "git config"
invocation here)?

Thanks,
Taylor
