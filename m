Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D55C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhK3Olp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:41:45 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:52480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231570AbhK3Oln (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:41:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO1n77z1o49SAGi1HwR17eJm9vJkUufqL3oQPoVdZrTcOOV/yzn9GL6CZGTaDbG9EJCBNIPhyNK6OsWYo84WzwB4c58tPtb4KyaQb8jyMbEAHFQiu+vXfgqR9eqcUgveGDTR6PrOhtrYkUV3CrJmuM4wCKQH51WiZTVNhwG/HY9nbJBBcKawkJh1SM1+zrbR6tE9ris3rF6ROz+WPVFyTuHlKI2ZYzxabQsY+Lly2nlAFRg9Tl6edP5Kxrf9FN5vctjaMWWgf/AfjC1Iy1WRxj5/ecyCpprIIwrjxT7Bwars/vJjAQMbQgdCAtbJb59zGaJ/YBoil8okfUhrPYqb2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0kLOEglqbTUGb+CuIu3NdDJXCYOU7FJEjHecqYPJQg=;
 b=XJS+coP7m4kxE3yCLkqK4AOkwf8X51tfw4QaG3njth8rSQNR0lydonSYTUmEytkaD6KDWPfscsT0o3Shc8hfkNCeNxEXUyFz0WFveYkdarBTcNR9Zurab6JIXfm5/SzUcJGRj1oSSkXs4OYJJI8H8z8np3S/kh9ENctx8vnRvmK16z8PB6lyuHqnJJAO5WsadWsVyyOEZ6rMVac9smXhF40XjMc7aoyUG2+FhlZZWKYy5tWyhpssqWRSLuOY6nQth1S2LgpswrOoCvTTbtXVIO9NbG6c/V4uyVM6Wtz6WEdEBmlINE4pZtXGjSIUdOmWxZdoRYHh+twmt9X8E5xBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0kLOEglqbTUGb+CuIu3NdDJXCYOU7FJEjHecqYPJQg=;
 b=GZJrTEttLXNt1P5N/0Sa3qhAjpkFUTwCYcOc2lfKuLWhbIdouWXcMiGbiVK+bjgwZ0ZMX7PLNXL7DzCw8o3runDecMYN24HMqBgOfzxB97nXcW0Kgc+YKKnVHxTmnzo9gZEL4eYeZFJN41dFxpzGqWoG56sgjXNLAwY70k/hQAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 14:38:22 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.011; Tue, 30 Nov 2021
 14:38:22 +0000
Date:   Tue, 30 Nov 2021 15:38:21 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Message-ID: <20211130143821.7dz5jj2z2x2q2ytn@fs>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
 <20211120150401.254408-4-fs@gigacodes.de>
 <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
 <xmqqh7c4i0jh.fsf@gitster.g>
 <20211126095509.weeknmg4p6sx7bdn@fs>
 <xmqqy25a636c.fsf@gitster.g>
 <20211127124733.ulicqyiudur3s5h4@fs>
 <xmqqo8634zrz.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqo8634zrz.fsf@gitster.g>
X-ClientProxiedBy: AS8PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0138.eurprd04.prod.outlook.com (2603:10a6:20b:127::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 14:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a97d884b-a4f8-4209-e33c-08d9b40f0f1a
X-MS-TrafficTypeDiagnostic: PA4PR10MB4463:
X-Microsoft-Antispam-PRVS: <PA4PR10MB44632595A5B3C27E857571E5B6679@PA4PR10MB4463.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Pq2F03eTBXzmIyZ0jtQj+du8ckpc7PPsONKvcvVX9fV34D+qdhuY57gIdsnAXNZra59fq0y2pbXL/OmUoG9cKgqeqxtpFp+rFxRBuQs33Zd5N/1yCgmcxufKq0YVJNnWsjtnybgl5ngE9QLh5iVQTRwnbhENff4B0Bua5u8Z0P0EhLqEcKPyIc3w8iFeduqFMIifmAhazusMlwkfHUi25Cw094Ydbyx6N5FJ/VOpQCm7LAuhAbFO4LiONq4OLt7rH4dV6cm0Y8xvJ2YRMIiK/NtBU+HlyMCd6OpB2lWJ9f0ObImxTRwEGqxwyiiCXpmhNVUbZl6G+rHWcEOOsc3iR2GVy01o+zs2asQR5TnmKVkRZFX+OPt5fwSUF1gA2usuP2JcPra7xW7lBLFrpDe6hfLFI2ys5Y0nGCvXRfLV5UxA9aVUp2xTG8VHuU60XsqCYEJ3oDUr+FaAH8PL7RbNI9FZkOZcGSl+nvlzxN2eEcNPfIKDZ1noIvQDVBsIsEDzPIyRiQKUEzSAfxWkhqOQFWyxXEdXumqG7tFKlTrcdBCemJ7mvth+7mAp3rWHgPSD16xJhYQz7W48w7Vm0SDCAR2FEnrKGOisEv3WqjCEkQo/wnpDIRQ49S7gOf9HJFEUN5mFDOUuwTO651sBodiXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(396003)(39840400004)(346002)(376002)(6496006)(6486002)(1076003)(6916009)(9686003)(86362001)(508600001)(4326008)(66946007)(53546011)(5660300002)(186003)(66556008)(66476007)(33716001)(8936002)(8676002)(38100700002)(316002)(83380400001)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHZEaHdoYkIxR3NZelowTFkyRWhRU0wyWnZnQWM3eFIyVXhpRDA4bWtwY1FL?=
 =?utf-8?B?bWF1ak1qRmFNQThiNjJEQXhNemUzRGFJZ25GVnBOMjhQeUNkaEJ5RWNWbnBM?=
 =?utf-8?B?L1lsTmxyN2x0SnM0cVVuam5oeTB1K0wvVDlveDRuMzhZaFpsbTlZK002SHh6?=
 =?utf-8?B?ZlhDLzhucUwzdXVMeFJZWW1lWjc3OWV6SXUzYlFFWWJuLy9aZGJQaUNsQ3pR?=
 =?utf-8?B?RmVONUhSZk1wdzhDOWhsb3J4QU1mcEN6M0RVd1doREpqcUE2UVpObVdXaFZF?=
 =?utf-8?B?Q1hQdnRuakt2ZHE4QzhQd0hFdkUwaUNxUEdUNUtlRWU2RjN0YWl3eFNjTWtP?=
 =?utf-8?B?Vk1TZDNKb0dqekV1WXkxVmtYRzdOakZVT3lCVFFxL2FLYVBTNnZBYTU0K0VN?=
 =?utf-8?B?NWQyN2dJUGhtdnlkRG96TnZGR0psSllaN2hRckY0ZEZVVUJ4eUtEQm0xNHpW?=
 =?utf-8?B?ZVN4Q0lzUGpUcDRITlFkUUpmME1nWFU0OGdFZnEyVklGMXdTRzVvUG5Gby9M?=
 =?utf-8?B?OXVwM25VbS9BM2pidU55K2xZMW0wRHl3b05uOTdScHczUkZ5R0cvdWV6L01Y?=
 =?utf-8?B?b0hjUHNYMHd2dFQvOE96V09lVDZJeE5oRTdEWVd2RVhEQS9FMlZQR282VGJG?=
 =?utf-8?B?NExMWWg1ekRaMTFHQ2phdy9lWUtkdmJQZUVkeFRmaXBOOE5TRm5nb3RHelVX?=
 =?utf-8?B?UGVwVGsvOHBPK245K1lMRmtCQlFuZldnQWlNdEw3M2llOVlTdFE1RnNoNlMy?=
 =?utf-8?B?SU52ZFR3NHk4WkZvV3R2YjJXcG9taEZnNHlXaVVhaDNlVCs2c3FUdTlnUEV6?=
 =?utf-8?B?TUo5UnlOc2pzTlZoYStRNXZ1Q3JaMSs4L3hwSURpcU5DQmwyUEU5YlovMnpI?=
 =?utf-8?B?YTZad0JlTmQyREZKTUJ6MHBMWDk3TDNHeDZuUlhQWUxqa3JWcnZhTzN2d3Rr?=
 =?utf-8?B?RVZrOFJIRDJmRU94NTZNVTBINTROelplMzdsby9MVGF5SUs0NGs0RXV1bkZh?=
 =?utf-8?B?eGlBemRpQ1p0MzAwdTVDS2VNNnJSY2o1aG9XZnVNb0o0dHNnTUxZQmZwY1h5?=
 =?utf-8?B?WnZHTnVnRnp6M2hGY1B3U0JiM0JoTW9Hc3NWWmsyc01jbzVqOVFnNFRKbGsy?=
 =?utf-8?B?c1c5QnRlb0dQcGoyZ292dHFkeUR5aWQ3YUdBWllKVUR4K2h3UFRySkkyYTky?=
 =?utf-8?B?aXcwNE5jeDRZR2lRcG94T3k4NGUwSTNyYmJVdHRsbzVDRHN1RU1lRHhqcGhy?=
 =?utf-8?B?YVE0YkpsalRXSlNWYzZ2eDRuZVpGTUtJdnBtMUhYbUtKeXBiQTlHb0E2M3Zk?=
 =?utf-8?B?NTRXVE5TZ0tyTERLSFFRSjQrZlNFNFNuV2g0NmR1M0xBSXpQdEhLZHIrL0p0?=
 =?utf-8?B?MnEvL3JsVzkrWG1reEpCemd0NlJFTXRPWVFiakgwSzg2OEZJYUhqTEM4YkVP?=
 =?utf-8?B?d2NLMzVPOUs5N01nYWp2QW5vOEJEcVg5TEhPem4zKzB5eGVHa1FGMTJzeXU1?=
 =?utf-8?B?dkdxQkJta3ZLbjdIRXpOeXhqV3g4NXZxTGhrWm5EL0NzRDhKTHVJWlUwQjJt?=
 =?utf-8?B?NWNreEJMMm8xeFlTbkdqQ2IxcDQ3TXJXSUgzU2lNQTFuQi9ybEdsbVRGNmVD?=
 =?utf-8?B?UHpidjh0NS9SaXhFcVB1QldLZ1owTVo5bmozdEw0ZUU0aThiT1Z5azI0QlBM?=
 =?utf-8?B?Rlkzd2tNZjVkUTQvcWdKMUprN2hjQXFHN1Q1RVl1a2ZTUTdKRUpveThMV3Ba?=
 =?utf-8?B?MVB3N3VDaC83d1RiUnhKL2dRZ09ZNU1ocG8xbWF5RTNoQk9sRXBmVGNMMjQy?=
 =?utf-8?B?RXRzTkxIZzU5MXFHcmJLTlBpbVZIN3hwcGNuZDlqL2NsbnkvTS9QOXhYQkN4?=
 =?utf-8?B?MXFjcHVHV2JudW5iZFpwYU5heEN0ZElBRnk3QnkxajZET2VvaVJ4aWdsSXk5?=
 =?utf-8?B?aEFkeEhvWlpxWEhGUkh1VWNnbmN6NkdQa3B1VHJDSG5QaXVKdTg0amloR21E?=
 =?utf-8?B?Z0pNUGU5ODFtaEsyejIyWTcyUDAvRmFqUkxkTzcvSkRSdUZmNzZkY041dHhl?=
 =?utf-8?B?blcvbnV4Qml0TjJuVFJxakFGVHhKK0ZLSmwxaUs3OURaVjRkQy9LK3J0a3R6?=
 =?utf-8?B?WHpLQ1FTYU1aVzBQVVdIbmRXWkJXU2VzenpQd1h0STI1VllIOEdESlRIOVNK?=
 =?utf-8?B?THM5dEJLZ2NCWTFnYjlwMnlIejVybHRBY2RnNGxoKy9oTCtvOE9Ccno3N2o0?=
 =?utf-8?B?bXpHYXJISFYyTXREc2FJZVoyc3BqaEw3ZitVeThjTlE3L2VzcXBxMDVlOFpR?=
 =?utf-8?B?TkpzYjRXZjREUk5xSDZraXk2NDFhMkptdXNLWi9xTFFmUmo2SWZHVTk0MFBO?=
 =?utf-8?Q?Uwn01j/WYtBL2suw=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d884b-a4f8-4209-e33c-08d9b40f0f1a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 14:38:22.4219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pZ5GR6hC0P8/A5FEMdieLAnhYi9BvMVfVC/uFYsZjxpmdr/mrobkaYICX0kQt87DeUX/LDLIiS4myan82STcVCSRJ2E5dLymuo14FQECJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4463
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28.11.2021 15:38, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>>>I was expecting something along the lines of ...
>>>
>>># What is written by tests to their FD #1 and #2 are sent to
>>># different places depending on the test mode (e.g. /dev/null in
>>># non-verbose mode, piped to tee with --tee option, etc.)  Original
>>># FD #1 and #2 are saved away to #5 and #7, so that test framework
>>># can use them to send the output to these low FDs before the
>>># mode-specific redirection.
>>>
>>>... but this only talks about the output side.  The final version
>>>needs to mention the input side, too.
>>>
>>
>> I like to use the term stdin/err/out since that is what i would grep for
>> when trying to find out more about the test i/o behaviour.
>
>I do not mind phrasing "original FD #1" as "original standard
>output" at all.  I just wanted to make sure it is clear to readers
>whose FD #1 and FD #5 we are talking about. In other words, the
>readers should get a clear understanding of where they are writing
>to, when the code they write in test_expect_success block outputs to
>FD #1, and what the code needs to do if it wants to always show
>something to the original standard output stream.

The current version in my branch is now:

What is written by tests to stdout and stderr is sent so different places
depending on the test mode (e.g. /dev/null in non-verbose mode, piped to tee
with --tee option, etc.). We save the original stdin to FD #6 and stdout and
stderr to #5 and #7, so that the test framework can use them (e.g. for
printing errors within the test framework) independently of the test mode.

which I think should make this sufficiently clear.
I'm wondering now though if we should write to #7 instead of #5 in 
BAIL_OUT(). The current use in test-lib/test-lib-functions seems a bit 
inconsistent.

For example:
error >&7 "bug in the test script: $*"
echo >&7 "test_must_fail: only 'git' is allowed: $*"

but:
echo >&5 "FATAL: Cannot prepare test area"
echo >&5 "FATAL: Unexpected exit with code $code"

Sometimes these errors result in immediate exit 1, but not always.

I'm not sure if the TAP framework that BAIL_OUT() references expects the 
bail out error on a specific fd.
