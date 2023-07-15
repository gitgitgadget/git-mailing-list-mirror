Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEAEB64DC
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 03:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGODCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 23:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGODCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 23:02:49 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD635BB
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 20:02:48 -0700 (PDT)
Date:   Sat, 15 Jul 2023 03:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689390166; x=1689649366;
        bh=cN6dLneZM9OWttFh8FzasHXEVxBx9L7hatwaTKCWyjI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=J/JttXhYZtWJXR659eV1S7jAa+W+wRq/xS7d9V3TnF19C5S3TbpPjAjSftgpKuPKv
         xZI0Q+bUUydlhseU7vLqAorSGGygH7U7d7IqvUEGXV42zRJIjh2YtIqioy9p70Znp4
         fqdWDde9QDkp5B/avLBXZmGnt2Kn2ovwDX7X/HIo/3UYWQ7iDJzhKJmb1gDOcvzPzE
         Z8MV1YExcIvxzLTrv64T0uCwT+oZ67d97aDKNYJW77Xqt3/Nu4TmPLjHrg5xEBBz8o
         cowCcF3/B2/w0MGTLwHS/t3Tu1Bs1fNrN8Ci41hnRqESla4Ru34SXhvdSkl9KVQDB9
         P8H5Xym3aay3w==
To:     Eric Sunshine <sunshine@sunshineco.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: t2400 on freebsd12
Message-ID: <dk2fndv5aqshkgvfq55mrr5chdouenszedugyjoezcuatrsmn6@vqyih7nbqwbu>
In-Reply-To: <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
References: <CALnO6CDryTsguLshcQxx97ZxyY42Twu2hC2y1bLOsS-9zbqXMA@mail.gmail.com> <CALnO6CCc-J+fe9qKaoyYUMM3xMEUnV5w7NKWSbn6xTgEjbac5w@mail.gmail.com> <xmqqfs5ro8v7.fsf@gitster.g> <356tacvizwbtwigdkz4byrrzsyjuktcb7cxaibf6wjocffgycp@iwhmszuuvzpl> <CAPig+cRMXJkrEgyVtC0u2QK=5QNnJOQnXBU_rE+JiGufEYH9sg@mail.gmail.com>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/07/14 12:19PM, Eric Sunshine wrote:
>
> [...]
>=20
> I haven't been following this thread closely, but I wonder if the
> `grep` introduced by patch [3/8] of the cited patch series is
> problematic:
>=20
>     grep -E "fatal:( options)? .* cannot be used together" actual
>=20
> since BSD lineage regexp (including macOS) historically did not
> support the "?" repetition operator. Perhaps an easy fix would be to
> simplify this to:
>=20
>     grep "cannot be used together" actual

Thank you for this insight. It didn't end up being exactly this issue
but it seems to be a grep issue nonetheless. I've submitted a=20
patch [1] which should resolve the issue (I tested it on a freebsd12
VM locally).

The TLDR of the issue is that grep 2.5 (GNU or BSD) doesn't seem to
recognise `\s` (or its inverted counterpart) as ERE but newer GNU (and
potentially other) grep versions do.

1. https://lore.kernel.org/git/20230715025512.7574-1-jacobabel@nullpo.dev/

