Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065CEC433DF
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21012065D
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=calebgray.com header.i=@calebgray.com header.b="QhyPWbcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgENVdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgENVdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:33:19 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58BC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:33:18 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id z3so31066vka.10
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=calebgray.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ZMSo+68M1KSd/UxDcckQB3CQFTZEpybUBsgBB82fzlU=;
        b=QhyPWbcRIjeroKJiYz2PBiFnSDRwSagIPnzJB5I3OAshxj/iu0pCs1R1iwSgi6ucMi
         cFjABSC7FgNtMVBLz1sX9GaZrISq3iJztkEuSDblUBXrFrF3kN4/D6s8XbGRnHN/+HKC
         CM8RBxLpZHS0cl7Juq3X0RUh43NV7TykEbv1hOF4vWh8dGvj9jfeMOEuZSSJA3ydPBDO
         Hy17toJgPhJ02b1XoIlZV7A6kc7wW+2gPZ7Sb3BldyQzzfuaJJhtb1LhD0qGHE0WuQ0j
         o1iNEfnfhQ2460+emP4Vr/uoYU0nbyKDAVFfSVvDxbgZ//jBX1QC95Zne6ilLQ25pCKP
         RjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ZMSo+68M1KSd/UxDcckQB3CQFTZEpybUBsgBB82fzlU=;
        b=t/8nk7ElYfDjpM4L34IiK/wUDtRR+t8jxfVZCDBOOlFyOIKYTmySUFeCCPj/3OEcF4
         w51SwtGWbQSOBgLtW1kJExAZRd13gpt3PbtupyvzRqb/FIvubFZbRrNyqsxRgzOy6/bt
         PtYH/JThVRepveDF4NyuihcHX0DJJfhaDCFi9X/2hwgSYOQ5qmMsKzvXZWi1EyBU5viM
         Lp/WK2QXt8ZsLuLs7eFATGZHhJ2x198MmAAZ6EspgwslftMzyAs4hwThPH3OEHQG3Pkq
         msel/rbr+cyPjfpKSWQgaOeKXGikbj1rDQBNR36inLGhgFs3GqFHlEP25IT6trOjNGRj
         9NIw==
X-Gm-Message-State: AOAM5300d/DqzVa+aPxkOtyDNwnl9ed4udN7W5LsY6W9J+2CwGyN5eym
        +FME6xNqeE2MW3ufi5HR+Lir+NNKKbsArtRGxY2CH7fTgdw=
X-Google-Smtp-Source: ABdhPJxn86K9F/bG9/qBVzV2/xSR0iVMK8qMsX8DN8fi6ZYfzURGg1jWqqONcwBKghllctbc/qb42F5aZeMIid3/C/E=
X-Received: by 2002:a1f:a24d:: with SMTP id l74mr451786vke.8.1589491997193;
 Thu, 14 May 2020 14:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local> <20200514210501.GY1596452@mit.edu>
In-Reply-To: <20200514210501.GY1596452@mit.edu>
From:   Caleb Gray <hey@calebgray.com>
Date:   Thu, 14 May 2020 14:33:06 -0700
Message-ID: <CAGjfG9bsQh2C6WP242v4LoiaSdghZDPuqns0VO82Txe-V54_KA@mail.gmail.com>
Subject: Re: Add a "Flattened Cache" to `git --clone`?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To Clarify: I'm talking about a server-side only cache which behaves
much like a `tar` file: it is a flat version of exactly(*) what ends
up on the client's storage. When a client runs `git --clone` and
there's a valid cache on the other end, that's all that gets streamed.

Konstantin's point that a repo like Linux is bound to see little/no
benefit (in fact, it'll just constantly invalidate/rewrite the ~1gb
cache) is reasonable. This feature definitely targets the "niche"
audience of repos with less-frequent-pushes-to-master-than-clones.

Bryan is exactly on the right track for what I'm referring to: the CDN
approach did come to mind (and is superior in nearly every way).

Junio nailed it: I'm not hoping for anything revolutionary here, just
hoping to reduce the redundant steps in clone down to a single
(presumably faster) step.

If the community agrees that there's little/no benefit to the
limitations of having a "cache for master and that's all," I'm also
more than capable of designing a more useful/complex graph/reduce
based solution which could dynamically bundle the most statistically
relevant data for whatever context the code is working in, though-- I
can't commit to any sort of deadline for that sort of a contribution.



On Thu, May 14, 2020 at 2:05 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 14, 2020 at 04:33:26PM -0400, Konstantin Ryabitsev wrote:
> > > Assuming my idea doesn't contradict other best practices or standards
> > > already in place,  I'd like to transform the typical `git clone` flow
> > > from:
> > >
> > >  Cloning into 'linux'...
> > >  remote: Enumerating objects: 4154, done.
> > >  remote: Counting objects: 100% (4154/4154), done.
> > >  remote: Compressing objects: 100% (2535/2535), done.
> > >  remote: Total 7344127 (delta 2564), reused 2167 (delta 1612),
> > > pack-reused 7339973
> > >  Receiving objects: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
> > >  Resolving deltas: 100% (6180880/6180880), done.
> > >
> > > To subsequent clones (until cache invalidated) using the "flattened
> > > cache" version (presumably built while fulfilling the first clone
> > > request above):
> > >
> > >  Cloning into 'linux'...
> > >  Receiving cache: 100% (7344127/7344127), 1.22 GiB | 8.51 MiB/s, done.
> >
> > I don't think it's a common workflow for someone to repeatedly clone
> > linux.git. Automated processes like CI would be doing it, but they tend
> > to blow away the local disk between jobs, so they are unlikely to
> > benefit from any native git local cache for something like this (in
> > fact, we recommend that people use clone.bundle files for their CI
> > needs, as described here:
> > https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).
>
> If the goal is a git local cache, we have this today.  I'm not sure
> this is what Caleb was asking for, though:
>
> git clone --bare https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git base
> git clone --reference base https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git ext4
>
>                                                         - Ted
