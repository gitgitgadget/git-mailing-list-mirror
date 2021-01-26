Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E86C433E6
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3404D2064B
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 10:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhA0KYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 05:24:10 -0500
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:5537
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S314256AbhAZXC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 18:02:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5JfDMlmBDrFyY/wTej5BH0XPPb1zflwe1Xw7cwxbNmzgLqJgJUyegldhEtKerfrv3nTOK7GLntafzJMee5HVg5ib1aJFeEmGL0JqsyOzbMPd0UIBTDQa1OYtp75aGqtnKxXHcgQ3kHbu8Lyww/iwmUKLxwlb0JLGPa6iz8CjtfKi+eDq6RSJsSouQp2nbZbRR9ADyNsdcsGSVeyK8uwfCKKGIoJdv13SyepQcYlSg/Sz9yZ7q6bgO0Uz9altwPJSkJhAlEuxo4sqzCtO0uhvOf6fKD6r5yuoPye83oEh+ep+N7tZ4oDr+m9UMKslzYJGeuZJnD4+chdlqSWsnU5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ckp0vFaU+mroh48TMw0IsUa6RHeapEtjQhYPKsd7Nc=;
 b=OKg4NeS3pDbkDmimUJwQXPCblvA0v4JbVMei56XTosIHfyP5ZTzsu9mF5/enCrTC6qrbArnCOo315MgIUeCbqGu7NFAyA8JQ/pQgCLJkJhJvcHa4zPyMryjAE5XgtNVq7qPHuI+P/91FEbDSsWm71g3RUoQ+Rjd+VySILCwo0k+uOUm6mtJTpfQva7Z+bAf3KOb2JfdF0YY4+x7gZcgKM4Ye7Kdq9JXQTVGaxlOXvtFsH0fsfzp3kESayKxJ6/FhmJLM3rXYqVbA8d7p4DL6ix98Jh5VFUa9cPcJwk7O9RGq8z5Rma4tzrvkUvCwrGSVVji9tr05MeMM696/UW1BWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CEDARON.onmicrosoft.com; s=selector2-CEDARON-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ckp0vFaU+mroh48TMw0IsUa6RHeapEtjQhYPKsd7Nc=;
 b=XA/ma9Ptk6JinDAf3SWjh/HcPVsudjrny27Ch7VlBkYqW9WcZiLKTRqDH/iXZnUYMZZKAFhT9UG2HwudYavUDy4us+8mTurTOIauny9S9vMp0oxlkyrc4XKhsC6SOxmevyu2ZxyFgQs/My6tb2h2LmrSYkvwKGCZWnmGKVlvic0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by BYAPR20MB2839.namprd20.prod.outlook.com (2603:10b6:a03:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Tue, 26 Jan
 2021 23:01:34 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::798f:4f9e:fcec:d323]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::798f:4f9e:fcec:d323%7]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 23:01:34 +0000
Subject: Re: Null pointer dereference in error pathway on git pull
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <1cda3398-7b02-edc5-aaab-c75191124b80@cedaron.com>
 <YBCd2ZAumP65yrUK@coredump.intra.peff.net>
From:   Joshua Hudson <jhudson@cedaron.com>
Message-ID: <f8b3b05a-db46-1977-6fb4-ed13ac48e131@cedaron.com>
Date:   Tue, 26 Jan 2021 15:01:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YBCd2ZAumP65yrUK@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [12.139.157.2]
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.8.74] (12.139.157.2) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 23:01:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65590ff4-4cdf-4673-dd60-08d8c24e536f
X-MS-TrafficTypeDiagnostic: BYAPR20MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR20MB2839D0C7003E28BE6F69BF04A4BC9@BYAPR20MB2839.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNl+TNaxyp+fkzQ5w1hnoNhbfkvkg1FHVDkUHVeu5KJ9FHzy2JlkiE7LaKfY6VRsYbspj4YaoR1Wd33hhClLa/knLfhNCt5zTvmcWUUiL9lixenA883XqH0hwZDPujOSfGPBFh7ZG/uxLR0GRKWfMDlOxP7cDeKAp2J5nUOuv8LDCrmGL9X9j3uTYInXWhNNzmwTsgAe79gK/59+MXS+f/laKX3GV/s0/HRObhqYXgRIrXBbdG42jY3J+MhvxV896WN2o4sVZu0AxZzmw6thtmtbU6lSQcRrBQnjl8iC9MqgNYu1urX5/nBFadzbErFFfX7l9ucbQAbK0JqQ+8T5F9HSlPUpaFGWD9+NVzrqAg3/2jH1PPnLINmGdCN+5r3HKRLEj2Bjp6kiT+u4LeBvtcCGvYKzbVIFIE7c+1nALE9L+uxSp/F+rNR1jc4fx1XUjQ6W9GbLG1MInK8tK5vX0P2bxNWQmnwW5ObUMcP3QXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39840400004)(52116002)(4744005)(478600001)(53546011)(6486002)(36756003)(4326008)(86362001)(16576012)(8676002)(4001150100001)(83380400001)(2616005)(956004)(26005)(16526019)(186003)(8936002)(31686004)(66556008)(66476007)(66946007)(6916009)(31696002)(316002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MFFoT2FoQ0YwYzZDeEZrZmJVZ294ZytwOFdCZENJZXJVR1B1N09KNU5wZ1dX?=
 =?utf-8?B?NHZ1K29mUnBKZkFnSjU5T3l2WS9ONU44OFdvVVlOVGRhNFFuZDFvekxUZ2F5?=
 =?utf-8?B?RVFHM2lZM21zYTlSM1RGNzRmSjZoT1N5QUxrM1ljcUFBc1lnZXBjWUZkY3Nt?=
 =?utf-8?B?SHRHdUYzT25reWlUNjRmUXhkejFnNGJTYUppWVowdnZWek1pZEtkUnNTem9L?=
 =?utf-8?B?WkZQV3VjYk16T3Y1QXRNb25yY1JyaFUwRVpZam1PbUQzTmx2aTB4dEMwQjNl?=
 =?utf-8?B?dVlGbUFkVTYzQ3J2SE9DQ3owYkRJTklCM2VTYUZyTlBsZFFmbVAvbVQ3VFps?=
 =?utf-8?B?RXM1ZUxqMlkrcGdsQW1Va0UrV2hURzdUdnB3S2Q5TGdtZEQ3eVZBVkZnbWx6?=
 =?utf-8?B?R3VGT0k2RTQycFFsaEF6SWxka0pwdFkrZ0N6QnZoNnVvb1hrR3gwTGxzeEl6?=
 =?utf-8?B?dWJIb0lKT0dGMzduanBWWFN1NTU4UkFVQytrS1RWRXIrODlkR1cxNUozUzln?=
 =?utf-8?B?bXJVZGMxcCtKaUdzdUlvUkxacVFVZ1BRcnVwU1RGa1U4T0VrbGh4c2hBdXE0?=
 =?utf-8?B?NjdoVDVzQVNtbXNQeFJteEtYaklWY1YzRTZaempabHZma0VWUnQ0a3RnUG1h?=
 =?utf-8?B?elJlTGwvNnJPb2U0VXNsUE40VVh2ZEt1Tm1POHVVcWVZQkRVTmFlWjlsTHgx?=
 =?utf-8?B?ckJoc3cyMjJ0d1YwU2ZOVmxPK2pCUHluZ0xVYlRreVdvQmtMSyt3Sm5ncE42?=
 =?utf-8?B?dkdJVkxsZEpMWmVxclA5TUZ5dUNBT0NQdVcydm5KNFJPMGNBT1lFb093Snh5?=
 =?utf-8?B?WFJOUTZQY1NvWHZvSFFTZ2V1ajVFS2diZ0ZpN01rTTd6NHRXY1RNN0s1bGdP?=
 =?utf-8?B?Zi92Y0lGaG03bDU3QXFUazVsMVQ0NTB6SXNpT3cyN21HV2U2bmxDd1J2SW15?=
 =?utf-8?B?T1RMOFJmVjU5anowcnhMZEVTK1ZEYjVkVGEzK09kVWpvdXg5djhGK2JiUGkx?=
 =?utf-8?B?b09lL2V6emdpVjAzVTVvc21KWEdQUEpqMGRvNnNnSDFZanJ3SFNNNGVyYkhS?=
 =?utf-8?B?bnZHcVNWTXN5MDZmTGlsRElFclRyRGtSOEthS0NXYjJyS1JHdklZUE9PK0FY?=
 =?utf-8?B?dzR3dFlNQmdLN0JNNFZVTTJFOUs5VkdzRW1BK1NBRUJHbS80MGZtZjkxRzc5?=
 =?utf-8?B?Tml0NzdKbFEzTW0vMFpJcVpXUExKVjMxZnBVWldDbkIyckpnQ0R4QTBDZGpr?=
 =?utf-8?B?WXh4a3RrdnpKYnRWWitYMzhmVURkL3VzS1d1eWZmanZkdDhGSU1KVG5wUHV3?=
 =?utf-8?B?OGxBb1BMZ1VjVkRBaGJtR1g2K0U3ZUdDODlVOHlueGRuS2JFUDBXdjZ4TmtZ?=
 =?utf-8?B?aHpsRjcvR3VVMld2ajQ4dmM5Vi90RjZzb1h5eGg2azdLSmVIT0IxL2Q4cGJ6?=
 =?utf-8?Q?tGPiagxI?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65590ff4-4cdf-4673-dd60-08d8c24e536f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 23:01:33.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDYz80CUmrGF3bmFT+1FCPQ9FY43hpbQGCHaj8+sVd+V1gwo4BEywPtHXt0cIkSY5Vxry6Y55hgtIZg2w6yE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR20MB2839
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2.29.2; yeah it does look like it could be the same bug

On 1/26/2021 2:55 PM, Jeff King wrote:
> On Tue, Jan 26, 2021 at 12:31:30PM -0800, Joshua Hudson wrote:
>
>>> git pull
>> remote: Azure Repos
>> remote: Found 452 objects to send. (157 ms)
>> Rfatal: the remote end hung up unexpectedly
>> fatal: early EOFs:  81% (367/452)
>> fatal: index-pack failed
>> warning: unable to unlink '(NULL)': Invalid argument
>>
>>
>> So it hits some kind of error (looks like network disconnect) and tries
>> to back out; passed a NULL pointer to unlink().
>>
>> Apologies if this has been submitted before. A search didn't find it.
> Which version of Git are you using? It sounds like the same bug fixed by
> 6031af387e (fetch-pack: disregard invalid pack lockfiles, 2020-11-30).
> That's in v2.30.0.
>
> -Peff
