Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639AC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E27161167
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 19:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhIJTrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbhIJTra (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 15:47:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EACC061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:46:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n10so4032493eda.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8ENOWfLiR9u/ExenFDjVyvw+w2sHDzKgNBIKJYtFRaE=;
        b=NlFtSV/Jm7ZbqRfJQk0ycy8b2r/gykEiQODt2rkR5ncLgEtGTy2QI3PnvtJnDlyVGu
         /wZuumzdGoegwqSFrxGLbjuTTC+o5hKEcplAUoRevtFKVEBGxb6Cjh+rKMZjLISSOA30
         g3GZS++SE70ima02BpIlvAcOhOUg7PeJCGrfbSVY8O2K5ahI4z81SCgDsyW7ztBDsxEc
         JdrGXgaT+FbbrMs4YIc30Q+Xy6p0azF+ZWoOmuksyYNzHJTywVRy9/6rCR7Gjp+8JSRZ
         sX1JzsBrd7FauLUiB7rgufYU/kE5HcHbso4Gifns3OZ+t+tFxd1yMrLqdbxe6ieCZv2+
         0v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8ENOWfLiR9u/ExenFDjVyvw+w2sHDzKgNBIKJYtFRaE=;
        b=mJnfaoIxdACYgYuL7s54/AXn1Ug2KP7S7ARPJPrLi0Bbb/6nr4wwVgGnEMqyeAbvdK
         F4t5DuiZknbow2SJV/FWvKX1qbPqiVQLJwmMCzLtHynKsZy4aLTfA4kbxSvVg3cT73aC
         13xCGWzeT9iHm4EfFGDzP6HjtfAeam7CpTzgBaEFd2HRlYXYMIo+ScogTIL2qSVlrhmY
         E0jp3g+EjWPjCUTcZTCO0vrkSvMQGx/6P9EVO16siV/bhZMhURn2iiIpV+/aqyVgFjGP
         hm2RumDfA8eJDNZ6aaQC5UctOOHjkZbOnOg4Oa65+q04Z8IAZWuqjbGJi1FXzggExT6W
         7CmA==
X-Gm-Message-State: AOAM530CboJontLbUNg7eOVG2Z9Og6BgbZtvyvIrHOHTkIOOE5gIa/VG
        IiNm8YVCkZHRGBLtk4OnVEpdBeXA61GwAw==
X-Google-Smtp-Source: ABdhPJzb0yl1eMVE8m6MSFtG6bbZPSv5eUBKI4N7lFTXwVZyhvhugCBOD3PHtUe9DYsWeC6vI7Mi2g==
X-Received: by 2002:a05:6402:3107:: with SMTP id dc7mr10868380edb.341.1631303177688;
        Fri, 10 Sep 2021 12:46:17 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lm21sm2954599ejb.58.2021.09.10.12.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 12:46:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 2/5] http: correct curl version check for
 CURLOPT_PINNEDPUBLICKEY
Date:   Fri, 10 Sep 2021 21:41:41 +0200
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <patch-2.5-511534ce17a-20210908T152807Z-avarab@gmail.com>
 <YTkNdGk28UJnSDVt@coredump.intra.peff.net> <xmqqv939wdgl.fsf@gitster.g>
 <YTtpWADzTJEAIvk+@coredump.intra.peff.net>
 <87tuiscwso.fsf@evledraar.gmail.com>
 <YTt5nhXfZ8CRYayk@coredump.intra.peff.net>
 <nycvar.QRO.7.76.2109101740380.2614@fvyyl>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.2109101740380.2614@fvyyl>
Message-ID: <87lf44b4e0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Daniel Stenberg wrote:

> On Fri, 10 Sep 2021, Jeff King wrote:
>
>>> 1. protip: curl.git git tags are rather useless, since (at least for old
>>>    versions) the embedded version number is bumped sometime *after* the
>>>    release).
>
> (double-level quote since I miseed the original email saying this)
>
> This is simply not true and it makes me really curious why you would
> think this.
>
> We (in the curl project) tag the git repository exactly at the point
> we generate the release from. The release is however the generated
> tarball, and the tag is the moment in the git history where the
> release was done. That's why the release number at the time of the tag
> will always say "blabla-DEV" something.
>
> I know this, becasue I've done every single curl release personally,
> since the dawn of time. Of course we've only used git since about 2010
> but I can't remember that we ever did it differently.
>
> The exact step-by-step to do a release is also documented since years back:
>   https://curl.se/dev/release-procedure.html

I take that back, sorry.

It turns out to just have been a stupid mistake of mine. I don't know
where exactly but somewhere in the checking out of verions, building &
installing them I had a LIBCURL_VERSION_NUM that didn't match. But
looking back at the tarballs I unpacked (which I didn't remove in the
interim) it does match.

So it was just a mistake of mine, sorry to soil curl's good reputation
on a public ML, my bad.

For what it's worth I'm rather prejudiced to the knee-jerk reaction of
just giving up on source control pretty early on for this sort of thing.
I.e. seeing what state some some ancient software version from 10-15-20
years back was in.

It is really common for the two to mismatch (e.g. because there was
never a version for that release, the maintainer grabbed some version,
did "make dist", adjusted files manually etc.). But apparently curl was
rather early on bandwagon of good SCM practices.

