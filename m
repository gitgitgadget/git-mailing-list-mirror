Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDDECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 16:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIPQGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIPQGU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 12:06:20 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2108.outbound.protection.outlook.com [40.107.10.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24469B5E63
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 09:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe5DO65aYMQFBqj6i6ShObCvDQytLBcgZOX7Gj9gP2igo4mkeQCBfdW7TfYUlvtMkwMpD+I4KUBiaB2HNm5zX/lIAfQF1kJgZKikSFZZS5sSlKawrR5JCeLwieNiFduIQAebId0pTbK/OcT82YAp8X4MztbHDTMFXMkA4X2iq8ZPBSW6HW0xtrTBuM7tAuZcTJz7AyjTp8U5KFJw7KRKuS0SqvtpKRm0b9QaWr6Y1LHMSFfKGdmpYb7fg5j725jCSu6oI9+0CsAoj/+QNMhkVn9sVtqgApLsFQKPLg5f4vDHH38AMrKxoa59iTRmuEHzFLmJHyLZx0Hcw/qvOm0nBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WP6k7qMc0bcKfMSeiFnMpamS/AQC3an3giyhoe/2vI=;
 b=m61MLOaZKhGxKmadGYqr6oillyX/VuvtxrkKxDtapC1J75MDmvwxQKGCXt3dLkY5CY3k7uZGii/0Kxw67Lm0ZxiL0FdEcnMdETod+9SBMkiUIPADXMGSHirt1UZ/KYaNv8yx9UTmicsi/CF0npcrmctwRv7D3+MDkWdIjjwhwwetoF8N06T6UZg7kBOPRgBP9ev9Hcjq5zMzmPzDhfAynMcTMzOdempJjU1VlR3lVpKul5zTkemXvi6b216WGqUBmxbA2zmR8OuqyG6+mOg8scXiol7POy+CsC9VbvMqKf2cQfkT//SWmctMc8lYWcU+D55Ns6LttqtERroinPlzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adalogics.com; dmarc=pass action=none
 header.from=adalogics.com; dkim=pass header.d=adalogics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ADALogics2.onmicrosoft.com; s=selector2-ADALogics2-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WP6k7qMc0bcKfMSeiFnMpamS/AQC3an3giyhoe/2vI=;
 b=VPcA8UF0rHgLTR0b4zJoNAt1ldklrRTXIQGEnywTTvqnxapy/DT3o3OEQHR+H4YW17oX0KyHpL1fRp/o8Y1gZHE6dy5KFyLs1XZX52YDmPbEXkUm5RibvOLSCmmEvkO6X2bHb9EEAbj6rvHgGjMhceLosZEK731I/eBYj4M++44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adalogics.com;
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b3::6)
 by LO2P123MB6198.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 16:06:17 +0000
Received: from LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688]) by LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 ([fe80::64f3:4ca2:ba01:3688%4]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 16:06:11 +0000
Message-ID: <d1a53455-f9cc-3c7a-0867-8b141435d251@adalogics.com>
Date:   Fri, 16 Sep 2022 17:06:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] fuzz: add basic fuzz testing for git command
To:     Junio C Hamano <gitster@pobox.com>,
        Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>,
        david@adalogics.com
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
 <xmqqv8pr9rrn.fsf@gitster.g>
From:   Arthur Chan <arthur.chan@adalogics.com>
In-Reply-To: <xmqqv8pr9rrn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0421.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::12) To LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b3::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6615:EE_|LO2P123MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8c8220-86c6-46b3-9101-08da97fd5f6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aC9BfvcQ9SitltO5pafgrp8j2QUo9XmK7r7g0QSp3BnoDkqCAsuQcfzUSEp5JFci0tgRtVbz1y6jS7oyWjel7NXscIxm41nY2Io9Pz2MO/egyIfMkWnSjWg0Up8Us5JLmtB+qFUXYHxE1zZDjrh0zx3hksgUOyDAJVVUSLOeKuTqDqAy6Zw408LA7GKbpapRpu9i4mdG4Kzw3AjaRqA0Aorizg5A1GNUkqu5BMSeL9SCeVMNiqEi9Ajo6EF3Gk5dJs3puau/uSCBwEPyKC97NNTdx8/WsvM/gnHiypl1kJqd/84As0negYtH5nLSGyfIrKKtsl8DVsV5MOSF286gr5/vbOP3oparR0Cd5/lmidBnMai6HBJMdqsMKBX2D//zzvlJ3iNCCGsg6b0APDa0E+XF4W0rLndrSJMnXA/fbGSVYSAwMtXzcP5V8FeRXxJ40A4F7MuI5ZzdLDMvFoLyfpYQfwck9V4cYSTu28WjOXfv1+/i1nVumwVLMBvt++rShpAZeOATrGd/rAnTSa0yHbNIWz/H4maBtyVVS35PkeYpT75Yh3Oc9KRsMgdYKWBsKk1jgVF2TrgPnmdq7GXYKqrT3jx8iRYRYKSgoase8qhQNVnEsaHqC0oykT1Gk8uB5JKNBeCouRB767amLQvwnF7a3zm9QYt9+Ujcc0ClObs2udjJsRT3pNmhl+HIcK/e2lWyqagEhlWTL8kwDZGozcXTw3VjM183gL30kk2008KJiqw4XCx3m2t0fAjO9zKFUjFsXXyTMBJq7H2zjkK3u0yXL4zHoJswOiyqIojKkAhYK2Wlloe83/6YwKjt1jibqwQd/1sBEYxLLbgpb1IWqS2GqV//M1/Iz9hNf4u4QF0PJ/w+BHdyxVP4HD9R1OX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39830400003)(396003)(136003)(451199015)(36756003)(316002)(31686004)(31696002)(2906002)(44832011)(5660300002)(66946007)(38350700002)(38100700002)(8936002)(66556008)(66476007)(107886003)(41300700001)(478600001)(52116002)(86362001)(8676002)(26005)(110136005)(4326008)(53546011)(186003)(6512007)(6506007)(6486002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmg0RkN0WXJWVG1YZnVUaTR6eWtmbFQrUmJzUjdxYUphUXdEMUNyTEJLc2J6?=
 =?utf-8?B?R2FSRkZwMGpPRDRjN1lVVmdrM0p4MGdiRHFpZUlMSTVCeXBuclRGTzBRVU5U?=
 =?utf-8?B?aDkzSmJrZDRVVEdQcEI3MlhzRzloenRZalI0eHgvWDlDbTJWMC9QNWtrdlR0?=
 =?utf-8?B?YXRUV2QwR1U2VEpDNllISFFueHFPcEpDa3kycmx0d0Zvc1l3bGZJTVF5bnJF?=
 =?utf-8?B?QlhMR2g1TG1ndTlqSHNIL2VIcVovN1hNdktuZENRbzh3OWdmeHFLdXQrMXZp?=
 =?utf-8?B?TG5rc0d0aDFPVElKc1pYSDE0QXV6YjdwK05NVDh3Wkk3c1M2U2RMRkFWTHJ1?=
 =?utf-8?B?cXVjbjFTRldILzVZSkIxRmtBL01xeUp3REU0VVE1SmlTUXJvenNSZWR4TUNU?=
 =?utf-8?B?YzlNa3phZlNPalZ6UEFML1ZPZDd2ZWtPV2dNckRaQ2pFeUxvSDZmSnNNcnA2?=
 =?utf-8?B?MkF3Z0RnS3BuWVJJVmxCYlY1MkhhU3IraGVhdk40Qk5sbUVzWmE1WWpXTzBy?=
 =?utf-8?B?VWlVL2tUSkoxOHhEV21UTmxHZERNbWwvMzZIUm9lWlVJcDRDUkFSVkl2a0wy?=
 =?utf-8?B?YmtGWkQzQXpOYm90alQ0THVYVzRZRStFVmxXZ3duQ2F2TlF6VlZzN1U4eWNF?=
 =?utf-8?B?d2ZDNnFDVUFpUjlralVBTGZiZmpsL0RpakpjeXNJdkcyaWgwUnlDb3VacVFn?=
 =?utf-8?B?R1lXYkxjYVdFdm85VnhSeXVrSWlXWnlScWhpWHc0QkM0eEZkYlErdnp2U05L?=
 =?utf-8?B?TUVHOEZpQ3J0WUJ2UVBGQUY2aFM2QThUVkxCZ0k2eUdOQnF2dmE4MWpzUjBw?=
 =?utf-8?B?WGhoQWZHSjEzRk13Sm5NbVNaMkl1YURXYlM2OWN3dDRqS0Rpb3ZMTjFwVW0y?=
 =?utf-8?B?SmQxWjVyRHhNelJ0dDlIMjJJNGNCcTFXcTJGZStJSitFa05WVU1hMGJoSE1B?=
 =?utf-8?B?WGNvdEE0Tldjdk5tSmF0RHFSNG42dW56MFpsMXBlTzBHS1d6VTA1T29BMVU3?=
 =?utf-8?B?WGtVbXZ6N3AzVVdYTUV1SnZTNTY4a1Z3a2EvSlhuQTNFNVpjK0w3ck1NWHp2?=
 =?utf-8?B?Y2NRZ2pYQnB3V0ZjTWlZUjdDNlZwZ0c5Sy9XUDErVkhsTmlGSEQwdWluQXlU?=
 =?utf-8?B?TGpDS1hYZ3pDYnN2WWxjUFRteWROcE50NUlQK2pwRjVUeU1MR0xXNGEzWnFM?=
 =?utf-8?B?cTREUzdXTVhiY2NCdkE0T3VEcnJ5bTNTZ1cwb2M2cWV0bHRUUjdSTDJUUWxZ?=
 =?utf-8?B?T3VtMjlmVkpjejVTWUUzVG8zVDBXU3FWZ2RoVGszOVk0eVlSRFJ2bnVQQ0Vp?=
 =?utf-8?B?YU9kS1l5ajVkb2xkWjl6SFNlSTZTZk44M3lBVzR5RUNyUmkyY2RCbU9kYlN3?=
 =?utf-8?B?Y0IrYTJ3ZHhoZDRzR0NqelFNbEhnN1Izd1UzTmJ3MlJVWTErZUJrMjRKV3Vm?=
 =?utf-8?B?eGd5cllzYXVoam9wZFRLdEZYR2NVODBjRmlnUllac1FLRDNFZktFSmc4cnlp?=
 =?utf-8?B?SndpUjFyeGwrREdmRncwMHc3SHl0RHdpUnB2U1kvRlRlSHl4L0wxNlBrWHFj?=
 =?utf-8?B?OG9sQWRGMVV1b2JWc0lEaUlZSVIwSGw0UUswQ2lTcVdnVmlObm54dnVCM1M0?=
 =?utf-8?B?TU9MZ2VvVmZDL2xLalhSaVFjV0hwL0xBMkM4OGRBbUJRWUszY2xxQW5KOEcx?=
 =?utf-8?B?cG5ESjAxbDM2aWtOY2RxMktRV3BrRXlXUjFqOFdvMGdzeHJMMVpNa25CaGFW?=
 =?utf-8?B?UmxjR00veUoyblV4cnQ1TXY4TWtLS3FrZTRtTGhOVWJnOGhXcWdJS1I5aTBj?=
 =?utf-8?B?dGVWZVVjUnJYekRzTVhwZjJMbzllakpCUjdpWUt3SjFjMEZJYU8vOXpObW9D?=
 =?utf-8?B?aEYyZEtoZDdvUjRyR0hvdkNZRlFUM2JDSm9Xcm1ZMXdBWFVvZzRaWjFDa1Rt?=
 =?utf-8?B?UUtOZ0xLaFg3NnF4NlRoRlhGSE42Rk5VTmVMMzVDd0VHekZiMWVKakZpU0Ri?=
 =?utf-8?B?RCsvMzNlWnFkVTU2MC9DRVZWSk1UY2Y3QkZ5STU1ek5aSXRvMVdMaHExc0lB?=
 =?utf-8?B?Z2Rxc0xBWlJQbmxRdUNLc1pOanllbzZkNWtjeGhNS0lqMEVZOU1QSGlwb0dB?=
 =?utf-8?B?c2JoOFk1ajYzYmNoWUhMT2pIc05zYzZRMmpITy9wcjFUZnA0UUQ5ekx6WGlq?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: Adalogics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8c8220-86c6-46b3-9101-08da97fd5f6a
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6615.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 16:06:11.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4a262c48-49eb-487e-893b-c5902e6682ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwDGtAVobAXkJ6SDTfZH0nyLP9rACkxi3QHnLNrYF1KewFH29TRwEcXLvQ8rJ+3ENnh8Rd6T8o+9/yK3VzThVfaFcca8I1+zqCwi17dQeBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6198
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 13/9/2022 5:13 pm, Junio C Hamano wrote:
> "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>   .gitignore        |   2 +
>>   Makefile          |   2 +
>>   fuzz-cmd-base.c   | 117 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fuzz-cmd-base.h   |  13 ++++++
>>   fuzz-cmd-status.c |  68 +++++++++++++++++++++++++++
>>   5 files changed, 202 insertions(+)
>>   create mode 100644 fuzz-cmd-base.c
>>   create mode 100644 fuzz-cmd-base.h
>>   create mode 100644 fuzz-cmd-status.c
> Just like we have t/ hierarchy for testing, if we plan to add more
> fuzz-* related things on top of what we already have (like those
> that can be seen in the context of this patch), I would prefer to
> see a creation of fuzz/ hierarchy and move existing stuff there as
> the first step before adding more.
>
> And more fuzzing is good, if we can afford it ;-)
Fixed, I move the fuzzer into a new directory oss-fuzz
>
> Thanks.
>
> Even though I am not taking this patch as-is, let's give a cursory
> look to make sure the future iteration can be more reviewable by
> pointing out various CodingGuidelines issues.
>
Thanks for the styling suggestion, I have change most of them accordingly.
>> diff --git a/fuzz-cmd-base.c b/fuzz-cmd-base.c
>> new file mode 100644
>> index 00000000000..98f05c78372
>> --- /dev/null
>> +++ b/fuzz-cmd-base.c
>> @@ -0,0 +1,117 @@
>> +#include "cache.h"
> Good to have this as the first thing.
>
>> +#include "fuzz-cmd-base.h"
>> +
>> +
>> +/*
>> + * This function is used to randomize the content of a file with the
>> + * random data. The random data normally come from the fuzzing engine
>> + * LibFuzzer in order to create randomization of the git file worktree
>> + * and possibly messing up of certain git config file to fuzz different
>> + * git command execution logic.
>> + */
>> +void randomize_git_file(char *dir, char *name, char *data_chunk, int da=
ta_size) {
> Unlike other control structure with multiple statements in a block,
> the surrounding braces {} around function block sit on their own
> lines.  I.e.
>
>      void randomize_git_file(char *dir, char *name, char *data_chunk, int=
 data_size)
>      {
>
>
>> +   char fname[256];
> In our codebase, tab-width is 8 and we indent with tabs.
>
> Use <strbuf.h> and avoid snprintf(), e.g.
>
>       struct strbuf fname =3D STRBUF_INIT;
>       strbuf_addf(&fname, "%s/%s", dir, name);
>       ... use fname.buf ...
>       strbuf_release(&fname);
I have changed all the snprintf code to use strbuf instead. Thanks for
the suggestion.
>> +   FILE *fp;
>> +
> Good that you leave a blank between the end of decl and the
> beginning of the statements.
>
>> +   snprintf(fname, 255, "%s/%s", dir, name);
>> +
>> +   fp =3D fopen(fname, "wb");
>> +   if (fp) {
>> +      fwrite(data_chunk, 1, data_size, fp);
>> +      fclose(fp);
>> +   }
>> +}
> Why doesn't this care about errors at all?  Not even fopen errors?
>
I have changed the code a little bit, but in general, fail to generate
contents of a file do appear many time during the fuzzing process
because some random fuzzing data result in unexpected behaviour and we
currently just skip that round of fuzzing.
>> +/*
>> + * This function is the variants of the above functions which takes
>> + * in a set of target files to be processed. These target file are
> "... is a variant of the above function, which takes a set of ..."
>
>> + * passing to the above function one by one for content rewrite.
>> + */
>> +void randomize_git_files(char *dir, char *name_set[], int files_count, =
char *data, int size) {
>> +   int data_size =3D size / files_count;
>> +
>> +   for(int i=3D0; i<files_count; i++) {
> We do not yet officially allow variable decl for for() statement
> like this.  We'll start allowing it later this year but we are
> waiting for oddball platform/compiler folks to scream right now.
>
> IOW, we write the above more like so:
>
>       int data_size =3D size / files_count;
>       int i;
>
>          for (i =3D 0; i < files_count; i++) {
>
> Take also notice how we use whitespaces around non-unary operators.
Thanks, changed the code style accordingly.
>> +      char *data_chunk =3D malloc(data_size);
>> +      memcpy(data_chunk, data + (i * data_size), data_size);
>> +      randomize_git_file(dir, name_set[i], data_chunk, data_size);
>> +
>> +      free(data_chunk);
>> +   }
> As data_size does not change in this loop and the contents of
> data_chunk from each round is discardable, allocating once outside
> may make more sense.  Actually, as the called function makes only
> read-only accesses of data_chunk, I do not quite see why you need to
> make a copy in the first place.
>
> We do not use malloc() etc. directly out of the system; study wrapper.c
> and find xmalloc() and friends.
Change to use xmallocz_gentle instead of malloc. Thanks for the suggestion.
>
> What if size is not a multiple of files_count, by the way?
It does not matter, the unused byte just simply be ignored. We just
ensure it has enough random byte provided by the oss-fuzz engine to
generate those random file content.
> I'll stop here as we already have plenty above (read: it is not "I
> didn't spot any problems in the patch after this point").
Thanks and sorry for the trouble, this is the first time to contribute
to patches in git and does not know most of the convention and style.
Have changed most of the them with my best effort accordingly and will
prepare a v2 soon enough.
>
> Thanks.
ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom
