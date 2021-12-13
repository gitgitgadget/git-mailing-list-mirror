Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE011C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhLMTgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhLMTgY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:36:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777EC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:36:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so56549943edu.4
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wsZpq+m8ilbfxVw6eOHY214rMhszLLYgtTMG8MMmEDo=;
        b=JmlIOUEJKRu2xireQTA8SDWrW1TQAMYlgYv7501ULuIiZPcpumhRPP6RcWPI5cR54F
         emO/dV653/QkrfY0qJbcWCC4exWVgi9rx9+jCUyTBEEkTUVE2mln1UhmPDBNrqep1kwz
         8LK4eLE02Fh4mMBsQLAPBCLOWdxIcH0VIWT5j7exriGO29ROmVqDVLV4tCiFXnMOhBau
         niJ3wCj513tUu6u+s8Krzu2AEHtwev5rjObmprIpLjL2bmNWdTHYcxLEMd8N1m7yV1yp
         KU737I/ycfLQGjyFbN1PfYPpsaC4O0hxBzAoVGZf6aj1Jxx360n7huNbq1bMy8D0NwhH
         jEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wsZpq+m8ilbfxVw6eOHY214rMhszLLYgtTMG8MMmEDo=;
        b=oO6oJuofYeZUfGlyG08Xmj1s+Tc5C/aI9Y60sIC/84jZ6HI4BEN8HBtvFsTYqG3d3u
         AxEidOU+J+zEuMw3x0mQyNXrWZAjR8+0fpECMEt0EPiiQXXQHw9kSd/KELbLfdSWm5UY
         cPaajtGwEDBXP9e+SQJHJj9edGm8QDcf7gngJb1tJOOfN6Lt1HJG8ylmzLkSmV3CgFIt
         fc8IfOK5x4KNQughQiitBuQTzaK3u0BDlr8axLUb4+b1rlh/2Ff8TRTA5Tsfzy0FZeD/
         bFVShpiyu2dX+LxFui/Ho1MkokRp9heszmHjfoIHkXfOkOamAj7MPCh7fP6ybdavU5xy
         hDOQ==
X-Gm-Message-State: AOAM531XA4BSUp4sOXvKFvCNRvTgah2/+07Ucdj/SqFyQxDoF48vJ0ms
        Yl6YPLDKNe4mudTMdnNUePI=
X-Google-Smtp-Source: ABdhPJys5RrqIOCHTTuyCPHbpRiPStmjbxnScSGGXLsLxt67YcyGnjL9bM4sc1Z53FFxcaySqwVJWA==
X-Received: by 2002:a17:906:2a48:: with SMTP id k8mr394631eje.758.1639424182311;
        Mon, 13 Dec 2021 11:36:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p4sm463375ejn.130.2021.12.13.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:36:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwr7V-000vV7-7E;
        Mon, 13 Dec 2021 20:36:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Date:   Mon, 13 Dec 2021 20:33:36 +0100
References: <20211213063059.19424-1-sunshine@sunshineco.com>
        <20211213063059.19424-6-sunshine@sunshineco.com>
        <20211213102224.y5psbojmivlxe5px@fs>
        <CAPig+cSKn6wdPKc=b8Xjqy5D=bVdu6FQtYKJuwN2VoV7pEEgHw@mail.gmail.com>
        <20211213154327.pmhopjbdlkz7dgjh@fs>
        <CAPig+cSXHBMgOUycL0cXuVCb_PJ2=x2w4wUkc7eQQueyk=0Uzw@mail.gmail.com>
        <211213.86tufc8oop.gmgdl@evledraar.gmail.com>
        <CAPig+cR5Q2q=wdXuVBeP52=pAfvh6_4z__g-0JUGWq_7uor_Hg@mail.gmail.com>
        <CAPig+cRkC=-dV_i1LJg3kZVVpR778YNyhpO6maHnH5zFH9zS6w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cRkC=-dV_i1LJg3kZVVpR778YNyhpO6maHnH5zFH9zS6w@mail.gmail.com>
Message-ID: <211213.86zgp470wa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Eric Sunshine wrote:

> On Mon, Dec 13, 2021 at 12:05 PM Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>> On Mon, Dec 13, 2021 at 11:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > The reason I looked at this to begin with is that it takes it ~100-150=
ms
>> > to run now, which adds up if you're e.g. using "make test T=3D<glob>" =
in
>> > "git rebase -i --exec".
>>
>> Regarding this last point, one idea I strongly considered (and have
>> not rejected) is to stop making `check-chainlin` a dependency of
>> `test` and `prove`. [...]
>
> Another less sledge-hammer approach would be to make t/Makefile
> respect GIT_TEST_CHAIN_LINT so that it doesn't run `check-chainlint`
> for `test` and `prove` when that variable is `0`. That would allow
> your `git rebase -i --exec` case to avoid the wasted extra overhead of
> `check-chainlint` (and chainlint in general).

Yes, but I just don't see why it's needed.

We need to build e.g. t/helpers/ to run the tests, and doing that is
probably always going to take eons of compilation times compared to
these assertions.

But it's a one-off eon because we declare the dependency DAG and don't
recompile them unless the sources or their dependencies change. Likewise
for these chainlint tests we can (and maybe should) make them optional,
but as long as we're not needlessly running them when no changes have
happened...

