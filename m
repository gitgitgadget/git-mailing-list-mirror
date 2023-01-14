Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B0BC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 08:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjANIcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 03:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjANIcD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 03:32:03 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3B59C4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 00:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673685106; bh=BNhQBD/wsqWO3UadfPhc+q62mcIENy/fJ6JbUfn3DMk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=cc/lSso0IxMtyACheYa+jPalERJ+IFgOBLEek4ptqd4U8+NUmAwiI19eYLO1JqM01
         +4tsuftjwyQl841imi1lvyVg0NOQ9JywB44AQqwWpuPPzzIh1PrMkHZORQsq/hjygh
         Brnz4C6mw2awo7JBeOnhIKaEZFg42/wnq2O2piM+zYfB+22Km3UbnqoCg4mnF1i3zQ
         zqNYGaSTAz91jp8UMDCmq4nkWQSOc0wqYpegC7gehQKDcNvib9Pwwe57n6A9ain4+S
         IeIAiLeO55qet4kZCyv1RrRSq7YZhBTqBB596PhjhbwR5XYfoi0XqDv2myCARFDfXg
         CuaTZALXU307g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrOdp-1ovZ8H0LtH-00oTos; Sat, 14
 Jan 2023 09:31:46 +0100
Message-ID: <b2e597aa-044d-e136-43b9-afc84a1e3794@web.de>
Date:   Sat, 14 Jan 2023 09:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Diomidis Spinellis <dds@aueb.gr>
References: <f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterprisedb.com>
 <634f47a8-b370-81cb-00e7-d93ffc7534a8@web.de>
 <1f61b660-b2d0-ba93-3182-05a9ab97b00e@enterprisedb.com>
 <343a891e-d737-0ace-26a9-3839d3bd5583@web.de>
 <Y7Uu35HwUx2EVfAg@coredump.intra.peff.net>
 <e5165840-331c-e9b6-b45f-62abab860d79@web.de>
 <Y7flVcALZQgz0VPl@coredump.intra.peff.net>
 <26a0d4ca-3d97-ace4-1a1f-92b1ee6715a6@web.de>
 <Y78GXZvyrOrXhe7n@coredump.intra.peff.net>
 <4165031d-e7f1-0477-2245-6a8e312de522@web.de>
 <Y8CBrtmL45tA/N8z@coredump.intra.peff.net>
 <230113.86ilhazved.gmgdl@evledraar.gmail.com> <xmqq5yda5p4l.fsf@gitster.g>
 <0e25e6b0-2eb8-40ee-7999-f2863a545a15@web.de>
In-Reply-To: <0e25e6b0-2eb8-40ee-7999-f2863a545a15@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C3k4NeiEawRMC3+WiYEookrDchiJlC9LPiBVW9ZnI/KT1FFAm5x
 zLGxkf8ldXdM3lLt8xDqmROj0zPqxBCV8f3ZZxyDy/ehVE/F88nPkXMVH+F2zkwBmcRgG4y
 o70H6lyREhWb+a7DVLPmbFrJuAv8oEjoepBDO9ONxLEIRz0LgmM0qHDIndFLhFFCElocIdh
 ulYnSMs68gU/nz71xloTg==
UI-OutboundReport: notjunk:1;M01:P0:G4Jn8ARPbe8=;8LE++muyaN+XoDv8RV56JLYIWTL
 QSTtzY2ZZq1XWe2NXjexQ75syEFvrNAcnB+6CSZfdFx+NsQEb4E/CxcAuBKL4UnT5efDCByo2
 8xpH5wWfJQXusjQ68FzApBwG+XRRldDSgVHLiKH4eJRUp/QT5RL/K/SdbXEs7fdP7SBK2bDnu
 RIW+WLW1xokLntcAvWyjhhG3MN1hzqsS+fPln25PhgyBu2r+4oQRBDzdVGUmlOeQn1Y4uHpke
 iH8rx0RZTr96WyGJwwC9LjWaS1wnotn46ra4c6xQ1Y2gQipDiuzZwV6FG0Jori3+tjqFTxVbZ
 QSXFf43D2XKaQIccIs60S8jTXmkKdBkCPInNRxWPZXAUYxgW4VGza7Gcrva8GzTzjIsJfGYyC
 YjlEFQ92Ae/KjIgFPOPjQG9EtMq6AXESRP6UDUIA+RxrMZJoUyIDa0in/7/RvCykLhmhPWQMl
 IK5KbPK/jJ2U78nGY/oSSUUnOaO/bjSEK/q9SrHVH5S3XEeTUJl6TD88IEm/QkNr2d9Zp2b3e
 78Gx82oVcX38V4Wehjx8mKrPt0hngFPmPyFkKs6k+1OEjjn1BYVMVves/SXWi0PxH57P2e9vB
 MAtXZg7vsdm9HBGhJWPJWyzFF9ogDDzy1xtNTPQn+97dqpTib8hfcKB+u+oiPnN8AXzgQpeHb
 6bHt3kktwxxYu7R0jxQn85A3qaRNDvXsnAyAPMVCjf3iJr+c0CTih3Sg26ikVdAEVSVx4nxHb
 2yG/8RSgmGJ4Bpt5Yqz+MospR9y1kh8hRgCdbjHNO00bMwetUDVqjynbYo1K09ZqUFOHItqbl
 l30iyNP9Uj8umlKEZ4la7MPEnTCYYovjHKEfX3xX2vCYdrEx82FVohMtp3CGrDiZ4p8Z8nv0L
 myA0xpeQYLoIxe6e/0ie/Ujpd56DtmWektQU1f7wrBuWW1NnxTAxPVBP12rtBlLrnbU3FJROJ
 /2fNGw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.01.23 um 07:44 schrieb Ren=C3=A9 Scharfe:
> Am 13.01.23 um 18:19 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Jan 12 2023, Jeff King wrote:
>>>
>>>> So it does seem like all bets are off for what people can and should
>>>> expect here. Which isn't to say we should make things worse. I mostly
>>>> wondered if REG_ENHANCED might take us closer to what glibc was doing=
 by
>>>> default, but it doesn't seem like it.
>>
>> I thought that Ren=C3=A9's "Use enhanced only when doing BRE" was fairl=
y
>> focused, but I am very tempted to accept ...
>>
>>> There's a couple of ways out of this that I don't see in this thread:
>>>
>>> - Declare it not a problem: We have -G, -E and -P to map to BRE, ERE a=
nd
>>>   PCRE. One view is to say the first two must match POSIX, another is
>>>   tha whatever the platform thinks they should do is how they should
>>>   act.
>>
>> ... this view.  The story "BRE and ERE work via what system
>> libraries provide, and 'git grep' matches what system grep' does" is
>> an easy to understand view.
>
> That was my stance in my first reply as well.  But 3632cfc248 (Use
> compatibility regex library for OSX/Darwin, 2008-09-07) explicitly
> added alternation support for BREs on macOS, and 1819ad327b (grep: fix
> multibyte regex handling under macOS, 2022-08-26) removed it seemingly
> by accident.  And grep(1) does support them on macOS 13.1:
>
>    $ uname -rs
>    Darwin 22.2.0
>    $ which grep
>    /usr/bin/grep
>    $ grep --version
>    grep (BSD grep, GNU compatible) 2.6.0-FreeBSD
>    $ grep '\(REG_STARTEND\|NeededForASAN\)' Makefile
>    # Define NO_REGEX if your C library lacks regex support with REG_STAR=
TEND
>    NO_REGEX =3D NeededForASAN

And I neglected to copy the author of 1819ad327b until now. :-|

@Diomidis: Here's a link to the start of this thread:
https://lore.kernel.org/git/f82ae28a-fb56-8d1f-96c8-550b61439d3a@enterpris=
edb.com/

Ren=C3=A9
