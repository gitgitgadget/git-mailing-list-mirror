Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A1FC76196
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjDGHtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjDGHtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:49:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45955FDB
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1680853752; i=l.s.r@web.de;
        bh=86J3+U7OdJF7fqc2fUs9M4lulY4sBJvOkhwjpmpnsMo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ni7LWHkgAMgCsyE/Z0tN4yUGgzVRVGG82caFBa5AXwsw4BG573puN1hvMHiHmBYW3
         8TntXyB2vO+YPq1UV5vwbCJw2JqFM27ohXFZXMa2j/39a0G0kTKIc0N0Wk7N9SbJJ2
         D/t9q5bTaxv+35TITWVmZMrjsvGp4bl77XFTDPw/itZWjgzYD+L9lshzujEJx7PeIV
         aEzHJNHcN9/RtA/woFqMXTmA3n98R6Z+uxvptap8Ch+Pb1PR6/H4LmIhJClWUaLWjR
         WOacNMqJQ1AXehcMV0qJKR++UDVP5Et16N1LD0BbF2om4InleviSfRxOmtTKxHPVo8
         KKv80z9ynkSlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1pilhQ484F-001nuj; Fri, 07
 Apr 2023 09:49:12 +0200
Message-ID: <39eb2a9f-83e0-449e-1157-152c43d49b48@web.de>
Date:   Fri, 7 Apr 2023 09:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] userdiff: support regexec(3) with multi-byte support
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>, Diomidis Spinellis <dds@aueb.gr>,
        Eric Sunshine <sunshine@sunshineco.com>,
        demerphq <demerphq@gmail.com>,
        Mario Grgic <mario_grgic@hotmail.com>,
        "D. Ben Knoble" <ben.knoble@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CAPig+cSNmws2b7f7aRA2C56kvQYG3w_g+KhYdqhtmf+XhtAMhQ@mail.gmail.com>
 <b45bf46f-580a-870c-5293-10ecdf2e56d3@aueb.gr>
 <b8b3777b-ee6e-d90e-3365-5cb9c9d129fe@web.de>
 <c4728fac-bea9-3794-077e-c978d99f46bf@web.de> <xmqq5yad7wv3.fsf@gitster.g>
 <bc6e89c9-d886-c519-85b3-fbc3f4eb5528@web.de>
 <7327ac06-d5da-ec53-543e-78e7729e78bb@web.de>
 <7fe0aa93-a764-66b0-5015-2f5fbd3901ab@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7fe0aa93-a764-66b0-5015-2f5fbd3901ab@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4N8cRyWy+cm5SWqV4qdmQol8ayN8zDj8MOJF4IEJbUt4b5y77zd
 TypPeVVKirGLfpVq3aEqkAh1754dhW9X6mk/CoCjG0B94GxNo/CmT0BAgOmYQ+rbpoEkewt
 1Xyu6AADRl4OdxV62oVEjrHqzOVCs9yU+sT08plq+4O1tViwL20ZN5iZ/K/NLQRaXXQEH1c
 GuiQa4a7I7Pr3rbJNJ5Uw==
UI-OutboundReport: notjunk:1;M01:P0:Leg7TXsTMd8=;Xmt/PkDlN/6mrJJ7Ks7ZocR6LZl
 671jSWbBi9OERDyTLfowUkXwKtxrEJ5kes5l9Y8o+Myv46Timr50XModoYH9tM0CgkNZHpfQJ
 /Znk5hOolxI+7ozULRYG2Mq8lVE77URYiCw6FD9agVT3mubDysxPos+SvptlLAZu5W2Dv996+
 0WYJF+5NavDHrqcZTW2atQ3yyRqFKL7rWd6dn76UiwmrYnGsh2kVPXycpZu2yToGTKspYbMol
 SNSOX8oxRn8/nDqEYc+Au3jKtjMJZWyd+NNkeXM05DmmbtWg1mIBI6gROO47QRVCplBoDMOjq
 qGdEub4jpTcsj3cnyC89NOC6qNTdKPnc7I/TF1D0lHJ3Ez3bhph/fD/kRp+UENyzS3KWqQQZy
 cL2CfdbEmN6ASHHHZaeEYCenNC4vhcGT4FX1kUoi0uznlocLpeP1pAp0/vh6kwjaL6iakAu73
 jri10M2dfIPIQzW/oTtOeg6sB+i9JFD2x9pEYBQox8P/fjDgpDRzG2ZGTtEyh0a3I/HmR3Jy+
 nO6+99Wo+NsMlBtL8rM2FIQL/WofF4Hezy7kc/0Lah/cONZ4Qk6SdO8Sn7QPjIUhdPiLtF1Uc
 gPtpp+a75h2rlEz3v2Sa5YnFeEgnC6CYodc/4j7LD1OpjBgMWp46TEvPrqrYahC21I5QQ40jr
 onEGAWricDCnb8lEd/U8ndpjCkik4L8yzP/FxodQBkcaspto4/VTL2RWmcvJVBRfg5UTH6mBh
 woHggha3l811qHvgLfec9jRqNM+U9oKyEiIqSRu27QAeO/6XdvxF+b+vwQawrcXRwmeQSfERp
 QUujonsh+aT9I3ZomnS7I+2COxGHg6vftpwGLHdG+oRi67LzZplLGwTeGv5iWa8PbQEAwzCZS
 q/i9ZHVg1OpjZy+TOtieGNMAsow5URVi8ez3lXmyXj261oivgpr/RvP7XKGjIYlO1XJ+cmaj3
 btVkRg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.04.23 um 00:35 schrieb Johannes Sixt:
> Am 06.04.23 um 22:19 schrieb Ren=C3=A9 Scharfe:
>> Since 1819ad327b (grep: fix multibyte regex handling under macOS,
>> 2022-08-26) we use the system library for all regular expression
>> matching on macOS, not just for git grep.  It supports multi-byte
>> strings and rejects invalid multi-byte characters.
>>
>> This broke all built-in userdiff word regexes in UTF-8 locales because
>> they all include such invalid bytes in expressions that are intended to
>> match multi-byte characters without explicit support for that from the
>> regex engine.
>>
>> "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" is added to all built-in word
>> regexes to match a single non-space or multi-byte character.  The \xNN
>> characters are invalid if interpreted as UTF-8 because they have their
>> high bit set, which indicates they are part of a multi-byte character,
>> but they are surrounded by single-byte characters.
>
> Perhpas the expression should be "[\xc4\x80-\xf7\xbf\xbf\xbf]+", i.e.,
> sequences of code points U+0080 to U+10FFFF?

regcomp(3) on macOS doesn't like it:

fatal: invalid regular expression: [a-zA-Z_][a-zA-Z0-9_]*|[0-9][0-9.]*([Ee=
][-+]?[0-9]+)?[fFlLuU]*|0[xXbB][0-9a-fA-F]+[lLuU]*|\.[0-9][0-9]*([Ee][-+]?=
[0-9]+)?[fFlL]?|[-+*/<>%&^|=3D!]=3D|--|\+\+|<<=3D?|>>=3D?|&&|\|\||::|->\*?=
|\.\*|<=3D>|[^[:space:]]|[=C4=80-????]

Looks like it objects to U+10FFFF here; "[\xc4\x80-\xf3\xa0\x80\x80]" is
accepted for example.

\xc4\x80 is U+0100, by the way; U+0080 would be \xc2\x80.  And
regcomp(3) doesn't like that either ("[\xc2\x80-\xf3\xa0\x80\x80]"):

fatal: invalid regular expression: [a-zA-Z_][a-zA-Z0-9_]*|[0-9][0-9.]*([Ee=
][-+]?[0-9]+)?[fFlLuU]*|0[xXbB][0-9a-fA-F]+[lLuU]*|\.[0-9][0-9]*([Ee][-+]?=
[0-9]+)?[fFlL]?|[-+*/<>%&^|=3D!]=3D|--|\+\+|<<=3D?|>>=3D?|&&|\|\||::|->\*?=
|\.\*|<=3D>|[^[:space:]]|[<U+0080>-=F3=A0=80=80]

>> Replace that expression with "|[^[:space:]]" if the regex engine
>> supports multi-byte matching, as there is no need to have an explicit
>> range for multi-byte characters then.
>
> This is not equivalent. The original treated a sequence of non-ASCII
> characters as a word. The new version treats each individual non-space
> character (both ASCII and non-ASCII) as a word.

I assume you mean "The original treated [a single non-space as well as]
a sequence of non-ASCII characters [making up a single multi-byte
character] as a word.".  That works as intended by 664d44ee7f (userdiff:
simplify word-diff safeguard, 2011-01-11).

The new one doesn't match multi-byte whitespace anymore.  What other
differences do they have?

Ren=C3=A9
