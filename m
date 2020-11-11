Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A2C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B933206D9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgKKRV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:21:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37932 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKKRVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:21:25 -0500
Received: by mail-ed1-f66.google.com with SMTP id k9so3117354edo.5
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9uW/jMxlasGUsOiPvHx6bnsv9ntygI2t6R0B9/5mfv4=;
        b=oVSke/mmyagnmsdeHBt0M+jie79zem0MHKWLOlf0ydwiaMkP0Pgt4snjRzXZkvgZUo
         3tl+qSQ0GZqLFHHNjpa0zJTw0GQDZUxUE8mjBnwXSMaQ3pCi959KPUMe3m8Ag1BnedNS
         gVzE+S2fGt8D7SVgIaBhr/6CJ/K7jrspijtzH25X5ftMp0sxZMu5cUD7dh6Wil0UfVtA
         KE99HzMRn1N5AV8YsevEy9G3Ml8x35zjiGBPJifpyY7UQ7pJZolMjaeEvf0ZwxcVVESF
         wUlJ3ZGVt5Ef5ZPLpgvQISGk7WAKqj51U0hBdkp6axoh6CFMoVhPKpQyzcxb4RnI3Wky
         gmWw==
X-Gm-Message-State: AOAM5317dyRknGHr1WQzh8Be4IgF3FBdfm9Yqyu/nR1r79h6x5YXifcv
        T1vcBy52+hTpjvmhYzmOE7aKtKF2BoRhM9BzE4M=
X-Google-Smtp-Source: ABdhPJy1FiTpX8jWQBsyNjMXgmhULGFAwrqBNuBPTD2todoby1hCswac1tZ+XB11RZWHUsbWgIAjh6/2iCzfdTEaV6k=
X-Received: by 2002:aa7:cc0e:: with SMTP id q14mr491583edt.181.1605115284275;
 Wed, 11 Nov 2020 09:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-8-newren@gmail.com>
 <c4b9b64c-f0a0-5824-44b9-072370cfc465@gmail.com> <CABPp-BGk8FBt8WWw_h8t2jiE4quBoMeaco19F-fJ6V_vOnsNww@mail.gmail.com>
In-Reply-To: <CABPp-BGk8FBt8WWw_h8t2jiE4quBoMeaco19F-fJ6V_vOnsNww@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 11 Nov 2020 12:21:13 -0500
Message-ID: <CAPig+cSrcodAJu9S82vogt05priRDj1vBpaZUTFfhJraEzKvZA@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] merge-ort: avoid repeating fill_tree_descriptor()
 on the same tree
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 12:13 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Nov 11, 2020 at 6:51 AM Derrick Stolee <stolee@gmail.com> wrote:
> > If the *_null values were in an array, instead, then all of these
> > lines could be grouped as a macro:
> >
> >         unsigned null_oid[3] = {
> >                 !(mask & 1),
> >                 !(mask & 2),
> >                 !(mask & 4)
> >         };
>
> Hmm, I like it.  I think I'll rename trivial_merge() to
> non_null_match() (trivial merge suggests it can immediately be
> resolved which is not necessarily true if rename detection is on), but
> otherwise I'll use this.

Are we allowing non-constant array initializers in the codebase these
days? I don't see anything in CodingGuidelines suggesting the use of
them.
