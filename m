Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B7C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 18:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbiDMSf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiDMSf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 14:35:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3155C67C
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:33:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g18so5695553ejc.10
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 11:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=VUdUX9GRlws1cDmW7ihMRL4Wi1G6qPrZFJU1J6e3jxE=;
        b=CcD89DHJ9+8+HRNx34Bq+tODTbUO66Q1z0uEbk5OWykJk1Nr8c7UweBNsEtzN5uIPL
         ICKN01tecGGTrgUFro1xOiMcGLRGvmsjA3vpdvHiLWL01S9fg89wMdPYELzulM3uQUei
         w/q7NwkjHepRB4phGuR677KWq0MCdeoUmmWNpX5HT/5P8zdsX3J0bmOD/ZIDuU/vmTjk
         mjRFKgjifFfqSx/g3n/2Y84rWMaJPWASi3IuKuHWr+LjyFtYB/2QYwJm580WequjMtWg
         InJcwQSwGqXs84rSBK3RQmYjdGyrpDPd8mCiRXy8/KOSGoYs+o0n+F4pKkegqueuk9Tf
         gm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=VUdUX9GRlws1cDmW7ihMRL4Wi1G6qPrZFJU1J6e3jxE=;
        b=WHRKeXrD2LO6Cdh0+Uyz3Gzbd8nOGNlAKELeKU9U7sy+2mjSjnlHQw/Ff0r2s8rOn9
         UwGt0XrgVqY5byj2Y4f/3vwuWaD9GXRNyRIxU3/hAHO1bSWTrYfmChPM1IqStb4ovZvZ
         cWMijVpoiPJ6GdDnrnBuyIkUaxf6NVvNv1IXoDR9NhI2N7SvMPlRdOY+pHwTUag7gkig
         aWq/PG8aM0oD49HcaESqHcDbR3ehr/ak6N8xsIFdNoRHRP0NLBN7ggXvEG51UsM2JxGQ
         PvRu0bdEotGvSoUBuTSyqQsyIQURefhFFy70La3AnHd8IzyR5Jn9SZakuDyUV1Iy798v
         Ud9w==
X-Gm-Message-State: AOAM5330t9sqwfbWj4tJA5F4EQb/PREbmF5Qz7vSuuy3sPPOwq8723Ln
        fIMc+Xd+nRRhkISWbfjX/E0=
X-Google-Smtp-Source: ABdhPJyD5oFR+HlPy1AUq/3n0L1fjsbHFzmE+lOSql0k2bBpCtz+k/mrhFBXhQHzlXjyNCS5V1Yx7A==
X-Received: by 2002:a17:906:714:b0:6e8:7f57:2d4e with SMTP id y20-20020a170906071400b006e87f572d4emr17061675ejb.575.1649874812576;
        Wed, 13 Apr 2022 11:33:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b0041904036ab1sm1503982edv.5.2022.04.13.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:33:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neho2-0058tg-RR;
        Wed, 13 Apr 2022 20:33:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
Date:   Wed, 13 Apr 2022 20:25:20 +0200
References: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
 <20220412201435.803424-1-jonathantanmy@google.com>
 <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
Message-ID: <220413.865yncg7et.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 13 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
>> This seems like you're using the commit message as the reflog message -
>> is this necessary? For what it's worth, all tests still pass if I
>> replace "msg" with "NULL".
>
> I think that's what the existing stash code does, and so I did the same
> here.  It's not strictly necessary, but it's a nice to have.

In any case: Jonathan changed the code to omit the commit message & the
tests still passed? Is that to do with:

    We specifically rely on the fact that we'll produce identical stash
    commits on both sides in our tests.

I.e. that they're checking round-tripping, but not known correctness?

Also: Maybe I'm missing something but stashes start with "WIP" or "On",
but the export adds a prefix "git stash: ". That seems like an odd
inconsistency, why not keep the message as-is as the commit message?

In any case, the import then takes the message as-is without stripping
the ""git stash: " prefix?

