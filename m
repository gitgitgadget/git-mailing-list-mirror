Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC50FEC8742
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbjIGRxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245620AbjIGRxb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:53:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93DE71
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694109179; x=1694713979; i=johannes.schindelin@gmx.de;
 bh=f/wr6oU/TFPb1aTfDBmbwkGGIXnieMUZn7kha/Y3fD0=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=pU+94/3mJXKW6odQ6zKDv7hJNycY6W+B/N6ozgZJsm1g9Gf5MIRqgE9+XqN31KS0255+1Yj
 NvOArnnrAklxFpExSyxKAURMWF6y7rXhKNYgyi6e2d4mqMtu/rl4wqfJSiUuieX0NaFKMOQIX
 ms07AZivb7ajZUQtbBfHaqyTFg7ebG7Qb6q9TVfgrzrtRno5dnD9blG8pTDkBbz6G3xbwtRqf
 x771hwXy/IMGPVL/fS4Vn/qLq053pIxtiKjVzbvNBbd9l7xwUW7l8lQBl+OPjGp6p2Ib9Y8qV
 jtyP31DGsMZZ+VsPZZLfB0XVewU7KDWXT46C5UPqmxpNEgDNCv7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1pt1bE2Zsd-00oTHi; Thu, 07
 Sep 2023 13:02:47 +0200
Date:   Thu, 7 Sep 2023 12:24:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 11/15] replay: use standard revision ranges
In-Reply-To: <20230907092521.733746-12-christian.couder@gmail.com>
Message-ID: <03460733-0219-c648-5757-db1958f8042e@gmx.de>
References: <20230602102533.876905-1-christian.couder@gmail.com> <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-12-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gkbhkjlaj+qrYge29mtQiSzyHRCQxSjOVfDda87ckgbCOY4fj7c
 JdgeQToZ8bqb0cYCKoxZtZMGzTYChGMH76buX6xL/vZwAPsV3wYWjjaPzB8cyhRyEHbfawJ
 St8zDzvrjSKpVJuupfmAitWdKHLrMUKRSwDxeHjONVGo/k2K6/2RHH5Z5iM7+MlodF+FmI5
 3tuVzqVjd9l/QXA5xWz6A==
UI-OutboundReport: notjunk:1;M01:P0:IxXIEIU8OcQ=;yq3AfcJzE+SOeb+kfSqEQf8f8xD
 bCMCSm8SOLH37HaRpQoa80ldx8cl44aa0XP6YPjk8WM2TAyEcd47twJncJaHzMnj/TsmpA6Ki
 7iraGP+Hzm9R1tP6DdgN613UgOoBaxMHZd8fHOo7JUeRLXmKq84ZcDpK25MaGxQconfxgGP30
 QtKw+w4QR1ng3a2QsSri5LcFsClt1KYs1z5IMKHUj5s3di8SUvJy2xNjY/rZMCJML1e/pqV3o
 1G8QBXMyIFTLl7pO4GzGEH4Cd00gtTQdGQeQ+lDhc9+yM3wUewJOrHjtPc09eyP0NGp8U+Omo
 5F6PSkiO78+uZQ9KZHoFV4uIfAH3lOZX2fexcdDtRCW43swp0A0vAZ0CY67nL1mn57sK1HLl4
 Mdnfx4PuO7kJIfZnAoGK3DKHMNlZ7VdOyQVBqPrruJQQyj46k06iWiYWhUspfHaFp2BIEjIYU
 UrH/unNuOlfF9I4KpP5lEd8X6P9Q9dTWwJzLYcIdsMuORpYE9Nd8gAbwu+rF/1qGjrXCQiT+I
 ytn24xchWqMUL+gpPgqivSS2VtYKa3NdfU4rPiL5x2wWG6ETXUYM9eFRU2+zlx3GbBicqUgQV
 ozazF/rgU4JtCVaPXOiDXkvSyUJ5VNdvGiVqG8/bGNAAg8uOEZVQUi7OjimKQex8jv4iqotWM
 R6B/S2Fp2+bwsPoMTz/EBASKqzWJqDO5FWG7c8l3MMtUjfFDvZKIcnRRrrLh5mfhn9Q3Jh0Db
 LaxGjyAraVF2UaQZWQVwvURHsCZPUBS1GsRDfgoQqRMQoolfTjgXj9KsOEHhq4Mx2fTpcZN/U
 PgJhXJ+FJa2PAUB/9K5DDpeUdVYEuLt9TQxlA3UcYikHr8/cdNTIrqv5KW8ZOk/Bte2Zunciq
 ZjFsrW0xRSpOqy01cBSHQCXcSgeWkPG6Ixtc3zqrChi0QyqV4iToN1yhZvBMCy/VAtW34EwQj
 coqYp03eYQYKyizopSqJCFjTBsI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

It is a bit surprising to see the manual page added in _this_ patch, in
the middle of the series... I can live with it, though.

On Thu, 7 Sep 2023, Christian Couder wrote:

> diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
> new file mode 100644
> index 0000000000..9a2087b01a
> --- /dev/null
> +++ b/Documentation/git-replay.txt
> @@ -0,0 +1,90 @@
> +git-replay(1)
> +=============
> +
> +NAME
> +----
> +git-replay - Replay commits on a different base, without touching working tree
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git replay' --onto <newbase> <revision-range>...

We need to make it clear here, already in the SYNOPSIS, that this is
experimental. Let's add an `(EXPERIMENTAL!)` prefix here.

> [...]
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> new file mode 100755

Just like the manual page, I would have expected this test to be
introduced earlier, and not piggy-backed onto one of the handful "let's
turn fast-rebase into replay" patches.

Ciao,
Johannes
