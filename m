Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F09C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 13:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhLPNOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 08:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbhLPNOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 08:14:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD97C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:14:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so85892975eda.12
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=feoB+mSmxE0I36UG9oziI8MPqXJ7OwmerRWsd7onM68=;
        b=WOKNNmfR6E3Hkb0RDyclDqa6nFNUAF8Vc0X3AmLWb0Bcq5xgTtLyJ0pU1I4DpNAJX5
         YaCMT7yYW0vZwf679sBPi3Z0dmlT9VoW57BypIgN3+GLSsJEnkg3iXnFvJRy0dGotiHB
         menluJ+CuDrJu4qg6eL7KcNPF8oY9hcp1lQWyAzNBqfOtyWLQtc7nIjE+/f5Xpdj64Vw
         v28klsCZNrwIU0HDxD5EsQ96cp26aIVMturwN/1x34bouqE8ULk3Onzpvu3mR2ZqCIOy
         qlDMECQMptJ+DjVuRtFrzy9xWqi15e16JOajQt+KFErF/cqzp87T1ZeclmpZMpRwYCD6
         jY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=feoB+mSmxE0I36UG9oziI8MPqXJ7OwmerRWsd7onM68=;
        b=2Qe2pmxdNA7gZnehFCtBU1S0EHnj7yWXQj5Bak8d5GxnD3AQ4lz83V1sQKluVWKmAn
         fAKeMTjagg1eJCMHFeEUTEld6jVFJbEiyu1hFas1NKiNEop1UXrO3/aoa2VJ+4q1czdo
         XhPui6VCZo1wMZ3HKyTh+bzJ8RA3GA0hcOLATnePfG5EvUy8KZwCns0pM6YT9agvAD76
         icShUx/tRH/gyCTO7/3NnhhqwLQLWFGuxEbBu4Dc8+MRS8u1BVZ3hNusbVj1OBSIgEaR
         x4WcBNJI99ktaQFlwDePBXzQatzqXhD8IbsRu+6l8xltJnFJibyTZFe0nJ1axZ2nKOtw
         rxoA==
X-Gm-Message-State: AOAM5321N806OTio1SI557cZKNH77YhOGL/3jNnuJTWe+vMS6eFptIhJ
        o3kof5jHwkY5rZNeuLgebG4tMu0l/Iu8lA==
X-Google-Smtp-Source: ABdhPJzCG+AgAA+yoDVH+wbhP6Kvex+LTDHmaqUn9XNwBmrWSxTbqsLgV4mKJs5O4uKGmQtpDltWKw==
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr20419693edb.309.1639660472754;
        Thu, 16 Dec 2021 05:14:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hb37sm563333ejc.211.2021.12.16.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:14:32 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxqad-000OTj-GA;
        Thu, 16 Dec 2021 14:14:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
Date:   Thu, 16 Dec 2021 14:04:58 +0100
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
 <20211212163207.GA3400@szeder.dev>
 <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
 <20211212201441.GB3400@szeder.dev> <xmqqo85kcp99.fsf@gitster.g>
 <YbjJuh4dVijL7jw4@coredump.intra.peff.net> <xmqqh7b994tw.fsf@gitster.g>
 <YbojKafkC/JcX4d1@coredump.intra.peff.net> <xmqqczlx93kg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqczlx93kg.fsf@gitster.g>
Message-ID: <211216.864k78bsjs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[Replying to the thread-at-large]

On Tue, Dec 14 2021, Jeff King wrote:

> On Mon, Dec 13, 2021 at 10:51:14AM -0800, Junio C Hamano wrote:
>
>> > I don't see any argument pertinent to BASH_XTRACEFD in general in that
>> > email, of in favor of its removal in particular, and there are no
>> > valid arguments for its removal in earlier emails in this thread
>> > either.
>>=20
>> If I am reading =C3=86var right, the argument is "dash would not be fixed
>> with BASH_XTRACEFD, so there needs another way that would work there,
>> and if the approach happens to work also for bash, then there is no
>> reason to use BASH_XTRACEFD", I think.
>>=20
>> Now, if the way =C3=86var came up with to help shells with "-x" not to
>> contaminate their standard error stream that our test scripts want
>> to inspect is worse to write, understand, and maintain, compared to
>> the way we have been writing our tests that inspect their standard
>> errors, without having to worry about "-x" output thanks to the use
>> of BASH_XTRACEFD, it may make a regression to developer
>> productivity, but I am not sure if that is the case.
>
> I think the method for handling this in the test scripts _is_ worse to
> write, understand, and maintain. The problem to me is less that it's
> ugly to workaround (which as you note in this case is not great, but not
> _too_ bad), but that it's a subtle friction point that may jump up and
> bite any test-writer who does something like:
>
>   (foo && bar) 2>stderr
>
> So my view had always been that BASH_XTRACEFD is the good
> solution[...]

Yes, I agree that's much better than what you need to do when not under
bash and when you can't benefit from BASH_XTRACEFD.

But unless we're talking about requiring bash and/or not supporting -x
at all (which seems to be overkill, seeing as only one test scipt wasn't
compatible with it) this discussion seems a bit like talking about how
some code is nicer in C17 than C99 or C89.

Sure, it is. But if you're also supporting the latter two it's usually
not worth it to maintain both with an ifdef.

Similarly, we can't really get any real benefits from BASH_XTRACEFD as
long as we're going to support "-x" with other shells.

Literally the only part of the test suite where we hard-depended on it
is the code adjusted in my 1/2 here. I do think if we could rely on the
pre-image it would be nicer, but not so nice that I don't want "-x"
working under "dash".

And in any case carrying a "BASH_XTRACEFD" seems to be just a dead end
for that reason.

On Wed, Dec 15 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Dec 15, 2021 at 09:05:15AM -0800, Junio C Hamano wrote:
>>
>>> Still.  I wonder if keeping BASH_XTRACEFD helps developers, when
>>> they need to diagnose a new breakage?  If their new test fails only
>>> in the "dash -x" run but not "bash -x" at the CI, for example?
>>
>> I have done that, but usually only after realizing that "./t1234-foo.sh"
>> passes and "./t1234-foo.sh -x" does not. So I think just tweaking use of
>> "-x" would be the main tool.
>
> Ah, that's true.  You only need to compare "sh -x test.sh" with "sh
> test.sh" with any value of "sh", especially after BASH_XTRACEFD is
> removed, demoting "bash" to the same state as "dash" wrt "-x".
>
> OK, I am more OK with the removal of BASH_XTRACEFD support than
> before ;-)

Yes, I've run into those cases and I don't think BASH_XTRACEFD really
helps at all. Yes you'll get a test failure because trace output got
into something we're invoking "test_cmp" on, or whatever.

But that's never a subtle failure, and the fix for it brings us back to
the question of whether we're going to support non-bash, or take the
more drastic step of marking the whole test script as bash-only under
"-x".

I think the answers to those are always going to be "yes" and "no", and
thus we're not getting any benefit from "BASH_XTRACEFD".
