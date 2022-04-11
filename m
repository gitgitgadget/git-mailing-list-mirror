Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD429C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349771AbiDKUQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 16:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244663AbiDKUQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 16:16:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60C2C679
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 13:13:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b15so19895475edn.4
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=FrxFfyrhhPRqSU1lMcjwy04JpzcD0HsLYP3ZryZQJTY=;
        b=a4tO+WI9d2N4dnW/XahVCueO/cDSEAKjxh5hiF/qBhPv+gIFYUWBWRIxHCQGTA0QGr
         YF41/zoXAgXl5KSx2LS1VJittT2TqsR26rXfRmMIlQ/3Llr+ETWSFNEhiTtgYNpkqD9a
         bPmscdWD1PnRd4x9UDy+S8Cw5hG3tDu9ljLq2cxSJUNl17chqwxN5sTWjCOxHuZCNMqO
         N16iIlxeC9e0k/iKxr6u5mUky4pz7o/V19r/GbaC/Shseu7qokTjud/dj8HcTlCzsBBy
         qGIMlhj/jKdY8qxhcR+tmWKFVD875Zp7B9lSDsY6lN4aqY9kmnvwFbi7A9yT5S+DcPpY
         Co2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=FrxFfyrhhPRqSU1lMcjwy04JpzcD0HsLYP3ZryZQJTY=;
        b=NQ3uvQdh/QFxbJmhRLwZyv+5XhT1hOWn8ZbaZjPqcTzq5cgah/sfPfELCeVnMgTym3
         jZaZp0ObBqQ8a+T/sNGIIdAupcf3Em220Z79odJFyh7K2E+9muVqEhk4s1KzFTppNMjz
         87MctuIMdhBKQWhYpUojO8mblaGq6DHFtHFreZyuheAIPgYIGCjhIIVR/+K9Xf5nRMxO
         X3BDmfbqgCgknuPOQG8rfFWNSPFlrAMbRHxFwO+traYDRVNMnTDuXWloayxRVg99EeIi
         reC3hSiceeMHPr2mHY3g+gWRqQ1BO1SYwMWycyZNpl3M9ooeMT51kpSqd0T/r3pHiszy
         fb1g==
X-Gm-Message-State: AOAM5313f5k/h8i905ShP0TkAYM6HfQFSYJ4uR1OB3TX436gZ4DwMGzb
        45g9qrPQZlRGgO5prjthQto=
X-Google-Smtp-Source: ABdhPJyBr+2Dl5/XFB5Pmh9+4xGxbmCq3Yo+VRhOUOo3L3h+71OGHprizHV8NXloJshNWQ+aTg9pgA==
X-Received: by 2002:a05:6402:2812:b0:418:fc32:be18 with SMTP id h18-20020a056402281200b00418fc32be18mr35310548ede.357.1649708026864;
        Mon, 11 Apr 2022 13:13:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709062a9a00b006e7ee7ad20bsm9655719eje.149.2022.04.11.13.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:13:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ne0Px-003msS-ET;
        Mon, 11 Apr 2022 22:13:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     tytso <tytso@mit.edu>
Cc:     Tao Klerks <tao@klerks.biz>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
Date:   Mon, 11 Apr 2022 22:10:23 +0200
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
 <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
 <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
 <20220409113244.GX163591@kunlun.suse.cz>
 <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
 <220411.861qy3khkk.gmgdl@evledraar.gmail.com> <YlRyHR5rvG5P/Acr@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YlRyHR5rvG5P/Acr@mit.edu>
Message-ID: <220411.86k0bvidja.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, tytso wrote:

> On Mon, Apr 11, 2022 at 12:19:51PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > and the main argument *against* is "for most
>> > people (non-advanced users), what you do initially is what you end up
>> > pushing, or at least trying to push, and fixing things later is *hard*
>> > - it requires a much deeper understanding of git than most people
>> > otherwise necessarily need to develop".
>>=20
>> Yes, maybe it won't be viable to go in that direction, but re this in my
>> [1]:
>>=20=09
>> 	But I'm also pretty sure that those people are engaged in a proxy war,
>> 	and we should just attack the "problem" directly instead. I.e. it's not
>> 	a problem that some commit somewhere has an empty message, rather it's
>> 	that such a commit gets "propagated". A better place to check for it is
>> 	then at the point of point of propagation.
>
> So possible options we could consider:
>
> 1) Do nothing.  If users want to override the current behavior they
> can just put in their .git/config or ~/.gitconfig file:
>
> [alias]
>    commit =3D commit --allow-empty-message

You cannot use aliases to override built-in commands, so this won't
work.

> 2) Add some kind of explicit git-config option which could then be
> added to their .git/config or ~/.gitconfig:
>
> [commit]
>    allow-empty-description =3D true
>
> 3) Change the default, so that --allow-empty-message is always
> implied, and hope that novices can figure out git rebase -i without
> shooting themselves in the foot.
>
> 4) Enforce git push doesn't push commits with empty commits,
> implemented on the client side.  This could be implemented via a
> pre-push hook script.
>
> 5)  Enforce git push doesn't push commits with empty commits,
> implemented on the server side.This could be implemented via a
> pre-receive hook script.
>
> I will note that only options 2 and 3 require source code changes to
> git.  The rest can effectively be done via config file changes; for
> the hook files, we could provide example scripts to make it easier for
> people to choose that particular option.
>
> And of these options, only one option, #3, requires imposing someone's
> preference (which does appear to be in the minority) on everyone
> else.

We could add configuration or whatever, but the topic of this thread is
whether we should change the *default*. I think it's better to stick to
that.
