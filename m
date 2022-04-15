Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE10C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 13:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243708AbiDONNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiDONNm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 09:13:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A292D19
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:11:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t11so15266872eju.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qT4SzJd9RG3lWB2Ao7oJnH7lj/GzAdAW57hTXwUGQmE=;
        b=gjFJai5UIe0xvQfFYBixgMey8xJ9LbzFUlIb7+6v1J4I/Xabguie5h8TIcKJg/2S7T
         fKHLv3PA3XjNpC4fOt7Lk/9diO9LmtImlbNS2JcWeSG7kuiXiyFYIxdwOsw1f2BWupll
         0OBLy8S2xhhJo4cd4qGoOh/vLPSDzw5+fhHYiV4+fg1CSYtX3U3jaDQ8KNZqvICjpWF+
         k2SjeJlIghOlBhruzTRLgVpWHlwF9pQhUOmq6kxIM7aYqrlyfdPTIGYD29vGocZZB0vZ
         EQxCWu0hB1mQdv+qt6Omo0tK+hsLYR9ZfbZATLsSFdXVyJhAF7OUWs9WK9AquT8RKvZS
         J+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qT4SzJd9RG3lWB2Ao7oJnH7lj/GzAdAW57hTXwUGQmE=;
        b=W+/xpqywAOR1vGuqII3Mq4HrKKp5FuoGl6EESLw48AkQiEprBrAGYutfBCYJB+zx7r
         9QEykWySuZtjxWh9KSM+kM02Y5e6O8/RLFITRs4K1heMb/owrj6gDBBwK2YD2NfUSouh
         lFzhdJZk3ai9RvX7WkV4XoutQ+6J0ZtP9tXGOUOWWHmkVJF3C1gCbzU/u4dRAFMMJa0u
         GenYbmS5aW7gsOUwstVNrfgeZT9+NHbP7VIpjBScVmdzd3fKiilwdm3N8olijr9MnIU3
         Q3qqyKtjd4E33u6t8g99Yc8KT28evM+VtYifPCqNQRTA5sVRmonaFeYTFlaBF7+PzANn
         vq9A==
X-Gm-Message-State: AOAM530JAaPFI9IXEjmTI6zjFaNGpPtuQpQD0vE50NZ7Pw04Cjv+KmeX
        bo6LoMCbDoHaTuTQ7kYK4vM=
X-Google-Smtp-Source: ABdhPJxoVlQ1AxxX9cBGrOPYxo7O71NWv/r9nX//OIOOHQj2BAy2PcQXCPYr8ax3o4aiOh+viHvsUg==
X-Received: by 2002:a17:907:96a9:b0:6e0:db4a:ba8d with SMTP id hd41-20020a17090796a900b006e0db4aba8dmr6353736ejc.87.1650028269496;
        Fri, 15 Apr 2022 06:11:09 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jl28-20020a17090775dc00b006e05cdf3a95sm1696486ejc.163.2022.04.15.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:11:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nfLjA-005eIb-7s;
        Fri, 15 Apr 2022 15:11:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] fsck: detect bare repos in trees and warn
Date:   Fri, 15 Apr 2022 14:46:15 +0200
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20220406232231.47714-1-chooglen@google.com>
 <nycvar.QRO.7.76.6.2204071440520.347@tvgsbejvaqbjf.bet>
 <e81cdc6e-da42-d1d1-5d66-7d5e2a8aebbe@github.com>
 <220407.86lewhc6bz.gmgdl@evledraar.gmail.com>
 <kl6lee1z8mcm.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lee1z8mcm.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220415.861qxycx03.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Apr 07 2022, Derrick Stolee wrote:
>>
>>> A more complete protection here would be:
>>>
>>>  1. Warn when finding a bare repo as a tree (this patch).
>>>
>>>  2. Suppress warnings on trusted repos, scoped to a specific set of kno=
wn
>>>     trees _or_ based on some set of known commits (in case the known tr=
ees
>>>     are too large).
>>>
>>>  3. Prevent writing a bare repo to the worktree, unless the user provid=
ed
>>>     an opt-in to that behavior.
>>>
>>> Since your patch is moving in the right direction here, I don't think
>>> steps (2) and (3) are required to move forward with your patch. However,
>>> it is a good opportunity to discuss the full repercussions of this issu=
e.
>>
>> Isn't a gentler solution here to:
>>
>>  1. In setup.c, we detect a repo
>>  2. Walk up a directory
>>  3. Do we find a repo?
>>  4. Does that repo "contain" the first one?
>>     If yes: die on setup
>>     If no: it's OK
>>
>> It also seems to me that there's pretty much perfect overlap between
>> this and the long-discussed topic of marking a submodule with config
>> v.s. detecting it on the fly.
>
> Your suggestion seems similar to:
>
>   =3D=3D 3. Detect that we are in an embedded bare repo and ignore the em=
bedded bare
>   repository in favor of the containing repo.
>
> which I also think is a simple, robust mitigation if we put aside the
> problem of walking up to the root in too many situations. I seem to
> recall that this problem has come up before in [1] (and possibly other
> topics? I wasn't really able to locate them through a cursory search..),
> so I assume that's what you're referring to by "long-discussed topic".

Yes, I mean the submodule.superprojectGitDir topic.

> (Forgive me if I'm asking you to repeat yourself yet another time) I
> seem to recall that we weren't able to reach consensus on whether it's
> okay for Git to opportunistically walk up the directory hierarchy during
> setup, especially since There are some situations where this is
> extremely expensive (VFS, network mount).

I'm not sure, but I think per the later
https://lore.kernel.org/git/220204.86pmo34d2m.gmgdl@evledraar.gmail.com/
and
https://lore.kernel.org/git/220311.8635joj0lf.gmgdl@evledraar.gmail.com/
that any optimization concerns were likely just "this is slow in
shellscript" and not at the FS level.

There were also passing references to some internal Google-specific
NFS-ish implementation that I know nothing about (but you might),
i.e. what I asked about in:
https://lore.kernel.org/git/220212.864k53yfws.gmgdl@evledraar.gmail.com/

But given the v9 superprojectGitDir becoming a boolean instead of a path
in v9 I'm not sure/have no idea.

The only thing I'm sure of is if past iterations of the series were
addressing such a problem as an optimization that doesn't seem to be a
current goal.

As noted in those past exchanges I have tested this method on e.g. AIX
whose FS is unbelievably slow, and I couldn't even tell the differenc.

That's because if you look at the total FS syscalls even for an
uninitialized repo just traversing .git, getting config etc. is going to
dwarf "walking up" in terms of number of calls.

Of course not all calls are going to be equal, and there's that
potential "I'm not NFS-y, but a parent is" case etc.

In any case, I think even *if* we had such a case somewhere that this
plan would still make sense. Such users could simply set
GIT_CEILING_DIRECTORIES or something similar if they cared about the
performance.

But for everyone else we'd do the right thing, and not prematurely
optimize. I.e. we actually *are* concerned not with "does it look like a
bare repo?" but "is this thing that looks like a bare repo within our
current actual repo or not?".

> I actually like this option quite a lot, but I don't see how we could
> implement this without imposing a big penalty to all bare repo users -
> they'd either be forced to set GIT_DIR or GIT_CEILING_DIRECTORIES, or
> take a (potentially big) performance hit. Hopefully I'm just framing
> this too narrowly and you're approaching this differently.

As noted in the [1] you quoted (link below) I tried to quantify that
potential penalty, and it seems to be a complete non-issue.

Of course there may be other scenarios where it matters, but I haven't
seen any concrete data to support that.

Doesn't pretty everyone who cares about the performance of bare in any
capacity do so because they're running a server that's using
git-upload-pack and the like? Those require you to specify the exact
.git directory you want.

I.e. wouldn't this *only* apply to those doing the equivalent of "git -C
some-dir" to "cd" to a bare repo?

> PS: As an aside, wouldn't this also break libgit2? We could make this
> opt-out behavior, though that requires us to read system config _before_
> discovering the gitdir (as I discussed in [2]).

No it wouldn't? I don't use libgit2, but upthread there's concern that
banning things that look-like-a-repo from being tracked would break it.

Whereas I'm pointing out that we don't need to do that, we can just keep
searching upwards.

But yes, it would "break" anything that assumed you could cd to that
tracked-looks-like-or-is--a-gitdir and have e.g. "git config" pick up
its config instead of our "real repo" config, but that's exactly what we
want in this case isn't it?

I'm just pointing out that we can do it on the fly in setup.c, instead
of forbidding such content from ever being tracked within the
repository, which we'd be doing because we know we're doing the wrong
thing in that setup.c codepath.

Let's just fix that bit in setup.c instead.

> [1] https://lore.kernel.org/git/211109.86v912dtfw.gmgdl@evledraar.gmail.c=
om/
> [2] https://lore.kernel.org/git/kl6lv8vc90ts.fsf@chooglen-macbookpro.roam=
.corp.google.com

