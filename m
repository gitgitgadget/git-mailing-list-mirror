Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BEAC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiLLWW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiLLWW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:22:27 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E22F03A
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:22:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg10so6910223wmb.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lSAcOalZW60fMmJ0ko04kdM/sMAHOKSIvWLTrrL2udc=;
        b=KwQw3o33+YzGu/hzr/gdrj5kBnCiehPLFpgwkJBF/m+g+vp6+tr5nySLTioJGNnJZf
         LYvhcgWlr6tlpVUL4aKc0oX5jG+QLPMQBBQlyf7FDKX+umyBRx4KXOfW+tOUjnAxwqVb
         6QtrD+jv3Q3akgHigLFP6yt3tw85kRV+bYjSu5m7vCFe7rp+ooBs2vY9zg5zFpYNugcv
         R09UV9L+wrG0vRFtirYmgkF/7j6sMKRVw+g6LNF9Qf6wMzXYcWYVtkhI0OyW0w+ZFiM2
         PfNfB7n+QSAaDmTKtRBKzjeyGqZz2Aw07pf0aecE3KaOSeUr1ImX6szWdRftjnhJM21G
         pQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSAcOalZW60fMmJ0ko04kdM/sMAHOKSIvWLTrrL2udc=;
        b=X+2TBkzraywQrTC0GNhCgz3uxX6WjsJaT0jxH8jjLhJ7yztrNds7YyZU77lJk73Ljd
         PRS55oE1T/wb8lsXb1xsuOdd7777/BHdZ2OOz6P2YcUd1JPmC+PfBC172doLo8iO2sTz
         Uu4u06S5JWpYGpULMuj7r1+QQKZbtu9HQGRE3OknF3EbqIq8Upq8kaqhFAoaTHtfqrq1
         7Xwnjm75EDByHLE15tdGQdpZZfyh7UoSG4YIDu9540giFexo1F4ssQBkrR1VrLys4h68
         ftt05/ANm0pcEN+u9VM1u418jnUOQ7OytwZlapeTzehkiKKI+JkoJlJsLrAnrEkhA6Ow
         sSIg==
X-Gm-Message-State: ANoB5plb1r18qnuZHVo+CcwjkQhLwMuApJmOoSLG76MkeO0b9zpLGmPd
        D2YwvWuRn7/RUfhHUCMm47TP7hkDA5B6VuYdmZc=
X-Google-Smtp-Source: AA0mqf4SSm+uLhVN1CcBO+xjp3v1KDGTwffTxMbZtndv53/OVfVjFBvZ3WkWWKF6t8L2xdkG7rGiMRg8vtI4U9nM1wE=
X-Received: by 2002:a1c:2785:0:b0:3cf:7dc1:f432 with SMTP id
 n127-20020a1c2785000000b003cf7dc1f432mr35288wmn.148.1670883744269; Mon, 12
 Dec 2022 14:22:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <xmqqilim6bhh.fsf@gitster.g> <3a47b7ac-25dc-5f70-9ab4-08c781df4cda@github.com>
In-Reply-To: <3a47b7ac-25dc-5f70-9ab4-08c781df4cda@github.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 12 Dec 2022 14:22:12 -0800
Message-ID: <CA+P7+xoaQFsYcwpaDz3Hg61cckfvK960z_rCTC3XTHeLzxwkvA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Optionally skip hashing index on write
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com, avarab@gmail.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2022 at 8:50 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 12/7/2022 6:27 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> Writing the index is a critical action that takes place in multiple Git
> >> commands. The recent performance improvements available with the sparse
> >> index show how often the I/O costs around the index can affect different Git
> >> commands, although reading the index takes place more often than a write.
> >
> > The sparse-index work is great in that it offers correctness while
> > taking advantage of the knowledge of which part of the tree is
> > quiescent and unused to boost performance.  I am not sure a change
> > to reduce file safety can be compared with it, in that one is pure
> > improvement, while the other is trade-off.
>
> I agree that this is a trade-off, and we should both be careful about
> whether or not we even make this a possibility for certain file
> formats. The index is an interesting case for a couple reasons:
>
> 1. Writes block users. Writing the index takes place in many user-
>    blocking foreground operations. The speed improvement directly
>    impacts their use. Other file formats are typically written in
>    the background (commit-graph, multi-pack-index) or are super-
>    critical to correctness (pack-files).
>
> 2. Index files are short lived. It is rare that a user leaves an
>    index for a long time with many staged changes. That's the condition
>    that's required for losing an index file to cause a loss of work
>    (or maybe I'm missing something). Outside of staged changes, the
>    index can be completely destroyed and rewritten with minimal impact
>    to the user.
>

Is this information in the commit messages somewhere? I didn't see it
in the cover letter. Nor did I see any other explanation in the cover
letter besides "this makes it faster". I would expect such trade off
or analysis of "what do we lose" to be in the cover letter, as it may
not be clear otherwise.

I do agree these reasons are good, but it can be confusing to later
reviewers when looking back at the code for an option like this and
wondering why it exists.

Thanks,
Jake
