Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017DBC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiBLWiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 17:38:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLWiS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 17:38:18 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7A13E2A
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:38:14 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id m185so15745164iof.10
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=HXJsrvaYZINcBJdDqRsL4iSvzc96MUle+Utqsv3x24Y=;
        b=Y099YFu+44tlqp8u2/ymHdHEDCyd842IuJWQbQJvRyaY5XtPfYYqJnDSVp4qC4/z2f
         CQE2UEXk6yPF7yf2ipfkcwd5T38/41sizwgM+hEv7iAhzvuav5Dj4+bTDcxSpr40jAL2
         iPg6G+Cwl5sObVut/SguMF7niRgacazAX+CC5Jzu/OO1UauFhRroHJoAEzVpUFzWXCzI
         mo1GyJ78nHQVoIg7k7xNeN/pSpfJXL/IoSlTn6vGA86ufqdwTwsvFtwdnT+evLcrsoqh
         E+t0rAvjFvZE9K9NbpOyeYoVi5BPcIpQOhpmITYVhdGmU1HTvvQbK704E4qa183zX270
         0B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=HXJsrvaYZINcBJdDqRsL4iSvzc96MUle+Utqsv3x24Y=;
        b=fK6hRKifKp32Rf0XqB+VzVtGYleRSqPIcGGGcIYDeduzcjhbqXbIBMgQUCCHa/PmcV
         014ygksGzRCkesTh6m5pmpZeXJZsH9BjHEC4R4li8nZpfn4Ob++oQJLOi3VvwOXGaciN
         VBpig2o2CSpmcdvCxy7g3UpYVk0AVgE3J5KSmh8wn3MV+esxvKIydB87px1xH4rLGGDr
         2gnuDxZvzW8Ku+MeUzGi3qciL/uAePStA3vcUXaA9OrOOtwD5Ajlf7l6ggQUAz/mqwno
         E0xNK8aEuTzMr7tQZtq5suS0IiBZwJVPl6l22gA7PX0XGQnuDSMYclqi5+n3ao1AoHBQ
         6UDA==
X-Gm-Message-State: AOAM530DhyWE7WjpLw2AwtYb4oUGyTNjN3sx+yG8I2JHXrcc2asemD57
        tYKanO6P/0ImczJ0eVdtJSgaxuqrjVcrMA==
X-Google-Smtp-Source: ABdhPJyv9y7r0fSlik1wTjVqyVBqVlJ6XXZ27egy/PQa3bfhB45e8wgVj4ewViMUNqQqUVVuyEcC0g==
X-Received: by 2002:a5e:9249:: with SMTP id z9mr3904966iop.188.1644705493214;
        Sat, 12 Feb 2022 14:38:13 -0800 (PST)
Received: from EPIC44019 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id n3sm16876298ioz.9.2022.02.12.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 14:38:12 -0800 (PST)
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
 <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
 <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> <xmqqa6guub9n.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112221717440.347@tvgsbejvaqbjf.bet>
 <xmqqczloju0q.fsf@gitster.g>
 <032aced5-4c50-76f7-9ab6-580ffa5775a5@iee.email>
 <xmqqh7ay6en7.fsf@gitster.g>
 <7c98ad08-046c-d2c2-2bfa-e6b559f41fd3@iee.email>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Date:   Sat, 12 Feb 2022 16:29:39 -0600
In-reply-to: <7c98ad08-046c-d2c2-2bfa-e6b559f41fd3@iee.email>
Message-ID: <87pmnrww1a.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley <philipoakley@iee.email> writes:

> On 24/12/2021 00:16, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> They had the issue that their windows users, using Git for Windows, do
>>> not have the `man` package installed. Rather the `web` help of using the
>>> .html version of the man page is used (needs administrator install in
>>> some case). So user commands would need to provide both the man page for
>>> Linux systems and some process to get the html equivalent into the right
>>> folder - this latter case was the problem step.
>> So are they willing to prepare `web` help pages, because that is
>> what the users of Git for Windows are already familiar with, if "git
>> foo --help" is capable of showing it, just like "git commit --help"
>> shows the `web` help page for the subcommand?
>>
>> As I said elsewhere on this thread, lack of equivalent for MANPATH
>> and INFOPATH makes `web` help harder to customize in that direction,
>> but that is a problem we can solve in our code.  Once it is there,
>> they can let the user install their `web` help pages into somewhere
>> the user has write access to and point at the "folder" with
>> GIT_HTMLPATH, I would presume?
>>
>> Thanks.
>>
> I'm not sure if they are willing to create web versions of the man page
> or not. The request was that we should let their code decide by passing
> the --help option so they could link out to whatever process they have -
> maybe it's a SharePoint server with fancy presentations (I never liked
> them, but many places have drunk the cool aid).
>
> Having an alternate GIT_HTMLPATH could help some users who do have html
> documents, but I was cautious about letting ourselves over automate the
> mechanisation and still leave the users out of the picture.
>
> Hopefully Sean will be able to clarify if I've misunderstood the details
> of their problems.

Sorry for my delayed responses -- I lost the battle to make Gmail do
what I wanted and needed to set up an alternative email client.  This
took more time than I care to admit :-)

Yes, the core of the issue is that Git (for Windows, at least, but
evidently this also applies to normal Git) looks in one spot for HTML
help pages.  We'd be willing to create the documentation in HTML format
if that means making `git foo --help` work, but needing to drop these in
the installation directory of Git for Windows raises questions of how we
keep both Git and the documentation for our tool up-to-date.  (This is
assuming we can hack around the obvious 'admin privileges needed'
problem.)

Having a GIT_HTMLPATH variable could resolve this problem for our
use-case (provided that the resolution is similar to PATH).  Making this
a normal PATH-like variable (with support for multiple paths as you
would see with `echo $PATH`) sounds like a good, extensible path (hah)
forward.

--
Sean Allred
