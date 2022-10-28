Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FFDFA373D
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 03:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiJ1DKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbiJ1DKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 23:10:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2837843AD9
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:10:38 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q9so10075271ejd.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 20:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9xUJz2gQEX6ALx968W2OPRxI85HHE+9b1vnAPWphD9k=;
        b=oUsa6bz8ZNEy+2JW/Mvxd2XGRAmngiC64+vOKxn79YcpQ1bvCuGe3UXtCs0McWxG9Z
         Ow6/i7srox8C4jaFEkOGtq0hTgWGaALJmqwAEg8ymro7CJb8OkXiT3o3oTaRBI58CWex
         kWA+K/H1RFFuCEoeHIaPsFb30TyDaakQB3URyOEu269UV3lbOB5+45TWQ2Oy85Kr2DGN
         7M9cpSTPyEL/41K2pi11KplEIJGxJN3rzfoCl2DVGXJlhRITL/9ktf0ohPC/7w/ojr3L
         wwIfYxnvYOuu8XMy2yZT3YX9KW5xnSfwwZQzmwgE6/01gNNb3vC53Uhnbo6bJKKIAbbN
         iUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xUJz2gQEX6ALx968W2OPRxI85HHE+9b1vnAPWphD9k=;
        b=xAK6paz7HzlYbPNQSS524KhvUF7VJqneDz9rM6e1uSPfGz2Qovl+NuX7JVnnndq4o+
         P6lsuc2nR6Fv9bOKoKT3VT6+xn8uLmXFBCD2shNSD8a79lnDVS1F3r2g8unCl1M+iiK5
         ilNoEqqXzfngDkSozpqIm6gRiqJezKQx8BXGL792KwnGrjcmdHo1YDS8HR8MMDVhZymR
         k02zFxaC/rER+hLN3XWRRpKDYbk4R7zTFWikJkYVjsK0Isle8v+4xk16dfuAlClVOZEB
         lOkaxDWxuS1rm+bamjt/YaMAi55yiVP9UWCUJs+WXSHwnObTjK19rQZGU+hcgFCAkY0J
         cY/w==
X-Gm-Message-State: ACrzQf3nCMBlQY55pUqvsMw5C/v5XV3FdkbnG2mXw0fqDIS/NrIIzVzN
        0z/6WMxui8/nsmCgd3vbe/Q=
X-Google-Smtp-Source: AMsMyM7Pg9g/P3zd1qdXn15lDJHnehVDza1AEgRFQpE2aNuCMw6yzGkt2zuGM0gFwA06bnCAZy7Tlw==
X-Received: by 2002:a17:907:6e09:b0:78d:a326:49c6 with SMTP id sd9-20020a1709076e0900b0078da32649c6mr44357826ejc.507.1666926636559;
        Thu, 27 Oct 2022 20:10:36 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sg38-20020a170907a42600b0073d7ab84375sm1660084ejc.92.2022.10.27.20.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 20:10:35 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooFlT-009lGI-0E;
        Fri, 28 Oct 2022 05:10:35 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] Makefile: fix issues with bin-wrappers/% rule
Date:   Fri, 28 Oct 2022 05:03:33 +0200
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
 <Y1so+kU1sZqYAS4y@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y1so+kU1sZqYAS4y@coredump.intra.peff.net>
Message-ID: <221028.86o7tw8wyd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Jeff King wrote:

> On Wed, Oct 26, 2022 at 04:42:34PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This simple topic fixes issues with the bin-wrappers/% rules, as seen
>> in the range-diff below this never worked properly:
>>=20
>> 	make bin-wrappers/git
>>=20
>> I.e. we'd make the scirpt, but not "git".
>
> Maybe I'm missing something, but the current behavior is what I'd expect
> to happen. Sure, bin-wrappers/git depends on "git" at run-time if you
> want it to do something useful. But AFAIK it doesn't at build-time. Why
> do we want a build-time dependency?  Are we expecting rules to depend on
> bin-wrappers/foo but not also on foo? Or people to ask manually for
> those targets?

I didn't have an immediate practical reason for it beyond just not
leaving holes in the dependency DAG.

But yes, nothing is only building bin-wrappers/% now, so nothing needs
this. It just helps to not have to worry about Makefile targets not
needing other targets to work.

> This kind of feels like making git-repack depend on git-pack-objects.
> One will call the other at run-time, but there's no reason the builds
> have to be together. And if you try to build and run one without
> building the other, well...if it hurts, don't do it.

Or wget depending on your router being plugged in? Beacuse that's what
you use it for?:)

I get the general point, but I don't think these are comparable to those
sorts of loose or semi-loose dependencies. For repack it'll service up
e.g. "-h" without pack-objects, at least that's something...

Whereas these scripts all end with invoking the binary corresponding to
their name, so they really are useless without that target. So I think
it makes sense to make it a dependency of the target in the Makefile.
