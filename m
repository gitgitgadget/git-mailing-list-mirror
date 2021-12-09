Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3DCC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 17:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbhLIRYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 12:24:09 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:15264
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242709AbhLIRYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 12:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxmDWtz1nMsE6rBZL+LCC1HKsDtSco4soVQEw/cZXKimVCimxoh2YMAtJSg1YBysnqqtU6XGvieLrj6BluIr30x9ygf6Q9n2/KSHeXIaJBSXskHK8mR+DkWeOBc/Ztp6LeDVJbamwR3Zs6RTgs2ZuVSizKIXtVQ9YoaFlBg1aGeNc8BxO8JszEB27B9mJ0s9c9gmxJpt7gvEe+iAYFDvTG87ZoGJZJ5VgzFnRGwwlAjIUug7sb9Um2piQROQC/iTLQWKDYh9sAZWZNZC0jRp0tvLWyaP+1e1sMOzzIHWdD47X5Ph2d8C4KZlC9WejXWFRWg3S8jjlKWQ/RIuYqEmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WZWanErajJAypXNssbJkapzLSbmTdE9xR9dZdXr3gU=;
 b=XWrdrVSNm4fyPaIjbHU+DaN66Gg/wW16bw2sjeI3tCWDB/NiYmiklLW+lrfQEOocmokA2Kc5Ku0v/b5K8C55FL5LbleV7JNDywYKP7x6hHVIotpAo4LTsXCT0WbeWwNm1UobQ6RK2U1xs4WmDeBKAYQqYA46f/co0Z06SdhOW6oOJE6q3SNs4DYtJ3unF6yM1BXr0llC4/QA1iBFRqzXwOXT8uQ6DCY0i1fqaMT9kcERhrWKdxbodUSZiboquDepRWH+MOa6jFmubPYx4aez/2yJTp0OJTIGyhlycno3Rthby+E9gfSzc/7EWcFD1oWCwminn7LZv9kpZgcGkX+THQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WZWanErajJAypXNssbJkapzLSbmTdE9xR9dZdXr3gU=;
 b=GYu+nZg4HZ8lyfQ3dTyIx9IJOJFB43dMgK0/8C3CRsM7SYNglSRkTKk/J7OOSxJj69E130djCiRM41DLJSElRGWYA0OiVIEQ+i5IK3tnHy7eS1/iX+OXFyQrH/skq0400J+NV0PS/BrMsjuj7XvlpzYPQ70ty6O9wrR73+xHxgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:20:33 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Thu, 9 Dec 2021
 17:20:33 +0000
Date:   Thu, 9 Dec 2021 18:20:32 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Pedro Martelletto <pedro@yubico.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Damien Miller <djm@mindrot.org>
Subject: Re: [PATCH] gpg-interface: trim CR from ssh-keygen -Y find-principals
Message-ID: <20211209172032.2iyda3rv4zsjry3s@fs>
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <Yao+l0ckDWZNf4AE@coredump.intra.peff.net>
 <20211204131149.cvyu7dvf6p66dotq@fs>
 <xmqqk0gjob0x.fsf@gitster.g>
 <CABPYr=y+sDDko9zPxQTOM6Tz4E7CafH7hJc6oB1zv7XYA9KH1A@mail.gmail.com>
 <20211209163346.w5ofhoapmjnpgc6y@fs>
 <CABPYr=xfotWvTQK9k1eKHa0kP4SsB=TKKuM0d8cpMb5BtuUZLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CABPYr=xfotWvTQK9k1eKHa0kP4SsB=TKKuM0d8cpMb5BtuUZLA@mail.gmail.com>
X-ClientProxiedBy: AM6P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::39) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::39) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 17:20:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76aeb9b-3a47-483e-523e-08d9bb383522
X-MS-TrafficTypeDiagnostic: PAXPR10MB4749:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB47493153FA0E75CAD409D56BB6709@PAXPR10MB4749.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tO+4Q0T12Zqp+ELV64dFX5x3JKySBM/iYfvE9xUyqubHShuDr6SKTgXMhmmI9gaAZJOOWtMItnFQIi94nxqU2S4b9U53cyKbUcVZBmPQ3XHjMa6KMbv2GSxm016DtLvKnpXDGCHbEOvrPfWqFwJXHnVxq8xNvCc4uyh6JH1mQwEG9MrcZX4uXZudc4dxDRVUhzcZkTfkfGZOfi9eNSoBZ8i6clh28yNvVJpH9CcQN6QTvLuQjDTsucfVGPGDFrMm5h8unXJF+rJ75Y6PCq9J5YdJaTfx+NDuc4ZXc4JksYwsWcg91FVms0UutlukrkEFSki3p1Ypb6dwYZaVzI5qOwrVRiOLPV3xxhvfJPztCNNYhED9s+MqlT0tNV2uXIrmKSiyJYnPg8TIIR7tKBPgkxqZ5USFL1viWXkwho5OM2hhWaB5oj/2RE8Y5R1dy2XW6+uQH5GPyOgDhG3SbHxYrbofT5/1dwp+KcvI94ZRj2Yfrp9K7B7uI8Bnsa69ERmGiNbEAWErgRmuueQAHAw1kcbvscG8IuVK+maQwYkYtm8RdcQ2oxEeKm6H4cd+xQy/W49px1l/8Wbswdfk0I4juIQN957eMzx7Y3uYwm/Lalgu7pFVJWQYcGLK+xqW6x1BayIs4NcmwMVItc9rtWX7tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(396003)(376002)(366004)(136003)(39840400004)(346002)(4326008)(66946007)(66476007)(33716001)(54906003)(83380400001)(66556008)(186003)(316002)(8676002)(8936002)(86362001)(508600001)(53546011)(6916009)(9686003)(5660300002)(6486002)(1076003)(38100700002)(2906002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTNPNEZoUVRCSDZkRUpEQnRjWWtnZWJOUUxQdFhjaFlmMGF0OFV2U2R1dnhR?=
 =?utf-8?B?YVMzMlJ1Rlh2SThuYlpKaTE2VWZKWmR4cXdoMW83b1E0VDdKVk5lTGdJdkhm?=
 =?utf-8?B?eGswVE9Ga1RjRVB0Q1dCbmQ1ampML3E5M1IyNjFRVTF0RjFFbS9TZEJucHBs?=
 =?utf-8?B?YkN0ZHB0eXBpRUtvZzNnMXJRRlBWdnl5ZVlMb2tZTGpzV3JxYWNLcWJZNVR0?=
 =?utf-8?B?TXZVdHNEdWl0MUk5TkR5RjMxaXZqL0FhRThzZ09WcGZnWGxTU3J0VEdOVGdR?=
 =?utf-8?B?MTQ1QTVkV1d6TnUvYWV0by9xMEFIRFlKYm12cFFZZ0VlVHE4TjljaVhmMTR0?=
 =?utf-8?B?UVNJMVlZdllJdngrVkNOMUU0VmFlNVZBa21rWWVKZXZNUWJXS2RwMzNmYTdC?=
 =?utf-8?B?dE9ydXkveTlWV3JyV2lHdGZ6RkREUU9tRnN3b1YvcTZCcFNIL1NuRHJGYXNU?=
 =?utf-8?B?azRoSXVtbUM3NzZ2VHdBa2VSbEp0OUZCbC8yZS8wRFU5TVdxUHQvcDNjMnhI?=
 =?utf-8?B?Q1liQmRpRlNUeG9xRG5BQnptVjUwS0F0VEFuVDA5U2hLNFhiT3ByT3grcWJr?=
 =?utf-8?B?UTV6V0kwR2Q0NzNDVUVtTDBLdHNRSkdFYzMrNU1wUTBZYnVaazdHOUpsTjVh?=
 =?utf-8?B?dW1WUDNqakwvaXNZUlYzRmZBWkNoNTBkTEVaTDFrNi9aQkpWL2M4WXdzZzF4?=
 =?utf-8?B?dFlWT04rODkvZGxnUmhad1NURzlKeU1ydzZCWFZPOFZpMHlreEZZd0M1ZWpL?=
 =?utf-8?B?SWhNbTYzZDFSWGVESDRXbHRYZHZQTC9xK2Q0K1NMa1VEVzdlamc1Mmw0Q3d6?=
 =?utf-8?B?VmFZeTZEV0s4Nk0rclVsMFZQSmhQcGJvdnd2YTBpbVBxamdhOCtuZTBSejlN?=
 =?utf-8?B?QkVNZlViWHFMRkZyUnppcVk3RllJblZYUDAzMldUOS9KaXJBZ2VzNzJKbnpE?=
 =?utf-8?B?cTlQSXBrUW0xejR2ZGxyUm8vcDQyc0FGUkMvTHJmc3JaTHovajRBQThsL1pD?=
 =?utf-8?B?U0hUVlM3U3VtS2tYYUlJQmNMQjZGbEc5OVZyNEZSUXdoMEw5TTkzWmxRbzNX?=
 =?utf-8?B?bWtKNW9LbEFPMm5IVldxaUR0ZnpUZ29yZWY1dGVrYm1YeGdDMmtUMW15eFBP?=
 =?utf-8?B?VWdyY3NHbkJaOVdJTi9zNWpIbXJ5TU1RTmRlemFIZitVL29GcFExZjVLU0Jo?=
 =?utf-8?B?U2lNWkE0ZGpaRUNKeStvMkFxb2tnWkE2ZEFXYVp4QkxWWjBWVnZ5MktsSzM5?=
 =?utf-8?B?V3NlUUZPU1prRHgyZzFjSWhtWGtHUUtCbmV0Y0tqMEM4b1ZlVG5JamxSaDdZ?=
 =?utf-8?B?a0VDamp6ZHZDTDJEYWJhQVMxUXpVa2FJckdKbTd4V09UdjBEM3B5RGx5bTIy?=
 =?utf-8?B?SGxNbDJJQ2YyTjhRVldmci9OQXI1VjVsV3VUaHRUd0IvMSt2YXJGbW9xYWhH?=
 =?utf-8?B?Qi91UDBxaUgwd2Q2Vk9KNExHSEF3cmY4N3R0WFF4aVpOYitXcnVJamhmSUVa?=
 =?utf-8?B?QzNWUEg3dmtPSEdmMmRVNHpEUzlKRXN4Q1RoanVrNlRwQUhrUEdtMkhTeGF5?=
 =?utf-8?B?dzMvcnE5WWFYeG1YNWdPaGhrR2pFTjNGNXdva3V3d3g2WHBvcWRTQ3VWZ3dk?=
 =?utf-8?B?blZsS0JzY2RFTDh1ZVo0ZXYrTlhCKzBNWlN3OEVJSE1lNTNHUUtlSlpjTEs1?=
 =?utf-8?B?OUYwMGhyMVo3UU1zdU9nK1ozUUdtdGNva1dHVlJDV0lNelJUTTBvc0FFRk5z?=
 =?utf-8?B?Ym1UN09LZGpZL0pmVjBqVTBLcTl5eDVlcjJzd1ZJTDZIWFlJdEZQOW8zck5i?=
 =?utf-8?B?MlFOYy9KSHJxaDFEUWtVUFpGRXZUTE1TSFZjRGdDWkJna3hxcHd0Z0hVbm1S?=
 =?utf-8?B?RmhoWWgzcXJwcjcxdTRzOVhRdzZYRWppcU1YcFhZWFd6UmtuSWlyRWVTOHYw?=
 =?utf-8?B?aWl4VVFUcVcweG9LbW9ickNoWkN6OGMyNlk0NmZuQmVHVGhSdTlHUmMrZEJV?=
 =?utf-8?B?Z2hIRCtvcFJpNFRVTzM3UlFxMW13MzdYN2RmbVJmcEg3V3FTSzAxQis1bEpC?=
 =?utf-8?B?c0x5YzVqTkJKckFpR3pwa2lVaHc1cldKRVpLNGQ2MVQ2SDlxaXhuUjRnUEJG?=
 =?utf-8?B?b3lSZGJHR0svL1RuSSt3cklxblM0c2h3UDh2SkRwL0w1b3RpOUp3NDNSL3Bv?=
 =?utf-8?B?U0hQTUE0d3JtT3FOeW5RVjRNaDNFY2ttQ2NueUFmOERQdWhkOEkyWVBKcTdO?=
 =?utf-8?B?b3pJTE9qanRramEweXZTU0tIY2RvK2ZQYUlXS00zNjduWkVZb0xxZ1kxRGhX?=
 =?utf-8?B?VHM1dTUvcG1QNHhiVUZyZ2JMWXQyc04rQVRHc1doZnNkQWJsODRZVFZaa2tL?=
 =?utf-8?Q?o1CO8tS5Re1IWvt0=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a76aeb9b-3a47-483e-523e-08d9bb383522
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:20:33.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPFFIDm99sdB745WMFYL3AK0B+O9iSNhhJTfD9zfE2TjcHRSGQMmDZkEYbfs470fs06LCHa4e3TZzl/Y2UetqQDyTF6vHiB1BW35Qs89udc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4749
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 17:58, Pedro Martelletto wrote:
>On Thu, Dec 9, 2021 at 5:33 PM Fabian Stelzer <fs@gigacodes.de> wrote:
>
>> On 06.12.2021 10:06, Pedro Martelletto wrote:
>> >On Sun, Dec 5, 2021 at 6:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> >> So instead of the posted patch, we should do something along this
>> >> line instead?
>> >>
>> >>         trust_size = strcspn(line, "\n"); /* truncate at LF */
>> >>         if (trust_size && line[trust_size - 1] == '\r')
>> >>                 trust_size--; /* the LF was part of CRLF at the end */
>> >>
>> >>
>> >>
>> >I agree that's a more consistent fix. A minor nit: if the intention is to
>> >only trim CR as part of a CRLF sequence, we need to ensure a LF is found:
>> >
>>
>> This shouldn't be necessary as we split/loop by LF just above.
>>
>> for (line = ssh_principals_out.buf; *line;
>>       line = strchrnul(line + 1, '\n')) {
>>         while (*line == '\n')
>>                 line++;
>>         if (!*line)
>>                 break;
>>
>>         trust_size = strcspn(line, "\n");
>>         principal = xmemdupz(line, trust_size);
>>
>
>The loop ensures that 'line' points to the first character of
>ssh_principals_out.buf or to a non-NUL character after a '\n'. It does not
>ensure that that 'line' contains a '\n', e.g:
>"principalA\nprincipalB\nprincipalC\r" or just "principalA\r".
>

Oops, yep. You are of course right.
I still dislike how we have to consider this in various places and i guess 
there might be more bugs hidden on the windows platform with things like 
this. I kinda wish we could strip \r\n -> \n within pipe_command and then 
have the rest of the code not have to deal with it :/
Especially since writing a test for this would involve mirroring at leas 
parts oft the ssh-keygen api.
But that would be a much bigger/riskier change so for this i think your 
latest version is fine.

-
Fabian
