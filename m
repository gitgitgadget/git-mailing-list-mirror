Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC5EC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 22:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245090AbiAEWf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 17:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiAEWfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 17:35:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118EC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 14:35:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o6so2273758edc.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 14:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEfjC3GAGo8I9DMpJMlogVs32qRShDS2/EEgLwlFmTo=;
        b=C5X8mocwNDdtXwq49LinADU3JNFwx20SrgmJyn8QTI/xd85fOZWZs0RMsvU4BMbZv5
         8vdpOAbbi8FbHBUbG+5+TA7Ul199Z5xmqD+mD+sR6h8G09lNYEU92DupT75Bu5rB70Fx
         H7O0shMKlZswgMf0EUroqhmv9B1y+OuGL+IjZUzUTacJHasbkI5k1yADEDJFDaMJGSn2
         fTFeDVgke2ZEcjtxmjGsIWE/J4UPxdxArz/fuH0DVB19nEMcda+2/97kjh9byezDzPpu
         O+Zv7hBj86kWsuIycE6xqwUcTl+VVi/ei6PUYNT9hw36mKmyWmtyLQiXRYDyaTHxckz7
         ABjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEfjC3GAGo8I9DMpJMlogVs32qRShDS2/EEgLwlFmTo=;
        b=PDkhR4PyPSnNGJJ4ZV5Ptr8pJAGVum/vesFSxB1Xxj6yox4K2Wi7T8fSSmfYLYfyEw
         iy9ym8bpNe7nJINuNB1tn6HBT6rOW8kPeEGfsyvt2AtfLsCtPnV5SQR865bBePAR6LUr
         mL8HwGL60aKpJ4WeGBRIOEzj/v5AvZmUdoGuZtRg1BP7KeS/qOe+LWFlpiq2YsdBZj4A
         YiRfJkRD/on1VYHD1WlIi4DKOhwNETQYHRIUOgINO7wuY9xKHgBuPWHZPg5qwpvD7MIa
         r2vsf/TLxOXJHmgaaqP75nsAM9dVeUjwpfxAKNUJhKjUYQd5k/i0FjfwpRtG7sGUlA8H
         FNJw==
X-Gm-Message-State: AOAM531atRUUuqP7f5t+bi4XFdJ6iX7fBSZoX23nSQKJZQkUl6ymbsJ8
        PogzSwf1XA87w3PDklisb4XK1rKHFUXTBkHMqBM=
X-Google-Smtp-Source: ABdhPJwCn4qHOWOUnOGqw1UKNvpmPjABUg8khV84YIW7QmYnvNI1gOduz7NGh3H/gHW9kj2EsEdDt1o29XOygRHuG50=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr45467341ejc.476.1641422152240;
 Wed, 05 Jan 2022 14:35:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <xmqq8rvuhr6q.fsf@gitster.g>
In-Reply-To: <xmqq8rvuhr6q.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Jan 2022 14:35:41 -0800
Message-ID: <CABPp-BFHqu6J2TFAwVzBBznhWBi0ESq+hYoytCPXhrYw1d0JAg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] RFC: Server side merges (no ref updating, no
 commit creating, no touching worktree or index)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 5, 2022 at 12:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series introduces a new option to git-merge-tree: --real (best name I
> > could come up with). This new option is designed to allow a server-side
> > "real" merge (or allow folks client-side to do merges with branches they
> > don't even have checked out).
>
> Finally.  merge-tree was added by Linus mostly as a demonstration of
> idea to trick other developers into enhancing it to implement a full
> merge that does not need to touch the index or the working tree, but
> everybody failed to be enticed by it so far. It is true that it can
> be used server-side, but I do not think that is what we want to sell
> it as (after all, receiving a push, merging it to the history in the
> central repository, and checking the result out to the working tree,
> would be a good "server-side" operation to have, but it can be done
> today without this series).  The selling point would rather be it is
> done mostly in-core, without touching working tree or the index file,
> no?

You're probably right about how we try to sell it as a project to
external folks, but I was focused instead on selling it to reviewers
within the project.

"Server side merge" was the name of the topic at the Git Summit and
lots of folks had interesting comments back then, so I was hoping to
grab people's attention with a phrase they would have seen previously
and commented on.

Further, the folks I know of who have experience trying to do an
in-core merge are folks who operate on the server side (using libgit2
instead of git, which they have some gripes with).  I wanted their
experience and views in the review and wanted to make sure it met
their needs, and tried to highlight that to lure them into responding
and reviewing.

> Exciting ;-).

Thanks.  :-)
