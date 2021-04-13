Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FDC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6956613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 13:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbhDMNlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbhDMNlj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 09:41:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECDC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 06:41:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bx20so18303460edb.12
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=eRX8FnaDepCecICP1mT6DQj/Knt1SKuVzb8GYuZai70=;
        b=UrRBTHvEbblurNYSYWbXoPb6Xvj4lNtyBxU9QO0nGBddqfe5gTQWA2N/rnbkW7LsXW
         P4NYZUxIww3nItDgw3iKz0ypv4msG3KYxN/o8hPXMYddETRCKIC3Mpjhr/DSx7JGsvAi
         cjDCkIyQzxof9LNR+MymFJXRoyV69MQ5vGpqQyboUuwDuR3hQVMkoCpVEjuaIWuE80tJ
         Vq3bNQE5iUnJBXXMcnobTx0LmjQyd3TRwS77FhDPqOWVg37a57mlPXCJ6t2PeW99MkBq
         xgxPIJV6Kvau17Z5zsMsuIZuhTeZbEYcBlCrrQWIj5tBj5aLuxulqxWYbG9mVx5JTiC1
         mR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=eRX8FnaDepCecICP1mT6DQj/Knt1SKuVzb8GYuZai70=;
        b=U93Adb33MLglQ/Z8Njys+7oeGft8HuM8Dj4OdSb4G/LNy3+19hmyq1LsQ9fwZAwswQ
         Q8jU+TLYTnqnVMxnOvaEJ9wmVyiChHOEymMb8Q6x0bbVnQQVjX1a795ZCdfZVhN4CJ1y
         t5jhaQK/tVB8RzK44sRHN48+B8DF7qGGRebSoV6elyuNH8zcniQhAclzdA2KOL6lSB3e
         snuZSD+4QNEGUmIV9XWEO5Us5AVQUTlWY8N/1Dbaf7giPCkAGB3EoMiNr+HjiSUtbq3U
         SgPCJqoUr1mFXLEhrv5ptJHfGkAirkhswWCWO+SlPzxOuXudhkVCXzenkQmFKV3505/Q
         59Jg==
X-Gm-Message-State: AOAM531Bm1KdwM74bdloD3DErvZ8VuESFM7TGHHrY1g5DlbU0pb7jqms
        Z+K4zMKqGIRwxIqMQ66TvqsmG9p6vbRM9g==
X-Google-Smtp-Source: ABdhPJxfClPjm30GGq5/XnKQlz8ZUVaa/uqYfAvtyqhv+oU7X3k0V9gzuMbPoEgOeEpPoduGahthRQ==
X-Received: by 2002:a05:6402:6ca:: with SMTP id n10mr35241876edy.312.1618321277189;
        Tue, 13 Apr 2021 06:41:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l15sm9196909edb.48.2021.04.13.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:41:16 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 02/20] reftable: add LICENSE
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
        <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
        <02bd1f40fa4e281f878d0b9ba4a8b5f8eb21c8ff.1618255552.git.gitgitgadget@gmail.com>
        <87fszuej8y.fsf@evledraar.gmail.com>
        <CAFQ2z_MQp99uPpdai9Hbh76h-PO3JUHmY-pasSXONjeRp8dTzA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAFQ2z_MQp99uPpdai9Hbh76h-PO3JUHmY-pasSXONjeRp8dTzA@mail.gmail.com>
Date:   Tue, 13 Apr 2021 15:41:15 +0200
Message-ID: <87o8ei2tfo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Han-Wen Nienhuys wrote:

> On Tue, Apr 13, 2021 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>     > However, it is fundamentally blocked on someone willing to spend
>>     > some time reviewing the series; this seems to be out of my
>>     > control.
>>
>> I for one find it hard to follow re-rolls of this when past discussion
>> isn't clarified/updated in commit messages/CLs.
>>
>> So in particular in v3[2] there was a whole discussion about what what
>> this licence & external hosting of this codebase meant in practical
>> terms.
>>
>> I vaguely recall that that was clarified in some way by you, but didn't
>> find the relevant E-Mail. Something like Google's lawyers said something
>> to the effect that this could just be added to git.git, no? Maybe that's
>> incorrect, I don't remember.
>
> You're right, I didn't update the thread. The outcome is that the
> library for now lives in https://github.com/hanwen/reftable while it's
> not integrated in git.git. In this repo I can accept contributions
> (including fixup changes posted to the git list) without requiring
> CLAs.

And once this lands if there's patches to reftable/* on this ML?

Knowing would be good, a change to Documentation/SubmittingPatches et al
in the next iteration even better :)

>> I.e. if it's meant to be 100% externally maintained and "code-dumped"
>> into git.git like we do with sha1collisiondetection/ that raises one set
>> of concerns, but if it's meant to be "eaten" by git.git that poses
>> another set of questions for the code review here. I.e. much of what
>> you're doing in later patches in this series is introducing things that
>> are redundant/odd if viewed if we're supposing that this code is meant
>> to live in git.git.
>
> The code is meant to be eaten by git.git, but be amenable to being
> used by libgit2 with minimal modifications. To that end, it tries to
> use just functionality offered by git-compat-util.
>
> If you could point out specific oddities, that would be helpful.

Things like different coding style, e.g. $(git grep '[!=3D]=3D NULL' --
reftable/) & comment style.

Having Go-ish (or Google-ish?) *_test.c files instead of that living in
t/helper/*.

reftable/dump.c not using parse_options().

This having reftable_free() etc., which at least for in-tree use is
redundant, see 8d128513429 (grep/pcre2: actually make pcre2 use custom
allocator, 2021-02-18).

Wondering if internal libraries (e.g. in basic.c) are there to avoid
various kitchen-sink things existing in git.git itself, or because no
existing thing fit the purpose.

I'm not saying those things aren't OK or the "sorta-external" trade-off
needs to change, just that reviewing it not knowing what the expected
status is left me hanging.

> As said earlier, the BSD license here is the most liberal I could
> find, but I'm open to something else, if that makes integration in
> both git and libgit2 possible. This was not discussed further, and
> hence the "TODO: relicense?" comment.

I don't per-se have issues with the license, just questions about what
it means for the development flow.

Let's say Junio merges this to master, and someone discovers a bug in
it. Surely one of these happen:

 1. We just take the patch, if it's a tree-wide patch someone at
    reftable.git would need to either look at GPLv2 patch or clean-room
    duplicate it somehow.

 2. Junio refuses any suggested changes to the reftable/* directory, we
    tell people to submit an upstream PR, once that lands we update. So
    like sha1collisiondetection/ (well, sans the "Junio refusing", I
    think I un-forked that at least a couple of times).

One of those means that e.g. if the change is to a strbuf API reftable/*
needs we'd need to version that API or otherwise treat it as stable.

As an aside, to your [1] again: At least to me reading a series on-list
that has TODO comments in commit messages very much sounds like an RFC
but not calling itself that, maybe I'm alone in that, but if not
clearing this sort of thing up / documenting it might go far in getting
more reviews.

1. https://lore.kernel.org/git/CAFQ2z_P=3DMqT81gLjov6A471Z9sd69qQTep8KG8M8=
=3DLO9pJtkpQ@mail.gmail.com/
