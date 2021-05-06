Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B633EC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B4610A2
	for <git@archiver.kernel.org>; Thu,  6 May 2021 09:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhEFJUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 05:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhEFJU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 05:20:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539BBC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 02:19:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s7so645421edq.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=upzM/ZyZcmZzAT3jhA5UV8y3uTm8ZOtf0S8ioT0A9EY=;
        b=AeN9ukH2n8wXGMhFpbNbf8DF5nX+RSwAX1IlayN5Q6+jX3CPuF4se1uuOV6ex1GjM9
         2PFX8zX1z9uV5mlJZ8PqE0+1TJQ69OncBJxG/wqm5EBq0Xiu/FT1tEA7lQrC2k04nh9Y
         uKYpTKlN/q5TdcH2R4cXy0h1qRPvj9x1WPYhg7CBbcyk0TgZq8jJ6zbEJmfpzN9SkEyt
         o/ziEGgKDY40mBBd0pFy/xeoSSl67vjTMvANqEIAw7r0wuWrgWFYaEGVWugDn0Ghaeek
         qcvtAWeYZ/+oRtnhLytvWeYZn4hjtXX79On5jCOp3PxWjF+ZWHEofvt0qAUPapB5sNFT
         V0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=upzM/ZyZcmZzAT3jhA5UV8y3uTm8ZOtf0S8ioT0A9EY=;
        b=YEh1uqEXi0/z2Q6iBbu1PbgMXN0aIBQ1FUx2VsEYbRw7h70s58aqnA/8KNJf6iJVjQ
         5AyMBaqPQdvucmqFTTF8GBgP7aAQii40XqI2JSHycbn7rbeGbrUWiLI10pDgoh66nlE9
         b5yGwfKnEdsEhsMo2CnHR5gZXhvUOearNQRqY6KDKxePP5TIfVvP1UpenG9/I9fAhPoO
         OH2I77jsnyObubmFBOswjwzo3iDggFKNnH4S9N/Lh+koO7mluGfNbk8hp3MX79waAQu7
         SVF6xRN1rlxyrnz/lx7uzLgavfzobY9tF9zPAlkG7qlUZ2rKI3SoxdC1GqHd8KQlTIKy
         th9A==
X-Gm-Message-State: AOAM532whCcEfI7uXs5WZFslQpbww5ZyEoSa/b+DMx6lTgDmUL8sB/BD
        qlBuXMhoVt+t7EKNm+Vfzao=
X-Google-Smtp-Source: ABdhPJyWahIDE7ZBkmHAU8YxFla6F4DLafPDryqQVMjZ819c0w51n3omtigHUJZXAvgb4cqiBuWUUw==
X-Received: by 2002:a05:6402:2366:: with SMTP id a6mr4036860eda.10.1620292767880;
        Thu, 06 May 2021 02:19:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r15sm1140901edp.62.2021.05.06.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 02:19:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] Makefile: don't re-define PERL_DEFINES
Date:   Thu, 06 May 2021 11:04:34 +0200
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
        <patch-1.4-ed2005a2fbf-20210505T121857Z-avarab@gmail.com>
        <YJKm0dnwHBwQuTi+@coredump.intra.peff.net>
        <87y2csv0qm.fsf@evledraar.gmail.com> <xmqq7dkcz20u.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq7dkcz20u.fsf@gitster.g>
Message-ID: <87sg30usm9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> -PERL_DEFINES =3D $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
>>>> -
>>>> -PERL_DEFINES :=3D $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
>>>> +PERL_DEFINES :=3D
>>>> +PERL_DEFINES +=3D $(PERL_PATH_SQ)
>>>> +PERL_DEFINES +=3D $(PERLLIB_EXTRA_SQ)
>>>> +PERL_DEFINES +=3D $(perllibdir_SQ)
>>>>  PERL_DEFINES +=3D $(RUNTIME_PREFIX)
>>>
>>> I don't think we generally use simply-expanded variables in our Makefile
>>> unless there's a reason. Do we actually need it here? Obviously not new
>>> in your patch, but just a curiosity I noticed while reading it.
>>
>> I didn't notice it at the time. I suppose it could be changed to not do
>> expansion, but per-se unrelated to the more narrorw bugfix in this
>> patch.
>
> Actually, strictly speaking there was *no* bug because assigning
> three items with :=3D made sure the previous recursively expanded one
> to be ineffective.  In other words, there was a valid reason to use
> ":=3D" there in the original version.

Yes, there wasn't any bug with the the eventual value being
incorrect. I.e. both of these are equivalent in a Makefile:

    FOO =3D abc
    FOO :=3D def
    FOO +=3D ghi

And:

    FOO =3D abc
    FOO =3D def
    FOO +=3D ghi

Both will yield "def ghi". They're just different in a case like:
=20=20=20=20
    X =3D Y
    FOO =3D abc
    FOO :=3D $(X)
    X =3D Z
    FOO +=3D ghi

Where using :=3D will echo "Y ghi", and using =3D will echo "Z ghi". As a
practical matter the distinction doesn't matter in this case.

> Now your patch removed the recursively expanded one that was
> immediately invalidated, there no longer is a reason to use :=3D
> there.  So "unrelated to the more narrow bugfix" is a rather lame
> excuse to do only half a task.  If we remove that extra one (which
> is a good thing), then we should correct :=3D into =3D because the
> original used :=3D only because there was the unwanted extra one, no?

I don't see how removing the stray line changes the reason to use ":=3D"
or "=3D" there. I agree it should be removed, it's just unrelated to
removing the stay line. Looking at 07d90eadb50 it's clear that it's just
some copy/pasting error.

Maybe the confusion is that I'm using "bug" closer to a meaning of "a
thing nobody intended to be in the program", not just "a
behavior-changing issue observable from the outside".

In any case. I can just submit a patch on top of this in a v2. I
continue to find it hard to discover the line between superfluous
while-we're-at-it fixes in your mind v.s. "we should fix this while
we're at it" though :)

But regarding the "half a task" it seems to me that these are different
issues; I don't think that's a point worth arguing in this case
specifically (let's just fix it, and I will), but perhaps I'm missing
something subtle with regards to Makefile semantics per my examples
above so it really is all one issue, and I'd like to understand how
they're entwined.
