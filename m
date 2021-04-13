Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238CC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE7660E0B
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDMTHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMTHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:07:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1001EC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:07:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w3so27705946ejc.4
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=VvZLPEBYDSLqkxehIgbdJxYv1+4jCzuCKsrN52zcI28=;
        b=urCOY9komm3G0kL0inHv9HtIHHnSqJehhbp/l59vvYDQhlAPsO1muAgb605dLUhlYa
         I5UlN9Qw/L+VR4y7ewk6jPTVoVZkBPcy0t1UlbtthfUhB+NdeXR6zXVeqo5nHxXoBKmM
         pkRIbmoHYOm5vC1wf3RK3WGRCraBmMEtbzWGjPC7QbykUL6N9lNzLFnCv21ILCEtrZxo
         SUYwn66VQIC++hLBSBeEUjtFi4l4Dkfp9nByl4vrMusK5WYAIswIMHTtHDdOyDUeC1je
         sMQVHcgoAJQYvf5BnqU9032/kdpukgiBMVi7hADB6sS7kC414GeTNPReJ2w/8OTKmDq+
         xHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=VvZLPEBYDSLqkxehIgbdJxYv1+4jCzuCKsrN52zcI28=;
        b=c/ji8OvB1dkk6Uk/aefteO7hrgJy/0Jda98yLuY3E539BTSHxjDKhlP+2o0TuYez4s
         LNV3EcHRL8VvBpL2jGyA/JET1hOc8u3V9TRS8Bp1RWOavMM1HHxCtjqw1m+MGAi25vWe
         QC+kmnIEqlr0VAqIOCrQDZikGVsV9G+5hcE1/RvUISyvOIANOvFEYXNFPQQgVgL9iFeZ
         l7kKaLKY+bPdeskH1NS4ENY6l8mdGvWPyglSydUWbZJ9v8ZGsvtX/cG7DIZIpW4lx/o7
         eQ4bPHmSQ0jXhxHQrvVXJ1YfY6Kp+cYhP4FGHO88LQ6CzEqtv0MYbveYgssivHYVRcoU
         3eCw==
X-Gm-Message-State: AOAM530jwqK5j6ulu0qbYoWQIuaJLDBxXOCtDApfwWgES5iCPxAHKS6R
        9cPCD/1vWeGiXmPef7HSFg0=
X-Google-Smtp-Source: ABdhPJwBqrsEFcaKFFZrWXjQJ/1uF27NQ/ZsoiD549wA9B1tuHvI8BY3/37yGJZaiRbYn5cNa/TqDg==
X-Received: by 2002:a17:906:a20c:: with SMTP id r12mr33131371ejy.554.1618340846722;
        Tue, 13 Apr 2021 12:07:26 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id gn19sm356687ejc.68.2021.04.13.12.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 12:07:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add missing dependencies of 'config-list.h'
References: <20200416211807.60811-2-emilyshaffer@google.com>
 <20210408212915.3060286-1-szeder.dev@gmail.com>
 <87pmz4ig4o.fsf@evledraar.gmail.com>
 <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YG+UeQRwdBsVeRNV@coredump.intra.peff.net>
Date:   Tue, 13 Apr 2021 21:07:25 +0200
Message-ID: <87czuy2ec2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 09 2021, Jeff King wrote:

> On Fri, Apr 09, 2021 at 12:08:23AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > -config-list.h:
>> > +config-list.h: Documentation/*config.txt Documentation/config/*.txt
>> >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
>> >  		>$@+ && mv $@+ $@
>> >=20=20
>> >  command-list.h: generate-cmdlist.sh command-list.txt
>> >=20=20
>> > -command-list.h: $(wildcard Documentation/git*.txt) Documentation/*con=
fig.txt Documentation/config/*.txt
>> > +command-list.h: $(wildcard Documentation/git*.txt)
>> >  	$(QUIET_GEN)$(SHELL_PATH) ./generate-cmdlist.sh \
>> >  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>> >  		command-list.txt >$@+ && mv $@+ $@
>>=20
>> This change makes sense.
>
> I agree it looks like it's moving in the right direction, but I am
> slightly puzzled by the existing code. Why do we need to use $(wildcard)
> for git*.txt, but not for the others?
>
>> I have a not-yet-submitted patch series where I added some more
>> config/*/*.txt that wouldn't be caught by this rule, I'd updated the
>> Documentation/Makefile, but missed this part in the top-level Makefile.
>>=20
>> So a relation question: Does anyone actually prefer this state of
>> affairs of having a Makefile, Documentation/Makefile, t/Makefile
>> t/perf/Makefile and template/Makefile?
>>=20
>> It seems to me with ever-closer coupling between them that it's getting
>> to be more of a hassle to manage state between them than it would be to
>> just move them all into one big Makefile.
>
> Yes, I'm generally a fan of avoiding recursive make when we can. I think
> the caveats are:
>
>   - it would be nice to continue to have stub Makefiles in
>     sub-directories that trigger the main one (so "cd t && make"
>     continues to work, for example).

Yeah, we should definitely keep those in place. I also wonder if various
rules for local wildcards will be more complex when they need to reach
into subdirectories.

>   - we may need some cleanup of parts of the top-level Makefile which
>     are triggered without dependencies (e.g., I think we unconditionally
>     run some scripts to compute GIT_VERSION in the top-level; this is
>     already a bit wasteful, but may get even more so as we add more
>     rules from sub-directories).
>
> Mostly my argument against it (and why I haven't purused it) would be:
> it sounds like a lot of work and risk of regression, and the current
> system seems pretty fine in practice.

One edge case I discovered the other day but didn't bother debugging
much was make at the top-level failing because "doc.dep" in
Documentation/Makefile uses this pattern:

    rm x &&
    script >x

Which would normally work in one Makefile, but in this case two rules in
the top-level called unrelated "make -C Documentation [...]", so both of
those sub-processes end up needing to generate the doc.dep, and they
race each other.

Another thing fixed (or, worked around) with a wider application of [1].

1. https://lore.kernel.org/git/patch-3.6-96e2338ed8e-20210329T161723Z-avara=
b@gmail.com/
