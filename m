Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64518C433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4521761390
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 14:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhJTOHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhJTOHf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 10:07:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7583BC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:05:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w19so26543829edd.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KO0f7apRtEpvb6dYHlVenUQ+4rqB1dwnme7MBe1Yd/M=;
        b=SHckiN2m39lmiEfkOIQFwod9mci9EqhsytCFaCqJVTDDXv3Mn9qFhMYiCncJlKNFLg
         TqI+Bj4n56/6AlDDvCLKgZES2YRrZvA8FAmqsJsxknFMiEw6e46hMBsdlkDgDun7cL6a
         J2XVeYpTEgXQdrCu1AXVphtNPy66C6m9COFjc5kelWevtORsV9eEgDcEgSvIAOMZtazx
         0dqyXdSaFBF0dLv+HnuUJlzYF+FmDIntRngTbJEdli1WmKPcrbXh1X9KTJHEJbV5OI/g
         tiyPKklroVx3Rdngt8xfk7ZF1CfZuF+jBHlygIIcpz0rNB0Un15n2GhvS2cKkD1SXbak
         Qk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KO0f7apRtEpvb6dYHlVenUQ+4rqB1dwnme7MBe1Yd/M=;
        b=U99IREmyoZLIoCZVT/4YGBNFDFPfz8W//BzE/VCNInigL5evFTKnE19D9T0Nevn07Z
         9fOaor7uokbuXmnV0bSv0VvAD92/WuSbpJfqmGEnaklJSyNSGl6VQEtFkCLMOesdP3EJ
         URehleNYDjsrIlcsmS6duQG+6ZgprT6FloWNuy8V7I29wmcT1BxmnJI7Sa7C4qD7zlBk
         b5vxYNfFMRNQIsIHYL8pAEw2nLiPabotD/uhJqa7wFCfnb0p5FqyGbrVIz245TW7AlgV
         QJmpycswVjXdCBE7Fa7zfb7RfVUXwlSSrGHHg/fetpzzHYD0bB+VMo2OX0WzrveUk1sq
         u0nA==
X-Gm-Message-State: AOAM530qycpmYQP/O83eYlUYHvK5AvNwxBvouIUnUpRLahZmlnRFiRKo
        9Cf4fbYmPVky2D/Uww2g1Prme3VLLZ1WfA==
X-Google-Smtp-Source: ABdhPJwz1wjdlbv/O/UIIF0E4Gz48Rytb5RAW2CfXT9barNRfNS+OHz8XvzIfKICP1JzYv/38iSAgA==
X-Received: by 2002:aa7:cd53:: with SMTP id v19mr294080edw.8.1634738581762;
        Wed, 20 Oct 2021 07:03:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o21sm1111818edc.60.2021.10.20.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:03:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdCBH-000jV4-Hi;
        Wed, 20 Oct 2021 16:02:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Oct 2021, #05;
 Mon, 18)
Date:   Wed, 20 Oct 2021 15:42:20 +0200
References: <xmqq1r4hv7bv.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <nycvar.QRO.7.76.6.2110191436250.56@tvgsbejvaqbjf.bet>
Message-ID: <211020.86zgr3n698.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 19 2021, Johannes Schindelin wrote:

> On Mon, 18 Oct 2021, Junio C Hamano wrote:
>
>> * js/scalar (2021-10-07) 15 commits
>>  - scalar: accept -C and -c options before the subcommand
>>  - scalar: implement the `version` command
>>  - scalar: implement the `delete` command
>>  - scalar: teach 'reconfigure' to optionally handle all registered enlistments
>>  - scalar: allow reconfiguring an existing enlistment
>>  - scalar: implement the `run` command
>>  - scalar: teach 'clone' to support the --single-branch option
>>  - scalar: implement the `clone` subcommand
>>  - scalar: implement 'scalar list'
>>  - scalar: let 'unregister' handle a deleted enlistment directory gracefully
>>  - scalar: 'unregister' stops background maintenance
>>  - scalar: 'register' sets recommended config and starts maintenance
>>  - scalar: create test infrastructure
>>  - scalar: start documenting the command
>>  - scalar: create a rudimentary executable
>>
>>  Add pieces from "scalar" to contrib/.
>>
>>  What's the status of this thing?
>
> As far as I am concerned, the current status is: We agreed that this thing
> _can_ live in contrib/, and that the `scalar` command itself should not be
> integrated deeply into Git because the end game is for `git clone` (and
> maybe `git maintenance`) to learn Scalar's tricks.
>
> A concern was raised that `make -C contrib/scalar` does not rebuild
> `libgit.a` whenever any of `libgit.a`'s source files were modified. In
> light of the previous paragraph, I believe that my time would be better
> spent on designing a new `git clone` option, though, than to spend time on
> a build process that will be soon obsolete (except if I allow myself to be
> distracted by things like teaching `make -C contrib/scalar` to know about
> `libgit.a`'s prerequisites). In other words, it is a technical debt I
> firmly believe is worth accruing.
>
> Other than that, I heard no objections, therefore I believe that this is
> ready for `next`, to be cooked in the v2.34 cycle.

Your patches as they stand don't implement a "make install{-doc,-man}"
for the new command. I have a WIP patch on top to make that and various
other things that are broken about it work as summarized in[1].

I'm happy to help you make that work, but I don't think framing it as
some abstract objection about whether something lives in contrib or not
is accurate.

I'v said that I don't care how things live in-tree in the abstract, but
as a practical matter much of our build process is entangled with what
lives at which paths. That issue with having an incomplete libgit.a
dependency graph is just the tip of the iceberg.

For example in your just-sent[2] you say:

    I would like to add a plug for Scalar here. Maybe we can link to this
    "opinionated tool based on Git" here? I wouldn't ask if I didn't _know_
    that it helps monorepo users out there.

I agree that would be useful, but currently our documentation build
would fail if you linked to the scalar from other git documentation.
Since we lint it and check if the linkgit:* crosslinks would be 404'd.

That's aside from the issue of there being no installation targets in
your version of the Makefile integration, so even if you get that past
the "lint" the installed docs wouldn't have a scalar documentation
installed on the system.

Of course all of those issue are fixable if your version of the patches
were to land, as are other issues like your new *.c file implicitly not
being covered by the coccicheck target.

I don't see why wouldn't consider an up-front solution to that technical
debt, or why you're seemingly ignoring comments about aspects of your
patches that are broken or will cause that unnecessary technical debt.

It would be a hassle to deal with when it comes to various build-system
integration we already have, or which I have WIP work to implement. I'm
also offering to fix it for you, so it wouldn't be much of a distraction
to your efforts.

1. https://lore.kernel.org/git/87fstdgh8m.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110201349570.56@tvgsbejvaqbjf.bet/
