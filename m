Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9759C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKASke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKASk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 14:40:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC491BEA9
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 11:40:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z18so18043442edb.9
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O0XIdABFbu0MgBTcMSGtB3geuFZhllh8GjdXA6qtmVc=;
        b=BQU60Bu1atLIebqbnMVnX9S1gee/sXH/YvNz3F3iR0zjOIfEE+qNlCmeA5YlxpFQqI
         SonotFhPPpmWPyjuRllejHS/oW2DxQI07AJJNvey/gfgKx53KiXhUN5voYmXqjTHVGFV
         eq2z+xoAM1LOGMeAyCG9G/HPIpgfFnSbbjl/ql6LIy+98iqWASQgRuct3vk63raaJ6hL
         XlEeeQQ+T4x17SmkduRT3sk6r4cFWFQ24Cev3HrZkkQ+GZhhvGWpr6XLE1AwbYODEuUy
         WRFDMbhYoGM5D9NMM11rzQJfCilvkX+jZIV0kPzRq0K2CDh5TBoUM55HFNG3vazz3F3X
         +/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0XIdABFbu0MgBTcMSGtB3geuFZhllh8GjdXA6qtmVc=;
        b=WgXTIMPULxC2UCqpBW3tQXd46ywBThbVt66RVjlSo7wfCoSWng/QlV1nFFw+YaACHa
         RI5hk+1cSjX7GaPOKmEh8GKgcUZDZtvYeEtErM29MyfV1A0kiHDzkIPmn/0ACh6X5El6
         u6d8z30uyAGClb7Iju+0/DD0RV6Bdik5qlZx3siwrpR7rIzE6W5W0mGJfurhWvuqzxsl
         qyaBHcbPUkk7KNboEQlWUqBwGeP5U+RNbvxsLnEfF/iwZtTQCtdXiborQulApOmz99UR
         mzNMwIA5DkurUDlXLKHRH85Z1llKmdsLUQ86r0wiBJun7/2oulH2cEEA12idHRZ3hcun
         MBSA==
X-Gm-Message-State: ACrzQf2QOhiTsAT8av5KbEJPoFKll8ijw98pJ+fv6IjvRrcakfpyXhJB
        SUQEbuZhrGz3goYKbrYjm9M=
X-Google-Smtp-Source: AMsMyM7zskQ/mFNJCqoCs2XuFITapRD3SxVndfm56R/P/F0dSTgBfkV2aVcDDn429V273/Qi22O3uA==
X-Received: by 2002:aa7:d797:0:b0:462:1e07:1dd7 with SMTP id s23-20020aa7d797000000b004621e071dd7mr169883edq.293.1667328026229;
        Tue, 01 Nov 2022 11:40:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id gy8-20020a170906f24800b007317f017e64sm4460139ejb.134.2022.11.01.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 11:40:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opwBV-00BTt1-11;
        Tue, 01 Nov 2022 19:40:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mark Hills <mark@xwax.org>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: Consist timestamps within a checkout/clone
Date:   Tue, 01 Nov 2022 19:34:14 +0100
References: <2210311614160.25661@stax.localdomain>
        <221031.86zgdb68p3.gmgdl@evledraar.gmail.com>
        <Y2Ax5XOgSOOcgo8J@nand.local>
        <d4db484f-a525-f6db-1bfb-922f788dacd@xwax.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d4db484f-a525-f6db-1bfb-922f788dacd@xwax.org>
Message-ID: <221101.867d0e4ixy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Mark Hills wrote:

> On Mon, 31 Oct 2022, Taylor Blau wrote:
>
>> On Mon, Oct 31, 2022 at 09:21:20PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> > I think you're almost certainly running into the parallel checkout,
>> > which is new in that revision range. Try tweaking checkout.workers and
>> > checkout.thresholdForParallelism (see "man git-config").
>> >
>> > I can't say without looking at the code/Makefile (and even then, I don=
't
>> > have time to dig here:), but if I had to bet I'd say that your
>> > dependencies have probably always been broken with these checked-in
>> > files, but they happend to work out if they were checked out in sorted
>> > order.
>> >
>> > And now with the parallel checkout they're not guaranteed to do that, =
as
>> > some workers will "race ahead" and finish in an unpredictable order.
>>=20
>> Doesn't checkout.thresholdForParallelism only matter when
>> checkout.workers !=3D 1?
>>=20
>> So what you wrote seems like a reasonable explanation, but only if the
>> original reporter set checkout.workers to imply the non-sequential
>> behavior in the first place.
>>=20
>> That said...
>>=20
>>   - I also don't know off-hand of a place where we've defined the order
>>     where Git will checkout files in the working copy. So depending on
>>     that behavior isn't a safe thing to do.
>>=20
>>   - Committing build artifacts into your repository is generally
>>     discouraged.
>
> If it's undefined and never implemented this is reasonable.
>
> But "generally" is a caveat, so while I agree with the statement it also=
=20
> implies there's valid cases outside of that. Ones which used to work, too.
>
> Here are some useful cases I have seen for the combination of build rule =
+=20
> checked in file:
>
> - part of a build requires licensed software that's not always available
>
> - part of the build requires large memory that other builders generally d=
o=20
>   not have available
>
> - part of the build process uses a different platform or some other syste=
m=20
>   requirement
>
> - to fetch data eg. from a URL, with a record of the URL/automation but=20
>   also a copy of the file as a record and for offline use
>
> So it's useful, to retain repeatable automation but not always build from=
=20
> square one.
>
> Generally discouraged to check in build results yes, but I've found it=20
> very practical.
>=20=20
>> So while I'd guess that setting `checkout.workers` back to "1" (if it=20
>> wasn't already) will probably restore the existing behavior, counting on=
=20
>> that behavior in the first place is wrong.
>
> I think perhaps the tail is wagging the dog here, though.
>
> It's 'wrong' because it doesn't work; but I haven't seen anything to make=
=20
> me think this is fundamentally or theoretically flawed.
>
> If we had a transactional file system we'd reasonably expect a checkout t=
o=20
> be an atomic operation -- same timestamp on the files created in that=20
> step. A discrepancy in timestamps would be considered incorrect; it would=
=20
> imply an 'order' to the checkout which, as you say, is order-less.
>
> Sowhat could be the bad outcomes if Git created files stamped with the=20
> point in time of the "git checkout"?

I agree that it's practical in some scenarios, including checking in
built assets.

But those that are doing that need to be aware that combining that sort
of thing with source control tends to upend your build system's idea of
the world.

E.g. until recently in git.git we had a po/git.pot in-tree, which is a
"compiled file" (although a plain-text one) that was checked in, and
dealing with that in make's dependency graph was a (minor) pain
sometimes.
