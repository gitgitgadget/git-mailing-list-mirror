Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C7EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 09:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhLUJjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 04:39:45 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:54503
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236423AbhLUJjp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 04:39:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLoqkVXsmglR1LyVuLmlWBN4ELWuels/by8N21bn86zt2e7YpvaoQeiO2XpZRa27lVbG499tTNupLFbC0SwNOL27+QAqLolDK006U8dLBX9RsOWcSVuZvX5nkospmsiCj3Me5Ul42n8x2e29lZNOdlfF00tnCkh2EwCijUcdWnReX0swOQIoN9MnFsYYPrOphHKlpIaatsaFdlLjmb0FZ6LY9lbY4uLWAWkXTaWP4eOJidDv0KYuiBpV4SG/92eMwQo1e3JsmSPFe+fmyGUSp3BB8EsZIuejJbGmZ+/iJV7G0BBE/ur397ZlEHyz9HW7ge0iSDFp1kKI4FL19NBuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd4Uo8n462dhlDN83LGP1m1a8AO8yBPL/+BEPNJJJ6U=;
 b=BEnC2CRe7TS7mCme2wFQXAr7YFG5KbKFnqSs+C+mEq1nXeIlztcR24XeuGfWphRfQuJsnCvixd3EZLs0ShL/jdk5lXd1CgUZEYwsKYZkkE6cx8cJaa4Kh0uxBSxuO4fahcMghaeaDTwm76NIesxihhY7BSzsHMhF4pZy3jzSNktH4BgguvvS4pVnhHm2So2igsH+QElxC4AhmoqXCUWl+eR1YG3bvXHHDmUYHTIX00XvXKkFsdcJG2UXFxJDFzQPomTJiHoP2LZbmhA0JwxanBfnmX7EoqGrF9YPiN88LrhGStP13eKIAR6AitipaZ0ZJVAElovLesCRcn//L5TUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4Uo8n462dhlDN83LGP1m1a8AO8yBPL/+BEPNJJJ6U=;
 b=ihvyNSnNearO4TXYN2NFP+OLPMaxCEZpAPooh5x1kGnzczjVJD/k5KXt7nMFT6zYONMPpU5CsRa56A+elmKizMkiPJ1P0kYKeRJ82FAkt8sA8UbF1V4Xe5Cg7qoOuGAnm2BjjdoTtWCtsNnWo4tbixJZtnIjQFUZsY/OpG0o0Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3803.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 09:39:42 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 09:39:42 +0000
Date:   Tue, 21 Dec 2021 10:39:41 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/2] crypto sign: add cryptoSign.* config
Message-ID: <20211221093941.53ks5gnbkxl7vkn6@fs>
References: <20211220140928.1205586-1-fs@gigacodes.de>
 <20211220140928.1205586-3-fs@gigacodes.de>
 <CAPig+cRGnMQaDj-qocpAbhQqyksCNqGub+LsspWf7-Dwy=TKzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPig+cRGnMQaDj-qocpAbhQqyksCNqGub+LsspWf7-Dwy=TKzg@mail.gmail.com>
X-ClientProxiedBy: AS8PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc7cf97d-79d3-4747-f50a-08d9c465d0df
X-MS-TrafficTypeDiagnostic: PR3PR10MB3803:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB380312F3491AF8615F348A54B67C9@PR3PR10MB3803.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6Doq52C1camTVWswb3qPoAFyFxPznb1tXjiF78/jaAqyPZ9fcYp2Qx6t/P5BTEeIcnVNQA5Mb0vOTTCviDGfaBXg+ZVtnsp2MfuEYY6R6HJzkTj80DkhlzyF09o8fF5rLD8DYs2pJ41YS4pixgmJTnibylk0Kdc19D7yl2e+t9D17ssmMJeB6ZXcqxJJAdb7lWTIvawkz16dDTqiZdess9iHZY1itQMplmwepD5DPCoBA3XuDSvsyu3obmx9OQYaVjjzpkZnXraylWjE/urjFgsKnDQ5mqcesvLXK04cRvoxDs115EGpuoxEca7gj0HJpr/+qC3tSnAdiKvbswEqaoF82t1rl7PwBzL2U36XOniI/V2UAbfQXmpbULlAllu5utheAytqNAwcQWzfvM5pmPBoTpbsUpO5bw9mNUEjKZQl7utJFDHG7tfaXREfyXqKx1SfZlr6pr7H6YmDJUntA3wRfJmBsM9bSh52HWlEM+TyyHfoT0FbBtd8ZpiNczH7smQ1E0uiOG1UJTXTCZEyUjejtHGSw/O2VFuXFu5tZAHlk59IpGF4LJ8lKvBONh2tZ+zsF7Gw3c6AVn5c2oKmTG7omUg000QU83/WcNY8XagmfWWdxAujjCyNQ8nId7sBH/s+QDl4mmP7fl6QgeH+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(346002)(366004)(39840400004)(136003)(376002)(508600001)(83380400001)(66556008)(6512007)(66946007)(186003)(8936002)(66476007)(53546011)(4326008)(9686003)(54906003)(6916009)(8676002)(6506007)(1076003)(316002)(6486002)(2906002)(38100700002)(33716001)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRSenJ3RnRISnE1aWFhMFlIWGk4d2E4UUptRDJndnlkOWh6MXkrYlBpbW1T?=
 =?utf-8?B?Z05YaWMwc3laSTh0cCt2QUpXemtTYng5bGJHUExzTEU5M2RMZlJvallrWm1w?=
 =?utf-8?B?citnK2lRZHpRc2kydzh1MHAwNGtWeVVQTzJQSG5xZTRWdEZWb0dPS0FVcFhJ?=
 =?utf-8?B?MWkxRHBkTXZMYm5FK1RGeit5QTlLeERvMWdEQkd2bnd2ZUhDcVVsUjMzSkpT?=
 =?utf-8?B?cFl2eHFROUEzY3pvU1lad2pPWWZVUnVtczUrQ1dUU21rQ3lsU3d5ZXpPdzlq?=
 =?utf-8?B?aHBEMDNEMFovQllibXl2OXpXYlZIQ3Z2ZlZiU203VHNjT3p3WW5kc1Z3cG5B?=
 =?utf-8?B?NTIrZDlKRzFqd0dSaDFOUDdkNkNBWHNLaktlL3RHbjBFNy9sZDdPN2RNaU9X?=
 =?utf-8?B?UnJEMU1KUTQ4Yi8zOGVjVU8rV2dVOUVnK2htVjV0ckFLWTBXeWFobEQ0VXk2?=
 =?utf-8?B?UDArRVJ2UDhhSzdhMG5LUlFNaG9GZm02SEFvdWZTYUpRRnZqbjBheGcyYkY1?=
 =?utf-8?B?YWdDOEtEZmxyTGJKU2ZENStlMmtSWmFwOFZDR3R6T254cGhnamMxWHJJTXJr?=
 =?utf-8?B?RzB5Q0MwUHIyazM4QTlnVVc4RDdJaDdsSUMwV2hTSGJFRDZQNlF2c0hONDh6?=
 =?utf-8?B?dGx1Sjdjb20zdTQxNDZtbWlYM2lKU2hrSUk4QTVxbXpycUVzODJUS21UanZX?=
 =?utf-8?B?WHdRWFZXdlE4VjM4WGh1WWdsYnhUbGIrRzZ3dXN3ckdvU1hBb1FVN2oxZWZ0?=
 =?utf-8?B?bG12VmhmU1J4WWJzUzRpUS9PTXlOKzd3ME9INXcvcUxRWDFTZXRHRDNqeGl5?=
 =?utf-8?B?bVkyV05Cakl4TlJBb2wwaVJRMGlNMkdGbGt5b2NBNnFmMzJsT0VlWWdQUWRE?=
 =?utf-8?B?Q29YWk1jWGJrMUNMeE4xZkwxUi9hVnhsS1hsVGYzWmxYN2lFVXVtdXR4cUVa?=
 =?utf-8?B?OEFnOURtZWZHdi8rdTlORkpQMkFSQUI2UllDT0s5MjdMcDFXd3d6OXVIaUFW?=
 =?utf-8?B?TGZvc3l3VlZWWkhzdWRUR3dWVVdJK3YvNE1ITndlZ2JzTWJrK1ZVMnhjV0Rt?=
 =?utf-8?B?UTBCVi9hMjEvWTlNK2tMVjlSbzdLNFJUNUFJUkNDYzFBL2lycnc4d1ROWGl2?=
 =?utf-8?B?OVNSNnJFcVFqL2hQS29XWTRtd2ZsV00wVHBsdGVKLzdVTDR0TytSYTd3NHcr?=
 =?utf-8?B?ZUtweExRdWMvTkRrOXJybS90dm5nd08xRFZ4RjdEVHJaTWk5bThlMmxZUUQ4?=
 =?utf-8?B?dk01Z2tVQU9NRnEvQWFpRmtib0tiVFlxWUhOMENoWmNzajhkcFlocUJxcjRj?=
 =?utf-8?B?dUtzYnI0akFQRUFqWGQ2NG9OeDZFZkdtbTFMbHRMZ0VQdTN6amo2eFRXamhv?=
 =?utf-8?B?cVZib2xmSEFuTXRMdm9uZHNrWGFCMkVxeEwwTkZyUHNnMHhaVmJObEN4R1JE?=
 =?utf-8?B?cGlhbmtzSHNLSUF0Ui9BbmVkbzRpNHdFcGJpb1NEWGRFMDJ4eldGMUF4UWk5?=
 =?utf-8?B?UkxJczNNMmhmWVNoNElQeVdWUjl1ODRGY1BPQlN3TXArcHViVmR6OGVvRU85?=
 =?utf-8?B?RTl1djZnT2xhMHQ5MkZOMkpBajBRZHFGRUcvTVFtbC96eW5QbVJwRmdBbDc3?=
 =?utf-8?B?a3pKWi9pV0hZNExnQzJkMGpDOWRETWJKS08vL2V5bnpnNW14N2VtT3Z2aHNw?=
 =?utf-8?B?Zm9lS3k2cmhrL2JrMFA3eW1PNVZJbkNiVEIzWnNHaUM3SGtlRlRqNFNMU2E3?=
 =?utf-8?B?eU1YOFdHbGswR3RhdjYraWw1NTkwV0pSdURaamgyVkUwam40Z000QWVBK2ho?=
 =?utf-8?B?b2MzQ2lDdzRiWVU2aHdqUkc0YS9ncW5jbnZUMmN4VkovcHpWeElNeCtpNzEr?=
 =?utf-8?B?ZjVPcjRDckVSdjhzdzJoUkpHeXRwdElkeEhXODBqSUt0dm5mNnVHK3ExZjNx?=
 =?utf-8?B?K2pqeFFRY1RhZ3RiUmNFUWtCcTFNODVyYXRxMkxWSGJMY29lNEVTMTVxY3hE?=
 =?utf-8?B?RytWY0dWNFd3aTJvQmRuSGpRMnlkQW1PVDVwRUZaakQrWDFrRWNSTWEya2xh?=
 =?utf-8?B?NVBjV0dmT3J1VUllVnVTbG1ZemI5NmY1eVVMMGl5V3h0TkQrWk9DNXRTRFZV?=
 =?utf-8?B?YnlUVi9EK2p5MWp6UVpiRUNNbmR3eVFPekxVQlFTcmI3MEMyL0U0SmF2Ymk0?=
 =?utf-8?B?d1AvMTVoZWVFWktlRjV5OWRjOFl0QncrcVdkY3kwMmxiMTBOcUl3WUR1UW1x?=
 =?utf-8?B?bnZ5dUNQYkR5MnZ2MW40VFBUVWRGUlBXcG04STN3SDBXMFVsemtqbkU3ZmpB?=
 =?utf-8?B?eTlCa3hlekRsOFh6VGE5azd0ak9TODVNOFAvUWtsaDNiN2xFVG9oQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7cf97d-79d3-4747-f50a-08d9c465d0df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 09:39:42.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3fmBZoWM+YCmq3jszZ7LTLxaWrZYrAWJs0SUGD/x/EX4830x+ij0a8ZH9ReMlmEYwj60zffnk7IFLw2DmwO8PCtJmYHfuqdtpmSF9Azs50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3803
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.12.2021 17:07, Eric Sunshine wrote:
>`On Mon, Dec 20, 2021 at 9:09 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> Since git now supports multiple cryptographic methods/formats to sign
>> objects, the `gpg.` configuration prefix is misleading.
>> Add `cryptoSign.`, but keep `gpg.` as a compatibility alias at least for
>> all existing options.
>> `gpg.mintrustlevel` is moved to `cryptosign.gpg.mintrustlevel` while
>> also still allowing the former.
>> ---
>> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
>> @@ -1,6 +1,17 @@
>> +cryptoSign.format::
>> +gpg.format::
>> +       Specifies which key format to use when signing with `--crypto-sign`.
>> +       Default is "openpgp". Other possible values are "x509", "ssh".
>> +
>> +cryptoSign.<format>.program::
>> +gpg.<format>.program::
>> +       Use this to customize the program used for the signing format you
>> +       chose (see `cryptoSign.format`). The default value for
>
>This is a somewhat minor comment, but I find that grouping these
>config keys together like this gives too much weight to the old
>`gpg.foo` ones, making it seem as if they're still first-class
>citizens which people can use freely. If you instead organize them as
>below, then it is easier to see at a glance that the old keys
>shouldn't be used:
>
>    cryptoSign.format::
>        Specifies which key format to use when signing...
>
>    cryptoSign.<format>.program::
>        Use this to customize the program used...
>
>    ...
>
>    gpg.format::
>        Deprecated synonym of `cryptoSign.format`.
>
>    gpg.<format>.program::
>        Deprecated synonym of `cryptoSign.<format>.program`.
>
>The same observation about grouping of config keys applies to the
>remainder of the documentation changes in this patch.

I wasn't sure how much we want to already deprecate the `gpg.` keys so I 
tried a gentle approach :)
But I would be in favor of your variant.

Thanks
