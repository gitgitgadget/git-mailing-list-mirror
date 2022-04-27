Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA26C433FE
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 14:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiD0Of3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiD0Of2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 10:35:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679920F48
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:32:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z99so2169089ede.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lDVWQVeE+3UCb/GH31JsVeB2oysxWPb6Pn9ipRahX+o=;
        b=gX27JxN5QXa8Ac/w49OGHBR0O7QnE9v/o2X4IjnSHqEKwXSAxzMgaGtNDyuumH4twv
         LmHG0GLqy2SgoARub0vJwQSTTqLafVvGDltbss4yDsje3RL+bAmvnlvkzUHI+Xzx7wBr
         LT009hCLbgOirtsLsGKZLeEvMk6W2ZhtwdoRZn71zItQ9xkg5WJ2Ng9U8E4QvBD/HCle
         8racrJF+rWe1uJyQl7uwkaZcuw40dtL4xm38T7YYhboq/RISEHxXYLIPRZAFWcIKgjhu
         KBW9SxYZnH0ZCQ6lt5m8QAQxk4MRe/q2TAbc8u5vehpbWpJsF/KRMuRUpsMCjyMpd8BQ
         ijow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lDVWQVeE+3UCb/GH31JsVeB2oysxWPb6Pn9ipRahX+o=;
        b=s5Eytlr3xGTdev5NIBWcL1U6VZxo3jqzdWH4Imgk8tiZsuqqc/bGoJkeeBFr2Itoag
         71rbZz6O2rN2L2g1UC46AaOGSnp5cOVvu1WnxmrrW0k97DzdZeGCLClo9EheKVLoTorL
         ggA4A3CrU8ZFlzv27JondTkE87Wah3Fftn3vUgMXIghn1u1ZDITAgAN6rogT9DBXhIzT
         ZRNSzfDTI4Lc8SHBntiFgGuxygOuWh3S/cO/yNBERbGXn7z8Y4WlTipeDmWAN/jrkyCI
         wVgOV3hQ1R/t52lnCusGDlN2B/dLl4n0xoYLHKw1JI+uFWsmF8MuMsmMjeR8lxGMOGLk
         syHw==
X-Gm-Message-State: AOAM530If1EpZGiCXukMjEEL46GRy+X6oehXKW34tyalXHqeiq+lJrVU
        6b8dRsjY+ltUtXd9wvOma/zEpVVP0AY=
X-Google-Smtp-Source: ABdhPJxsStDFDu55nCwsjuUm2MGZcP3t9Gi0Yv09ViVu59m4O0i8S9gfxjOTLo+F+GIbyGVt76bOQg==
X-Received: by 2002:a05:6402:50cc:b0:425:e744:53cd with SMTP id h12-20020a05640250cc00b00425e74453cdmr17053737edb.390.1651069935477;
        Wed, 27 Apr 2022 07:32:15 -0700 (PDT)
Received: from localhost ([2a02:2149:8ba4:e400:b4f9:19f2:e54:30c8])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709064f0f00b006f00349c4c3sm6626070eju.122.2022.04.27.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:32:14 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:32:06 +0300
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, matheus.bernardino@usp.br,
        mhagger@alum.mit.edu,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 3/6] dir-iterator: refactor dir_iterator_advance()
Message-ID: <20220427143206.6cqksztbk4exift3@compass>
References: <20220410111852.2097418-1-kioplato@gmail.com>
 <20220410111852.2097418-4-kioplato@gmail.com>
 <35160d46-d337-2110-f968-238abb7e9f0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35160d46-d337-2110-f968-238abb7e9f0e@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/11 02:26PM, Phillip Wood wrote:
> Hi Plato
> 
> On 10/04/2022 12:18, Plato Kiorpelidis wrote:
> > Simplify dir_iterator_advance by switch from iterative to recursive
> > implementation. In each recursive step one action is performed.
> > 
> > This makes dir-iterator easier to work with, understand and introduce
> > new functionality.
> 
> I think that this message could explain a bit more about why it is necessary
> to use a recursive approach. As we are implementing an iterator we cannot
> keep state in the stack between iterations so how does using recursive
> approach help us?

It's not necessary from a functioning perspective. This iterator works on tree
like structures (exception cyclic symlinks), performing pre-order and post-order
traversal on some vertices, in our case directories. Traditionally, these
operations, i.e. pre-order, in-order, post-order, in textbooks, lectures and
online sources are implemented recursively and not iteratively. Therefore it
helps reduce mental load for the reader, since it's easier to follow as it
reminds of the same code paradigm, e.g. post-order:
  * Recurse left child
  * Recurse right child
  * Visit subroot

In general, graph algorithms are more readable when implemented recursively.
In each recursive step a set of instructions are executed and recursion lays out
the code in such a way that these instructions stand out symmetrically for each
recursive step.

As a result, recursive dir-iterator is more maintainable, as its code structure
is more similar to other graph algorithms and to what we're already used to,
than its iterative implementation.

A nice side effect of recursion is that it requires one less indentation depth.
This further simplifies the code.

> I reviewed this series as a way to learn the directory iterator code as I'd
> not looked at it before. Having read the existing code I think the it is
> fairly easy to follow. I'm not sure the changes here improve that. I also
> found these changes harder to follow because they renamed existing functions
> and variables in addition to moving the code around.

Michael Haggerty said that dir-iterator code is quite intricate[1], I agree and
tried to simplify it. My conversion from iterative to recursive implementation
tries to deal with this problem. The proposed advantages are specified above.

> In order in implement returning the directory name after its contents I
> think all we need is to remember whether we've returned the name when we
> readdir() returns NULL so we don't pop it too soon. It's not clear that we
> need a lot of refactoring to do that, especially as the patches you linked
> to in the cover letter seem to avoid that.

It's one more thing we need to keep track of, that's not required and can be
avoided. It further tangles the code, introducing more cases. The recursive
implementation that I propose, does not need to keep track of this information.
Probably there's an equal iterative implementation that also does not need to
keep track of this information.


[1]: https://public-inbox.org/git/7a665631-da6a-4b9f-b9e7-750f2504eccd@alum.mit.edu/

Thanks,
Plato

> Best Wishes
> 
> Phillip
> 
> > [...]
