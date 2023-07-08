Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D8EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 08:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGHIvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHIvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 04:51:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ACF123
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 01:51:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570540d9777so2840587b3.1
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 01:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688806300; x=1691398300;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=GAGKkV3PdAJL83q6SWTDajpfI17piqy+dPgD6lNuEfQ=;
        b=e90aKa7HxkHP7/TzH46Xdil1yzVbiT4WgtVMiX8GW8NweGJNO+3xIun/6KvJsLR6Kt
         VzWWUdcBFSwnfeurwVTc6AWeqV7qIDQiyCkQZ0whFEIpPsa8P5hMUES7DxzdSZRJ0qio
         vm7RmdcjxMqtGXpSTet9vo+kph6WwZjiEvlEosiFCOPh4mXmGnGFbBuBInfGDp0IcJeW
         zrZfJcO0SXvqaIEpQuElIt/ZPr9skV4+HMnGokDp9BuSN4pEXtDoqAEy+Rt4dYQh13bS
         h75wBo/0PDAGg8ZDe+CPPLo1VJGJDa+x178zxR8jG0/qJZLDhwNE8l7U6smVOFrVL5aH
         Yhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688806300; x=1691398300;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAGKkV3PdAJL83q6SWTDajpfI17piqy+dPgD6lNuEfQ=;
        b=NIci7xTXcf//HYbS/LSSHVl5mfu4WKZ8EasbUeWCCOwpIhvrFyqcrkYjDXJcWyOpqK
         FQa+0kK9w9WehvdXli1D8ZfntSd9MK2soZEm6IQatC3KZLTu2cFHxJ6hb9G633ZJPOJX
         p+IqdTab6jgfBGW172w3aFdXdSOlk60KUqtsmvB/G+MghFhCbc4cArr4YbTB54QrPFYb
         dlmpgishK99onkJBRQp+XqP78rIiJlrpl1gvpGA+7bcFmRMFuxeA/9D1orJeoWN1GhEz
         b7ZZGGhBk6ZBeOTWq0xnHmMykiWlijbuQAmulPP0Lj8IkSzlz/bP+BQ8pze5SxzUYEXp
         po8A==
X-Gm-Message-State: ABy/qLaNCRL3/N+sOvLPmDwZumS6QgPM+nqJ8Jo/AHfoj7DUkmLmQUaa
        FjaIDSXysfu9aTE8igjCdG3vS0W3cvY=
X-Google-Smtp-Source: APBJJlGZ7LC8zSyCC5LL+tntMNdfiXKmnDly5AexS2Bl2foBl1m2/d0mFDsEpcV0JlX0bO3Pvog8DQ==
X-Received: by 2002:a25:fa12:0:b0:c4d:7a05:8db5 with SMTP id b18-20020a25fa12000000b00c4d7a058db5mr3103770ybe.5.1688806300374;
        Sat, 08 Jul 2023 01:51:40 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::12])
        by smtp.gmail.com with ESMTPSA id f3-20020a25b083000000b00c6051b16f8bsm1496834ybj.8.2023.07.08.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 01:51:40 -0700 (PDT)
References: <m0ttze4qzl.fsf@epic96565.epic.com>
 <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
 <m0pma14sbx.fsf@epic96565.epic.com>
 <CAPMMpoiC8oca0AVNy1f+zy26L_b-ADyNopY4zO3r+v6v-KEH=A@mail.gmail.com>
 <m0zg46eueb.fsf@epic96565.epic.com>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
Date:   Sat, 08 Jul 2023 03:39:19 -0500
In-reply-to: <m0zg46eueb.fsf@epic96565.epic.com>
Message-ID: <m0pm52eqg5.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Following up with the results of my bisect (more discussion below). I'm
forced to conclude this may somehow have never worked as I'm expecting
(even though I do recall it working well in a long-gone environment),
but I'm very much hoping I just did the bisect incorrectly. (It's not a
feature I need to use much.)

So, is this a bug or is this working as intended for a good reason?

Sean Allred <allred.sean@gmail.com> writes:
> Thanks for the replies. I'd like to bump this up again. This has come up
> in a new context and I don't see a viable workaround for us that doesn't
> involve a rewrite of the process and an excessive amount of new
> infrastructure.
>
> I have a feeling this is somehow a general issue with promisor remotes,
> though I don't know enough about how they work to know where to start
> investigation. I've got what I believe to be minimal reproduction steps
> below.
>
> [...]
>
> I believe the following can be used with git-bisect to determine if this
> truly ever worked or is a regression:
>
>     setup:
>         #!/bin/bash
>
>         repo="https://github.com/vermiculus/testibus.git"
>         repo_dir="~/path/to/repo"
>
>         git clone --no-checkout --depth=1 --no-tags --filter=tree:0 "$repo" "$repo_dir"
>         git -C "$repo_dir" remote set-url origin unreachable
>
>     bisect script:
>         git -C "$repo_dir" rev-list --objects --all
>
>         (obviously using the just-built git)
>
> I'm going to start running this bisect, but I suspect it will take a
> while, so I wanted to get this out there.

I ended up using a bisect script that looks like this

    #!/bin/bash
    make clean
    NO_GETTEXT=1 make -j8 || exit 125
    ./bin-wrappers/git -C "$1" rev-list --objects --all || exit 1
    git rev-parse HEAD >> ../good-commits

and running

    git bisect start main 637fc4467e57872008171958eda0428818a7ee03
    git bisect run ../bisect-script.sh ~/tmp/testibus/

It took less time than I thought, but unfortunately I was never able to
actually find a 'good' commit. I arbitrarily chose "partial-clone:
design doc" (Jeff Hostetler, Dec 14 2017) as the first commit to the
partial-clone design document (under the assumption that it worked at
some point). If potentially lying to git-bisect in this way is
especially liable to bust it, I can start the exponentially-more-
expensive process of testing every commit along --first-parent, but I
suspect this may have never worked as I'm expecting.

--
Sean Allred
