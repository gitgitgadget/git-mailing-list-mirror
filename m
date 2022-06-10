Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545AAC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 17:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiFJRfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349630AbiFJRfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 13:35:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314120F47
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:35:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m20so54698012ejj.10
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=N+ikygJ/256n84UnJ7Ib6rGK++qch6Ql/DcSd5CHR6U=;
        b=PZ+Y5H47B2yEiNQFKnu0U5wsdgBJz1E6DQEbuD3Q22A3kIsbQMmIZ/uu3JPoWDjl6W
         L5rEC12/XLPyyf+aXdc0+d0kMfpIf4+BpDhfe8DnpvA9Afj14eH5Dv0b+tLitQGmoAek
         ZhegfYrCMjJczcTer1oMNdkMS2fYKxdr2RRb8lIkZxo9wKTkhOuMlWYa5jw+tDl2loDR
         L5LD77kNrqkzI1If2FKG4bMha5jXCp3aD5hOFuDyrnazeaEshGOb+mpUkbC8qNh7NESJ
         kxTYpX+3rJdjelHKnLoI3EliN5urRu21AvdaK4u7pGfD8IcNnXhP25M0XByu/qp1ILnE
         n2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=N+ikygJ/256n84UnJ7Ib6rGK++qch6Ql/DcSd5CHR6U=;
        b=Dgkg2l7V/gODdsP4s9FBbcIiNbDeHtkmzb1wq2ffZIOiLt2BwfdhhC2234j8l897L9
         jKz/mq7Vm6kPdGZE6WsK0ULy8XMk/50w2ttuIT2pdgIX+RKScIr18jNMzJVdtTOzkUcD
         NNrSiDEZV440+yeCzpCl1LbtGECorJt4Iug1DJYriDyVs3/uO71HhkDTb4IcK0dECgcG
         u5mFRKiYRtdmRrx5PLM0qiaUmFeQGuhB+LZDyKDMCq6QeJ5a3awyT1V9U6KvpWi1jIVx
         qQz/mZmQsv3iTxWqk/obYd1i3+XSCiCulm6AUmBl292qrDbegwTLj6Ea8kkk39TpnFjb
         bVkQ==
X-Gm-Message-State: AOAM531NENYF4S0Q8x3Nqb8XYNJT0o7tl/+V5EWA+KTvOAQ9wB0hH5Xo
        1ijGtiq95CQWXrgtt9I1jaI=
X-Google-Smtp-Source: ABdhPJyneVlWdAeR4woXq7mTRARnE0p869Qxao48jngD7tXa/lfaRHuY8TOM4iHwXYYQu0vZaXlLAw==
X-Received: by 2002:a17:907:f9c:b0:711:734d:a9a2 with SMTP id kb28-20020a1709070f9c00b00711734da9a2mr28335930ejc.690.1654882504451;
        Fri, 10 Jun 2022 10:35:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090636c600b006feb6dee4absm12492748ejc.137.2022.06.10.10.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:35:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nziXH-003bLd-As;
        Fri, 10 Jun 2022 19:35:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(github): bring back the 'print test failures' step
Date:   Fri, 10 Jun 2022 19:32:07 +0200
References: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
 <220609.868rq6t0la.gmgdl@evledraar.gmail.com> <xmqqtu8sfp52.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqtu8sfp52.fsf@gitster.g>
Message-ID: <220610.86edzws9q0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 10 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> When ci/print-test-failures.sh was last in this file before 08dccc8fc1f
>> (ci: make it easier to find failed tests' logs in the GitHub workflow,
>> 2022-05-21) there was no "name" field, that's an unrelated change that
>> shouldn't be part of a narrow regression fix.
>>
>>> +      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>>
>> We likewise just had "if failure()" then, is the distinction different
>> in all these cases?
>>
>>> +      shell: bash
>>
>> ...and you've made every single one of them run with "bash" instead of
>> the default shell, which is another "change while at it" that isn't
>> discussed.
>
> If it is so important to support all the other shells in the GitHub
> workflows environment, we can discuss fix-up patches on top or
> replacement patches, but does that really matter?  If this were main
> Makefile or ci/*.sh that are supposed to be usable by places other
> than GitHub Actions environment we use for the CI there, of course
> it would be worth to try being extra portable, but it may be even
> beneficial to "fix" .github/workflows/* stuff, so that we won't have
> to be affected by mistaken use of non-portable shell construct
> written there, perhaps?

It just looks like a mistake. The Windows sections need an explicit
"bash" shell, but nothing else does, and the Windows sections had
explicit names for somes stuff, but the other ones did not.

So I think thas was just a case of copy/pasting the first section(s)
rather than bringing back the pre-image. I think just bringing back the
old behavior makes sense for a regression fix in a re-roll.

Aside from that I think it's very useful to not rely on bash, for future
directions of being able to use this tooling more portably, c.f. what I
did in my series where you can run "like CI" locally, which I'd like to
do on Solaris, AIX & whatever else without it being a portability
hassle.

