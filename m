Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A219C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 18:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348594AbiEZSWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 14:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbiEZSWx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 14:22:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DADDED4
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:22:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gi33so4578552ejc.3
        for <git@vger.kernel.org>; Thu, 26 May 2022 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=AD0Q6WudHTcZs6NWGNS7thUr0ORYTIN61rY/3L8yIW4=;
        b=OQu8ajfGXbKbzcxP4m4CW58rbmin+U+y0uM/3qX5fyaTr/eCyOgJyFoQUzsh3StiV2
         kWbuNzoVp2n/oCVca7BuhmvXEm4Er3laLGNTsUdLUoufm9+2TaWa1B0c15gTbFrSvnBX
         y970dS1len6orLlKSpnE5lhz2h5hePCFNZloBQX30WGAdBfjRV9Yo8Mo2ybAwPK9Lllz
         bebmrAatxKxNUPov5JQg4BFqeuUzpR0JToU+HcGnBeKYfbZbzeYjAfRKKCyq1JqQbU3y
         ObyV81muu0ibVvTxcVavQKdze11KDreDVW6qLhs9lXDzlpxnD/muCTNdpux1bGOv/SW8
         4OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=AD0Q6WudHTcZs6NWGNS7thUr0ORYTIN61rY/3L8yIW4=;
        b=AGWbH1GCnavo0GJ/MCCpu/m0OI4Y9j7+c+fD+JBKdDdiYib46jKEA2IECKRCafXzxv
         kdsFxu+wvsCKbkMsd3jZsKdQNyRTpJW7A4v/2ue1L0Et7Z1G2PhXfLBfUHT03VQzq6yr
         z58RzxDOor1H367NYYvbLVGVQNwKtyAqHdK86Qlb5Edu2QCdiRiRO0dW5p26bJCZz5hY
         kwWF6pXCik0A1cHWSnOrC6tDfjjdXRwS6qPy7cz5VuD8PIJd+gB9+Z1Yst6ZmDkphKg8
         XVp6L/nmpdnum6+5fo0c96KkH1VamUA3pqOkcDfTHgSgrGcpoUOx3dJQRaZxDOWw3RR2
         Oabg==
X-Gm-Message-State: AOAM532TyBl5VQu4nkQhsJciNd+2nC6TPP330ZCOvcfYpgAhNTAG0FZ8
        JO/JA+RxAOUTvjhnAGYPk9y11D7bL30DCQ==
X-Google-Smtp-Source: ABdhPJyD5WTzI7Y9QDoVUXbH0rGk7yfFcjNZfAjhp6E7R/Zklf0avYEW2AodMQa518pppLkEvCFBHQ==
X-Received: by 2002:a17:907:2d23:b0:6fe:8aef:b533 with SMTP id gs35-20020a1709072d2300b006fe8aefb533mr3647677ejc.650.1653589368974;
        Thu, 26 May 2022 11:22:48 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b3-20020a509f03000000b0042617ba63a8sm1064998edf.50.2022.05.26.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:22:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nuI8F-000EjG-Ek;
        Thu, 26 May 2022 20:22:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (May 2022, #07; Wed, 25)
Date:   Thu, 26 May 2022 20:02:50 +0200
References: <xmqqzgj41ya2.fsf@gitster.g>
 <df44b0cd-bba7-19f0-4e45-c0988239cc4d@github.com>
 <xmqq4k1c1a34.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq4k1c1a34.fsf@gitster.g>
Message-ID: <220526.86leuo5f2g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 26 2022, Junio C Hamano wrote:

> Victoria Dye <vdye@github.com> writes:
>
>>> * js/ci-github-workflow-markup (2022-05-21) 12 commits
>>>  - ci: call `finalize_test_case_output` a little later
>>>  - ci(github): mention where the full logs can be found
>>>  - ci: use `--github-workflow-markup` in the GitHub workflow
>>>  - ci(github): avoid printing test case preamble twice
>>>  - ci(github): skip the logs of the successful test cases
>>>  - ci: optionally mark up output in the GitHub workflow
>>>  - ci/run-build-and-tests: add some structure to the GitHub workflow ou=
tput
>>>  - ci: make it easier to find failed tests' logs in the GitHub workflow
>>>  - ci/run-build-and-tests: take a more high-level view
>>>  - test(junit): avoid line feeds in XML attributes
>>>  - tests: refactor --write-junit-xml code
>>>  - ci: fix code style
>>>=20
>>>  Update the GitHub workflow support to make it quicker to get to the
>>>  failing test.
>>>=20
>>>  Will merge to 'next'?
>>>  source: <pull.1117.v3.git.1653171536.gitgitgadget@gmail.com>
>>
>> The latest version of this nicely addressed the feedback I originally ha=
d,
>> particularly in improving page loading time. It's still slower than befo=
re
>> this series, but IMO it's manageable (especially taking into account the
>> improved information accessibility).=20
>>
>> I don't see (or have) any other unaddressed concerns, so I'm in favor of
>> moving it to 'next'.
>
> I see =C3=86var sent another reroll of "rebuild the base" and "then
> rebase a (hopefully) equivalent of this series on top", but I think
> it is unhealthy to keep doing that.

I'd understood per
https://lore.kernel.org/git/xmqqwnecqdti.fsf@gitster.g/ that you were
mulling over whether to take my version of js/ci-github-workflow-markup
or not, and you rightly pointed out some bugs in (at the time) the
latest version.

So I re-rolled the two:

  https://lore.kernel.org/git/cover-v6-00.29-00000000000-20220525T094123Z-a=
varab@gmail.com/
  https://lore.kernel.org/git/cover-v6-00.14-00000000000-20220525T100743Z-a=
varab@gmail.com/

As the latter of the two notes there are some outstanding bugs that
hadn't been noted before in the v3 version of
js/ci-github-workflow-markup that you currently have queued.

Victoria: This includes a bug in your
https://lore.kernel.org/git/patch-v6-10.14-90a152d79f9-20220525T100743Z-ava=
rab@gmail.com/
where a patch that aims to change the *.markup output alters the *.out
output, i.e. the "raw log" output now omits output that you were trying
to omit from the *.markup output.

But as the performance numbers on my version notes the new GitHub
foldable output seems to be around 20% faster on top of my "base" topic,
the reason being that structurally un-folding "make", "make test"
etc. to the "step" levels is asking the already overworked GitHub CI
JavaScript to do less work.

And while it leaves the new output Johannes is proposing on by default,
there's now a facility to disable it:
https://lore.kernel.org/git/patch-v6-14.14-0b02b186c87-20220525T100743Z-ava=
rab@gmail.com/

Which at least for the time being is something I'm going to use until I
can figure out how to speed it up & get the now-missing parts of the raw
log output back,

> Does the latest "rebuild the base" part look unsalvageably and
> fundamentally bad that it is not worth our time to consider joining
> forces to polish it sufficiently and then build this on top?

I think per [1] that Johannes hasn't looked at the "base" topic in any
detail out of a belief that the two approaches aren't complimentary,
which I think the ~20% improvement in performance (per my re-roll, sent
since then) shows that it's worthwhile to combine the two.

I use CI quite heavily, apparently in a way that neither you nor
Johannes use, because even with that improvement I really don't find the
new output worthwhile. I.e. I can open/search the raw logs and sometimes
even figure out what broke exactly while the new UX will still be at the
spinning loading icon.

But as noted above my latest re-roll provides an out for that, you can
just change your ci-config to use the old output if you'd like, for that
and reasons I've noted before I'd really prefer to see the combination
of the two land.

Thanks!
