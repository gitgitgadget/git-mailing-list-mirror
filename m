Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF2CC432BE
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93DEE60C3F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbhG2Ino (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:43:44 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:7892
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235211AbhG2Inm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 04:43:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUPwsLfujM6BIptUAnFjdf9Cj2p9QBz0iTV0SxlmTxHmGleYK5mkvf/BYHWI+bQpEzUJFib3//s6A+ZxZCruhi5vdtftLZC+ZCtY49h/sPG4vHiZpVGisOedU0V/fxJhj6KPf7ZD/QhPhwXKwpvOzI0YFyafj76wcugKJb+xMhKjkjgfRLc/ESGb0EvkdL2cL3WpJjoQv03WnZhc2sRinYl+49DLUAffdzj27jbpnoMG+y+GFW1NLSdOHiHEeyhL/CBMDIWug9fe6JUsDW7SxxpFIzU2paMmowdz54n2PJYo4LT1XEIGatGm10obJ12M/rWyyrRfu1+bEFHTZxRwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMHOcnwZuXrizw0JPTy5d2uFgDKkU1zTezNqQY1zxZ4=;
 b=l3TYdh9+IiVzmpbSH+bQ30QGY6djm9aj511pmmG+m77HqnD2WVjQjvHkaPpCIEDVEsXTLb6BHwb/ZsYWFJOVaFOF5l+1+lZXzeaMqeV9m+6rreC60+p35kJCsoS3AsgSGTaXYDG4scSuV8LZGTxjYe6mHlvwusR0nSdZLbxsmCKfJ4/yPF7PGrsJPFGB3GwFJqsnujlRE9t0wZSlcrAVh+/EhyA5GeRK1RwGzRGdhfG92gy4/lHw348lj1MzRALT3SVJ7OJiB6cFhKs10n9CUImOLw7vZXxkhgux17pdSkQNcD9NoQ6/8V8JjRma6h/q6OoV3HOa6TEIxJV08ghHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMHOcnwZuXrizw0JPTy5d2uFgDKkU1zTezNqQY1zxZ4=;
 b=kTXyDu6334+pEL7w11sQpl++1JWC/euL0GgI1UTvDwsT3k2MIhM4kpCLJDAh74Q9hKzzAPkkVHFU/wvi4SjibcvN7hO/ec0Csf79XIEH1iYnIcHlnhdmSiIr2mgo1qnVBogwQKT9dnTbwouMMbg7DazFu0kNkbZaEgU7X/+iUKU=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 08:43:36 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 08:43:36 +0000
Subject: Re: [PATCH v6 1/9] ssh signing: preliminary refactoring and clean-up
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <7c8502c65b833e7e563a833b592f6932421b1056.1627501009.git.gitgitgadget@gmail.com>
 <20210728223206.2715554-1-jonathantanmy@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <0da4ce02-9f2f-adc9-40ae-bc4120ef534c@gigacodes.de>
Date:   Thu, 29 Jul 2021 10:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728223206.2715554-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::32) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR0P264CA0164.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Thu, 29 Jul 2021 08:43:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 618e6ad7-8f98-4037-fd0f-08d9526cf4b7
X-MS-TrafficTypeDiagnostic: PR3PR10MB4111:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4111C7023DE415E40C5B4F5FB6EB9@PR3PR10MB4111.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhefTkJLINS5I2DMSPK3jEYeQSPop5Nq5rbJxLr3mX4v7M1Unu3aLspmyTPF3zBieKyv5UwgAU+iSHE8Edh92p42wQmWrpvaD9RjPY+bLYzGu50T9l52iPWokEe8QmMyrIL+WYRyKm+KrBxnvWD9ir2pwVvAjBi66YaVFMKA2BusmHrcQ4g1t3Hxv+m/InDwnwk8EOkKS2X5lSDekjx2rrFmKx7rCG/9FZxTfkQ49+FgV7M7rHYVaO6TzlNGM+wrMBpxgewljBk4HbfIDCfnz/vj2FyDaa09dh9/fcs6Ig2CdFmw59ubCbBH8jOjb35qcYCZcsmeiZR8yG6CUgtLjwzsY4OUEhzn2LLzRoJoidGZg0xWnyUF+yviJps5okWpZ5MFvT+LMO9QQm7NrMvYMphxP0aqq65Bg2acw07bU/GYplEBr2OZhbFMuWijhI6wbrTDj3lB5KlSJVxA0roGmilsR+bOZIydyfRqx9KQwbyqT4QbR0La90XgV/aBgnidKUwliXXQpVpMXrGnyTwcE2L+7ywG6ict4+D2pq3PT7AXns8lO4hFJDEpxDCL70Js257EjcspmOM3AYsQw/Ee7JvZQIkTgW01wmlbpiPn3WKh4THeRaV7A3xHVqFyb0mpfsc5fvE5S/Zdtn3Fg75wY4td3rt+DAJcUHzsqYVLMS2Nm0iv2lAhmwhT/5d076P4by/2IPE3u2NuZgEjqDCHoCuuZ7J/Pwd7cdCCKr7FIj3YCdwfPTbGeqJuvs+uUQ5w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39830400003)(366004)(396003)(376002)(31696002)(6486002)(38100700002)(316002)(66946007)(53546011)(186003)(66556008)(66476007)(36756003)(2906002)(31686004)(8676002)(2616005)(83380400001)(52116002)(86362001)(8936002)(7416002)(5660300002)(478600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnNPOW9qaHZrMDZZelZpTld3M2syYjVGYXFOVklleWg3ckc0Z1NJUDJoc1pJ?=
 =?utf-8?B?bm9aOS83Y0FJdnZGWW1LZWIyNC9PRG1Ma3lsMC9ITEpSYU90ejZHQzg5WVhT?=
 =?utf-8?B?ZTBIdlgyeVQzdHdncFhOY3VHYW5MWjhUbERrSEp5ZWpKRUEwSzM3QXRpS0lS?=
 =?utf-8?B?QnREUTJIR01mY0ZhcG9pOXc3cXJTMEt1ekxjL2F5NkF4VWkvWE9kRjlCWmRH?=
 =?utf-8?B?Y2ZteElyaGltOUxsSFFqM1BiU3d2MGk5SWxCWDlKUEZkQjE5ZGpmdTAxV21E?=
 =?utf-8?B?ZWdHSG1IdlAwVDZXY2xJZ1JmS0oxN00zd3AvRlMxaDJJcXlKdC9FQXc4U25F?=
 =?utf-8?B?T1ByMFJyLzB6V25JSnFEcUo2WFZyNG56SXVOSmxHM2E2dnlaOHBvYXFtRElu?=
 =?utf-8?B?R0xxTW5MRE9YWnQ0aEl6UGtzazBZRi92Ny8zSk51ODJVRkFBV1lhQUYyR0Q4?=
 =?utf-8?B?ZjhISmwzdTcvTXVDcG1HSDlQaDVZTW0wNEVkWTdkdFp3Yk5FOHJadk1wRktN?=
 =?utf-8?B?dUE3aDkyN2pKZUM4OHpsWVRDcWJFRmlSNkhuOUlZMnVRbTQ5M0h2Y3lJNGJp?=
 =?utf-8?B?ZkZBKzlSbHFTa29md1FTVlNGYjBITVJHQUFVL1IvMzQzdEVNSFFIZlVvTXNq?=
 =?utf-8?B?SXZST3dLZU5hd0U5YW9zLytaRTI4OStvMGxmMi8vMFB6aGdQemVPNW5EOUtw?=
 =?utf-8?B?cW8vQTlUdDB6TXNlY3dHQ3JMWThuQXk2eWJYR1pRQ2FtcXF5aFRXUFZBODRB?=
 =?utf-8?B?Q1dQdjI2alVtOGlBcGhJS0NnR0QyMnhhV1ZYdHZhdVdDbWZTNW56MEh6UjBq?=
 =?utf-8?B?MTRGY3pGM2FXcWpkcjg2L3pvd01YZFR1emtKM3QyUlgzbmZxaWZxSWlQMlB6?=
 =?utf-8?B?NDNtOXhhMlE5Q2xRWHRHc0sranFZajcvTXRaL1R0NnJvNlpxdVVKRmJ0VTFU?=
 =?utf-8?B?TFI5eGRpWnIwcCtqMWVLb0ZVMGN0VjhtZ1lLeDFOMTR1VlVvZ2Q3WnBXZ3Z1?=
 =?utf-8?B?R3VmS1dIV1dGYVI4TUVha1hCVUpYNCtSeG5aYkdNM1hFbS9UNThOUkpZTGtu?=
 =?utf-8?B?QTRRNVBudThGRnp4U2UvelpCM0tqc3lHUG55Z0hzQ3Zxb21GMXVpMkpMVWd1?=
 =?utf-8?B?T2xJUENwc2xzek1Uekp5a0U0SDR3OGpkdVhBa3JBdlc2a1d3eXhyUmpmTjU5?=
 =?utf-8?B?aURTOU81Q3FkOEM1eVJNaE1YY05TOUVvTHlHNWhFTUdaN3FidGtxZXpUcGdP?=
 =?utf-8?B?MWU3VGpoQzRtbXZqcTVXMHU5L1BwdktQMndIMXF5VDJoYVMzY2hVbUo5RFVF?=
 =?utf-8?B?OWNCQzN5cmo4WDY0cVIwaGdtTGIxcWo4dTdveDlFT3NxazA5VDZtN3lQRWFY?=
 =?utf-8?B?eDg5Y0RqeklEZlJSTjdVTmdZSnRmelF2N0ZNNnZCbE1sakJXVWJHenFUUmJW?=
 =?utf-8?B?WmFaWEg1ZEFUaS9iYlJWaXpxcDN0MzVjZ2t3dVJzVWtQQ21rckhxUG40a0pP?=
 =?utf-8?B?Rkh4U0JYR0NZeHZWKzFDTnRrRlM0dUNoby9oU1N6YjVKbW42UkJDb0Z2UE5q?=
 =?utf-8?B?SWJIQ2k3NjhVQjh4NnJncDRlTkVJbHIxbXp3WHVneEMrMXNaeS9rZDJDQjlT?=
 =?utf-8?B?ekxvOFRVemwzRDQ4UlRObkhXellpb1g5MjlIaVRWWlVvSzFaeFAyZnF4VWZP?=
 =?utf-8?B?NmdUU2dPQytXakJpYXdPN2FjSEJHZjQwUWhONDByLzE4YTR2Z3IvckZwcjA0?=
 =?utf-8?B?UStKYkY5TXNObyt5c2RYQUpNZ3kxTnRZVUNFcFMvTU85OVFNNEZ0MFZaQWZl?=
 =?utf-8?B?MmNTYjJBUE9aVnhkQkNtZVFxbS9OeExBQi9ReUNENlF1OXY5VlZxZ29Pcmpq?=
 =?utf-8?Q?dwUwBSNheoD75?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 618e6ad7-8f98-4037-fd0f-08d9526cf4b7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:43:36.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXTBptxOAN9fgjEDzg/B7RQLucQdLHpkJhPWtAu1qtTnt5aFFL3nFCYMAKAHco+AL3jqRnerMsGiRnXIwyykvVc+EhLkTuJD3OphzYki0Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4111
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 00:32, Jonathan Tan wrote:
> I think this patch set is beyond the "is this a good idea in general"
> phase (in particular, I think that being able to sign Git commits by
> using SSH infrastructure is very useful), so I'll proceed to critiquing
> the commits in more detail.

Thanks for your help.

> 
> Firstly, in commit messages, the left side of the colon is usually the
> name of the subsystem - in this case, "gpg-interface".
> 

The docs call this "name of the component you're working on". Since this 
code does not actually change any gpg functionality (at least it should 
not) i think gpg-interface in the commits might be a bit misleading.


>> To be able to implement new signing formats this commit:
>>   - makes the sigc structure more generic by renaming "gpg_output" to
>>     "output"
>>   - introduces function pointers in the gpg_format structure to call
>>     format specific signing and verification functions
>>   - moves format detection from verify_signed_buffer into the check_signature
>>     api function and calls the format specific verify
>>   - renames and wraps sign_buffer to handle format specific signing logic
>>     as well
> 
> I think that this commit should be further split up - in particular, it
> is hard for reviewers to verify that there is no difference in
> functionality before and after this commit. I already spotted one
> difference - perhaps there are more. For me, splitting the above 4
> points into 4 commits would be an acceptable split.
> 

The rename can of course be easily separated. The others would probably 
require some code in between commits that's not present in the final 
patch result to make the individual commits compile / work. Otherwise 
those would only add unused code with the last commit then actually 
using everything. I don't think that would make things easier to verify, 
would it?


> [snip]
> 
>>   static struct gpg_format gpg_format[] = {
>> -	{ .name = "openpgp", .program = "gpg",
>> -	  .verify_args = openpgp_verify_args,
>> -	  .sigs = openpgp_sigs
>> +	{
>> +		.name = "openpgp",
>> +		.program = "gpg",
>> +		.verify_args = openpgp_verify_args,
>> +		.sigs = openpgp_sigs,
>> +		.verify_signed_buffer = verify_gpg_signed_buffer,
>> +		.sign_buffer = sign_buffer_gpg,
>>   	},
>> -	{ .name = "x509", .program = "gpgsm",
>> -	  .verify_args = x509_verify_args,
>> -	  .sigs = x509_sigs
>> +	{
>> +		.name = "x509",
>> +		.program = "gpgsm",
>> +		.verify_args = x509_verify_args,
>> +		.sigs = x509_sigs,
>> +		.verify_signed_buffer = verify_gpg_signed_buffer,
>> +		.sign_buffer = sign_buffer_gpg,
>>   	},
>>   };
> 
> I think that verify_signed_buffer and sign_buffer should replace
> verify_args and sigs, not be alongside them. In particular, I see from
> later patches that a new entry will be introduced for SSH, and the
> corresponding new "verify" function does not use verify_args or sigs.
> 

I kept the verify_args since i would either have to duplicate the 
verify_gpg_signed_buffer for gpg & gpgsm or have an if within deciding 
what format to use.
Also this is something that we might want to make a configuration option 
in the future and pass to ssh-keygen as well (there are a couple of -O 
options for it users might want)

sigs is still needed for the parse_signed_buffer api function.
