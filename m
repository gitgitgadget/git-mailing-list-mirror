Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E60C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237829AbhLVU12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLVU11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 15:27:27 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499FC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 12:27:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u37-20020a632365000000b0033b4665d66cso1982253pgm.18
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 12:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CYN64+Yvb5hIXPCNVTiQOVqRT+EXZ5gt0kU19jVqREY=;
        b=Y7Dj7/zG0Ky0s5smIIWdgL730uSphyy69xHwFTojRtgUyZvAXLRgsUw0GFTOFfac56
         prf3D8Cqv6hd982679hIeumOx9GxgZWTxbgpJlkXfCCUCEyjjdxPisarNL9IRtOibnI0
         7mrQzJMcUnIbfPnLkQpTUJ2EV0hCw0t5qtNq1Hc6fPimixlNNST/XjIB0KOOFRSnyBtn
         NImZNv+Qkn6a2CrJfbmYvxM49BaNKkmAYX+WisXbeLv+KiSsld7IsmtKnqVfC8diAFxI
         HHXWIK7QAzR0dlbuDfdx1JPXsd8YUEEzs/IIy1xuwGnXe/RcibhzwgZ5ax58eRya+fu+
         1NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CYN64+Yvb5hIXPCNVTiQOVqRT+EXZ5gt0kU19jVqREY=;
        b=MsAYGB2d5U3cREToxs7pA0Q68zDwNDxi2zww/65/ydQ+gqf/mCyIi54mmHRRnog+Di
         YnQ9xs/TJPVoRrIYHMKLzWEtNljNevIp+xthm85pY5gfKFir4CQvF+5yAy6wvcOt1rTc
         m4IX/bJgJeWOEAFr4eiZRV/32H3DoN8cwu8PwBhwEreKsy1CcvcVP3S5VROXiYv1Etml
         xq6I+NDgGNJ8K/1hG6+CS2ya662gLgAWl4FinXfCeJPbyVLQolfTCHhoLYRbVukHwXvu
         y/jjASPmx2fxJXTZ2hN8D0JXZhy5frlT5uEFEDi6SVV4Ns7FmX3bLPVfQoZB96jeC9Mt
         zo8w==
X-Gm-Message-State: AOAM530eyYHYd9SoPGrXwrvH0dQkiARx5Uihl+0Jm7iuNBdY1Z0ZXsPI
        LhtMfadUulE2WocwdvB57tSI+hA5P00ogQ==
X-Google-Smtp-Source: ABdhPJyMmXyj9hU9NX1WvIPrpuLSIbdHzwNfgHjSkRrfH/Ule1RrZcOjGvqNjazkRWpXfV/zYwWaplb3tC9Uug==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bd4b:b0:149:460a:9901 with SMTP
 id b11-20020a170902bd4b00b00149460a9901mr2157296plx.44.1640204846890; Wed, 22
 Dec 2021 12:27:26 -0800 (PST)
Date:   Wed, 22 Dec 2021 12:27:15 -0800
In-Reply-To: <xmqqpmpojv48.fsf@gitster.g>
Message-Id: <kl6l4k70z8po.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com> <20211222001134.28933-1-chooglen@google.com>
 <20211222001134.28933-3-chooglen@google.com> <xmqqa6gtkumz.fsf@gitster.g>
 <kl6l8rwczgzy.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqpmpojv48.fsf@gitster.g>
Subject: Re: [PATCH v3 2/3] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> I would have come to same conclusion if I agreed that we should recurse
>> into submodules even if no objects are fetched. When I first wrote this
>> patch, I was convinced that "no new objects" implies "no need to update
>> submodules" (see my response at [1]), but I'm not sure any more and I'd
>> like to check my understanding.
>
> For example, there is a "everything_local()" optimization in the
> fetch-pack codepath where the following steps happen:
>
>  (1) we look at the current value of the remote refs we are fetching
>      from their ls_refs output (let's call it "new tips");
>
>  (2) we notice that all of these objects happen to exist in our
>      object store.
>
>  (3) we make sure that we do not see any "missing links" if we run a
>      reachability traversal that starts from these objects and our
>      existing refs, and stops when the traversal intersect.
>
> When the last step finds that all objects necessary to point at
> these "new tips" with our refs safely, then we have no reason to
> perform physical transfer of objects.  Yet, we'd update our refs
> to the "new tips".
>
> This can happen in a number of ways.  
>
> Imagine that you have a clone of https://github.com/git/git/ for
> only its 'main' branch (i.e. a single-branch clone).  If you then
> say "git fetch origin maint:maint", we'll learn that the tip of
> their 'maint' branch points at a commit, we look into our object
> store, find that there is no missing object to reach from it to the
> part of the object graph that is reachable from our refs (i.e. my
> 'maint' is always an ancestor of my 'main'), and we find that there
> is no reason to transfer any object.  Yet we will carete a new ref
> and point at the commit.
>
> Or if you did "git branch -d" locally, making objects unreachable in
> your object store, and then fetch from your upstream, which had fast
> forwarded to the contents of the branch you just deleted.
>
> Or they rewound and rebuilt their branches since you fetched the
> last time, and then they realized their mistake and now their refs
> point at a commit that you have already seen but are different from
> what your remote-tracking branches point at now.
>
> Or you are using Derrick's "prefetch" (in "git maintenance run") and
> a background process already downloaded the objects needed for the
> branch you are fetching in the past.
>
> Depending on what happened when these objects were pre-fetched, such
> a real fetch that did not have to perform an object transfer may
> likely to need to adjust things in the submodule repository.
> "prefetch" is designed not to disrupt and to be invisible to the
> normal operation as much as possible, so I would expect that it
> won't do any priming of the submodules based on what it prefetched
> for the superproject, for example.

Thanks for providing concrete examples; that's a lot more convincing
than my hypothetical.

> So in short, physical object transfer can be optimized out, even
> when the external world view, i.e. where in the history graph the
> refs point at, changes and makes it necessary to check in the
> submodule repositories.

Yes, you're right. I'll move the jump accordingly :)
