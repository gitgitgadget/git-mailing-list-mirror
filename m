Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A239C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0763F60462
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHDXbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHDXbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:31:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61013C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:31:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u3so6297812ejz.1
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dK61CqDsHW/aBbiwzqDR3+s0zJxzRFBtUTTRP92LZMM=;
        b=vaUEsfNIkAj4gTBeiqDfg8ct/MsG4k/V+atrCxy+uRaZ9dRRAlwIwL+SdTCb8Q6K+r
         s0m2kNn7P6n5mYekBZFgvoXrA4ObVlmFEj3V6Dhi+EKXURY9NlPM3R5DO0obHKCATL+N
         Bi7sQH8sshSH26DaCPrb/zJEhHZU3hqL3LFPTPHYUX1m/iYrRDqR4MiY64bG6T1KyhqJ
         KTYPdx4ulmVoFREzEkVOYVUmbOiep+7KIRt+KduX1cMMxb0q1I37OfAO10YkSFurO3O6
         hLpBYlhql8Peq92IOD5zW32kJa0OsuU9EMjy7/LK1EzAkoCevSNRe1XQkuVcOz2NKfG8
         uaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dK61CqDsHW/aBbiwzqDR3+s0zJxzRFBtUTTRP92LZMM=;
        b=RMeoEfM5oTHiN5FjMgJZWHYoZ9GqibzEGKnkcAnonbRtgVdJE8JUafPL+cT595IIhm
         CryB8VcPeJm2pleGF/xy+a7gA97MC/II0NLYuPpbE4zVsnRCHGq2PNLy5BdSi2jrY5bT
         D4BOHewhx3fLUlF80GLsWu2inkKKUn9g7ZBsoqZNtlm8GNIwBJdI1tnJTSruyrLwCvF+
         aEsBCESww+8zE3j1VXT1v9AwLEFPclU6FVKPzIzCB6rdSiyQ68Y5r2pauHR5tUWhMT+D
         zxeXVWU0G0TXy/LEtt0XrXgVemeAw0rNcWnB8mcVJoORs1CzYdP1OdmzQsvdfsWKpCg4
         B/6g==
X-Gm-Message-State: AOAM5320pNpz7xKR7iPoQ1BHl5ZVD5Ijdaq6UZtbnFR+sGrRybSV1LTi
        6WwVrEeM+DI2fnc7u/0y+H8=
X-Google-Smtp-Source: ABdhPJycwFxVi/MAH92Lrf+rB6qQgCHx0lTLcXfJoUgp4KIVtvKeqB2Jr5RuD54wAOztZctG3F8A5Q==
X-Received: by 2002:a17:906:9c84:: with SMTP id fj4mr1539137ejc.264.1628119862814;
        Wed, 04 Aug 2021 16:31:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r7sm1528332edi.43.2021.08.04.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:31:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #02; Tue, 3)
Date:   Thu, 05 Aug 2021 01:06:55 +0200
References: <xmqqfsvpr8t5.fsf@gitster.g>
 <87wnp1mqv2.fsf@evledraar.gmail.com> <xmqq4kc5ozi7.fsf@gitster.g>
 <87lf5hm0v7.fsf@evledraar.gmail.com> <20210804212825.GH23408@szeder.dev>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210804212825.GH23408@szeder.dev>
Message-ID: <87fsvon5xm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, SZEDER G=C3=A1bor wrote:

> On Wed, Aug 04, 2021 at 09:53:02PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Aug 04 2021, Junio C Hamano wrote:
>>=20
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> >
>> >>> * ab/test-columns (2021-08-02) 3 commits
>> >>>  - test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
>> >>>  - test-lib-functions.sh: add a test_with_columns function
>> >>>  - test-lib-functions.sh: rename test_must_fail_acceptable()
>> >>
>> >> We're going to need this or another solution to the v2.33.0-rc0
>> >> regression in c49a177beca (test-lib.sh: set COLUMNS=3D80 for --verbose
>> >> repeatability, 2021-06-29) before the final v2.33.0.
>> >
>> > Just a question.  Is that true?  Wouldn't a system that needs these
>> > on top of c49a177beca already break the tests without c49a177beca?
>> >
>> > IOW, is c49a177beca truly a "regression", or is it merely "a half
>> > solution that solves for most but not all platforms"?
>>=20
>> Yes, because with c49a177beca your tests only break if you use the
>> --verbose option, i.e. if your stderr is connected to a terminal. I.e.:
>>=20
>>     ./t0500-progress-display.sh --verbose
>>=20
>> So in practice it mostly affects git developers who run with --verbose,
>> but probably nobody doing a build in the wild.
>>=20
>> With c49a177beca they break on e.g.:
>>=20
>>     /bin/bash ./t0500-progress-display.sh
>>=20
>> If your bash is recent enough, so "make test" if you're on a system with
>> a recent bash whose /bin/sh is /bin/bash.
>>=20
>> This is because post-c49a177beca we don't "unset" COLUMNS anymore, which
>> bash takes as license to update it.
>>=20
>> So we really do need that series in before the release to avoid that
>> common annoyance, a revert of c49a177beca is also possible, i.e. it
>> would still leave things broken under --verbose, but that breakage is
>> rare and existed before v2.33.
>>=20
>> I think given the triviality of the fixes and that the cause is
>> well-understood it makes sense to go forward in this case.
>
> On one hand, there is feedback to be addressed:
>
>   https://public-inbox.org/git/20210802171429.GC23408@szeder.dev/

I read that a couple of days ago, but managed to forget about it. Sorry,
re-rolled with it addressed:
https://lore.kernel.org/git/cover-v3-0.3-00000000000-20210804T230335Z-avara=
b@gmail.com/

> OTOH, setting the checkwinsize is the truly trivial, minimal, reliable
> and uncontroversial fix for this issue, and IMO that should go into
> the next release.

Addressed below.

> This fix in this patch series is not trivial: it introduces yet
> another GIT_TEST variable and a helper function that developers will
> have to remember to use in the future.  Worse, this means that despite
> aiming for future proofing I can't consider this approach future
> proof, because it's easy to forget about such a rarely used test
> helper function, and if anyone introduces yet another test setting
> COLUMNS, then that will be prone to similar failures when run with
> Bash.

How would it be forgotten? If you introduce tests like the ones changed
in 1/3 of the series and expect git to pay attention to COLUMNS you'll
find that they won't work, because if you set COLUMNS=3D123 we won't take
it over the GIT_TEST_COLUMNS=3D80 set in test-lib.sh.

So it seems like a fairly easy-to-discover thing. You'll grep for that
setting and find test_with_columns().

Most tests (such as t0500-progress-display.sh) won't need to concern
themselves with the new helper, it's only for those tests that want to
check how git itself behaves with a custom COLUMNS value, as opposed to
just wanting consistent repeatable results.

In any case, I didn't think a helper was needed in this case, it's
something Junio requested:
https://lore.kernel.org/git/xmqqzgu7b6of.fsf@gitster.g/ ...

> I don't think that in this case we should aim for future proofing when
> the cost is the additional cognitive load of yet another helper
> function.  I would instead prefer to go with the really trivial fix
> for now and wait whether this issue pops up again with other shell or
> terminal, hoping that this issue is a "one-hit-wonder" [1] and it
> won't happen ever again.

...I'd be happy to remove the helper if Junio would take that version of
the patch; :)

But in the topic of the overall approach, I think it's worth
future-proofing here mainly because it's useful to be able to reliably
run "make test" on old commits for bisecting, which is a property we
mostly manage to uphold.

By narrowly targeting a fix at one specific shell's cleverness around
COLUMNS we'll leave open a window where we'll fail on other shells if
they introduce similar cleverness.

It hardly seems like a stretch that once bash starts doing that sort of
thing other shells might think to follow suit, and all have their own
non-standard way to turn it off.

You also didn't address the other rationale for it, namely that it's
also future-proofing us for submarine breakages in non-git programs
which'll understand the new COLUMNS=3D10, but not GIT_TEST_COLUMNS=3D80.

I.e. should our tests rely on their output, and those programs
themselves change how they treat e.g. COLUMNS v.s. TIOCGWINSZ any tests
relying on their output will change their behavior.
