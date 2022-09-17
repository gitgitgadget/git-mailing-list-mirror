Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399ECECAAD8
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 00:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIQApV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 20:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQApT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 20:45:19 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2139.outbound.protection.outlook.com [40.107.10.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B563E756
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 17:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8LVBXwzllDJjNWSQK9aoIAITNLI57mSZhyvMzvQKC0PnivN9rXTzAPDqoA4qObUAAmThVuc5S9IeLGfuYgt0dWERvDR6TrNim79TvjkWRDi2PME69mBcPP6/lsy7mt+f/93a1wMVHn+vYOVu7OUiokV/vOpH8uGNvdTCuT1UAvHOe2P6shUA1f2sxRzeruXBOuMPfTkTpb59KIYMqcOOIXU5doc6LnHxJtNSIgxkCUbai4G71uzWOvGJPQnH2RzAOk3SrvanL6MDqronBrqRkWa+WpfZz5Zy66RicXtmJuXPAvLJ3AUeZYg3JFj267ZMkemTknRo8k1mW6CcAHJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQEBLG4unmGLgORJKh5LCMzaQSaoynPkJBfAJbxx5+U=;
 b=jHusCL5XQJUY0gz9jYC7K1eh9QFDzMOXDl8kASCtec2uZrvfy0UmN1Ik9XRfam4ZFa8U7XyAoKMWGm/o2xBW7SDRad0al4pGn0/HEvfLNwBOJZmg0ENEGPZmk5Phz3mfETUwBfHnG5tcVIM0Ho3oBqryGUEJBXes3wAWZR0cdBHxJh/Luyqz+gkcqgi8uWPKMsaHrm2FXDQ890xwMF2UlWTSqCfm1GnB5GTcbFmNGIIvGCz9X1vTR7OAYt18Us3ba4BoUAcsPiyfGEuytCNlwhoNs9KUqDoDTR6SlBNVXz1NrH6j2yIRrAxMrt1ltNRsiEAG6USUEsXUkI3SUlXEIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adalogics.com; dmarc=pass action=none
 header.from=adalogics.com; dkim=pass header.d=adalogics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADALogics2.onmicrosoft.com; s=selector2-ADALogics2-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQEBLG4unmGLgORJKh5LCMzaQSaoynPkJBfAJbxx5+U=;
 b=b3BOGP/Bj4yRYMEBYNzZQ2/i69k0lAw1ZN/HjGYHW+i8jdjE5fLFQb0aWzlkJdkcy9oUCOsGSLFEg/QKGuzQYxO4Va+wfqofhujmXXl0JpcToOSEjB1v7qLRwIVdolVXU4YWPDeyh7Vfir61uDWVpFuDyHIf0bzOoxaRSEt3MGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adalogics.com;
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::6)
 by CWLP123MB2705.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Sat, 17 Sep
 2022 00:45:14 +0000
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688]) by LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688%4]) with mapi id 15.20.5612.022; Sat, 17 Sep 2022
 00:45:13 +0000
Message-ID: <2405897f-a774-e0d3-99bb-2185dcbb5432@adalogics.com>
Date:   Sat, 17 Sep 2022 01:45:12 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] fuzz: reorganise the path for existing oss-fuzz fuzzers
To:     Junio C Hamano <gitster@pobox.com>,
        Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        David Korczynski <david@adalogics.com>
References: <pull.1353.git.1663355009333.gitgitgadget@gmail.com>
 <xmqqo7vff0gi.fsf@gitster.g>
From:   Arthur Chan <arthur.chan@adalogics.com>
In-Reply-To: <xmqqo7vff0gi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0392.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::19) To LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6615:EE_|CWLP123MB2705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e2340c5-6d0d-44cc-9a4e-08da9845e1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GbuVDQOorqypnt99nhFth5GCCAaxqWY+axsM0FA6hFOuV5/FDh9i3J3AOeZdCT/x6Y9Y9GGweHjm9MppvtimlPrdhtrDgYKLkRc//vi4+sq9RGiMGB4nqTFtWwvjCs77Bs4UyAlPZ9RQjcGtsi6uulDDjDoFOyneEOBJpuPtQ4yHDWGlm6V49sQqG6nfkjMd1MR6T5DogzVZiOLZ++pGWRo5QKOB+omccgy7Ga2hwmtUnXNA+JtXFKdEiK+0S6ONOJcB+wpo1MbXcme3ILAK38BMU4s0soBy2ktJixEQY2iyYI6pMIqw25JesAYdAnmsPF0cBDc6z7/shLaaQmPwgP/G8Qozs6HKCKNyCNVkVwjNWC8htDw/FRyETKVE1O8Ye1grHcz3IWkeuTGmpCRhZ5MFosKzIv9ho/bAdlL16SXLzOxzxBQwy9Wud0OvJyKFuA2xGM7lJXeU/8DHwQbyu6MCIqsBjjP3y9BHqki6kutOtW5dY07APuZF6rauOsbxaZ05I/SRxwE1hw/HeVBsAQ5bAD3qQitV+o7AQP+CFVIZjDDXs2C6TT+WCMakqAURbM4QID2Oi1ytPD22pik55l+2ETHa+sfJk4RIhg4vfX8IPSLXJLxhInCmdgURKP191bOfiI7gfgNzXBlZteTdk2Uvk2XqQywF7FwRReXSQqFQZGBVwQZSmqRHE/sO9UZqGNJUvllYHWHCTyVqgPN4CuclvBFIV1vOW+4Fuz/YVDrNfAM7ZqJCu6IVNe51xslI/AURC06G92MAqiW1D4CHhLFUdZkjo028p+nHdMA9c0Xx7bkimyclp06q5XedwOCGwixH0BACmBXYMldvTmDbwl94s6EOeS4DULiUonMBR3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39830400003)(346002)(396003)(376002)(451199015)(36756003)(316002)(110136005)(66946007)(66556008)(66476007)(54906003)(86362001)(31686004)(31696002)(2616005)(38350700002)(83380400001)(38100700002)(186003)(6486002)(478600001)(8676002)(107886003)(4326008)(52116002)(26005)(53546011)(6506007)(6512007)(966005)(41300700001)(8936002)(5660300002)(44832011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpha1NUdkZmSStrcG9lRHRTQUkyM1FoR2FBbnp3TlkyRS82L1Z6V0Q2YUpK?=
 =?utf-8?B?STA2TDFQOWlJUitXR2NCRjdmS3d4RU5DWDBsZGY0L2dDeFZLdWwybmNFdEFL?=
 =?utf-8?B?TXU1WGxmRzF3WnJqamtVWldRWVFJZmRBUDh1VkxkM25yT3lENnpKQzQwQmJY?=
 =?utf-8?B?TzlmcWJnT20zMGI5S1ZwR25pdnZabGhqS3hldGJCUDBTYlFpa0dBY2RhOU8y?=
 =?utf-8?B?Ykc0bjhPNmRxaDQ5dUk2Wk5iaVdmeDVkYmFJSFByNzNYNDJYQnlrNVdLdDVy?=
 =?utf-8?B?cEY3TklFeFFWQXB3UHBwRXpxREVYQ3VGQW5SMUlhWEQyZnZWQ2xFSzB6M01z?=
 =?utf-8?B?Y1BrUjlKeENEWlh1bFI5TjNmdTkrWlZDbEE0eCtXbUJnQkRmWDhTSkUyVGJI?=
 =?utf-8?B?dWsxanFBRGxrbXlvT3Z0SjV3ei9YcU9vN2xPUmh1eWdKd2pqSjVUU2FWc3gx?=
 =?utf-8?B?MmN4RUNVbFpIRDdQMnlTWDJCUG9tRHhSbTR1bzFFL3QwSkkyeWJjUnkvYzRT?=
 =?utf-8?B?SWZQTTJ2MEN6U3FJZVRpWmVMUXZ6UzBkMSsxOGxWcjlPWk10NC9yV0FlK2p1?=
 =?utf-8?B?OVV5S0IzdlV4bFRsaUIxdkZhZDdwazRMQ2hKRmN2US9qS25kdGloQWtqenlR?=
 =?utf-8?B?UkRwSllsOEdNNDRvOGZ4UG9uRllBTWhRNXFKTis2b2pxVVlGZEp5UmcrWkxm?=
 =?utf-8?B?S0FGV0htc0tmZ09EN2swTSs4K29CdnNVSGYyRFE5OTc0SlBnaGVPeGFISUNt?=
 =?utf-8?B?TUVid0poUkRodGcvNW5QUkNJbFlES1J5VU9adkZyMUJPaC9kRmdIVW1QVGd6?=
 =?utf-8?B?VFVRUGlaYWZ0VVVXT0JjUStEV2s1K0c4cFlDVVA4Skkydnovbkg5cFliYXp1?=
 =?utf-8?B?RTY0NzBBSU5xTDVkWVZyQjBJbzlYWkNrSmxHelhFRjVBNTY0eUNCenhjZlEr?=
 =?utf-8?B?MU4zQlQvM3oySnhuSHc0ckMwaEl3emVvSHBHbDlERUoyTTBYZndKUG1aNUg4?=
 =?utf-8?B?NHBtTWRLR09sVVhEZm8ycnBBTUpWV0dBOEc4N2VkRnRDU2hXdXBWYmtmV1hp?=
 =?utf-8?B?My94aytNZVdGYS9ZYlZzQk5mdWxMMFNhVzlJMmd6T0NxYVpDMXpRV3c2UUxs?=
 =?utf-8?B?Y3lEdnFaNmowRmZVc1pGc01SQXdERkJvN053VmZqMEg3RGd4em1GRnhadk5a?=
 =?utf-8?B?Z1BETG55Z3JlRVFjbWVrODMybnU1TVAyVWJTWEZVUWlnUWpUdzR1ckliUWlD?=
 =?utf-8?B?MTZIZjVnOTgvUVpnRytpVXd2Q3VqNUVWSUx4bnJ6WlZwMllqNTdCNUFJbTlo?=
 =?utf-8?B?UFlXV2p5eEl2L2hUSDBUUFk5UElUWkJCWlI2em5rM3poV3ZsaFB4czhaWFJT?=
 =?utf-8?B?S1J4cXNEQmQyaE5SVi9OWFlPZHdQVWZJVnBkTFNscnVUcnF5TG8wamlRU0lZ?=
 =?utf-8?B?eDJLdjVMZGNpRVYzdEhkbE5meGpaWGc2WlhIR0F3VjZSeWFjWUxLZTJWOHhP?=
 =?utf-8?B?bFAweDF6ajhmTUtMU1pWdEpWMkp4SUk5OUw5MjRyZENIN2R0TGJFSTh1L3lT?=
 =?utf-8?B?cnFnZldHSms0RmVFUUlDRUxaVk4rM1VleS9KRmhocTNxZHJWRm1vN3p4K1pk?=
 =?utf-8?B?ck45VGN6OWVadVhWMm15YUVmVURTTGJxV0RSR0NUajY4SmpsY3h2RitNNWsr?=
 =?utf-8?B?QXZRNVRtV2QyV2FmQlpXb0hEYUo4aW5rMDYzeFFHQUlnT0w2TlRnL1NjeFJu?=
 =?utf-8?B?c2ZBakpvTkJKUDdiNEtMZFpLK3R1Z1I2TTk3VW1WdjZ3VzZZdWlVU1pPMitZ?=
 =?utf-8?B?ZmsxczY3TEgxREdtcHJkaEthblUydjIzSUlteHdKdzNLU0Fra0dROEhHaUNy?=
 =?utf-8?B?WHBFaU8zWFRkY2s3cEhiMHA4cDZpT3I2YlAyTllLYUJiZW5LNVZ1Ujh4c01a?=
 =?utf-8?B?aTBkUW40cHhVbVVjTGlFZEY3WVZMVURWcmJoYzg0ZEpyeVpLSXZVcFQ0S1dC?=
 =?utf-8?B?blhIb256eVVaTjVMRWN2K3VHMWhSYzIvVTZXeHExdjJtZ25tczNBYkVxdVJs?=
 =?utf-8?B?d0hxNjhBS29yVWp1SGJJdHpLcWJMb25ISzhqWHRXbFN0cmV1NzJldVh4cnU1?=
 =?utf-8?B?STZFNTczTEpoQUJoNE1NZHlIQjBmaUdJaElmWUVrQ0R0bzZWMFQ4c0dNSG14?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: Adalogics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2340c5-6d0d-44cc-9a4e-08da9845e1eb
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2022 00:45:13.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4a262c48-49eb-487e-893b-c5902e6682ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebSLKzjR7OMZYapw3hyKVEpebt7XmdhWozHhtM+bq9qP9d9pII07Ysc6+EgilLfzSixOS2Kk6zM4OuTxH/OL5Y/+73LztOIxattBl9Ds4dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2705
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 16/9/2022 10:55 pm, Junio C Hamano wrote:
> "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Arthur Chan <arthur.chan@adalogics.com>
>>
>> This patch is aimed to provide a better organisation for oss-fuzz
>> fuzzers, allowing more fuzzers for the git project to be added
>> in a later development.
>>
>> A new folder oss-fuzz has been created and existing fuzzers are
>> moved into the new folders. Makefile has been fixed accordingly.
> "folder" -> "directory" everywhere.
Thanks for the suggestion. I will change it in v2.
>>   Makefile                                            | 6 +++---
>>   fuzz-commit-graph.c =3D> oss-fuzz/fuzz-commit-graph.c | 0
>>   fuzz-pack-headers.c =3D> oss-fuzz/fuzz-pack-headers.c | 0
>>   fuzz-pack-idx.c =3D> oss-fuzz/fuzz-pack-idx.c         | 0
>>   4 files changed, 3 insertions(+), 3 deletions(-)
>>   rename fuzz-commit-graph.c =3D> oss-fuzz/fuzz-commit-graph.c (100%)
>>   rename fuzz-pack-headers.c =3D> oss-fuzz/fuzz-pack-headers.c (100%)
>>   rename fuzz-pack-idx.c =3D> oss-fuzz/fuzz-pack-idx.c (100%)
> It is curious that we do not have any changes to .gitignore
> patterns.
>
>      $ git grep fuzz .gitignore Makefile
>      .gitignore:/fuzz-commit-graph
>      .gitignore:/fuzz_corpora
>      .gitignore:/fuzz-pack-headers
>      .gitignore:/fuzz-pack-idx
>      Makefile:FUZZ_OBJS +=3D fuzz-commit-graph.o
>      Makefile:FUZZ_OBJS +=3D fuzz-pack-headers.o
>      Makefile:FUZZ_OBJS +=3D fuzz-pack-idx.o
>      Makefile:.PHONY: fuzz-objs
>      Makefile:fuzz-objs: $(FUZZ_OBJS)
>      Makefile:# Always build fuzz objects even if not testing, to prevent=
 bit-rot.
>      Makefile:# Building fuzz targets generally requires a special set of=
 compiler flags that
>      Makefile:#      CFLAGS=3D"-fsanitize=3Dfuzzer-no-link,address" \
>      Makefile:#      LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer" \
>      Makefile:#      fuzz-all
>      Makefile:.PHONY: fuzz-all
>      Makefile:fuzz-all: $(FUZZ_PROGRAMS)
>
> I do not know what "fuzz_corpora" is, which step in build creates
> it, and why we do not have to bother removing it in "make clean",
> the last of which is not the fault of this patch, but I suspect that
> at least other three existing entries that name $(FUZZ_PROGRAMS)
> need to be updated, because ...

I also have no idea what fuzz_corpora is, I will ask the person who
wrote the three fuzzers to see if he got any idea.

And yes, indeed, I miss the change in .gitignore, I will modify it and
push it to v2.

>> diff --git a/Makefile b/Makefile
>> index d9247ead45b..2d56aae7a1d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -686,9 +686,9 @@ SCRIPTS =3D $(SCRIPT_SH_GEN) \
>>
>>   ETAGS_TARGET =3D TAGS
>>
>> -FUZZ_OBJS +=3D fuzz-commit-graph.o
>> -FUZZ_OBJS +=3D fuzz-pack-headers.o
>> -FUZZ_OBJS +=3D fuzz-pack-idx.o
>> +FUZZ_OBJS +=3D oss-fuzz/fuzz-commit-graph.o
>> +FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-headers.o
>> +FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-idx.o
> ... FUZZ_OBJS now live in the oss-fuzz/ directory, and Makefile has
>
>      FUZZ_PROGRAMS +=3D $(patsubst %.o,%,$(FUZZ_OBJS))
>
>      $(FUZZ_PROGRAMS): all
>          $(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS)=
 \
>                  $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE=
) -o $@
>
> neither of which has been touched by the patch, so presumably the
> executables are now created in the oss-fuzz/ directory as well, and
> they are what .gitignore should be listing, right?
Yes, indeed. sorry for missing out the changes in .gitignore. I will
modify it and push it to v2
>
> Also, compiling the exectuable files would not be the end of the
> story, right?  Do folks (like test script, makefile targets and CI
> recipes) who used to run ./fuzz-commit-graph need to be told that
> they now need to run oss-fuzz/fuzz-commit-graph instead?  They may
> not be inside my tree, but what's the best way to inform them?  Add
> entries to release notes (not asking you to add one immediately ---
> asking you to help formulating the plans).

In general, for the oss-fuzz project, there will be a dockerfile and
build script prepared for each of the target project. The Dockerfile
will pull out the target version of the the target project, setting them
up for the build script. Then the build script will compile the target
project together with the fuzzers. After that it will move the compiled
fuzzer into correct location for the oss-fuzz library to grab them and
start the fuzzing process. The fuzzing and execution of those fuzzers
are all on the oss-fuzz side. We are just trying to push fuzzers to the
git upstream in order to allow it to compile and sync with the git
repository which the fuzzers depending on. This is the existing
execution plan for those fuzzers as far as I know. We are actually in
offline discussion with the person who create that three fuzzers and we
agree to go on this route. For your reference, you could find the
dockerfile and build script of the oss-fuzz for the git repository in
https://github.com/google/oss-fuzz/tree/master/projects/git. We will of
course need to update the build script on the oss-fuzz tree in order to
allow oss-fuzz to retrieve the fuzzers after it has been reloacted. But
this won't affect the git tree.

Thanks again for pointing out my careless mistake on .gitignore. I will
fix that together with the comment and push a v2. Thanks very much for
your time. Cheers

> Thanks.
> ADA Logics Ltd is registered in England. No: 11624074.
> Registered office: 266 Banbury Road, Post Box 292,
> OX2 7DL, Oxford, Oxfordshire , United Kingdom
ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom
