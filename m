Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A012C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 23:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjAMXER (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjAMXEP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 18:04:15 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB27F461
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673651039; bh=LZ6+ub8VYlY3l896uonP1vMabsjfIjWBiU9gwY1KlpY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ee1QaImUhiuTmhOLTYhPI3P5FmZKjk4a+AkqZRSKBn23vDakCH9WTiEDkQQ1Z6zY3
         OqgEtWwHBrBgrlKWM/mzAY2GdFFpGqWzKgJmWpxaOnGqU6XNO8DKNeIRfwjRDaBkUL
         0DOpvotbeZXsflhPBWonjP0r9F5qDn3yfFmmfKv0yFNae3b/g3/97S+uGn8Y4CxGSx
         zWAIfySCs7UAb6iIszYWfoJROTIfOaKb20fRbYAwgvX/oy6JhhnvXiv8fJrDL6CG48
         2Ehn4Cdb6hKiGOkHaMiuN2wscrzLLVn3Fr47fH/5uPLY65qdsrqog3/ul1dnsP/dLT
         gu42fZ66F/b9g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.69]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS17v-1pA2tQ1ZzX-00TYjW; Sat, 14
 Jan 2023 00:03:59 +0100
Message-ID: <e9913631-0534-ce47-ed73-2caff0f9d04a@web.de>
Date:   Sat, 14 Jan 2023 00:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: BUG: git grep behave oddly with alternatives
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Marco Nenciarini <marco.nenciarini@enterprisedb.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
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
 <230113.86ilhazved.gmgdl@evledraar.gmail.com>
 <5f6908c8-3f84-92a3-b9d1-8689c500c1e9@web.de>
In-Reply-To: <5f6908c8-3f84-92a3-b9d1-8689c500c1e9@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zYoGq7yOMHvxqDTvfKgN6FIMT4tMDwMLa3Pf8wehO1gGq1vMFSU
 odjHoF+QI7y29AAZLKXctUSSJ0f0Q3+xSx9vvVqoZOeLBOjzznX+5Cm49gc4vom9sJxuBSa
 f5ZgElBTAYYeFHcRi7hnznCmCVRa5fG4yN2wf0W0VOD1cIGRleZthP1po66t4EffmMD088R
 RrioN/CQZVnOp6n0JYggQ==
UI-OutboundReport: notjunk:1;M01:P0:yu4iGkmqZng=;uRta2jtzvtgxWYtVG9seND1d3XW
 o93TxCZ7wDAprdy0Oo6OK0LezjQHzOauU77gcfFZgWQ4Wpt1MUnokwPDHf3Xus8vy7RMldLFl
 hLAcd6KDUf3HTbAyhiC+vIcYPPb68qw0aA6/Y0Rpya4iGAP2R+08yTmFG97cwsH2AwmicuqMz
 lI/2e2E0MuCNKqhdM6UJuxJpNP7KVZ3AYxi9PkJicHbA0SOhH+hG5otgyOrUmknwddQRvyWkK
 0gpoAIIU9t6YkgEyX1ctUbWgwqA07BOaCJIp0Qiw3jU2ptJSFdoS6yYxWnxRZ4mTOy0x4DtNE
 VCV87fflSF3Vzvx6Jo0rYFvjVZAUgbDxZtzvgeShHaMcrDTtX8pIQhE7cNSasBLmx0emROvnL
 f3ZfxjNE86+gbtQNAjUJlWuuNpuqoKrXNKOnkneo59WyY6s1Q1n01dUPD4/+G6vWktaJSl4R6
 hnMELfmXZS3AX+SmMSek29i+dqv0qFJdzi0mGj1ugCgBv5FzGYkKecA9M7y2t4pgB/BrDdSQN
 lz/pcH356GJc4Jyd7ItYZt8rQmcIyFH+ZKDkSaPqiJLGyAmo2qnu1/+asFO/vhTHxNt8ApYsa
 crpngDQOqzEfRgkX2Rfs+behsNmQnHQhq4vWKUWRwHA2hQ3WJJoO4P5iEsy1NGihzWGoFFSzL
 eX3GcnNKhLfTbb7kOS0qMmLfI3e2RTqgjwmdJ0QCIMKB/2ZfswgBD8Lipmblyq/nSH/4qJqj5
 l4PR1y+Yy9wHklklW7UfCinHmjn5htr9bSRUKPC3bP3POr8aflaxCR0VJLliIs9IosddEco31
 xDwK9uTN+LxJPASpqZR1F+FUBobweH+hQU5WCQculIvPiDTbY+s4yf+pGVWDrO+04xNPM1c/y
 3rIJcKsKxNpMY3d6Fm1ezzPYZmJx2CYyM6yiIGyHZVGw03Y6Qp8h+r16pHSJ4tOlfnO48ijkK
 hpgt4ZyuqVoANtajZBZNZaxM//c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.23 um 18:24 schrieb Ren=C3=A9 Scharfe:
> Am 13.01.23 um 09:28 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> - Just mandate PCRE for Mac OS, then map -E to -P. We could do this wit=
h
>>   the pcre2convert() API and PCRE2_CONVERT_POSIX_EXTENDED flag,
>>   i.e. PCRE's own "translate this to ERE".
>>
>>   But Perl/PCRE syntax is already a superset of ERE syntax, minus thing=
s
>>   like (*VERB), (?: etc., which people are unlikely to write without
>>   intending to get the PCRE semantics.
>
> PCRE2_CONVERT_POSIX_EXTENDED is a flag for pcre2_pattern_convert(),
> which allows converting an ERE into a PCRE2 regex
> (https://pcre.org/current/doc/html/pcre2convert.html).  So this feature
> allows using PCRE for every kind of regexes, right?
>
> There may be feature differences for EREs between libc on macOS, glibc
> and/or GAWK, but I'm not aware of any complaints so far.  So I currently
> don't see the need for that.

Thought that maybe this could help us matching NUL characters and fix the
TODO in t7815, because PCRE2 can handle binary files just fine.  But no:
pcre2_pattern_convert() uses (NUL*) in its result, meaning that NUL is
treated as a line separator and . (dot) won't match it.  And it's still
experimental according to the documentation link I mentioned above.

Ren=C3=A9
