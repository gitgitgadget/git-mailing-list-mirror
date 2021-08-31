Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF1BC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8D060F12
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbhHaUab (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbhHaUab (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:30:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DFC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:29:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i6so1095711wrv.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ib+lGCA/I2QNmnxo+EcDS2R5HjDlk8iXuQ9bwJJAOD8=;
        b=kH8trj1kcYCW+DAufgFCBaEHRSQ8BgwQAmMg6VlJXv9orWITlMEjUnmBJuzoUHBbB9
         S5SWp+omsLHnUgI5ptIxwIOi8i4pJXlM1BE70pyZ/msHBlKAnNeah3pavH1hXSldmo3+
         iJXEyp6DY69h+CFfnP2CQ5lQyieV+ur3U4mbYhtqiN21XYsWvr0APyjzbQAZHI2jnBFd
         RkE98htKk872D/uNKjQBFcLlHsAKaBlJxlJVTuzCBS95+Dful+uZ/pMnzSbGhg7kSW2G
         3OL66PXEfkEN7e26SQee6pVbKcexoaex3afGaLZOtjlNRdyqN4O8a7omub5j2tv1SHna
         6I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ib+lGCA/I2QNmnxo+EcDS2R5HjDlk8iXuQ9bwJJAOD8=;
        b=SZQAgA1eJ7yJUQOlRFNoNUp0LxpwRBW2CWJK3YvByHGaYJBz7lHBziOhJ9D1Y6BQnq
         kb3RmoxsPAq9OA7hXhkCwoeLVrHAqjRvCuxPJDAfelM2PLvelIAEvtnaAZuMB0M+JCk+
         s5FoLGYKK3XFlJOktMklSgnd6PxxSzaY01kJRI1mi6TWNTSA5/hwUJItgvlXqg7GgfYs
         lEja8RaWukAtytw2fX2mKUQRLbORU+SJIyGIqn1/UES+gd75CPh37yz+h3RP4o7VGuHw
         q/vXsWop1C5D331jQEqQqAS1XI6cdjrA5emxxKg5xi6H0x+q8zvtX+rXUVcI7ect1Pvn
         WahA==
X-Gm-Message-State: AOAM533DmDeWv0BCkWjRRWhdyqBT/9d4E1b/e0a8+ue3oTyuOqUUE5Ep
        u8VhhNFAEnw838uhiLzNQWI=
X-Google-Smtp-Source: ABdhPJwLmRwVGWcfhpSlDWZFSETjD9seFtXh+x6j51dlUeXNX7nAzwNCfADmIAvOk9AyOIK7dbCwNQ==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr34727283wrr.382.1630441774006;
        Tue, 31 Aug 2021 13:29:34 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o7sm3347763wmq.36.2021.08.31.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:29:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>,
        Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Subject: Re: [PATCH v4] pull, fetch: fix segfault in --set-upstream option
Date:   Tue, 31 Aug 2021 22:20:46 +0200
References: <patch-v3-1.1-68899471206-20210830T144020Z-avarab@gmail.com>
        <patch-v4-1.1-0caa9a89a86-20210831T135212Z-avarab@gmail.com>
        <xmqqfsupwose.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfsupwose.fsf@gitster.g>
Message-ID: <87h7f5we6q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 31 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>> Testing the new behaviour is a good idea.  I also agree with you
>>> that die() would be more appropriate and does not risk regression,
>>> if the original behaviour was to segfault.
>>
>> Indeed. I changed it due to your upthread
>> <xmqqsg0anxix.fsf@gitster.g>.
>>
>> I think doing s/warning/die/ here makes sense, but similarly to the
>> above comment: Let's punt on that and do it separately from this
>> narrow segfault fix. If and when we change that we should change
>> various other "warning()" around this codepath to "die()" as well.
>
> I do not think that can be thrown into the same bin as "should UI
> give irrelevant details?" issue.  If you make it not to segfault and
> give just a warning(), it becomes impossible to make it die() later.
>
> If we all agree that die() is a better action, that must be done
> now, or it will become never once the change is released to the
> field.

Because someone might have been relying on the current behavior of
segfaulting to stop their script? And a mere warning() would break
things for them by having the script "work" if this patch were to make
it into a release?

I think it's unlikely that anyone's running into this in the wild as
anything but a one-off, and in any case whether or not we segfault, warn
or die the behavior of fetch at this point is to have already finished
the fetch itself.

We're merely doing some post-fetch work of setting config etc. Both
before and after this patch we won't be setting the upstream config. But
yes, the exit code will change from a segfault to successful exit.

I think the first priority should be to just narrowly fix the segfault &
leave refactoring of e.g. having fetch do sanity checking on all options
before doing work for later, especially as we're almost 2 months into no
fix for the segfault landing on "master" after the first working patch
to fix it, so if we have that all wait on agreeing on the perfect
behavior for fetch error handling...

