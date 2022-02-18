Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD79FC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 12:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiBRM6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 07:58:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiBRM6A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 07:58:00 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498527CE5
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 04:57:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p15so14828370ejc.7
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iUhvSfwuchNRGfYWBDdEwzaZM64G3cnNwI/1/RVE6Jo=;
        b=LimuRmeobwEOHP+SpO4xCXpuGrjTaQtX6zWQK5q1BILogXfPsn+MiMuWVPUEghzCLR
         zKdJdLnKe7VTdh1aq7xP/y16A/mTcS2sA9nFhieHBvndERSKaA8iXm1WHG8DsNlGo7Cu
         sj3Bf56WINvEbFH4wL1kl++EuORM2yEHLNGcVovcJOweaqzOKZedrzWLmlVVo5dw7Ab0
         sPgrLb7ElkWNNLHu64vzvooz3Z/iUg8CmF7r3QSNFiaWwyigqtv8ilX0gvQEy+YqLd1s
         AzaOfEyVmwmpDo0blP7h6TOWMmRu+ZG7zyPBMD8lD7WV90fTHK63dy3MxVMbQkGCHyad
         1M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iUhvSfwuchNRGfYWBDdEwzaZM64G3cnNwI/1/RVE6Jo=;
        b=H8p2jKzishCP0GDNg8L+EjXuGdXLxNJ4XqX2mvKJgO6dtL7cWYgXu9aIAGZUA6XS3E
         aooEySbAX7i39cQ3Nxoq2Cf0W0YqDRX0VVg/IPc/rXwSLHMSrwmgEQCa0DUeTnjgjE42
         BXku/GYPM8h2wduMOUX0yc/326LigJGcGuzptbiXozCerOFVWTCT6pUbJr7Hb/guWNFv
         iKeSChK0NDPFdUtEDiq6B/z9kipS5E93N3rcu0kmg9tjxu0gwRCilW/lJkkQremCrWnX
         W2EgJ1RuOIdkAxx9ErVRejUrrrGkKOSo5WLiqpcmAbRv0PZdA5DwBhk5r+JNVlmM1K1t
         Q6ew==
X-Gm-Message-State: AOAM5309uF0yk33ri354ulbs987NEhEldt2jkD1OtACeMzDCJ9zTc3ZS
        s+SfjRKltk7GQmrI+Rg+SV8=
X-Google-Smtp-Source: ABdhPJyc8Q4SPtLoURVKnqqcPu2dyV03Ke+XwogznnDWCB3KKErGFA1P0gud7uEKwRyfLQ/NLVVmYg==
X-Received: by 2002:a17:907:3115:b0:6b5:6ebd:d785 with SMTP id wl21-20020a170907311500b006b56ebdd785mr6421789ejb.592.1645189035160;
        Fri, 18 Feb 2022 04:57:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l19sm4899559edb.87.2022.02.18.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:57:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL2oz-0046PQ-Ss;
        Fri, 18 Feb 2022 13:57:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <ajrhunt@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Whether to keep using UNLEAK() in built-ins (was: [PATCH 2/2]
 commit: use strbuf_release() instead of UNLEAK())
Date:   Fri, 18 Feb 2022 13:35:12 +0100
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
 <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
 <xmqqa6equ1rq.fsf@gitster.g> <xmqqtucyslz9.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqtucyslz9.fsf@gitster.g>
Message-ID: <220218.861r00ib86.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Junio C Hamano wrote:

[CC-ing some people using/interested in UNLEAK()]

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Convert the UNLEAK() added in 0e5bba53af7 (add UNLEAK annotation for
>>> reducing leak false positives, 2017-09-08) to release the memory using
>>> strbuf_release() instead.
>>>
>>> The tests being marked as passing with
>>> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" already passed before due to the
>>> UNLEAK(), but now they really don't leak memory, so let's mark them as
>>> such.
>>
>> That smells like a brave move.
>>
>> Specifically, the cited commit turned an existing strbuf_release()
>> on &err into UNLEAK().  If that and the other strbuf (sb) were so
>> easily releasable, why didn't we do so back then already?
>
> I suspect that the answer to the above question is because these
> allocations are in the top-level cmd_commit() function, which is
> never called recursively or repeatedly as a subroutine.  The only
> significant thing that happens after we return from it is to exit.
>
> In such a code path, marking a variable as UNLEAK() is a better
> thing to do than calling strbuf_release().  Both will work as a way
> to squelch sanitizers from reporting a leak that does not matter,
> but calling strbuf_release() means we'd spend extra cycles to return
> pieces of memory to the pool, even though we know that the pool
> itself will be cleaned immediately later at exit.
>
> We already have UNLEAK to tell sanitizers not to distract us from
> spotting and plugging real leaks by reporting these apparent leaks
> that do not matter.  It is of somewhat dubious value to do a "we
> care too much about pleasing sanitizer and spend extra cycles at
> runtime while real users are doing real work" change.

We've had several discussions about the utility of UNLEAK() as I've been
submitting these patches, and I thought that if we weren't 100% on the
same page it was at least clear what I was going for here.

Per https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/ the
real goal I have in mind here is to use the built-ins as a stand-in for
testing whether the underlying APIs are leak-free.

Because of that having to reason about UNLEAK() doing the right thing or
not is just unneeded distraction. Yes for a "struct strbuf" it won't
matter, but most of what we UNLEAK() is more complex stuff like "struct
rev_info". We won't really make headway making revision.c not leak
memory without using "git log" et al as the test subjects for whether
that API leaks.

We are also freeing most of this already even for built-ins, e.g. see
(not all of these are applicable obviously, but per the numbers enough
are to make the point):

    $ git grep '\bstrbuf_release\(' -- builtin | wc -l
    456
    $ git grep '\bUNLEAK\(' -- builtin | wc -l
    29

So one goal I've got with these patches is to eventually get rid of
UNLEAK() entirely. We only use it in these few instances:

    $ git grep '\bUNLEAK\(' -- '*.c' | wc -l
    31

Per the above we'd want to convert any that deal with the complex
structures that are the big source of leaks to doing real releases for
testing the APIs. That'll leave only a handful of remaining legitimate
uses, which I don't think are worth keeping some UNLEAK() API around
for, v.s. just freeing them.

I think we've also somewhat been talking past each other in past
exchanges (including me with Jeff King) about what you call "real
leaks".

When I'm referring to memory leaks I'm talking about them in the more
inclusive sense explained in this valgrind documentation:
https://valgrind.org/docs/manual/mc-manual.html#mc-manual.leaks;
Basically "a malloc() not followed by a free() is a leak".

But you and Jeff King have (I think) commonly used that term to exclude
what's called "still reachable" in that table. Those *are* memory leaks,
but as explained in that table just ones that arguably don't matter. Or
at least ones most people tracing leaks don't want reported by default.

UNLEAK() is just a mechanism for moving a memory leak from another
category into "still reachable". That will make LSAN blind to it, and
valgrind in many cases due to it being a heap tracer. But it & other
memory leaking tools *will* report even on those if given the right
options.

So I've found it useful to get rid of UNLEAK() in some cases for those,
because even if LSAN runs clean it's useful to run valgrind in its more
pedantic tracing modes to see even the "still unreachable", and if we
should care about it or not.

Some of the leaks in those category *are* "real leaks". I.e. you can
have an ever-growing structure with global reach that's always "still
reachable", but when using the API would eventually OOM you.

So while it's a useful heuristic for spotting "will be cleaned up at
exit anyway" you can't rely on it, so I've been looking at them anyway.

So being able to just free() them so I can permanently ignore them as I
fix more leaks would be useful to me, so I hope you'll agree on just
talking this as-is, thanks! :)
