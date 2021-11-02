Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6FC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E344C60EB9
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhKBRIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKBRIw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 13:08:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED144C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 10:06:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id l13so44295489lfg.6
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDmF7eqh0Aij6VOGszwuxYk69GP7FTMR7BAf8v4JSBY=;
        b=g/227CSMiOmORNa1r4qBSP2WwHe0yYNo49W3mPnO1spcVRWdid9At43rRSs8tWoGA4
         nqNZWeVNMW7/uXavn04wFsVPX8OyOBXLj8EooyD+ka+HilR3uTBcQ5xC/P0woMtgDCXn
         RNKB4dj+jEj2HFupDVLaHxyBIfD/UbI6a30e49Dgny2UQwPbkWy9TqroHlzYawlSozEJ
         L73L0yBq+jO/G/l3n2icHay0Sv3FGQ+npVejJxmdRmtV0z5/XpzjNyzl9hH2GEsXm6av
         8bpkN28XRbYSLTQl6sQpuTxtALnMPuEo17y9UuUbu62XwDh05T8EkVHBmCNm9JB4qGmA
         IEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDmF7eqh0Aij6VOGszwuxYk69GP7FTMR7BAf8v4JSBY=;
        b=SBaisP4BSVswQTGzU2YlDJn9vYQ0IPvWEGxpeRndGhBgQajvoJT2XSDM2Wh9lNHsHa
         62ocy3LAWSks5xon8WQli6gaadPFZRi2TC2V1yAGBEDM3ZvbXd/RS9EzkgQvvzBmKCUv
         TVyqkWlTmh0WmcljhJU1Des5LtZ6MYtqEqHrXDXhr34uFrn+Z1UUItx0SFhcYPtu2T9z
         lFkPzJtPn8a1Xq6NQgcS2H7vae13Av6Ra6nV9SIgfEpXNNjOu0K/7lROuJDgK5oie91V
         Q+LytUKCazGjj/kW6WYqy00Qzq0X6SKHQrTfiYbxnp5cbzRLh4mjZfYEqSM+ui48wIBH
         oyeg==
X-Gm-Message-State: AOAM532TV+dCwQ8HqbWE7OG8syt1tW0Tm/AVoFQ+ZyXOzSKfoGsvD2g3
        gIcyJ/N03OZ3abV1AQhRgcZBadTakFgTe4n3kZyyE0IaU/byA40f
X-Google-Smtp-Source: ABdhPJx9dC/o+MIo/d75kJci7nk/ndX7vDfAAZ2Rp2CZU9x+ZPrhBfB0lT0eBxCf6yi2qSPko4uEet9dDrSGgVKs+2Q=
X-Received: by 2002:a05:6512:b29:: with SMTP id w41mr35400454lfu.240.1635872775009;
 Tue, 02 Nov 2021 10:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8Xcm-ivTkPVpF3XwaniUeyM_RJVLY9wSvBKbr-7rUYgdmQ@mail.gmail.com>
In-Reply-To: <CACPK8Xcm-ivTkPVpF3XwaniUeyM_RJVLY9wSvBKbr-7rUYgdmQ@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 2 Nov 2021 10:06:02 -0700
Message-ID: <CAJoAoZm7uHaeTqj=CQU8CH6qfjn5b3V=EPpcm8VwSbbuLRRmqQ@mail.gmail.com>
Subject: Re: bug: invalid sha1 pointer in cache-tree
To:     Joel Stanley <joel@jms.id.au>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel, hopefully someone can correct me for being wrong about this ;)

On Thu, Oct 28, 2021 at 10:57 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello,
>
> I've filled out git-bugreport after discussing this issue with a git
> developer. I'm not sure if it's user error, disk corruption, or a bug
> in git. Any insight would be appreciated!
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> I was attempting to merge a tag into the current branch. Before I did so, I
> reset'd away a commit I didn't want:
>
> $ git reset HEAD~1 --hard
> error: Could not read 7c03aa457205afa2def273129653bea6225c5a0a
> HEAD is now at 387b8b425339 spi: fsi: Print status on error

I suspect you already had problems from this point, regardless of what
came after. What's surprising to me, though, is that the object 7c03aa
would be missing, since it should have been referred to by the current
branch you were trying to merge into.

Is it possible you were doing something slightly odd, like partial
clone, shallow clone, or working in detached-HEAD for some reason? You
didn't mention here that you had been rm-ing things in .git/, and I
asked you explicitly about that when we spoke offline, but that also
would worry me.

Regardless, I think once you've got a missing object and 'git fsck'
fails, there aren't many promises we can make about correct behavior
after, so I'm not sure I have anything to say on the rest of the
report, unfortunately.


> Anything else you want to add:
>
> I have tree git trees involved:
>
> linus, a clone of torvald's tree
> stable, a bare clone of the stable tree. it was cloned with a
> --reference to linus
> openbmc, a clone of a kernel tree that has a --reference to both
> stable and linus.

Ah, this is a hint and may actually be the winner... When you're
cloning with --reference, the "referenced" repo doesn't know who is
referencing it, so it sometimes can gc with abandon and delete
something you cared about in a referencing repo.

The workarounds here range from "if you care only about network speed,
reclone with --reference --dissociate" to "if you care about network
speed *and* disk space, do something fancy with 'git worktree' and
multiple remotes" to "if you care about disk space *and* you care
about insulating objects from accidentally going to the wrong remote,
get a bigger disk and use --reference --dissociate anyway".

>
> I did a fsck and saw this:
>
> error: 7c03aa457205afa2def273129653bea6225c5a0a: invalid sha1 pointer
> in cache-tree
> broken link from    tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66 (:)
>               to    tree 7c03aa457205afa2def273129653bea6225c5a0a (:configs/)
>
>
> I have since tried re-fetching all three repositories in turn, and
> this had no change:
>
> git fetch-pack --all https://github.com/openbmc/linux
> git fetch-pack --all
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch-pack --all
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>
> I also tried removing and re-cloning the stable tree (an the assumption that
> this is where the objects that make up the problematic v5.14.14 tag should come
> from), but this did not help. I have however changed the output of git fsck:
>
> $ git merge v5.14.14
> fatal: unable to read tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66

Yeah, I think this is the final decisive pointer to "this is an issue
with stable as an alternate to your other stuff" - I'd guess that the
object that's missing changed because the alternate links broke in
some way.

>
> $ git fsck
> ...
> error: 385b33c97554b2ab43b7dea822b34e10e9d7ce66: invalid sha1 pointer
> in cache-tree
> broken link from    tree 61a337aed7681b506b935b507a422fc5983ba4f3 (:)
>               to    tree 385b33c97554b2ab43b7dea822b34e10e9d7ce66 (:powerpc/)
>
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.33.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.14.0-2-amd64 #1 SMP Debian 5.14.9-2 (2021-10-03) x86_64
> compiler info: gnuc: 10.2
> libc info: glibc: 2.33
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>
> Cheers,
>
> Joel
