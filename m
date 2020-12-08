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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5432CC4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134AA23AC4
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgLHOHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:07:08 -0500
Received: from mail-eopbgr80094.outbound.protection.outlook.com ([40.107.8.94]:36185
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729308AbgLHOHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 09:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y08o3UtG9+GhhlFsafgf3iZAKe3f1c+P3+yqS/vglCfD7ZTb1ZqkRtEVXwYYFTmFdQAYMGqn9ELCAkCjg/GN4Zfstq4RX3rT53NhiUwV9ydY07M1BO0URGSqM18ietxpw8kGz92PPbAVtiCXXvFQ9NTG1TEV/e/YJtW6xghhaqMchhCo2AWiTO2hge770HzEiZH6kuBlQjpkLMGOng/YE0Jw9esP4VtGzZodDPPTfUJW2xVoNTAgdhJO2Zf+zIV72/2uoMJY10QFIa2raMxP1OUKLY4gQ6hdeN7KyocNLkqQumjrMMVrJlaptvHk0nIX1OdNmg+tEh2qpj6dLvZKjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H8FYETl3sAy/anrmhdsfmPk4vyghaKUld2gGf6d1us=;
 b=hxiwgAat8Qi3NWFBcZNAX1ibo8ROCHWakNo2KY5mwuc06ekHOS48oOY4t/J5JYLsLuj1XUXxvQvdc5xy4FUjE+19rUM666Uv1FaEiC7SpY1hkSnIrWwhYV0Q21XX9zxU4G6T+QaovlxlNRdtyqeuBZN+D6XEZIpWYzxz2dQ1mTTB3Jzlrf69pQX7HVq2JF3Iv+hujK2eqv8PhLTGhQTXYKpY5V6BImCa6OEYWD1HbKBepH+NnuvaIIlf8XX6PuEGCyljNkZQd2GOWnFjsPAYwmlygWGUz6TMpMAtlh7TAI2LM7NAAIdsDOw7hH8v8jWs/rJWZv3lV8mIhioC1iZ37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H8FYETl3sAy/anrmhdsfmPk4vyghaKUld2gGf6d1us=;
 b=X/iQ50CkOGaVDC0ljgyZjBiBKQUcEmaxnJ/4niefcQUqTFJ3Ow1no3bY8cSP5X4rtgcjdIjXro8YLckKa0gYxJ9fgBLX/hfJkdNsFLBl/3GQ233QgXCqEfDafhMxAB0UroIAVLtFM6VCTPqE0A7Vo7KFSu0ikomEer7OF7QcXFg=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB6PR07MB3221.eurprd07.prod.outlook.com (2603:10a6:6:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7; Tue, 8 Dec
 2020 14:06:18 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Tue, 8 Dec 2020
 14:06:18 +0000
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
 <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
 <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <1f0422a1-f6e7-8044-ed53-c9496fbd1ccb@nokia.com>
Date:   Tue, 8 Dec 2020 15:06:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <613FAD04-0D5A-4DE0-8FE8-0C5C5619B7BC@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: AS8PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::8) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.6] (131.228.32.166) by AS8PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:20b:311::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 14:06:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25fa5804-37ed-4566-81d9-08d89b826f34
X-MS-TrafficTypeDiagnostic: DB6PR07MB3221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR07MB3221B4779442E8109F133A60EECD0@DB6PR07MB3221.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35GnWq5r3R75XajHy0fveF879Oc1EJ71H7wBrSt6mTcxXbddk5aTdBrCQcf3EGV6QxKoi5nImXD13XriKqFjDp+5fQltVa3iad/F+SrEuB6w67VorrYhr4AIYLjtmPee8AWzmNAaztbc5pgsAg1hFVM06RDgSABWz+sqDz5oyJ6j4wIg2leltwf7b+AGgvXUVY0f131nGHxzooYYu87e8ynkvtlZTl95wuP39/eTwS2D+nqkXtSBnrKAm1r5kVZnEYCqJdm0lh7mFVymIfhUofdtkFTxdpC96cWqVIo+f6c+rBl9lbeGnUjvBZnvsY5LCu+BFKwYMHNQRTDYndmzy36TNIORxvwP7aBNMcrRvRYMM+B5tyvbvU56a42OIoZtSmBJCbcE9uB5CriJ2lSgV5Tyv9GNqDMRn6028VEJEd35W0LRLkwFlrUHIrya2EMj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(52116002)(5660300002)(2906002)(26005)(508600001)(8676002)(8936002)(956004)(16576012)(86362001)(66556008)(66476007)(66946007)(2616005)(4326008)(36756003)(186003)(6486002)(34490700003)(53546011)(31696002)(16526019)(4001150100001)(83380400001)(6666004)(31686004)(6916009)(54906003)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SysyUVJRaXVoQmFtN1FXQnAyZitXK283dHIrd0RZTzE5K1RWTFNrR1hTeEVT?=
 =?utf-8?B?aGNWTWVhZFhQd0NjRVZyc3RocWl1bm9nQm1UVzd0dXR6WitrUjU3ZDBxTzlZ?=
 =?utf-8?B?QTV1RnY1VDliRjM2Vi9FWkZabUlscE5BQThZQ2pEUHdaSk52RjBMRHo1UzlL?=
 =?utf-8?B?MUt0akdrNFc5dEl2YmhzcFpNaC92bGkwY2UxdEhNVjdrVzkzeWEwSUE3bHJp?=
 =?utf-8?B?SzByWERwZ01Bakg2YmFZZW5MYVZ6aGpGaElFZCtCclljWFVUYm1rTU9vbllE?=
 =?utf-8?B?Ni90VjByMDNjd1pkOG92bnJIcUJzc2RNVFRuSnk5ZkhxVmdRT1JHaHJLcDU5?=
 =?utf-8?B?ZnFJS2lSbUJaelBZb2paOElyNU9Za3pxNEZxZDE5a0VrQi9TSTlZYWpQTFBE?=
 =?utf-8?B?S0ErcmVmZ2JwNjJRWVNTSVVzb0lhRCtGOVcrbTk1K2VRS2twRWFPdlRlY0Jq?=
 =?utf-8?B?Zk1lSDhTMXlmT016eWduUkIwWWRrRmVJcE1QSDJLbzI1d1lCQittQldNYzJI?=
 =?utf-8?B?Rlo4NGhPUjU0NCsrS0tUUmhLeGJhYUsreTFjSVFJN2dyK2ROaHJ3cWhJYVkv?=
 =?utf-8?B?b29DQVpHYUIzR0JhV1k0VVg1V3FBajB6UWhKaGhNZE9vTWdITmYxdTEzSk11?=
 =?utf-8?B?N1ROTGFpRFlJTlV6YVl1a293b1kzdGVzSjBodmIzN3kycmd4YS9IaWUvVFJk?=
 =?utf-8?B?YTBqREU3QS8yeHJoOWEwclZ2dGNxdCtNNzJQSEc0bDRyTE1LeGhWeWdJKzEy?=
 =?utf-8?B?Q283VlRuODJwWHJpYTVGN2x0ekFRNU5WeDlicFF3SVNjRGt6S1QycW83NytN?=
 =?utf-8?B?UUJaRHkxV0ZKeDk2c0JNN29UUE9Vd0diRi9rR1gwbk05Ujh4K0VXbEZqZzFa?=
 =?utf-8?B?SXFIcDZhbkdoMkhuRTcxSjkwZjRReCtPZnJPVlVtYnNxc0EvTFh6a0JGNlFC?=
 =?utf-8?B?cklRNGFFMGNBL0NkMTFiQVY0SkU0ZzhMKzlyK01MWlRZOXdlalNJNFN2NjY5?=
 =?utf-8?B?RHBvRGMwa1E3aGsxS0lvUjVEV3BWbjZEa1VlK0tjOGMwL0FjdmVzdEdjbndP?=
 =?utf-8?B?TWpyNkJpdmF5QzFlUTFZemRsUkhVSmsvdVgra21yTDVxMk05c1p4VWQ3ak9j?=
 =?utf-8?B?WVZXSUFnY2QvVUpEcWlmNnR1eU9kVnRMLzNyM0ZocGtQaGRVelNicndRNUh3?=
 =?utf-8?B?ckdTZkJ5SkhlRk9oT0thaXh1TEJ0Umw2WTIvc01tbUQ2ZXZjbCtrcW9RY0R1?=
 =?utf-8?B?OG1jbndDZDcrYi9YVjVWNnNPM3JEOERnS2VaWG85OWs3NlloZGsrOEx5dXdJ?=
 =?utf-8?Q?w250KIAKHQMaD0LXrHMO9BY6gLK6hzJGU1?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 14:06:18.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fa5804-37ed-4566-81d9-08d89b826f34
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7X36BDsVEdwTwLDfGXq9hZUbzfzKfuGwYn3ejENfg4Y331P5sAYB5GpPOwZR1cdD8qTQ4JMMPxX9+gQzUwKvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3221
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.12.20 19:42, Philippe Blain wrote:
> Hi Peter,
> 
>> Le 7 déc. 2020 à 08:46, Peter Kaestle <peter.kaestle@nokia.com> a écrit :
>>
>> A regression has been introduced by a62387b (submodule.c: fetch in
>> submodules git directory instead of in worktree, 2018-11-28).
>>
>> The scenario in which it triggers is when one has a remote repository
>> with a subrepository inside a subrepository like this:
>> superproject/middle_repo/inner_repo
> 
> The correct terminology is "submodule", not "subrepository".
> 
> Also, (minor point) I would just write "when one has a repository",
> as its simpler (the repository by itself is not "remote", it is only "remote"
> in relation the repositories that are cloned from it).

ok.



>> Person A and B have both a clone of it, while Person B is not working
>> with the inner_repo and thus does not have it initialized in his working
>> copy.
>>
>> Now person A introduces a change to the inner_repo and propagates it
>> through the middle_repo and the superproject.
>>
>> Once person A pushed the changes and person B wants to fetch them using
>> "git fetch" on superproject level,
> 
> s/on/at the/

ok.


>> B's git call will return with error
>> saying:
>>
>> Could not access submodule 'inner_repo'
>> Errors during submodule fetch:
>>          middle_repo
>>
>> Expectation is that in this case the inner submodule will be recognized
>> as uninitialized subrepository and skipped by the git fetch command.
> 
> here again, terminology: "as an uninitialized submodule"

ok.


>> This used to work correctly before 'a62387b (submodule.c: fetch in
>> submodules git directory instead of in worktree, 2018-11-28)'.
>>
>> Starting with a62387b the code wants to evaluate "is_empty_dir()" inside
>> .git/modules for a directory only existing in the worktree, delivering
>> then of course wrong return value.
>>
>> This patch ensures is_empty_dir() is getting the correct path of the
>> uninitialized submodule by concatenation of the actual worktree and the
>> name of the uninitialized submodule.
>>
>> Furthermore a regression test case is added, which tests for recursive
>> fetches on a superproject with uninitialized sub repositories.
>>   This
>> issue was leading to an infinite loop when doing a revert of a62387b.
> 
> I would maybe add more details here, something like the following
> (we can cite your previous attempt, because it was merged to 'master'):
> 
> The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:
> fix of regression on fetching of non-init subsub-repo, 2020-11-12), by simply
> reverting a62387b, resulted in
> an infinite loop of submodule fetches in the simpler case of a recursive fetch of a superproject with
> uninitialized submodules, and so this commit was reverted in 7091499bc0 (Revert
> "submodules: fix of regression on fetching of non-init subsub-repo", 2020-12-02).
> To prevent future breakages, also add a regression test for this scenario.

Jip, I like that.


>>
>> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
>> CC: Junio C Hamano <gitster@pobox.com>
>> CC: Philippe Blain <levraiphilippeblain@gmail.com>
>> CC: Ralf Thielow <ralf.thielow@gmail.com>
>> CC: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>> submodule.c                 |   7 ++-
>> t/t5526-fetch-submodules.sh | 104 ++++++++++++++++++++++++++++++++++++
>> 2 files changed, 110 insertions(+), 1 deletion(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index b3bb59f066..b561445329 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1477,6 +1477,7 @@ static int get_next_submodule(struct child_process *cp,
>> 			strbuf_release(&submodule_prefix);
>> 			return 1;
>> 		} else {
>> +			struct strbuf empty_submodule_path = STRBUF_INIT;
>>
>> 			fetch_task_release(task);
>> 			free(task);
>> @@ -1485,13 +1486,17 @@ static int get_next_submodule(struct child_process *cp,
>> 			 * An empty directory is normal,
>> 			 * the submodule is not initialized
>> 			 */
>> +			strbuf_addf(&empty_submodule_path, "%s/%s/",
>> +							spf->r->worktree,
>> +							ce->name);
>> 			if (S_ISGITLINK(ce->ce_mode) &&
>> -			    !is_empty_dir(ce->name)) {
>> +			    !is_empty_dir(empty_submodule_path.buf)) {
>> 				spf->result = 1;
>> 				strbuf_addf(err,
>> 					    _("Could not access submodule '%s'\n"),
>> 					    ce->name);
>> 			}
>> +			strbuf_release(&empty_submodule_path);
>> 		}
>> 	}
> 
> 
> Maybe a personal preference, but I would have gone for something a little simpler, like the following:
> 
> 
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..4200865174 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1486,7 +1486,7 @@ static int get_next_submodule(struct child_process *cp,
>                           * the submodule is not initialized
>                           */
>                          if (S_ISGITLINK(ce->ce_mode) &&
> -                           !is_empty_dir(ce->name)) {
> +                           !is_empty_dir(repo_worktree_path(spf->r, "%s", ce->name))) {

I'm not deep enough into the git code to judge which approach is the 
better one.  From my perspective, being a foreigner to the git code, I 
like my proposed code more, as for me it's much easier to understand 
what's happening by having a meaningful variable name and without being 
forced to dig into outer functions first.
Also Junio C Hamano <gitster@pobox.com> is having some concerns, which I 
can't judge:

> But then you leak the return value from repo_worktree_path(), no?

Thus for v3 I'll stick to my proposal and when you'll review it, please 
discuss with each other whether I should go for a v4 using 
repo_worktree_path().

[...]

>> +
>> +test_expect_success 'setup recursive fetch with uninit submodule' '
>> +	# does not depend on any previous test setups
>> +
>> +	git init main &&
>> +	git init sub &&
>> +
>> +	>sub/file &&
>> +	git -C sub add file &&
>> +	git -C sub commit -m "add file" &&
>> +	git -C sub rev-parse HEAD >expect &&
>> +
>> +	git -C main submodule add ../sub &&
>> +	git -C main submodule init &&
>> +	git -C main submodule update --checkout &&
> 
> These two steps are unnecessary as they are implicitly done by 'git submodule add'.
> I think we could reflect real life a little bit more by cloning the superproject, and running
> the 'recursive fetch with uninit submodule' test below in the clone.

Yes, you're right, "...init" and "...update..." can be removed.


>> +	git -C main submodule status >out &&
>> +	sed -e "s/^ //" -e "s/ sub .*$//" out >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'recursive fetch with uninit submodule' '
>> +	# depends on previous test for setup
>> +
>> +	git -C main submodule deinit -f sub &&
> 
> Here you are deiniting the submodule, such that
> the Git directory will stay in .git/modules/sub. This is not the same thing
> as a submodule that was never initialized ("uninitialized"), for which .git/modules/sub
> will not yet exist. So maybe we could harden the tests by also testing
> for that scenario ? I don't know... maybe the infinite loop only happens
> if .git/modules/sub actually already exists. If so, the test name should be
> "recursive fetch with deinitialized submodule", I think.

I added another test case for v3, which checks for this in case of never 
initialized submodule.  When executing the test, I can see that the 
infinite loop regression only occurs after doing the init followed by a 
deinit.  Thus renaming the test accordingly.

-- 
best regards
--peter;
