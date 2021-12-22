Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB7C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 11:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhLVLPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 06:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhLVLPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 06:15:37 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5DC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 03:15:37 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b19so3185562ljr.12
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 03:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kKWh92enwARTkiERFJ6AX7xBMJy6rMSdiII5y0A0cas=;
        b=Vrd2mRHiiQsI/6GRjawLozeOsamNAIh1ZHl9U8dy2N1UDPL0Iqtd8+HWKDAhsSpKX4
         Npg1XinyfPwx9DuL/Divpb/NeLEiKB0tO+XlWsGrU9t5X+XbT8vyQXdM9pF+rwA3+QDM
         aKH4wbs/nLO+TxlK1lTnpq2DXIpQEgMJh108761mN/852NuQo4urPfgPOTdinNwtDCcN
         93qRMbKooD/r7HeWmfPGGA6BikqvdakPcBQkG6sU43Ka+G3QCR5QybzKap+pSc5w8+MD
         Wx/HfHITyg9XpFiulHJm7Aw3Lvsfoql6gWxLXCX5pGAyS3hI2ijKDRnSQzQZXlVfeteR
         XpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kKWh92enwARTkiERFJ6AX7xBMJy6rMSdiII5y0A0cas=;
        b=zcfBxMqYd8KMshtQ3GDwQHFuk10LUfbJDCVKXqnixqEBibyp4mhXw3qk+dKlT3nd1H
         HyJoldFlu2gCgDgVn1mxF2AKqjp4VRqb4jsExUgj1A0n+wLWYdnE6ZOm8++Z0M7WV5Li
         jhSTJvg9Sn/w0DrNY3cjZe1oA3Y+V+gQ9EG6FJ9zEaVWJADQUquNOd5GVC/w6HZwfdlQ
         a2hoYL1eGz7rHq+fNwEx6K/YYrHQkJ+95QtWcVpoL57X4y7bx94GPBoHn3swDZDHK/VF
         j06uMnJ6b9C3jjJP7KtkE9cDh3HcQ4luL0znmgGKv1DQTxQ8zSEUnoiNCgzqn0Lho/8C
         jEYQ==
X-Gm-Message-State: AOAM5301vs9hmn4S5KPt3VXSVx9PVFQELlpTrAY/nPEuG5pm6gVmSczK
        pzcjFQXEQuZSKJCdXKhbieeTWyAEyz7ddsh2zEk=
X-Google-Smtp-Source: ABdhPJx0bS5FcAF26CYyImSiJaNquxdOPd3+9d5iIQ7vwQ3otrXBKqDwYM4Z5obOaqRdfGDvXYOvgwcwidzdl2BfN98=
X-Received: by 2002:a2e:a270:: with SMTP id k16mr1759684ljm.387.1640171735468;
 Wed, 22 Dec 2021 03:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20211217112629.12334-1-chiyutianyi@gmail.com> <20211221115201.12120-2-chiyutianyi@gmail.com>
 <211221.86bl1arqls.gmgdl@evledraar.gmail.com> <3f1e3a59-1288-ecff-88b5-53bbd510a6a0@web.de>
In-Reply-To: <3f1e3a59-1288-ecff-88b5-53bbd510a6a0@web.de>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 22 Dec 2021 19:15:23 +0800
Message-ID: <CANYiYbELNLg+5AZ5PYS_FJKOXBC7Sw9jxsyt0Pu7GQue8H1eDA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] unpack-objects.c: add dry_run mode for get_data()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 22, 2021 at 9:53 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 21.12.21 um 15:09 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> > Maybe I'm misunderstanding this, but the commit message says it would b=
e
> > dangerous to allocate a very larger buffer, but here we only limit the
> > size under "dry_run".
>
> This patch reduces the memory usage of dry runs, as its commit message
> says.  The memory usage of one type of actual (non-dry) unpack is reduced
> by patch 5.
>

For Han Xin and me, it is very challenging to write better commit log
in English.  Since the commit is moved to the beginning, the commit
log should be rewritten as follows:

unpack-objects.c: low memory footprint for get_data() in dry_run mode

As the name implies, "get_data(size)" will allocate and return a given
size of memory. Allocating memory for a large blob object may cause the
system to run out of memory. Before preparing to replace calling of
"get_data()" to resolve unpack issue of large blob objects, refactor
"get_data()" to reduce memory footprint for dry_run mode. Because
in dry_run mode, "get_data()" is only used to check the integrity of
data, and the returned buffer is not used at all.

Therefore, add the flag "dry_run" as an additional parameter of
"get_data()" and reuse a small buffer in dry_run mode. Because in
dry_run mode, the return buffer is not the entire data that the user
wants, for this reason, we will release the buffer and return NULL.

Han Xin, I think you can try to free the allocated buffer for dry_run
mode inside "get_data()".

--
Jiang Xin
