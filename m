Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0216EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 07:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGHH00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHH0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 03:26:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41510CE
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 00:26:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403303dc14eso6860971cf.0
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 00:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688801182; x=1691393182;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0QrSho9VCChOdpj7ZeffsLSBA+h6Tmb+KEfvfG1Lk4=;
        b=T2fF66PEqnTR82Zpcip23lecOXqg1HFRHP5gpBRy2uCs5qESSH/+G/3C4evxLA+6ai
         /4Gis/aJ2I28KoGgGx94ja4uNb3Xy6JyTLRWIaoigdj3qGXpJesTfxMcpctPJaLGyKHe
         mjYJs43qRIfxLZGuXmIp6u+/KBlaBBBf7cBZh6cnvcwYkiW6Xbau0/OFe4MQcwxqrOhM
         paLZAkU5Us5Whtm+gi5VWhZlExdNQ90GNjEe/jXiWUGZxGwmHMmCI0SeEvk0m0FiWaQL
         QCRj8xTISkTFMKrwr6pYjDkweTVMEzzRep6NHkdkDOJGUnGeS5TW9Gt2Q9qs7nsE6y+H
         SifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688801182; x=1691393182;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H0QrSho9VCChOdpj7ZeffsLSBA+h6Tmb+KEfvfG1Lk4=;
        b=bcRnsJ490AylWUlZwFhy/K40z2vaQfSbpT1w/Nq0EO9JdaCfQVuf6n6p+86+20i1an
         vXeP9i5hKh+vFkBwr3XOqu9ULETlBPrCWJEglkneoPcFG9Nybcv6h97Cptevv1WCUCIt
         Csj3pcqZ4D3Kznn/COareE/TRWtWZ5BkGZehgkCeAoIjHxyRn7wMrIWJYPrgiX2ZjF5c
         NWROSSGvW2xwrH6/Kjqo1IwiK0m4T8UsjooHqAQdfgyihgE2oKIMjNN+ec14Mkv7n4pw
         /tvRYRQb2rInz1YaAakXg8W8j8vgc6ilVYzae+6ioOaGQX6OHNMd/IUjmoxYu0PFNjFX
         dFYw==
X-Gm-Message-State: ABy/qLYIb63ItlTw7uA+4bo9SwXl5e/W0+kxW8K9ta/qknrVLFLzRo4P
        SA1kZUGhpPOz5SdGGaHrEJs7MPu2lS8=
X-Google-Smtp-Source: APBJJlEmI4jAI00mBn8qao1DRQD1zPxYcwfJ+qpKpiUD64c7MP12Quys/mRD/NeeIB9Q+MZW/lR0gw==
X-Received: by 2002:a05:622a:1899:b0:400:aaa0:a4ef with SMTP id v25-20020a05622a189900b00400aaa0a4efmr9478477qtc.6.1688801182439;
        Sat, 08 Jul 2023 00:26:22 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::12])
        by smtp.gmail.com with ESMTPSA id d62-20020a0df441000000b00577409a2958sm1599125ywf.138.2023.07.08.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 00:26:21 -0700 (PDT)
References: <m0ttze4qzl.fsf@epic96565.epic.com>
 <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
 <m0pma14sbx.fsf@epic96565.epic.com>
 <CAPMMpoiC8oca0AVNy1f+zy26L_b-ADyNopY4zO3r+v6v-KEH=A@mail.gmail.com>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Sean Allred <allred.sean@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
Date:   Sat, 08 Jul 2023 01:27:54 -0500
In-reply-to: <CAPMMpoiC8oca0AVNy1f+zy26L_b-ADyNopY4zO3r+v6v-KEH=A@mail.gmail.com>
Message-ID: <m0zg46eueb.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for the replies. I'd like to bump this up again. This has come up
in a new context and I don't see a viable workaround for us that doesn't
involve a rewrite of the process and an excessive amount of new
infrastructure.

I have a feeling this is somehow a general issue with promisor remotes,
though I don't know enough about how they work to know where to start
investigation. I've got what I believe to be minimal reproduction steps
below.

Tao Klerks <tao@klerks.biz> writes:
> On Wed, Feb 22, 2023 at 4:45=E2=80=AFPM Sean Allred <allred.sean@gmail.co=
m> wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > It's hard to know for certain what's going on here, but it depends on
>> > your history.  You did a partial clone with no trees, so you've likely
>> > received a single commit object and no trees or blobs.
>>
>> Yup, this was the intention behind `--depth=3D1 --filter=3Dtree:0`. The
>> server doing this ref update needs to be faster than having the full
>> history would allow.
>>
>
> FWIW, you're not alone - we do exactly the same thing, for the same
> reasons, and get the same outcome: We want to create a tag in a CI
> job, that particular CI job has no reason to check out the code, all
> we know is we want ref XXXXX to point to commit YYYYY.
>
> [...]
>
> In our case it's still better than any alternative we've found, but
> wastes a few seconds that we'd love to see optimized away.

Unfortunately in our case, 'a few seconds' is tens of minutes (I'm
working with a repository of several million commits) and is timing out
the remote host.

----

I devised some minimal steps to reproduce what I believe to be a related
issue: rev-list fetching content. I've prepared a public repository on
github.com to demonstrate, but you should be able to recreate this
repository if needed by just making a handful of commits to a couple
arbitrary files.

    (cwd:tmp)
    $ git clone --no-checkout --depth=3D1 --no-tags --filter=3Dtree:0 https=
://github.com/vermiculus/testibus.git
    Cloning into 'testibus'...
    remote: Enumerating objects: 1, done.
    remote: Counting objects: 100% (1/1), done.
    remote: Total 1 (delta 0), reused 1 (delta 0), pack-reused 0
    Receiving objects: 100% (1/1), done.

Sweet, I've only received one object from the remote. This makes sense
per what I want: a treeless, blobless, fetch of a single commit. Let's
double-check.

    (cwd:testibus)
    $ git fsck
    Checking object directories: 100% (256/256), done.
    Checking objects: 100% (2/2), done.

I have two objects? How'd that second one get in there? What is it?
Let's try to find out...

    (cwd:testibus)
    $ git rev-list --objects --all
    d86642e7ae089b69e8a0b20a3e39337435833f92

Alright, I've got the commit object. That makes sense.

    c0fa909c5f67047abc027d9b06e1352954ee33f7

Weird, I also got the tree on the commit, even though I specified that
this should be a treeless clone.

    remote: Enumerating objects: 1, done.
    remote: Counting objects: 100% (1/1), done.
    remote: Total 1 (delta 0), reused 1 (delta 0), pack-reused 0
    Receiving objects: 100% (1/1), 54 bytes | 54.00 KiB/s, done.
    94b334d80405218e281a6f5b48d31f73cd3af4be file

Woah woah! All I did was rev-list; why are we fetching content?

This is why I believe this is related to the push issue I'm ultimately
facing -- I'm not familiar with the specifics, but it stands to reason
that git-push needs to (somehow) iterate through objects in order to
negotiate a packfile with the remote. I suspect these two issues have
the same root cause.

I believe the following can be used with git-bisect to determine if this
truly ever worked or is a regression:

    setup:
        #!/bin/bash

        repo=3D"https://github.com/vermiculus/testibus.git"
        repo_dir=3D"~/path/to/repo"

        git clone --no-checkout --depth=3D1 --no-tags --filter=3Dtree:0 "$r=
epo" "$repo_dir"
        git -C "$repo_dir" remote set-url origin unreachable

    bisect script:
        git -C "$repo_dir" rev-list --objects --all

        (obviously using the just-built git)

I'm going to start running this bisect, but I suspect it will take a
while, so I wanted to get this out there.

--
Sean Allred
