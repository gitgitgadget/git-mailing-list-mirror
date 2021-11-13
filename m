Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7B8C433F5
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 14:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF646054E
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 14:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhKMOqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 09:46:48 -0500
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:37526
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229668AbhKMOqs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 09:46:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qbsctun8ioJhAhWy7v3U3+P+OUNgzHM/9qgTFTWcCJqjUmIvRp2AfFu+00bad0b6iBnQ2p82DBoFMq+W3mcffC/cIpLbzR93PjnYpST5nn/68MEGMS+yJ+cfytW7BRUbqcuhiFXeV8uoo17i2qD39GTL16PomSNbNKdQn802IgzUXJGLUWDbcZONWmovPX5O5518Mis0ZkkhXKeWWu3yemtRrqz0mGYM/RtJAQMgHzKHeWpbEUXnEfetkPsE3C+sPmJd9yn9BTpprp6LL8JwoNBOemOGUDWxVvl0/pjteKqpFSJo9+aWpkineKNTPS9UkkbTjt2qydfofU0UVCOFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sfX79l2O0K8OJjL0NPeblsk76d1yuYGXGe6axTeMwE=;
 b=ecpAqxVNh+eVH5GwUJqde76tuAcRDryl4H7kgrN1R1A+RBaowLOq3XPTi8mWm6t7o2NuirV4BS0I+dKOi5Mbmd0OS3uS79gy7zqHTaenOzV7Ls+vvpBGhiDeWlgSNxNj9iOWjMxAmGtGpRRm7CHaycn+3zE00oDvCOxa55U6kqgxs6nk30ylS93DvJdcWrVe9bffdWQCiiAu9ulyg0n46k6zaTfuCWjnGiFMg1vk3Avkc8o4Az4tMxA9SCZA1qmKW+Osnt+qBEzOJyHzPqYbVXzWARE6KhEk4Uoq2cvfvdtH3pwflnARiGOOfq9jBwnZh3DUdUTac7wd2MZnSL6x+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sfX79l2O0K8OJjL0NPeblsk76d1yuYGXGe6axTeMwE=;
 b=qshAr9A1yv5CjTMQgSvmGmahZ5kyiXbvED7CD/wE25ADjQyRJYxU562gXAR/5Jxh3zRZvcPbocR1BpNrTYWgnx0jA4Y4QANaBLVCL5jAnEDxyJBjlcN01Vqmu5TpHNPdYjBbYYskBaMbXwzvOkLRpAzWc8I31Vv8uLgENyEXCI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Sat, 13 Nov
 2021 14:43:52 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.011; Sat, 13 Nov 2021
 14:43:52 +0000
Date:   Sat, 13 Nov 2021 15:43:51 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] lib-test: show failed prereq was Re: [PATCH]
 t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211113144351.3rsbogowax36iatz@fs>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
 <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g>
 <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
 <xmqqv916wh7t.fsf@gitster.g>
 <20211112160101.xm7xi4474pgybrh4@fs>
 <xmqqk0hcmvql.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqk0hcmvql.fsf@gitster.g>
X-ClientProxiedBy: AS9PR06CA0271.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::25) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS9PR06CA0271.eurprd06.prod.outlook.com (2603:10a6:20b:45a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Sat, 13 Nov 2021 14:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac8ff59-8b7d-4981-ea7b-08d9a6b40300
X-MS-TrafficTypeDiagnostic: PR3PR10MB4240:
X-Microsoft-Antispam-PRVS: <PR3PR10MB42403B2D12B788A89B9D955FB6969@PR3PR10MB4240.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLLuFEAl0rzceXjZOYVp6DQpocDHxprbOw/lrPG+p8JzXCqJMsFY7NjEPBSDf0NP7SK7KPIMrbSRJEf9EQOa9I9sG60+dJ4BANFDrh4xPiB5s7oHCctLEddWMD0K5YDDu5Vcn4NUhuQ4nYMXrKhPHLdcuCmf4A2EcLXO1PC5YzebN5fAG31I5cvD7ZzDOEoobNXk6h3Cke125mCon2XiVXnUajfdeFpBXWVbRFc2vc9wtMz5egJxBav/c4voKuSNvzgOXuB00plE5OsjZQIS4A56D5SXaQb6enkC9HD+HkzER6RQURM1E9nkz3S1MRjcVkjGZ3/DJs1xW1rbWN7xVKNtq567zmEl2/5KyoKxJZhzX5hdEo2QxSIXC3RtS5k1T/SJh68Cqsf2aa89KnaEG+LBQJsc0JIFI2/lYAD2u+6mDDgFKwA6v0l3jrYQxN0NUEPTkY7HIfOPIpqIYlM9QH4/UAo1VMx6twbkhbiiAOUoA7B4huki370O8nGZZOWIUg58Oz7uOG56iZXNiP5T6qiT/h6uYT0EqXz0pqgRVH8w9fjdRRbSq004ag2KbQcUMUHfufZ3yCCamF+lulxdrI4CUiZeldZd0t+70AElamYCSihvPTJ+U+MfANGr8reXTwSnycNbVRJmxcdvVhPGbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39830400003)(396003)(136003)(346002)(366004)(186003)(38100700002)(33716001)(1076003)(6916009)(66946007)(66476007)(66556008)(54906003)(508600001)(316002)(9686003)(6486002)(2906002)(83380400001)(5660300002)(53546011)(6496006)(52116002)(8936002)(86362001)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3N4SVdvNjlPUytFV2ltY2psRUpPYktrWkF5LzQ4eGhRVjZOQk1sa1Y2ZEY3?=
 =?utf-8?B?S2YrZHYzZEVBMG1zZkU1cWpJZy9yRjVoRGYvQ3RkYm9BOVJtbGw5ZnlDTkxz?=
 =?utf-8?B?anNUaHhqODBnNHpjbkpmeERJT0gvY0FabVFlSjNZQVVQb1JiMTI4ejJVMm1o?=
 =?utf-8?B?Wm5OYk5YdjQxcjB2WTE4a2VzTG5peTk5aE5naytscnZ5LzRwWWE2RUpKRlo1?=
 =?utf-8?B?NUc3LzlGYkFoZkszK3c3ZWgzeVdoOGdENGJEd1hRSnhENWFvWVZSazJKZmxy?=
 =?utf-8?B?Y3Z6YjE4NDJTODZVdkFrOTJxOElFYmo1UWtFLzdvUmdGcmcrcElvTFZVRHZi?=
 =?utf-8?B?WE5uU0ZVWitxOGlxZmxLRWdNZ0x3NTN1c0xVL1VOa3FIZUJTSGt2aU5Pc205?=
 =?utf-8?B?aUxPMUFlVlVpRWZBT1RHWnY0SGNOa0dBcXZ1RUYzUWM3QWsxYVdiMmlLeEpW?=
 =?utf-8?B?WTlNczNTS0FnVi91VWlNRndhdGxWd1loSnlyZWFRbXU2MlNyN1Z5blk2WXFj?=
 =?utf-8?B?eWt4ZUh1UjlPc29LdUkrQXUrYmhFY1N6RnlPVWVBeDFCNm9WaW5xU3FaTlBw?=
 =?utf-8?B?UWRzNGd4d216cnQxWmFpNkVYTGVRa2lzMjVDV3NORTRLSjZvZEtQZ0lRTy8v?=
 =?utf-8?B?ZXVZRUVENndpdjhHYzNrZFk2bmx5a0lhbnJ4N3RvVDlmN3llVnlkdXpYQWpy?=
 =?utf-8?B?ckMvUmk0U3huVHpaSlFLK085MWFxRlFlMTQ4dllvaGFqZndoRzVmbUhTM2t3?=
 =?utf-8?B?WDNmZkJ1RzJLYjNiWGlDSjVYUlZ1VnJxYWlHVzBRTSs5QndXS0I4Z3c3OTFE?=
 =?utf-8?B?VTMrOXN0OW5RZlVEK2VxUjR4RElqcFp1Z2JVcG1xSnhQUFpkMklZM3ZWemZi?=
 =?utf-8?B?bTJLLzNoMDhtOU1xK04yUVlGVDJ1Y1dzbHFFWEdNSW5YT3Z6aU5ZdmFzMW1N?=
 =?utf-8?B?RHQrNlk2QlpaalFHL0ViV01BODViTEljaW5uL3NhS0N0NXhtRjRsNkVHZ2ZT?=
 =?utf-8?B?UTRKTzJZc1UwOVNVVEVlMTMwdWpXck90Qm1hZENqSkJtSHlad28zOHZTa2J3?=
 =?utf-8?B?aHM1eXNBejBNNHRGQys5L0VHU3p2eW9OLzF2S0tJeEg4SlQ1bElPTE5JZmZ1?=
 =?utf-8?B?OVJ0OXFqNW8reVYvL2JZZVVac1ZldzFQVDAvWmk0blZQK3ZBQndDVmJPMlRV?=
 =?utf-8?B?djFhOGV2N1huUDd6Ui9vYWFKNWtnd2wyNzBzMDc2U3RvMUFLRHNKK0t3Mi9q?=
 =?utf-8?B?UWZWbElWTjdIZkEvOGFBQ0tuS3Y3akxPMURLSHBFUElOT0ZBREJmUHNVWm9X?=
 =?utf-8?B?UHBHL3BSSGtzdncrV2tpUTh6YjEwS25TNGxLSWlhbm40djVGRTFJNDY5KzR4?=
 =?utf-8?B?YUhBS3Vod2hTWUxmdmRQK1ZzcmtCL0pia0FVMHZrSnFDY1dKSXRVakZ6UktJ?=
 =?utf-8?B?T0RmT2EwMHhtLzZHR09pckZWRWVsY3Jtb1Y0b0NEcmg2QlQ2b3FTWFFwdk84?=
 =?utf-8?B?Y0hrMGF4cTVqdWZpb1lZblR4RE5tRVpDNXpybFZYZlF5bE1Xd3AveVlZbVVI?=
 =?utf-8?B?NnA1dGJjdWMrY200SXRWSzNiVVk4STZkL3I2aEVNdTlzTjJYV2dUTFV6aWs0?=
 =?utf-8?B?VTJPTGV6ZmNHUkxSWjV5ZDlqckxRa3c2b1lEMTd5ZWhzTGNVRTZjdTZZTmxq?=
 =?utf-8?B?K1UzcFJoM2dPREFiOU5LMUtNNFlQR2toZHVBd0kwTUdmT1M3QTRtb1dhVERY?=
 =?utf-8?B?QzdLNEIvOCtaYVJsdkZqU2tPTmNSTms5VWJDeFFHZlIyQjlnNXQzaE5OQXRS?=
 =?utf-8?B?S0lvU092MzIyZ3FEalFLbEszRjM3TGVJSVdZUXd0UjViYVdkUXM0eXF3ZUF0?=
 =?utf-8?B?TERXVmxLaGI4Q3NaSjNpaUFYU1A4azNSV0JLa21LRVpnWDVXRGhqK2MzMEd6?=
 =?utf-8?B?WHFWTkNvV1VZeSsrZlQvZGYyZ0EyZm5RRFZNazVoY3RtZlZTNTdMRU9TTUlX?=
 =?utf-8?B?clJhcGZGWElPaGhUQzU0U0FWbzV4Ti9WajNVTDhhdW9wcHF3Y1p4R2o2emdz?=
 =?utf-8?B?Y1hIVEJTUitPUkp1b0pmTTNUdU1reVAzald3RnR6dDRPTWs5OUsyRUFUYnFz?=
 =?utf-8?B?eG8waDFpVnZhb3FIdGhFdllWK2dEcTcwUE1oMEppWE5Ja2cyazZnclU1T3p6?=
 =?utf-8?B?UlMzcHJaNUVDTkVBYkFKa25CRmRFZUtYRDR6OTVTZ1o0ZUpMSWJqRE5Vb0R0?=
 =?utf-8?B?eGc5SjVnTGh6ckhreitqTmlZQTFBc1drdnhwRGlodnFJc1dpMWtldHljOEs5?=
 =?utf-8?B?M2VsWXBNanhKaDFiQjNiWklhMHkvOEJNRnpFSU1ZbUV6UGY1ZFlGZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac8ff59-8b7d-4981-ea7b-08d9a6b40300
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2021 14:43:52.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rDhFlYlNmELQaQ3NPxntQJRmnRrpbze8POeIa0MakkvAewnN7q1nD6cDphRJZ21YGP6oOaT5et5ZW21nvFSpxMgKjvXPwdPGwpPqg8M+luI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4240
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.11.2021 22:10, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> As for the general prereq issue i ran into that as well during
>> development. When you depend on other patches / a specific version of
>> ssh-keygen for git I always have to remember to set the path correctly
>> or the tests might silently be ignored by the missing prereq. Usually
>> not a problem for single test runs, but when i run the full suite before
>> sending something.
>
>This will become a handy tool for everybody, not just for those on
>minority and/or exotic platforms.  When someone prepares a plain
>vanilla fresh box and build Git from the source for the first time
>on the box, it is fairly easy to end up with a castrated version of
>Git, without knowing what is missing.  This is especially so when
>autoconf is used, but even without using autoconf, if you do not
>have libsvn Perl modules, svn binary, or cvs binary installed, our
>tests treat it as a signal that you are uninterested in SVN or CVS
>interop tests, rather than flagging it as an error.  Being able to
>see what is automatically skipped would be a good way to sanity
>check what you actually have vs what you thought you had.  For
>example, I just found out that I am still running CVS interop tests
>in my installation.
>
>> Subject: [RFC PATCH 1/2] test-lib: show failed prereq summary
>>
>> Add failed prereqs to the test results.
>> Aggregate and then show them with the totals.
>>
>
>> +		sed -e 's/ //g' -e 's/^,//' -e 's/,$//' -e 's/,/\n/g' \
>> +		| sort | uniq | paste -s -d ',')
>
>I suspect you are making more work than necessary for yourself by
>choosing to use SP when accumulating values in $missing_prereq
>variable.  If you used comma instead, "tr -s ','" here will make a
>neat sequence of tokens separated with one comma each, possibly with
>one extra comma at the beginning and at the end if some $value were
>empty.

You are right. I'll change it to ',' as well. It makes the following
unique logic easier.

>
>Would something like this work better, I wonder?
>
>	unique_missing_prereq=$(
>                echo "$missing_prereq" |
>                tr -s "," "\012" |
>                grep -v "^$" |
>                sort -u |
>                paste -s -d ,
>	)
>

Ok. Took me a moment to understand since i didn't realize tr did the
newline expansion as well. But yeah, this is nicer.

>> +	printf "\nmissing prereq: $unique_missing_prereq\n\n"
>
>I think it is possible that a $missing_prereq that is not empty
>still yields an empty $unique_missing_prereq.  If $value read from
>the files all are empty strings, $missing_prereq will have many SP
>(or comma if you take my earlier suggestion), but no actual prereq
>will remain after the "unique" thing is computed.  I think this
>printf should be shown only when $unique_missing_prereq is not
>empty.

True. I'll add an if.

>> +		test_missing_prereq="$missing_prereq,$test_missing_prereq"
>
>OK.  We accumulate in $test_missing_prereq what is in missing_prereq
>(assigned in test_have_prereq check).  I notice that over there, it
>takes pains to make sure it uses only one comma between each token,
>without excess leading or trailing comma, but we are not taking the
>same care here.  It would be OK as we'd run "tr -s ," on the side
>that reads the output, but looks somewhat sloppy.

Ok, i'll use the same logic as in the test_have_prereq func here as
well.

>>
>> From d13d4c8ccbd832e1d62044b18b8b771f6586ee2a Mon Sep 17 00:00:00 2001
>> From: Fabian Stelzer <fs@gigacodes.de>
>> Date: Fri, 12 Nov 2021 16:43:18 +0100
>> Subject: [RFC PATCH 2/2] test-lib: introduce required prereq for test runs
>>
>> Allows setting GIT_TEST_REQUIRE_PREREQ to a number of prereqs that must
>> succeed for this run. Otherwise the test run will abort.
>
>I am not quite sure what the sentence means, so let me read the code
>first before commenting.
>
>At this point, we know $prerequisite we are looking at (note that
>what is written as a guard for a particular test might be negated,
>e.g. "test_expect_success !WINDOWS 'title' 'code'" that runs on
>non-WINDOWS platforms, but here the negation has been stripped away,
>so the test says "I require to be on non-Windows", but this new code
>only knows that WINDOWS prereq has failed)

I will write some clearer commit messages and then re-send as a normal
patch.

>
>> +			if ! test -z $GIT_TEST_REQUIRE_PREREQ
>
>Why not
>
>	if test -n "$GIT_TEST_REQUIRE_PREREQ"
>
>?

Obviously, yes...

>
>
>> +			then
>> +				case ",$GIT_TEST_REQUIRE_PREREQ," in
>> +				*,$prerequisite,*)
>> +					error "required prereq $prerequisite failed"
>> +					;;
>
>So GIT_TEST_REQUIRE_PREREQ could be set to a comma separated list of
>prerequisites, e.g. WINDOWS,PDP11,CRAY, and we see if $prerequisite
>we have just found out is missing is any one of them.  And abort the
>test if that is true.  Makes sense, except for the negation.  You
>want to be able to say GIT_TEST_REQUIRE_PREREQ=!WINDOWS,PERL to
>require that you are not on Windows and have PERL, for example.
>
>Perhaps this new block should be moved a bit further down in the
>code, i.e.

Thanks, yes i did not notice the negation issue.

>Thanks for working on this.
>Looking good.

Thanks for your review.
