Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45FEC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2197613E1
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 09:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDJoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 05:44:10 -0400
Received: from mout.web.de ([212.227.17.12]:36093 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGDJoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 05:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625391684;
        bh=3gzx7r4QoV4ADiikkA9gX0VMBhUtCOwc2m7b2vg67uQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CMTXJeaz9cAXpD4sA0UyZIwTOu6ITRSHmtMu1g4BBlmGcdiLu8jJ1PHa876FOz09v
         fICPSMnMIHOQv+NKCo/kSzS71UAB6neAOjh4bYQQQJe6XxZgIMtIGiSZ7F306OTX88
         LWNPJ+1pUqfyD4cpyY1T/htmyNlpBM77Fdrzmdpo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MejmG-1lp4WK2y1w-00OE19; Sun, 04 Jul 2021 11:41:24 +0200
Subject: Re: [PATCH] khash: clarify that allocations never fail
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <d13b50fd-5944-0bbe-d28e-8232a2932598@web.de>
 <YOA+IibZw6C9mkdF@coredump.intra.peff.net>
 <87v95r8w86.fsf@evledraar.gmail.com>
 <5cc24582-ed96-453a-fbad-d3fb83c8f949@web.de>
 <YOF46CU+SSDRE51/@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b2c9b072-b2ac-625b-4f0f-9ba1ca3321d7@web.de>
Date:   Sun, 4 Jul 2021 11:41:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOF46CU+SSDRE51/@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ym/7aO+DHa7UzuOL/Vck24IA1z0ki74rCyBm7hjK35hzlcDdrVJ
 ytJ34fcqJNn/jAazXrTjUdRv7TQve5fnWne3xtsJIQQg2w0bqcM+PJX0FxA/DqWQUdV4QB3
 HkvyiALImyfMy9FgQX9dMJnl/YToEan94B4u3Tkeb0lbLZcptj7sKVlPiX2kkdEyg4RiH0N
 0V8h5OfbTz4JvOP0AmktA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n4YS+7EqrjA=:HSZdy/Qv4ikZ+5k7gSE6ov
 6ZtdIY9vxb8Q2BZFg2hiJnGhf7Ax0YWKSo8UkEaxjtj6OMs7dhytlBNvy3G0HGtE3d6sOPq3C
 GrS/wF4Hf0r85BvB4K2nmbCz8Ax5ShzHHGoGzll3Jrq4u3VFheqs/9xCpxmJ9IKULMr96CdtJ
 ZGCsCjLIuYSI2ipLhuJngUNrbCjRcs75vHWs7Ey2o86FSSBXW9ENdEeJbBM2oqyER/48O5wAs
 3mp5WWt3RWamNqhLXsn4IkO9xvM7RgTSdrtZEqF9vxBXk//SyvJDAbOdj+DTfd3kiM4tN1UMU
 9nJkIVPQXy/bHG9bK0AXf1kvViei3GYA/St/VAf1Z3bVOKtDHZ1QjOaKLTLGh1jNFIKnyjMmz
 FUwzcuEj//8Q4ubV3t0+b3k9uv6XXL0Z5Cm4S0zEAvYeRb01/hRpL1WrtAW4Kt3T38nwQ+XfU
 PF99qexEf22kz9G3O/N12J/d3ewrKwH/XXgAlv708mtxXY/Ig83g1NO9LAkA9BjuuMqGHLekR
 Z4I0wQ7z3xivp2RqVaSvbxN+OXoP6w6dWr9W7ryIdTaOfsjUq1qDQicdupFPviaIZL4oa/H5f
 /9tpJnCKfrztcRXr1yC+8VH6ULMLZH6kAuZpNVAwsNnd+mvm4FooTu8ovT2jr3Jprry3A4jTi
 Q3/phmpb2oc7X8O4CtJKqkQpbp6epHRLpKUuXJdu6WB3VSp83uvNHa61mrQH6Jfq25pDD8puS
 jm6bJlEw0dOS0BnBzlyPsyXM4a1c6c/lrfmKhnZJPAI4wvECPNDy2idx8MzfefqlpC8mksCsS
 xx9wmuL9K5fI4jhL/JmT8xHrV8qTFIQ9z5/LLriv410Lg6gS5rppKe0dJjtzuVqvCPLgmWwPx
 uJOAvdkoPZ/mWMW31zd/veNJ+x69n5CNa/s8zeAypc9iD0nLfgErm9YyZZ/v3NY7aiqL2w02n
 cvoF1PTtaZ6Kl7K3TRd/vUEOqyedZvw9PF338TRjcYwkqOwhKUufiMG/+CDJJRJrj79eKCdff
 Vya7O3ngiYjgwnQsYrS2CJbAWRhbXNFRQqBbws9Zapd8dXO/YtA9NbyIUgF3+awSuFExs8EjI
 nDoawcW9Yfd74+u/LH75H3pThCIPHnQm2GZ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.07.21 um 11:01 schrieb Jeff King:
> On Sat, Jul 03, 2021 at 02:56:50PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> The following semantic patch finds a leery xmalloc() caller in
>> compat/mmap.c, though:
>>
>> @@
>> expression PTR, SIZE, SIZE2;
>> @@
>> (
>>   PTR =3D xmalloc(SIZE);
>> |
>>   PTR =3D xcalloc(SIZE, SIZE2);
>> |
>>   PTR =3D xrealloc(SIZE);
>> |
>>   ALLOC_ARRAY(PTR, SIZE);
>> |
>>   CALLOC_ARRAY(PTR, SIZE);
>> |
>>   REALLOC_ARRAY(PTR, SIZE);
>> )
>>   if (
>> - PTR =3D=3D NULL
>> + 0
>>   ) {...}
>

Btw. the found code is:

	start =3D xmalloc(length);
	if (start =3D=3D NULL) {
		errno =3D ENOMEM;
		return MAP_FAILED;
	}

start cannot be NULL, so the check is dead code.

> IMHO that should not be using xmalloc() at all. It is a replacement for
> system mmap, which can fail with ENOMEM, and we should be able to do the
> same. Using xmalloc here is probably losing an opportunity to close
> another pack window to free up memory for a new one.

Do you mean using malloc(3) directly instead of xmalloc() would no
longer try to release pack windows?  xmalloc() hasn't done that anymore
since 9827d4c185 (packfile: drop release_pack_memory(), 2019-08-12).

xmalloc() still brings support for zero-sized allocations on platforms
whose malloc(3) doesn't like them, and it enforces GIT_ALLOC_LIMIT.
mmap() is supposed give up with EINVAL if the length is 0, so the
first feature is not actually helping.  And GIT_ALLOC_LIMIT is not
documented and only useful for testing, right?

> I doubt it matters that much in practice (most systems are not even
> compiling or using this code, and it would only matter in a tight memory
> situation). But as a general rule, I think compat/ wrappers should
> behave as much like (sensible) system equivalents as possible.

Makes sense.

Ren=C3=A9
