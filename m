Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35EAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhLJJ5c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbhLJJ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:57:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5FC061746
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 01:53:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so28458051eds.10
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iETaU/yB9txot5L4NgoHBnMyBTzOyJF+dmOiogb98Cg=;
        b=mDe8J19ihU5Z7JWuczpLqRamFx5vMP+sQik2+9sJdquuYL6yIz+jVlTx/hh/Pgjun8
         /tUJIScaoZVccsYoMEH8jO5NgvbV6PW/VSo0t5sURDejuezofJR5tAQcZ8eK4X7Qj5Qg
         WftYLMiBRGSo4EtpeGfrmoLwOePzrJ5AtJY5t+v4elzr4tqaxXO0Tc+zg6yUDBE20a1j
         iQgjy0UbXtJv8912s09bomM3IraR3vX2qWMmY/lzq6/hWpJ+f+ZIhXEYytglZyvI8g19
         7oqtc1DFpv0vI8fapWxKR3wuo0QRpeWPuqzgODz/9wMQj0FckzUYZhQumo2JDtMeqgBr
         mZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iETaU/yB9txot5L4NgoHBnMyBTzOyJF+dmOiogb98Cg=;
        b=1COamYPO4lzU5Je2Z5rdc5XEoL6dCpy+7DUzzc/L08gu3rAet5VE3juFWlim+Wl1cR
         ajZxPVSJ76+vT+1LCI/gmhnoiZMWKOPn0MQl6zmmpFMjdM0/pdQKzrlefTTJT2oTwb9p
         jm5buXdSiKXunDKzpN6uEl9M2BJHQvlr7k+BVrgn47k7WPFLHYfR1Xvu2KM17mQsgTwu
         L72fhUq8VT2vSd2PWg3tLh7uuBpAPg1QFiQYTwd8dJZ8Pou0BajaISzQnKNGz37PCYLU
         PcQiRev98IuVJHX2TZTsJ6e+zm/P2ZPlonABIWfbAIn3xJsn+6DlnoiwzwKPCnxUO+0V
         xrjA==
X-Gm-Message-State: AOAM531wAJXN//H0gFASndBIBljkHkWu/SpASzS+ayi1uokSfDsNClfH
        v+2DmOQD0bvzwbRXrddWTuA=
X-Google-Smtp-Source: ABdhPJwAypc+ahsj6M/8+R1z7XK8zH4+LqfdYlgaJNxUhU9jJ1P/lvnh7rv9Q2nO9r/CshG+f1GV5g==
X-Received: by 2002:a05:6402:524a:: with SMTP id t10mr37589128edd.78.1639130035713;
        Fri, 10 Dec 2021 01:53:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa3sm1136826ejc.113.2021.12.10.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 01:53:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvcbC-000Ftd-DD;
        Fri, 10 Dec 2021 10:53:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Date:   Fri, 10 Dec 2021 10:30:12 +0100
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
        <xmqq4k7nmksi.fsf@gitster.g>
        <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
        <xmqqh7bi27o9.fsf@gitster.g> <xmqq8rwu278d.fsf_-_@gitster.g>
        <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
        <xmqq4k7htzpk.fsf@gitster.g>
        <211210.86a6h9duay.gmgdl@evledraar.gmail.com>
        <YbMUw70vfxJ+hJW3@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbMUw70vfxJ+hJW3@coredump.intra.peff.net>
Message-ID: <211210.86tufgdbv1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Jeff King wrote:

> On Fri, Dec 10, 2021 at 03:38:53AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I just don't think it makes any sense that I edit say refs.[ch], run
>> "make test" locally, but only see that something broke in scalar's
>> specific use of libgit.a later when I look at GitHub CI.
>
> I'm definitely sympathetic to this. Having been surprised by CI failure
> on something that worked locally is annoying at best, and downright
> frustrating when you can't easily reproduce the problem.
>
> But isn't that already true for most of the value that CI provides?
> While part of its purpose may be a back-stop for folks who don't run
> "make test" locally, I think the biggest value is that it covers a much
> wider variety of platforms and scenarios that you don't get out of "make
> test" already.
>
> In some of those cases you can reproduce the problem locally by tweaking
> build or test knobs. But in others it can be quite a bit more
> challenging (e.g., something that segfaults only on Windows). At least
> in the proposed change here you'd only be a "make test-all" away from
> reproducing the problem locally.
>
> I dunno. I don't feel that strongly either way about whether scalar
> tests should be part of "make test". Mostly just observing that this is
> not exactly a new case.

Yes. I'm not saying that "make test" should always run what a full CI
run covers.

Just that a proposed change that's really only adding one-more-test-file
testing a thing in contrib in the sense that we test
t/t9902-completion.sh should similarly be part of "make test".

>> If I'm preparing patches for submission I'll need to get CI passing, so
>> I'll need to fix those tests & behavior either way as it's
>> in-tree. Knowing about the failures later-not-sooner wastes more time,
>> not less.
>
> I think there's probably a tradeoff here. How often you get a "late"
> notification of a bug (and how much of your time that wastes) versus how
> much time you spend locally running tests that you don't care about.
>
> I do agree that CI presents a bit of a conundrum for stuff at the edge
> of the project. It's become a de facto requirement for it to pass. In
> general that's good. But it means that features which were introduced
> under the notion of "the people who care about this area will tend to
> its maintenance" slowly become _everybody's_ problem as soon as they
> have any CI coverage. Another example here is the cmake stuff. Or the
> recent discussion about "-x" and bash.
>
> I wonder if there's a good way to make some CI results informational,
> rather than "failing". I.e., run scalar tests via CI, but if you're not
> working on scalar, you don't have to care. Folks who are interested in
> the area would keep tabs on those results and make sure that Junio's
> tree stays passing.

I think if we're not caring about its failures in combination with
git.git changes there wouldn't be much point in having it in-tree at
all. That would just be like what we've got with git-cinnabar.git.

I would like it in tree. I just don' think the test/CI setup needs to be
a special snowflake.

> That view disagrees with the final paragraph here, though:
>
>> The reason we do that with the completion is because some changes to
>> e.g. tweak getopts will need to have a corresponding change to the
>> completion.
>>=20
>> The reason we've not done that with contrib/{subtree,mw-to-git}/ is
>> because those are thoroughly in the category of only incidentally being
>> in-tree.
>> [...]
>> Scalar is thoroughly on the "completion" side of that divide, not
>> "subtree".
>
> I haven't followed the discussion closely, but in my mind "scalar" was
> still in the "it may live in-tree for convenience, but people who aren't
> working on it don't necessarily need to care about it" camp. Maybe
> that's not the plan, though.

Since v1 of the series[1] it's been compiled unconditionally, and there
have been tests. We just didn't run the tests.

In v6 the tests started being run as part of CI, which was ejected in
v10 due to "[an] unrelated patch series does not interact well with
them", which as I noted upthread in [2] isn't accurate, so I think the
stated reason for ejecting the CI from the proposed topic doesn't
reflect reality.

Since then 1d855a6b335 (Merge branch 'ab/ci-updates' into next,
2021-12-07) landed, so I'd think that any narrow tweaks to get the CI
working could be based on top of that topic.

1. https://lore.kernel.org/git/pull.1005.git.1630359290.gitgitgadget@gmail.=
com/
2. https://lore.kernel.org/git/211207.86ilw0matb.gmgdl@evledraar.gmail.com/
