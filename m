Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A395EC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF6A60F8F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 09:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhHDJCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 05:02:09 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:33249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234880AbhHDJCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 05:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJJ/nVrTv3n50cDPibE/9cV0fIdm42i3pVZRqA28EwySw2GsAHIbpJ/HxWqYSXOIzNgnoG96eMQs9U/5mpYHbtt5XO4k5B3ZLG+8nBxp12MdCY5u7zSGPB9vlrqvWVzEypxuiApRdVFgYWde5BZveoDfnfe8jV7OskOEkXy0OxyXUYKyOoEyR6U77a2rRV9OnevvYQV2dpjCg9MZX5P7B7NO/flSmaOIfgBPyelRuuO51YKZNJnMTbmrgA/ROnGrGg30UJ1jkiN3BuqgvReCJyvyomv8/4lwQn3a/EZz4eXFivED9ffZmmCZLIpuA+WzxfL3Vks/zMZH+pNCp5z9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7PXSBBMpyYfaTtR/DMm5gx3XGlSTwahzdaXst1ZIxo=;
 b=YdIkR59fiUyXVcFHmBroHkRF2I5TyI5pXwkkjdScrOa/HKLCqLJhTxC+r4ip++q5vedvljBcS1Cz+b4HEs8cZXv0LyJuHd+ilWeiM5ZE/fydR3kI77csnEc8c87tLEMvtGtVXk9xyiU9logkTCyv5mL7HHra7W8di5KzLcb6arvoMqZFhNu8kiPiZxWefuobGIfFjTa3w8niXd8vPmACK2+1Q90FCp6gH1t1UoTCNneKbIN2+Yd6DOPmcFU7d8LnSK71TQlbapUxMxHUZfWAFtbfPFb18ptGHaXKmkS9DCi+AsqGuCY4X2eaFahR+OgPeUfWTBf+bsWn88hM+zwsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7PXSBBMpyYfaTtR/DMm5gx3XGlSTwahzdaXst1ZIxo=;
 b=g274Hy7N7GPon8l7Ea0e+qA1dasfX+ajo51qZ18G5lw+OiFU8rMiRSXsD9SnsN+rihUN8AGja9wi/iKxgk58QtSxu9B0YwZLPKkOyeLrS2Ua3riDFN/XpbXugcQrPHSuae64TVbR+IZhKUF2n2PzqGeu258YyJx1dxLiMF4ntgg=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4814.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:155::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 09:01:54 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4373.027; Wed, 4 Aug 2021
 09:01:54 +0000
Subject: Re: [PATCH v7 6/9] ssh signing: verify signatures using ssh-keygen
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
        Josh Steadmon <steadmon@google.com>
References: <pull.1041.v6.git.git.1627501009.gitgitgadget@gmail.com>
 <pull.1041.v7.git.git.1627998358.gitgitgadget@gmail.com>
 <dc092c7979618d252f7a5a0a5bbe497d8011fd5b.1627998358.git.gitgitgadget@gmail.com>
 <xmqqzgtyrszl.fsf@gitster.g>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <fb7c504f-90f7-9a79-1903-e3942f43e808@gigacodes.de>
Date:   Wed, 4 Aug 2021 11:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <xmqqzgtyrszl.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR3P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend Transport; Wed, 4 Aug 2021 09:01:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be13633-db6b-4393-67aa-08d9572681c5
X-MS-TrafficTypeDiagnostic: PAXPR10MB4814:
X-Microsoft-Antispam-PRVS: <PAXPR10MB4814D58EE203927A12116AF6B6F19@PAXPR10MB4814.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nxju78wKAEv7hsg7wv8ZiJkj9yLquGjVeGx/S67TyS/DRiP3UrhiT0HRJsq5aAQG44CN+sxmGItLabi8BzHi5DLBAGKm87mjPsg8rkTpNTo6ctsP6Q9IhrzBfqM1WfmTP3TIQf4AKAg44miZP/tcE+6SyiHcxHTZHGi4BaNEsR7EmkomPL4zTFt8hb9EU7CfhIgmWMRZj1CnAjq8uYqUJkWmr89U5wKcaXlE4nXjZQFKr5+jraWPacKWgJg3wf51C23xfZ3+AuSq2ERD+4+bRFcK26BBNoVJGCYWjY29sbBSACNuF+UPG339kgcxc4PKfmr7IjdXw4sQx7+xrbN/0/bb2izEI9QuxKZ7xpza8MwZcdrrhM20AJgCQloKUrIi1PNV1gBis852sJjKNPCzIl5PePc90L/SjMQ74Avqb5qwFXVo0zD98GTa5r+FU1R+wvd0xtHFLhpuQBldQX0WMuCyWq7b/yKVAhxAXecLvUnGlgsaDV/MPfi4o1mH5gpUmpo7mjhHwNqREwcteqfA96PnL4ELe3z1ApOH4IRDmYmTlNgZBP8VyjI5lt/QBrz/j1YTnOyqFT05qHuRUzFtjw8PqJFkOIIOAw4cix+b7iD0adfijDbYI33kK0aTUMpokFvoTP6xd+7em1iMlJUgSZY+PxCh+UW8iOStgCGCCUIqLSwgTS1Zv3EIuHM53WPjodBwgcTilyj/oAUQytGCHQcT0dlDCd4R4Fjv726Vv1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(366004)(136003)(346002)(83380400001)(5660300002)(7416002)(8936002)(86362001)(186003)(53546011)(508600001)(316002)(54906003)(110136005)(52116002)(36756003)(31696002)(6486002)(31686004)(8676002)(38100700002)(2616005)(66946007)(2906002)(66556008)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3Q4L0thaHUwRGNxbW5aYStBTCtUUEI5T1dqdmduUk9JZzkxQ1pPa3B6SHdm?=
 =?utf-8?B?Zm1yWVkyY25sbm1iQXNOQzV0SHU0VWRYdTRIdjRvVEZoSTAzS1IvU09HLzBJ?=
 =?utf-8?B?VFA3MnVlTDc0R2tjSHpkMTQ3b2IvYWRNYWh6RVdGK1d5T3FTSjZYc1gxblAv?=
 =?utf-8?B?NDhGYzRRNEtRSnFuYlU2L0Qza1hoWWRSV0ROTmhyRzhWK1dlQ0ZOTDZjNDIx?=
 =?utf-8?B?ZjVmZnVrVng3eEFCc0xVNm8rQ0g5YmdqRlF5ZDhuejk1TWltbUlSSEIySzNP?=
 =?utf-8?B?b2ExVURmSVNiNDlwMXJ2YXdjOWhFc1VZRGRVdUxTVUdXZ1Z6b3d5R0MyNEFo?=
 =?utf-8?B?N0JWNHZ6TmtMdjFvNTlpYno1Rnp6TDBpZnBLMHhzbHp3SUk5T1dYSmhaT2My?=
 =?utf-8?B?L0VyTkVna2hPazZaazV2RFVRM3BNeldOQzVNaVJ6Z291VVdHNlEreXJaaEU3?=
 =?utf-8?B?bHZVMzlzQXdaSFBaSW44NUduakl4bHpuRGJaUEc0Zi9JdWR2cUxJazl3ZnMz?=
 =?utf-8?B?L01tKzBNODVNRmNkOHV5WWYxM3VBTW41emxHQ25pWGFSeUdGbUJYd29mYVpS?=
 =?utf-8?B?KzdpZXNnRW9qUndkWjFuckZabDB0Uy9lR3BpSnlKelo4a095d2VJUG9HV1dX?=
 =?utf-8?B?b1JuU1lqdHJGM1NIV2VoU2d4UUpjdWppTStBWlRyL1NSL2RwdFdJV08rV2Rh?=
 =?utf-8?B?MDlSNHYrTXlGcEVPSVVNZWF2MTgvT29DOTd6NnYxS1lyaW9DM1AreTdJd2Ft?=
 =?utf-8?B?RWRJTTNkYUpNem5QZG56YmZ1M29NdVNSOFFwL3dscm43NkpvZDZOc0ZuSlZN?=
 =?utf-8?B?Yk9iWGJ4K3g0TkdyRm0yU2dNME95UFhHQ25OWG42WmxEK2xLVll6ZHRiVm9C?=
 =?utf-8?B?RVNFcUlWeGV6bjVlc09FYUpubFB0aVlrMTB2bkF4b0Q3TDh1eFlZY1Npdk9E?=
 =?utf-8?B?RWtwSDQ4RzZ4WUNFOHlFZ1ZENndxa1FHNnptblYwUWJpQW5nakpka2g0bUVE?=
 =?utf-8?B?SS9yN0daL3IxaE9FOW1maUZnQjVnbXFXQ0ZZeFJIdEJOY29Bd0Q2VE5UdFZ3?=
 =?utf-8?B?Q0FpNmQvbHoxbkFPN1pkdGhHOUpobGVDQmhjV2tMQUNvVFlxVExjdG1nQzdP?=
 =?utf-8?B?WlltUWY2M2ZjczBKcTBGWmt1RHI5a3NRcFRJaUNLamovV09GZTBIQ0xhNzZC?=
 =?utf-8?B?RG5iSDVEMko2eVhEMzFybFVGL2xoS3hBZXVrTUYzNFFISDE4c0JWc25odDZJ?=
 =?utf-8?B?YU52bzVvbVFxeWxLbWpuSXlHcHB3MUlyQXkvV21yMmJscnlTeFpXSGFqc0xn?=
 =?utf-8?B?WGgramZkQzczSmltaDVkT29GWko0VjhOdDhHTHVLRDd6aFd0aU1GaEZZcTAz?=
 =?utf-8?B?WFlPbW9kejh4T2w4L2ROeDBPTXd3WWFEcWV6TEVSMTNvWEIxR3FsVWtNNno4?=
 =?utf-8?B?ODBwWUlvOElIZXRVWUlRSGxKYkFNYTJ1Y1dMRW80U3RnYXNhVmJZbGFrMk5M?=
 =?utf-8?B?bmVNVlNYbHRTZkd4REZpdnZxSzFyWGxuMmdQdnc0WHRnbE1KWHh5NUtyc2Zm?=
 =?utf-8?B?MGpxaGhCVjRvTElQWURxb1lQZ283b0ZEL3FWMUJqLzROY0xFSmFzTkhobmYr?=
 =?utf-8?B?QWxNMlh1M2s0R3k3VXk5ZUdsWTR3MnorblJXMGNCTTdWMlE3emNiYlhDSXBt?=
 =?utf-8?B?UlFmbUg4VGxyblZwdkpIVWtKSjBCZE55UjBTK1dtMjl0UW4xREgwVlhpV2Vz?=
 =?utf-8?B?N2UzN2tVSU5xZzdMV21Ub1JKRVNpTGROWlJTSGdVRUo0LytaRHR3cXdsaWda?=
 =?utf-8?B?TnV4VzNrZ0Z2cElCajZJZVU2eGRISTJqa05rZC85eVBFbWdkQjVocjlIVjFQ?=
 =?utf-8?Q?7f1vDSSCTNFaU?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be13633-db6b-4393-67aa-08d9572681c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 09:01:54.8292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDoPsNUjKJRb05kb4JAn7PCzgUYWA5Jin60btKKjA4S+yO+J0zUhgWvjL4hNJFpBDgAGCafTkRNw9uIHvSHF5InHyGC7ye0VX8eJ+axCHy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4814
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04.08.21 01:47, Junio C Hamano wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 2d1f97e1ca7..05dc8e160f8 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -131,6 +131,10 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>>   {
>>   	int status = parse_hide_refs_config(var, value, "receive");
>>   
>> +	if (status)
>> +		return status;
>> +
>> +	status = git_gpg_config(var, value, NULL);
>>   	if (status)
>>   		return status;
> 
> Hmph, it feels a bit odd for a misconfigured "transfer.hiderefs" to
> prevent GPG related configuration from getting read, but is this
> because a failure from receive_pack_config() will immediately kill
> the process without doing any harm to the system?  If so, the code
> is good as written.
> 

I think i misunderstood the comment from Jonathan about this. He wrote:

"Check the return value of git_gpg_config() to see if that config was
processed by that function - if yes, we can return early."

Looking at git_gpg_config i don't think i can actually determine by its 
return code if a value was successfully processed (it will also return 0 
when nothing happened).

The return in case parse_hide_refs fails was already in place before my 
change and returning on git_gpg_config failure is done in most of the 
other commands calling it. builtin/send-pack.c is the exception but i 
have no idea why.

Generally i think a broken config should die() early as it does in this 
case with the return.
