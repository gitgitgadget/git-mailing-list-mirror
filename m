Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD8C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23BD2343F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgLIJ7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:59:46 -0500
Received: from mail-vi1eur05on2116.outbound.protection.outlook.com ([40.107.21.116]:11713
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729089AbgLIJ7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 04:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAQ9S5rRJ4DdqVFBvuZ1gLzr47VLS8dACLfmCR8dJ9Dk1axHVNuS+RLvglZbWWYJbkW3Ot5e7Wf4WzO4LdBy+dw4vHvqGAnBYRVRWDPSMM2oDqPiafIjyAzX0JzJahHqD6VnJCdTLoNRZnLikT0l7XolwFrPdaTi1Kum13ZIR6lY5GDXtuo3bdPtZPZV0mbaZuKJwO6db60LXKePrNBm+ZPEhGJWkcX6Zd+Buqa3rwETtOgZlwdJtpFvMhTIAclhGpeK6kyzCqTI817lEvfXe3iSVWCrriXQlouoWuwI79qeYzSs4j1VKVfDCOxDUKHftl44PU9v3X81n7tqErQ4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjFonaTMk9J2Ldicu57PLi0xC61jy+yk5Yc/27SoFv8=;
 b=gsVdnJTNKdkhExaY60PY8J3CBiyTG0NQSXOAPkCCHyKjcgp0TkttxTkS3dRC/ojN0SNFlBdAn6P8MPmxOgn5v+Zt3fHhW+Picucu/YGUPq9Bef0reqAMDLeg/D9JGqSqjGB4vzwtL5JtIiloi2idFHbosaLQc9Xqr+FQYAD0trbFa5IhxQ07ougYlm9pHUpvtBe9DjerCys7ugYedfzaPndNGKKbDcY1QdShy40++d3O6at+vAX43I51/WgH6923bD0gh9UgeMsDAIYQcISZ9CaiG93vrldcZkgmYsVlFEmYhsw55v7jMEw7BQjtEgZFRjTNXubrpzJhP7iYFb567g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjFonaTMk9J2Ldicu57PLi0xC61jy+yk5Yc/27SoFv8=;
 b=GkWWlKSzNU/MaPLb6HSPzv3a49QCOnCMFDfePVKVomuQPcS3a/WeoKqkwJz/Mbp3Jre4zMrsbIR1eARzj5PHa5hfxceLGhsqc1t08+tmahRXk0a4HQEJGsaiwsrpv8E0bAucBKyDdgd50XPnVrgNcxoy+ejDoU90SdpnoiPMKVo=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB5896.eurprd07.prod.outlook.com (2603:10a6:10:2b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.11; Wed, 9 Dec
 2020 09:58:47 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Wed, 9 Dec 2020
 09:58:47 +0000
Subject: Re: [PATCH v3] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
 <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
 <CADtb9DwwfAG69YmM0+0FC6qkO361-95Uy8dNZ8jXnrVcxHSrMQ@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <c0971d1b-3bc5-8004-09f8-7ce10fb3df26@nokia.com>
Date:   Wed, 9 Dec 2020 10:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CADtb9DwwfAG69YmM0+0FC6qkO361-95Uy8dNZ8jXnrVcxHSrMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: HE1PR05CA0304.eurprd05.prod.outlook.com
 (2603:10a6:7:93::35) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.8] (131.228.32.168) by HE1PR05CA0304.eurprd05.prod.outlook.com (2603:10a6:7:93::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 09:58:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: efc91849-f8d7-4f0e-f4d4-08d89c29056c
X-MS-TrafficTypeDiagnostic: DB7PR07MB5896:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB5896CCED9A575E14446C147DEECC0@DB7PR07MB5896.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:138;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZ78rFk3Rsp4Sn5jJGm+/pzY1deapGnL/bBogbzgCljqOhxLtHBj0XDHtvIWo7S1yopHTM9XOdQO16+Uj0UD2JVwDUl5PRrJWWcDXRSfOHdpc8Urr48jF0pCUxYmhzMnXLu6GLwDJCv4Ns5JmEWPAGtyeM2408rnWKIhrR1olyxTGOXsBYdmF+dpm0eFzfoEf6sLcROw936cNx1i+E/4ANUAkrc3Oyzewi2Ro2/VK+3P7DVdLNZUPfX8D8rJ225fYLC7A17bFL0z+CZgRBHGrH5uMehPlfbkXjrshSmAWsrJI60NrmhLJGveQPjTEchwKqy4oFQaPf6YBU3nRlGlIIC5tcJnrI64nVQ2ZNCB3Dn3X3N+fcownj5c71s0/RXcpoTEG0NmXLfsxXCw9gWgiqkkiKANkwD5fgdCw6J9g9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(2616005)(8676002)(2906002)(956004)(186003)(36756003)(478600001)(83380400001)(8936002)(66574015)(6916009)(6666004)(54906003)(6486002)(86362001)(66476007)(16576012)(26005)(52116002)(53546011)(5660300002)(31696002)(16526019)(4326008)(66556008)(66946007)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N0FBTkxHUyswOUN0NzNXSGhmc3VRaUxzdGZOMFM1Z0JteCtJdUxnYlk3ekxY?=
 =?utf-8?B?allDNzZxZjNnY3VMR29IWUdnUzgvMmpITzduRlRVcDJTTHgxR2JQWjAreEdD?=
 =?utf-8?B?TG9aTnhTQzdBSi9IU1hDZ0c5ajlhSExGeVl2OVBqOW1tRDlyS3hIeUFIU2ZH?=
 =?utf-8?B?elBFK2ozTWZzOVRXalRwUDdwOGp1b3VTYmg4cWZLWXhlVDZ1T09uaG9kc2tI?=
 =?utf-8?B?OGwycVRFTW5EZjdXQzUzUUdKN3RhRWxqcHBVNFFIc1QzWGNkZ3hwVDJyblp0?=
 =?utf-8?B?VkZpSTEwUkdtcWQ4SWtFWFJ1V2M2YmRxSmdWVnBmWnVEWUdLVkQ2U3pEZGFD?=
 =?utf-8?B?WnlZdStEMUxQZE4yVjFOQnJFT1FyN09VdEVIWmtXRDhNay8zYkVlenlJZld3?=
 =?utf-8?B?TmhmeGRTWU10QjdLVWpkdnlxaDBGNGRlS0NRVmVvSVp4TkQ2L1BZUjRzdEZU?=
 =?utf-8?B?MjNvbUhoU3JlM29GQm05dDBPakVUZXVNK2Vya0Znem1YVW5Lb3o4TE1yMGtt?=
 =?utf-8?B?Mlo2elNuRHlWTVppUkxwVWZoMTVLUk4vSjU1NHNxaHkwUXBiNHdNYW16WWR1?=
 =?utf-8?B?ZWxWTGEwdEZjdGNObjQ0VjJUNTdhSFFPb3lBR3hBMGoxb3NWWFZFL1JZbWFX?=
 =?utf-8?B?OVBKS0pVTVBWaVNHVkV0NmZyNmwzbTNjWVBnWC9xelhpMmQ1dTllc1g4OFBR?=
 =?utf-8?B?QWZVcWR5K2FrNGkvVWxGQWtPNit6NmozMC9ieW9EUjViQzZjK29mRGwwZ1JK?=
 =?utf-8?B?MHNHWk92WmJHK1pyRFpVa0djRVVjWVl3dmFDejREOTRzOGdXbkoxK1NOUk1y?=
 =?utf-8?B?M3FVdWlEbHZSWGlKSXlaN1NwMEtDRENZek9INUQvR2JEMDEzOEVPVXVkS25m?=
 =?utf-8?B?U3JNWmZPQzFKdkZMV2h3ZGFuYkkrbFNTQ3Q4RHFiZlAvTGlJVVNpMFN3aDN6?=
 =?utf-8?B?S05tNkdDN25QaEcrVmZnMktLZGdqcGRMQVJncnVlMGNKS3drenVjcHB1YjR3?=
 =?utf-8?B?NUpDTmpEMERreG8xWE9hQSs4UmxEa3hPM1oybDZvR1Rxd1cyYldHU0pkRk5o?=
 =?utf-8?B?T3V6UnNOYWJ4R09TYzZDVE5ueXM2RFBKY0IweDBJdE1ZYmZKY0FJZWxZejVI?=
 =?utf-8?B?azZvVXlQU3lMamZFemFFODUvT2RldGtGeHZWU0ZNTmNnTG5RaGl6VHdWU0N2?=
 =?utf-8?B?ajBiNmRMNlU2RlVFa2Z6THVYRTB0RHdMMHJCZmMzZ1N4NGZqVmJzbUNlcWpy?=
 =?utf-8?B?YUx5dVkyblhyc2NPSlI0QXhwbWRqVWU3VmRpZytKRlREY2pVZHMzSWRXSjFZ?=
 =?utf-8?Q?74pefhwu9ZBvQV197lnldh6WvqjdSWXtkd?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 09:58:47.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: efc91849-f8d7-4f0e-f4d4-08d89c29056c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfwcC4udsLhAwCifsyZiegT7Fosq2GLWsMa4opuLrsBPgL9NjRfOEIUiTezGNBGCr5I0WoNNvvVS44FuzVhk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5896
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

when sending the patch yesterday, I had the gut feeling to hold it back 
to double check it a day later.  Should have done so, some of your 
findings were really stupid mistakes.


On 09.12.20 00:25, Philippe Blain wrote:
> Le mar. 8 déc. 2020, à 10 h 43, Peter Kaestle
> <peter.kaestle@nokia.com> a écrit :
>>
>>   -- 8< --
>>
>> Furthermore a regression test case is added, which tests for recursive
>> fetches on a superproject with uninitialized sub repositories.  This
>> issue was leading to an infinite loop when doing a revert of a62387b.
> 
> I think this paragraph could be removed as it's saying the same thing as
> the one below.

jip.

[...]

>> +fetch_with_recusion_abort () {
> 
> s/recusion/recursion/
> 

yes.

[...]

>> +test_expect_success 'setup recursive fetch with uninit submodule' '
>> +       # does not depend on any previous test setups
>> +
>> +       # setup a remote superproject to make git fetch work with an uninit submodule
>> +       git init --bare super_bare &&
>> +       git clone super_bare super &&
>> +       git init sub &&
>> +
>> +       >sub/file &&
>> +       git -C sub add file &&
>> +       git -C sub commit -m "add file" &&
>> +       git -C sub rev-parse HEAD >expect &&
>> +
>> +       # adding submodule without cloning
>> +       echo "[submodule \"sub\"]" >super/.gitmodules &&
>> +       echo "path = sub" >>super/.gitmodules &&
>> +       echo "url = ../sub" >>super/.gitmodules &&
>> +       git -C super update-index --add --cacheinfo 160000 $(cat expect) sub &&
>> +       mkdir super/sub &&
>> +
>> +       git -C super submodule status >out &&
>> +       sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
>> +       test_cmp expect actual
>> +'
> 
> I think this is overly complicated, what I was hinting at was adding
> the submodule
> in the superproject before cloning it, so something along these lines:
> 
> test_create_repo super &&
> test_commit -C super initial &&
> test_create_repo sub &&
> test_commit -C sub initial &&
> git -C sub rev-parse HEAD >expect &&
> 
> git -C super submodule add ../sub &&
> git -C super commit -m "add sub" &&
> 
> git clone super superclone &&
> git -C superclone submodule status >out &&
> sed -e "s/^-//" -e "s/ sub.*$//" out >actual &&
> test_cmp expect actual
> 
> And then running the two tests below in "superclone".

Indeed, looks much simpler, I gave it a try run and it resulted in same 
behavior, will double check the logic of it and then send v4.  Thanks a lot.

[...]


-- 
kind regards
--peter;

