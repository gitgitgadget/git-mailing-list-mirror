Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254DC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 14:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0756564E35
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 14:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBMOcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBMOcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 09:32:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D86C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 06:31:28 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i8so4145544ejc.7
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=q+4j5KxfWdgFYk+liL+jxHfVqFyGJ1nhxLIAipwNeps=;
        b=B34ecqXAdNkMvVn2VO701JPlhJ/bMq6SONd2yU/nZLUs+YR/Oy49NfhwlzjV9DD5QR
         PPun4BLUZ4wC3pluYnp0KKnPcG8sjryROaR3N7rZ1j6VdPa8CFuSZUrmCzxBJdzu/se5
         zzF2z2sjvrAZANrQJAGFoWTmaVaA1sTUtcYbKRgRguz4IpmwfXbIyZ7AZDTRDWmz+W5w
         Qt1EKe2MTcXAvLQlQZGGiO7gYfnPv4n9dG9zXjitRF2036SW85uBe9Sm4cneAZcuuv0D
         6TMcuAiJZPuByrBHmI4X6MnewHvz3V6C4yIN8Npq2Kp8WjCCdCFdMqoNQ7EU32DuqfTN
         Et3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=q+4j5KxfWdgFYk+liL+jxHfVqFyGJ1nhxLIAipwNeps=;
        b=qHO4vZKUw/bcAFe6eMYlbfavV/GqfJiAXiPFSkvf7OlI8A2R7mXDeOuLESP7mmhbfh
         9CJldixF038Wgtehe4ZjNjItx2qTrTUQsrEgZZxCrUS5HfYoF1jGfTZNpTs7B+UW6tpa
         LTog8jzJm6QzcPvrBsm5leW7NpzE9kEXzn/COms5/ihWp0rEjExOhItWtn97eDhmjKt/
         Ws7Li6ZMtb58Yg8zIbdu51dRUkmGca9q2ny8IaN+gkIlLqvuqj3/nQj5wDAp4SF2qhm4
         0yLU5vUgNyu98SpI9usWrZrCuQ/mhGbMHaLdgUv9gH07QlFwCy6XpEg01hEM+P7TkTqP
         Jobw==
X-Gm-Message-State: AOAM5313cN6CMmIdDWGts2YdDTvYxFwa5UeO5J4txaKJFODXz3LWr+L1
        1ID0pJQX4FJEjot4H9Zj8ts=
X-Google-Smtp-Source: ABdhPJyzHEsUWYLVBsq0tseRmS1XgMsH8NwavqCl8fy9+Jm9P9CFsYaEivIhEX+8g1vg9yRLB0tOhQ==
X-Received: by 2002:a17:907:1b12:: with SMTP id mp18mr8026399ejc.128.1613226686735;
        Sat, 13 Feb 2021 06:31:26 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hd19sm7442637ejc.83.2021.02.13.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 06:31:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tests: remove most uses of test_i18ncmp
References: <20210120182759.31102-1-avarab@gmail.com>
 <20210211015353.28680-5-avarab@gmail.com>
 <xmqqa6say0h8.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqa6say0h8.fsf@gitster.c.googlers.com>
Date:   Sat, 13 Feb 2021 15:31:25 +0100
Message-ID: <8735y0ca4i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 11 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> As a follow-up to d162b25f956 (tests: remove support for
>> GIT_TEST_GETTEXT_POISON, 2021-01-20) remove most uses of test_i18ncmp
>> via a simple s/test_i18ncmp/test_cmp/g search-replacement.
>
> I am a bit hesitant to take this step, primarily because the
> distinction between test_cmp and test_i18ncmp is serving as a sign
> for tests to identify if they are dealing with translatable messages
> or plumbing/machine-readable messages.
>
> If a totally different approach to test i18n messging part
> (e.g. Dscho's rot13) appears any time soon, it would be helpful to
> leave these distinction in, rather than ripping them out, with two
> caveats.
>
>  - If such a change does happen soon enough, then the codebase this
>    huge patch touches would not be all that different by the time
>    when it happens, so reverting this patch should not be too
>    involved, which means my hesitation is not all that warranted.
>
>  - If such a change does not happen for some time, then it would
>    become impractical to revert this patch when it does happen due
>    to changes in the codebase, if we apply it with the intention of
>    "we can easily revert if we need to".  But even if we drop this
>    step, until such a change appears, we surely will gain more calls
>    to test_cmp (and possibly test_i18ncmp) in the codebase, and at
>    that point, we can trust the distinction between test_cmp and
>    test_i18ncmp even less, which means it does not help all that
>    much if we tried to keep test_i18ncmp.
>
> So, perhaps we should bite the bullet and just take this step.

I think it either makes sense to take this series as a whole, or not
take any of it and also revert the already merged 73c01d25fe (tests:
remove uses of GIT_TEST_GETTEXT_POISON=3Dfalse, 2021-01-20).

I.e. if we're going to not remove test_i18ncmp uses then we should leave
C_LOCALE_OUTPUT & GIT_TEST_GETTEXT_POISON=3Dfalse alone as well (or
convert them to the test_i18n* forms).

As noted before I'm not invested in the outcome here, I just submitted
this to not leave the obvious post-cleanup undone.

My reading of the list discussion/consensus[1] (such as it was) was that
even if we had this rot13 mode ready we wouldn't think it's worth the
time investment overall, hence the follow-up patches.

Also, if we have it down the line we're probably better off with these
patches. The parts that'll revert cleanly can likely be resurrected
as-is, but conflicts would be a good thing, as that code needs to be
looked at anyway (it will be re-arranged tests that never used
GETTEXT_POISON in their current form).

We also won't have cargo-culting in the meantime, with new code using
test_i18ncmp or whatever just because the test above them did.

1. https://lore.kernel.org/git/20210120182759.31102-1-avarab@gmail.com/
