Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42320C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C58C61050
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 19:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhKCTsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 15:48:40 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:38848
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230172AbhKCTsi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 15:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOKydhrljIBJqd8YUZ++NeQK6YBz7kc/2V8QHEAl/OWRM7QQ8HcBs/D5gzzpeeN96Brf2IcerlpODBMCVAMNSmFVoQvkR54SGiaWSWXrOdM0CE40hG5ZdwTO7rsto5puJDNVaZz9ZDGcUTwZqY2kQDCbWpm9d+did8ikWCxRa1Sd8f68zCOJdmRAwytxexaCB8+oAIhuUl3UYiD22BPkJCEk1TKLZYIbQ636LDRSM+LHqvNf/AZtm8dBRR6nVIVmNDdoNGCIuvlt0w8pt3gwPcWnINcQiWYDfDFQpgZrG9of/fUReq39EqKz7Fs7dV0h35PYnMshzKXwTY5wIIzgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkP2BsRka43pf6+OZz5qPTLitF2xuN0YT58CeR5eot8=;
 b=n3fBV3OzzN6x2T9jzcqK1Lg2JGBLEUVRuSlYsVoFmdL5WbeYM9mZzFQlKBysEyX4erHoOL2k7UVXNRjkjhqYjRqxKIoK66wvPrnT7uEFYOBTyp8oWlMolTcVJAVuq3ql2wCa8HcB1OxpQK1EAUb8U6iC7SZ/McAfAYZGD0xs5IFCBlpYARfuTlgx8O7qsUXYNdXj2L1NCAXMjsZ0/5xHIROmwLuvcMb64U9AHVvFvi2bIM9SPQdkMaZF2Cz3vjkWPOwVJLfvSG74yp80o7HfbPWWubdOqv+2KTOPtSiHuTYUHiRGQP7XJmzr9OfohuhCKjy1bFXIVb37ghYWI3J/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkP2BsRka43pf6+OZz5qPTLitF2xuN0YT58CeR5eot8=;
 b=Q1BidnqSAtNppkQHtgfSr8HSJ3J0HZwl46GVFJt/zM9Sibgt8RFg1fXM+LTnU6/wMorqDqpMqiI5P4FdYakphTfiz2+/mQdLl3/KmD76UbonmLPsr9FjKhiUNtfDaEkOnbdt3IWDDQvTO7NTIJac9jZ6FbGT0iuQnapGt4BJD90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 19:46:00 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 19:45:59 +0000
Date:   Wed, 3 Nov 2021 20:45:58 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] ssh signing: verify key lifetime
Message-ID: <20211103194558.xqcsaljvcoontnal@fs>
References: <20211027080616.619956-1-fs@gigacodes.de>
 <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+kUOakzQ5aEQf81rQULiz6FRdmCLnbhspt9e6behPS3sbZT8w@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Wed, 3 Nov 2021 19:45:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4929d6f2-4ae3-4afa-ced0-08d99f028f81
X-MS-TrafficTypeDiagnostic: PAXPR10MB4669:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4669EA9AD17565657502712BB68C9@PAXPR10MB4669.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EcreKVoeDj/BI2i+YjS4sxX+0GbJHFU/CfZnGr/+0rBgSi8x34N9kjFkKh+WAb2XIFs25Ig5eXxnVEapA1ldyyXWMuRVLpaYdMLxpV4h4r/KKhwczpbGxOhk33dh0c4RhSTmnHX8/5U00gsrp7gTp4/q8YRLCrmAvdJDXOkBjwMQ6KldpHwiANRHdOVy0mNM6W7W0hxejuRd+b9ffU4MMNW/J/R9bDJkGmxpkT8bNQ5E6DjkqsAUL/g73p3v4wEFX4VLT/tW9TBaZvOGkS4CpeTJ0DiUoOZ+Me+TBCutW+mbtWFPKfvWi9cMgMDnQovExBtF2lx022ZjfKG9Pa1KMLK2aLNrA6kXdS3Qrdu/vb8iDXMxTfYxqfMi1LpXbHezNcnLt2aWoDKXHo7qbSkktV6iIi3cHPt6D+V8ivkfbwjnJ94PzLJOnVnJWHtWl/3q8oOXVIWBRxSLlOg+sfHPYab5CMnloEALVz2wJRvyEmYrwbwg4Sbw6+Mbu/HQ0aegIypYnZ8gJbkdy3ECDsYG0AmIopG0+C4UE+UMqkHvvlRzIZ5aCwEzKtK/tRXAcLt6wKisnZn3o7qfA0TUZWHM+jTyqWpfErG7FypTFT8fH1O8B2JlMgoXtrkgR8Tc2jGxzUvB4FpCKXYGMPtnH8/68g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(136003)(376002)(39830400003)(366004)(3716004)(38100700002)(4001150100001)(2906002)(316002)(33716001)(5660300002)(1076003)(86362001)(54906003)(8676002)(508600001)(83380400001)(66556008)(9686003)(8936002)(66946007)(66476007)(6486002)(53546011)(52116002)(6496006)(186003)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUVUUzNVK2VqNDBHSUJJd0pxVU1SQW8yblZIV3VGZGN2ZFcvSktSNktCSlhm?=
 =?utf-8?B?a3FGRHVxZHlKNUJINkc5d2FreXd2dzduZUhXTmN4YWxzVDh5MjRYRlBiclVz?=
 =?utf-8?B?QjhaMXRQWXp6Y29ZeVo2MzR4UE9wWDY1RlB6OEVCWXBUdFVBaWNnWmpDVkFR?=
 =?utf-8?B?SkxVeWRvR205L3NVdDBvZkx5R290U1NyQkthLzZtaVY2eVpQSERUSVEzY0ZV?=
 =?utf-8?B?UGdJZHNWVG8xdktyWWtTMU1PcWY2TWRuSnRqSjExNzRkVWtmNWpaVHlObWxZ?=
 =?utf-8?B?ZUlkallWQUE4NXdYR2RxajhhSjVPK3A5TVpZRmx3ZEwvdExhSzJzZXJuYjF4?=
 =?utf-8?B?eGE5NzkxbHAyYi81SDV2TS84R1hvVXhEQTRKTlEvSGVaRi9FUDRXekpnN0hG?=
 =?utf-8?B?ZUlSck5aeldaWVlXbG9SSW9LSGNZTVVCWDVPL0pVVzB5MDdVdHoxalRXTXd0?=
 =?utf-8?B?cEdXc2ZTWi9TSjdCNllNeGhDQ0oyVkJjVnQzNzRET3dSTStYMVBvcEFTcHFi?=
 =?utf-8?B?a0x2ejB4b0JNV2hCd05EQWIxNDd6dDFtcW8yQjdRYWpnM3hyRGc0bUNESUdu?=
 =?utf-8?B?eXJYaTFVYlp2bnZBZzBFaWRRZEg5TjNUb0Q3WTZlOFNNU0hvZnJjNkUwSDBL?=
 =?utf-8?B?a014TnNKbEo3NFNIdWRPVUdpWGtVZ3RDVUpHRWl5VkF5MEFEc2Q5blZRN21p?=
 =?utf-8?B?ZlUzakc3TVJ5Q2JGeVU2RVhhY2E2ZnZMa3g5bTN5eGRBTFBEOE1YcVJZTGlz?=
 =?utf-8?B?bTRuK1BhSk9XbjBERnM1YXBEemNnSzYrUXlUaW5HVzBVdTNJZVhrbk9zSTB0?=
 =?utf-8?B?Z296STk4bGFTbi9nZEFPZW1PWDlxMlVoK2I1MURSTGJRQnpmYkFYeFRUZTE0?=
 =?utf-8?B?TmFlUUExc1NzK0kxdjJCclVKcXNpYXgzdGM3MHJnQyszMXVOcmhmTjhLNXhU?=
 =?utf-8?B?ZmgxZTUzeXdsUXJ1enB0TS9UVi8vVEJQcXk5TTJvbWVvRXdkQWpmbSsveEd5?=
 =?utf-8?B?VmE3VTZCTmxhZjJST1JGMC9ZOWpkSEFBTWllUUlDWGlWL1JsaU1FTzZPdFk2?=
 =?utf-8?B?QVI5eDU4dWp6R2x2YjFJMnhXdjVFS2J1QlozTEhYMFFyenBkOUNjc1UzM3F4?=
 =?utf-8?B?WFMxY3BKclducTJ3UFhZNkI0dVc2WFRGeFBFcWV2Zll1MksweWxJYk1ubm9l?=
 =?utf-8?B?R3l0ZjhTdmYzTUNoOHB3K2dZa3V1Y0JtR2thcmtOWEFia0RnOTVVeTRiaVBr?=
 =?utf-8?B?c3JnS1MrQ3dqYXdlVER1QzZCTm9iZlhuWjAvd2VhTFJudFRmTTdUaEZTWnlH?=
 =?utf-8?B?MEtTZEhrWEJDY1JYdldqWmpOQytFVSs4UmxKeGF1R1NpK0YyMVM5MFNLQzhx?=
 =?utf-8?B?WGthc3BYeHViOGNMVXUrTVFyVEF0ekkrT09uWkRFZWxuUnA5bnZUb2hOMTlX?=
 =?utf-8?B?bi8xMEpic1l4bXpCWU91V2h1SkRDTGcwenlrTUJNNkVMU0FUK1RYdGk1YTdJ?=
 =?utf-8?B?a0NENWE4UUhzbWdaSW9zOU4xRE92MXV0S1hzWFZHYldDMXlhMmhGZEJxVkIv?=
 =?utf-8?B?blZmeDR2UXYvdXV3RmI0aTBTL0hzMXZ5NlYvNTZESmZ4RE5QSTgyWUJ3OExm?=
 =?utf-8?B?cTBZbkVnR0g0MUdGL2pubU5hQnJhRHhPS1hvOTRxMWJtVzU1czBJaWRpNEUx?=
 =?utf-8?B?dmtMbEk3Mi9SOGZTTnlJUS93R3VKaWVHbXJCZE1taUZsY0toL1VUYXFNaXFZ?=
 =?utf-8?B?ZDgwYndVc0lvT25naWw2Y2NXMXA5Z1hHTGllSEwrRHAvM1d1VVhNL0l3elJ1?=
 =?utf-8?B?dmpLaEJiaXk5Tk1MdkgzazhxZk9wQXRsaDhIQ202YTVVK1JaTDVwVDhWbHRO?=
 =?utf-8?B?eUsrK0NSQmFHZXptaXE3SC9YNXFSbVNJb0xQOGpnTXZZbURndHNzSWJITGpR?=
 =?utf-8?B?WUw0WjlUaU41bkd4MzVUZUllVDlCdWc5YjBOSnJza2hDSlFwdTdkdU1BTW4z?=
 =?utf-8?B?aHMyRGM1d2xFN1ZURGRtS0RlaVhZWUZUaWJKQVV3dksxcjRzT1pObWp1d0pp?=
 =?utf-8?B?eWVvWE1JRXRaMWk5UTJKeDBQM05uQ0xPNExDZUNVS244WDJ6TldnczhrcWxC?=
 =?utf-8?B?a0ZwWlo3WVZqWHYwTlMxVFV6dWFIa1JOU0lad2JnNloybXVlTnRaa2RMRnlp?=
 =?utf-8?B?d2pueWM1TzlOWXZwaUt1V0doOG1ENHFYK0lPTGxZZTV4dnNrQnJMaTNoaE84?=
 =?utf-8?B?RlNRWGpIOVFiUlkwL2hrVjZxNys2cGYvbHUrRDBVVTAvNmdRdjI0YUtmdGRC?=
 =?utf-8?B?K3pPcHM3em9rVGdIZTVEWFUrcnNPUktRK25CeXhWR2hWUmMrVzhSdz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4929d6f2-4ae3-4afa-ced0-08d99f028f81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 19:45:59.8106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIArKSsYmh5AGtMIUA5PIrfbG7XQUoJBg1uFhN9306beKqdXvqyToyWrjb3WtmC7aLFyxj5/kqGRNy402kj9eNqwV2N2LZ+zcFB7BRVkKUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4669
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.11.2021 19:27, Adam Dinwoodie wrote:
>On Wed, 27 Oct 2021 at 09:06, Fabian Stelzer <fs@gigacodes.de> wrote:
>> This series adds key lifetime validity checks by parsing commit/tag
>> dates from the paylod and passing them to the ssh-keygen operations.
>>
>> changes since v1:
>>  - struct signature_check is now used to input payload data into
>>    check_function
>>  - payload metadata parsing is completely internal to check_signature.
>>    the caller only need to set the payload type in the sigc struct
>>  - small nits and readability fixes
>>  - removed payload_signer parameter. since we now use the struct we can extend
>>    this later.
>>
>As part of testing v2.34-rc0 on Cygwin, I've found this patch series
>is breaking t4202, t5534, and t6200.
>
>Specifically, bisecting points to f265f2d630 (ssh signing: tests for
>logs, tags & push certs, 2021-09-10) as breaking t4202 and t5534,
>while responsibility for t6200 seems to be 9d12546de9 (ssh signing:
>fmt-merge-msg tests & config parse, 2021-10-12).
>
>I've not yet done any investigation into the specifics of these
>failures, but I wanted to report them early so other folks could get
>on with investigating as appropriate.

What exactly are you testing? This patch series is not patch of the rc
and will not be in v2.34. I even have a small reroll of this for after
the release.
I assume the breaking tests are the new ones added in these commits.
What openssh version are you using? (ssh -V)
Either the feature detecion for the lifetime checks is not
working in cygwin or maybe you have the broken openssh 8.7 version.
