Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C77AC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbhLAPSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:18:32 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:27268
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350966AbhLAPRw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 10:17:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hunXfORTg/O9XgqWd3d9rUYB40BZjAahREC707+L6vugZeIkMT5HzVRgslCdOu0YKgN0EhyGr5ilu+4NMHONkpqRzN/ZvAe+PwxLZz1A5s2p+Mi8iceHx18sg1YOOqSTfIXM/9Ab41Es+TfxbzG4F/s0CHkanbU/lrk1+8h3+9p1odoBTNnq819ewRd6J/EA/TPUDqryqYCxYvPeyaPz1j+yMmcYoc61ip5qz1oGDPGYPonlg1aSgyTdwX6uA0QdMeX+AUTKKS/g5U0vpANno1vojqi7LFdzHdC6BmFsuqaXxk/vxxEXVA9PqBW+kJDSx650mRqRPOOFoBP5gXWnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foi7wyuRYj+fH3KA7IWGVijqn7QF89KUsViSC8RCcUQ=;
 b=RU+xsxSSfk8g+wZYpsDPmaFuSihO26gszsxsNWasnS5l58BssoMXttgKZ/noR/5AVdBhtoQZX4fUdbFZtiijLCYKNvNKmPIOhZvF12qSqB+c2abyD7+I6MWAuISFc1PIiMHUfs500ijF15pxBt8QYu+OoOdNxLLPyq8+WLkHlgEM8mYAONoofhyh2cHfV3M500gD5RKIPAUXLqzGMYedWXqDazoTHOksMw90nkR1EjUJmDuM03QW7eOA/h8SytVbwD5dl3DkXaNIi55yQ/1myPAgHyK+ovZnPtQ5+TRsd9SHNVRYsC+/q02sLntgceAoqinZ6gUlbepHjvA8RHSaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foi7wyuRYj+fH3KA7IWGVijqn7QF89KUsViSC8RCcUQ=;
 b=BpMzyHgoYyDfpsknCYAFpEN/lk9nUGNo42J+Vpmgk5gaJRiy1/nVbrk4hHAJFsH1e6rXi0yPJcRuiezSEY3mLkwVJhBuBGr4/d14gxdl6XyBS05XqabcKRKx6Sa/O8lhRwUBhQ6S+5X+dvSy2NbgM/E/EJJPZYdz5lEMy+SKiQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 15:14:29 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 15:14:28 +0000
Date:   Wed, 1 Dec 2021 16:14:27 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
Message-ID: <20211201151427.6z3stwrodxbjwzf5@fs>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
 <20211201083301.ozrhi2brjk4zx5ll@fs>
 <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cRFqO5wcZTPrpTuiBP72+6enJs+---mjT2AFAQq5ztt_w@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:20b:31e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Wed, 1 Dec 2021 15:14:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80989ccf-5ed6-45d7-070e-08d9b4dd44fa
X-MS-TrafficTypeDiagnostic: PAXPR10MB4765:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4765F1C60AAD7FDEFC3CBEBEB6689@PAXPR10MB4765.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3aAHzKGwIguLfHoUBSJU6HNMzMjWWj6W/CPSPnSXYjMCdqwiAAiuSjE06IgTsAHDEPh7ChXt+G7IYgI9QS5X4t0A1QEJq4jfeujP75X5ohdPsLhEubjV3WqW1v9Hy8Ve0B1NvhvVC71RfIzWC/JIh+oMh6ncrNOn+YU9zkSISwmYtmv1cUu7Lmhuj3L32EeYYlglI8dAhEq/X9dkVqBtARo2NQWjILGthwfHjD39R3s8PMmvZTr1yMejnsCYBt0GwqLGFE9XYSoNrYuCnqRAQnEN+WRPhBsNGy7d1Nch84qgC+8T9Vf6Rx4b0U2R3M1zCeoTLwXUddec7wiJ6G04fJiPhgm1DWIBX7FhlW+mMhW02vn2hCpEaw3OCbfHEzISFs85uiGEPpFjJf42+ATX8aw8scD0T1ZxFBsXgsLrUKqarcM7zKZMwd78KBYwUgF+3QoAURrVQYD60ShgG3sk1NHf+5lpdmT9zw0PK3qdqrOgFXK1sqy/LNOhtk3El6gtsDT1lVQo+kgXnEpRtzcIUwjkn0/QEW6ct1Yq6v2jNVIGRS+Ha6znaec72bljlie2eU7FlCGJOOUc/8Hf7vhlbx7VP7CzpLbzuqgQtZsF3LtcDe1VvvZ93xoBE+vSGO3CpMiOYhkFTZRng/cSQOQp4bH3dCcVaW8Zks9DaysTY8ZKj0mi/MwDb9UQnqiaIR+zCID2+P3PURZfLkPSDuXEyBmecmkel/iabxqYnyu1lY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(376002)(366004)(396003)(346002)(39840400004)(316002)(54906003)(186003)(8676002)(5660300002)(8936002)(6486002)(508600001)(966005)(33716001)(4326008)(6916009)(1076003)(6496006)(66946007)(38100700002)(66476007)(66556008)(53546011)(83380400001)(2906002)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU5BRC9XT3FwUGNoQ01rWWlqSWtTNnYxS3dKWDkwUzdpTFFUZHVIVmQyQm0r?=
 =?utf-8?B?STY0OUFIK25ucWl3S3JqeTdOdUVRTE9JbTRhR05KZW9xZ1FmaU9YSjJjdkNX?=
 =?utf-8?B?S1Ezd0tJd3B3N0VtRHUrUW9tWVVTckEwK2NYR3I0Ny9vcDJueDJ0bmF1dHVF?=
 =?utf-8?B?aTNuZGxUalB0a2Y0d0YwNTZtVFVtRW03SXVXVS9PQzBYdmVHMjR2ZnZ6ZDF6?=
 =?utf-8?B?WWl1TTRKd2hPTEIxUDVKQkxEQ0lNTkNuYnJkYWFYNlFyZTJEUFpNdzc2dWEx?=
 =?utf-8?B?UEhXVDZJcUJlVTBHblRiSFdJMUdabS9CRVM1eXFFN1p6VlhlQ1kxbUFhSXQz?=
 =?utf-8?B?S3BaOFlYUTNYV0o0UytVeTdBWUFRbXhPUFFaUkpuVXprSVM5U3Uwd2l6Sjdz?=
 =?utf-8?B?czdJQUZKejlldTh4VlU2ajNtczl4d0xSckF2SVdUSnJzdHVldzUyTWttNzJp?=
 =?utf-8?B?WktMcmd5S3BianFhOVFYMmo4bEhLcnRndWoyZ0docFRRVmM2M1dJcWd5QkZB?=
 =?utf-8?B?REJ0UEZuZHVoRnhmNXd2TW8zVDYrOGV2bjRiTXNMMllLL3F6ckNyWTJOZFNX?=
 =?utf-8?B?SVBHYWtVS3Z0ODNJR2NLUWVOS1lzVHA1Rmk1NmRtdHRHREtaMmUrSlFJS25R?=
 =?utf-8?B?UlBROFdldmlMbGZrME1LLzlvQWlGZWhCaGRPZUVFcG5JVW15TW1udkRFSlJ5?=
 =?utf-8?B?VWVCSTNYL2FoQlBZdDF1Z1ZTNWRydHp3RlpGczRBdE5SWjVvZVc1alQyaUFZ?=
 =?utf-8?B?VzE2Znk4WGhHR0dwbXA1MHdOeEVxaktJSDdjWDRFOVpWVDZETS9XRDV6OVhi?=
 =?utf-8?B?b3BtZjY1MDl5N1hvQkNZZGQ5eGxqWmNWYjdDektmWHVpTmJidGR3b3M0bEdK?=
 =?utf-8?B?ZnlrNlVaWDluODU0UjNPL1RBY3FwQWF3RDBzNzgwa2RNUzdsbVliWWZvT3pk?=
 =?utf-8?B?RzR4NGRtenROeXo5T2xVc09UT1FzZmQ0UDE5LzZ3L0RjcDRIdy8zeWdMK2Zz?=
 =?utf-8?B?aThUbXgvWmdER0RlMlFKWFB4MHcvUFlWbW9YS0RZOWdqWml4ckhaT2Y1Sk0r?=
 =?utf-8?B?dzJKalNLaDVGc245L1I0bUdIOGUzc1pJZFpjS3VaT1Z1NnBNc3pjbEt3ZytR?=
 =?utf-8?B?NkFwQ1hjbWNNZmhnaHQ3Q2VsNDRZUml2bFB4V3Y2T1cxQTlYTmlFaGtNTnlI?=
 =?utf-8?B?Sk43YUtxVXVVT2hZUFcxQVJ0b0k0QUNZbjdtYjBQU0hUU2FvWDZlaktmUE9E?=
 =?utf-8?B?Wjh4M3FZUlRNdmxxMjZzQnltMHk4MjNjM0tad2QxM2F1azRSOTJXQ2NYMzZC?=
 =?utf-8?B?Z1ExT2dURmVjK0RjY2s5ZERxSkNlWUtWSUp2ZFhmQ05nY21WNmI4SjMxcmxM?=
 =?utf-8?B?aVhFSW9tWVVodldEMGk0aEFXOEhjY2VuR3BwVGMwcldTeEdmYzQvaGtqdEZs?=
 =?utf-8?B?M3hhSWdEN2lNT1p1MXp3bkxjZjFYNGhiL29wQTFXemFrVGp1ek5Bd3RlSVVv?=
 =?utf-8?B?Y1F0dVlteUpabm5IRDJhdWUwRkpxU0RyTjRGQXNDNnV3djN2ZFI4VUY3WXVC?=
 =?utf-8?B?MWlrSldIWGJvalFDWUxQM21jRGVTbUpYYmxrMVFFaytYYlVwdDJCdlhvbUZw?=
 =?utf-8?B?WGIzb0xxWTRQTVk3OUhYbVZibitMMXY5VXFtVjdZejVJd0IxM2ErOG82VmlY?=
 =?utf-8?B?cS9YYkZORWFUSllyVzhmVkhaeWtaWVBOUTB4dUV4MHd3bjZiVS9tb1M2YWlT?=
 =?utf-8?B?akJvYi96dHNCaEtSbEFjc0czR3hpeHVDNGF0QmFYWDUxZHZyWTBvSHJ2K0hC?=
 =?utf-8?B?eGJROWl3VGhQczJtLzcwbHljeG9ueERFQUJYYnplSDdCVGtGM2w1NFlvUW1o?=
 =?utf-8?B?Vk9CeDNaUXVOaTBlU1VtZ0hEY00zcDZCbzNxNGJnNzJtVzA4amFLVTg4ZmQ0?=
 =?utf-8?B?MEpjeS93MnZSdzhHWW5jMUdaUlk2S2FSeklTSW4rSCthWDlGdThDQ3l0MG1Y?=
 =?utf-8?B?NitIVkZvbVJGMUNiV1FPZHhEZ2JyT0VWenBCcDV0ZWx1a0lFMytIc2hmTXZp?=
 =?utf-8?B?bU55bXI5NXk0UWJuaXNTTm1oTElvcVkrcDNDOXBlWmZRTURuMm9seHRXRTdF?=
 =?utf-8?B?MWRmaTM0WnFLMkNLbERpSzVOOVVJS3JtRkl0eGtnRjI0dVVoWE9ZbGtCbmox?=
 =?utf-8?B?eDg1R0w1SUZvK3pWUUY4RGxYcGliN0tPblNmNitMcnplamc4VGZ5ajIraG5P?=
 =?utf-8?B?b2tRN1Q4U3VNK3NSSW16dlAzZ3k3MzMrQ0pUd1grSEVZT0ZaSGNWcXE5QnFO?=
 =?utf-8?B?Rys0QTlkT3VwZ3V6aFFmSy9lbE1VdnlrWldmWWRXSkVJWTNWbzRyRWEyVDQy?=
 =?utf-8?Q?KqdXUea+tUm/SpAY=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 80989ccf-5ed6-45d7-070e-08d9b4dd44fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 15:14:28.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdkBezhpQBdf5gDA/N45Gzl94203Ftt1ObKTPe8eMrfoiCuJqKH9GIRVEjFz0K6c/RGH4DLW5rLGXo4K4ITYtbP6Yz8WqVVQXBCwZT3TfF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4765
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.12.2021 08:50, Eric Sunshine wrote:
>On Wed, Dec 1, 2021 at 3:33 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> On 01.12.2021 00:32, Eric Sunshine wrote:
>> >+ We make a distinction between a command's primary output and output
>> >+ which is merely chatty feedback (for instance, status messages,
>> >+ running transcript, or progress display), as well as error messages.
>> >+ Roughly speaking, a command's primary output is that which one might
>> >+ want to capture to a file or send down a pipe; its chatty output
>> >+ should not interfere with those use-cases.
>> >+
>> >+ As such, primary output should be sent to the standard output stream
>> >+ (stdout), and chatty output should be sent to the standard error
>> >+ stream (stderr). Examples of commands which produce primary output
>> >+ include `git log`, `git show`, and `git branch --list` which generate
>> >+ output on the stdout stream.
>> >+
>> >+ Not all commands have primary output; this is often true of commands
>> >+ whose main function is to perform an action. Some action commands are
>> >+ silent, whereas others are chatty. An example of a chatty action
>> >+ commands is `git clone` with its "Cloning into '<path>'..." and
>> >+ "Checking connectivity..." status messages which it sends to the
>> >+ stderr stream.
>> >+
>> >+ Error messages are always sent to the stderr stream.
>>
>> This is not necessarily true in the context of the tests.
>> We just spoke about this in:
>> https://lore.kernel.org/git/211130.86wnkpd6ou.gmgdl@evledraar.gmail.com/T/#u
>>
>> I don't think it necessary to bloat this explanation with the test details.
>> But mentioning it as an exception would be good.
>
>Yep, I tried to be clear about that by repeatedly stating that
>_command_ output should follow this guideline, where "command" means
>"Git command". I strongly considered writing "Git command" to be
>perfectly clear, but figured reviewers would insist that it was
>redundant to mention "Git".
>
>However, I can certainly change these to say "Git command" if you
>think it would make the intent clearer, and can update the final point
>to say:
>
>    Error messages from Git commands should always
>    be sent to the stderr stream.

Maybe it was just because i was working on test-lib stuff earlier that i did 
not connect `a commands output` to a `git command` but basically understood 
it as all output in git code.
Still, I think your addition to the last sentence is a good idea and won't 
hurt.

Thanks
