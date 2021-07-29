Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684EAC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A8A6103B
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 08:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhG2I7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:59:54 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:11905
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234936AbhG2I7x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 04:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeQ1LhYULBRvKKPu0dIapWGSonWyubfQB56D0xIQAS50orBD+bX9+6+332th4Bu+KYms/kxu3y4Ts+liGlZ9SKy3a0A2RsiR8U6uNKmqLPxF8KPZK639y2b7e9bsoY8V0zv7nMBQK1H/JT3awMTt2AfWC3jeB1rFx2xePY2ETesmpIaTQaGbJLAFltQQcu8IMok/f+/e/yyHXlF9rLTlCY/VHyKpSghl2C9+/vpcL1Cqgj6evgo2L/YnDt7eVPcXIgaTthmHB83gQX9ef9knt5KCMbUiXE2fZYErpi+UAyXTC3UTeUefVYOjVM9kkHlFRLdk5zLMGaivNaKVPTUP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgjYIJgpKdZ9vuB1GRQib7+3BoVzLHl1kO3YUyXefs0=;
 b=JBZVaI3iWtDie5clpSQJ1GvcdOvVOK7EeMDUMEHy8anhdKkw07d0S1KUAeg4gefxAgelg6n6Lg7CkrV601S2MR4+XzmIYOJxQ49GXogcQwEdFljag1G8OiH3wWDdV2N+ABWwQeUKJHqktdOF0eEuvFh965QescmeVRsV4ntIYIp+O45k3WRupc1DX0RHml0mPmsMAdtRt75GTHu1MjuwA1N/QUQZXJI2FvLTtgQQWySbsFi6AxRGrpPIMLlhc2ngfonilFSuhClWpG57PvPgiACt9V4GYsoXFuMn+Libui9Mdjdv0+iqLrQ3qsuj8eQlQn1jVh1P4Ve8xF24aXYHEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgjYIJgpKdZ9vuB1GRQib7+3BoVzLHl1kO3YUyXefs0=;
 b=b/tUWgV1mSW6ImF0R4jjkx94Diko1Ray0AFDeKLm4loSE2CyfacHIB79hWtseyZqlpsrcc2Wedi4dqb/jV2+Zzm6+zcpw2DLKJezC2tN2cEcz0+8jMRo6ruujnQzJk+ihTj+giduf7iqzB3s9pAwmIu0TDjksdTp1/cG9kzYS+s=
Authentication-Results: tilde.club; dkim=none (message not signed)
 header.d=none;tilde.club; dmarc=none action=none header.from=gigacodes.de;
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:259::19)
 by DB7PR10MB2412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Thu, 29 Jul
 2021 08:59:48 +0000
Received: from DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178]) by DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d980:59ba:f8fd:6178%5]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 08:59:48 +0000
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
References: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
 <20210728224832.2717826-1-jonathantanmy@google.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <f3e72ec9-3ed4-9955-a7bd-042fa6eb016c@gigacodes.de>
Date:   Thu, 29 Jul 2021 10:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210728224832.2717826-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::22) To DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:259::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR2P264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 08:59:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696074a4-9b8d-4a90-d81b-08d9526f378e
X-MS-TrafficTypeDiagnostic: DB7PR10MB2412:
X-Microsoft-Antispam-PRVS: <DB7PR10MB2412EC971859BEB6647EE8A2B6EB9@DB7PR10MB2412.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJ84daymvxnnPGpNjlCxFPsHFQ/cbE+2Xroo0061mX2tXwoxomUA44uVIqlX8rPwsrFJtpCrvNuUQrVHu2yefrKtZnmVCFJxIpRydattbCH57n/vFnmyLZrTMr28WvgImkTINE7LWjGVPRGF2F3Pf4IgI/Y3S9+CtYrERpbMmvy7TC4eAl0sc9QtnbSqYLVsduJ+tiVVkFj4RZV0NX4YQ7IlfA08/upQQ3rQG3NSJicb1xGQS+0bF7bfGdFaaKXdnwRtcD+9WDP9EsJPzYMQ3CtxN1oP2JKzdzs9tffJ59x615ZmIS7CqS1CZCgs8t9YICRYj0JIUFNStcSYuqwB3qtud5qnuJY6dyztkJ8gr9tTj1kYseXoUiaoa7j3pyyegYdxlPwB4W0AnHU0t36mwIhQ1EEoQfThdjyx9DTw7/mS7RLqGFfxjphCLWOlrvyHI1w0MnEL8e+vNpLTfL9AzA/Xy0EG1Csb8uqFG+k2vK4+ErxwMJRgLPpjShQ5njq6ZjW+OBaCHOfyI+W7OI1XZwIhTD72s3BxJdVKQtgkc5tgHeTyzWEYkYmnY0bGoHw1Kv4uRh3wFp8X6ayURDsPrrY1bsVestddzhKGcz3PwN1wjD/yx3QvE7GgyAhQroZWmidkwNTVUBdgKyoNClUvCWC/NELI+4tEx5wfmgavHwGFAK+OmfBiRbrnfNY8QUMFi2AxxMX38XBtn9sKHWttCAKtWEdMr0nJczgcLBAOTMHTJKQ7QaGzYAgXWHQqnQQo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39830400003)(136003)(376002)(5660300002)(4326008)(36756003)(2616005)(8676002)(8936002)(316002)(66476007)(66946007)(66556008)(7416002)(52116002)(2906002)(6486002)(38100700002)(186003)(478600001)(83380400001)(31696002)(53546011)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dS8xQTBSMTFxeVc0MDVyK3QzOXJhbStUOTJPejFUcG4rOWo1ZEhXdWQvNE9W?=
 =?utf-8?B?cXNGdFNINFM4ZVNzUVplRC84MSsxSmZPQkQrTHNINExXLzUxM1ZnK1pIYm9G?=
 =?utf-8?B?V0p3bGRSWlVwMEJ2aG1NTTNqNnFpbUdjeFJpeFpxVS91b2dZeW0wZnhuRUlj?=
 =?utf-8?B?MFJxM0Vzd1N4Ulp3R2hNdTFEcVJqZURKcWtCdERJc0I2WlFxaFNhRWxxYXo3?=
 =?utf-8?B?MDVkZUJRY0E1RU52K2JFZmgwR1dKYjMwdDkyOGF2Q2o0Mjhrb1lLUmVodVNq?=
 =?utf-8?B?eVlrZWdrZUc0bTZDMm1aL2E3MWFNcE5hZERjYWpZbFZMUzdwUGdDcjFnamFN?=
 =?utf-8?B?Nkg2QmdxOFVacmFYSWhPa2VGOWcxSnNXNFVlUER6eFpxU2RyaVM0bi9kVUE1?=
 =?utf-8?B?YTdHWXJVdHByUEdaUkxRRHhXbWI5MmNNT2hTQVI2VUhaNDRqczlmNm5uK29N?=
 =?utf-8?B?QTBxMjVlTEpVT2RJYWluZ3luVXprRU1NaEkvcDlJQTI2cU5kU3JvaUI1K09p?=
 =?utf-8?B?SjB2OTlvOHFNamhJalZTQWV1WW9GVENlYmlhaUxzVEJYdEl5OXRJL0ZJZFhG?=
 =?utf-8?B?cmtDQWd4RU43cDBzLzF4czliSGwvckIwWXV3YlZOSmVlVUozOFZURkl2L1BC?=
 =?utf-8?B?dlZ3Uzc5TDB1Mlo1SEJiQTFnV3Ewckt1MGtSSUpCRGJZanJPcERaUlYwVVgz?=
 =?utf-8?B?aW1uMytVYUFnWmdhV3NuNk5NMnhtTHVnUzBnSDJiOXNEOE12MTN4RFNGYStU?=
 =?utf-8?B?S2tzZG00SGt6YWlhUjVvSVV5SU9YWWdsM1hoYVRWb3dIaWV0QkZ5NlU5cmlC?=
 =?utf-8?B?ZmdsNXJYak1ocUx4NUtNUy9tMDJlTTJkZXZpdEdNOFRUREE5M3FrZWNJMjNH?=
 =?utf-8?B?SjJOTXV1SWRSbm9Yd3F3SHhDWXVYbUFCOUd5M1ZkS0hXTGdTa3BLTkN2MzFZ?=
 =?utf-8?B?ZVJ6VDBwdFMxTFdCR24weGVMbWE4NkYyWlFhUFNGYkEvdXdrbWdBdThyUnpq?=
 =?utf-8?B?a0ZNUTB0UnM3S3k2UXdnOHlVYnJ4YWYyOSt3d0VLbUYxWk1sNThycUE4b1Mw?=
 =?utf-8?B?SXNyU1hlWjlzQ3MvWnZhYXV3RlJ1N2R6TVpNZG1TSURrUVMrSVlVVWwrUTZr?=
 =?utf-8?B?ZzNSVE5XMnVSQUxCR1ZwUERCdG8zbGpNSURQTE5UZUp0UmpPTzNVTXQ0bEZn?=
 =?utf-8?B?b0M2aGJMUDFZQ2treG04cWY2SE5WSy9iSEtYNllqblo3VHJGNW45dmJpYk5S?=
 =?utf-8?B?NlBHVzdrRC8rMVVxMjV1MUtNNWtvanN0aTl4WWpKeG1vaEdFTjFMbmc2L1oz?=
 =?utf-8?B?MUlwa0U3WDBIU2hqSjBrVXNDREJJMmhHOEs3OG1lSEdtVnhidnBxa3NVNnZH?=
 =?utf-8?B?NzVrWWFMSU5xR1lvQlVqVEJRciswbmpZZGFHb2pva0RxRjJRbVRWc2dXSi8x?=
 =?utf-8?B?bkkreXdha3E5Y3VLbWdweEpQR0RhZEZnVU4relJJNUdyTXJoMjVQdkh0Ly8v?=
 =?utf-8?B?YlIxbERCSTFyRjBsZ1VkVmt3aW0xcTVZK2QwTTZwVUpzMnhuMkkxVmJIMEZj?=
 =?utf-8?B?a0V2a0Nidk44Y28wNzJSUXZxZ1lSNXpHb3RST21sMW01ZENZQjhFcWxvUm5R?=
 =?utf-8?B?dEZ1a1BYTmQ3Z0hSYVV4RDFIQzdQcjJ5U0E5QjBtSHRIMG5URlZLZ25iSlZR?=
 =?utf-8?B?bkVzZnZNZWRvTEpDTTBUMC9hcEhlMUJ1YUNEaUQ5Z01ScllEK2x1M2RMU1Mw?=
 =?utf-8?B?OHpFa1kwMjByeDF2SzUzQmUrMkRxbGwvTEp3ZXM0dnk3bXVOV1prVkMwcS91?=
 =?utf-8?B?a0J5SVQ2bE1VczJkWTNBTUpIcG9ycm5iSzFZSjBCNFU1eXhnYzUvelNoUENl?=
 =?utf-8?Q?mEyBt0myN7Beu?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 696074a4-9b8d-4a90-d81b-08d9526f378e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4729.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:59:48.2525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ursHyXv1XzJTmalhBhRtRbPCzxkpzFwn7DlGQABkNRWaPwcCfxx8jdtb9FepfmTXAzIMpotEIX1RAqRZG+DfN4L1Vrxk59JVeTyxEEB2Axs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2412
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.07.21 00:48, Jonathan Tan wrote:
>> if user.signingkey is not set and a ssh signature is requested we call
>> ssh-add -L and use the first key we get
> 
> [snip]
> 
> Could the commit message have a better explanation of why we need this?
> (Also, I would think that the command being run needs to be configurable
> instead of being just the first "ssh-add" in $PATH, and the parsing of
> the output should be more rigorous. But this is moot if we don't need
> this feature in the first place.)
> 

How about:
If user.signingkey ist not set and a ssh signature is requested we call 
ssh-add -L und use the first key we get. This enables us to activate 
commit signing globally for all users on a shared server when ssh-agent 
forwarding is already in use without the need to touch an individual 
users gitconfig.

Maybe a general gpg.ssh.signingKeyDefaultCommand that we call and use 
the first returned line as key would be useful and achieve the same goal 
without having this default for everyone.
On the other hand i like having less configuration / good defaults for 
individual users. But I'm coming from a corporate environment, not an 
open source project.
