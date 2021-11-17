Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF81C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA41060E53
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhKQStg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:49:36 -0500
Received: from mout.web.de ([212.227.15.14]:56097 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240176AbhKQStf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 13:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637174780;
        bh=/feeNcxENqhUQZEFr35P/3PN+xFAx+wI5E6FGAFw+T4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=joJ3POSHUvK0Z4b8/UCtB3/m1PjqU/SEyX7aRyg9Sf1D2e8PR5vCp3JyL3+LtqkIv
         PPKzcGLyLXMkzZhc3cg6IwuKsjNvdv7wEEbXxM9o26Bp1+E93+LHfQ7IpZCIfY+DN6
         6LqBDrmIkSsIErVtzqECxkRsEh+1gL4G4X4CLKmw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1mpsv90ArD-003F5Q; Wed, 17
 Nov 2021 19:46:20 +0100
Message-ID: <634c4237-325a-13e8-0a92-09d23bdfb111@web.de>
Date:   Wed, 17 Nov 2021 19:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v13 3/3] grep/pcre2: fix an edge case concerning ascii
 patterns and UTF-8 data
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hamza Mahfooz <someguy@effective-light.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20211015161356.3372-1-someguy@effective-light.com>
 <20211015161356.3372-3-someguy@effective-light.com>
 <877dd9i1zj.fsf@igel.home> <211115.86fsrxqbvp.gmgdl@evledraar.gmail.com>
 <87o86kv6fh.fsf@igel.home>
 <CAPUEspi=r9EsG8KPvdiD-HM7Drq8ho1yjkN_c_T1e+ZeR4eejg@mail.gmail.com>
 <87fsrwv46h.fsf@igel.home>
 <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPUEspg8ZUdn+KFz35yG1k9bbfVTe1b+7=+WdMknRS1zu8VcDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GkDVQERBEufuZ0lb4rfnslaX7dk1BurIzAUJIMsKAmlp2vzhxf3
 54j6LxOF4pVardE2U74PgYASTg6MVVYG3kGofs1oh1SNRhmX1duoNWwh5nwKWSb0Ro8nvVT
 AbF8qdFgmQuTwjAU99bSPU7gYqzz0ozE5FAWUJ+3DlCvOqE4/cv7qVRe2L7IM8R6E986s9M
 06nHTBJzGDehmuj5ryNiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XlAtho/Rxew=:QTIZwkLixfPhMcP6IljjOr
 Rol2KCEDMvD2O08XQQBR4dz89HoQM1SByAemXzbnPMEHRu2FmPBh7JoT0fc+49HqrKQUPMPgF
 kgCptnunbUuOs5w8zhuf4QDWnSkpJxUdbG1nMf4TuADKq/phNbegKYI/q2AdpqjArDJZmNfsg
 HZbuRXGFRhRGVVLxepeN3dFURPNt3y2c9MRNUzURVXmIcmFgbC3nYl9cXhtkqFXslJak0GWA3
 Vy1rgfejAxWPXhAF3SYMVTMdSwJWAlK022QwvKhEUAapa6KQcyZExTDQLrcMuUpWwbSFdfnQB
 HilINdoHpU7dLeTlCxSpB5CrC1dkg4rvkSGyoF3jhxVTuMjw0cgmsIRrG1sEf1MRiDNljbWuW
 Cr9TFkoT1oJfBzxaBM9MwH3VX1Otsz2FBrwbaQ6ktcKmvc2L40+W6rZ01dj60Ez1FwdvTNOvD
 qSfiOJTg8k2BAMkQpFR4WjeeBP0MzGVXBgdZecfuRJ63sW7qhPcqrh12lVR/GW4V4yVCZnn6C
 gOeA25LPX67xDqqwR/uTmGYfEIVbCFlkbeIs4kRRNAAFAtpl+PrPkSIknEM0lryzR4Q35WZ4D
 DP9m7OdmPCL4geFHkiJSwmbpoCecqaOioxU/mOYaQsE0OFbhCVciiR+yYzU1k1Noie2DVWaKz
 SprU5GD9WHwZVzfjkA0nC6N4CiiHgnASDf729LjcSdX2OxcTu0zMO/EQ6J1faMT3FO1NUbqI3
 Q6YyJh78oPrB3fKPTz3PeTFMlBAQroLQlOFmrkvHMrXuRS6N0uBFKcKoyq2Ins50NTwKk4KK5
 OJAPrv2NyAak9G4APzwvIBZU00g7hlOakrJEIUHgFCcFjjt+5E21zRKRsGUu4MfCsDs7LocDO
 VrlnX5RvTyk7y+AGAwP08Su58NAFPkYij0TG5AOIrdju4GHatOBSajnoTenIoOvx7UrxTyL5H
 kJTcoytiVt/cW2o3doB1URXJie4Eh1ZPxs+L5KVy3JnRfnXNts8FlJ5yOG2iuPTmfxHQBiOk1
 6zC+xoVbjQRzB0ye4KqY6PMqPCRLxjcV0Gn5h9TVvk710DQCwlTWLouZW95EOfgyRQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.11.21 um 10:38 schrieb Carlo Arenas:
> On Tue, Nov 16, 2021 at 1:30 AM Andreas Schwab <schwab@linux-m68k.org> w=
rote:
>>
>> expecting success of 7812.13 'PCRE v2: grep ASCII from invalid UTF-8 da=
ta':
>>         git grep -h "var" invalid-0x80 >actual &&
>>         test_cmp expected actual &&
>>         git grep -h "(*NO_JIT)var" invalid-0x80 >actual &&
>>         test_cmp expected actual
>>
>> ++ git grep -h var invalid-0x80
>> ++ test_cmp expected actual
>> ++ test 2 -ne 2
>> ++ eval 'diff -u' '"$@"'
>> +++ diff -u expected actual
>> ++ git grep -h '(*NO_JIT)var' invalid-0x80
>> fatal: pcre2_match failed with error code -22: UTF-8 error: isolated by=
te with 0x80 bit set
>
> That is exactly what I was worried about, this is not failing one
> test, but making `git grep` unusable in any repository that has any
> binary files that might be reachable by it, and it is likely affecting
> anyone using PCRE older than 10.34

Let's have a look at the map.  Here are the differences between the
versions regarding use of PCRE2_UTF:

o: opt->ignore_locale
h: has_non_ascii(p->pattern)
i: is_utf8_locale()
l: !opt->ignore_case && (p->fixed || p->is_fixed)

o h i l master hamza rene2
0 0 0 0      0     1     0
0 0 0 1      0     1     0
0 0 1 0      0     1     1
0 0 1 1      0     1     0  <=3D=3D 7812.13, confirmed using fprint() debu=
gging

So http://public-inbox.org/git/0ea73e7a-6d43-e223-ab2e-24c684102856@web.de=
/
should not have this breakage, because it doesn't enable PCRE2_UTF for
literal patterns.

Ren=C3=A9
