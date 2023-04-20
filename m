Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26770C7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 20:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjDTUst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 16:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjDTUsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 16:48:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F110B
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:48:41 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f8e81c3f3so13673767b3.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682023720; x=1684615720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRfz6FOTKqlkMf0DQnmAtb0gmv+PeHnGpi9Mm7Cq6d4=;
        b=1vlqYEX1GEpEgm9Fw74u9q49Mt9Fxz4075qe8h5/0JW4AHDevioUyT7bzJ9PnntEv3
         ndSecAnRieSE/CdrSOEjpN+/dofLKyVrm2jnxXEfmN1lwiG+rPGyAT9ZUCGhU6l1SVXD
         OTe5+33qRjg2QJ0JaxT8/MGgJ1lfXdUn4pNmCP0J+Nek/HgkHeyLVgrmcf6XK5WprJZx
         rNucZfZjWmyCnvOB6g/RR3esuNFL+Zm00aBgxPzC0QNg0RxzhwLOEqpMOGXUogkDp4nR
         ZoLvRV//c0Z3eGZvuBQd1WomLIjOWBCAMdenBRxuM+kAmsX4+O1ZOJQ5O7rke9NKLI+5
         v3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023720; x=1684615720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRfz6FOTKqlkMf0DQnmAtb0gmv+PeHnGpi9Mm7Cq6d4=;
        b=eIMPoZi3udEj0w6M68oaSwiKIBFCnLpZKtQzJmrgYwXwS94gsXQY4bH1H+1ch1addf
         gno3ZlVn/GYBPfThe+clN13K4WoNkT5lb1XP901DBi6UIV+S1Q/ZZ+Oynwfb9zc8tysa
         ejjSN2TUUv6VBHfO7f5jjc5DVpWdJL0lT7M7o+WGLMjTiPNjUHGok8nW9ftdGG5VLaz0
         ia20s7GCIVNk7ZP5tuMSYUDEEfEc0jI8/VAtPCs1Ukf2vW36awVmS2719B5VeKFf51aO
         4xRWFdTLc7DUs7jBcSzunB5FsR62OLnj3b98flQe6F6Ss1FlSxvc7zNpJG7K2xAzSViv
         7YlQ==
X-Gm-Message-State: AAQBX9flQLGa3YP97dDt0CrXLylWRKCNo6osCpJ4hDKitRZi852sfmza
        hTDCqfUPmVebcmN9Iigmb5Dl7g==
X-Google-Smtp-Source: AKy350ZuKQMXKjHrWQyCo2fM9O04BeQPTY/cI+BBpFQ+7WkfMGaec8zgKcMsvUjazkT1GulIeUkwQA==
X-Received: by 2002:a0d:f8c7:0:b0:54f:e2ae:21d8 with SMTP id i190-20020a0df8c7000000b0054fe2ae21d8mr104101ywf.28.1682023720522;
        Thu, 20 Apr 2023 13:48:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d14-20020a81ab4e000000b0054f885d381esm539630ywk.135.2023.04.20.13.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:48:40 -0700 (PDT)
Date:   Thu, 20 Apr 2023 16:48:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <ZEGlJx4ibYSp6qmD@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <xmqqzg72zalp.fsf@gitster.g>
 <ZEGSvfEkE5PhokKv@nand.local>
 <xmqq1qkez5yg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qkez5yg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 12:52:55PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> But it makes me wonder if it would make the life of end-users simpler
> >> if we reserve a special ref hierarchy, say "refs/crufts/*", than
> >> having to write a program for doing something like this.
> >
> > Ideally, yes. But I think there are certain instances where there are
> > far too many (disconnected) objects that creating a reference for each
> > part of the unreachable object graph that we want to keep is infeasible.
> >
> > Another way to think about pack.extraCruftTips is that the program
> > invocation is acting like the refs/crufts hierarchy would if it existed,
> > but without actually having to write all of those references down.
>
> [...] Is there a less hand-wavy use case you have in mind?

Sure. The use-case I have in mind directly is keeping certain entries
from GitHub's `audit_log` file (see a description from Peff in [1])
while excluding others.

We use the audit_log to track every single reference change, like the
reflog but with the reference name prepended to each entry and some
optional metadata attached to the end of each entry.

Our goal is to be able to prune the test-merge objects that GitHub
creates without (usually) pruning any objects that was pushed by a user.
E.g., even if a user force-pushes their branch from A to B (where B is
not strictly ahead of A) we want to keep the objects from A around, even
though a reference is no longer pointing at it.

This already works with reflogs, which are considered as reachable
objects when generating a cruft pack (that is, they go in the "big"
pack with the rest of the reachable objects. This is extending that
mechanism to work with GitHub's custom format, but doing so in a way
that is not tied to that format whatsoever.

The hope is that others may find it useful in other special
circumstances like above.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20150624094919.GC5436@peff.net/
