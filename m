Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736BFC433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384932AbhLDNPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 08:15:21 -0500
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:48601
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbhLDNPU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 08:15:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtsR/5wj04MHOlaNMMu2zOzykEes2KKtha+hj0nKcR9wDwIMVlq/KKHdTQQlRMd+Hk2sNegsRGfEyWzh+nl/z1TszrAcMFyHaBgyd3Xwmvt1If3NwvJbgDMk/x6AVSkr1+fDWAPpIkzPhhi8NY1Z5+8st4xqAo+yUKql58YQox21gYGU3GoWa2CtTZLPejdzBQvUzWLIobHpWqfF115fUPHRgNOu6FMj/9UUAPh0mHipa2DGvX+UJ5HlzZXFuvQWcO6ndq/j0jUkisfrs/dsLLz+uqc3/3eK3PBCx9wrM+KiMFbPk3Vg1N5oDqVNCK1APKknD/gHyIu99QIueKs8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUB3z3GbsUZxHiSpjsG8VlfBYT9M4+O5U4cH9yHCDfg=;
 b=BoWo94uky9jQEyywuCL+YUfHdFvZCe8XkIo6om7XBqs6xFlKPkiKALhgw2zrReuxVstsweLBXnOhewdfuoMopH3PWDP/y5THsLBNcH+VyLsf5ViCDVduIbH8loHXW1q0F9e74MnmMLkDVEKDNWfRzB+AIM+Vqnm/yg7KaCdtvCaevqr/NAqRHecsOKYf/hvKWZpyHkVXHcj6kH2hg1GgAL7K5DUrZnK0KCVi0YCW3EhBSYNoC+fAKgVqHJlLUrmLEaCGWoEyhD7zUlQw9WP34jnEfm9gJDF+aMP12a7QoYFQDP29KX005kFgdLCl9ATEidov2RqWCeoWPD7jI+rcXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUB3z3GbsUZxHiSpjsG8VlfBYT9M4+O5U4cH9yHCDfg=;
 b=l4YGDguu1uHtuaetFW3gACcR81QBINbHmqon3AYEDBYTIlIeqP85V+kMDvdOh+hY/ekfcDUWW1Cas1KfBdnqY9u+u1A/rKrVnKBYOBLH2ZZvd/ngMdmbArB4b61jVEgtFuEQ6vRDHgSpQSE331lN54SrXErYp0ybfz+DHFGqnlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PA4PR10MB4350.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 13:11:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Sat, 4 Dec 2021
 13:11:50 +0000
Date:   Sat, 4 Dec 2021 14:11:49 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        pedro martelletto <pedro@yubico.com>,
        Damien Miller <djm@mindrot.org>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211204131149.cvyu7dvf6p66dotq@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Sat, 4 Dec 2021 13:11:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cf5d928-b8ac-47dc-b303-08d9b727a25f
X-MS-TrafficTypeDiagnostic: PA4PR10MB4350:
X-Microsoft-Antispam-PRVS: <PA4PR10MB4350EE5291D764B705B89248B66B9@PA4PR10MB4350.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yJ2UapnF9UdAeH87HtVmcJUPbMCmMp+ixkC4Hd+hu02nw5Zw5sIFBU/B8g3dDHG0q2kwSqN7tXsQZVpTetIltwM2tQLAHQWT85N0KElt8vptZBwSN0fC98vDHNjoapKGYflFatvptY02dJqV4Rf4O3Mh0Yp34882vG1P0/WvBW/gmSJiJAAGAbknMaQF1d0XjkdbJHcHwo6za0SekN+ODHwxtrlwsSNi44qEdrmxMshfK3MiGV37IUMj8+KiixAcnkNV8uRkKwRzKhwyDIafL89M0e+Sr7nWTPGOTY5Iz0Nhopw4gSs05Yt8xGZqOLcqyX5+PwID5h+YCw+NccCtyojttT/AR9slRfY+BvucOpY0getvIf/dX5ruMmjSZDFeFxwwNn/hZb1Q8/u10/QunI9wRvIGtZ7R9nvi7IL5vTm0bbRXwi8kbEKCdVx2ghRspLgCkBM0ywNu71oMcH4xkV5R/gJ8aUetDIxYRFKaJXrPYsDfomnAu2sul+b7XCP+WjJApg2FDj9sXZtc458c3QZP5mYse3gV+CCfofyoyvjgQZYcI/I7v88Mf+QF5nB8A0G4hZxJYl1CIc1iRLhQjbUA1oga1CCvTF/+uMn41PMWMBaOynhYg+jCNChrUmtmT5D9sOamm3OSBelyghaBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(346002)(366004)(376002)(396003)(39830400003)(186003)(316002)(54906003)(2906002)(33716001)(83380400001)(9686003)(6486002)(5660300002)(66556008)(86362001)(8676002)(1076003)(508600001)(8936002)(6916009)(53546011)(66476007)(38100700002)(4326008)(66946007)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdwK2RaVjNNMjhQNHZmYk9xVXJxbmoza0NDOUNBbDUrUnFMUFhrODgzWG5j?=
 =?utf-8?B?RVBta2RzRzd0Q1Z2K3ZtTW0xVVBnRUJnRVZncmtQYTlVcC9NQW5CcXdnQjNX?=
 =?utf-8?B?TjR1RTdDa3BBUmRCU2VhaHRLQmptMkE0UFNFdmU2U1U0Q2hqczRha1ZUQ1FK?=
 =?utf-8?B?VElVOWg2YitpZjlSMzRVMFBGZUtmeUdJbGdqYitibDNGOGtEZXVZd2o3S0pq?=
 =?utf-8?B?SVJlMy9kUW4vdERuN2xYNDRxZHBwbytrTGtWNmFVbGJxaHlHZGJPUDhIRkRC?=
 =?utf-8?B?bFB3TGJxMTFzcjFJeDNwNGhiYmsxdFRrSytOYUFDcitwS1FUQ2toSkpTNFdS?=
 =?utf-8?B?dXl6MEJVU1JmcURFV1IrUTZ2dWwvMmtZY1FYQ1lVK0ZrOWpBa3BWRnFFaGtz?=
 =?utf-8?B?RXF5Wlg0eXNyNjEzeXc5M090NlVTRmVSblVTN29rMjg3aDJCN2ZMczd1VENq?=
 =?utf-8?B?eWUwL2ZvNUpGSE9HT3h5YWFUVE8ybHRoT1pHd2QzTkVQMFlUaXdHS21UZExX?=
 =?utf-8?B?NHZEajQrVG0zcjZlaFZNbHNDV2dINWFQNy9VL3dkclRrWmViejJDdVNYeHEy?=
 =?utf-8?B?TUVGSDdoUmcrRVA0N1E3ZWdUUm1QdEtua2ZhRDg4S2YvelRKd1FJTVpwcEVj?=
 =?utf-8?B?MCtkRmNydFJyYkNTVk5IZjhmU0M1RVNzUUFOd2UzTkZBVE5obER3VDBWWmpO?=
 =?utf-8?B?Uzg0RW9ZZVpwVXZ6NzZSUXpBd1d3allaZWcwREpRVmhLNE5JNk5CRjBmMnVt?=
 =?utf-8?B?RWpLbE53Y01vbTgrT1o3ZlJGY0tGaTN6OEFiNE5VVDVzOS8zbHc3SkZPWkgw?=
 =?utf-8?B?THVqTUZ1Sko0RGdGYmtDdDI1MytDcVpsOGRuOC9GYytwRm5kS1Z2WnlZN1NZ?=
 =?utf-8?B?ZVBEOEpUSWpNWUtSb0xYM2VwVk96MVRQVFRXaWRDMFBmeHB4Rm1SUm80R2Qy?=
 =?utf-8?B?aXlkZTJWUHVtdUkyWFN0UUVhUnpHalQ0ZDkzYzlMemZYUU1VYkVEMzQ4MjM0?=
 =?utf-8?B?YS92UEEyVXhBVFJyUGVhY3ZGaUdBUzdmYTZpbHlqbk0rQ25mMTVvUkdiMy9h?=
 =?utf-8?B?UVhtZmJBOWFLNXFQbFgveUQ2eGFhd3Q2cXArYzhRTUtub3pEajgvQWhLKzli?=
 =?utf-8?B?L3FUOGttRXRkUHI2dFRsMFNtUXRLbGJabWlZakNKeXh2eVUyclErd25RcDUy?=
 =?utf-8?B?N0RYMllKMldCWG9IbVhxaWQyNDNWcE8xQllQYkY3TnNsNTVVTHN2amlsMm1S?=
 =?utf-8?B?UGUvYW8rQnVMYncvOW51TFU0cWVPSlpRaDcybm12RVlNZUM3c2tRNUd1VUNa?=
 =?utf-8?B?ZS9YS3grRWlGUkhEYlZCZURnVEVuQjg4N3JhU09QR0ZRazltcmt1UzhzVDVq?=
 =?utf-8?B?YVJ3VElGaDVtbzVLeVRaNy9ZSlR4dWRKQlR6VkZBSW82VnJmbzl1N0RXdDdv?=
 =?utf-8?B?ZEkweVdsVmxrT1RNUTJzVmtSQU9aR1NiRXFqdXI4WTlVRkdDNWMzU2VtYnV3?=
 =?utf-8?B?NklVbFhROThNSjNwRFZxa0dGMmpPMURodUFPUGdQRGt1UVJMS0IrNDNMWmdV?=
 =?utf-8?B?SE5GcGlSeERyMlp4OEltZHlOOFZla21RSXgrYk1tbWUyYUU5U0hGZkU4cllO?=
 =?utf-8?B?T08zc2pDUXg5K0ZyZkhzQVlaamozVm5YU3R1ZUlsWnh3Y1FLYmtodjcreUJF?=
 =?utf-8?B?TTg3SmNucjZJaU1WUGNWUHhhUm0vM09qTU1qRU1RNndVbWUwTnJ3TlhZRmtv?=
 =?utf-8?B?eENQR2xKU2kzSkY1VnZtWW4wWGxPc1l3K3EvWTVOY2ZLSEc5V3RNSjVQWkJQ?=
 =?utf-8?B?QVF6WUdKdTFyb0JKOHltVTRRaWJ4NG5mdlJ2aFg3SjR1TTJZNVgvS3ppeHVC?=
 =?utf-8?B?M1VJQlRoNDNQeFhOOStROG5EeWxRZ0pSV21kMitwU2t2U0F4NGs2dko0OEND?=
 =?utf-8?B?TU9kc05qMmNueFV2S2FMQ1VlbEVRSy9XclljQVNEU2JVNi9pd2p6OTBSWjZp?=
 =?utf-8?B?WDMwVHNFajA3TlhsajAvZk84TTczMUxKWnhBWEFHVHR6K1k2eWMwaXBVNlRw?=
 =?utf-8?B?eEw1enZ2K1J1UnUzRGlvSlNUOVlJVVN2SW1FOUt1V3ZZSXRaaXpieFV6Rk1S?=
 =?utf-8?B?QndIMTlGVFI5UjRQOFlselhWdGowRTF0czV2WWJkb3phV2RhM3VZL3ZWWFgw?=
 =?utf-8?B?KzQ1MCtjU21IT2Fzem5OOENHTGQvWFpMRWJhU21BRERlVk5VN2JJamwvOURC?=
 =?utf-8?B?UmRKRHJRVy9WaDB6OUY2dVRYTllUY1dKV3JYWjZPdFdJek5reXZjU1BoaVpF?=
 =?utf-8?B?dWFCNURETXpwL3RGZUxRaUljbG9LK1BCcnhJcy9kaEVaMkFOQmJRUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf5d928-b8ac-47dc-b303-08d9b727a25f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 13:11:50.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sy9402uNU9xU58FrFRpXCTsuB+MKDqXWIQy5UpVSeGU+pC6kkkh81ExiikStA+cYPHghaG5LJSgYXEGkQCFUnXtSEbWFDZXZMIYw09g7lss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4350
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.12.2021 10:58, Jeff King wrote:
>On Fri, Dec 03, 2021 at 01:31:16PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> We need to trim \r from the output of 'ssh-keygen -Y find-principals' on
>> Windows, or we end up calling 'ssh-keygen -Y verify' with a bogus signer
>> identity. ssh-keygen.c:2841 contains a call to puts(3), which confirms this
>> hypothesis. Signature verification passes with the fix.
>> [...]
>> @@ -497,7 +497,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>>  			if (!*line)
>>  				break;
>>
>> -			trust_size = strcspn(line, "\n");
>> +			trust_size = strcspn(line, "\r\n");
>>  			principal = xmemdupz(line, trust_size);
>
>Just playing devil's advocate for a moment: this parsing is kind of
>loose. Is there any chance that I could smuggle a CR into my principal
>name, and make "a principal\rthat is fake" now get parsed as "a
>principal"? Our strcspn() here would cut off at the first CR.
>
>I'm guessing probably not, but when it comes to something with security
>implications like this, it pays to be extra careful. I'm hoping somebody
>familiar with the ssh-keygen side and how the rest of the parsing works
>(like Fabian) can verify that this is OK.
>

A good point. I just tested this and CR is a valid character to use in a 
principal name in the allowed signers file and as of now the principal will 
be passed to the verify call `as is` and everything works just fine. When we 
introduce the patch above a principal with a CR in it will fail to verify.

I've added Damien Miller to this thread. He knows more about what the 
expected behaviour for the principal would/should be. I think at the moment 
almost everything except \n or \0 goes. Maybe restricting \r as well would 
make life easier for other uses too?

 From a security perspective I don't think this is problem. The principal 
does not come from any user input but is actually looked up in the allowed 
signers file using the signatures public key (with ssh-keygen -Y 
find-principals).  If I could manipulate this file I could change the key as 
well.

If we add `trust on first use` in a future series I would assume we use the 
email address from the commit/tag author ident when adding a new principal 
to the file. Can the ident contain a CR?
Even if it did, I would only allow a list of allowed alphanumeric chars to 
be added anyway since a principal can contain wildcards which we obviously 
don't want to trust on first use ;).

Thanks
