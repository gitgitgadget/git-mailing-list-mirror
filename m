Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622EC76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 00:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjC1ADh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 20:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC1ADf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 20:03:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2045.outbound.protection.outlook.com [40.92.43.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5D1BC7
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 17:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyxDQvxdIwMcFFtQSsHVmxiYJoFA8Qgp5QpQ1kATZ/n2Up/f9WKmJBg9977RAahObkamDYQiFg21Idc9kjmA+ZtB2EDse4avVAAOS88q+vYvkgOvj7sq7Lvw/pjAT0p5UwWjNy34bgi0hboCQ08yxRyJi3NGn5a4W/kvi1h8HlKcQ7g+Z0rwtaFFtX4RWpT1Jzz30jyoQqENF8CKbrnXusqFdg1Wds40CnSlTojeNQ+X2B06mJjLf1RY1wgvSxPi/yUvcf3+nCxO88S67DLNGDWoGao58yiQU1+ZnfFlsto3Iuy+nsj5DgnAOpMKD+oUKy/h61GYo+2900UbaBVs9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXxEHXqL6T+uXOErp+xJmp3BVH5IM1IptXguoIUOnFI=;
 b=kWRNPjdfhuXcjSIvIxq2n7OD00y44qx9rW4AsjowWzfQbFVsT80z2Fi4U5EoFf0DrmwnscF8pr6tfi3WN4H7zOMiXSP18GVWMdU29/+kASiEE0pNBFba45dt9SdAd2u4G4hHJ0a+CXTCIDFcJIiHj0HAV/Oo/lq+3f8zY/NfiaDVDskAnYiR+Kr2n5ClyBGEWDw+NhRRBN/oUb9Zo295wf1CZZM8/oyaPGdc5v1xV8q9tqBhcxJSBjg7Trxdrrii0v/V137O72kDYy7ECNOQLc9QG7QuQaz4Rbhn3ZtQwjCNW9/ID1XHOGuisVb4k2KUD7RePfE6TgbyNw0wHe/0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXxEHXqL6T+uXOErp+xJmp3BVH5IM1IptXguoIUOnFI=;
 b=si50RmZRPW442soFCfWbSDyaSGouc5f3X+HJwxLsXP3L1JKgvj3U85ui1ce3XAHieCIniIAiIeT2ENpZFilnjNY4zgUgQJ2g0O/2VjbwmAXovZHyfu2WQ0paSkxNjcZ5cQOP8Jvsqw/J5+CSWmgqSIch0cdFHmgPSxScrCYCSFIP8DCl2SkbZpH7eu2UtAl18GPqjzYfcZ++Rrs5K+3oSEkguadvW84OYISmUJS1KfWpkK2mopHGkOUx+QbzqWqNSXjxh78JMwqGb3J95uBq8qxdQveKxXMGnUNuxj9wptUK325DpDsxOPiZmk0S6uOvOYUtP3VgoGe9wZBDljB3vw==
Received: from MW4PR20MB5517.namprd20.prod.outlook.com (2603:10b6:303:22e::15)
 by MN0PR20MB4719.namprd20.prod.outlook.com (2603:10b6:208:3cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 00:03:29 +0000
Received: from MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::75f6:4d32:4ddf:6c6]) by MW4PR20MB5517.namprd20.prod.outlook.com
 ([fe80::75f6:4d32:4ddf:6c6%5]) with mapi id 15.20.6254.017; Tue, 28 Mar 2023
 00:03:29 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: git bug: Perl compatible regular expressions do not work as
 expected
From:   Mario Grgic <mario_grgic@hotmail.com>
In-Reply-To: <xmqqtty5nbm4.fsf@gitster.g>
Date:   Mon, 27 Mar 2023 20:03:26 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <MW4PR20MB5517CBF944D108A95665025A90889@MW4PR20MB5517.namprd20.prod.outlook.com>
References: <MW4PR20MB5517583CBEEF34B1E87CCF1290859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <MW4PR20MB551779102E85B305E9F675E990859@MW4PR20MB5517.namprd20.prod.outlook.com>
 <xmqqcz4ucg1w.fsf@gitster.g>
 <MW4PR20MB5517E2591A77978709695AC3908B9@MW4PR20MB5517.namprd20.prod.outlook.com>
 <xmqqtty5nbm4.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-TMN:  [paP9HV7XtfneEnOx+MUWUVuwMvB/M8/D]
X-ClientProxiedBy: YQZPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::29) To MW4PR20MB5517.namprd20.prod.outlook.com
 (2603:10b6:303:22e::15)
X-Microsoft-Original-Message-ID: <33AF2941-AD7B-49FA-9F8B-5D3F8D367B72@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR20MB5517:EE_|MN0PR20MB4719:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9e460d-b0bd-448a-10c4-08db2f1fdc93
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ryy+gK4n+4IFrhtDJHCP+ehDbPCP4W8w1jOQRoAxa3Ua9dmYlp1TxXj1oOPIiqhQoBO404I7jwtqGo8wK8senVhPOovLJTepm59J1fyw4h3xJIqz9K95uiEkTC3RTGvgEmajOf5ZljAhtgiijdi/UDS2TqyBziPlQ+GxUWtIosqqchzXQb9uJsqu5F0hlr3FFjaBAF9hn4BmCJ82/DCFEy63KgsaBPtk0VcRynn2/A4Yf9/Cd+xMpKgOzaVe4lr7+pCBTVvgUPkAdVT8cABMHAzNZ6EN7Dh6s+JZ+FJd8F0huiwUmWxrJ/V6Thp4w/NPExgFVUqxYmf0nPlGU5aDPK1ur5ENBLzZ4J65EUlOZOh3iW8apvjJFyv0swdcE8L4PfspfnbAHHpYVSSyZydQzDHE5xQ1YGL5ewMJjv/etojErfnwVTkkLAuXQKfpkr7D3uocWYqUCVjzHtN7pU3Yc8EufKS7eIa6XY8ceKUwYby1RO1bG7VDvdi/vBMCcqxCjMv3U73bcJoepqTaAxmqbLBIcZ2J1U7llfZfHhKkOG0K6n9osAWIf2SiSf4Advo7IN0AATfg4cP3dM8MCz4tkE5eFbBZziq39vF/kR0QPeM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3N6OWFRR1FiUWE1NWo2eXpHNDZtclVRRTJQNGV0Wi8xeTdYNVpaNmI1amNx?=
 =?utf-8?B?aGc1cThJOTAwZGNtcDVFZ2tKL2hLMHRGRWdhMHh6UEtnWkNJaVZmcmljTlJz?=
 =?utf-8?B?L1ZPR1JXK3FrdnpZdE5qUDJTYlR3M3JYUllFS2I3b0VqMklVVVZkNldLQnRE?=
 =?utf-8?B?WW5MYVhIWTI4ZlBhT21IU0hkTmc1bTdhYXhRa0hxdkg5d05SaUhRYjJWOUt1?=
 =?utf-8?B?SGc5SXpRSDFZb3o0YjJZZ3ZEbWVQS0ZqdzVtNlBUNzBLcUxUTTRsUzlOODBk?=
 =?utf-8?B?RkpUSUcyd0Q4Rkp2T29PNlkyV2FQN2FwQTN5dFlxN053T05QU2VYTTBFVC8r?=
 =?utf-8?B?UmhPMjlVZlNRMXZsQ3NrWGtFVWthREo5bzQ4NE5iZEM5RlBsSTlJazc1dWJG?=
 =?utf-8?B?K25oTGFBWUtOTG5NbllQT2NFOTFUaGRGVWg3Rkp0ZmphaW5kWkdwc0Y4dGVr?=
 =?utf-8?B?dldRTFNYME1YTDQveXF4VkFTRzlFWWd2UWNhYUw5UWY2SGdXc3A4bG5Pb1Ns?=
 =?utf-8?B?Zzg2TjMyUkxsWVYvN3JhYnBFSnJ4UGJWVlg3eCtUSWlieXMwaUlSY1Nlc3lR?=
 =?utf-8?B?eHMxN1pxS0tBVW41ZWVKUkpMSWZNWWNQR08zcVJXcndhVGozNkh6WUdpM1BQ?=
 =?utf-8?B?NVpKTmJYUFlyTFdDdFZnZHZBWjhjUWxFdkoxVUpSWWNxQnNmM1hOT2NUSzNY?=
 =?utf-8?B?SHd6S1JLWmVkU25pNmtMZzh6cSt0c2duaG5TTUF4RnpiT3pya1NobDd4Y1RF?=
 =?utf-8?B?aGdQWlJkK1RkQVJlVmZDSnlZTEJRc2h1Y2Ewcm5namdoYzdzQVdUWkxUaFdl?=
 =?utf-8?B?ZjhZa1JTNDg0NWJBWVVoQnpJZGcvOXZIN01oZ1czdVR3dHJQVDYwUkVVa25s?=
 =?utf-8?B?aVJRK2dsL0FBWE1sTG00aUNBTmxSOE55emVSRm02N01LczgveWU4WDFmcUFv?=
 =?utf-8?B?b2dUN3dNbDZha1lyZHJqSCtFV1Z3OHpOYVQwWWZjY0F0Uy9kSDFHWnVSVWpP?=
 =?utf-8?B?L3BZQVoycUw3dERMQW5wOXF4b2VKd21kUEd5QXptNjJrYU1VT1cyYzF2Tm01?=
 =?utf-8?B?bVowTzZDT1RTSVJyd241OEVpaEdsRVBIQzhIZ0ZaZFBBOHowMlZPSTJxeGd4?=
 =?utf-8?B?U2xsV0tER3lJWElENTJsaElnK2VvbzJwem12eU9sYk5kV3dHVDdSdy9qdTQ3?=
 =?utf-8?B?ZXVRU09MenRZOXErTm9KVGg4TkpZUTk0Y0NkR0EvdjVHWUlRWWZKcDEwOEJZ?=
 =?utf-8?B?bWRGM2hlYSs3aU9qQmx3VXZvbUZMb3BqVEtFdXRZSEpUK1djUlNPOEZVZjQw?=
 =?utf-8?B?K3FSVlNUa1kzcXNJbUZPRkhmWHFHbUxDNkgzTDhxYzhIaTU4MmNGK3R4VHN2?=
 =?utf-8?B?dGJKVnBnb3dkMEpyVWRtN2JLWGV6SXlpSjF6QW41U2JoZlk4bUt5ZXl6dGRY?=
 =?utf-8?B?cEwxbHZqMHJROXFrQ0tLcjZBMUgxeFJDV0J2aXMvWlEvMHJwT0hLbHRvczAz?=
 =?utf-8?B?aW1PL2R1M2dOTWFaTzBnOGl2a3FGbnQ1MGN2a3BnOTFsV1YwSXRmVUd2YmY0?=
 =?utf-8?B?MU5FcGZkdGpuZS8wZFZnVS9zVi9rclJ5dnI5K1lHbmIvTDJFL0lCamo5L09V?=
 =?utf-8?Q?O7oKG4uCqE1goT1jtL/2lxH4uk8IzkTyUCsvT+xzMIhI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9e460d-b0bd-448a-10c4-08db2f1fdc93
X-MS-Exchange-CrossTenant-AuthSource: MW4PR20MB5517.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:03:29.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4719
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interesting. I could be wrong. Let me clarify what I did and what I observe=
. I edited the Makefile and put back the NO_REGEX =3D YesPlease line. Then =
I configured the build as=20

./configure =E2=80=94with-libpcre2=3D/usr/local=20

then built and installed git.=20

otool -L git shows git binary is dynamically linking the libpcre in /usr/lo=
cal

However, it looks like this third party library is also used for -G  search=
es (plain POSIX regex or PCRE), since it accepts and correctly finds things=
 like =E2=80=98\btext\b=E2=80=99. That is=20

git log =E2=80=94all -p -G =E2=80=98\main\b=E2=80=99

works

Furthermore, -G works with multibyte strings as well:=20

git log --all -p  -G '=E9=A1=94=F0=9F=8F=81=E2=80=99

What doesn=E2=80=99t work is multibyte strings with PCRESs, so for example =
this does not work:

git log --all -p  -G =E2=80=98\b=E9=A1=94=F0=9F=8F=81\b=E2=80=99

This doesn=E2=80=99t seem to be consistent with the thesis that regex libra=
ry from compat is used for -G searches and that it doesn=E2=80=99t support =
multibyte strings?


> On Mar 27, 2023, at 5:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Mario Grgic <mario_grgic@hotmail.com> writes:
>=20
> [administrivia: do not top post]
>=20
>>> Mario Grgic <mario_grgic@hotmail.com> writes:
>>> ...
>>>> +	NO_REGEX =3D YesPlease
>>>> 	PTHREAD_LIBS =3D
>>>> endif
>>>=20
>>> It will unfortunately break multibyte support on macOS by reverting
>>> what 1819ad32 (grep: fix multibyte regex handling under macOS,
>>> 2022-08-26) did.
>=20
>> In my case, I compiled git with pcre2 support, using third party
>> PCRE2 library: https://github.com/PCRE2Project/pcre2 and PCRE and
>> multibyte support in git works with it just fine.
>=20
> Sorry, you misunderstood.  1819ad32 is about enabling multi-byte
> support for normal regexp types, and does not have anything to do
> with pcre.  By setting NO_REGEX, the build will not link with
> Apple's regex library but the one from compat/ and that version is
> what is used for -G and -E (not -P).  -G/-E patterns with multi-byte
> would not work with compat/ stuff, but they should work when linked
> with Apple's regex library.
>=20

