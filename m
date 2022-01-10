Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E4BC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 12:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiAJM3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 07:29:04 -0500
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:21089
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245449AbiAJM3D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 07:29:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEFKiram+tGl8ZqDm89MBnipD/pvNxHaMYWuo2hJMIFep6vfdMe9cq4GXixMM94ytvlyi0AwIJ3AFm56pDA6cwsxX3RjeaHzSYGhlx1T5uj9mW3tDURcHwQ1HQ1i1EQkqrcvUpfXz5QpAdH7q59jRh0Gp/pLu6Bgd+qn4O5JSq+NgHBe5V2nmMdD6U9xbieCQ/zw9CiG4NnKltcL8wcvyrf0OqIuDX+6NX9fXKUAVUHno9ya/yKroUr/iYK83lHdRYUuUP7oxJkDDiBBbxMqXFQvazvxJ/A8oZd/QV1S78YxJ2QVIJUcDWbdrIuZCx5nzM0pJ7Pz0mjGmTExdBpRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsOQzx2rk5KfX7XY71c8qnlmeLYeZ57x2WL+tuTPqCQ=;
 b=kZZCHRg/2LWU1lqOQoHW5lo4ZCtAOyrLMlkJ47e42FUn97jb8jhjds7gpZWQteLrfhKXSnjPRQX2JxvnvNP7xLBbbAs/FIrEXah1oau3HlXo/gHvd+u+cQ71y/smuelKJJWG2P587V5/vg/NL5X9csMQWrGf1AVJNr1vclQtPitpj7zXfC26NVyDeqnDYQWwQIswxTeJR8eICBBoNijqcPmSe5ZYPXzYJKQfah8T4t0OvGIqyfNWalqs2GxWSz00Fw3Q/J9O1drUh+jrBp1WLMO1eRF9EAnHDjVxaUhBb6YXvWdBCm/MazK473eFhexijrutln9wUYJ7J6WlC67ROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsOQzx2rk5KfX7XY71c8qnlmeLYeZ57x2WL+tuTPqCQ=;
 b=nVavd499ZEv4T3GKlLa0haBB2Wl7MopIeAIhYwRQ48wBL9nI3FLoB4ndlPp5ytvzi5qS1d+C1mPJjhBgozn4UVOw90N3YUB1gsbWdf0jY3ZkKKVKA0UsHa3hDxsv+9zNLZVvsfdxeQV1CAUxCyl4tNpff8Tn0Xn2uXLBc3wuqRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Mon, 10 Jan
 2022 12:29:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 12:29:00 +0000
Date:   Mon, 10 Jan 2022 13:28:59 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
Message-ID: <20220110122859.3x37a7xdbmcsmuvm@fs>
References: <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g>
 <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g>
 <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
 <20220104125534.wznwbkyxfcmyfqhb@fs>
 <xmqqo84rcn3j.fsf@gitster.g>
 <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
 <20220105103611.upfmcrudw6n3ymx6@fs>
 <CAPig+cQMP_Ppg6uywAcFhaVqSoa71dD6UjXbUtC-bvK0WzJnZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cQMP_Ppg6uywAcFhaVqSoa71dD6UjXbUtC-bvK0WzJnZA@mail.gmail.com>
X-ClientProxiedBy: AM6P193CA0131.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::36) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3621874d-840f-4e14-8574-08d9d434c7e4
X-MS-TrafficTypeDiagnostic: PAXPR10MB4859:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB48595478301EBB875AFC3CFBB6509@PAXPR10MB4859.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7dIkWq2DNXrrHc77tCjMnL4iG5atA6vVJQIRdjACYgIpQTP5lI7Ti5gxxlQQPSFrlGbao11u5KXHbzL59RkkD2mWofqLTSMsYpcArElmGmFM1V7NMtW/82QP4n9XpnAG03noGYqiAZRfQz+7fKOfziN5w1teeTlWUKR9Ac97sSXYabEF9xqENoBtiYn/Ee7NSp+2HWucdtOi23mC1+7smE5RweIvoF3v9r+nMdh0KOZEFPpATGkx3PoiHVRg2O+OoifXW2elOKlYSNOMeLbsdGWWl2K9IwZZWsHo/D+r9EeBuzR9MRW3HouayHX+k4idBIAarx6NYKJJqcvyYKKUAmbqqGgDaesDoFsrpQAIoDsykYGVgK2KXm57RRFzaSuh5REkw8npPx73YUZms6VGbbpIINrjC/hujRHc6KbPhVP5Vml5ifpvVG2GafKHhHHdJq8Iu8myzIi6v4vFEmIvTUnXZ3ZyieqLi55RTgaG1MtVOfxBRIvovXVFB9VEY/z9WnGxG6gh7BExRKePcPVT5PJ7VIy/9MVRvU6B5/yZew0KVKk+yj5p1YJH8EWeblYopomTvXHM2z6M1XEq7527RIFX+KA4wdkGnTtJCl/PU7L6XDtdQsXUbWSYPl9vBfeCKgrZnvZFKUa5Jgo+2na3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(366004)(346002)(39840400004)(136003)(396003)(8936002)(1076003)(508600001)(4326008)(54906003)(316002)(8676002)(6506007)(5660300002)(186003)(53546011)(26005)(86362001)(33716001)(9686003)(6512007)(66946007)(66476007)(66556008)(6486002)(38100700002)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUtkQUlDQlNCSWhsdnFRMUtOZTc1QS9EUm1IMUtFRmFFSStnelpyYU5wTk5J?=
 =?utf-8?B?QnFkbTg1OUJPS2ZTSXFZYmdhTFRzbCtodzN4K1UyQkw3ei9CcWNudElKTGRW?=
 =?utf-8?B?ZGFsQ0tDLytldG1MZjBnNytncm9hOUFrRnF1VmpBSFVzSktxVXd1RjlDV0la?=
 =?utf-8?B?MktGdDROVzNIek8wNjlHV1VxQUpzWW5LZjZEci9CNTBjYUc3NFE4UlR3bWdQ?=
 =?utf-8?B?a3ExalFUWjZrMGVKWW1oUVFBSXV5d3ZhRnl6eUk2N3kvTVRKL1IyNmhZTXov?=
 =?utf-8?B?eDIrbnNEYlVkVmFGd01LaW5DTHNzdjZSMmJkRHRCb3pQUjZSMkNHRWZwOG1h?=
 =?utf-8?B?czljYklURS9tOEUvNVFsTTRMUmNPV1R6MFl4NGZ5K01jc1BONVhZSWoxMFR2?=
 =?utf-8?B?NmsyM0hOc0NQV24vOU95T0ZWdEcrSEFOQnpRcGt3c3licTl1NHg4MG8ydnVH?=
 =?utf-8?B?R1FtazNpS2hhNG5ONDJSU2VETHpDd01rUCtCdFp4aVdkdWdkS2NoUnhpZzh4?=
 =?utf-8?B?SS8wcnJKQ2ZiMDJ5VGc2MkF5U1RLWE43aDlBUWhrK21VMU8wdXlpaXRQNFpQ?=
 =?utf-8?B?NTdFTWJ4WDdHMGV4ckExdnY0cXRVbzdFb1d3UzNmVG01S3V4b1hyNnBWc0tq?=
 =?utf-8?B?VzFXZzNVUGNSYVJIVjk3N0ZPTmRiODV2Rng4eFpkbHR2MzgyQ3prbmlMbXJ4?=
 =?utf-8?B?YVc3bjkrN05VU3JwUGxKV0xBUG5sVmpQSmt2OS9OQVdMZDNGcVhaY2R3azV1?=
 =?utf-8?B?cGVZNDZ1czIzNDhSMTZ4UzZYQlBUb2FZVUFwNW9iMmtXNWlrQzVHRE9qdWFI?=
 =?utf-8?B?YVlGYjJhNDFnNkRqWEdkeUptZ01DaW5iOU1raVBoWTNZQjZ2dGNSTGhxM08y?=
 =?utf-8?B?ck9nRWNhdE5KeDBuVFU3YXdLMnJnQ1AyZzkwUUdaZmh5UjFSQ3h3WWwrRjBK?=
 =?utf-8?B?Q1ZTZjNVVUM5UmVBTjhpL0J2R1ZUUHgzRk9HdkZVRm9tN05SamE3QUp0MEZ1?=
 =?utf-8?B?RzM2WEMwM1I4ZmJDUXhVUEwyMGZWd0NsODh0YTdxeDBmajE1aVJmZzlHN2Q0?=
 =?utf-8?B?VEgvRHJWOEZRelI4bUhvQ3lWdG0yTStiazU5N3BLVWErOStmbW9uZ1NIYTRS?=
 =?utf-8?B?Y0d0eXlVQkp6aDBPcTF0d3NEaW9RWm5pdkNIMWtWclNuZnZlWk5VaVo4M2xk?=
 =?utf-8?B?SWxPanhwRlN3OXZVdVAwREpMeWRicFVVQlVSc3oxWmNkVTlaNE1SRE9kNFFP?=
 =?utf-8?B?VFFScFdubUhwMEVkaGVHajAwTUxIRm9EbnUyalA2UzdOMDhiUWk3Z0FSSzVp?=
 =?utf-8?B?eURPQmw4WHk1ejhSVXV3WHFuSEVpQ3daVVR5SFVwRmY3RERMY2hyb2c2Y0xy?=
 =?utf-8?B?eEdiWnRSV3cwZkFTbU5BbmhCenk4YVIyS0NTQ1hsaTV1T0YrdWVpVWVLTFRm?=
 =?utf-8?B?TGFXTTRsb3B1SHFTdDNadUxodHc3NnM4d2QyaEd0NkpSdHNxVU1sV0ZwWTdD?=
 =?utf-8?B?QzZnczk0cUZuMlUwV05SbjF4L1dJdC81SWNpY2dpeDBiczBtTjVRbXIvWlJm?=
 =?utf-8?B?VklRKzJQdXM2azFjUzl5bEtIUXRpK2NJZWoxQUtiWUc2Y1ZVbGd6UHNNNWw3?=
 =?utf-8?B?UFhmbUFKbFVNLzVZZ0ZkNVRFNW45ejZUbWhHL0krOGkxTmYyWGRTR1MxU3hJ?=
 =?utf-8?B?SytRWGNWOWM5MkN5VXJGNDNqU1BHN1lia0EwWE5PWkJ1Z0F4Tnh5eWlBTUZo?=
 =?utf-8?B?SXFzMkFscGxKRlN5eksvMkxOM1FLS2N2L0o3T3Zpdm9uWGFOa1h1czJOV3VG?=
 =?utf-8?B?bjNLQ1gzcU0wYlFkQ0xZSkNJZE1veHlua2RDakRremlLb0JGU1RTRDBSUHZj?=
 =?utf-8?B?byt2M0ZENnp1Sjl4ZWhISjc1dkpFalh5Q0FUYTFIMnhXQXR3U0ZOenUyZy85?=
 =?utf-8?B?WCtJdmpHanJ4Y21kUUFiY0pyUGsweTJQWllhOWQ3VU9NMEkzMC8vdUNhY1BL?=
 =?utf-8?B?T3RLdG1wWWovMHJWVG1XRmV5Ymx1V3lmNldqVkhibFExSnNrWWx4Lys3Zlgx?=
 =?utf-8?B?YllKN1NIdzYvQ2kwQ3VGQXNTR1p6b1IwK3BSTHhRVjAvM1AyUThRbVpjSW9t?=
 =?utf-8?B?N1lTV012V21uRWFIZ0VjZzhaekRaQW1TcWhKWThScGpxRVdYZ0lWQkhmTVhz?=
 =?utf-8?B?NEVEdmh1WXkvSFVnaTFtaTBiU3RKWjhBeVdZQmJOU3dxcGZhcWlFR0tGbkE4?=
 =?utf-8?Q?dlGGqVi7w9PxycQzWZ/xyhLMSbQuO2b3k9CDn8UuLg=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621874d-840f-4e14-8574-08d9d434c7e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 12:29:00.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHvN0hLord/U9iebLcJhb2YWVKxTrERgIK5yqUoCwhgfl+jv5d0f6w+CU+CHXabbYbTcTZy7xuTQIx6Q343NEpifrSpP/IjNdHPk4jiXVv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4859
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.01.2022 15:49, Eric Sunshine wrote:
>On Wed, Jan 5, 2022 at 5:36 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> On 05.01.2022 02:09, Eric Sunshine wrote:
>> >> >      line = strchrnul(line + 1, '\n')) {
>> >> >       while (*line == '\n')
>> >> >               line++;
>> >> >       if (!*line)
>> >> >               break;
>> >
>> >Indeed, the existing code is confusing me. I've been staring at it for
>> >several minutes and I think I'm still failing to understand the
>> >purpose of the +1 in the strchrnul() call. Perhaps I'm missing
>> >something obvious(?).
>>
>> This whole loop was basically copied from parse_gpg_output() above. Without
>> the +1 this would always find the same line in the buffer. The +1 skips over
>> the previously found LF.
>
>I still don't see the point of +1 in the strchrnul() call. After:
>
>    line = strchrnul(line + 1, '\n'))
>
>`line` is going to point either at '\n' or at NUL. Then:
>
>    while (*line == '\n')
>        line++;
>
>skips over the '\n' if present. So, by the time the next loop
>iteration starts, `line` will already be pointing past the '\n' we
>just found, thus the +1 seems pointless (and maybe even buggy).
>
>But perhaps I have a blind spot and am missing something obvious...

Hm, yeah. I think you are correct. The while below should make the +1 
unnecessary. I think this never mattered to parse_gpg_output() since it is 
only looking for the [GNUPG:] status line which probably comes first anyway.  
If it does not then I think the loop will skip over it. Same thing with ssh 
(but we are changing this whole loop anyway)
