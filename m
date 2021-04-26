Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8013FC43460
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4921B6135D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhDZPiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:38:22 -0400
Received: from mout.web.de ([212.227.15.4]:49099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233829AbhDZPiV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619451457;
        bh=s0gEcOTik6IAwPZI7lW0AuWufSErlW5w3cfx3kSTx9E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=O0bJfgnhbKsdvjyg+Z4IRo4VxmULeOsIZ7TdOWkhxl0VEYBFvL2FWqhEFdSObmk7y
         l49KAfY8B7LSQqptn4iyimxQJ5NbTBr255elX3sVp6xQZkUyVPNI8esSmCNV9KbtTR
         mJkiidwcHws5z37/WyVtiCXtgYR1HIHDUverYI/c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MbTLB-1l4BWi2GHx-00bT6H; Mon, 26 Apr 2021 17:37:37 +0200
Subject: Re: Possible segfault with `git clone --mirror`
To:     Kostya M <kostya27@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBE?= =?UTF-8?Q?anh?= 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <CACAwW2gHBPRujCV0LSS3p1Td_GkiGG87U6QPLVrp69ShVNnPTA@mail.gmail.com>
 <YIYL2BtIacMIthgy@danh.dev>
 <CACAwW2gUo7R2V-gX8dM90UCoRSBwqgz3nw67xyDx1a3R9ahmqw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bd656129-7b89-d61b-3413-5495ff3142d0@web.de>
Date:   Mon, 26 Apr 2021 17:37:35 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CACAwW2gUo7R2V-gX8dM90UCoRSBwqgz3nw67xyDx1a3R9ahmqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+TaDv25EZY7ihbJJTjZFw6rXeXqZrXO4oe1EkyTcgHMypG6uSeZ
 x9/N/DCm9oFRUH5T8HT/RaSjouJGLCwy7jokV/+7G83e+/cFga+6Xru7R/PuACR25Ppjle8
 3ePXgfuKbWO6JGWGXhEYYmexSLXBX4anL2lMYx48ky2GHYjAnFLw7sSCO+iaKfXUV3qFWvM
 P8ePITDDtHmkM9cwgQ0cQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JeSYrSYVqxI=:gZb8Ff0K0qEYRfQaQ2YHx+
 XJCeoXZIFSzIMoDpTslGj4aAXftAw8ugsqOW7PBspSRekFi5rRB2MOafhGhoh+3a9BKEDb9TV
 0ZGEr6TmWq96meHtoytMGSCgsSJWScx9G7sbOUjHXpSzttXDcMV4hKpJWUyYHHLtZRmji9YoB
 6bS4aM+A2q+Tln/232HTfqqfgmGMqCe1uGk8Wpy6MOrfM4xEKKy3rr623IF8qCFhMptA3mtKw
 oiS1oWzdjmJjb7VxEUAlZ/J95J3i78rwVJaN/MSfiexFfhnN8/Ir2olDrUWm1KGmETS7lLkge
 XqShmwBkXm3SeoU3AZxXCWF6+myQJy21Bf/3ND81trJrUj0r3o+GQYX1e68rGP7/4YLCThKyr
 KjGr7uApPTfLb20jVfpBGNTd8eca0SIvGSwbt40UJDUq78u9ETkXZzANY8OKLlRB0DbIkgnRN
 ycawGGcFrDa3kusPG+9owNfyQgbRDLMX4ygUmvxfZCOYH1Iq3IwNbfHFCuGtKB/EeL3XqXTR2
 EvVGvWL77c2erDBsQs6YPDVzOYWv4IOObHZ8FRW0/4DOHuUkzi4RABBSm7kRPOaS5EhD2flnN
 2BBHWAWhCCOLnPJyQg0ORgsRCWORcqHuHlRq8yF0GFiYxE5K+Hzp3fSpFm4fH/ZFN+3Awfrgs
 5K2hUahawpwVt0MnPt9GVqn+yaABoZe/miQ/W+LiRzcAfa60y8pQXSu9emkvTk5Jpolah05Il
 0W9ljOPg7bQ2aiHsnHwaL/UkjEDvfT6IqQdrymrx2n5SLO184u7sB6LJdba9taxCeVX0US13I
 60G9ovcNCvXp0+AIJYNK5f//BKxwtQ5SHwHI6ooLIQGMf1ZHX9YPVgm+Vyqcjf4tSMl4O077O
 XD+szSJV9jVnVBu5351ZpKIWYT8MB48I7vJUwOQbW0oj5nnhAALZmFxGdGVBENgqG1VKOBGFI
 n6VfBTLHGtqznTtAvSMpQhE/wDdLTGsY2iZmhA3ExjqrUiQ7x4BoE4Sz9fCAXtb4wBuf5Y2gA
 pMgfOhewg19X58zQms3Ebsy3eyXvahNCI1YLLp+JxdtDxBpr9CnkmjKNim16GptFKzXquRwmB
 tWVYYghj6P5q07MN0TpMV1KEctik5KlVqfyUvEocNlWlIQ8QnVbpco3sqLfgofnFaokUjQG9Y
 tcOPVrVrQsdmxltrRU4noEkH5oQrL+LNRGC4PyyD1UueZqv7hXicqvcaJdbMce+yg/XCc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.21 um 14:53 schrieb Kostya M:
> Yes, adding `HOME=3D/tmp/not-exist` fix this.
>
> my ~/.gitconfig is (maybe it have outdated options, it was generated lon=
g ago):
>
> [color]
>   status =3D auto
>   branch =3D auto
>   diff   =3D auto
>
> [core]
>   symlinks =3D false
>   autocrlf =3D false
>   repositoryformatversion =3D 0
>   filemode =3D false
>   bare =3D false

That's probably the one.  There's a related fix in master:

http://public-inbox.org/git/20210310011120.1151749-1-sandals@crustytoothpa=
ste.net/

>   logallrefupdates =3D true
>   symlinks =3D false
>   ignorecase =3D true
>   quotepath =3D false
>   pager =3D less
>   editor =3D "vim"
>
> [pack]
>   packSizeLimit =3D 2g
>
> [apply]
>   whitespace =3D nowarn
>
> [i18n]
