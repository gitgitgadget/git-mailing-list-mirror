Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A838DC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 00:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiAFAKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 19:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbiAFAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 19:08:56 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467FAC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 16:08:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bm14so2922585edb.5
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 16:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSJMeKvCQGk5Ls7kl+Df66+8aH8m1F/LvO3xViWu9oM=;
        b=DNgjIb0SeoLeHo4Z3GbqenUaAnI22N2pvrNkdsH20TcEe5nnJ6A5tDmgi4BnEXlQRT
         hxWpsdoTw2+DoVH1uS7Teu/wWkLd5gh/9xKRYcl5A9coydQ8VWNgPq9ePi1weAdLFZmV
         pBZriGj3TC8x1a/V1CjbL7ULKG/BnCrugGWPfbJIqDqyr9gD7YSIUPHHjmM868GoUFue
         PoCnXbeaz8eczcjFOQfk4xqDyb0NoHP6v/rHKHbE5nU4BrBrEgIz3+zknbiP41k2tbQR
         dxdjTr6DRBdSVpEV76P5YSRtb0ir8YxuNDJ9qtd9LZryLj2/sOMo5bwaMfOFOx52fmR4
         kvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSJMeKvCQGk5Ls7kl+Df66+8aH8m1F/LvO3xViWu9oM=;
        b=JYUs5EwMRL1PHB929yQ9H8FrPdIP4Geka8p825k1TP6Y43/MA9n4I/DWDGuYj4aRDX
         2pn46aP6n1+CURgnPQ3KL6RlDcKukx6JeWD+KI5Y90rTovE6lne8EmMt790h06kpJzg9
         2qUDZcusbt8hMK7WZd/pnySMYR4bAFTp3S7OKustknDBx83tNsL6H5b2gaXVSES9X7x1
         ChBgZoRi+05S6vv72wjtAIm5gktLLllKNQ9BE2IJfC+pFmLyVNbJnXCA4De2LlmFnjh4
         2UiBVzUQbG77AurFbwbg4dGaO0UIqp5B9nRdBIcSAWBHnYXsswA/FSakl/7zGHPjpybL
         ZoBA==
X-Gm-Message-State: AOAM532x0PfckcswEUta59sRBIKPdiCIuXX+pZDb8ao4bwIyBPU2sthB
        S0h7OexLWdr5mtBn1CvmnpYGg35CVD5WCoJWXm4=
X-Google-Smtp-Source: ABdhPJyDcMBLYE3pE7eIlkJYKiA9X8FC6o6cL+mneXHYMW1qxa1LxL6ZMyBj9pwxD99cUdGOvSq8jDKzvXyt6Zx5KzA=
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr44527508ejc.493.1641427733835;
 Wed, 05 Jan 2022 16:08:53 -0800 (PST)
MIME-Version: 1.0
References: <29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com>
 <xmqqsfu1g64s.fsf@gitster.g> <CABPp-BH5woi6KY7OBpnsS-M2EmgLHii9zs8rSwrgcPFkOAvn_A@mail.gmail.com>
 <xmqqbl0pg3s7.fsf@gitster.g>
In-Reply-To: <xmqqbl0pg3s7.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 16:08:42 -0800
Message-ID: <CABPp-BFfuDMQXCZg_5YXQLaPtc9nyrJaq8J6VEDVsaiEMeeZMA@mail.gmail.com>
Subject: Re: Bug report - sparse-checkout ignores prefix when run in subdirectories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 3:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > So, should "**.py" go directly into the sparse-checkout file as-is, or
> > be translated to "my/current/subdir/**.py" first?
> >
> > Maybe translating is always fine, or maybe we want to throw an error
> > when: (not using cone mode and prefix is non-empty and any patterns
> > are provided).
> >
> > Thoughts?
>
> Perhaps allow things like ":(glob,icase,top)frotz" to be passed and
> treating them as pathspec is the most sensible way to go outside the
> cone mode?  As far as I understand, the cone mode is a strict subset
> that is straight-jacketed into "no patterns allowed, just concrete
> directory names and nothing else" for simplicity, so it is perfectly
> OK for these two to be taking different things.

Are you possibly confusing pathspecs with gitignore patterns here?
(Or am I?)  Or are you suggesting that sparse-checkout be modified to
accept either gitignore-style files or pathspecs and handle both?

I have never liked that gitignore-style patterns were used for
sparse-checkout, but it has always seemed a bit too late to change it.
Ever since Stolee introduced cone-mode, my preferred strategy for
fixing the gitignore-style patterns problem, assuming we are allowed
to do so, is to deprecate if not kill non-cone mode.  (And in the
meantime, I'm just doing due diligence when I mention non-cone mode in
my reviews.)
