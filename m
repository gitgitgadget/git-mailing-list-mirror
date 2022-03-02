Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9452C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 11:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiCBLJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCBLJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 06:09:52 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4223D1DE
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 03:09:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p15so2930596ejc.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 03:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jGiD/YE2bXkdWRFvowI+3r4Q8Rhrzuk4IUYhGnuXy+Y=;
        b=Q8IX8+mK7DHhQCakxP83qlQWi2Wbv7PuCFcz2t04DxiyAMubIu1BfO5t7S43xARddD
         5SD3PIg+fY9qpiScTZbc6o6BYCc+iAin/CrH/yA/ZIePjLVHkoC/HL6NKf7aXCu9ouEx
         B8k+Rc+1GVSkTnotTQ2hFLld+6fd9VLc9n9yDqUAlWCq2C8lUrVE3BM3vdnpiaxXdrPP
         sGTXTWealomX1wZ9W9yoqgq3nJ5vVn6dEt/dbtVB+ZfFF6VbyuS7l4nfDIteeZiAiE9g
         UWyk8AzMdr0VsYECrRhKU7no1Hbj7NH4PTCl7BJt0lrWFps1FRyPqr99LbdGTrd0DvIk
         K/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jGiD/YE2bXkdWRFvowI+3r4Q8Rhrzuk4IUYhGnuXy+Y=;
        b=MCHZQ+1vpP2kJ8We65wT8KM4G4rK07GCMiDnnTBC5qbYk8ylm6SgoXVaoOoCOEi4mM
         MXn+uBLlS+IkOVl8E6ZMulF9/D6teFilJncYKXy5hGFs8qBieIA86pFYPX6D/psSYdzS
         oObj1N4IlcphOq2FH/T9mJZaN/DbF6C3EJc6w94r8b7Mv+iejP1PHjNvGWl8ohPclhiW
         sUjE+NgRP5/9PRPdtF8BMstZLnak3/jM0MQIyE+12aCStKqUK2FsmHiIk4GEQN+ruj2L
         8/KkgRuklZylPVpG+A8Fqa6zAwTWK3I9uGy7XziuplCJVg+OrIG7aTg/a8zJbVtqYz1J
         YbDA==
X-Gm-Message-State: AOAM532H65iLxIzoaRX/Yw1+lxJiGyWatvCE/pPbodcKQLodAYr6xLLk
        lwutaIFyIsUPWHWN+KBIsTf6G/gY0aE=
X-Google-Smtp-Source: ABdhPJwEVmu/O75Cn3HmIaG9+kx0S2UCwiRSLo8hPHdWuIFFW+5kRIcreLlz6tW/4vOKrwiLbHG8jQ==
X-Received: by 2002:a17:907:7ba6:b0:6d7:1888:d553 with SMTP id ne38-20020a1709077ba600b006d71888d553mr3975456ejc.98.1646219347044;
        Wed, 02 Mar 2022 03:09:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7dac8000000b0041291913c15sm8517916eds.1.2022.03.02.03.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 03:09:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPMqw-0003rF-0N;
        Wed, 02 Mar 2022 12:09:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: make parse_options_check() test-only
Date:   Wed, 02 Mar 2022 11:52:22 +0100
References: <xmqqtuck3yv2.fsf@gitster.g>
 <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com>
 <xmqqzgma287n.fsf@gitster.g> <xmqqr17lphav.fsf_-_@gitster.g>
 <220301.86pmn5z5we.gmgdl@evledraar.gmail.com> <xmqqo82pnwoc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqo82pnwoc.fsf@gitster.g>
Message-ID: <220302.86r17k7gry.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 01 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Mar 01 2022, Junio C Hamano wrote:
>>
>>> The array of options given to the parse-options API is sanity
>>> checked for reuse of a single-letter option for multiple entries and
>>> other programmer mistakes by calling parse_options_check() from
>>> parse_options_start().  This allows our developers to catch silly
>>> mistakes early, but all callers of parse-options API pays this cost.
>>> Once the set of options in an array is validated and passes this
>>> check, until a programmer modifies the array, there is no way for it
>>> to fail the check, which is wasteful.
>>
>> That's not true due to the "git rev-parse --parseopt" interface. I'd be
>
> Meaning that a parse-options array can be fed by "rev-parse --parseopt"
> and having the sanity check enabled does help the use case?  Even there,
> I would say that once the script writer finishes developing the script
> that uses "rev-parse --parseopt", setting the parseopt input in stone,
> there is no need to check the same thing over and over again.  Am I
> mistaken?  Does "rev-parse --parseopt" that is fed the same input
> sometimes trigger the sanity check and sometimes not?

If we're declaring that "git rev-parse --parseopt" is something that was
only ever intended for in-tree usage sure, that should hold true.

I.e. "git rev-parse" is documented as plumbing, and we document
--parseopt as a generic option parsing mechanism you can use in
shellscripts.

So out-of-tree users wouldn't guard against
GIT_TEST_PARSE_OPTIONS_CHECK, and I wouldn't be surprised if we could
e.g. segfault on some subsequent code if some of the sanity checks
aren't happening anymore.

No, I'd be quite happy if we declared that it's for our use only, and
could remove it when the last in-tree *.sh user went away. there's a bit
of complexity in parse_options() required only for its use....

>> I see the benifit of Johannes's suggestion of checking this once (but
>> with t0012-help.sh etc. we're nowhere near being able to do that).
>>
>> Now this runs for the whole test suite, so our tests will have the the
>> same behavior.
>
> The code for sanity check is there ONLY to help those who develop
> while they develop, and it is logical to enable it during our tests.
> There is no reason to trigger the sanity check in the end-user
> environment, no?

I don't see the benefit of skipping it. Your commit message mentions
"but all callers of parse-options API pays this cost". As a quick & dumb
perf test I tried:
=09
	diff --git a/parse-options.c b/parse-options.c
	index 6e57744fd22..cabea35e8b1 100644
	--- a/parse-options.c
	+++ b/parse-options.c
	@@ -523,7 +523,10 @@ static void parse_options_start_1(struct parse_opt_ct=
x_t *ctx,
	        if ((flags & PARSE_OPT_ONE_SHOT) &&
	            (flags & PARSE_OPT_KEEP_ARGV0))
	                BUG("Can't keep argv0 if you don't have it");
	-       parse_options_check(options);
	+       while (1) {
	+               printf(".");
	+               parse_options_check(options);
	+       }
	 }
=09=20
	 void parse_options_start(struct parse_opt_ctx_t *ctx,

And:

    ./git [am|rebase] | pv >/dev/null

Get around 4MiB/s. I.e. we can do this check ~4 million times/sec on my
computer, with -O3, with -O0 -g it's ~3MiB/s.

So the performance cost is trivial & not worth worrying about.

>> So aren't we shaving microseconds off the runtime here?
>
> No, the problem I have with the runtime check is more at the
> conceptual level.  Those who remove assert() by setting _NDEBUG
> would not be doing so to save nanoseconds, either.

I think the trade-off of not having to worry about the runtime
v.s. "development build" checks is one we've done well with BUG(),
i.e. not to have it be an assert().

E.g. in this case we have parse_options_concat(), so you can dynamically
construct the options to be checked.

I happen to have looked in detail at all of that code in the past, and I
don't *think* it's doing something "actually dynamic". I.e. it should be
the same when the tests run and when git runs in the wild.

But having to know and check that when using or changing the API is just
more state to keep in your head.
