Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685EBC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiCINyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCINyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:54:23 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B71E546A6
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:53:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt27so5311848ejb.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cCV1xuHCvyd3nwn+kwJ49CY5n+Rsyw+EKIReJgTOfGU=;
        b=IdgHs78z1hkTW3GvNU8Coo7uifrFq6dog3pWn+pzk9kvFs3UYihchOkT4iJXTFdag+
         xKg+pRgYbI/NztHDJe9k2TgRWB4c6gPOiNKSiSwW7vU2Dtui1nQhF8vcg85ZoXOfSPHb
         CMLqlgQ2DFZcv86xsLyfJwmnVEbsG7HgmICr1Om4QZWLps1Xs0u7ON8KfuH4h/SxYegB
         7rIuFAkIv/+PowSGWIAN+IjMB+tdFhW/4KnxmgKGZz7lqrYe+fNklPv5GQJGFtGv1wIO
         8l7cxt4Y8PyFBXCuexzswF0joUanufOOkjR0tD6eC+zKjpAMz+UrlsLbWAMxoV1I1Uoi
         tfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cCV1xuHCvyd3nwn+kwJ49CY5n+Rsyw+EKIReJgTOfGU=;
        b=nE3qy/DZ24ONd5Vf270eA6CdnQzna6rfUJMADJpOh4XAfPY2Jmo1qW6A7EK0bayjCv
         5Zu+gn95o1EXS2tR1S9i7M/+6lmFBvRQQ3il8EerZ2jKX7hXreAXaWndThVFap3OxMBi
         hmyV1O7rv5ktQa5rZYde+kQ8/y+ca98Hsswj75OjljyIOb8IgKEKXrNDHRNUrDSAHN5a
         FxU3mmPZv6dU6RJDFJo3QLZQOdpSPQL8FFD7b/DRJxVh0UP90OCaoX5aEcK+H8M7tylf
         heITRrEqbNOdJEp115615V+RuA3i5s/3GO95S37AyXPLlbKL5DWRjfH8c3TVviCXYtTI
         b0fA==
X-Gm-Message-State: AOAM5302zBWWhP9ji4HiPjj0Pnl+GKeUbxzEwpf6TvGlki3jao044ym/
        5UJWCRel7DCmWKmHN4ujFTI=
X-Google-Smtp-Source: ABdhPJzsco9cyNGLXJNrI1K9Wc3YyC2YYH3EEM4QiRxCku6WYefuI1PWl4Y4+Yp31adzsuJakM/QcA==
X-Received: by 2002:a17:907:d01:b0:6d7:9f7f:ef8a with SMTP id gn1-20020a1709070d0100b006d79f7fef8amr18287848ejc.656.1646834002540;
        Wed, 09 Mar 2022 05:53:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm788029ejz.57.2022.03.09.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:53:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRwkj-000B0h-7A;
        Wed, 09 Mar 2022 14:53:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v6 16/30] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
Date:   Wed, 09 Mar 2022 14:52:17 +0100
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <cdef9730b3f93a6f0f98d68ffb81bcb89d6e698e.1646160212.git.gitgitgadget@gmail.com>
 <220307.86h78a2gcn.gmgdl@evledraar.gmail.com>
 <9bc32c17-7249-303f-e579-8992c5bc8497@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <9bc32c17-7249-303f-e579-8992c5bc8497@jeffhostetler.com>
Message-ID: <220309.86fsnrmdv2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, Jeff Hostetler wrote:

> On 3/7/22 5:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
>>=20
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>> [...]
>>> +#define kFSEventStreamEventFlagNone               0x00000000
> [...]
>>> +#define kFSEventStreamEventFlagItemCloned         0x00400000
>> Can we define these as 1<<0, 1<<1, 1<<2 etc.? We do that in most
>> other
>> places, and it helps to quickly eyeball these and see that they don't
>> have gaps.
>
> All of these constants are defined by Apple in their header
> files and system documentation.  For example, see:
> https://developer.apple.com/documentation/coreservices/1455361-fseventstr=
eameventflags/kfseventstreameventflagitemcloned
>
> The set is relatively fixed by Apple and we won't be adding any
> (since they define the bits in a FS event from the kernel).
>
> Changing them to shifts would be wrong.

Ah, I missed the "ifndef __clang__" at the start, so most of it is not
needed except with gcc.

FWIW I think having that whole part just split into
compat/fsmonitor/darwin-gcc.h would make it obvious where all the
GCC-specific hackery is.
