Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD63EC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A184864E79
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 12:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhBKMHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 07:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhBKMFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 07:05:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C12CC0613D6
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 04:04:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b9so9614216ejy.12
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=As5Gl5u+2CbRQ7twk8ARObFaS3GnfbPo8KckSikGo4Y=;
        b=F0Nna6Bwv966q5VOKn2HWN0oXTfXEuuaw0tEjCi8FqRcsQX5JVv6B1IUV8DPX9s9BV
         eXiEepwKWLEiUPzRv1ztdZaJPsxK9Gp06L76n0L0Y9rCpIDWlde26DA4fry3GU+SpNEP
         e/M5eQ9uvPnsOHlMIbC1cVWRtX6+kJPOEc1q5geaXktH8O4Ls8vTKR48GOCKhE3AbwPA
         5lQBj9sRByUGP7b2hOLEDuPVwtptoXIpN5SC25dcyBI3qhl4eO8BRo6oeDsf9bdUmtXw
         b7pAGEqfcDUP7cMqegOhJgcghJCX7EobsUnoxf/FxstfYE8PbLwR5lXpOmMUgfVRpNCG
         LyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=As5Gl5u+2CbRQ7twk8ARObFaS3GnfbPo8KckSikGo4Y=;
        b=JApXwMt07mOrsKGyMlcjzbAp2Wikij1kXewzjIBAmRW2GbOvYNuLWjEcbxIsWFH0GR
         eIYpmq67iyfdWrSRmVf2vc9syx+tzAOVOIeYrK6aAL0EIdDFLxt3R2Sno0GCXRnA0xkk
         ZVVaOeISAoLqF3N73+9mLEImnNQxGosdFXpgV6QcdCZ8GBC5OO5spY+dJzlXE1oxDNyY
         q0wU0R+BHRYN1xsDoidLd1gDUI9fSCkxetvsNQ4BFtTlCqexyi7Iaak+DxiqCQ727gsa
         S71Yi54D+a1TNiTIOuHZtzLT2n+jt0M7Hcw8YWbYvyCztViItRW2977uU2gy3EIsRLs9
         jqdg==
X-Gm-Message-State: AOAM533cJhU9enhPUJ7ga+8NFz7dlSOx6adGbN3GKfEOoiw4XFhqmgFt
        b1apUmRqYRYY/wESfq7MjwE=
X-Google-Smtp-Source: ABdhPJzICvmCyDO9Taf17lgQaTFXoa5bODJUNbh8fb+yCn1LHuzpHZU/yekc6aoEYeHRO4rRifpL6w==
X-Received: by 2002:a17:906:b047:: with SMTP id bj7mr8226914ejb.335.1613045068879;
        Thu, 11 Feb 2021 04:04:28 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id n16sm4237551ejy.23.2021.02.11.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 04:04:28 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] rev-list --disk-usage
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
 <YCREYmBsnv2wgvXZ@coredump.intra.peff.net> <YCRpBCNJ2yNTbc2i@nand.local>
 <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
Date:   Thu, 11 Feb 2021 13:04:26 +0100
Message-ID: <875z2ydd4l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 11 2021, Jeff King wrote:

> On Wed, Feb 10, 2021 at 06:15:16PM -0500, Taylor Blau wrote:
>
>> > > I kind of feel sad to have a nice write-up like this only in the
>> > > list archive.  Is there a section in our documentation set to keep
>> > > collection of such a real-life use cases?  Perhaps the examples
>> > > section of manpages is the closest thing, but it looks a bit too
>> > > narrowly scoped for the example section of "rev-list" manpage.
>> >
>> > Agreed on both counts. If this gets put into a release, I suspect Taylor
>> > would cover it in a release blog post. That is not quite the same thing
>> > as having it in the documentation, but it may provide more search engine
>> > boost than the list archive. I dunno.
>> 
>> Yeah, this is the perfect sort of thing for those blog posts.
>> 
>> But it makes sense to include some of these examples in our own
>> documentation here, too. git-rev-list(1) doesn't have an EXAMPLES
>> section, but maybe it should.
>
> I think this is the "narrowly scoped" bit from Junio's response above.
> It would be a bit weird to have an examples section for rev-list that
> only mentions this rather obscure feature.

I don't think the lack of an EXAMPLES section or the relative obscurity
of the switch should preclude us from adding useful documentation.

Yes it would feel a bit out of place, but we can always have a
sub-section of EXAMPLES, and we've got to start somewhere.

In this case I don't see why it couldn't be added to OPTIONS, we've got
some very long discussion there already, and as long as there's a clear
separation in prose from an initial brief discussion of the switch and
further prose it won't be confusing for readers, they can just page past
the details.
