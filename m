Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC27EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 13:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjF0Nns (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjF0Nnq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 09:43:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE1211C
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 06:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6ZHtPotbMUew4OuHd5ocGx08jhTvjkgZr7YwZtX8iO1w8C42YOxYJqnwGtQXWXEUruLLhxsp63Y+aHXvkD+8SkdF+qubzhrneiRGkUjUf1d4LMmdyADO5j0rc6RHGeV+Jv1t99pV/iv4SJ85tTbcumosgid6FFGkBdM3G1Nq6ke3daHLZM3f7Kr4tkruh/QsMVXyOa7m1y1Ftr4C/34WR1AD4EY41jWSdocwt+HQhSikqLzv9S50n7wrmQykzf/tGiWlYaIiepDhao7vrJD+EPa/acDR42GF0hJ+Hmw1KHQaOJ+ibqd8amZbgLGrhWqjwHoByDmJ74KrCz7LL9udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVCP38kPvKMZSaAf4fl11KB52fjn59u5+e+qb0xcgUA=;
 b=iaNi1rvPxB549OPhR3eFyXRps+kFb5xSXhGKHV7XuaV0cpu/ul+avNN+ev2TOpvOTIfWGboJVsDx2w4ITpYWjsV4QwB3zMCry7GL7XvhlKpQhj/Yl6U8qfQ5S+jqXJaTuCXVQJUKCpwkD/x3/CdQp+mXqW0qerHhJE1Zo2kKCB/WVpBRseeHpy6vIepomp3Udgvfd2DFyZOJhs5ITVza+yYtVrbwLRDvsMkyl1MkhIX2dx5Jv7Xhq73mRrVl1Ckfd8NSEESke8H4y8dIW2/IW75D69R5EU6Kpz09z86U+MhSVE3/MEPgE/85hZE+nV7cQm0dSpPw3Z/orn2qvabkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVCP38kPvKMZSaAf4fl11KB52fjn59u5+e+qb0xcgUA=;
 b=B4UZJgeeUk4JCndbdREJYQBEB6FURu1YaR/1FdqjrhA/7Vlc06CoCIsJz3u1TEmtkTpu6VShaVL6S5M2SCE4DBCUV68S35CS9zgZgcwAogrF1FIvvoAeLu6xt/04I0ghicWo5vKiKvKnOcZvbN/VLPmweGAefU/LhEhTztTp2XivQWBQyxYL6pUh/8dsMkxiHOWfwizporVKKWkBsDBEQqu9aK75jJBEG1+7wZ8pyzfB3uDYdIvssH7FHMS3i9+vdN/FlE9pjPpOJT8AuwHx9nP7xxVJlBd/TaOVREiEZDXlr/3iQZnz+xDpRRBatCNcfFcIWPlI2zN9WAlza61Bbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by SA0PR20MB3293.namprd20.prod.outlook.com (2603:10b6:806:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 13:43:41 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 13:43:41 +0000
Message-ID: <45ca0983-a0b6-1372-b548-2e0351988587@cedaron.com>
Date:   Tue, 27 Jun 2023 06:43:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
 <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
 <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
 <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
From:   Joshua Hudson <jhudson@cedaron.com>
In-Reply-To: <59b7a582-be68-3f7b-a06f-3bd662582a1d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::26) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|SA0PR20MB3293:EE_
X-MS-Office365-Filtering-Correlation-Id: 940b0b91-f3c1-43bf-4a2e-08db77148437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMoC9mhU4rT0a2agT2iLdBbt4wFGBy2ktjZeAgVHLiW9VHLsKoMv8jaeNnZzxXxrbaPv3hbac4OamRptJ2zHIqTArdBr3bQWU3we18pyJ00XkNHYo1yHy/opBlTflupKc7flBIyv8O/g3iTnZOMeoyoi9uEo+SrNJIskpHu/C6aLQudSPpSjL6kWlRfeUIaNOLisBJqDhrGctY70Lq+DP8lJ1cIUXdKpwXj5ePtXJUyhBlXpSP+P6BzIt7zrDLn4vfZa6xG/zFvWLat+4ciEceHa+zR2cWUjz+CglXq/jFwKOW75rTJzvNjq6DOW7gUDxqwvviCl/3AsaINHRlh9OwNkONWeTB32mhDyfDIJutTGplYY44fNqtDlbNT2yM5W6IJVG7Ma3dNIfG8OmeH8iCckXe0nCzWvFsA28DszBLBxcHggDt0XZmF+c4wLtIp82EXPu145izIFj/GAvCd3jPVXAwMoz8D0YaT/zunY07/A0aQURDcTGk20ioS2pvr2APaiSYTMDwZpG8HVXM9FgyqlAdZXQZ6UVGgm98JMEE0D9pFlBKNt9EIxPhP/rP6nkhtpetRYvm23YZac4NvKnzqD2DUI248oe2cv1ci8/6oSwQFPqEJQtxrjVFbns9XJjZRaSMtyqI9mhEu/aqhjLED10b5nRjG6yYuogNOw0D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39840400004)(346002)(136003)(366004)(451199021)(66476007)(5660300002)(2906002)(186003)(26005)(2616005)(38100700002)(83380400001)(6512007)(6506007)(53546011)(41300700001)(66946007)(66556008)(8936002)(8676002)(36756003)(6666004)(966005)(6486002)(31696002)(4326008)(478600001)(110136005)(86362001)(316002)(31686004)(43740500002)(45980500001)(460985005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVXWll1MDhsbjJEUUxXR1UwdGhGZUo1dmFvRG1NQ1B5S0ZpMncyMnhnL3U1?=
 =?utf-8?B?c3IxQUVJbmg1NDRYVDFTRG1xTjI3SnVGYmpmb056VXhWU3kyUkNjbzh5eHVV?=
 =?utf-8?B?QVNYWjUweStLdUdzZndGUlc3M01TRXhmUWlNVk5SZy9qN3FWMjdjeCtQVHYz?=
 =?utf-8?B?OHhRMzdpZjhwS0M4N1ZQNXVhQXpoVGdXcWwyMnZmNjN0TmZkOG8wN1ZXVzNZ?=
 =?utf-8?B?bHQ2dG9SUXFGMGdzbHRSVmlmY2NPYkt4bnZHWk1scElQRGtkaTB4ZFpSdS9H?=
 =?utf-8?B?d0RhMW1TSkZ2WVhXV3B0Q3hJeldocVV5Nlc1Z0k1UkFEV1hBOWJZZHNDQk13?=
 =?utf-8?B?N0sxV0hJUU8vTktWbkxNbHplRGNzYWFjd2xSdGNKWkNudnZqZXFDZHhZcGNi?=
 =?utf-8?B?N1hLeWk5QS8xb1JvQ3hzajBOTzVLNDFIVjl3bEM5QzNMdkM4OXJPSlFKSFBT?=
 =?utf-8?B?bW9zK01ldFZLdll2OEVReXc0bmFHU0laSFIxcEcxVEdKb0h3eWlKcmh1VWI1?=
 =?utf-8?B?NDV3VXZPSnNQN1JIejg2WC9nUHdNd0JPYjJYbjNJL3dTakdkeG50WVpaV3hY?=
 =?utf-8?B?SlZUc2JkMnZ6TXhUZHA4TjFvcnFqQkdmRk5pS2NSbnptUDVRbW5sSHJyaEZO?=
 =?utf-8?B?djJ2MEpQeEJwRHJ5eTB5V3BkYzViWEx2SmZVMUcrMU1xSUwyNkRiN1ZTVWs4?=
 =?utf-8?B?Y25BeEl1T0pmZnhLdGFiMUNuTVFsRDkyTG5HSFdZMm5lTjloWnVXVFdwZUk1?=
 =?utf-8?B?QlR0VGVyQkM5QXZWbklaWVA2OG44dkVxeGtkeitTL0VRdlNVODVOajA0RWhL?=
 =?utf-8?B?UlF1aGdQYVkxdklpTXAzME1zU1pTekpxODIrVkpKTllQUnpSYUpSTXY3MUdI?=
 =?utf-8?B?ZlJBMUdiRUYrVFB3cllzNnpaa2NWUjQyVkpVL01UUHhPZnRySmNBV2xWVnFs?=
 =?utf-8?B?NDc0Z25zZVI4clVrNG92R2NHYm1mMXhkbThORERNMUJZVTE3dld4TXdlcHdq?=
 =?utf-8?B?aEtFR2QrbnF5enBrQ1Q1WC9RK0JHMDZuc05jUVBFNDZJR2xRWE4yOXhJYmho?=
 =?utf-8?B?T2pZcFEwaXNNOVJBQUowUHNXZHBnVUp6VVZpTWNaM21ZUi9wdlozZm9BSjdq?=
 =?utf-8?B?eW95dHJyQi83MjBXc1NRQm1aVGx3YWFYdVU3R1BUNnJmZ0pTQUZwSHJ3ZlBD?=
 =?utf-8?B?anBUVHFtRlJBNWNJZ1htaGU1YndGQ1VYdjAySjRxSGlFZmxJbjdUM3QzNXNY?=
 =?utf-8?B?dlBrL2dZZSt0dWNzLzhTSVRvZ2VZSUVKcmtrcVkzUDF5c3RlbzU1c2Y0eXV3?=
 =?utf-8?B?MGtMdkdxS3RwSmY3ZFZOS1pLOWZ5N0p5ZzBmNXVmT0hVemZUbGNhZzNUR1pv?=
 =?utf-8?B?Z2JERkUzLy9DSFM3VEZvazdTSkwxc0xEMFVJd3VUNzM4M0g1VEFxd1h4QzJz?=
 =?utf-8?B?ZGgyRFEwNVc4NmdyYjlJWSszOWFCWU5qVXdrU1J4ZVM4WWtGWDlUNFZ1NVFW?=
 =?utf-8?B?cFhJTXFOUE1nVlJEWjRxMkhPRk1TdVc0MDZWTGhaRlR3NlJJeDF3OGpMYkJs?=
 =?utf-8?B?SitMajcyRWxoTzNuSU9JYWh5U2cwVGNhU0VQS2tKbll4cVpXT2ppN1U4NnR1?=
 =?utf-8?B?ZUU0d09kWWZtTjVZbEtvSkdNL3Z5YlFrN0tQeFVYaGVYQndCV0F0L1dWR0E5?=
 =?utf-8?B?VEZyd29nRUt6QUxhUmpuRmloTkhyMFJPeHJYa1BWUlRESm13YlRoaFY0OVRu?=
 =?utf-8?B?ZFFNRnZpY01VVUhRRDcwSGN5MDBGUGZkSHRFY252ejErOVlLLzZsYkJyZ0E4?=
 =?utf-8?B?ZFRIVU5YZlNWRHpHQ2JjbnRrYzhnQ1FQaDA1Z2dhbWRmc2hEb2Ria3FsT0ZX?=
 =?utf-8?B?eklpWFcyUzAzdlprVS96KzV0WGlQM1lnZTFkZHN5Wk5lY2h3Mjhpa094cEhl?=
 =?utf-8?B?MUNPVVZ5NDFjbkVNRjlNV0ZxKzBINjFCNlRKZExJWXNpeDFTQmhaZWxDVEEy?=
 =?utf-8?B?K1Q5MkNPaGxEUHNzdzJIUWFxa2k1VVVqNGF2VlJxRi9HbjVZdjhabmVGQVhm?=
 =?utf-8?B?akFxVEJoL2lRR2NhclAxdXYwSU9qWWFPYzdpV2ZFVEp6VHFCTkdiRVk3OHpU?=
 =?utf-8?Q?11dDXrdbzotS58eUc4UAsmqNy?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940b0b91-f3c1-43bf-4a2e-08db77148437
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 13:43:40.5835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy+FHJbFJD79Y8AjaMZCnzOnnPxALZh3oq3YGAV71XGubVB8x+Y0+MYjChs+b7iEpuzVuySUBMaUb8IT5b4Rfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR20MB3293
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/27/2023 5:02 AM, Johannes Schindelin wrote:
> Hi,
>
>
> On Fri, 23 Jun 2023, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>>
>>> Thanks for a quick review.
>> Unfortunately Windows does not seem to correctly detect the aborting
>> merge driver.  Does run_command() there report process death due to
>> signals differently, I wonder?
>>
>> https://github.com/git/git/actions/runs/5360400800/jobs/9725341775#step:6:285
>>
>> shows that on Windows, aborted external merge driver is not noticed
>> and we happily take the auto-merged result, ouch.
> Hmm. I tried to verify this, but failed. With this patch:
>
> ```diff
> diff --git a/git.c b/git.c
> index 2f42da20f4e0..3c513e3f2cb1 100644
> --- a/git.c
> +++ b/git.c
> @@ -330,6 +330,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>   			setenv(GIT_ATTR_SOURCE_ENVIRONMENT, cmd, 1);
>   			if (envchanged)
>   				*envchanged = 1;
> +		} else if (!strcmp(cmd, "--abort")) {
> +			abort();
>   		} else {
>   			fprintf(stderr, _("unknown option: %s\n"), cmd);
>   			usage(git_usage_string);
> ```
>
> I get this:
>
>
> ```console
> $ ./git.exe --abort
>
> $ echo $?
> 3
> ```
>
> For that reason, I am somehow doubtful that the `abort()` is actually
> called?!?
>
> Ciao,
> Johannes

abort(); does _exit(3); on Windows because there are no signals. This is 
easily changed by providing abort like so:

void abort() { _exit(131 /* or whatever else you think goes here */); }

