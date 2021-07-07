Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3B9C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A1861CBF
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGGIve (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:51:34 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:26964
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231262AbhGGIva (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 04:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzUE6xHjEffGKxbcwib7Cf/jbAGZckyJExPo8kpWCZJqZjt4WruPOMRcM838Ys5TrwQmfY2U9Xvm7NwjdeVaTxMkvvz1BELSsDbqud6Ji2BqenFbNlg/zc01k7APAAanEBmcwjzZVVXoVvSeLcRinKVgCr8A72fnTKomIqocTvQUKzQ4t8OhKrhDcyPhs4bSwVB1/BZsEfPrQyeqULJgfNM7HdQPitiF8/LuBzeX8AR8oxQsbiTISXL2pFz6akqSdSHTkzuja4UbNGNlXbLGfmWvbjBaZTSPBHrmb1dNtSZkOiNK39mUxzLkDjvHRK+VNo7Z3d0OmVTHEilVCqCdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HJp4/ZjUhzBb5YhI/IbZ6T5e3Fj8eVSuNaf9pa7KMI=;
 b=jaZpjoTMA00ipOxJFCLa7hYS98IBnK6QXfmfEsSnTK/TmvTc7VNUo38fmW1wuU6xCVUOWyn+2a7rhe/WZKpMWitVD2fkvzy/ZOR3GCuxCtwPwYfJ9j9wIsYowl6tdz1bAR1LxUHzPnHaNIaUNto5XrfPU331oM89pXHs0ga96pVrCNdAearF5P+JLYkUSJnNIsn7UeTXNvJml0jQCiPR3jPNvIAyQUCnOPZJjMcdTLGckqCNJ+z6QtO4FILp/5Zmo3GmkBXhOuS6RFf9iSCwPb7f4MwWc5w7A5QH3E2qaMuobWVMRLy0HlkHl1gMLxaf/LkarsJhkstHvb5G0CYPYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=campointnet.onmicrosoft.com; s=selector2-campointnet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HJp4/ZjUhzBb5YhI/IbZ6T5e3Fj8eVSuNaf9pa7KMI=;
 b=XnA4af7axFRGJ/nvzVe5EMEqAz7lmh8lfPljSIgFf2MXDH0pscMDVj/p69T2b9y9GCBxXZ53NhxwUPjUDjw6cpE3nSPjJND0Tlyrk3PyX91wNkpFeJP5qpEjIZraGrRk0ZpvFQZaEo6J/6a9v22KpjrUiVMqjWRcP7el9vdCBmM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4303.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 08:48:48 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d8f3:d5f9:226:e9aa%3]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 08:48:48 +0000
Subject: Re: [PATCH] Add commit & tag signing/verification via SSH keys using
 ssh-keygen
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1041.git.git.1625559593910.gitgitgadget@gmail.com>
 <92d8ae43-f146-e938-d793-b8b67d810130@gmail.com>
From:   Fabian Stelzer <fs@gigacodes.de>
Message-ID: <f4a5f0a5-8713-4640-e351-69b265c74460@gigacodes.de>
Date:   Wed, 7 Jul 2021 10:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <92d8ae43-f146-e938-d793-b8b67d810130@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PR3P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8] (2003:ea:5820:600:5dc9:1fd2:e8fb:a1c8) by PR3P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 08:48:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac997887-68cb-44d7-0011-08d94124096b
X-MS-TrafficTypeDiagnostic: PR3PR10MB4303:
X-Microsoft-Antispam-PRVS: <PR3PR10MB430354AD9B712A4D8676BA41B61A9@PR3PR10MB4303.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODTg4YLwOZGXWVdZEjBI7mjqRHz+GBIB0RU/p8h3Ep54a31XgSAUPp1cGNEfEJtmLyJG0XQyiyw6PdhQNgqk0/HL4lz5Sfd1BbNo0rfuV7sOEPVBpqHAx/HnxgrtC6zdWGj7fjy9Lz+a6Jljje+COlqVR8xabqBmogVXaoUzp9WneLYHVwj95g3ARhRWkS9YHDoswuKAFC3QmCG1eitBLAlcF7vNLMB0I1TQkpatARDd7kUDCgV/eIYeDFPvfWYywqYnmowDQYrcPO3S2QGTnC+MjNkyO31J0jpqwnbvgFsxbkSaC+dFjsi5WP7/sU0VvMIu6+9pjk0alLkVwSEyzmnWSVo3SX3Ogx8wLDdkCFVCigHjn5JFnTvMuZRKSxXNgGOzMNl5FJIXfRawWvH6rarrI+5T0AbjNu/2hirqWT4dkDnK2SeD+CmUf0yJSpb70AD9z8joNlN0hDCOBoUt2nHpNARAS3JT8fKxUq9NAMMRt5iDpcWUJ0CcfZDCmPgf7UwS+uKFvT1c8yu+MAXa+GK9HHE2HbE6Mi/iyQfNWyHuj641qXsv+VV9HIgDqU1+zYb0cXyfeS8Rh8sFaXRKG+Ag/tmjptpa6NwUqq/KSxEGn7cksjEihxnTZ+yJTfGYv+gyAWmOTG9e5wL+y3ow4DefcvrXVeC097U91Sd/Ef4eFqB/Oi2Y2hcMYq3mnawo/MjMKhUCsoPHRVnPdy3ft7J+DTFim4kz2TIshqqGzRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(376002)(136003)(396003)(346002)(83380400001)(6486002)(53546011)(66556008)(36756003)(6666004)(31686004)(8676002)(66946007)(52116002)(15650500001)(5660300002)(66476007)(478600001)(86362001)(186003)(316002)(31696002)(110136005)(2906002)(38100700002)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNScnBNSnlUMlozWjZDTGlNcUoxM215dGY1U3RMWkNKWFMraUVvbFYzZ24w?=
 =?utf-8?B?eUhYQU1aZE8xN1FHcVRjbnRhQ3JOOTNicTc4OWZNVUMrQVB5eWl6MHpudkJh?=
 =?utf-8?B?UUpKS1hmbU41ZkVjQUhERUNhR3M0WnRlNEZHR2VMRzEreWo4QkQ4WkRZd3FF?=
 =?utf-8?B?ektOYnE1K0ZtZ21nUmFBSithejhuODNneDk3UFJSMjBDYXd0UG5hVTNDNG5C?=
 =?utf-8?B?dW5vVGgvOVZ2cWgvaEs2ckxjL292RUpjaUFJU2xiWW80ZEt6eGpUMGtXNnJP?=
 =?utf-8?B?dkljV2YybUFUcGNyUWNzaElCK2luVzBydnl0RENkenRJSHdvRTdaN2RlNVU1?=
 =?utf-8?B?WnZVblpsRGUvSFFwRkpJK2hCbm9EVXJEQWxiclk2NHpkTXBNa1BWZTk1VU01?=
 =?utf-8?B?VFk1REpocTVtVTVqc1AzNURYV1ZyamFJME9zRFd5MktFelZLN3YvMnpvVmZ0?=
 =?utf-8?B?MU5KNFhKUE5BTEk3UXQzM1FldDlpZ2VzU20yeTBNMlEzVzhxMm0yUEUvcG9Y?=
 =?utf-8?B?YTVCd0NpTlNKbG9PdU1JdmhpMDM5ejNNckd5VEh4K2VmcWZYeTdwVmxQd25o?=
 =?utf-8?B?ci9ORVdsN1JQbFBodU45QWNCOGRocm9MRmFZK3pVdHQxKzZsOGN6YjYyS1hE?=
 =?utf-8?B?WTR1MllGNnp5NzV3K3hJZUg2UzlIMkt6QlNGSFY5WE84SVdHUUdVMlFMdTk3?=
 =?utf-8?B?SzNxYlI2U2ozSEdCSmpoU2NVQ0dvVzM2TEZWdms0RVFxWUF2R0FnS2V5eHQ0?=
 =?utf-8?B?N1F6Tk5henlLbm5wN2RnTFk5QnhIQUFMRUw0Y1hCbzhVZS9VVG5nWFVHcGFs?=
 =?utf-8?B?Y1diZ2pPN01nWHBQTDYxOE12WTZkV2kxU0ZRcERUaU9YWlN5V0FoSFQwdmhJ?=
 =?utf-8?B?N1pZMWtERUFPenQwVThvTVdWTjBWU0tVN2RmV0tzQTBuaVRIZDU1VXpXWUt0?=
 =?utf-8?B?cjhDUDZqNTJsNHhrbUV3bkptREsyL0NIb1BsbThsRW1aT2x3emdQbGJjMmxp?=
 =?utf-8?B?c2QydnFiSDZDS2ZlZDFkS21sMnI4alRHK01kZGdmb05udEFNSndqNkVWMG9C?=
 =?utf-8?B?L1BLc1RyVEJrRnpTVjViM2dGdlRTNTlVSzd0eWUvVHRUSEpFTkxCaHU0dVF3?=
 =?utf-8?B?aGlNZEIzTDJOenB5aVU0VWZQUnVVV3NnZzNJU1VOWnI4eU9nOXRidDFaMkQ1?=
 =?utf-8?B?Q0hIUE9jWlVJSk1UVWg4VFRGWVBYemVkZGQxcVdBZUtlU3BTd1VCNTlUK1RI?=
 =?utf-8?B?MURNQ05OaU5Dc2poanYxNktvcW5ibjZpUmp3NDlScnFyVGhwdXArc3Jkait4?=
 =?utf-8?B?SWR4ZTBCclZRNzNCSmNEMEVnMHhsNE9PT3NkRVQyVndydTJtV0FxTll6UkZ0?=
 =?utf-8?B?QU5sRnpzd0ppSG0vbUM5RHhHcnVCNWhERU0zaGdzRkJYbEhMcFNYbU5zUk1q?=
 =?utf-8?B?RFhkQU9YanVLUEFhK01rYW5kUWxJcmN6WkYxeEViY2tyTzFNR3ZiYU5zdFRG?=
 =?utf-8?B?MC92cmRoOG1LZVM1WW9xYzU1T3hRL0NURTBjNEVDUnVHdTBaWjdnWXl4YlF0?=
 =?utf-8?B?WEhGdjFHWWtlRWN0YlRsM0hWOTVTaVY1WnIwRHZmeXRnc0xoQ3NtZ09FLzFI?=
 =?utf-8?B?RkR6Zi9SVjVMVEd1SUd5UVBYRGs5WVp2NjcwZHVVaGNiNE4rVkZTVXFCSW93?=
 =?utf-8?B?eGE4THk5WGI1RkVoQms3NHpKZXEwTXE4VVBvc2Z5VDkxQXlJVjhHRHlqWkxE?=
 =?utf-8?B?WHJIZ0h5TDh1NzQzZXZWK3NvaTZ4eFpmN1liaGJ2Nzh0cDUzSUZvemlUVGlB?=
 =?utf-8?B?aTA5Yi9WdGh4dU9TMTRCdmtZa0Fqbk5hN3ZHQS9wL2NkbWFKSDhuOUNZbG4x?=
 =?utf-8?Q?99IkyZMVd/s+/?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac997887-68cb-44d7-0011-08d94124096b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:48:48.4013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W85NwEc0ZhEXrPjR1ief1mxJV90/x4FfTcvcMtE64oRAl9m6Y2sdbmfsU5RpFixVSBNVqxohx/4ERnDQKTEFiNqW7W+l7jTWhvZntCtr1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4303
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07.07.21 08:26, Bagas Sanjaya wrote:
> On 06/07/21 15.19, Fabian Stelzer via GitGitGadget wrote:
>> From: Fabian Stelzer <fs@gigacodes.de>
>>
>> set gpg.format = ssh and user.signingkey to a ssh public key string 
>> (like from an
>> authorized_keys file) and commits/tags can be signed using the private
>> key from your ssh-agent.
>>
>> Verification uses a allowed_signers_file (see ssh-keygen(1)) which
>> defaults to .gitsigners but can be set via gpg.ssh.allowedsigners
>> A possible gpg.ssh.revocationfile is also passed to ssh-keygen on
>> verification.
>>
>> needs openssh>8.2p1
>>
>
> Why did you choose to implement SSH-based signing as GPG interface? 
> Why not create similar one?
>
> If at later times we need to implement other signing methods (besides 
> GPG and SSH), we can refactor gpg-interface into generic signing 
> interface (say `signing.h`) and let each signing methods implement 
> from it. 
I agree that a general purpose "signing" would be cleaner. The GPG 
kewords are scattered all over the codebase but all the paths i found 
just call the generic sign_buffer / verify_signed_buffer from 
gpg-interface.c in the end whose api works quite well for other signing 
mechanisms as well. I will rename some struct fields to be more generic 
and adjust a few messages printed to the user which currently say things 
like "gpg failed to sign the data" or "has a gpg signature" to be 
generic. Do we just want to call this "signature" and remove the gpg 
prefix or would that be too generic?

Refactoring the whole gpg part to a generic "signing" would be quite 
involved and should probably be a different patch even though its mostly 
renaming stuff.
If we want to go into that direction i could add the new config keys 
under signing.* (signing.format = ssh|gpg, ...) and keep the 
compatibility for the older gpg.* keys.
