Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7EC433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB5561056
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 18:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhKNScm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNScl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 13:32:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D71C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 10:29:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id w1so61695931edd.10
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=D26m46w8V1wql7G/6NI2YOTSeu/sJq0gq2kf9z85GZw=;
        b=V6SBLBvR7dadN3fdBCCGiedar1OhL4XOj5C36rs9TjmVvWQHLCGGg8KfFnEZXrfyq7
         s25iEvQbBgDRYmcoVL/GOPBR47EVDCdemP7B4AyoY5JDIG2EcM7eIC/5fpgVymUTo3g8
         IMBP9Y5cFFa4W2pUfj+ucrXHdpy+k06FsrixK2xR/fXqCfIXLLg03hJwJqqbsuG1RkFA
         thucNI++9HOkMw/IGiDAqgM3uFVHw7aiQKLr+C5QIkDuAnCYgyn+39fE3GO6Ir54YanV
         V3pCH6S+5xTl69SlWb75B43XUNg6NfRKrpmtrU6u0YChhWcwprYD44M2skP3o3S6rjIV
         4GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=D26m46w8V1wql7G/6NI2YOTSeu/sJq0gq2kf9z85GZw=;
        b=qCNS/JT+T5s1ZkIuQnnynKA1iTbv3ZyC7+mw3MX5hVsmr4NHtLB14d6e7p2zJBON9f
         AkspzQER00umXRGB8vmJwwUfkiQEjvyiatXKMM2sOi5/4wUp2dWA2rHfyrZKTuDigIiJ
         XV+CUl1JyhVlGkYtCNQQaRrdu3YnFRMlvh364ikpzGuyzHalOECuBEZLA8XwjvAc963r
         sipXKz3mtLjQOLzL3lww1SMHIEHt8JHjLq/qTUuiwycCq3S5FZaXIEhaRu6mCLQTidV9
         M7AEUMNnocMoX6vgidS4r6MCj1uFapZhuQ73RoK8cLPULmBTNo/TjyDjGUlBv6uiZtTl
         dfAA==
X-Gm-Message-State: AOAM5300C6d7aFFUUvjMpiLTuMoW1amc4JjQLY5Wt6MdFVeQfZK0CKu/
        IBos3eUv3qTz2fNdbkPTynq5f+P09/g=
X-Google-Smtp-Source: ABdhPJz/kwGgG1t27x4qb587j/cK6ZAERBNGh2YaIAeTVrm+XPxhN/FD0svfqvHirSdI4723yA8Qjg==
X-Received: by 2002:a05:6402:4d5:: with SMTP id n21mr44820293edw.303.1636914584623;
        Sun, 14 Nov 2021 10:29:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w24sm5282507ejk.0.2021.11.14.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 10:29:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmKG7-000suX-Py;
        Sun, 14 Nov 2021 19:29:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Is 'for (int i = [...]' bad for C STD compliance reasons?
Date:   Sun, 14 Nov 2021 19:25:31 +0100
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g> <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqilwulims.fsf@gitster.g>
Message-ID: <211114.86zgq6si94.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 14 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Also, our code does not introduce a new variable in the first part
>>> of "for (;;)" loop control, so even if the original lacked decl for
>>> "i", the posted patch is not how we write our code for this project.
>>
>> Just curious: Out of preference, or for compatibility with older C
>> standards?
>
> The latter.
>
> cc0c4297 (CodingGuidelines: spell out post-C89 rules, 2019-07-16)
> adds a few "weather balloons say these are OK" together with this
> exact one as "not yet allowed".  We (at least, those of us who have
> enough knowledge and authority to propose changes to the guidelines)
> all know that particular feature is a nice thing to use if everybody
> we care about supports it [*1*].
>
> Here is the thread that resulted in the relevant part of the
> guideilne.
>
> https://lore.kernel.org/git/CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQM=
t=3DV38w@mail.gmail.com/
>
> The "another patch that tried to use it late last year" the thread
> refers to is
> https://lore.kernel.org/git/20181114004745.GH30222@szeder.dev/
>
> If I am not mistaken, Carlo added gcc-4.8 CI job to catch these
> recently?
>
> Now, "Centos 6 is no longer" cannot be called a good response to
> this message.  We stopped at seeing the first failure, and breakages
> on other platforms were not even counted back then.  To those whose
> compilers also barfed, it was sufficient that we pulled the plug
> after seeing a failure on Centos 6.
>
> But two years may be long enough for us to try again.  If we want to
> pursue it, we'd need to raise a weather balloon that would break
> compilers that have been happily grokking our code loudly by being
> in a central place that will never be conditionally compiled out,
> and is easy to back out by being in ultra-stable location.
>
> cbc0f81d (strbuf: use designated initializers in STRBUF_INIT,
> 2017-07-10) is an example that Peff found and used a great such
> location.
>
> I know you are capable of reading Documentation/CodingGuidelines and
> running "git blame" on it, and then use mailing list archive to dig
> to find the answer, and it was a bit of disappointment to see this
> was asked as a question, rather than a well researched "now after
> two years, let's try this again".
>
>
> [References]
>
> *1* https://lore.kernel.org/git/xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.=
com/

The issue on CentOS 6 isn't one of incompatibility with C99, but that
the version of GCC refuses to compile C99 code without -std=3Dc99 or
-std=3Dgnu99. See [1] downthread of one of your links.

But yes, it would be the first C99 feature where we have a known
compiler that needs an opt-in -std=3D* option to support the C99 feature,
I think.

1. https://lore.kernel.org/git/20190717004231.GA93801@google.com/
