Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6996C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiCGMQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCGMQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:16:30 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264167F6C3
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:15:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id c20so1150127edr.8
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BHAYr60rw4Q4SqOsUFsA/nxIDlMg+erd4cS0HfMxUbQ=;
        b=Hp5mk1eHIFrLj8s/HX1nfgEscaK1l9h5Zsv/QWnVPGjTBZCCLUiCo+I1JHeVSON2RP
         fJ7W1Pm1BzPRy5GVgMdXjvBojAD+NI9Ckc9tPvwi3LWANmB9Fa2I5w2VgCFPCrdyUqnG
         f/js5c7Dq5Sif/NV7U7aaFdENByAfDOpr+TTOpBYgyKjOSheIR6OLwxc4MCD/gUM7tnF
         UkXyrt9o0EVfLGysvSisGPyVKSwtL0JAMSCBkAcCQJEWdKN0UJdbZRayNIyc1dsOWpcC
         mLRYoNWo+vspQXBy0Z+HqQOnNvZPYGH9KHx+YvsRDYz9HgbSpYU85ufky+ZlcaH0BWA7
         N9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BHAYr60rw4Q4SqOsUFsA/nxIDlMg+erd4cS0HfMxUbQ=;
        b=l2ig4iQUmX5vCMAt4wiI8vSEG0DdQy79QVznMGE64NCghaBeC1HSF+MMbkAXWPCzi5
         5Xa/VesC0/MF5RyXfrpGYxbaOQrdIfNbDTUtj2wSfOT+KjdCvAasCa/7Gfoe9XoHl4XA
         0VljhqdDgDDkd0YRI9EDK6GpYhkG6PjEQDfQAwiVcu/T+iYg8NegsaSQkLghxEPNyjL6
         Kal8d4S8T8rxWJ8hx6f5/J0u968puY7jNZO7NByjaZ5tnt7CNmaXjSb66PvTB0bHZjO5
         iY/p9mdTnui2r2hnG7+KNhtx09AkvPtCNsz5fQHmFjCmGtAYdYSLbut4FZSBfDD4ttbL
         Bh+A==
X-Gm-Message-State: AOAM532LDA6JLqglMThv1hRRQPYnZBp74wbysacMa4pDEuaFKX6x/dz8
        0mOuNjY8OgnANpsyATnS8sY=
X-Google-Smtp-Source: ABdhPJy4x9CSD/Tgc9JHDsdCIfp8NbHzikV+7ibTH9yIEVQxPUqbSaOgAK7D3JHp5FA4D7Ek1ucahQ==
X-Received: by 2002:a05:6402:440b:b0:415:c50d:853b with SMTP id y11-20020a056402440b00b00415c50d853bmr10732138eda.346.1646655334412;
        Mon, 07 Mar 2022 04:15:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7db89000000b0041372781e69sm6006933edt.52.2022.03.07.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:15:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRCGz-001TcE-B5;
        Mon, 07 Mar 2022 13:15:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, git <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: What does it mean to have multiple upstream tracking branches?
Date:   Mon, 07 Mar 2022 13:12:13 +0100
References: <CAPMMpoiTJAuadBEOPWOVa-kguSXMDvAhvD22B63QwYpu=H7xEw@mail.gmail.com>
 <220303.868rtr42mg.gmgdl@evledraar.gmail.com>
 <kl6l4k4ek73o.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqzgm2vjab.fsf@gitster.g>
 <CAPMMpoh38fm-jNi=GD+uf6O+JLiJz-ue2zh5ceWpwmTYBRKzvw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPMMpoh38fm-jNi=GD+uf6O+JLiJz-ue2zh5ceWpwmTYBRKzvw@mail.gmail.com>
Message-ID: <220307.86a6e20xi2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Tao Klerks wrote:

> On Sun, Mar 6, 2022 at 10:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Glen Choo <chooglen@google.com> writes:
>>
>> > Not that I would ever _recommend_ someone to work like this though.
>> > Junio also wondered whether anyone uses this [1].
>> >
>> > [1] https://lore.kernel.org/git/xmqqbl2hw10h.fsf@gitster.g
>>
>> I actually think the current octopus behaviour is a sensible one
>> (after all, that was what we envisioned how it would be used when we
>> did the mechanism long time ago).  If you have mutliple, say source
>> and docs, groups working for you and you are taking their work from
>> time to time, something like this:
>>
>>     [branch "main"]
>>         remote = central-repo
>>         merge = sources
>>         merge = docs
>>
>> would let your folks push into the central-repo, and a "git pull"
>> will help you advance your main branch that you'll publish later.
>>
>> You can explain multiple .merge entries for such an integration
>> branch like I just did and I think such an explanation makes perfect
>> sense, but these are quite different from what we view as "upstream"
>> in the traditional sense.  In the setting illustrated here, yours is
>> the main integration repository, the center of the universe, and
>> those folks working in the 'sources' and 'docs' groups view yours as
>> their "upstream".
>>
>> So, "what does it mean to have multiple branch.*.merge entries" has
>> a good answer: you are integrating from these contributors and these
>> entries are not your "upstream" in the usual sense---you do not even
>> push back to them.  Asking "what does it mean to have multiple
>> upstream" makes little sense, I would think.
>>
>> Now, with the 'main' branch used in such a manner, if you did
>>
>>    $ git branch --track=inherit topic main
>>
>> and worked on the "topic" branch, you do not push back to either the
>> sources or docs of the central-repo, of course, but it is unclear if
>> you even want to "pull" to create octopus from these two branches at
>> the central-repo, which essentially duplicates the pull's you would
>> do on your 'main' branch.  I suspect that you'd rather want to merge
>> updates 'main' accumulated (or rebase on them).
>>
>> The reason why I asked what Josh's plans are for the multiple .merge
>> entries in that thread [1] when the "--inherit" feature was being
>> invented was exactly about this point.  I wondered if last-one-wins
>> may make sense (and as the above octopus set-up tells us, it may
>> not), but if we want to keep "multiple .merge entries means an
>> integrator making octpus merges", then it may make sense not to copy
>> them when there are multiple with "--track=inherit", to avoid
>> spreading the "curious" nature of the branch like 'main' depicted
>> above.
>
> Given that the notion of "inherit"ing the tracking configuration is a
> (relatively) new one anyway, and given the slightly esoteric nature of
> the "multiple branch merge entries lead to octopus merges"
> functionality, I would argue that it makes more sense to die when
> branching under this specific configuration, saying something like
> "inheriting the tracking configuration of a branch with multiple
> branch merge entries is not supported - we think you're making a
> mistake".

I don't know if this is plausible in this case, but we need to be very
careful with that in general. I.e. some people might set the "sensible"
default remote config for "origin" in their ~/.gitconfig or whatever,
including "merge" for a "master" and all.

Then expect that if they have a local repo that we'll take whatever
custom values there to override them, if any.

So for most config variables that take a "last set wins" it's a feature
to ignore any previous entries.

But in this case it might be different due to the odditity of the remote
config, how we almost always manage it with "git remote" or "git clone"
etc.

> Skipping the creation of tracking entries in this case, even with a
> warning/explanation output to stdout, would be a "slightly hidden
> surprise", in that git command output is often not read by, or even
> visible to users when a command is successful, eg in a GUI.
>
> If we think this will basically never happen and really makes no sense
> anyway, as Junio seems to suggest, then I would argue the extra
> complexity in the codebase to support the "inheriting multiple branch
> merge entries" is unwarranted.
>
> Either way, I will happily drop this topic as it does not appear to
> require follow-up in direct relation to my "--track=simple"
> work/proposal. On the other hand, I'd be happy to work on a patch to
> eliminate this multi-tracking-branch-inheritance path/support (undoing
> some of Josh's work here) if the team believes this makes sense.

Just on my side: Don't take any of my comments in this thread as a "we
shouldn't do this", it was genuine confusion, thanks for clearing it up
:)

Perhaps a gently step into adding validation for this (if needed) is to
do the die()/advise() or whatever or the write (i.e. when we copy
branches, or use --track=inherit) v.s. when we use the config (in "git
fetch" et al) ?
