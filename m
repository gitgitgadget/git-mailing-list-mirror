Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51EC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BA9610C9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 20:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhIJUtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 16:49:32 -0400
Received: from mail-eopbgr20083.outbound.protection.outlook.com ([40.107.2.83]:13286
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233384AbhIJUtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 16:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRpBoHW5mcvrfpaZ6vj5+7cVJCOu43wue8o7OV7e5nogSO5msuWJ12GyP+qHOcGH66LaYg7SSqkGz7M/d7A+g6D4KIym5jiRYb9MiqXgUj5Jm+adPQGf0Zbisj24SeFjpzQjIoutMMo90RNvAks73tvBS4Y4Te8yGQmTzGOcNtol0q/JM7rFzehmB+Dy+6Y4EKFkqvHF1YvvFhI37yZczcISibCtqJcTK47RiAViFGZha2ye1bgFRHad3ysCdZggI3ow+UXv69W3tdbDYgR7WMSRPt3peDas/0+VjoEUo1/2vaQdBIcOwOyNaw4nntaQWb0GhE9CgoT+yOMhPTfKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QvKvK/hELBEFQMFF8bHQM+9668CAUVSf4GcqCSjOP5o=;
 b=bRmQBN7wJ4QxVKiOcFeGwu4ZLGrKzl9ZAmmaDsNuywHVhe0b/mKiGiH/3eQiVZG2KjuV7qu7YyOSo/j+9MIYbk48lvA97xXYEJvdhul6pZ1VjtzJRCBtKzn5gtOhr/rYJWGqS8gmj2r1gwevQAjk7NuHMxX5496S4S2d87zvtGWnoGXgG/ncoemYMiJQcTrUHQBHC7imGMrfw2foLySxzkIRyT7m3YRN3qAKvQaRfxadlFSH4Xi53e1h7idQsKqvSaQvd1xF4riLobmGDFn3LugQfmfy6yk49P5gV1d8XgH/HJDe7dsy+SNOpI5SZPDA7ESgs31lO5UGSz3vGOqWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvKvK/hELBEFQMFF8bHQM+9668CAUVSf4GcqCSjOP5o=;
 b=YI01+LS8yUoCoeq/iTIwB0oFjoCPo18PLtRPUNw6oDVvbbVtIuBSnp/RNKiaRV2oKp68aqGeeWPRkLopVMnVe01I+ilBYXtVmRgF55W1yV80FLE5zour+DeO6aD6Q88D5WAlJC70wSLehghfE/AXfgQJStgxmSf3ZODRGrDloQ0=
Authentication-Results: stelzer.cloud; dkim=none (message not signed)
 header.d=none;stelzer.cloud; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 20:48:16 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::49a2:88ed:be81:d939%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 20:48:16 +0000
Subject: Re: [PATCH v8 0/9] ssh signing: Add commit & tag signing/verification
 via SSH keys using ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Fabian Stelzer <fabian@stelzer.cloud>
References: <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <pull.1041.v8.git.git.1631304462.gitgitgadget@gmail.com>
 <xmqqfsucrxhg.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <ced584ee-4f8b-24d3-1f5b-459c67e75584@gigacodes.de>
Date:   Fri, 10 Sep 2021 22:48:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqfsucrxhg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0054.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:178:20a0:d22:c58d:d0a4:a83a] (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM0PR10CA0054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 20:48:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26cf106e-fd46-41c6-08df-08d9749c5033
X-MS-TrafficTypeDiagnostic: PR3PR10MB4126:
X-Microsoft-Antispam-PRVS: <PR3PR10MB41269B8F22350B7ED34ED039B6D69@PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd4QWnCdKG8JHNKIYxvpS6lM7WFRClVWSDs6LbO3tH7bzbvU4RZ0EOSRzyWTyW5477XHWNVYWaj2992e5uGmYkarXPeeYFKzN9JWYON1aMe12inb5S0yEo1vETQ7GvvvEfvHNacc8kXKMlVp1Saw6tJ+45+i+ZR8ppBeFBSfqKvnSDwJKVU+QmloFM+4zulADeoMMGKadb/b4ZOVVX28c+Hb2aI3wgOAtREH5crAa+Jhp+H5XDbf/XOuGxgXnzI/ipQpEHeG5oJHeEjdNM4I3nGc7axtBo5xmE/c+OF6krvtiVNd9ItaTWnU84BbKtna25YqSM+VcVsTCECSBPh1YzQZszBCybx9BlqTnJpIe2HDQiMbZKpNcjqhsJGAcpJV/Uz66wzgM9zLQWkg63f6LsWvEqjbt27xJpkTqs3WIn0O9tvnNyuy8cNrEdi1kaSHa8p2aTlVHlMPAJPyMUxclFualyPRaNJGu0yRqczKu2Y4pY2NPdFKpISF4RgLDo3daZUTrWkmm1e+ULfkR0C6yB7fy9Wj4+xpkL/y6QMwgfry/+272v1T/rhyZWRJ6YpjD3nuewEbXz1JNrx076X/SSgym/xpbj9W9x6zhvMW/oUWqgWWLUZGiDLv2QrMqHefA520lOLA1Ixbn6K9Mw0/6Q8XzxfzXyBEu4I1DRTa9nOwAmxOvKy0nnSO8n2dpHR2lCLTK1BK3XRAjp97hPUGg8eL7/w8ZkSh65d/hanWqzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39840400004)(136003)(376002)(366004)(4744005)(8676002)(2616005)(15650500001)(86362001)(316002)(110136005)(54906003)(36756003)(66946007)(52116002)(66556008)(66476007)(478600001)(83380400001)(5660300002)(31686004)(53546011)(186003)(8936002)(6486002)(4326008)(38100700002)(2906002)(7416002)(6666004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFoyNDNaVFhDZmlETmxMNHZteE10K201R0xXaHBUK1RIUlN0SmppWlN6TUxG?=
 =?utf-8?B?dTY0dkhydHdYcXpON0NmaStmL0Jaek9qamRGQWhyRi9qa0tjZ0d6cXNmdFBr?=
 =?utf-8?B?MVJmNFExUEtmMFJ1bG9uRTZCMy9zaThsNllZM1dRMG5kTWF4L3VWQlB0ekJY?=
 =?utf-8?B?by9TOGdGYUgvejl0Qk9Pa2dwZkgwUzlyUC9hbWdsMS9KVm5CQnFucWNFZUVY?=
 =?utf-8?B?MWNTMHhEODVtdmxxMW1pZ2wyWHRVa09iZVh5UXV4WXRYUnppdG9sQ0R5ZjBV?=
 =?utf-8?B?bzlRc1pxai85bERDZzg1dlJXRHVnbFBheDd3S0pCVjFBQ1hDUkRkazlpT2p0?=
 =?utf-8?B?T050VEdNRTlBOUdjOXB1Ym1MVEVxV2dxNFFWRXEvajk3eXd4Y2JwS1kvekRL?=
 =?utf-8?B?NE44bklWUmx3TmVZdEI4VUJjTU5CNnIrV1JrQTg3Q0pQampvV0oyUjhNdXp3?=
 =?utf-8?B?OVlpcEg5UTZITzFENjY4MW5TbUhrc1EzUGJLUkFSQjE1U0tsVm5GUzZISWVR?=
 =?utf-8?B?NWxnbzdQd1E4YS94UmJEYmJpQW9zcThkV1J3K3J2L2lqVDdVYVhUQnBVejBH?=
 =?utf-8?B?OWo3NFczUWRkZ1BiRis1RE9PakNTakJzS1lMZVRzQlpaYTZiWGYvNmlkSFVB?=
 =?utf-8?B?Ync2aEZXbGVPWS8rTnZnQktvSm9lOXcwTGc2ckR0Y1NJS2RxMmJNM1YyWnBp?=
 =?utf-8?B?TFlKSllpVXdSemhZS1BpOUNRUUMxSVROTk1xSFJxK2tGLytDQmlGNm9rN1F5?=
 =?utf-8?B?VU5zRnBMay8wL1ArQXluUFVYRVhIT1AzMDRaZUxFMU1oUHNHbWozcnhtM0NU?=
 =?utf-8?B?M0RWTnU3U1R4ZGF3OWkyU2VEM0VkKytDNk5vTUY0eTlhOGIwa21KakJMckY3?=
 =?utf-8?B?V0JJSURlY0pSQVpkOUxocEZDRGZEQ0M1Z0hWcmNpeUhJT1NwZlcrbXRaa0Zk?=
 =?utf-8?B?WHI2M0NjZUVDZWtqNWF1TWRQdFAwM0sxWUZVMG1iOEh3RUpQaEZDeEJMbVUv?=
 =?utf-8?B?d1ROdUJsS2x4S1dqM2pnWUVtQWxsMTFwQnY4aklwYzhZc2t6YzFTei9wNkJ3?=
 =?utf-8?B?SVhPdm1jcUQvL3JJTUExZVFFMk51WVltOS9RYytOSk9RWjIxYmJrNVhKM0o0?=
 =?utf-8?B?Zk9DUk9xWHVWc0lQK1d3czF1U2RlelQ0UUdmTzVHWTgyRUVPRGwyNjhJUkhi?=
 =?utf-8?B?cHBZL0RHUC9zT0drcC9sdkRBNUJZQ3Q0MmJMY0pBWFRvaTVOaUpJZmNmSnc4?=
 =?utf-8?B?RnlNWll4Q3pVMlNRWlN4Q0hNM3BOOGVsWE9PajJQU0dEV2sxWlpUd3RrZjlx?=
 =?utf-8?B?M2d4TE1hUmxjazN5bnQxelU2VzlKcjYzVkVYWlhsQzRQWUV0SU94YkNXQkpZ?=
 =?utf-8?B?N3pGbUZJU1FsT1JyVkdFVXl1Mi8yK2ZadWt0Y1ZPZUxXdGNHbnNxZ1ltVndX?=
 =?utf-8?B?S1Z0cjdZUU44cS83REx1cVZ0MFNuaVFPbm5LbytINkVnRzZuTmVWbXVNeTlN?=
 =?utf-8?B?dE1sczJDaG02MzFlTm1BUUlyb3pmYk1rSlVxNGZza2RTOVk3YnQvRElCbXdE?=
 =?utf-8?B?SGNIcHo0YWxBTVhoL0hiTmtJTTg5aW1HYklBZG5jM0w4dWJRaUVzcVdwOU51?=
 =?utf-8?B?WnpMVUZBaDRkVzZXNEkwbDhvOW5yRVM5czBaem80aGZKcUVFU2thYkFZOXdz?=
 =?utf-8?B?bVhwd3NXanMrV2MwOWtIbDkyYXhFTmhiYk9hR3lXRkwwdDdHdjNId0plWE5n?=
 =?utf-8?B?UU52d0h2Y1NiZ3VaNklETjgwdjVzRE54aW5hNVdSUW9hd0Z4Wmh6WlF1eGFj?=
 =?utf-8?B?YXRZNFFqR1JlN09DTmdURmRCZE1JZXhvQlA3L3lmcEFsdlFaQjF5RHBNUW9i?=
 =?utf-8?Q?of4g+ZQyjq5K/?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cf106e-fd46-41c6-08df-08d9749c5033
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 20:48:15.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EBhKQjNf00YBtqKCFqeuTyBDfSvmf89c79X+VPtq2ceCuZiQkWIdqfSs478wKj9HS9ZdHyyJZJ674Ktyu2U/Uzki5X2wKzetttRg5ULjIy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.09.21 22:23, Junio C Hamano wrote:

> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> v8:
>>
>>  * fixes a bug around find-principals buffer i was releasing while still
>>    iterating over it. Uses separate strbufs now.
>>  * rename a wrong variable in the tests
>>  * use git_config_pathname instead of string where applicable
> I guess I'd better kick the topic out of 'next' before doing
> anything else, as it still seems to want to be replaceable
> wholesale.  Somehow I was given a (probably false) impression that
> the previous one was in a more or less testable shape and we can go
> incremental already, which was why I merged v7 to 'next'.


Sorry, i think i'm just not familiar with the process. What do i do when
the patch is in next and someone (or myself) find other bugs during testing=
?
Do i send a new patch based on "next" or update my patchset but not
squashing the fixup commits?


