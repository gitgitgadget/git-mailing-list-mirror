Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D05C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C2364E08
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBCQqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBCQqV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 11:46:21 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26623C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 08:45:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y18so290218edw.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 08:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xwFp53iSo2yJcNOvDAmjLPt/Xurg3wnn4cEbXt1ZpHc=;
        b=rBj3FjgrKu96yGWkXTGhJSz3zVoX/BPKFLuUyhO38/rqIlqWAqrV14hV2RrmOlxuos
         MsKxObCyAtK+Ilott9qhDx/iYdfmbugiLHDXQl87Z1HqzH97KtkNo2fjsw+Xrwj+oBw5
         MTm5XmhfMDFzyUEA2mhuHlcy3BGXH6ltDagoAzdRKcJvLjuvUyKfxVshg+TvSQS/FtWc
         KVrwSI83lGQHRZOj4tao3LxVAS8I99BbDdPCLXvLGaGoL9MsVIntY3maLf5xYx7nMIah
         uigebTUh1fblJhiQ8TWHTiyQweIGvPqFI6tmfcvhJPm+Pg5j0BEe25VZmGi2a+DTB80h
         yQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xwFp53iSo2yJcNOvDAmjLPt/Xurg3wnn4cEbXt1ZpHc=;
        b=tbX4uwVfQOAdhxMLpnCpXXC7H8lbpFXWd+ejXOE6sjy4biTQhCjOXam4m7vloVQbgY
         lwHr9c4OWioXdQFpAgbdXnClyaU8JaWid21F8YQRwb+y1HCix8mvi4v0Q1vunaNsuvWQ
         QuxMwRZsA70UMjT42B7oyaLOvPpqqz1GlIiahTgVFY5GAY4K9x3INRDUcAyFmw1jipR8
         PFpyxzyTT3A1FQjmgP0o8Mxr9fe/BAhiZU5Grbscte4SjbtpP3VWLDlH2Ma7If8iFu8a
         Z8X4CDZiJw62Zd0N2rJbo208z16iwvRNqzu3pZIUY2Nq2/9m1yv2tD47p48ZoHxCT1Wz
         rUEQ==
X-Gm-Message-State: AOAM531Qn6grMs0v6SzU1gqMG8YmiUBvlxXqiIiq2JORjdE3Ab0wLMVx
        qnXr3gPYRk43CvNXv9ktHkabb8jlSd97fw==
X-Google-Smtp-Source: ABdhPJwKH+5BMVmLiiYzSBDqtDl9jgGXm2SmIZXweO7jxKH0s4pHiDmqsPlD6rqYAAeVqS6D5NwhWA==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr4062241edv.307.1612370739775;
        Wed, 03 Feb 2021 08:45:39 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id s15sm1213849ejy.68.2021.02.03.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 08:45:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 22/25] Remove unused kwset.[ch]
References: <20210203032811.14979-1-avarab@gmail.com>
 <20210203032811.14979-23-avarab@gmail.com>
 <CAPUEspgBmuTBHVZWY9fRtjbHWBRr0zHravLL1Czepc6jmib4HA@mail.gmail.com>
 <87a6sldytf.fsf@evledraar.gmail.com>
 <CAPUEsphN7QuSVsC1Tr4xE8yQgPTtpF7wL7zbk1crQU3n-5g6JQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAPUEsphN7QuSVsC1Tr4xE8yQgPTtpF7wL7zbk1crQU3n-5g6JQ@mail.gmail.com>
Date:   Wed, 03 Feb 2021 17:45:38 +0100
Message-ID: <871rdxdrrh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, Carlo Arenas wrote:

> On Wed, Feb 3, 2021 at 6:13 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com>
> wrote:
>
>>
>> On Wed, Feb 03 2021, Carlo Arenas wrote:
>>
>> > this is still being used in Linux without Glibc (ex: alpine or void th=
at
>> > use musl), and other OS that rely on the compat layer by default for
>> legacy
>> > reasons (ex: macOS and Windows) or where PCRE2 is not widely
>> used/available
>> > (ex: OpenBSD, NetBSD)
>>
>> Are you perhaps confusing kwset with NO_REGEX=3D1 and compat/regex/*? I
>> just say that because that's a common "Linux without Glibc" && musl
>> fallback.
>>
>
> Indeed, my bad!
>
> FWIW I was not arguing against this patchset with my comment, and I agree
> with you that the less old unmaintainable code git has, the better.
> will give this patchset a spin as time allows and hopefully report back
> with some more useful feedback.

No worries, the whole fallback mechanism is quite confusing. One thing
we've got going for us is a hard dependency on REG_STARTEND.

I'm not doing this in this series, but I do have my eye on eventually
migrating other things that use regexec_buf() (and thus might need to
match across a \0) to the grep API, and dropping compat/regex/ in favor
of some version of compat/pcre2/.
