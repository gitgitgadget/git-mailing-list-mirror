Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D5AC35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1033621741
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 16:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EZUdlpV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBEQrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:47:08 -0500
Received: from mout.web.de ([212.227.17.11]:40735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBEQrI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 11:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580921223;
        bh=f1nrZR+s+k5ZS/7j3HBk/wyAL47q7cetpMCWG1jKQ8s=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EZUdlpV536lNUjTMKgMGwSZc+mzKU8jnl/493t6fXR00XRsf1SOwFCxmRVu1AWP7P
         oF8ews0shj2yDD/ZKKCgBIzfzoXGlGDOC5Av15cZpVr3MCyUxMUuz+FIXd0STgqLZD
         4p3y8qMrd16vlbcQ7g5/FNYoB0MvitEaboFh0qa4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1j2Zml0JkC-00Y6CC; Wed, 05
 Feb 2020 17:47:03 +0100
Subject: Re: [PATCH 01/10] name-rev: rewrite create_or_update_name()
To:     Andrei Rybak <rybak.a.v@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <b8f6a47e-1cbe-b2c7-cdde-ff2dc28af2b2@web.de>
 <f8b7102a-ecab-1980-c129-ad00f3467655@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b983507b-40c2-dd14-9c5e-506f9be8a2e6@web.de>
Date:   Wed, 5 Feb 2020 17:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f8b7102a-ecab-1980-c129-ad00f3467655@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RyEmNEFood3uPiEl7F7NpSciF2PhuTU8loJEbfGxwLpxrJyA+ym
 2kS0Ekv/9Xya0jbIhp05lTh9w2hAXsCVgE8G2sJMntdGwJoF8Vn01w7sAVcGLd0BKryg8Rg
 odVqAtLjdmP0e3tDywgVFYMLkf9zxiYmy3mXDSzsgQnsJL6Co6Y9kgl502UIY02qCxlh0fw
 xBDzHiR4GHHCh9apZWmCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PphzMRT2Vyw=:X7E9FUMluUpBrPOcO/aT2V
 WvDJ2wlpTj8zgnzc0o4MpF8Z6zveke95CQZk31Vu2i5ganQR6lh3lkep8wp8UR1PdNOV6KoJb
 aY0QqtsNlSoRcAy7Y0063SwEKkVhf9fTxSN0yoXw0Bj488BUHLQsLE+b7hWTWH4KEJbqt17ui
 +tDJcZ2mFQGL54G2fc2mFy/rm9G/VMKydjDbpCucNaagc5G3hU+qDR7uQInsmdqNnJWCtqwo+
 LP4Ivz7o9hNq1vqVrfr0q4PEErlGVXq+JdbK97ZKHNqOq03F+AesjU6jT6+MisjqMrhXv9CXq
 x+z7m5l2Tc9Fl6aNTrwnq/TdXqD2o7negG/PaML4UBv+ucbnu3/fsrTtE1YAibNrrZhVumTws
 l6jNZywU18wkbqde18aV2PEgbUDj6FTBbCtQSv8iiBHxONOYqXW5GbUFp+DpMZvUz1lygPXyx
 pukD/U83IYSK9quEHP2I7G5bNscP+fJpajOBDfZhT1q5kbAJjP+xNy77zJQKIaVV+DnUKv7AY
 tX+VU+AqTspTARHudZHob55ulP6cJvxQ42HwEeF4Vc2AHPJnIw7JWBqG06H4WQ3Z4Au5oOqTo
 3KBLYTxs66pQQ6jes14YxDrRGvvpN0eCPEBD7f4vraDauboEi/BaR12lQjzfYnpTsG65EhxBg
 fAtY487AfRk8eOIoBLxz1p/xxzMsHKcjtil8KAT8sFxQgneaAZPZNeNZXgtxsxGWNyFdTTm1j
 D/M94mSDbNBfSLvDhUuL4qwWI6tmWbpAKyL8fCh/KqB07D17TfFuX1ALDHdAnHFKeEGnC62GV
 3QluxzWC2qpnon99QSb9f5lc/6bSwqy7LJUDIM8oiTWOMLb9S/gp7ubwAGm9GDdV0eHnEDVVG
 ACI4ava2UmxIdWpL5OnVlchabE0wZ7FrWrTt//pndR1dse6i3jjInYftpVZxhmY3a9f64+H5J
 KPou2pbXzIFboWDwRf7bCzsjUURv5pfahZ1spDCpaYsyAul7/pyXu8jIL4WZGZBIaJXzljlaO
 vutk0oNgjZ9g0iPdjK8GlU3tXiE8OIQbTut2WlTASxRj9Zvu6R86Jsey63ZWIlUGfcp+wibtA
 r6lCaE/PEkA5eZhGMes5HZSGUS4WNgKwQ5P2sgvpdTCfVSS07ac6CS4nNE1IuteVvaiMgpevS
 UtE3sEz559veIZ+sKiiK5I5WsCmhvTzg6/Dz0Cdciua5joEQVBuyBVOmc2spDZTYtvuxem8rA
 PjO4nlBXlcAWaPvBl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.02.20 um 17:45 schrieb Andrei Rybak:
> Hi Ren=C3=A9,
>
> On 2020-02-04 22:14, Ren=C3=A9 Scharfe wrote:
>> This code was moved straight out of name_rev(). As such, we inherited
>> the "goto" to jump from an if into an else-if. We also inherited the
>> fact that "nothing to do -- return NULL" is handled last.
>>
>> Rewrite the function to first handle the "nothing to do" case. Then we
>> can handle the conditional allocation early before going on to populate
>> the struct. No need for goto-ing.
>>
>> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
>> ---
>> Original submission:
>> https://lore.kernel.org/git/20190922081846.14452-1-martin.agren@gmail.c=
om/
>
> Judging by this sign-off, link to Martin's email, and shortlog from the =
cover letter ...
>
>> Martin =C3=85gren (1):
>>   name-rev: rewrite create_or_update_name()
>
> ... it seems that "From: Martin =C3=85gren <martin.agren@gmail.com>" is =
missing.

Yes, indeed.  Sorry for that. :(

Ren=C3=A9

