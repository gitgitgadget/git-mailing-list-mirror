Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FBC04A6A
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 02:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHCCzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 22:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjHCCzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 22:55:17 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2143.outbound.protection.outlook.com [40.92.62.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0D19A4
        for <git@vger.kernel.org>; Wed,  2 Aug 2023 19:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNtqh4C987sCYLLd94oHXvcijw6zP6t2qCzQ7hRhxC/QHj7U93WZQpYDtGztBolaixsV2Exwo/2Y03ZNoFaEFVnSZGKg+uyEB1xrNWeP1TaCnJet8GMEVHmJT1ipAhcfQ2F2dFc/dG7IW4bVOvlbPXvk9qB2a0OD9OhnP1sHQvMxn3DmW/7JtcV82h0cbJCo5gXRhe0CZ37p+wj6tTTWE/QxHtziwhtMtnQx1OtFALhGka8gsizGHwv1Is/sGawUBLMk7anykmNzldW2iCLntM61qeHyf1x0L8TdCVvmGEwPasJHAB9Gt2LzMgrT8EWD5wYpI4ebvmkRrjGCZKYEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExPCcCvfVMx3zXpNpedJDoTFnmy8l9J4XnDZ/2xVLH8=;
 b=aItFVmrhSb8ifL6iy+EXouIJy91ZmEYenmaMftUjcxArkZgVzxJu46xBPQlnbedESPAVAXPOXM8okKmBPkWiSceJsF2ag1UNTbpb5R2GpRFqC/ccAK/B6pR21s0V+nm9MkN+hjeD0ew5O1J2y5ZHRBlCVp0pEYpysCbNwhz0JfusexTW961wm6+KNARsQM86uKz2mxJarmy+0cHCPDvdYvNf3heX9YqMz9oJS/miT7kGJX7hj+IkbskaHhz2Eti8vVBaAu8GPdZ5J4j+CW71kbl+XBQHICgYW+9voeLpVder4pcQbzLassCKcfeC3muGvEyvaPYCyHKOGFNWWAUaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExPCcCvfVMx3zXpNpedJDoTFnmy8l9J4XnDZ/2xVLH8=;
 b=XyTeQfCcwilOE6b7h90WeXkY44Edi06NoOnUWz7XhX98AXRm/MrAGtskq90xhCtNbGOEZ2mBz1ovP5CVAACw3k2UwxZ4sZjjl44y62cxJW+J3qOimur4qk6KCuehBX5ShfwiD04Vy8qR2lFo1ASh8caGitX9itTwWG/L9sAoukeEzTmA7QtIgbqLOfMd+h9ckdV1ksCDnlQcc2sEG39KhAm4VSKOwJKZ8fVF4LOK9OnS7h9VOhQ5XQZ2afgFCIKcQSRYi+Jtz8/JS5BlmlBjR0deZKTJiNEszxwW0XweioovzBLRGRwCgcsK90BphWydm3nnIIOFnTCCoabY3GfgZg==
Received: from MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:f8::14)
 by SYZP282MB3189.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 02:55:11 +0000
Received: from MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM
 ([fe80::980f:f4b7:e0bb:4b56]) by MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM
 ([fe80::980f:f4b7:e0bb:4b56%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 02:55:11 +0000
Content-Type: text/plain;
        charset=utf-8
Subject: Re: Feature request for shorter relative date format in log
From:   Yucheng Zhou <zhouyucheng98@outlook.com>
In-Reply-To: <xmqqsf915b54.fsf@gitster.g>
Date:   Thu, 3 Aug 2023 10:54:47 +0800
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <MEYP282MB2280E174A5B4FFE11DDB5C40BE08A@MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM>
References: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
 <ZMqciat7tdbYGob8@nand.local> <xmqqsf915b54.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-TMN:  [KHO1fQg8o8ZHo4ts2TAXOKnmzRatusaq]
X-ClientProxiedBy: SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35)
 To MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:f8::14)
X-Microsoft-Original-Message-ID: <AE10D0A8-CD7B-42C7-9D3A-BC181ADABA5C@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2280:EE_|SYZP282MB3189:EE_
X-MS-Office365-Filtering-Correlation-Id: d931f03d-9937-4183-1fc0-08db93cd0dc6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvzhZvqkU5qIDuxOH092nVye3RyoAs1l3/Hpcnfq7p7oLCJ6dppkIlBplyqCuNr7rScBueeCUwM9IB8JglqaHdGp6RIepE4trzoODr0AD5GRC8pM37sm49jlChKp3wtwzLxZQ3pKH5HkTTnAbxqunUviJo6Hjkz8elENduoM4hRMML+Ipq3aDVG8zbV9sqBJTK15R7ICtlT6hZOEghZRx0HNqYreWNV00T37O0T9jsCqfTaoYXMkKAIkQRiL5DtVBzsN2CNf4PORs3Jm8oQjBFKmVcFxOqdBROpp0pRtUUADBH+TrCSyzSPNCVUIUP5+DmUHowtaWhE7HNDJ8QQen1rh/FHuhibNaL2I5qPPYtyPmoNawKEeecY1z6SMn5hqi+sbs/P1yI/xvWyB71cL6odaJadzClqf7bwsaBKnl+0Daj/sVjWSa51D6v0J7YvMCSxOD+s24W0P4K/Va6s5Fz4peE0K0N/muuWarRQpuUaUAH3r1nVkkjBRi4aORnuxfCNzezLBayac2fVbvGwMElzpFTqxK/fymBasn9NoZ9wG3tETu0svttI8rqzBybEV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFB4OUtvaE9KZXErSWlwTzQwQWhzZkVRWFI1dFEvUWN3T242Qk45elVWNmpH?=
 =?utf-8?B?UzRtSEdiTlUrWTgrQ3o2NFlnVmNsVWpsNkxGWGxBYURKR2VKU3ZTZ1VGQVlP?=
 =?utf-8?B?c1A3NUduL3ZjZ3NaemlCekQ0OWpXbFhjTGk5V3lLM0N2dys0ekJmSUVmbjd1?=
 =?utf-8?B?d3VKSzZPOGJVd3BSV1lrMUhrSXVkT1V4K3BvWGxGM04xTEVPWnVVdm52UGdE?=
 =?utf-8?B?WXVtdi9kMDQrTXNSSVRrdUg5a1VxQWFPUlIvUnRDZk1aK2hMSzZPQ0RHWnQ5?=
 =?utf-8?B?eHVqY3MxVytqaTA0eVRiSkZ1OUI0R1hQVFFmRWpIL1ZKVUhvSFBLSkxRNjlV?=
 =?utf-8?B?V25YTVd0dzZkK1pDUWd1K2N4K0V6ZUhTL2d6ZDdRankxVGw3V24zSUo4MXpG?=
 =?utf-8?B?Tm1VbEdWTVo4OWNLZ3lwZ1Y3NW1zMFZ4SzQ3NFBxZWZqeGxlU3JBOE5yU3BQ?=
 =?utf-8?B?MUJkTHFheG1NWWZIV2NtVytqY2c2QkhMeFhNa3ZKQWViSEJVNVMxa211cXZv?=
 =?utf-8?B?Q2d4UHlhaFk5U0hJdW41UkppUEtFbXpXTFBZemkyVzdZZXM5SFAzMHJSTDUx?=
 =?utf-8?B?enZaVklCV004MGk5a09UQ0xwNERVY2hiWFRZMytpbWgwNlVFTWlaUk5IL0Er?=
 =?utf-8?B?Y1pTTkNqRzJKVHgrMDJYa3JCRmZHWUM1eGVNM0dyTnRabmlROVo5YmRWd2I4?=
 =?utf-8?B?bTQ3VEZ1MkpjbnE2ajNidXBRWTV1Rm9KZXdLM0tmODZuYWh1aWs3aUtSSnEz?=
 =?utf-8?B?MEV2Y2JhNnN5NEh5QnNLZThXUmNZZnF4MGpPdHNhR3RZWUV5Z3haVndSMW9r?=
 =?utf-8?B?dmVMdjJ4RWh1WlBncXRLRFBzdWVMN0xRMjFCWEJRWVlsOXVKTDNqTkpmSDdk?=
 =?utf-8?B?eTZpdGl0MDVPekVKOU1KTE9YRUlpU2FsNFZ1OFhndlpZdWhzTjEvQlUxVlAv?=
 =?utf-8?B?V1dtWXBRdi95K2grTUpVRGZZUmtYcWxKT1hhWmN4cWRubDhsbm1vL3FWMnRp?=
 =?utf-8?B?clAxUytTMFNqbUh3Ri94bGx2Mm5jZE1pdkJQZXJvU2QrNmVhdHkxYm9tTmJ3?=
 =?utf-8?B?QmpWNm13VWI5ZzhjL3JOWkFxelBHTTI1U3IrdVJxTGFnZXpWOTVTWHJpS21z?=
 =?utf-8?B?dk5CNjJuczJIdklwY2VHUXljR2k1bit5L0p2OWpvNHM2TWMrM24rclVUa2Ja?=
 =?utf-8?B?bE1CSW52cGNqUGo2WWJ3aUxhSjV4cVI0UGNmbWhBK0RIL1dMTlllWHNpcSs0?=
 =?utf-8?B?TXpUZlhiOStnNko2Y0kxcit2bVN6MTd6YWt3dmxsQnBSMnNYbEhWdEIvNWZV?=
 =?utf-8?B?TkIrSkNWbFZSOXFCUjVTbURjK2V0M2xKR2YrUm1UeThoalFpbGtTcldxbzRh?=
 =?utf-8?B?WUZIcHUyMlk0eHpjRE90YnpGcWRaMnljYjZJQXBYaHBMVXZSbld4bVJMT0Jh?=
 =?utf-8?B?amJ6dit4bHF1ZUxZNU81aTdWM28yZkZwWU11UUNJRU91RmZhV0c4VmJXUkhD?=
 =?utf-8?B?N2dtNisvNCtUNDZ5dzZVSVdnaGNVM1RBWmIvandUc1Y2QndYenVaYmcxdEFJ?=
 =?utf-8?B?em9Ga0V0dm5QM0wvMlJVakdlNy9uaHJFY1RTRDRvQnN0c0xOcnlSS29uRFBW?=
 =?utf-8?Q?OXaILAREcQJo+5JbZo+TVQX2Ia+iQHIgh6S3TAO0Q080=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d931f03d-9937-4183-1fc0-08db93cd0dc6
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2280.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:55:11.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZP282MB3189
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your reply!

Actually, I think there is no need to allow users to config the switching o=
f granularity. The current relative format has already done a great job.
What I want is, a handy way to show a shorter relative date (like the =E2=
=80=9C--short=E2=80=9D flag in git status). And the current switching of gr=
anularity should be reused.

The only thing need to be changed, is the vocabulary for representation. Fo=
r example, the =E2=80=9C2 minutes ago=E2=80=9D can be represented in =E2=80=
=9C2m=E2=80=9D, and =E2=80=9C10 days ago=E2=80=9D to =E2=80=9C10d=E2=80=9D.=
=20
If both the past and future timestamps should be taken into account, we can=
 use a prefix =E2=80=9C-=E2=80=9D and =E2=80=9C+=E2=80=9D  to distinguish t=
hem. But I think we hardly see a future timestamp in the git log output, so=
 we can let the past timestamps un-prefixed and only prefix the future ones=
 with a =E2=80=9C+=E2=80=9D, maybe.

The rationale of this feature is saving space in the output, to let more us=
eful information be shown in one line.
For instance, many skilled git users use customized one-line formats in git=
 log, such as =E2=80=9C<hash> <date> <author> <title-line>=E2=80=9D. Where =
the <date> can be shortened as much as possible to save space for other imp=
ortant things (especially using with --graph or --decorate). Therefore, a s=
horter relative date representation of no more than about 3 characters can =
be a great idea.

To achieve this, a new format like =E2=80=9Crelative-short=E2=80=9D can be =
introduced. There is no need to let users config so many things. Since ther=
e already exists =E2=80=9C--date=3Dshort=E2=80=9D for short absolute date f=
ormat and =E2=80=9C--date=3Ddefault-local=E2=80=9D which consists of two wo=
rds, I think a new option =E2=80=9C--date=3Drelative-short=E2=80=9D with a =
well-designed shorter representation will be very handy and great.

