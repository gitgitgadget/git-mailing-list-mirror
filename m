Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F3C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 18:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiIZSox (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIZSoc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 14:44:32 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174D91D17
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664217790; bh=QMK44NtWBnAOchkHF0hNH0qC1rFgAyOGxd7VkxepJqg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Vt9OeBwGSUXbFci2m0+/Lpj1qLXfjZvg6jfmPLW2qKubJP9GFATf5XKCUEjmAYLGu
         GhFjpeAe1FDZK/bubn6ssds9PMKtmHk85gpUNCVAwL9vIrNDccMaQvJNpBXRTq9sJZ
         W8PmhN+QQZT04QywGCa12SLsWB7N6xtHn9OLuEO/0cUYSyWoYDg8jHQHDd1Nww31sk
         8HYNu4z/NSaI9LPR8uwEXcUkVq1nC1Z5TIYngcv49KOXgCLCt6+2wmYG9AVDhH80dO
         sSF6P1JDbOBb2hqL1tbQCy0C4KX9UXyqAROfkT+sYLRIZDwCcBujj+cmKMY3ObKlHP
         s8aRLOFmp2GhQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MODiX-1orw2h0HKz-00OJvR; Mon, 26
 Sep 2022 20:43:10 +0200
Date:   Mon, 26 Sep 2022 20:43:08 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 1/1] diff.c: When appropriate, use utf8_strwidth()
Message-ID: <20220926184308.5oaaoopod36igq6i@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220914151333.3309-1-tboegi@web.de>
 <xmqqpmfx52qj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpmfx52qj.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:4TmHZ4/HuieZCBsK/Zz40/tPubVUZka07KbUSbFWvjkB7NUJzrR
 VZzcoHW5dL/lq+LoHw6y/V/vWSHI+5qhG+qHBEMD9397qvC1l46de2kGC3IZsbfQWPXEMU/
 7xeCJvsTsAc5CPopeGi2MDa/nm49v5Z/dJWWm7L5FESQDJcvAWuizN73ILkeMrpeOIRxoFV
 MKtzsUFmeqRewz1bvSpkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S6ushWoKdI0=:NJsXFEwoLsnNPoN1hMplkF
 vGfJ07gvGMPoe3rohpFHJx0G1XBlhEyd3iZdtwg8ppwcDTOPs0CMGtNKhjIx4GuyNPuIs4rB7
 Qr6qdCgclr7K66LBylgtQGuxhYD4c01EMLwgF81HdrrNFkhbGNmI4RJtLO52mv1fOlNmFFw/U
 7EBkSCadfucy1IN2HPxmJvghDD+aTxO6V6j/FAavs4MPvxtHBDbsJLzTtoCTIul+ECjDn44Ms
 kSEtn1AWEUkyOAjVb0f+2J8k7ZpvibDag8YuOejySb0nnTdBp+/ocm/GomB3ltSyCt+2LZqTJ
 aOJqZI1tUBTNIZ5xV7WMSTt0WFTYbud/90vQ78/gkJbhxCIvxI9fbAgsBOaSxj6wffWq6lrRI
 4N8NBzk24D9A9YLPL4yVw38KIMDjvLjmrZKhRDA5/FysogZpJGPaw8cI/jSep5+FwCwg26l3J
 9YelZQntnXVx0GPJuClQvpJ+jNocvJuKsmHS5vApdjDeAza36VZeL7aL+LIWrpnAeoDak9KG5
 4wZyo/RyKMNykhhpFbxylAVXe9m/JvzaSUvzqeHaf0ysKp1xuJpOmMCEheNRw9icefekp5fB6
 7JAtIQ4ZDzkzjRyA0k0vFa57W4FDG61Y6Sj0/lNB5gZHPT5w9RSmHBAKergp41r6pU4VD/RkE
 yLeAtiOiKTqGvXNO5+8vo+FI/U+V5WGrOJ8m3gAM1+2fk5fRjFz7dMaw/tJEjes4aDcFdzY03
 oDSyVBFu+CFMCh3a3go01wy7Ojxvnm91OKgy2rmZnsLxRbgDsxejPbZgFfY6vesIZ08Seaf5A
 0wCiU+yo0blUQ5LBwdzbCT5lGy41PCN5IP4BNIqQayZZxOfUziYUTJ/KbcjwlxXBFYPBKB3TM
 f9rb2w7D0YYAJ67awDYqhW5kI+8DXX9nTwbQbPZ2+nFzVcdQ0ykwsJZJLHuYy5O8NRFvtK3+x
 +hhha5H1C9x3fywoKuU8IfuZKIXTUOukLyx+w1xmx8WxespnUnt8UriKnTpjqXHMGfBpu/lhZ
 rsJq9hi62FDyVQDfg8A3NZWKBHJYAFvYMSrGShxKmVhYTzt1WeYHCmlwc497NUCAivA/zpaRq
 TcnaNp5NuDWlkNMgYRE+bJamqOYuslHoTYxB2+r+igQ6LyC9JAzlXlDWGrorxDKm9ImJUjd5x
 NqeIk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2022 at 09:40:04AM -0700, Junio C Hamano wrote:

[]

> I think I spotted two remaining "bugs" that are left unfixed with
> this patch..
>
> There is "stat_width is -1 (auto)" case, which reads like so:
>
> 	if (options->stat_width =3D=3D -1)
> 		width =3D term_columns() - strlen(line_prefix);
> 	else
> 		width =3D options->stat_width ? options->stat_width : 80;
>
> Here line_prefix eventually comes from the "git log --graph" and
> shows the colored graph segments on the same output line as the
> diffstat.
>
> This patch is probably not making anything worse, but by leaving it
> strlen(), it is likely overcounting the width of it.  We can
> presumably use utf8_strnwidth() that can optionally be told to be
> aware of the ANSI color sequence to count its width correctly to fix
> it.

[]
> This is the other remaining bug.

[]

> I think the remainder of the patch I did not quote looked quite
> straight-forward and correct.
>
> Thanks for working on this topic.

How should we proceed here ?
This patch fixes one, and only one, reported bug,
which is now verfied by a test case using unicode instead of ASCII.
Fixing additional bugs in diff.c (or anywhere else) had never been
part of this.

Things that needs more fixing and cleanups had been layed out as the
result of a review, that is good.

"git log --graph" was mentioned.
Do we have test cases, that test this ?
How easy are they converted into unicode instead of ASCII ?

I am not even sure, if I ever used "git log --graph" myself.
Digging further here, is somewhat out of my scope.
At least for the moment.





