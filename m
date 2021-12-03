Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5585FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 08:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379244AbhLCIhD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 03:37:03 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:43525
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379233AbhLCIhB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 03:37:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ7Lp7SBeCap7h/kZCDfJrjrWx36279lc73KpDz4Dxc/yT3Jw77nAgxnvstBfK7vBcCK9MR8J/3jIgxOUoX64HvvyHNv3zYBRf+i7xYIM4z5l1ybu4rSQGPQ5yIjCNRPWtyydG4PFuQjoDUVTKtDxJ5cPuHpKlGZW+ccyapMXjAEHGtnbE8m3CfWijren5Dz+4W+ptvvQo95fn5KyikGKj3L51PLZtKnA20kJuY/z6JATKwKLl4QHNOi72RmpB8XaZf+LQ0i6THiEejn8FJ4MX4gNsETftsKxfIxILY4EfyloX/3/4mvyRfmpbbmOH9LL6aSvZXR4suARMbm5c58yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UymY2nIcjjGWoTdyCatBxfcWmys/AfOzCDJpsnqxKn4=;
 b=RZ8p6n/DKCFUkVnKSBgtfFwcxuofo2vpI1TUw57mK77TiQDHGNyWzojCLuwj5824RO5xxQ5cCm+ZSQMtL/55sDdRrceSdRlMq5rC3PtcVednjoOqQS4WKHGz/2T5uG7c8/Utr+5FJ+JUggNhgMz8kWAFQY0Ga7aKMbFymWeItWBClNpjUPo//UOzEqykk5iz7xQjM6laPLD8VDpE3UFCXO0QhxxPCC3xQne+l+SRfetifgbuwHTzDgxWkZTqMeLVFZceCBqK2kIbPmqMuACIuV2xnrGDXOZQi0azch3+1FBhCYjhL031wpbFHmHZAjpGLvJjBLVruo8ZqRuG21of/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UymY2nIcjjGWoTdyCatBxfcWmys/AfOzCDJpsnqxKn4=;
 b=ipv/YCQpJXZOVZDtmsXU0kq/nS+OGuN3Gt9SdD+SdAaaYcORnbhhjI/Or3LvVhRXOkddaPaT9ABkSTRjAjtsvewvu4vdAUA2rzDf86AphSSRsnAJK4gy+1LINQsFbShOTz7v7ZSsX83lq1uR0PxoDmVvL/uyCA69OmPyfmF7hMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 08:33:34 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 3 Dec 2021
 08:33:35 +0000
Date:   Fri, 3 Dec 2021 09:33:34 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        Mahdi Hosseinzadeh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahdi Hosseinzadeh <mdihosseinzadeh@gmail.com>
Subject: Re: [PATCH] githubci: add a workflow for creating GitHub release
 notes
Message-ID: <20211203083334.tziwuhbg2u4lsslt@fs>
References: <pull.1146.git.git.1637840216877.gitgitgadget@gmail.com>
 <AM0PR04MB60196EFE984652ECCBD591A8A5629@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <nycvar.QRO.7.76.6.2111261455590.63@tvgsbejvaqbjf.bet>
 <AM0PR04MB601972377B5CC2E24B6BA1DFA5639@AM0PR04MB6019.eurprd04.prod.outlook.com>
 <211129.86k0grf7lj.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111301239480.63@tvgsbejvaqbjf.bet>
 <xmqqy252u8t7.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqy252u8t7.fsf@gitster.g>
X-ClientProxiedBy: AS9PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR07CA0029.eurprd07.prod.outlook.com (2603:10a6:20b:46c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 3 Dec 2021 08:33:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8cf4ed1-5d0b-4089-9a41-08d9b6379905
X-MS-TrafficTypeDiagnostic: PR3PR10MB4205:
X-Microsoft-Antispam-PRVS: <PR3PR10MB4205C3EB12DEB8A1BA93B92DB66A9@PR3PR10MB4205.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch80nDvqNUxOQnVQqKmYwpPJ/Jn0w74BQfTfTbBSwonkP+22P2YbwcKCXHNyEVqZUwIAr8/oyMyL6pomnn8JJm97hIPSzHKvHwCPLXQmgOPCSXz+IIBUXiO4jiEjXqBno55hm+vaUJiJK8Pkroku8gplGo4Yc8LOz0Fk6NkCOiOd7Lup7G5aWNm/FT/CBU513fL3RvezoqZVCEZoEiBWa7wHnE0qxrKdAHvAG9pQ7/EtP4WLv9ScVrYIc2ijoOnSYFYQ60tWpsgJqWlir+CJ9Go8EP7dDDauayWHW+DVt8qF7Aam/VanTCCWnaLbvHqXJIkqJkK4C8OhS/wIq+ykVAr8YegS8YBAeRPPvGIQIRXl7+RUHvyvmOHRjPFxgTduQkHHGh3aCVY+HUBWuC1zadpwnEXPjg/V5ExAVq0cG3uW8ZERKlngvyLDjIcwwYgw1mLsTDxvFbQeScD0QOBV7OGnNCGcQWbtICXB8B7I/5Mdje2PNlECEgXJ4kLY20pGoclCShuJqptQTQItzLBzxxARinb01Eo/aZ8yrgY8wsPSMZUVbNVQgQPs8W0S73qkL3JluYwv/3jCAX4raYUXwr0zojIGhKewxqgXbXWBlUgkVQF0SWrQnrQY6fTkW2nk/qAwsfL87ApoC81BZE2ldQrvTqEgOIYrJvjBaKgRdDpY26SOTghJ/afbvf23W8o0OCBwy13QmZuDKK4k2urnt+291QMbmMpedVfI8y7VzQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(376002)(39840400004)(396003)(346002)(136003)(9686003)(83380400001)(6916009)(53546011)(316002)(8676002)(4326008)(86362001)(54906003)(33716001)(1076003)(2906002)(38100700002)(6486002)(966005)(6496006)(66476007)(5660300002)(186003)(508600001)(66556008)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmErVHduNXNFVmxLMFI5a2ErT25hVWsrNloweWF5c1RBb3BCbjY5OXlhUXJ0?=
 =?utf-8?B?UEs1aFY5dlU1eDI4Z1VrcWpSYUhkSUpyZmplRmIvRlVqYVMzVURyK1JaOU5p?=
 =?utf-8?B?d0M4Sm9vMG9YNVNVMi84Wm1LL2RMRjRVSTYzUmxTNlIxRTVaUWhUZTh6M1VB?=
 =?utf-8?B?ZllVc2FRNTczdFd4QllxYmFtV3NZa096SGVmQ21TaVowL1EwMzFjNFpRL2hh?=
 =?utf-8?B?SnExN1FvdkQ1cTA4NkdCNmQwM2lRcndLODBiU2tjbWFHeGV3TXFWaWcvSSsv?=
 =?utf-8?B?d2g0d2dwaEFudFhMRkF1enlhNjNHRHM2VHhWZzE1bmtYRXBxMmZ6cDhxQW9K?=
 =?utf-8?B?aTM5blIxc3ZFRDZEc1FLT1hpMnRKU1pMTkZ2VDJKMHJhbGh4eGorMWFVcWJV?=
 =?utf-8?B?TENrVVBRQ2Q2K21SY1g2cCtGTmIvK0Y4NWY1QzdMTmFxTmVTeUpVblZxdmhX?=
 =?utf-8?B?Y1lmbThnaEZBMy9PSkNubC9LcWlDOGU5RWhNZ2FQQ3lTV1hieW55NkNPMXBO?=
 =?utf-8?B?STlhN25mTDZNU2lETlFQWlNKcUN6ckpiQ0czZ3JxblUrTVF0K21XVWsvaDZl?=
 =?utf-8?B?TFNST2dhY2ErQTkyVVNlUWdZVjg2N3owMEFwUVBNTHZJNUtJUDhYQUlxMWVM?=
 =?utf-8?B?dVF3azZ5ZVdCMHFPTzVCNmg0MjBiRG1SZnpJQjZwR1FoN2ZCZ0MrRjZQdzlh?=
 =?utf-8?B?OHhWbDJzeGk4UUdQU0FOWmxyNG9sdFFuZjdTcGQyV3JKT2Q4SUpkUkVkSTVo?=
 =?utf-8?B?L3grVlJxSS93MGdkenNneVNwRzEyS3hLZnFLYVFWaG4yUnpXYlpGM0Zjcmlw?=
 =?utf-8?B?Uk56REx3ZEJra2hYVzNVVno3MVRtdXlSYnZWMEF5Rlo0MDlNZ2JxVnltM0Jz?=
 =?utf-8?B?R0tHaDN0U0ZTUUwxaHNRbG53aXpCQm9icW9DMWhVVGMxWGgzcitHa1p5RFcr?=
 =?utf-8?B?ZGxlRVIzYmpQa2hvdE5sMlhGaDh6c0R3blBVcXp5bWlNUVZ3Q2JnRFNtQWpm?=
 =?utf-8?B?NlFOVmlEME8rd0VEeHcyVzdLYXRCNWtsU2NNYk1TbkE1SVcvMnNXbUNJK21l?=
 =?utf-8?B?QVZJZFZ0NWlKOFZwVlVXQVVVeTBlS3EwdzlHb1lDcTNTejVjWW83ZTJkWG5r?=
 =?utf-8?B?a3BnVGErbDl4d3ZCYU03aUNFb293RGY0RzFKUGJaQWFJMWJOMkE1aWYyR3V1?=
 =?utf-8?B?dE9oZ0JyUExwSFJ3aHNxZU0yOWR0U2VXSkNhNDJETEZoOVJ1NEZES1JFMlBS?=
 =?utf-8?B?VCtTQmNpVklNSWQ2c3FONWczSmJ4WStMNzlPK0hVbWhsR1BuLzhQcE5zVzJm?=
 =?utf-8?B?YmlmNDJBT1pacHFuL1lLTEQyRnJwNEJkb1RCTXhkcG5tUGlzQWlwakgvZ1Q4?=
 =?utf-8?B?TVhOd2QwdGptbk1sOXRHczFYT3dkUVVtdG9uWEpPMW5Zd2lXcFVZVno4bjlQ?=
 =?utf-8?B?RkVhQklySm45SGZyOHZBNVVLeVp4RUZ5Mk9pT283NjJrTm9HTDIxTVV0Zlhh?=
 =?utf-8?B?RXNDbk4vRUxBbWJpd29rNWZLZHdZZUhYZkN4UCtzS3hyVkxEZFZSYlgwbVQv?=
 =?utf-8?B?S0pUYko0b2Z0UFNydmxsZFZvMGNPNG4ydVRVUW9kMEhpYnJMZkl1R1E3K1ZZ?=
 =?utf-8?B?NExvQU5MNzBwRC9UMXVpM2JSbFJ5dWNzS1lkWkx1S1BEejZZVktwUkJEQm54?=
 =?utf-8?B?bjlkR1NqNGNDSUsrS2tDci9aelJTYUZjZ0pFOEIvMUpPU1dQd3kyM0NLWlJu?=
 =?utf-8?B?VERHZmtVeGhtV0Z6UUlnZVhXb2k1RHZwUTFZUFhDM2x4K3JqNE5GdlhNanFV?=
 =?utf-8?B?VFVCdVUzRmhiU2JWTWJuZmMxNkludVpISXM1L1BSd2FCTC8zVklCejVZTDVt?=
 =?utf-8?B?V1h1dWVCVm1tNUlQMUxUeDlnYlllWkpSSjdTQ0JIcXQ4OFhnTzZWNlRYTnZh?=
 =?utf-8?B?WW9CTmQvVU9vVkpJaEphSXBhR2ZIdFVrajVwNmVvOUFQQ3IzTkpBNmVXcDlJ?=
 =?utf-8?B?eDl0MEtPbkV5bmVZM3VHdXcrMEhiWVFSQVR6a1VqNFh5blRJUHoxTmg2NEV4?=
 =?utf-8?B?WFpyZWhJK2JndDJqcDJXY0Y2R2JSMlE2VXFjZmJqWHpOZ09iaC9ya3djVWp6?=
 =?utf-8?B?SktJNkJNQWFLRXY3RjVvd2RwL3VXcGdTY3BYVzlKZlUrTFRUVC9lbjhFcWdK?=
 =?utf-8?B?YjdKc2dXV3J0N2JKdlJrcEltSGpCaFBQdXk5TklhZFY2b1llbGlONkRxamJj?=
 =?utf-8?B?UjNadjluNU9KVktXeWVDWFpndUM3UmRvMXN2K2dHbHc1UmFkdkxPT2wxamIw?=
 =?utf-8?B?R2JkWDlOQ1NJYzRNdE43YXpEQll0dWtrc09FTzZybjV1Q01EMzRUT3ZSVVhT?=
 =?utf-8?Q?f269D4X9q1f0kzYY=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cf4ed1-5d0b-4089-9a41-08d9b6379905
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 08:33:35.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/GFHVUOd5ncGGXUHraJtyoEydu4Q+Fybr6dXGgBl5xzCLCDeuo0qd1Qzly/Jb3TaENQ1SILM1wIEzu7qRYr+x5OhVfSiOX7ZXcHQ4+vrB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4205
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.12.2021 11:05, Junio C Hamano wrote:
>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> Rather than hardcode given repositories, which e.g. for testing the CI
>>> itself can be bothersome, perhaps a better thing is to put this into the
>>> existing ci-config? I.e. git/git.git could opt itself in to behavior
>>> that would be off by default?
>>
>> You probably missed that the purpose of this workflow is something that
>> does not make sense in the forks of git.git.
>>
>> Its purpose is to create releases for all tags that are pushed to the
>> repository. Most forks of git.git have no business creating releases, and
>> those that do already have their own processes in place.
>>
>> As such, the situation is very different from the CI/PR runs that some
>> contributors might want to restrict to only certain branches in their
>> forks.
>
>All true.  But https://github.com/git/git/ itself has no business
>creating releases, as we already have the release process that
>pushes the release material to kernel.org to be distributed from
>there.
>
>So... do we still need to discuss this patch?  In other words,
>what's the benefit of creating "releases for all tags that are
>pushed to the repository" there?  Does it give us redundancy in case
>kernel.org goes down?  Does it risk confusing users having to wonder
>release materials from which source is more "genuine"?
>

One benefit that I see is that github offers APIs & Notifications around 
releases and lots of CI integration already exist for it. If my (non github) 
CI includes building the git source then i can easily trigger when upstream 
releases a new version. Just pulling the repo and watching for the tag works 
just as well of course.

However the "which source is genuine" is a valid objection. You certainly 
don't want the CI to accidentally create a new release that does not exist 
on kernel.org (yet).
