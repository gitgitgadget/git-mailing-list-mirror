Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C9C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbiCWO6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiCWO6g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:58:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD0782317
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:57:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z92so2125182ede.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pooP9CMRj9xOqwHbEwjkDQn8qBmQcosFZpwTJ9zFCRA=;
        b=qfES0L29V2NrnmBNUYwWihGEZYIVTkCYhl9NTSAH5zskfEHk9mDEH1nWZUUEE2kPTL
         hiQTD2Ohii8hl0sNLL4KkmdWIa1k+LXus2gaJ1PI8r1X3tn9UtT85tA//nzEkaXs9fB+
         qoBljH3xZsgkXSsCXLaAlQ8Dc2sp7m8d31YHA2b8YbEZpp8r8KToD8vpXu3EBAGc0MXn
         4yCSAGs8Kwq43GJ68+ZnfCO17mTcqL0HvKbhiRWd9/4/NgmRIYNLz0vxFlcurspV98RC
         /ennefxQ2wdoo3UOD0ZBOM3g7mOXCN+uoENGIpns8YgvZIRHL+WLbtbEhfxPi8BuPi0I
         r6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pooP9CMRj9xOqwHbEwjkDQn8qBmQcosFZpwTJ9zFCRA=;
        b=zmicp1UIfKlMeQuBH6pmo/Da/9bEGkSaPkHdMbQ0PaPSR0l69/MDJ7vru5HG7eoeZC
         B5Bus0NOVQNzqRDKZb9zyuZMzhE1mHvo6eEZ9wzqVRuMyeQpGu8XmpF9u0ppvOfOfGkH
         wdZuaJNSc6eMICfp6FS4mID66ysw6JsUXZ+TrAH2pGuxfb9XUgoS/YyxROK3FEIl7shI
         VxxXagTt8ZBC3Jx0mhnYXpWnBTWG7JpvyYDzTe6GeZ9ej+I+a8y12/mvnqryEXWgyi3/
         GfHO3bglekPDJ3eZr2lOZMUSclenkWsFMaHKqMQfbtf6FOmh3bcFjLsrGNxoLSl4zpOn
         VSYQ==
X-Gm-Message-State: AOAM532fcjCAFoFZeCsvLFYJFZdOM62SmUZhbSbJkSkIjAz3pQtEr4OA
        vCAoAqPm6AHoAUc2uyWz90wsqMt2TbLiEA==
X-Google-Smtp-Source: ABdhPJwietAXi6vrg2FKpBkvdhytBsc01I0OGjYs0xlRxwgCNiZeHyAvkTfM0S8hlXM4jOcbUHzXvA==
X-Received: by 2002:a05:6402:3495:b0:419:1ff6:95d9 with SMTP id v21-20020a056402349500b004191ff695d9mr519311edc.249.1648047424665;
        Wed, 23 Mar 2022 07:57:04 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm33028ejo.198.2022.03.23.07.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:57:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nX2Q3-000qqx-LC;
        Wed, 23 Mar 2022 15:57:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How to determine the number of unique recent committers on a
 branch?
Date:   Wed, 23 Mar 2022 15:47:42 +0100
References: <CAHGBnuPavzr_gq0ake6bOQETmHBnU2XOWdDz-UtkBP_+rRdYfA@mail.gmail.com>
 <220323.86o81wonlf.gmgdl@evledraar.gmail.com>
 <CAHGBnuMRKhsF-xCL944KD5GFPWYe-9cSp6FBZfaZ7bdVTkgjng@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CAHGBnuMRKhsF-xCL944KD5GFPWYe-9cSp6FBZfaZ7bdVTkgjng@mail.gmail.com>
Message-ID: <220323.86bkxwogxs.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Sebastian Schuberth wrote:

> On Wed, Mar 23, 2022 at 1:33 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> I think --since to "rev-list" combined with e.g. "shortlog" is what you
>> want here, e.g. on git.git:
>>
>>         $ git -P shortlog --since=3D2.weeks.ago -sn origin/master
>
> But that still interprets "2.weeks.ago" relative to today, right? So,
> for a repo to which no one committed to in the last 2 weeks, it would
> show nothing. But what I'd like to get is the number of committers
> since 2 weeks before the latest commit. Any idea how to get that
> easily?

Ah, sorry. I managed to (mis)read your question.

Perhaps there's a way to do that in one command, but I don't think so,
but I may be wrong.

But you *can* do by grabbing the epoch from the tip commit and doing
some basic shell-math on it:

    git log --since=3D$(($(git log --oneline -1 --date=3Dunix --pretty=3Dfo=
rmat:%ad origin/master) - $((60*60*24*7*2)) )) origin/master

It would be nice if we had some option to to do that, e.g.:

    git log --since=3D2.weeks.ago --date-now=3DFebruary.2018

Or To get you things in late January 2018. Or even:

    git -c core.time=3D"February.2018" log --since=3D2.weeks.ago

To fool the entirety of git to use a given time() as current (but of
course it would also need to "adjust back" commit dates for relative
--since).

I'm 99% sure we don't have that, especially from looking at some of the
code just now. But in the meantime you can hack it as above.
