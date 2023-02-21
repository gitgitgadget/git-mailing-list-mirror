Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F086C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjBUVms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBUVmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:42:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953252F7B8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:42:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ck15so24030633edb.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EM7qrYCKN1D1rdWZiKgXqeKR0SxA95seszllsdIY5rk=;
        b=BnrkWgdNTNzH6ZPNG10UiFmfjmfXlDaLDUUafgrZbYjSZlHkrDXhqT/xscEcfR6g/C
         3no0Qb//9/pvis2ItyfnOyRVNB/Wm6ud/iwZLxa7xVDnEK/FVAd3YElgKRJNLwi2GAM3
         nHzT24Yj+kV/9lwUDJie/kwDomqKDpfle27dmzaVprW6t7TiAr2BUO4gv7clOuthNAhK
         bxT9TECqZFT19kOx3StzE0wx4wCJV5NHe1B/KScdtRkKgljaLUs12ER0Sfs+97xovQF9
         AewND/wcagpcpGTziNABDhDOjxv5saXkNL4/IznUR2YNjzqoyeyit04kJhQ30wuIps4R
         ZNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM7qrYCKN1D1rdWZiKgXqeKR0SxA95seszllsdIY5rk=;
        b=6cxmFXR0S0Jn0bNkOl6FdZ7Bx9jGsOfH1uYsiV8Qa4JI+pqSlx2eDDV/Qp0Q/TYczI
         rnF6I/NK056z4ig8BgG8gR0Eml3vvM2f/q+y8qTQX7lZuxrPRW00WAxRl8PSwZMAYM8R
         R/IHF8rchPVnjamaVdBON4YuiX+YbzMq4erGex300d0cd+uJ4Mt1a+H5Bwi1AQGAUHuD
         w/UlpUbICwtIz8L/fSjWFegX+Wqei3pgpr8xKyLHKDm0cmZq9n0GVIqQkNllOQ+gam/H
         6v2RABH+NxNsfAwa8Aq8Y6Mv+UtAL5yzS7SGNtnKOlD0Oo+tKarC5/H594qAghueelWU
         bWrg==
X-Gm-Message-State: AO0yUKXj8o7SYIlK4SImENbZW2e7LCVbeZijM2nQG+AACz8xu4v1cVHm
        xbBX5XQ3ut7HYPyM8Esef3ms+8VNEdCGLh9zeQ14Uw==
X-Google-Smtp-Source: AK7set8C5AIdZev01VuTJ4FTzGc26MUY4TOAzRa+YbuGXKhZZaLDyOc1evSWwetkHtz6jb3DZAV+3FRNfxFQtEAshOM=
X-Received: by 2002:a17:907:7b8a:b0:8af:2ad8:3453 with SMTP id
 ne10-20020a1709077b8a00b008af2ad83453mr7454910ejc.6.1677015763775; Tue, 21
 Feb 2023 13:42:43 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g>
In-Reply-To: <xmqq3573lx2d.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 21 Feb 2023 13:42:31 -0800
Message-ID: <CAJoAoZn7Nt37Eh17dpLDK+YX2BaEaAaii2rJPXO3L0BmQQkcgQ@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 2:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > Basically, if this effort turns out not to be fruitful as a whole, I'd
> > like for us to still have left a positive impact on the codebase.
> > ...
> > So what's next? Naturally, I'm looking forward to a spirited
> > discussion about this topic - I'd like to know which concerns haven't
> > been addressed and figure out whether we can find a way around them,
> > and generally build awareness of this effort with the community.
>
> On of the gravest concerns is that the devil is in the details.
>
> For example, "die() is inconvenient to callers, let's propagate
> errors up the callchain" is an easy thing to say, but it would take
> much more than "let's propagate errors up" to libify something like
> check_connected() to do the same thing without spawning a separate
> process that is expected to exit with failure.

Because the error propagation path is complicated, you mean? Or
because the cleanup is painful?

I wonder about this idea of spawning a worker thread that can
terminate itself, though. Is it a bad idea? Is it a hacky way of
pretending that we have exceptions? I guess if we have a thread then
we still have the same concerns about memory management (which we
don't have if we use a child process). (I'll reply to demerphq's mail
in detail, but it seems like the hardest part of this is memory
cleanup, no?)

In other cases, we might want to perform some work that can be sped up
by using more threads; how do we want to expose that functionality to
the caller? Do we want to manage our own threads, or do we want to
pass off orchestrating those worker threads to the caller (who
theoretically might have a faster way to manage them, like GPU
execution or distributed execution or something, or who might be using
their own thread pool manager)?

>
> It is not clear if we can start small, work on a subset of the
> things and still reap the benefit of libification.  Is there an
> existing example that we have successfully modularlized the API into
> one subsystem?  Offhand, I suspect that the refs API with its two
> implementations may be reasonably close, but is the inteface into
> that subsystem the granularity of the library interface you guys
> have in mind?

I think many of our internal APIs, especially the lower level ones,
are actually quite well modularized, or close enough to it that you
can't really tell they aren't. run-command.h and config.h come to
mind. The ones that aren't, I tend to think are frustrating to work
with anyways - is it reasonable to consider, for example, further
cleanup of cache.h as part of this effort? Is it reasonable to rework
an ugly circular dependency between two headers as a prerequisite to
doing library work around one of them?

I had a look at the refs API documentation but it seems that we don't
actually have a way for the code to use reftable. Is that what you
meant by the two implementations of refs API, or am I missing
something else? Anyway, abstracting at the "which backend do I want to
use" layer seems absolutely appropriate to me, if we're discussing
places where Git can use an alternative implementation. (For example,
this means it's also easy for Git to use some random NoSQL table as a
ref store, if that's what the caller wants.) For the most part refs.h
seems like it has things I would want to expose to external callers
(or that I would want to reimplement as a library author).

 - Emily
