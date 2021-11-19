Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C13CC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D38E61A64
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 09:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhKSJIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:08:54 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:29259
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231270AbhKSJIy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 04:08:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEphl7r56gl3zaXPEDvcBW0BFj+hZkXHP39ARfUpjbh11KUZYk2jAi+Hs3i69HTy9UDR0PPtzpUCE34nD0BaIfw5+M5NZnFT4zaHMi+TRTItqpO1UP0UN0kBF2n5HlLYJ+Q8EevjYh93lQsHUV1yL/ZAAkx63xh7TBuZrJq8o089pr6phFIS10wlfspHOC+Uoe4Hj3Fkys5xkq4YFBJpW7Bhhi9lFf7pBVXd8qaD/FoIWbyA79aSghQDleBIbTlMwcC93TsgY+GHgAfHCuujrK0aak0IZ/ow1ktuH0N1+KCTuZJQrwmvz3oPF2X8Cznk4tkmvOE84AlKtwFuIr/rJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jx7EBz/0wQ0PiXf5Br+j7S6rZTFHwKpSTDnoFqC0D4=;
 b=nDH9Uc37h+VK9dJJcRUP5vF37YTLzEP3ZkpuZJ/5gHhtmRER61SKqY5DFtz2O1xRBI6qfpFwgXDS8xBQVybV6PckVpWeba3okjcfoH7C24cVSxht3Dco8eYoLLxQ45l4KuYkaJLErnI0SHV/tx/h+n+tG19LaYzUOTmARYjHbOv0LBTYkBKWu5eMsLCIITUkk6LMze3crPNz2iHO+sMHJqHKs8I0gZQZUbTRHc+vU7M/zFJa7dcq0pYv0if5ywS06QqXRjWBtqOfiGlYTP/YVW2+cVEE99WsJWjVxt0xmcZdCk8hTKuN6jLLf92l2CwccdzXwaPG4XGIF10v7arZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jx7EBz/0wQ0PiXf5Br+j7S6rZTFHwKpSTDnoFqC0D4=;
 b=k+UIif83uFFzX/nU2qQpgQCHs2GsijW5z8apxO4/Md5bNdoM7K3TGq7mKe1vzmfHIMwEPQyG62RzxJXAtD3lyweTGNV+WboR2xtQQrc+bwY7uRe+Yplm0F5feJZEHlPEYOSsB8ptg1BH2NwhyWLaqKhbrt2OUHRgrHSoKrV0qLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 19 Nov
 2021 09:05:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Fri, 19 Nov 2021
 09:05:50 +0000
Date:   Fri, 19 Nov 2021 10:05:49 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] ssh signing: support non ssh-* keytypes
Message-ID: <20211119090549.uggwmaxjq3yg3fyj@fs>
References: <20211117162727.650857-1-fs@gigacodes.de>
 <20211118171411.147568-1-fs@gigacodes.de>
 <CAPig+cTVX5yYp-1eUjCgj6aox9vYpzm+JFvson37M0R_pnxRvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cTVX5yYp-1eUjCgj6aox9vYpzm+JFvson37M0R_pnxRvg@mail.gmail.com>
X-ClientProxiedBy: AS9P194CA0030.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::26) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9P194CA0030.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 09:05:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8f2b83-c729-41c7-d8f7-08d9ab3bc877
X-MS-TrafficTypeDiagnostic: PAXPR10MB4815:
X-Microsoft-Antispam-PRVS: <PAXPR10MB481539DBAB3CD84195A1EFE9B69C9@PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNy0fgkIVc+nFBc2Z/ykGnZmNBO6Lz7Znlql+594kuEzboAOk2SDrGyEt2z5Ii6rAzYRBtsJy+PGEd9ycaIAwHYBtqeLtBUWQmzdIEref46+viKgKRGxUHnq/gDddXwYNzzVHn3wpuWsShWo82r5aeHaxCe7GJ+Ud7GWK0pgKgeT8IKcC06Q133Crq9uIrRHOQ9wSyVt3H4GAZfRA5VWpcGTAWPzn13LI05tE7VellB3Ay9NUixefa3IB6cmSLGklgTBr84PNWWh/hY6kqi11nW7Uv3rzTqyzR36+bpkk5QY5S53VGaZRskbxskSrVgw/RYrSjZ1NjVQ3320t3rBQYvnISPwGPu1zyhSxQXGBYgCUcLn/hLalIL3B1wIusQPwCBNnLLTu9faHMfW3bSAEWKiX9W4PE0bSXTyh9QhhFyMxOIPqU8qncLVbsrZgrlSd+QXMPsGrB5YRWTnbVd0bJVTf5vbDDWKV+mkUAItbFVr91CYerv81Yd81TvncymlYSqFsfxAXoPY9+7qzHQpt3VQSEiG6eXbVAlYOUVmuL+ZDvoPUu2qUDH5GMPr9rn26IykC00rh6J2LC3nx7aYCMyADS7vrstostfdsig2yg35W/DNjXGvkaFDHicKGzc024g8dkY78lGLCLeXCFu0vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(366004)(376002)(346002)(136003)(39830400003)(83380400001)(54906003)(5660300002)(66556008)(316002)(66946007)(9686003)(6496006)(508600001)(8936002)(6916009)(86362001)(33716001)(52116002)(66476007)(4326008)(6486002)(38100700002)(186003)(1076003)(53546011)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmx5WDV5Q1NzcHV3QTZ2eFhxWk00dWFtRE1TTVJIZEtmcWJSOWltNEhCSGN0?=
 =?utf-8?B?SzhiNTNWdmViS3o0MFgwK1hXWVArT0JwUlZQZEhBS200Q0ZqVHBvQzRPSEJn?=
 =?utf-8?B?VW1sWWtEamtPSFRFYnE1NzE0RjF3Q0IySzBSQzJTenRjM2FLNFU4L3dOSnQz?=
 =?utf-8?B?c1FIQXBqUUxHZmdUVDFRMWR2bXdZbFowdzJjb2NJSlpNdldMTDM1L3F1OGtn?=
 =?utf-8?B?NW1HRDFqeXpUSFpTOXdhUzJmeEh1QWlXdnRuMjkwdFZaL0Q5azE3WmVwQWl4?=
 =?utf-8?B?ZHRLblBsOUVmb0JCNHpYN1lqSW5uaHBwUlRiam9Hb1oraW5GdzFRb1E0eXdw?=
 =?utf-8?B?dEFsTjVzazg4TmQ4eHF4NkMzT2N4UitZMXRvSy8waUgrNVpuTmNFUmg0WW9L?=
 =?utf-8?B?aWIvejhxY0V1L2d5cWJ0Qy92TDFnVmpRLzNoS28yd0szODN1WXczMC84NTgr?=
 =?utf-8?B?eWlJc2V5eWsxZU8wMXcybEFwOE5LWURzMWtseklBbS9hT255REVWVnhtZktJ?=
 =?utf-8?B?eWN0amM0MVVXUFJwRU9XK1I0OFo0VkRzbVl5UVZpRnBFQkhZTVVGWW1zTk90?=
 =?utf-8?B?a1pqZCtFMWpJVmkraGp5RllzdCtoN3R1Ynd2N2k0R0FJTG9ycGE3Y0JPQmJN?=
 =?utf-8?B?cDZwdzBXYUtxQ0c2cFVJYnhKSW9aQmw4MnQ3b1EzYkRVN2VUODkvZGdXajdk?=
 =?utf-8?B?d09sM2xETHRBNWk1N25JOGYyME5jZFNpM3VuZ1B0V2VpZVRqdjA5am9QQjVu?=
 =?utf-8?B?UG9rb21qMTFwdERJdWxEZGdMYzFkN3hTSDk3VEVQdHVFQlI0bEhrOUZSaHV5?=
 =?utf-8?B?bmxGTVN4bnpwWDhic0JNdFBoRFJiYmdVL2hENTZMWVpWL2t2T0VJTi9NelIy?=
 =?utf-8?B?OUhSRFZ5bGZQYStkNFNEdEh2cUVKQmROcEd0K2NxNG9YcUpMUFliQm1vZlAw?=
 =?utf-8?B?dTBvSVVMNXhDdUUvSFMreWNBU1RKTzNkT2diWnZlcHd5QlZBeTZNcmlUR0Vm?=
 =?utf-8?B?TitvWXl5RldXYUpHQkVmelE1eE82MmZnRWorZTJ2WTRSSm5HbWtTQVpUZGM2?=
 =?utf-8?B?R0ZwazRXRkNGYkx3Q0FzMEpIV0I2a1hicDFZT0QrVlF0d04zMjRFUmtkdzRQ?=
 =?utf-8?B?cEU4SFNieXFuNzlNemhDK2p0Z1lieXFCemRKeVl2VXllOGZuTDBlV3MxTFNF?=
 =?utf-8?B?NE42UlV4ZWwwNEtQemlWdFloMzhMS3N1RWhxaEhxRm5SNnRPWDVMYzdoZXYv?=
 =?utf-8?B?VzJ6eVdyRFc2VDNWMlN2RjhtS0h1SlZIbGpocHp2bTFpWW41WmZpTWpyV1J1?=
 =?utf-8?B?UVdMS3R5Mm5QTkM3d3RpZ1pVTFhoSHJGRmptei8xQ04wNUFwZDRPWi9RWndt?=
 =?utf-8?B?TmlTeWVDekRDNXdXVmdQUlNXVVloUmIxU0dIOWM0c296QXQ2RlQ1WFo0Zk1u?=
 =?utf-8?B?elpLeCtuK2ZqTk0rd011Mm5PMzQvVlVqWkh3WFNucTFVY3IrSGFhb1BUaGxh?=
 =?utf-8?B?YUM2MjBubnQ3U0k1bVVhU2h1SmlobUVFR1hSYStoMThJbEVpS1FXeE1SMHlo?=
 =?utf-8?B?a2NmcDBWNGFBQ1lDbUgxd0JqQnRKZlNCeDhibDlLcndUTjlNYUR2NGE1cld3?=
 =?utf-8?B?elpsQ3FIRUZRRXBVTGZ6YWNyY05ZM20vY2k4NmxsQVBDL2o3SVlHWGF3VE5v?=
 =?utf-8?B?RXBMNmkyUFBwdmpMRHAxeStTQkdvVTdmYVhRMHIvVkRDdDRMbUlkcDN3Yy9n?=
 =?utf-8?B?Vm5MbWZkbnlKNG5GTkY3bGJ4TWJhdngvWWdoWHViTStpVjRWMFdjTVZPL2s5?=
 =?utf-8?B?UnRsbDQ2eDB3aVd3UHFuQUI1dTB0ZllHSFNlUGFLQWFTWldVZWFCcng1Q1k0?=
 =?utf-8?B?cXp6RCtHTjg2a1hyT2E0OTBSWitJTnFMZDN2cUdncVZHTm44QUJnakV1L0ZP?=
 =?utf-8?B?UGVVRnFoVllFMEtTT0lMb2hzMUs2V2dmQmViQ1J5ZS8vUlRsTFBJLzZJZ0Yv?=
 =?utf-8?B?eFNYcTh0WWY0RHNJYVdGS3d6cThsK213SVhaRUE3NTNiUXpGTkhYMjU2b1RW?=
 =?utf-8?B?STlRb2dGRW9OL1NlZE1UL1ZUcFZrcDJDdVYvMXFEUGNQL2MzOVhJUjNvWEpL?=
 =?utf-8?B?TmtxbHFFRmpFSm13MURwdWYrR3NNZndha2V1Ym5XQzdKNDhYd1NubEJwNTN1?=
 =?utf-8?B?MEZXSnB2WFlUc2NsL0ZDanZMQ2lKd1VyYUlPa21sM0ZqTWZ2UTdjbGNTcW9H?=
 =?utf-8?B?S0IwdDg3RGQ4QjdoSmEzaXBJN2ZqTXdwWmFtVWMxVmVWRXVCaitHK2piSlps?=
 =?utf-8?B?L3NHQVFLU0xBM3JtdTJZd3B4TWxTUjl3d01LamV0WEtMUFhYZFZ0QT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8f2b83-c729-41c7-d8f7-08d9ab3bc877
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 09:05:50.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOEPtMsJ/1rbDi1oZM8wP8Vp0DGnASlkTtFFYznbE7cFmpPcNSE49oMxF9KUy0cBXspdH0T4nDLUO5P5w7fMkrSM0T5uN8CXyhV9xjmeA1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4815
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.11.2021 17:14, Eric Sunshine wrote:
>On Thu, Nov 18, 2021 at 12:14 PM Fabian Stelzer <fs@gigacodes.de> wrote:
>> The user.signingKey config for ssh signing supports either a path to a
>> file containing the key or for the sake of convenience a literal string
>> with the ssh public key. To differentiate between those two cases we
>> check if the first few characters contain "ssh-" which is unlikely to be
>> the start of a path. ssh supports other key types which are not prefixed
>> with "ssh-" and will currently be treated as a file path and therefore
>> fail to load. To remedy this we move the prefix check into its own
>> function and introduce the prefix `key::` for literal ssh keys. This way
>> we don't need to add new key types when they become available. The
>> existing `ssh-` prefix is retained for compatibility with current user
>> configs but removed from the official documentation to discourage its
>> use.
>
>I think we usually avoid removing documentation for something which is
>still supported (even if deprecated) for the very real reason that
>people will still encounter the old form in the wild, whether in
>configuration files, in blogs, or elsewhere, and may be perplexed to
>discover that the form is not documented (thus not understand how or
>why it seems to be working). Instead, we can discourage its use by
>mentioning clearly that it is deprecated and that `key::` should be
>used instead.
>

I thought since this only existed in the docs since the 2.34
release a few days ago i could get away with it ;)
But since we keep the support for `ssh-` in the code we should document
it as such. I'll add your suggestion below to it.
Thanks for your help.

>> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
>> ---
>> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
>> @@ -36,10 +36,10 @@ user.signingKey::
>>         This option is passed unchanged to gpg's --local-user parameter,
>>         so you may specify a key using any method that gpg supports.
>> -       If gpg.format is set to "ssh" this can contain the literal ssh public
>> -       key (e.g.: "ssh-rsa XXXXXX identifier") or a file which contains it and
>> -       corresponds to the private key used for signing. The private key
>> -       needs to be available via ssh-agent. Alternatively it can be set to
>> -       a file containing a private key directly. If not set git will call
>> -       gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the first
>> -       key available.
>> +       If gpg.format is set to `ssh` this can contain the path to either
>> +       your private ssh key or the public key when ssh-agent is used.
>> +       Alternatively it can contain a public key prefixed with `key::`
>> +       directly (e.g.: "key::ssh-rsa XXXXXX identifier"). The private key
>> +       needs to be available via ssh-agent. If not set git will call
>> +       gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the
>> +       first key available.
>
>Thus, perhaps this text could end with:
>
>    For backward compatibility, a raw key which begins with "ssh-",
>    such as "ssh-rsa XXXXXX identifier", is treated as "key::ssh-rsa
>    XXXXXX identifier", but this form is deprecated; use the `key::`
>    form instead.
