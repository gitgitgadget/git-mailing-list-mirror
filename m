Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C81EC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 02:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiBSCu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiBSCu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 21:50:27 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E3FB0C41
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:50:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m17so18429871edc.13
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gH0iXZlb69KGwTMEwCW73BBlpu/qd9hmFpBDv9nG00I=;
        b=TIxaTrFwdRdR1uBF9OdNtQKLmcEc3djnoKqdk2iBe0nsAfjs8kOwE67msGp3fJ45kY
         M+78VtH6cZNF9df/CnklCwCUXMxGsAVnToJ1wAMOY9m3PXRKwedoa6/ihQCLAOYOdyiW
         Uj1jaFeuuB+RQRHZJfrD3O3u0ecQRM794mt9bj29fTaK/ceGwMsiMPw++XctJJU0QgUk
         S285hD6vP4WMcsLksL7KYexHoE6zC9kUcswclZOv/gbDaUHoaD51r0p4hxePovJ0QeL0
         MsUfyD9G/YsoSAp3MyroC48SPD1Un0heJXwaCQyvNlir2gx/v9sFulfcl/WN4s4fz4lr
         VnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gH0iXZlb69KGwTMEwCW73BBlpu/qd9hmFpBDv9nG00I=;
        b=xBgHU0a72fxjp4WowZO7sUPfLmnkOz1iKQs0ITxj2LlqlgTSpBaOOXbVWhOWvAzkDN
         jZ+7K89iXjboFSnN5IvuVTsBbzFZPkpXtpFA1O6PJXL0oJYrayZRbmNfJrZcibF6JAcT
         416DZjJEBC00JnxysA6x5mQ/7vWDGlFMxTOILmFj+bNP/hvTAA8LZqaq5faM7lcKx7tm
         pwsBYK4tdT4CoUqmumH/Xqx7dlDflMcpKMnq68x1OfhQf/yg8QklfxwilmLvAg03aLoZ
         j5d1X58KKRLmpHiFOsXopDL9WIsTma46WGxl6aoE+jW0e+td1lu28GjDdDA6esZckbtw
         0Ajw==
X-Gm-Message-State: AOAM5339HCCBPmXX2FrX+nUgOQ8i0QOJqHROEVYfOGHgh18TfRlOMxu4
        p1DzsksyR2he1lr8Dk0R2bc=
X-Google-Smtp-Source: ABdhPJzpR5DCDtBTjZQlkX7N6TM62x5jzamoUKm9E/t206Rf1w8CCH0cC3pYxNQnqTS3ZRrK/PTqqw==
X-Received: by 2002:a50:da47:0:b0:410:a39a:c43b with SMTP id a7-20020a50da47000000b00410a39ac43bmr11361683edk.33.1645239008474;
        Fri, 18 Feb 2022 18:50:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p21sm5183699edu.107.2022.02.18.18.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:50:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLFp1-004fSE-FE;
        Sat, 19 Feb 2022 03:50:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Date:   Sat, 19 Feb 2022 03:48:42 +0100
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 <xmqqley7yd6e.fsf@gitster.g> <YhBY8oD/xJZUQsj9@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhBY8oD/xJZUQsj9@nand.local>
Message-ID: <220219.86ley7fu3k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, Taylor Blau wrote:

> On Fri, Feb 18, 2022 at 03:20:41PM -0800, Junio C Hamano wrote:
>> > +# Usage (using ":" as a delimiter):
>> > +#
>> > +#	prepend_var VAR : $1
>> > +prepend_var () {
>> > +	eval "$1=$3\${$1:+$2\$$1}"
>>
>> This one is correct; the above sample, when passed ":" and "VAR" to
>> $1 and $2, will specialize into the above example.
>
>> > +}
>> > +
>> > +# If [AL]SAN is in effect we want to abort so that we notice problems.
>> > +prepend_var XSAN_OPTIONS : abort_on_error=1
>>
>> XSAN_OPTIONS stands for "options that are common to all ?SAN", I
>> guess.
>
> I was also unclear on this. Looking around in the google/sanitizers
> repository, I don't see something called "XSAN_OPTIONS" mentioned
> anywhere (neither in documentation nor in the actual source code).
>
> Is this a convenience variable that we use to store options that are
> common to both ASAN_OPTIONS and LSAN_OPTIONS? If so, I am not sure the
> extra confusion is worth it, since it only contains abort_on_error=1.
>
> I guess it makes it (along with the prepend_var function introduced by
> this patch) possible for a caller to write XSAN_OPTIONS=... into their
> environment and then run a test script and have their settings feed into
> ASAN_OPTIONS and LSAN_OPTIONS. But I don't know that callers would find
> this super useful (or, at least not dramatically more convenient than
> setting both variables).
>
> I could be wrong, and I'm obviously biased towards my own usage of the
> ASAN/LSAN builds, but to me this patch might be clearer without the
> extra variable.

Sorry, yes it's just a git.git invention to refer to "common LSAN and
ASAN' things. Perhaps GIT_ASAN_AND_ASAN_COMMON or something would be
much less confusing & better? Bikeshedding most welcome :)
