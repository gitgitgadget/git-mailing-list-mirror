Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E66FC433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB48613F4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 16:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhD1QlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhD1QlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 12:41:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98418C061573
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:40:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u17so95698572ejk.2
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OVEy1bqEzFwCk31a72UV7InpI209Y904IkJ8+tjGiW4=;
        b=VFiwvroUN+0mJE6fWJ7UsGtj8CNIc7wGF2S+K0Fdk/kBhfK9sRaZR9E9oFrbzeCAWX
         Z5/OefL5Bmr1z+gUi6U4exj23q8qfjNbSSLhrQmya+rYCguax/7MPAL35eX5lmDguGRp
         mxy2590yd+PtO6pkJgXlXB4AcaQFG4GNVLlxggxAA6vRSV/p7EDMKxY89Fwq2e6shmqc
         s1Gc9orP7xOPdGBXJBBLqvexyy6vNXJrcy6hUwoMZijYoZKYg41FAK82WbfgLW+9y0Tz
         3r1DhDmJlYGxEK/Z6GV6vXBVvme4hslQgRRvYQ0qF1r+Jt52NPGDcXNzGfyIgeIhuZax
         7/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OVEy1bqEzFwCk31a72UV7InpI209Y904IkJ8+tjGiW4=;
        b=EQoZhaGd7nu5flLNyVeQ64JX6YnvOzqqL1/cQ3nDS8w0cRabBUg4iG6mfc1sImUA5e
         sqGgYD+42vkXPUudC/PZCJEYQKHcjunCtVVCLGk0bbIQ1yKL6N2svzzJ6sbYifwFc5sA
         m5DxvEQAHvu3Qp1MfnK2hm8osfsyoRkuWAYL/QCI2FmmWOWoruRgTMfwL4OCJC4EA1h7
         pGED4dbcbulOgagsjUKSaRCAO0xgo7CZndoOUKRzY/pRFCPAOY24FcpLRf2/s2CxHzXp
         ozWBIHQd6M5Relly7NDh9njHZlMrE2zr8jeAFWl6w9FUlgDQ2kEyPU8fngMt2SmY7znX
         3D5g==
X-Gm-Message-State: AOAM533Fg/Xkq4eCziWZ39Bgw6UlnuzSk8+W2AK76y7KSrDG1gXFoCSw
        EsfGVbfmW1Ga7NwGWBnnQhsIQdW6gclxtg==
X-Google-Smtp-Source: ABdhPJxCtWIE4RgM04/YQ6e9PjJhyW66Z+6uZ8tbr7dGqBWUvR11BOqZCom0nsVODQ5Cy32xNK6N+w==
X-Received: by 2002:a17:906:b754:: with SMTP id fx20mr30238250ejb.69.1619628028012;
        Wed, 28 Apr 2021 09:40:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm261477edi.32.2021.04.28.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 09:40:27 -0700 (PDT)
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
Date:   Wed, 28 Apr 2021 18:32:31 +0200
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
 <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
 <d57023d9f13d178dc95d7a74751923b80d1a5939.1607522429.git.gitgitgadget@gmail.com>
 <871ree8eto.fsf@evledraar.gmail.com>
 <CAFQ2z_Pco4KhhE7S_8zBZ7hCwOH=DnxHoKE8zus7REdQaXCZiQ@mail.gmail.com>
 <87lf953yto.fsf@evledraar.gmail.com>
 <CAFQ2z_Pb62Oe352UwdsPWLxjXd7P97pyuggTMK2URJd2p=OTnA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <CAFQ2z_Pb62Oe352UwdsPWLxjXd7P97pyuggTMK2URJd2p=OTnA@mail.gmail.com>
Message-ID: <87h7jqz7k5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 26 2021, Han-Wen Nienhuys wrote:

> On Mon, Apr 26, 2021 at 4:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I agree that whether or not we should have any tests at all is a matter
>> of opinion and circumstance. I don't think in general that someone using
>> some random internal API needs to be checking what is and isn't tested
>> in that API.
>>
>> I do think in this case that it's worth digging a bit further. The APIs
>> in question are using EINVAL and EISDIR to pass up errors that are had a
>> 1:1 mapping into the FS historically.
>>
>> Are we really better off faking those up, or is some of that perhaps not
>> used at all? Maybe we'd find that this level of abstraction isn't what
>> we need, and it could actually be much simpler.
>
> I think none of these error functions are being used at all, and I've
> made a start at removing them in https://github.com/git/git/pull/1012
> (see also my discussion with peff.)
>
>> It seems to me that a good way to get there is to seek some systematic
>> ways of focusing review onto various edge cases of this series. I.e. to
>> begin with having GIT_TEST_REFTABLE pass as noted elsewhere, and in this
>> case calling attention to some of the underlying assumptions behind this
>> series.
>
>> One of the hardest things I've found about trying to review this has
>> been closing the gap between things that exist in your mind and commit
>> messages / code.
>
> thanks, that is valuable feedback.
>
>> something like this in the commit message (and other applicable commits
>> etc.) would be *very* valuable:
>>
>>     In functions such as git_reftable_read_raw_ref() (and ????, are
>>     there more?) we're diligently emulating the documented behavior and
>>     return values of the refs file backend. According to "make gcov" we
>>     can see we don't have coverage for this, in particular the behavior
>>     of EINVAL etc.
>
> I haven't done this, because a lot of these considerations are
> transient, and I'd rather not spend a lot of time documenting what I
> don't know.
>
>> I.e. per [1] once if and when we have GIT_TEST_REFTABLE passing surely
>> one of the best way to garner feedback on the rest is to discover those
>> parts (using "make gcov", after running with/without
>> GIT_TEST_REFTABLE=3D[true|false]) where we still have outstanding blind
>> spots between the tests and code.
>
> Getting GIT_TEST_REFTABLE=3D1 passing is the hard part, because it means
> having  to understand exactly how the current code is supposed to
> work.  Once I get to that point (with knowledge being complete and
> tests passing), it will be easy to document what is happening and why.
>
> I was hoping that by posting these series with known test failures,
> and questions marked "XXX" in reftable-backend.c, I would get feedback
> from the other people who know exactly how this part of the code
> works.  But from your mail, I get the sense that nobody understands
> how the whole picture fits together?

Almost definitely not. I don't know about you but when I'm looking at
code I wrote 6 months ago handling some special case it takes me a while
to get up to speed on just knowing what I knew then, and when we're
talking about something like refs.c ...

On the topic of the way forward: I for one would very much be for a plan
where step 0 is to just a series import the reftable code you have
as-is. I.e. we'd include it as an imported external library, maybe have
some light test-tool integration and compile it / run its own tests, but
not have/advertise the "git init" etc. integration yet.

I.e. my opinion on GIT_TEST_REFTABLE=3D1 needing to pass is implicit (but
I now realize I haven't explicitly said this) on that happening before
the tree is in a state where we'd code/doc-wise be in a state of
shipping this to users.

Whereas just importing the library !=3D that, and I think we'd be in much
better shape if we had it in-tree and would incrementally work on
integration from that point, v.s. having more re-rolls of
mostly-the-same big codebase being re-submitted.

I'm sure there's some things that'll need to change as we start the
test/integration work, e.g. the reflog topic that's been discussed. But
that's surely better done as some patches on top of the already-landed
library import at this point v.s. trying to get the library perfect
before getting it in-tree.

Maybe Junio disagrees, just my 0.02....
