Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D435DC433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 07:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiK3HMH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 02:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbiK3HMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 02:12:05 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088A725C5A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 23:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669792308; bh=Y9SCKSm+DOIgUcbu5QLwczfV2xFX7YGZF+uqTVpbNBE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MF3DNKMRX8BHomxH6K8GsroOmSIv65RFMOU1Vh3ADhchoEnVeHfJcAG78ZYNq+O9w
         x5KTW29YNHlrqn4giQ/ut7QX8pl3mkkLYWJdIoAm9y2DbvH0KVeXaJbBypglGyCmwv
         KcGqlbLOmIcOwSL+7TXkvoDUs3m4kU9195u9FKHvhL3zuecDxBh+oBm+Pj8xcMUyOm
         jB6tSz46wBFAllrwM9l0dfeihkk41wDF+9XWMI4xrBd5Lv85jl5uaHDJF5p7noKOpL
         afGpKXsHC8k4VEaUz6wRpWIKhZpNDeRRySIMHpdMmZTUD5PSBaWOd+HzI/hX17lhWH
         JZW979kUCOAFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1pPgQR3sVY-00Rzby; Wed, 30
 Nov 2022 08:11:47 +0100
Message-ID: <3eefcd8c-3011-0317-c6d2-d554e03d8e6c@web.de>
Date:   Wed, 30 Nov 2022 08:11:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/5] pack-objects: fix handling of multiple --filter
 options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
 <6c7ef5fb-59b5-df16-036d-9a9a3d987cb0@web.de> <xmqq7czd2qq6.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7czd2qq6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:irdYnJbnjBGe6njqt8XOYwFO7NUM4NIS9dirjOqDusB0iwAPXeg
 BCLSnbqIoeCwU5B1RBJqbIzQMQ564b3HU7evRy5UylJw6KpXxhyeeLaX42arW4iy8LvnVWR
 JGFYjYnanzoE/oBqxuyqpEW3oR9Wy7EbEH1DqZ/MWFNLqOACL5qaPWiqg1SQ7Ch/iiErS4t
 DID++9SCD/scT0OFVGLRQ==
UI-OutboundReport: notjunk:1;M01:P0:pQqcDhJBK1A=;5In4zgMHoLtkjVDXBvOTezl+xzC
 4xh4cjUbv6j6vC9m04ZO1rYOiZPj1DxbwDWULepNYw1TdhzIbKuxKbgK78tEVFC0RjNVRr3K0
 IFhY/cpKXtHj83SO/Hp+oQp2fzjcy5FNGdvArQmA+rsFJs75wTME9YQhuzzEjK5Y5ooGWTpbo
 LnqXXUjLGM3zBzwe5ao0p466qXUHlNiWpttWXCqF/PUsr2E6lK13YeajzRIUxqz0sXfWxFfor
 J9Y3YWWQ4LoJfkZz/AvUI/Ue8mf8sYcL2mCxuWWyD4sW+4ozTailVsarncqGqLI9IaBvgYgjE
 Zs43Gi3qg64PffUSM5yaHP+flHLSVm3vze3eT6opAui9SHmI1NEbtwnSVjNcH02S0Zg2iOvU7
 /ZcekkMDgaXKVarzye9j+48FgLbAO9kOM1jrZG+jWSOanM/7WU+g/U0WmoO4yOZ+gDpZ/JIFJ
 KFrWgf3QAn4vYGaKvcU4d+zWkUJY1fvqEdwSJyjntlFrnDLB9N0KhxJ+wGWWgsHWm9S97C4/Z
 Fce2cY5RJGFgxKagWSIB0XhOsKiTb4W94pvub2a0zziQ8CixxBEhz3rO4zfHi0nIJ4/FS4aFl
 yjz37Lp4lNEgW6sJd+RdwmsI2LvijLBT5gXA0zwffvj0SBTMzELfgtvvgvQtRJj9uwWXzzpW5
 /3diltRUMhnbrsP96tMm+mDWL2fwPuBl8qCTvvLZgRCOG1syhlNI0i1QvgEbke8og2kDaMPjj
 8q7xDJD2b5CUCWUKlOsILBBNgpgoxeLnNCZY8AoeEtK1J3lWpXwixGOKi+8M8bl0yEjV3nZ/q
 WGYpY1NuWgFKVY9onQvcGGH0Xkwn0WPgK1RsTn5wkjcbx7lpm67T6Et5PDuuiO8VT/SkpptzW
 c+Yaf604neiX8wvyyEgOvVFsfzKgeyzGhNcRQmO31BKG0lzjLwfeO/Vo4TGlal6rqMwXjGM4W
 0+bayOQ+7SyaLi7Yq/ioYsAIC1k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.11.22 um 02:09 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
>> leak, 2022-03-28) --filter options given to git pack-objects overrule
>> earlier ones, letting only the leftmost win and leaking the memory
>> allocated for earlier ones.  Fix that by only initializing the rev_info
>> struct once.
>
> I think "leftmost" -> "rightmost", if your command line goes from
> left to right?  Or "leftmost" -> "last" (e.g. "last one wins" over
> "earlier ones")?

Yes, indeed, I mixed up left and right again.

Ren=C3=A9
