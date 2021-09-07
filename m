Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1BC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF5F61101
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 09:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbhIGJOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbhIGJOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 05:14:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E3EC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 02:13:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s25so13009874edw.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 02:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KREQoIglvDiZGtil6VgakxVqOu55NmgbMDY5q5YifKc=;
        b=pFqcaJ7/NpuyGWEmKps1apiizxME+V5UUmjHak+dM3Oow8d48WDMm5X1zYtN5FxDhe
         POFB+5gU4oSqetkD8kx7id8ieaQ9XOEelJi3aza3f6qHQGtGD/nMhvMW1dsoYT2g7b6F
         xwH3NRpyMhdJ6GUnrTx2BNfUAtNUgTK18Xs12Qi36rTIlLOJG81P/000yFyz8DOZVpz4
         jBl98NX37BV8IEVA25yqBEaJnPEmI46WE7eEzzMJrMu+4kF89amx6WE45DZzZtE8+1bm
         J+Pi8TLAp/PjXN9dbv+iRDkhOKGOZ61j01UCJrfuFwkzxAVRfI+s1qqnn51fuJrgBlp0
         a7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KREQoIglvDiZGtil6VgakxVqOu55NmgbMDY5q5YifKc=;
        b=PzfWHvlRZlJYF18ToRBpVW+Z6D4nsPrqnpoLk5yJPwbfGqlG+Spi2acv5WnXSsJIx4
         a2o0kHhxY1FzBV2C2mP+Wj/HYOvj6/lPrLC6mug9P9pk+GtAUP2dV+iX+F1YZ7YAc+jv
         ruYiNdEmw/UDGiADw+/clwRflUN5C2pmza64fFWUCTRED/abzDw2D4TrbJo/LFZe/hfv
         89yK1lOcWg2Pk9LFP8Q3dUcTeDCyZ4R5/khvZAbbXUUaZZ6JSNb33GacZSy2kcCnPmbV
         Rng31MvE4iQLR1eI1zGdwOEos95x5Rj8pgB9vdSh3ew5uB5CeHmNFdNyxM//uCIsXPnp
         43LQ==
X-Gm-Message-State: AOAM532ehrVTJaCgoFaW01fFtHE38caE48J40Yr2YEGSdQ0nG/KFgar+
        AfYszIQmOsp+nhLDUVgewujgmAjBcOc=
X-Google-Smtp-Source: ABdhPJwYBcTDYK/iyTZ/sIL/G3lyycgudqZnU+1Pu+0Qb4J3LJhlWxI2jwv5KsKvwjTT0eV6QrtIDg==
X-Received: by 2002:a05:6402:4cb:: with SMTP id n11mr17412898edw.292.1631006006727;
        Tue, 07 Sep 2021 02:13:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r11sm5211781ejy.71.2021.09.07.02.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 02:13:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrew Olsen <andrew.olsen@koordinates.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Coup <rcoup@koordinates.com>,
        Andrew Olsen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andrew Olsen <andrew232@gmail.com>
Subject: Re: [PATCH 0/4] Compile-time extensions for list-object-filter
Date:   Tue, 07 Sep 2021 10:59:15 +0200
References: <pull.1031.git.1630885899.gitgitgadget@gmail.com>
 <066e186a-ffa5-3548-1b7d-a769bbd296f2@gmail.com>
 <CAPJmHpV2c_EubO4-GpV5Yi3RLpgvcaake=fz0rfgD_SZZcawOg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CAPJmHpV2c_EubO4-GpV5Yi3RLpgvcaake=fz0rfgD_SZZcawOg@mail.gmail.com>
Message-ID: <87r1e0n3yi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Andrew Olsen wrote:

> Good point - sorry I sent this out without accompanying explanation. I'm still
> learning about contributing to Git.
>
> The filter extension that I want to implement is a spatial filter - it will
> return blobs that store geometries that intersect with a given geometry, eg,
> "only return blobs in North America". This is useful to us at kartproject.org,
> "distributed version control for geospatial data", which is built on Git. But
> safe to say that this functionality is not generally useful to Git users.

That's interesting. I think you're probably right that returning blobs
by a GEO filter is not going to be generally useful to git (I assume
it's aware of some specially-encoded blobs?), but a mechanism that
enables that might be...

> However, the idea we have is that there will be others who want to implement
> custom filters also - perhaps like the spatial filter, these could be
> domain-specific filters that are not useful to most Git users, but allow for
> a custom Git to be more powerful when storing data from a particular domain.
> We could just fork git and do what we want with the fork, but defining a plugin
> interface makes it possible for us to keep using Git at master, instead of
> maintaining a fork indefinitely.
>
> [...]
>
> My colleague Robert Coup coded this up once already as a plugin library
> interface that could be loaded at runtime, and I've been tasked with rewriting
> it as a compile-time interface, which he thought was "more likely" (but of
> course not guaranteed) to be accepted as a worthwhile change to Git. He's
> unfortunately on the other side of the world to me and not working today, but
> I hope when he reappears he'll be able to say something more in defence of this
> idea, and perhaps give a history of the reasoning for this particular solution.

While it would be easier for you it would leave this project stuck
maintaining a C API interface, and indeed your documentation suggests
that not only should users use the narrow C API provided here, but any
arbitrary internal structs in git.git.

Personally I'm not per-se opposed to such a thing, but I think that we
should really be considering and trying something like the clean/smudge
hook interface first rather than a full C API.

This seems like a perfect fit for such an IPC interface, i.e. we'd have
a hook to register custom filters, and when it came to filtering objects
git would communicate with that hook, which in turn would query data
with something like the "git cat-file --batch" interface.

> Regarding licenses: the sample extensions I'm contributing will be covered by
> Git's GPL-v2 (I assume), if they make it into the Git repository. Any other
> extensions that may be written by third party authors and are maintained
> elsewhere could be licensed as those authors see fit, as long as they take care
> not to violate the terms of Git's GPL-v2 when they distribute the extension or
> Git and the extension together. I could add a link to the GPL-v2 in the README
> warning developers to check it before distributing any kind of extension to Git.
> I'm not a lawyer and wouldn't want to give more specific advice than that.

I believe you've misunderstood how the GPL works, those third party
authors would not be free to license their plugins as they see fit. The
reason the LGPL license exists is to allow what you're describing, but
git uses the full GPL v2.

See https://en.wikipedia.org/wiki/GPL_linking_exception and
https://www.gnu.org/licenses/gpl-faq.html#LinkingWithGPL

The project you've linked to even has a GPL linking exception of its own
(but git.git does not):
https://github.com/koordinates/kart/blob/2934f2b951d61233cbaab9ff627aa3c8cbfb82bc/COPYING#L7-L16

> On Tue, Sep 7, 2021 at 11:24 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> On 06/09/21 06.51, Andrew Olsen via GitGitGadget wrote:
>> > Adds an extension: option to list-object-filters, these are implemented by
>> > static libraries that must be compiled into Git. The Makefile argument
>> > FILTER_EXTENSIONS makes it easier to compile these extensions into a custom
>> > build of Git. When no custom filter-extensions are supplied, Git works as
>> > normal.
>>
>> I don't see why this series is useful (use cases?).
>>
>> --
>> An old man doll... just what I always wanted! - Clara
>>

