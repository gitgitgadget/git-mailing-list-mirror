Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F5C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 00:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344390AbiFDAt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 20:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFDAt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 20:49:56 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E411D0DD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 17:49:55 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so5848961ejb.11
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5dAsgWmv0Hke8rrwldpSJsfC3ii9N0LsGD/JXSa96PI=;
        b=Jl8F8oGsPnOXxEBOCLdK0r9XAVzFEfXVO2/WU5gzQ1+iz6/lGlfjKTu6gsa4DjvGYs
         iX55wJ2pYmsrsca2Zrsh6VlAGkvj7NdgRWEBdUbbyPyRt4YzcYn/9OTr8tzYrXSXGfoX
         ZZp15qp1jOMrQ2GK/LGsMSKSA7+vUcEdfnTC2LPt9AU1j1jCrz9P7EGguAHIxVEJO+pq
         QfxebMEhwo07hfnbs1dbVEtAM+uXSqm8MK+KDx6iKzltMHU8eYuXjsyb316pTMCa+BWK
         re2vcgIzbypUpxNMFJzHps8qUjmVIFUYsmhcEQ1MZ1+9TPFmdvE7wlgVdP6PP32Ws1u6
         Et0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5dAsgWmv0Hke8rrwldpSJsfC3ii9N0LsGD/JXSa96PI=;
        b=Sx1nfA55WfYtVhxTakecMMNhokjhGrAvuIcWeafyfEtBD7hkWKtNizd9FVTifNy+1i
         v5rL3ntbFE/JDozNb8uyTte9BBiyW2JzkBE7bh4i/QXlM0Qhuh2a3ovc9DeMeoOTHezn
         5p5G1y8orJyI4WHNF1W0PE9s69aB1DNWHBNkZaBMF311+didHi32dAdEsev9X5Hik51B
         c+FKRlLNPnSvy6+zVKqFT7Z0oYP0F/Lz+mAVJtEqidkCTaK3RzLDhQhLwRNnKhi4pExU
         FXd0lIwpA80sbM45CBsUX03gqYYfyzfPmI3Qwrucu8hpJh2f84LEi3n8gFxU/PZv92Hm
         /OJQ==
X-Gm-Message-State: AOAM5330A4jRpYli/fqbk8EEXeM5bM2+mgziUWDzWNURJSipFIRz/9m5
        aN40ccHQCDVnWPlsFH59RJ4=
X-Google-Smtp-Source: ABdhPJwJrwpyKLkHh09N2QozJEIkZ48IEmU853ojRWDkyBHKWbRt39egyrLot2l39/O8jTB3EqSgXQ==
X-Received: by 2002:a17:907:62a0:b0:6fe:69f3:88de with SMTP id nd32-20020a17090762a000b006fe69f388demr10634217ejc.214.1654303793523;
        Fri, 03 Jun 2022 17:49:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709061c0900b006fec27575f1sm3338675ejg.123.2022.06.03.17.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 17:49:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nxHzE-001xCM-3G;
        Sat, 04 Jun 2022 02:49:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] tests: don't depend on "git init" using the
 template
Date:   Sat, 04 Jun 2022 02:41:16 +0200
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
 <xmqq8rqdftfg.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rqdftfg.fsf@gitster.g>
Message-ID: <220604.86tu91w8un.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This reduced-in-scope re-roll of [1] changes those tests that
>> implicitly relied on the existence of the default "git init" template
>> to no longer do so. This makes the intent of the tests more explicit,
>> e.g. in the case of the .git/branch directory.
>>
>> Parts of the v1 were already split up, re-rolled and merged as
>> a5bf611cc4f (Merge branch 'ab/hook-tests-updates', 2022-03-30).
>>
>> Future goals: I then have a local topic on top of this to add the
>> "--no-template" option to "git init", and to have the test suite run
>> in that mode by default, that's currently one of the blockers for
>> making the test run without the bin-wrappers[2], which as noted in [3]
>> leaves us with some blind spots in our tests.
>>
>> But for now this is all relatively straightforward conversion of
>> existing tests to make them not rely on "git init" giving them a
>> template, which they opt-in to with a new TEST_CREATE_REPO_NO_TEMPLATE
>> variable.
>>
>> Junio: There's a trivial conflict in one of the tests with "next",
>> i.e.:
>
> Heh.  That is good to know, but I am not sure why we need to run
> without template to begin with, so "why this much churn?" is my
> first reaction.  Without the churn in the first place, we do not
> have to worry about unnecessary conflicts ;-).

A few reasons:

 * We currently lack test coverage due to the bin-wrappers, as noted in
   the "remove cwd" topic, i.e. we couldn't easily test our own $PWD
   behavior because we run tests through a shell.

 * It's also much slower, as detailed in the linked thread(s).

 * When I do a full test run I get ~790MB of accumulated trash (if I
   have the tests not remove "trash directory"*), out of that ~168MB or
   more than 20% is just 'hooks' directories.

   Particularly on boxes with slower I/O (including CI) that really adds
   up.

 * Since the original submission we've fixed the bug I found in the
   sparse-checkout code where it had a hard reliance on our default
   templates, which "init" and "clone" allow you to customize.

   So having our tests provide you these by default leaves the door open
   to other such bugs, better to not rely on that at all.

   This series doesn't get us there, i.e. the default is still to
   provide them, but with these changes it'll be trivial to flip that
   switch in the follow-up series.

But yeah, this doesn't give us much more than churn *right now*, but I
think it's worth having these because the end goals above make sense,
and if I'm going to include the eventual benefits in one series that'll
be a much larger topic that'll be harder to review. I'd much prefer to
split up some trivial "prep" work first.

Thanks.
