Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7CDC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784AB2223D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 13:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405057AbhAZNqO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392686AbhAZNpH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 08:45:07 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED723C061A29
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 05:44:26 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id l9so23003284ejx.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 05:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=R+3JdKTG2XQBKknHH5opT4dxdv4Cf/f0K+rKCOoaWsE=;
        b=noY9rm96RUNainqipjhHcIfz0TYcGRxCbns6SfQuLsWgCz5vDFxuIN3gkLjuYi4qE+
         e2Mi/OlmquoeTtYXn06yarRR0R4UVO9R6PDiD/pq8hzt0t9Ywh6iTMCjvqOgLv0B4cyP
         n2M5u0iQSNTQ/9IjVz1M6/VYQQpENLLZ5ocZL2pGOqIgJHo+cQdD3BJZxrCi+gxL6byk
         NT9uGLIa8hRIJClCeDiZVIsqFsGKiALsk4C/TS0PaOfjeokteUyalgOjvhO/wt7hWjyG
         KlmX+Ifdn8KhcoN5yFV4aZnI0HtdMP3aYDIF8KfEMhfBlF1uAu+FkJB3JF+1a//3MRVz
         TJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=R+3JdKTG2XQBKknHH5opT4dxdv4Cf/f0K+rKCOoaWsE=;
        b=XNY51KL2XOpI643y54t1qaiuPcs0hxS0v9EOtAN8Y9oAlZtAiCCYvtG/2MQWsem3tV
         i1/inzoqog1Hh4BQxWX/vhuUzbxvUj+VrAI43zc1DQVoZWEKZCLqorsgQtzm1GISPoq5
         uSonezJc+4HJPJEYDJDxdERWRg09ffPaCH3hjmXOA3CauesM1fJQrGzh8N+BAgRWKv6E
         HT/iYG7YJYk3BdT9t8++9Y3inTdcT2WAkk57EUyVSKNsJUmR0PW1dxLcOkRcp4jXARuT
         gmhhjAARo+IUq0sQYkFImVuGEgA7wpolacjDOSLLdFfl+eo0RCstdGqYihaBXha61Ido
         J6Uw==
X-Gm-Message-State: AOAM530rc8AwRuLtPlCpA033b9eMxWVfeVelOGWoV0OFpvg18uN3ARp/
        JWtPZUzA4m5G12KSVa6nX7vQbRfUfqvohw==
X-Google-Smtp-Source: ABdhPJzdXaBZs8EAHt8GskQkrgs3834FfP01iqU3iY6BYqYVy9Q/oM3j7D5OY2KsXfmv3YfpquuOQw==
X-Received: by 2002:a17:907:1b10:: with SMTP id mp16mr3543440ejc.482.1611668665293;
        Tue, 26 Jan 2021 05:44:25 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id l17sm3080133edr.75.2021.01.26.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 05:44:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 13/15] Reftable support for git-core
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
 <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com>
 <CAFQ2z_Py46k71fHyBHyS2jqjhJJm-N0AV4X8YZZVawoZyVyhAg@mail.gmail.com>
 <CAFQ2z_PPnmCHYvse-V8QG2zG2MouHxuvraMmWD=cv_bRWpakEA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <CAFQ2z_PPnmCHYvse-V8QG2zG2MouHxuvraMmWD=cv_bRWpakEA@mail.gmail.com>
Date:   Tue, 26 Jan 2021 14:44:23 +0100
Message-ID: <871re77qyw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 21 2021, Han-Wen Nienhuys wrote:

> On Thu, Jan 21, 2021 at 5:14 PM Han-Wen Nienhuys <hanwen@google.com> wrot=
e:
>>
>> On Thu, Jan 21, 2021 at 4:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > I must say I do find it a bit more concerning in the case of the
>> > reftable series. I.e. the git_reftable_read_raw_ref() function seems
>> > like a faithful copy of the general logic (at least this part) of the
>> > refs_resolve_ref_unsafe() function in refs.c.
>> >
>> > That I can remove error checking/handling from this place means existi=
ng
>> > general logic was faithfully copied without checking that we have a te=
st
>> > for it, or adding one. Or perhaps given the history of this codebase
>> > there's out-of-tree tests for it somewhere?
>>
>> One of the earlier iterations of this code didn't have the errno
>> handling, and it caused a bug that I tracked down to the errno
>> handling. I'm fairly sure of this, because I remember being perplexed
>> and flabbergasted at using errno as an out-of-band API mechanism. The
>> first iteration of reftable code was about a year ago, so if you
>> checkout the Git source code from that time, and remove the errno
>> assignments, you would be able to see which test exercised this code
>> path.
>>
>> Or you could check where errno is read-back (I believe ENOENT is the
>> case that has special meaning)
>
> In refs.c, there is behavior that depends on errno,
>
> if (refs_read_raw_ref(refs, refname,
>       oid, &sb_refname, &read_flags)) {
> ..
> /*
> * Otherwise a missing ref is OK. But the files backend
> * may show errors besides ENOENT if there are
> * similarly-named refs.
> */
> if (errno !=3D ENOENT &&
>     errno !=3D EISDIR &&
>     errno !=3D ENOTDIR)
> return NULL;
>
> blame tells me it has something to do with dir/file conflicts and
> commit a1c1d8170db.

I'm aware mostly of what the code is doing. Yes some of it's used, some
of it's not.

My upthread [1] wasn't clear enough, the intended message was "hey this
new major refactoring/replacement of a core git format still has zero
coverage on at least some of the code it seeks to replace" not "hey
what's this thing in refs.c doing?".

I.e. lack of test coverage on refactored code as part of a big patch
series is a lot scarier than the same lack of coverage on existing
long-established code we'll either not update, or in small incremental
updates.

So it was a gentle prod to maybe look into what the state of that in the
reftable series as a whole is and fix the coverage gaps. I'd like the
feature in git.git, but this series has been stalled for a while. I for
one would feel a lot more confident in reviewing it if I knew I'd just
discovered an outlier case.

But in any case, when I wrote[1] I didn't know about / had forgotten
"make cover". As noted in t/README that can even give pretty HTML
output. It takes ages to run so I haven't run it on your series, but I
ran it on master a couple of days ago and it flagged those (and other)
parts of refs.c.

So perhaps running it on the reftables series will find some useful
cases to make up the test difference / potential bugs.

Of course 100% line coverage isn't practical (hitting every BUG(...)),
and even 100% line coverage !=3D 100% test coverage. But it's a very good
first stop to see glaring omissions. E.g. the refs.c cases I mentioned
where we'resetting flag "xyz" in a() and then acting on "xyz/!xyz" in
b().

1. <871ree8eto.fsf@evledraar.gmail.com>=20

