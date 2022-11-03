Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2523CC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 13:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCNqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKCNqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 09:46:32 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2120.outbound.protection.outlook.com [40.107.116.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA59F19
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 06:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4j1ZzWREtF4K5PMhDsWPOS66S58GJYLeVPQfMzYEYJ++JpC4qyy6uNx79Xun0bIs+NUOKYx+UF8CjUmTPPhJIt2NZlSHJhqe/wUfcRW+Kxo/kxppU6Ch4xJRB5TpoL/KGnZY/WjX6tZCBbTwJtN7YdvK3HE4MBa42s3JPZq9LjbiGzRJyDwsuj/tufMgrTFlGmaaXZ1gI5jIyukdj7BUnf28mA31k+qIJL8orANdUMizyCdn4GD0z3d9TZrpVmsmxHELnp90r6vnMLrk7ASipkY/6I5kU9XW6x4Uuy3a69zMH/9Xie+CNIlF+zGkFxFpOdYJ8iLmXNe2CeR9qN5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ieIem6KLzz0+N6AZ4VOKTPHEeD0iWRyreHard3zfzc=;
 b=VcRwiFR5tjUVFvtLQ4DrpGR3ucn+58CB4V9yUHApD3JQfRrgEtRDvTu8hJ69R72fFVa8N7vIunDhimTX20cyrRAvGPnFfn13e8IYXChADJNTHAixfAo8ycr8o8PsJgoNXUFwt4tPEJATYLEdVWOqpulhf/+PiLfUt+fzIUbG5h5L3sf+M/OtATw2RwCavdm/jLV3iectfKAXLtwAUFPrK624XfHFQoQDZFXj+GNATh4qbQAQAzwrvKaDX65Z5kRy5zGgUf2DnLsZN3uO6/vm24opjj4V+fD28+8G9AVHjHNYWX5zD68kmS9XblviBiPOR1Svb/FUUGGYvdmI77oJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ieIem6KLzz0+N6AZ4VOKTPHEeD0iWRyreHard3zfzc=;
 b=AO/Bm+Z3fAMRJGSBkEcRWgKPURG4gHvPtyCnoNEYACAY7+hNalEObbMNYiugTpMfR56i0WcRULBk6JhLlOwBeMxW3qWJSZ/2HeUjT/QiyJn05OuBLp3QDJGbuFIbVaAWGra0TzQcnlR0nEGwhFMpgUR/Q+VRmFG9WcVF2FH3okZSimKgPhocVK/hzYTYxj6lMhN1/Gaqcq9E4qAq2sU6S0XnWDuNHeWMV50MFh7mqMaAS4VpKMvO6ixGmEzdM8QvSpQkzkoKw+SS1g4NKjG4wBnCssuFd2ytqj7gR60mH24HckUQK/QQF1lzb+LMMznjGrqMG8AVUl4TYumG6BOcSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:30::29)
 by YT1PR01MB8682.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 13:46:30 +0000
Received: from QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1400:5589:c949:bb7b]) by QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::1400:5589:c949:bb7b%4]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 13:46:29 +0000
Message-ID: <bb6c6509-171e-ebdc-e251-aeba380bdda6@xiplink.com>
Date:   Thu, 3 Nov 2022 09:46:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: Consist timestamps within a checkout/clone
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Mark Hills <mark@xwax.org>, git@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
References: <2210311614160.25661@stax.localdomain>
 <c060312e-0d35-8439-85dd-920b172c90be@xiplink.com>
 <221102.86leot2ytm.gmgdl@evledraar.gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <221102.86leot2ytm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:30::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: QB1PR01MB2451:EE_|YT1PR01MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 38248a43-1fc2-4039-1e7e-08dabda1cf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9/+J6poneXo4+LxtcBlHjSM7964kXBUELQaLKkldiVs73e4ESQuvERBM1OZ/Qyuj/MAVykwrOfcFPGHbhibLz/Za9qs0bFUqh77m+G0ymZBfFRRPRmnKrVEOKZVxZ7e4si5H6wI3lECn4TelZUseOBYQg9LV3KC90XbMD9tZuG8V4O/A6xEZMFhTjpZHTx8p5iJoQ7IOSwZV0cUogONlhP9kASRGpHpvE5A9lgIn3mZHiu+ob6hYIy8eOpJMnWLUE6yE9uBoupKe0QdRofTxYtK0iiCUozcMp72bmqFlcRAKCerQ0DA8FbVxQ9PymlXs7aaapTCle4Jg/kFWtO5e+JLQsQiFyFUMSzv7l7siI/ZtAGDKiHPYDhiuPI7Xnk0gOwDh6OUiSUMQGSg/S/PNgcO5ME5Gj3tawHDencedQw+gJ0xXwGXB/W1S0Z8TLbORZhMP6lq5OLc7g9cgaKNImIEtxA+mt16+le914VzmFJ9v78vgr46IoIxR3A9vTr0qbmyrIQ6K438CNxy4lw7uqrtLaJxcCsJQ7LY+6Q1kTK4kXNEXlLADYDbGy7vN4pnf3kONSZgdYZQATMeCqhQ21SH6HARBFlr5lULMD1W9rv4Ucw5djBN2ZE4g9cR2h5/hUpN9OqvzELE8ybneTjRSSh2Y56dyh4KHIXi2Y78CWmrS54MkNXfVszkJf9bWZTIEGtZCrXeSWMKRTncYc7BWbhIFkPN4I81oKmW/AhBJbVvX02+heFOqfKBCKy3BfvxcqpDmjR5SqrvtwdpSrHinnDOmHmnVfbcdhSFEKQn/LU8KZRKoCpU/TdCrEGWMtUU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(39840400004)(366004)(376002)(136003)(346002)(451199015)(2906002)(36756003)(66899015)(316002)(31696002)(6916009)(66946007)(83380400001)(966005)(41300700001)(8676002)(4326008)(54906003)(8936002)(6486002)(66476007)(5660300002)(66556008)(478600001)(26005)(6512007)(53546011)(186003)(2616005)(31686004)(38100700002)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxkMllUSmJ3YWlDT2NuSVNtVEJueUNFdHVDSUc1eDRNTXdBSk05bXZPU1o4?=
 =?utf-8?B?ZnFMSkhzemJQYmtqaEVKLy9taDhBeDExVWtFNUk3ZG5abVozcDY0MG9hU0p4?=
 =?utf-8?B?THBENWFyMEdVanZVQjhLRkNZQjNPZlJqWmhRYTNLZmVmdWFCQmpiUDVxVG5p?=
 =?utf-8?B?K1ZacEJINE5UNUVJdVJ0U3BoVzYwNjRSZFRyR0ZJdFJlaGVPZTI2NTQwVEhm?=
 =?utf-8?B?ZE1GUWxpc0FhaktUUjdTdXhMdTZNK1JvN3l0YWlhY0NOWndCbi9BRTI1clph?=
 =?utf-8?B?VTR3UHlXWmhhTDdZSXpFeVZkY2FON2N6T3dZUDBjRUhvZ2l0aFNRUTNGUEtT?=
 =?utf-8?B?WHpvbkJqNWZ3VThleGROTC9aWXlPOVlHdTNwa2QzVUxZQi9mTmIwS3JndVhD?=
 =?utf-8?B?TWRjdy95NHVrRVI2ZUZ3THZOMnVEVVFKRUdmRnVFTDBMTDhhbWV4Y1Q1ZW1w?=
 =?utf-8?B?UlNCZXdsMFBqZ1BDYXRuYzArWWw4OGRIdUQrdGlkWDFCb1U2ZFhVTHJPYnZa?=
 =?utf-8?B?cTRDZWpMY1FLZE45YjBQQWI4RVNQYys3NnJhRkpIRU53S3VQN1ZMRUl5cE5q?=
 =?utf-8?B?Mnl1NW5KYk4vcC9Ocml0MmVIRWRnclV5aUpJTlZBRDFOeWF4R3RwcGZRZUd5?=
 =?utf-8?B?LytPVTVYR1B1em5ZM3NXWVU5M2RnVU9RNVNmYTh0NHZWSGVMWGZKeWJ0Z2lp?=
 =?utf-8?B?blFXVG4weEZQVkNjVHplbFFxOWZlUzV3OFIvNnBKaW0yOGhRTGFobitZN0NJ?=
 =?utf-8?B?VEF0KzFPdWlRTEVpMjRsQmtnc0lLbTljKzlxR1FUcG9ndWhkaTlsb1pYT2Zj?=
 =?utf-8?B?Z1FXeU04MUdWZkpUWnFhNVhlRFBKVnJmS3ozUUxYMW12RHp3M0QxSGM4L2Ni?=
 =?utf-8?B?dXlZdjZ5Qkc5TGVQR0RUZVZnSDRpWjJVVUt0RUx2aFJjWUFYQnZ3OHJuTXkw?=
 =?utf-8?B?MzJQWHArN283R0kxTUJ1ZElqWENtWXU0TUtHWDFqbmZGYmdYQ09YUDRMbzZy?=
 =?utf-8?B?VXZHWnJUUDA0L0pNd1ZPbGFDY3pEUTdLVjdIK21TM0c2ODd0Y1ZTRTh0NzJ5?=
 =?utf-8?B?U2JyYkdib014VzVHQVp4WE9DYjVZSDltUWk2WkJXajR6S1d1YVZtS29CUlAv?=
 =?utf-8?B?RGoxa2ViUnR5UWYvWjhIb0hVR2h1aHJkb2Z4UXE1aWg3L3J0d2pLdnQ1dk84?=
 =?utf-8?B?OWtKNk5INk1Kdy80Q1IxZFFCbEp6S3QwaEo3RjRRT1hvQjNjNEg1MDdYbzlr?=
 =?utf-8?B?UVg2ZmErVlZ3Y3VwTjlvelQ4TjYxNmNsYm1WaWFJWEorY1dzUEtLRHFOZ29r?=
 =?utf-8?B?ZVlRcC80NVVMb1VCOGZJckRYZFdZeFdXRlVvQUVQcGQ4Q1d2bzMvd08rSmsw?=
 =?utf-8?B?SGllRUxGVVNNZGFzcERWclVVTlJZdXFJZTh3Q0xtVTVackVtZzRSYkREOWNS?=
 =?utf-8?B?ZFpINW5TaS8vd2ZOUnFtRkhKWnZFclBTMVpTT3dlazgwZnBEd2ZqNmRiSnhD?=
 =?utf-8?B?TlAyWHVDVUh6T0FFYmpjOXNKVWdKUHdnS2toQkdyZmpnMTZiL3dYUTJESkFs?=
 =?utf-8?B?bEtHbTJSVERNd2tHTHZuTU1UOFM5Rkp5dXJIMGs3Ky81b2VlZEVlb285MFlU?=
 =?utf-8?B?NitoOG1Ibi9ORHd6VTRuOGVPTUh5eitYZmtOUnJ1VGNpbEFjMGdLcll1WkZX?=
 =?utf-8?B?OWthN1Z2MUt0Vm5vVjJrVlRycU11Z3ZKN2JrOEQ0S1U3eml3YXZWdi8zQkdw?=
 =?utf-8?B?TGRPcFh1b3l6VXY1Q2lGNXhDVjlucnh6Z29Bc0NzdHRzeG04K1h1dkh5aTBS?=
 =?utf-8?B?QnA2Vm9zYStxZ3pwd2xMWW5TOGNDUjVUTCtBajBGNXc3ZWRkb3V6UmRCVkwr?=
 =?utf-8?B?dTUzR1BsLytTK1ZvUGYrSHlnREhrYmxTa1VFUm4zV2xtMVFtcGcycDc1TTZW?=
 =?utf-8?B?bE56dVlrYmJlelhZUkdydkdUb0ZzN01EQWtWNjFnZzc2SUl2WWQvcGlKMTFw?=
 =?utf-8?B?Z0RhQlFLMFYxTkFTSHZ6SG13T3FqM1dtV3lKby9HUm5nWlhmNUM4UzY0dFUw?=
 =?utf-8?B?ZUZDOVk0TXZlT0xIeGtEOGlvdFB1cHBpNWdYdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38248a43-1fc2-4039-1e7e-08dabda1cf6c
X-MS-Exchange-CrossTenant-AuthSource: QB1PR01MB2451.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 13:46:29.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BIaCrLqvvq1ak2UYb+8o4U9jUS0T2xD3G/JDjn0iSbGqsi+ugGrft0ItuCS8jiT1BeZ0hhQ5E9Qr/aNc+TNLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8682
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2022-11-02 10:45, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 01 2022, Marc Branchaud wrote:
>>
>> Instead the decision was to do nothing in Git, and instead let people
>> create their own post-checkout hooks to touch the files.  I (and others)
>> argued this was inadequate, to no avail.
>> >> [1] 
https://public-inbox.org/git/20180413170129.15310-1-mgorny@gentoo.org/#r
> 
> I think that's the wrong take-away from that thread. Maybe a patch for
> this will get rejected in the end, but in that case it wasn't because
> the git project is never going to take a patch like this.
> 
> Maybe it won't, but:
> 
>   * That commit has no tests
>   * It's clearly controversial behavior, so *if* we add it I think it's
>     better to make it opt-in configurable.
>   * Once that's done, you'd need doc changes etc. for that.
> 
> Now, maybe a sufficiently polished version would also be "meh" for
> whatever reason, I just think it's premature to say that a change in
> this direction would never be accepted.

I did not say that it would never be accepted; perhaps I should have 
said "outcome" instead of "decision".  That 2018 thread barely discussed 
changes to the patch itself.  The patch's writer (not me) didn't pursue 
the work, after its frosty initial reception.

Past discussions around these proposals have been negative, which 
discourages people from polishing a submission as you suggest.  I hope 
that this time is different.  (Before you suggest I submit a patch, I 
sadly don't have the time to hack on Git these days.)

> That being said, I do wonder if software in the wild is being
> monkeypatched to work around issues with make (or make-like tools)
> whether such a change isn't better advocated in e.g. GNU make itself.
> 
> If it added "B" to "MAKEFLAGS" if it detected:
> 
>   * I'm in a git repository
>   * It's the first time I'm running here, or "nothing is built yet"
>   * My dependency graph would be different with "-B"
> 
> Wouldn't that be what people who want this feature are after?
> 
> It's not like it's SCM-agnostic, it already goes to significant trouble
> to cater to RCS and SCCS of all things, so I don't see why they'd
> categorically reject a patch to cater to modern VCS's.
> 
> And, unlike Gike, GNU make wouldn't need to guess that munging
> timestamps would fix it, it can compute both versions of the dependency
> graph, so it would know...

Fair points about advocating for changes in make.  However, Gnu make 
isn't the only flavour out there.  Our builds use both BSD's and Gnu's 
makes, for example.  (Also, BSD make has a completely different 
interpretation of -B, and does not have any flag that mirrors Gnu make's 
-B.)

Git is really the ideal place to solve this problem, instead of playing 
whack-a-mole with build tools and upstream projects.  Making the 
behaviour opt-in is perfectly reasonable.

		M.
