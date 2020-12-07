Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC07C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668C8227C3
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 08:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgLGI3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 03:29:45 -0500
Received: from mail-eopbgr40120.outbound.protection.outlook.com ([40.107.4.120]:13294
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgLGI3o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 03:29:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqOF2o8/75ma8scz8c5Cipc790vxp9f4xWqfTUQV+OMOwxXQNJ/okTc5E4LQabU0Knt6ZbnzyP7l1NcYFI7QcSwCOsDrdMxl8GTkZvvPcyviYiMY8OF2ck0TyYnlhOtaqpq9qOTqmvm2Dmmyq25oU6g4H4oTXqRDN8aoe6IoE57HYawYQUrfNwKkVMcJudAJ/Ag6Uk0r1hNmk98i9MjGbx+CcHL7GYPQw/lpOi8d/nitogOYo8fJL95XDJ/LySugJuRRtwX7yVsRBa51bySsSesWEpQxzaVp1v9eU4KISQB7cAOmiOGpuUEUfIf0sdHaeUQ4+vvu1slcXc34XiCuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON90F5jipzCHKkxTtj11vKn6PMajNDGVDVoMaAWrxS8=;
 b=bWVa39N7FeHJnZTZMaqjaF/z8ytLuNHuVLUqQQbLk3Q4hCdBfAu6KpLgO9tSRbr+yhdVgKyw1KbG/VJWpoNqKOQBrHPt5mJRRIUySdJf1WugWhhsB+28BYvFpT0BNdjy7fWJLmbUXVXaOlT/QbJG/um9NJe+fBlkKdeBaqJVaUp/CUVzqUM7T7JaAkA3WXkqAqPdkzd21KpaExJz30lVMxDMGxkxFc8JXJkH1PvFnVg2ET1Cd7kEkMQzue0cwgAx9+CquIbdTOmUzAuPg4X5VjCHIwzgytQK4WxzTs0stXcHO74DVWTa6zaQrocietnbdGqhCeoOHINCBmV5Rpyixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON90F5jipzCHKkxTtj11vKn6PMajNDGVDVoMaAWrxS8=;
 b=oByFjVyYWezyIH50Fh7Qe09BOLzSkUFjP6HCqIZCgxSz4mTJI59Z9U6g/3F3Rc+zJGCagqGggKJlGzuD0zDMsjV96alcSOFcCq6ONt6zxRMRz2kPwTAshJ6yW+jdRRNGjdv0bhXr8rGcLTBGWJAqCVL0nCswbLzVZXASJYyDUbs=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB7PR07MB5048.eurprd07.prod.outlook.com (2603:10a6:10:5c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 7 Dec
 2020 08:28:55 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Mon, 7 Dec 2020
 08:28:55 +0000
Subject: Re: [PATCH] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <0b6a34a0-428e-5fc4-307d-1217b112659c@nokia.com>
 <1607095412-40109-1-git-send-email-peter.kaestle@nokia.com>
 <CAPig+cR69HJefRMfH_5-dHOMVY-VmVgbqQuWV90ednDEjrnExw@mail.gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <0deeeabe-9590-db7a-4a07-447d43df7a24@nokia.com>
Date:   Mon, 7 Dec 2020 09:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAPig+cR69HJefRMfH_5-dHOMVY-VmVgbqQuWV90ednDEjrnExw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.169]
X-ClientProxiedBy: CH0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:610:b3::14) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.9] (131.228.32.169) by CH0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:610:b3::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Mon, 7 Dec 2020 08:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 301b5b2b-ec7a-40bf-0a71-08d89a8a22c9
X-MS-TrafficTypeDiagnostic: DB7PR07MB5048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR07MB504887824AD551D8479C352BEECE0@DB7PR07MB5048.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu8gHNVf4LapfzyCizSTkiA9MKgpoVpja98YLZruPNwyQbpSZcEGoeKYV1IJCYcaDola7ozyqPMqMFptDX9teMGGkKYCQdLfl7AfWlIs+SAEKkGE4We9JWULWAfH6Dnj6TcVx2N/CxHMZWSLo/mAnfbXSCIg6xy4BhsEYqYGSNz8VvIFYRyDN+iHGN+V80bfz6ha0nnCv6mngHrV7s3elgjTT0kIplKoBjX8J+z4Lk30VqdR0XTTad7GWT2T7wKsxGSip35bv3oJWjE53OWcZMI6OXSTcfsbj0qb/yBLeLFtGCA5INhlvc7f/UmkE//aaQwy+ASyhVe9xG5QAPnDihEWM+G3h/aBR5ACxpM/amls4D+jQZtjTfUrsC7luK6jsXoqGMUZUAZxpqmjZ30AgLQln7L6DeUvZyIHJXAJEok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(4326008)(2906002)(5660300002)(478600001)(31696002)(31686004)(83380400001)(6916009)(53546011)(52116002)(86362001)(54906003)(6666004)(8936002)(316002)(66476007)(8676002)(36756003)(2616005)(956004)(16576012)(66556008)(26005)(186003)(66946007)(16526019)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dXRTTlVndGFRRVh6cW8yMDVXYXJ4ditSNmpEM1hzNTJDalJKdmx1dVNDRkZJ?=
 =?utf-8?B?MmZIWlc5M1ppYUVXSlZnNnIyOGlaSmdnSWpnOXVJNmF2NWI5NzZzK1VHbFFm?=
 =?utf-8?B?N3JsTWdZZlhiWWhhTzJmNUY2UTlIVFc3QUNpMjFrS3hNNk1DMVJRSStKcHc1?=
 =?utf-8?B?aGswWFpWY3RZZnlsR0pEb3hibzBYT1RuQ3NobzNxVWlybTQzRm1mSlVYSXVh?=
 =?utf-8?B?bGs4b1E2Z0YraXFCMk9Bc3o0ZU5MZnM1eUZabVA4cnlBczJmcFRLYjFkOGpK?=
 =?utf-8?B?OTREc01KZVViRHlqNEFMMTVZM0RGRnVNWFp5UzdvcXNLYWpxS1BwMlBBQlBH?=
 =?utf-8?B?MGdqQS9pUzlBTkJoUHcwZVBld213bVdpRW42cWhidWFTaFlMUzdzaEZjMmRv?=
 =?utf-8?B?TXRuL1pzcXpuRC9JMVpBQVlzdGlNSys5WlUyUG9LcHdiM3VVaDdzeDdQYkp5?=
 =?utf-8?B?dVFMWGRmYjNWRWQvTFY2MW9GZHpKc3pJNEdGQ1duK0J3ek53dit5YkNuODVs?=
 =?utf-8?B?bi9QOXF1WkY0WkJCWmFnUUtOZyt4ai95ZytOWGcyU1drRWtaeWZQMVNuSFZM?=
 =?utf-8?B?RW9jb1lSTnNTalRMaG5DaHV3dWh6ZVAvMEtPOGxsdGpQN2poSEMxU0lnbmJr?=
 =?utf-8?B?NXdtUGdrUVRoRHpENU90dFkzUHNoNWNRMXE0Rk9Xd1BXVHMrMExidFN2T1Ny?=
 =?utf-8?B?SlBZYVNhbDA5ZWNiV0pEbDhLMUVrVGJVcElyVEg2L21UT016M1ZxQTJKcFI3?=
 =?utf-8?B?WEdnK2VvRFBTaWhRUHNBR3Ria09OR0Y1UzFMMWRobEF4UVpsT0tHaUNmMEF0?=
 =?utf-8?B?djEzVVBiZGhuTW81SzNOZkZackUvY2RPejlYNmowSzF4VG5vOUZRNVpZWm1R?=
 =?utf-8?B?TE02TjBqcUJKaHhjK25QaTl5R1JpbVVOU2VHRERYMmI4QnVmSE9FS0FxcUw3?=
 =?utf-8?B?aks2S1UyRkUrQTVwSXdqdjBsTUhJWDFaczgyN3JSUDZlZklUQmJESTdMbW52?=
 =?utf-8?B?aXd0RUtVaGFPbTk5UGFjZzQ2TFA4cUlramNMSStxS0xKdGgveEY1ejNoY0lX?=
 =?utf-8?B?WG1tZE95RXQ0c3k4eG1RVTNwRFpSWlNLZFE4a2E0aFgxY25QaklvSHlDNnE1?=
 =?utf-8?B?R1VkZmZ4T21ZNTlSUENsaW9RaDBiR3liakswMktEZXYzaEV5dVRqNUVrZlhL?=
 =?utf-8?B?S2x5VGZ1ekpvakRZNVRhU0R2VjRKZ1hYMEc1S3B2UDhPL1lTRCtLRU9DK2hy?=
 =?utf-8?B?cEJCUUtWYVpkRlphUmhYKyt2bmFYQjErOUFkSHhzM0VNVkttTTFSQnQvaEwz?=
 =?utf-8?Q?e1iKcF/xN/MJv3WVxM+Z4uE7A19Chfv7+o?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 08:28:55.2082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 301b5b2b-ec7a-40bf-0a71-08d89a8a22c9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnff7ZLKJfVExugJ5757Hd5J8Y7kJxM3oIuqODlaNeOB/tr1JypMYW39TFRPKMQPbHyMQsLuiSRnCEHpJdW12A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5048
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On 04.12.20 19:06, Eric Sunshine wrote:
> On Fri, Dec 4, 2020 at 10:25 AM Peter Kaestle <peter.kaestle@nokia.com> wrote:
>> [...]
>> Furthermore a regression test case is added, which tests for recursive
>> fetches on a superproject with uninitialized sub repositories.  This
>> issue was leading to an infinite loop when doing a revert of a62387b.
> 
> Just a few small comments (nothing comprehensive) from a quick scan of
> the patch...
> 
> Mostly they are just minor style issues, not necessarily worth a
> re-roll, but there is one actionable item.

thanks for your comments.  A new patch will follow soon.


>> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
>> ---
>> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
>> @@ -719,4 +719,98 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
>> +add_commit_push () {
>> +       dir="$1"
>> +       msg="$2"
>> +       shift 2
> 
> We typically recommend including these assignments in the &&-chain to
> future-proof against someone later inserting code above them and not
> realizing that that code is not part of the &&-chain, in which case if
> the new code fails, the failure might go unnoticed.

ok

> 
>> +       git -C "$dir" add "$@" &&
>> +       git -C "$dir" commit -a -m "$msg" &&
>> +       git -C "$dir" push
>> +}
>> +
>> +compare_refs_in_dir () {
>> +       fail= &&
>> +       if test "x$1" = 'x!'
>> +       then
>> +               fail='!' &&
>> +               shift
>> +       fi &&
>> +       git -C "$1" rev-parse --verify "$2" >expect &&
>> +       git -C "$3" rev-parse --verify "$4" >actual &&
>> +       eval $fail test_cmp expect actual
>> +}
> 
> We have a test_cmp_rev() similar to this but it doesn't support -C as
> some of our other test functions do. I briefly wondered if it would
> make sense to extend it to understand -C, but even that wouldn't help
> this case since compare_refs_in_dir() introduced here involves two
> distinct directories. The need here is so special-purpose that it
> likely would not make sense to upgrade test_cmp_rev() to accommodate
> it. Okay.

Yes, I saw that there's a similar function and I tried to modify this 
one first.  Unfortunately this didn't work without touching much 
unaffected test code.  So I propose to continue with this additional 
function.


>> +test_expect_success 'setup nested submodule fetch test' '
>> +       # does not depend on any previous test setups
>> +
>> +       for repo in outer middle inner
>> +       do
>> +               (
>> +                       git init --bare $repo &&
>> +                       git clone $repo ${repo}_content &&
>> +                       echo "$repo" >"${repo}_content/file" &&
>> +                       add_commit_push ${repo}_content "initial" file
>> +               ) || return 1
>> +       done &&
> 
> What is the purpose of the subshell here? Is it to ensure that commits
> in each repo have identical timestamps? Or is it just for making the
> && and || expression more clear? If the latter, we normally don't
> bother with the parentheses.

It was intended to make the correlation of && and || clear.  I have 
experienced many cases in the past where things were screwed because it 
was not clearly understood by everybody.  I'll propose next patch 
without this subshell.

>> +       git clone outer A &&
>> +       git -C A submodule add "$pwd/middle" &&
>> +       git -C A/middle/ submodule add "$pwd/inner" &&
>> +       add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
>> +       add_commit_push A/ "adding middle sub" .gitmodules middle &&
>> +
>> +       git clone outer B &&
>> +       git -C B/ submodule update --init middle &&
>> +
>> +       compare_refs_in_dir A HEAD B HEAD &&
>> +       compare_refs_in_dir A/middle HEAD B/middle HEAD &&
>> +       test -f B/file &&
>> +       test -f B/middle/file &&
>> +       ! test -f B/middle/inner/file &&
> 
> These days we typically use test_path_exists() (or
> test_path_is_file()) and test_path_is_missing() rather than bare
> `test`.

ok.


>> +test_expect_success 'setup recursive fetch with uninit submodule' '
>> +       # does not depend on any previous test setups
>> +
>> +       git init main &&
>> +       git init sub &&
>> +
>> +       touch sub/file &&
> 
> Unless the timestamp of the file is significant to the test, in which
> case `touch` is used, we normally create empty files like this:
> 
>      >sub/file &&

ok.


> 
>> +test_expect_success 'recursive fetch with uninit submodule' '
>> +       git -C main submodule deinit -f sub &&
>> +       ! git -C main fetch --recurse-submodules |&
>> +               grep -v -m1 "Fetching submodule sub$" &&
> 
> We want the test scripts to be portable, thus avoid Bashisms such as `|&`. > We also avoid placing a Git command upstream in a pipe since doing so
> causes the exit code of the Git command to be lost. Instead, we would
> normally send the Git output to a file and then send that file to
> whatever would be downstream of the Git command in the pipe. So, a
> mechanical rewrite of the above (without thinking too hard about it)
> might be:
> 
>      git -C main fetch --recurse-submodules >out 2>&1 &&
>      ! grep -v -m1 "Fetching submodule sub$" &&

In general I agree, but for this special test case, it's required to 
have the two commands connected by a pipe, as the grep needs to kill the 
git call in error case.  Otherwise for this regression git would go for 
an infinite recursion loop.

Of course, we can go for a "git 2>&1 | grep" solution.


>> +       git -C main submodule status |
>> +               sed -e "s/^-//" -e "s/ sub$//" >actual &&
> 
> Same comment about avoiding Git upstream in a pipe, so perhaps:
> 
>      git -C main submodule status >out &&
>      sed -e "s/^-//" -e "s/ sub$//" out >actual &&
> 
>> +       test_cmp expect actual
>> +'

ok.

-- 
kind regards
--peter;
