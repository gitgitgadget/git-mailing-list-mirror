Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545FC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A8D613B1
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhFCMyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFCMyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 08:54:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE3C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 05:52:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so6953357edu.10
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dqfIK2LC8P9e8ng5YQFcw3NcYA58kNWqSWIZPPgr2fI=;
        b=ftVIPix/tv9eRJvphhwtdHCB4xjux7Onl68xXgi0eSJTtzYWeTMRxuxHfoDEgwVjDc
         V6CEyb1z6kfVYVqh7FobDDGjsdjSUTXyxt5zrwj5We5POmRjJTXv6ml1IFNMgMEMggyJ
         l6oP/gTf9pv8irXtJz8kgSMH0qyM67jtBzwNAhdCPqM0ureOVQY5rPh0HRpfyxzlyvT/
         ti4B6DVwchVYKnWJB0q3D7Vy+XaUEQ6qYy4j6ZSDl4MPUUjYfLwTFgYlYobf7NuNSA+0
         8o9X38YBKMHfd7D+XxHA1LtoRoh46XK9bEIsc1vIdz0PvvOgDchFnSdu8jnP5xy+3zC0
         OHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dqfIK2LC8P9e8ng5YQFcw3NcYA58kNWqSWIZPPgr2fI=;
        b=JAsOWu8fQk9f/D3Tp8zFICgX3V5GRRYZz/77BSGm/tAcXvK5Xkj20g8/VIoCOxLG32
         R6lokmRIMfENbCaKyRy9WfmvWIsoclO212UDnwCyBr/eTwNDkusjh6Rob0oh/MEJFS9t
         98EJlA2cJqG+VmeJRZGoDb9tX8X0bbizrP3+Uz0I9KRd2Zd8Ep8wXLLlIz9x1M6ZwkTX
         RSqeKygLpbKzXUA6Pxj3zxRpUVBud8A5Sax+bZQezk9VIdiif/qLjjVWHpoCrhRydAZO
         BpTMElqxbZQlQLqRML9yrCYkWQrYZOhpAs5EGF1IvCBTOYoyWglrPb21Iwf5CiubVAJy
         nMVg==
X-Gm-Message-State: AOAM531mjsNJmNr4lavWB75289c1e1FvgN+YDj00+jkpohulb9M2EO2O
        LOaJ7uN7twg8aImchXRLTRU=
X-Google-Smtp-Source: ABdhPJxEj8xiPdfqhJFdI25hfkF4v3/S+xQGl9Q3CubGtJRi9FBjK5H76hl/J3QQKF0jJkk2hMbTyw==
X-Received: by 2002:aa7:d610:: with SMTP id c16mr33992721edr.207.1622724752062;
        Thu, 03 Jun 2021 05:52:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v19sm1488165ejh.86.2021.06.03.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:52:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
Date:   Thu, 03 Jun 2021 14:31:59 +0200
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
 <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
Message-ID: <87wnrb5cvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> So I skipped the "disable most config", but for what it's worth I think
>> I'd miss these the most, I couldn't pick just N favorites, sorry:
>>=20
>>  * diff.colorMoved=3Dtrue: super useful, but I'd be vary of turning it on
>>    by default in its current form. E.g. on gcc.git's changelog files it
>>    has really pathological performance characteristics.
>
> Very nice! I didn't know about it. I'll pick it for my third day.

It makes patch review a lot easier, and also integrates nicely with -w.

>>  * merge.defaultToUpstream: ditto other discussion, should be "true" by
>>    default.
>
> That is the default. I used it as an example of a configuration that
> changed default (I did it in 2014).
>
> (I just noticed the documentation of the config wasn't updated).

Ha! Maybe it's leftover from before then, or I missed that in the
not-updated docs more recently.

>>  * checkout.defaultRemote=3Dorigin: I introduced this, so I'm biased, but
>>    I find it super useful. Usually because I do "git branch -m
>>    new-branch" on master to create topics, and then "git checkout
>>    master" to get a master back (or use the existing one).
>
> That is useful, but I don't think it's aptly named, it should be
> something like checkout.autoUpstream. The name of the default branch
> belongs elsewhere.
>
> I would say core.defaultRemote.
>
> Right now for example `git fetch` defaults to a hard-coded "origin".
> Doesn't make much sense that the remote for automatic upstream checkout
> can be configured, but not the one `git fetch` uses.

I think there was some bikeshedding around that time. I share the
sentiment, but worry about "core" over-configuring such a
thing. E.g. wanting "checkout" to search a "upstream" and "origin" in
that order (not that it supports a list right now, but could) !=3D wanting
"init" to use "upstream" instead of "origin" by default.

>>  * commit.verbose=3Dtrue: so you know what you're looking at in doing in
>>    "git commit --amend".
>
> Aha! My alias had `commit -v` but I would want this on all commit
> commands.
>
> Moreover, I was thinking on suggesting this by default. Who would it
> hurt?

E.g. "git rebase -i" with "reword" now becomes a lot more verbose, I
think it's a feature, but others might disagree.

It also exposes various edge cases around our parsing of the diff
v.s. commit message content in our apply.c etc. code, e.g. say you want
to blindly search-replace "diff" with "difference" in your commit
messages. You'll now change the "diff --git" line to "difference --git",
and now "commit" won't detect that it's the patch part anymore, and
merge that diff into your commit message itself.

I can't remember if we pick up on "diff --git" exactly, IIRC, but
anyway, whatever part of the format you need to screw with, the point
stands. I've run into mistakes like that in the past, one recently made
it to this ML.

>>  * grep.patternType=3Dperl: Another personal soap box (but really, BRE
>>    anywhere sucks).
>
> Nice. `git grep` is the #2 command I use the most, and I often need to
> specify another regexp because the basic one doesn't understand what I'm
> trying to do.

Yeah, it should be at least ERE by default, Something for Git v3.0 ...?

>> I also have a bunch of aliases that would not be useful to a general
>> audience, but which I find I can't live without, some of the most
>> commonly used ones:
>>=20
>>     # Log with "less" n/p already going to the next/prev commit
>>     log-psfd =3D "!f() { PAGER=3D\"less -p'^commit'\" git log -p --stat =
--full-diff $@; }; f"
>
> Very neat.

I think similar to your "git help xyz" patches having coloring, we
really should consider things like that by default knowing that we're
invoking "less". I.e. if we got over the notion that our job is just to
throw data over the wall to "man" or the pager without any further
tweaking or integration.

>> Similarly rebase is "r", "--interactive" is "ri", "--abort", and
>> "--continue" are "ra" and "rc".
>
> I have almost the same, except rbi, rbc, and rba. My 'r' is reset, but
> since I use rebase more often I guess I should switch them up.
>
> Theres are a couple of mine:
>
>   advance =3D merge --ff-only
>   undo =3D reset --hard @{1}
>=20=20=20
>> If anyone's interested in the rest / full set:
>> https://github.com/avar/dotfiles/blob/master/.gitconfig
>
> Is thata private repo?
>
> Here are mine:
>
> https://github.com/felipec/dotfiles/blob/master/.gitconfig

Yes, it was private[1]. I've made it public again.

1. It used to be public, but then the security/auditing people at an
   ex-job kept pestering me about me hardcoding =C3=BCber-secret company da=
ta
   in public GitHub repos.

   They didn't find questions like "uh, you mean this information we
   advertise in an MX lookup to our public nameservers?", or "yes,
   that's my company E-Mail address in a config file, my co-workers have
   the same info on linkedin" all that convincing. Anyway, it's back now
   :)
