Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0602C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhLHMzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:55:24 -0500
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:54436
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229751AbhLHMzY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:55:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSRLBCFDdy6EPwHp63+jkKWXxnBCiVurnyY1n3kjiSld2wPDTbv73FLCjvBuZkgzBmSIkYBYXSj2RKMonFzBopwPJJgNOks1GE8NmTf3k99+HmdvRSwhJRaQuJLUwrfJfdBatlc5ZaG8Cr34lmYkpat0bVpJ0LHi4bUPkgidkXMYVzy0QTS625gRzyDaktHYsEwBCYDdnzouVwa2iaAT3hZ3ZmFz/TYFR+2TLGRXdrd/SZVPNpJnndPWEUG+e5nQlEVqdYRHJt8bf9xIToU0bJ++2mNcmljW4Cj1t3S+7XfGna6/DLsBxswL1QEUFzPS9EpOH3pvVOkjnRWh2LxAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh758+GmzgyjIfpTzG2RhL4nCVR0cGNLLpRjUaspcQM=;
 b=idsRruauvfkjjZQZdr7xwX0TT7TXEtMS4dKZIwy2iRcCmrba/rPMTlkTxFkYbiSv7MEr+fkhuNbQoCORN0q0KwNVMzzD71td+NGHsRMR4nHnkfsqHkv6l/mG2VJgGcY04HUsut7A/Yyw+Bx/veHHJ2jdh0NOSnZRdrMDsGuyW71DeoCl6vUo+ECJ9pI8PqyrwmDa8801OeL9LpHIJnQX+X+Yx7ZJ1qHJ21xGPyH64LQYhZSEpMkrHokRdb7MpfAmU+4Zi+6UDK4MaThouAe3etagxprGOY4uGZvNS8VGdKcOSjeEq4LtB8yW7IVB+hVb8G72Y0S56+CMerxVP7Yljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh758+GmzgyjIfpTzG2RhL4nCVR0cGNLLpRjUaspcQM=;
 b=vRco7ughNmQzBnjZfcCqwaqSbQzcCVKsBrHRaKDzBbbkD6vL9lZHepSDsmn7MDLm1DHt7Hm3fHzoKXkUGAinJP4XVsw9qvqImFd5XMjfFHq883jhPV71IKsuE7lXKim7RrvOICenCRSJQnVjE4R8p1MNp8MEOzpxYgDlrSbkQAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4749.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 12:51:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 8 Dec 2021
 12:51:50 +0000
Date:   Wed, 8 Dec 2021 13:51:49 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     rsbecker@nexbridge.com
Cc:     'Robert Coup' <robert.coup@koordinates.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [Question] Switching the URI from SSH to HTTPS for submodules
Message-ID: <20211208125149.enyd22nnhmvou6lr@fs>
References: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com>
 <CAFLLRp+yakYKxeGHjvg-8s-5QP8GqMeA5t+azfny=v6wtPPW2A@mail.gmail.com>
 <00b901d7eb79$c374f070$4a5ed150$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <00b901d7eb79$c374f070$4a5ed150$@nexbridge.com>
X-ClientProxiedBy: AS8PR04CA0164.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::19) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8PR04CA0164.eurprd04.prod.outlook.com (2603:10a6:20b:331::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Wed, 8 Dec 2021 12:51:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8cecc47-9631-4838-c48b-08d9ba498068
X-MS-TrafficTypeDiagnostic: PAXPR10MB4749:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4749E7A50FD991B792A2DCE7B66F9@PAXPR10MB4749.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0/eIMLzqiKBBkWD+vhTMVWHFDsdoUgCgkLR0reykvde2ov4v+vSZ2pN6Z6kY/4jM9Jyz0gJcgsCcul5kHdLsGmuJ1S1NT8DQXY704yxOIoGH4Jchwalyd+VJQ/jR/uMkhkSuaJSbjhFqO8uoXMLjDE39YlElqIfoI+aiN/nvYfYCoMCgJxI51fRR+5oTHrivjR8QCmudPs60gKabHyl18t+0E9nwzp/2X2kPdYVWOgNjK6x6H7AY7flyvFNPjHId+yZ0r0rqrlkfWP3Ui6H7jRP99gIcHQ1DzydzhDqGRGzacsKLlvg9Ny0D+OmSxrvb9qbpjC8gtAaowtYmtg1YQ+iCefMeM3ZRGwIox8EcHJ+amg3vt84w3Qj9MK9kka0tZLDcHXHTjlMfju0IvAL3xHBPbo/f7sz8OD2rhMixFEy8TGU8Rh7ukOQaT4KVuBGgFv7ABYJrIitX2wzM6J6OaaoVgxwKeZzQeK5wgl7kZl0ZOELDyWowCrai1ckFLlekYGvA0B0A4mwdrkOWPTZ7+G3DhdK/dCMrWWj2vBNhVC+5RlI0v7t9odM5jTefnABJEGTYIiE1uPJVl3o1x3NpffFV0AvxGZ+kkVUi0AsftEEQtwkn+IjcJRrY/qd7zqOQMc3IrGPbzELXJgwsQXPPw40dDNL+wIlfCt8H9ScRvfAtx6/NGhzh813/f4UQ7okRkjq1rOpH5GLEQyhZ03TaqeJ6hG7BnyMQvDYOLtg8rdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(136003)(346002)(396003)(366004)(39830400003)(86362001)(33716001)(6486002)(1076003)(2906002)(38100700002)(66946007)(53546011)(8676002)(8936002)(5660300002)(66476007)(66556008)(186003)(966005)(6496006)(316002)(9686003)(508600001)(4326008)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxrUTlST1VMSlN5Q05LQ29nWjArYlRCc3hlZmtnQWxqY0tvaFZQL2pGNGFo?=
 =?utf-8?B?RVluNy9zQmViNzlFQlROKy9ELzhXWVFPTEhYTWkvOUQzSnl5VE5SSzVBcEFM?=
 =?utf-8?B?YWUvWk1nYjZodFlLSDhRSUdwb2lodnplOFZzcTJMaDgzdGlGWEJqMXZpdHht?=
 =?utf-8?B?NVdHelVtQUFPUDA2c0hrb1c5cndFQ0FLeTlWUjBaOEh0WjkxWHhicVpoNnVN?=
 =?utf-8?B?OTVEbm5JY2xMTXVWTHcxSkRvVmtabzBrdkZZc3Ywd2grNUkrc1FtaEZPQ255?=
 =?utf-8?B?WlhMWmdNZHpscE5tYis2M2Judk5zeEI0dzVBdEtheHBzUFFaSkhrcXFOYVlM?=
 =?utf-8?B?Rml4S0FOaWlZUkFmUHhISTNuVFM4RTRRNTN6SGN5YjhPZml3dnZCazJxYXFu?=
 =?utf-8?B?UVF2VFVmY0Z3UlMrVVZFZ1p2ZFNiWDlBQnIvem1sSFMvZDRTQTBvc29YZHQ1?=
 =?utf-8?B?VmFpN09JZXc0ZER0a29vcURMSVhqZlhWT0trRURLcC9GcVBVb2FLMk5mRkVp?=
 =?utf-8?B?QXFxaSs4MnE5RjZ6aTdGVnZFaUJmU1lVU1JIcnZHanBEL0tlNlF4d0x1Q0Ew?=
 =?utf-8?B?aU1rQ3ZDb3hUeVpJY2xJR0ZLTlpTbWtoV1d4SG4zU1daenYxdy9GendkU0pL?=
 =?utf-8?B?UndsQmpwanlmbU5CMXMyL2ZYa29WK1VGc2dwRldvVkJkakZNZnhuMVdDc2Fr?=
 =?utf-8?B?U29OWjBjN3lzMm9KOEF0TkhZL3Mra3N5UkpmVTJMUUNhNS93bXFNUFZBdGJ2?=
 =?utf-8?B?S05jam1pUWlNQzJXN1hFdlhZbEhhQ1hGZ0tQYk15UDVCQzh3ckJZbVRjb2ZD?=
 =?utf-8?B?Y1NrMUhhYmxpaFEvbkxIZW9BMHRYMEphdkNvcUdmR1hHcTRxNVFIY3dPTWpI?=
 =?utf-8?B?azgwOCtoUjRKbDdiajd2bmdvZTVjYitpTmFJNDd2alZUUC9ZTElSdG1rQVhO?=
 =?utf-8?B?OHBQT1ZmRWU2UDcvaUtoVFJua0NFMVV6QllJVFYzK3ZzMnhrL3Q5azNZejVQ?=
 =?utf-8?B?dFBXaThvUUpPV3pQMTN6S2ord05LbnIrZkRLZTB1VC9FYTRGbW4rWCtkTnBV?=
 =?utf-8?B?N0NGbzJTL2sxZmpVL1cvdjVVcFZzd3FVUjdGR3NBVHBJN0l2TGYyRTJiN3BM?=
 =?utf-8?B?NG9ZUytER1N2UjZIQjN5d2NXK3FLY08wWXovMXZwclRTQjlpYnBtRHEzRm1k?=
 =?utf-8?B?UzBhcG9oZ05tOVRTd3hDQzZUeSszWENLVjc0MWUzaHc3U2xBVWV6c1l1d010?=
 =?utf-8?B?aEtnS0xFcFNVOFFTZXBPam5peVhkNGlZSGk1QzVmVDJ5TDFBOGhtT1VWVHVm?=
 =?utf-8?B?czFSM0JLdGp5YVQ5UXdmYUZNQ1A5bUxIcjRUN0lBRU5CZnYyTkJZOTJ1MVBG?=
 =?utf-8?B?ZzBTV1RwQzc2Q25HWW5WOU81ejF3dmpKRU03V3FvdUw4emFyWm9WeDJOb3U3?=
 =?utf-8?B?cHpNTWc1Y1VtQW41MmVVdStTR0piczU3YVRCWlZEREdyMFNNcmVpY3RXSFBI?=
 =?utf-8?B?cDZEanRXYXo4U3lobHY2Wk1VZW5oY2NzYWQxZUNOTXhEQ05hc0hocUpES0RC?=
 =?utf-8?B?Zk8rcWNHZzhQNGEyS1k4UVl3NlRKS2JoUzNFcnF3QXJvQldQWWtmTk1wRGs1?=
 =?utf-8?B?ZDh4Y21OK0dnaUlML2tmVFdHUGFITmNabGVXM0lTU0U2UVhxRjJjMWhXWm45?=
 =?utf-8?B?L0pucU1pd3JKNzJyTzRpOFZYZWpwcGpBeVJFdVhzczU5VHdzSEZoVlZRdVlQ?=
 =?utf-8?B?b1lDYjRmUTcvSkZPWmxqSTMrTHJIMGJiZml2ZUFTYUl6eDBIanpFcGN6dm9x?=
 =?utf-8?B?STArWXNkeDhEbThxQXp2d0Rvblg2YklPa3dXcmxmdVB5SFF4NS9JQjF2MkVs?=
 =?utf-8?B?akFXb3NZV0Y0SFZnaUlRdmJmdTRSdHFwT2lJMUVuV3p1NWk3RC8vNkdrdCs1?=
 =?utf-8?B?THUrcnRjaHh3cW0xTFczdFV3ZkZxSyttdGwzNHFFMGROMjA5a3hRUnBCYjk0?=
 =?utf-8?B?QlJqK2tuQzRST3JvVnJCMWo2VHU4WmFxaUFrQkFvV1dmNEt0dHIxbG43d2o2?=
 =?utf-8?B?U2YycEd1cGdVNFdJWFpnR0dIajJWQUdJcktvZEFZNTRPOFlUdE1YdlkrVVU4?=
 =?utf-8?B?dFRjbnJrdk14bTlHVmoySUVOU3ZWZ1NjTEUvQnNGd0ZvcUZVQzN4UVJUbS9D?=
 =?utf-8?B?T3VpRk5jRnlDZ1VWc0pTT2RkSDRtUUFZaUZTV3dtQTYvemx6RFZOajk1cFZP?=
 =?utf-8?B?SFZmNFZTbWwvOXl4T0VuYmFKNEY3Ly9ZTlM2V1NyOUtTZWV4L1JFMTgvR2Uw?=
 =?utf-8?B?QVc2NFYyYnRsdFNYL1M2NGZrejVBZENuQzVtL0VvcXlCSXB3YWUxUT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cecc47-9631-4838-c48b-08d9ba498068
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 12:51:50.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ts1ezg7iVnStlAPM7jpKHQapU0coAnvneZSpFS1mWxjW8t7elxTauex5PjZDcr17CFw5Q3pSWP5YDkhj18S0M+R55FoYpt1R/P60PGzmQE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4749
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.12.2021 09:50, rsbecker@nexbridge.com wrote:
>On December 6, 2021 6:54 PM, Robert Coup wrote:
>> On Mon, 6 Dec 2021 at 23:10, <rsbecker@nexbridge.com> wrote:
>> >
>> > git@bitbucket.org:project/module.git
>> >
>> > When in SSH mode, clones are simple with --recurse-submodules doing
>> > what we want. However, we had to clone on a system where SSH was
>> > locked down and we could only use HTTPS. The form of the URIs changed
>> rather radically:
>> >
>> > https://user@bitbucket.org/project/repo.git
>> >
>> > I'm looking for better practices than I used - I'm sure there is at least one.
>>
>> AFAIK the existing `url.<base>.insteadOf` config option[1] deals with this...
>>
>> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-
>> urlltbasegtinsteadOf
>>
>>     $ git config --global url."https://user@bitbucket.org/".insteadOf
>> "git@bitbucket.org:"
>>
>> If you don't want to set it globally (not a throwaway CI environment?) then
>> you can do it as a one-off:
>>
>>     $ git -c url."https://user@bitbucket.org/".insteadOf="git@bitbucket.org:"
>> clone --recurse-submodules git@bitbucket.org:repo/project.git
>>
>> But it isn't persisted into your repo config then, so subsequent fetches won't
>> work. You'd need to persist it using something like:
>>
>>     $ git config url."https://user@bitbucket.org/".insteadOf
>> "git@bitbucket.org:"
>>     $ git submodule foreach --recursive 'git config
>> url."https://user@bitbucket.org/".insteadOf "git@bitbucket.org:" '
>>
>> Maybe there's an opportunity to make that part easier?
>
>Well, I gave this a shot. The mapping did not appear to work - I tried a few combinations. I was left with the original URIs. Note that I also had to do
>
>$ git submodule init
>
>which reported the wrong URIs
>
>$ git submodule update
>
>which obviously failed since they were still using SSH.
>
>I think there may be something not working correctly with the insteadOf operator. This is easily reproduceable.
>

I ran into this as well some time ago. For submodules this only works if you 
put it into your global config since the parent projects config is not 
relevant to the submodule.

There's some discussion in the archive about this as well:
https://lore.kernel.org/git/404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org/
