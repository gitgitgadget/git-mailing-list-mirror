Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D1C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42923239D1
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgLHO7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:59:39 -0500
Received: from mail-eopbgr70124.outbound.protection.outlook.com ([40.107.7.124]:52311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729842AbgLHO7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 09:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVJSeuBjGGdZqKuB9SQ47PrI9BV8FjTtJx6cNCte95VqB8v6N+gr5LhyOupmM8/XA/x9/7JBnnY/1pRSVQyqUkBpE9FowJ1lJdDDps5XFjBP3Xh0wfgoLC5tLdkKFQ+veIJ0rvHb7ZKT4LJCP8jI1k5q/Cm8xaile5mIXkDdr1Fqmn0C5JwjSh37s8x1XLt3f6xg5nAUjbqzXWLlURjPhJJES8VoiMY9AmIEhYJZhFU7qwEjH9stVUENKdhX+3tTiryTQhDoK/NTYgtVaxRJm4/VRgoRqkkuwxGyrBlCCc+QF61EAnR8x+wsK4clCGimB5BzVQpq6dmStK08b+xhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVr2v9jwhRUHSLNB+lN2CgJJKWj4TwCo/7cB+jA3PDQ=;
 b=Vh49qHXC28poxNMCywG3tL0nXePluMK17xC4CETftVCrUERxl68Im4icowRKqsYCs42KNURhUw1P9Nx8HzC+dqxKdwpjbWK2VvJxIieBM7AfkL78dm3z8FYnyYurbauk5K0RiU7JaNawwq5A5Aebwt6CGPo9og2vapNZR+shPBOXtBLvOCyTpzlWSL0d7T4Er6qx7sfEYJ40qajrHJ+NFI/Cdt3QMKsVD2dVtlbSOMTU1BVto2d96Uo0Q/FHxd4nPz4H+MfWvDRAtyHlQU+njR6PSIHAlusurRrCcSrq7vm7oZ3IZ6DP4rbhb0R/O1KjTjGaLlVWJfsIS3MppBO/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVr2v9jwhRUHSLNB+lN2CgJJKWj4TwCo/7cB+jA3PDQ=;
 b=yOx/6Q4+ifPtVYiiyny4vzwbjoZv1R92rhUDM1P1oED480XVvW+XFoT9NKhRiBQYFb9JJgGaOWHap+9wCO4pEG5EJEP1ouqCWNmlRS+T2MonaKse5DJGqkbaE9OF3Jay1OBZQpcJJvO47M4uU7oXNtPWrldy50mzRXa4HTv3TTg=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB6PR07MB4197.eurprd07.prod.outlook.com (2603:10a6:6:4f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 14:58:49 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Tue, 8 Dec 2020
 14:58:49 +0000
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
 <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
 <xmqq360hbev1.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
Date:   Tue, 8 Dec 2020 15:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <xmqq360hbev1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: HE1PR06CA0144.eurprd06.prod.outlook.com
 (2603:10a6:7:16::31) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.8] (131.228.32.168) by HE1PR06CA0144.eurprd06.prod.outlook.com (2603:10a6:7:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 14:58:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37b00f3e-9825-442d-ef09-08d89b89c504
X-MS-TrafficTypeDiagnostic: DB6PR07MB4197:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR07MB4197872C055B86087795D6BCEECD0@DB6PR07MB4197.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcJyRbp4XcUZbqDryBo90A92GOrJgIBbr8YGEilc8CndfvmDWjBIAMBeqxOLpFpxfudk0xv5osfoUg79NhHBcPl39bHtWUqytSrJvg6AkWkMAMBzzYwXTwRLnSPvmpIT/letT9u0ZAw85swdBeO2gsArYx3Mbus1dOcINeUSxPIQDA1qksJINBRV2cz2Iw7z0Cm3a3XAUldOaI2iYM5MsVWjoau022eQP4mPdwhbN3mg/bU/aRw+GtXhiuK+dNW8rKLiziKUoYi8Eb+P/H+zuMWfIc4qb0Ixk9i1LMQ3yjIJ8+9KAJ08zopco1+q7zuvZKJO46/zSUHgwp8EoLRo5KyKxSqeXUjymRnhMUFQwfaZk2Tdq5U63EbYfREJQFbCBrlBccmoJMXsEWzIGthnaaxci6WJe56TYD0fzWuc7OGJSfqhECZScuec+4ITz8eWSxkfjmGlruer/wQMzCr+/PDTvWyLbEQcJ6LZqS3ybm0/AO29DMhig984zFeFT3QZ0sjg+i2D6BAO15gOctu7QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(66946007)(16576012)(66556008)(956004)(54906003)(52116002)(66476007)(6486002)(36756003)(6666004)(34490700003)(31686004)(83380400001)(26005)(53546011)(6916009)(31696002)(5660300002)(86362001)(8676002)(2906002)(16526019)(8936002)(508600001)(186003)(4326008)(966005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXZkT3RPN2liKzh4K2NIRWw5ZklmNEtna1RneXlwTTNIcGZSZlRvUzc3YXpN?=
 =?utf-8?B?cCtXM2NMRzEyUjdTaVBhYnNzOXlPTGlkSldYUlB2bGg3a0RrUTVseEt3NTdH?=
 =?utf-8?B?N1dDZHlzUVlaM09xQk1DR1lGRnNINVc1bWlCUzBMSFkrRG4yL01lR0VGN0Vr?=
 =?utf-8?B?MmlPcFVkTEVFZEhoazE5VjZQeHVQU2U3SlFoMFB1b0dOOTVkQ0ZaOU1nMWk1?=
 =?utf-8?B?RCtJQldCRkhEV2h0ZUhyZnlYcXBxbVBJdDFJOTA2U1UwcUhVeVdXaEpQRFgz?=
 =?utf-8?B?T09venlBdzVEb0xQTWlDUHVDS1BsS3FHcy9vZ1RFbHpGa3dHd2VIYS9aYnFh?=
 =?utf-8?B?WkVoQ0tnNjlZL1UxNlIxbTZHUVYvcVkwRGM0UlNockZhZFV4eXNXb3hEVGlD?=
 =?utf-8?B?VjRHVmJ3dTdOVy8xU3VwZ0svNkZ1Z3lmMVZnWEtDa0Yrb0hNc0VPYjdrZzJn?=
 =?utf-8?B?cHdPV0ZuQ25HRi84aFUrR0kvOVZXUkkwVHhsSnU3R3hkOVdtdFRESFhIR2VC?=
 =?utf-8?B?a05NZkUrOXJHRlhBc3BGczM3eVdlSjllajc0WXVScEtlUEVTa01JNUxrTW9R?=
 =?utf-8?B?Z1ZrM003Y3Q2b2hyTUFPSmtXTVR0blQ4RHlWM2gzSnlhSUVGZll5RkJKU1Fo?=
 =?utf-8?B?UEFsWlFUZndqNXMwS3h6TFgxU1NLTCt2L29oSy9iaDlhSUdlMHRvS2pqNjdl?=
 =?utf-8?B?S3VXSXFwUnNUUk9OMjZNaDlsRGRFRVM0ZHE5ZmFQNFpGOFBiU1cxNUIwcXlC?=
 =?utf-8?B?a2d1azdZSW1YNW9vR0ZhdzEwR2cwcDh6RGhUbStDNlFXaHRNT3lMSlNwQzlJ?=
 =?utf-8?B?REJmNEJzL0JWRnZONkZIK1A5ZzFqVjFSYWJBWmZNdDFwakVqTGl5T3p4TWFI?=
 =?utf-8?B?aDlrcWRlYkcyT0ZhUVhmWWd6QmEvcU5KUW5NR3BYUlVkajRPV1gwMjdlejBo?=
 =?utf-8?B?ZmJLUkYxNVpmWVg3SXhSdTNmVlduTVRZcSszeE9jazBrUkJ3Y1NFenhWbXJB?=
 =?utf-8?B?cUhmd091M1ZRYWFDT2RRZnA4RVMrK2t2M3hXOWR1SWJFZy83ZUxEaG5UbW9F?=
 =?utf-8?B?OVBBSHM4NUdYWmh2blp0TkE2UVlBOXlrNlkyZ0Y2QWNqYTAxckIzeGQwa1o0?=
 =?utf-8?B?R2Y5RFZqVnBsSkRzekFRci93L2lPWjdQWFhjZ0FEUEpoNmw3bGJtd1ltTjF3?=
 =?utf-8?B?dlFyK28vTFk3RVlQKzRDMnZYVGpPcjYraDBadHprR01FSitTNVp2eVpjQ01h?=
 =?utf-8?B?dU4rcVlwZlBFQTBaUmJZMWU1bUtkeVZGSTdkRVN4YVEyNWRacFQrRHZFT3dy?=
 =?utf-8?Q?CZ/T4ezyy+HLWwe/Ac95QxYaV+zUT2Io2i?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 14:58:49.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b00f3e-9825-442d-ef09-08d89b89c504
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvAydiFCGUZM51ghczhWbb/11Va9FlKek4GRBADlXik2fBgdTzcRIKZ3pcqCo4BMTXYGD5wvMsF8I4iq3NReyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4197
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07.12.20 20:22, Junio C Hamano wrote:
> Peter Kaestle <peter.kaestle@nokia.com> writes:
> 
>> +add_commit_push () {
>> +	dir="$1" &&
>> +	msg="$2" &&
>> +	shift 2 &&
>> +	git -C "$dir" add "$@" &&
>> +	git -C "$dir" commit -a -m "$msg" &&
>> +	git -C "$dir" push
>> +}
>> +
>> +compare_refs_in_dir () {
>> +	fail= &&
>> +	if test "x$1" = 'x!'
>> +	then
>> +		fail='!' &&
>> +		shift
>> +	fi &&
>> +	git -C "$1" rev-parse --verify "$2" >expect &&
>> +	git -C "$3" rev-parse --verify "$4" >actual &&
>> +	eval $fail test_cmp expect actual
>> +}
> 
> 
> 
>> +test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
>> +	# depends on previous test for setup
>> +
>> +	git -C B/ fetch &&
>> +	compare_refs_in_dir A origin/master B origin/master
> 
> Can we do this without relying on the name of the default branch?
> Perhaps when outer, middle and inner are prepared, they can be
> forced to be on the 'sample' (not 'master' nor 'main') branch, or
> something like that?

Using origin/HEAD for compare_refs_in_dir should be fine without 
additional setup, as for the regression the "git -C B/ fetch" will fail 
and return with false (see description of the patch).  This 
compare_refs_in_dir is just for additional checking as you proposed in 
the mail:
https://public-inbox.org/git/xmqqk0uuct94.fsf@gitster.c.googlers.com/
------------8<-------------
> And from B that was an original copy of A with only the top and
> middle layer instantiated, you run "git fetch".  Are you happy as
> long as "git fetch" does not exit with non-zero status?  That is
> hard to believe---it may be a necessary condition for the command to
> exit with zero status, but you have other expectations, like what
> commit the remote tracking branch refs/remotes/origin/HEAD ought to
> be pointing at.  I think we should check that, too.
----------->8-------------


> 
>> +test_expect_success 'setup recursive fetch with uninit submodule' '
>> +	# does not depend on any previous test setups
>> +
>> +	git init main &&
>> +	git init sub &&
> 
> "super vs sub" would give us a better contrast than "main vs sub",
> and it would help reduce mistakes in the mechanical conversion of
> "master" to "main" happening in another topic.
> 

ok.


>> +	# In a regression the following git call will run into infinite recursion.
>> +	# To handle that, we connect the grep command to the git call by a pipe
>> +	# so that grep can kill the infinite recusion when detected.
>> +	# The recursion creates git output like:
>> +	# Fetching submodule sub
>> +	# Fetching submodule sub/sub              <-- [1]
>> +	# Fetching submodule sub/sub/sub
>> +	# ...
>> +	# [1] grep will trigger here and kill git by exiting and closing its stdin
> 
> "trigger here and kill..." -> "stop reading and cause git to
> eventually stop and die"
> 
> But we probably cannot use 'grep -m1' so it is a moot point.
> 
>> +
>> +	! git -C main fetch --recurse-submodules 2>&1 |
>> +		grep -v -m1 "Fetching submodule sub$" &&
> 
> Unfortunately, "grep -m<count>" is not even in POSIX, I would think.
> 
> What do we expect to happen in the correct case?

sigh, we can't use grep -m1.  Too bad, it was such a nice solution.

> 
>   - A line "Fetching submodule sub" and nothing else is given?  That
>     feels a bit brittle (how are we making sure, in the presence of
>     "2>&1", that we will not get any other output, like progress?)
> 
>   - "sub" is the only thing that appears on lines that begin with
>     "Fetching submodule" (i.e. "Fetching submodule $something" where
>     $something is not 'sub' is an error), and we allow other garbage
>     in the output?  That would be a bit more robust than the above.
> 
> As you seem to be comfortable using "sed" below, perhaps use it to
> extract the first few lines that say "^Fetching submodule " from the
> output and stop, and check that the output has only one such line
> about 'sub' and nothing else?

According to [1] posix sed offers equal possibility to quit like grep 
-m1 and I'll adopt:
$> yes posixgrepisnogoodforus | sed "/posix/q"

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html


Looking at the other mails I think I processed over all open comments 
and will prepare for v3.  Thanks again.

-- 
kind regards
--peter;

