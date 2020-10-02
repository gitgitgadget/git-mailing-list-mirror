Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43BC4363C
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6670C206FA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5NRGOvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgJBQ2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQ2H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:28:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DBAC0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 09:28:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so2246744wmd.5
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2mZLIb/d7YZpTqmjry/FkgH3XwX+mmbxMdE81w6snU=;
        b=n5NRGOvCLwXNisZT8DQOerbEqDA7ypL1MsOk6G0hqihR75Gl1BqJ54efiEmaXAebx0
         KuP11jQxoAQdorNoMZltJorAA7LK3bwgU8+sL+lmWshAxGBeW03qUukXbye3/tFDvmZe
         8hocv0w08JYP35qTFMpHdjYiwoHQbnG+hGmtRd4GFdBeanr5lqiQUcxhFSeZI7ArIYHV
         9Yrt/zy9zRnjfX1IlUMAvnxJPxqugBFIGSsVC7CVQCJu7Ke98Ay6f9tDahVPjcA/ggQL
         JBJe63xs73G1cb0yif1VTJbThigeXQGFigg9rHom4PGoShzt46e03tEgH1J09gjyc1Js
         3F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2mZLIb/d7YZpTqmjry/FkgH3XwX+mmbxMdE81w6snU=;
        b=O4P/iKeSezmSLksElDwX9LbaOZdwkjmdi3v7duk+RgcJ5ywqco9HGSa6kd9TOfP+UP
         eTFChzBDf7kd8SmzDLxX/+U6za+4A9HmGv/+MfgR/23RNOBOoQ8qB1WxVT5lly/hBQTG
         p4Y99iKQl9EJsRcLl1X6EwTX4K68xunQpTkJNL2636stoPBHZ6iekWxtG/NOj1PpmDcD
         dLQITfxNit2OCHlme5IvbAaQKLkGBhhtMbY6IkgDSjqCs1238aG8zi5nQWw0X2NtUvR5
         LLBx1FXsvpqMQuKetdP9YiUp3K8We0enGfY3YFZ8w16zwFkrbJFgQ5y/1mUQDA7tJovO
         2oOg==
X-Gm-Message-State: AOAM5326uVymVBm4JKH+XAL7aleqWez7esMWHuPfUlJbN7c63TSJ4Qih
        dapLZXnE5FJu2Ip1Er09Ko3BW5BzVjI=
X-Google-Smtp-Source: ABdhPJwBbSnH2kgFt/aQUG5kcI0pkqRuVIvf0sFHhOMXTOK8Pz82Vp7ZA7GroQ35UHS+xefzxMIRlg==
X-Received: by 2002:a1c:b103:: with SMTP id a3mr3862141wmf.68.1601656085088;
        Fri, 02 Oct 2020 09:28:05 -0700 (PDT)
Received: from contrib-buster.localdomain ([79.140.114.87])
        by smtp.gmail.com with ESMTPSA id z67sm2384663wme.41.2020.10.02.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 09:28:04 -0700 (PDT)
Date:   Fri, 2 Oct 2020 16:28:02 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
Message-ID: <20201002162802.GA15646@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cQXkP8vTNR+LJ4fZRT-an0vEgKxcFpfi+aQ-BdipTgq=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQXkP8vTNR+LJ4fZRT-an0vEgKxcFpfi+aQ-BdipTgq=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 03:19:27AM -0400, Eric Sunshine wrote:

> On Mon, Sep 28, 2020 at 11:50 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
> > This patch series introduces a new information on the git `worktree list`
> > command output, to mark when a worktree is locked with a (locked) text mark.
> 
> Thanks for working on this. "locked" is one of several additional
> annotations to the output of "git worktree list" which have long been
> envisioned. For reference, here are some earlier messages related to
> this topic:
> 
> [1]: https://lore.kernel.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/
> [3]: https://lore.kernel.org/git/CAPig+cSGXqJuaZPhUhOVX5X=LMrjVfv8ye_6ncMUbyKox1i7QA@mail.gmail.com/
> [4]: https://lore.kernel.org/git/CAPig+cTitWCs5vB=0iXuUyEY22c0gvjXvY1ZtTT90s74ydhE=A@mail.gmail.com/

Thank you for all this reference, it's really helpful. It is nice to see
that we already have few discussion on this topic that we can use and
work on top of that.

Sorry for the bit late response.

> 
> I'll leave a few review comments to supplement those already by Junio.
> 
> > This is the output of the worktree list with locked marker:
> >
> >  $ git worktree list
> >  /repo/to/main        abc123 [master]
> >  /path/to/unlocked-worktree1 456def [brancha]
> >  /path/to/locked-worktree   123abc (detached HEAD) (locked)
> 
> In [2], I gave an example of output similar to this but without
> encapsulating "locked" within parentheses:
> 
>     % git worktree list
>     giggle     89ea799ffc [master]
>     ../bobble  f172cb543d [feature1] locked
>     ../fumple  6453c84b7d (detached HEAD) prunable
> 
> I omitted the parentheses partly due to the extra noise they
> introduce, but mostly because I foresaw that a single entry might
> eventually have multiple annotations, for instance:
> 
>     % git worktree list
>     giggle     89ea799ffc [master]
>     ../bobble  f172cb543d [feature1] locked prunable
> 
> in which case, the eyes glide over "locked prunable" a bit more easily
> than over "(locked) (prunable)" or "(locked, prunable)" or some such.
> Generally speaking, "the less noise, the better".

Agreed. Without the parentheses is cleaner and it make easier to
extend to future annotations. I will drop the paretheses for the 
next patch version.

> > This patches are marked with RFC mainly due to:
> >
> >  - Perhaps the `(locked)` marker is not the best suitable way to output
> >   this information and we might need to come with a better way.
> 
> Taking [2] into consideration, I think it's fine to annotate the line
> with "locked" (sans the parentheses), and it's compatible with the the
> verbose mode, also proposed by [2]:
> 
>     % git worktree list -v
>     giggle     89ea799ffc [master]
>     ../bobble  f172cb543d [feature1]
>         locked: worktree on removable media
>     ../fumple  6453c84b7d (detached HEAD)
>         prunable: directory does not exist
> 
> in which case the short "locked" annotation gets moved to the next
> line, indented, and expanded to include the reason, if available
> (otherwise would probably not be moved to the next line).

The verbose mode seems like a very good extension for the worktree list
with the extended reason for `locked/prunable` on the next line.

> 
> I'm not suggesting that this patch series implement verbose mode, but
> bring it to attention to make sure we don't paint ourselves into a
> corner when deciding how the "locked" annotation should be presented.
> 

Doing a little investigation on the code, it seems the machinery for checking
whether a worktree is prunable it seems is already there implemented
on the `should_prune_worktree()`.

In such case, I would love to get started working on a bigger patch that
will implemented not only the annotation, but the verbose mode as well.
Specially because I was also thinking about how to make the "locked reason"
message available to the command output and the design proposed by [2]
sounds like a good way to manage that.

Additionally, having the ability to see the annotation and the reason in
case you see the annotation seems like more complete work for the intention
of the patch.

Unless you think that is better to start with the annotation, and some time
later addressing the other changes specified by [2].

> [2]: https://lore.kernel.org/git/CAPig+cQF6V8HNdMX5AZbmz3_w2WhSfA4SFfNhQqxXBqPXTZL+w@mail.gmail.com/

> >  - I am a new contributor to the code base, still learning a lot of git
> >   internals data structure and commands. Likely this patch will require
> >   updates.
> 
> Under normal circumstances, I would be hesitant to accept a
> contribution which makes an addition to the human-consumable "git
> worktree list" output without also making the corresponding addition
> to the --porcelain format. Thus, for instance, I would expect the
> porcelain format to be updated, as well, to produce output such as
> this (taken from [4]):
> 
>     worktree /blah
>     branch refs/heads/blah
>     locked Sneaker-net removable storage\nNot always mounted
> 
> That's a bit complicated because the lock reason may need escaping if
> it contains special characters (such as the newline in the example).
> Thus, I'm a bit hesitant to expect such a change from a newcomer.
> 
> More problematic, though, with regard to the porcelain format is that
> the documentation is so woefully under-specified, as explained in [4],
> that some people may interpret it as meaning that no additional
> information can be added. I'm not particularly sympathetic to that
> view since the intention from the start was that the porcelain format
> should be extensible[4], thus adding new attributes should be allowed.
> But I'm hesitant to ask a newcomer to undertake the task of addressing
> these shortcomings. As such, I think it may be okay merely to change
> the human-consumable output as this series does, and leave porcelain
> output for a later date if someone wants to tackle it.
> 
> A reason that it would be nice to address the shortcomings of
> porcelain format is because there are several additional pieces of
> information it could be providing. Summarizing from [1], in addition
> to the worktree path, its head, checked out branch, whether its bare
> or detached, for each worktree, porcelain could also show:
> 
>     * whether it is locked
>       - the lock reason (if available)
>       - and whether the worktree is currently accessible (mounted)
>     * whether it can be pruned
>       - and the prune reason if so
>     * worktree ID (the <id> of .git/worktrees/<id>/)

Thank you for the detailed explanation. much appreciated.

That something that can also work on. But I agreed that it could be bit
more work for a newcomer. I was thinking that I can split the work in 
three series of patches. 

  1. Implementing the annotation for the standards "list" command, implementing
     not only the locked but the prunable as on aforementioned in [2].

  2. A second series of patch that will introduce the verbose as defined in [2]

  3. Third and final series that extend the porcelain format.

I would like to kindly ask your opnion on this. Whether you think it will
be a good idea to implement all these changes this way and I can start
working on that.

I will change this series to become the first part of annotations, specially
because after reading your response and references, it seems this will be
much complete functionality that I would like to have on Git.
