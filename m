Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6746C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B0C6500F
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 09:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCPJLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhCPJKo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E09C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:10:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r17so70834738ejy.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gTX8HfIeZjsFl7uwT91lvmhZzE9OVARpIYhswDY7E2U=;
        b=da8THAPfw39va7U7FAwBGsZRfpowCZPW5LfNta9zWJeCFnxCwKB27XWZG1oCh1rPT5
         QuFkgqVomKXQFA5nKG51pwkreVSejOy+ZuIeGoooBB9hofVxDPb0fY/cPmgJ98pD8Id8
         os4nIxY3FDFd05pqGe7UnpQt55YKSYPTS9Fk4WGGG01FlALDfALq0Dbwe87BcnhR5XNj
         UwqHGz8LLAofTh22JysgvRFEuO5UdQohDKD7vIuKS5qIsgwJJkS1mQ+OhZSsORoTC2kp
         rtPj5pVyH+HfE5z/6v6WxkJIhe2N6cxU+iRkIw1y7UWhHmwj9QRSmXUjovpjN7CUJYLm
         PDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gTX8HfIeZjsFl7uwT91lvmhZzE9OVARpIYhswDY7E2U=;
        b=MQaWLJXruXzEmwbp2k5evc5Pg8ioykjTwM15U5/LeAWPgOmjPLzGMVd31sIjcM5GeR
         gT5+i8uKZABGK1hWSjJS5hBtN1l7w+Aq4enslTJfs4fOoZCFcNKbGUzgGIFjh8Vqy2eM
         5A4eWGFR1FlTjLl4Y18DufBsjqsIP4KRsML8YNu5G74qLKtxT7YePSIpaThhdIVoR65/
         31h0UsjSuncUM+ms3gVjNADiQ8fVsgUiohqTb2ipFx/7f2UhD6MqRngu+kMrSCvKjkbz
         ZeMbX7XFUKA+sECTyPp2EKhGNxnUS/WQJFSpo2sE3aVAZPR79UiKOO0c6uSeW1Wd8giC
         SexA==
X-Gm-Message-State: AOAM532o60td6yGCLZZXQh0c2Kvm3hckuVoSMa4itVF61FZNdI94Ua0c
        YWB6OdUwgl7oXZufUjUq5sw=
X-Google-Smtp-Source: ABdhPJwu4Q4o/jgckcM6Vwo4VydJY1ObpwXg8eK2/T+YRQ8PaLtCPhUONaBTbnGOhioPefGarMNvjA==
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr29079720ejc.183.1615885840615;
        Tue, 16 Mar 2021 02:10:40 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p3sm8901798ejd.7.2021.03.16.02.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 02:10:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] test-lib: make --verbose output valid TAP
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-7-avarab@gmail.com>
 <20210309185911.GF3590451@szeder.dev> <87k0qghwps.fsf@evledraar.gmail.com>
 <20210309213117.GB1016223@szeder.dev> <875z1zivlv.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <875z1zivlv.fsf@evledraar.gmail.com>
Date:   Tue, 16 Mar 2021 10:10:39 +0100
Message-ID: <8735wvfoq8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 10 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Mar 09 2021, SZEDER G=C3=A1bor wrote:
>
>> On Tue, Mar 09, 2021 at 09:57:03PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
[...]
>>> Becuse the advantage of this series is that that sort of thing becomes
>>> really trivial without everything needing to be hardcoded in
>>> test-lib.sh, observe (this is with my series):
>>>=20
>>>=20=20=20=20=20
>>>     0 $ PERL5LIB=3D. prove -v --formatter=3DSZEDERVerboseLog ./t0201-ge=
ttext-fallbacks.sh :: --verbose-log
>>
>> Well, this doesn't look trivial at all, does it?  In fact, I consider
>> this unusably convoluted.
>
> ... I meant to say something closer to "does that output look
> ok?". Obviously we'd then make the --verbose-log run something like that
> under the hood.
>
> But in any case, I found it easier to just add this feature to my "tee"
> program than doing it with Perl's TAP libraries, i.e. something like
> this on top (will integrate it in an eventual re-roll):

FWIW I implemented this. I've got it at https://github.com/avar.git's
avar/support-test-verbose-under-prove-2 if you want to take an early
peek at it. It turned into a 50-some patch slog through refactoring
various test-lib.sh code, so I'm seeing about how I submit it.

The end result is that -V now powered by a proper TAP-parsing tap-tee
program. So you'll have e.g. this working as before:
=20=20=20=20
    $ ./t9004-example.sh -V
    ok 1 - decorate
    # passed all 1 test(s)
    1..1

But you can also tweak levels of verbosity to stdout (while retaining
full logging) by suppling -V N to get N-level comments, as now indicated
by N number of prefixed "#"'s:

   # -V0 is a special-case to get 0th level logging (couldn't think of a
   # better name), --verbose-log=3D0 also works
   $ ./t9004-example.sh -V0
   ok 1 - decorate
   1..1

At level 3 you start getting the source of passing tests (failing tests
are level 1, unexpected TODO tests level 2, trace level 4):
=20=20=20=20
    $ ./t9004-example.sh -VVV=20
    ok 1 - decorate
    ###
    ###     test-tool example-decorate
    ###
    # passed all 1 test(s)
    1..1

So obviously the devil's in the details, but it would be useful to know
what you think about the approach before I try to roll this into
submitted patches sooner than later.

I'm mainly interesetd in this for this providing building blocks for
more advanced features down the road.

E.g. it would now be pretty easy to do something like run -x behind the
scenes even if the user doesn't ask for it, and then when a test fail
annotate the specific line that failed using fuzzy-matching on the -x
output.

We could do that now, sort of, but once we've got unambiguous TAP
start/end markers that can't be fooled it becomes trivial to write a
function like get_trace_lines_for_nth_test(N-1) to get your own trace
output for test N.
