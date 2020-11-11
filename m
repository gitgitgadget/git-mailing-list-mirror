Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFCC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CAA2068D
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 12:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Rj6NHViB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgKKMqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 07:46:50 -0500
Received: from mail-eopbgr60106.outbound.protection.outlook.com ([40.107.6.106]:39680
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgKKMqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 07:46:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7qp9Q60QyOlWpPXC+ypLz1ZnJP0QLCdHTs0IsSysQ1J0qZeLOyDbw30SvMCL5QEC8ejMFlQe9t0UI0oR5xJb5jPAFun6x3w4yWAAOuB+iX4UuqLGVYycxVO9STDWqruG0O0r0AgWfjszwwcRH/lKeSB39LCuLiscvqfU+qEImk2MSUi89A0+j6jywcMdVzQ0U3SvTWUFNsCYQGirLFyj276HO4nK0cjSAgDj6q67xMTGf77/6HmPnXIat+T4+iq1I9bylQ4QTY+Bb1B4S772seYvcxGQn8iWddVapmCrPEKfpA/Beu2HkVdx8YT/yKp1u2f1LTGMnQkHj/UIQmjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckfWOTNHNQ2EVTShOaluWgYOnQQ9zPZKe8U+WqmRecA=;
 b=gbnERpd56fZ7lm7+ZQTiCsrbW4wP3xG0Vvt5jLEAp8tzzKhpbECp9aY6Go88Rwy7I+GXUPBeyWvtwzCnjS3my1SWWz6z3TX1FFRvz0yF9ytfwfbFsXZLv6qrd2ITjbpHJi3gnYj61ppqY8GSTyrKS56x//Kd8WG6WwUJP9j5vSn2LltNvqEssAtK4vzAFHvY/7SaymqmY/EHbKgYskCHPS8ekknbp/7YeRQXYVYGOhwKtKMdr8r4QQTGin5xlkQpTzpgq+hOddim8Obpw29wVngBzDotA6GbkemynBn6qG3eaz2rvEG+5bvgoFSFr8L8aYATVlrSlaf7c9xtSInGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckfWOTNHNQ2EVTShOaluWgYOnQQ9zPZKe8U+WqmRecA=;
 b=Rj6NHViByYoNzd3R3WWCJxc0kpLXKb+WjGhEtc1Ueu7GrOwPcRP1HMfojARJDaNZz1JHN+VFKCESARNQw5N8rsp+pEq0xaupX7lB6J8a+g/29U8yhb98kx9jhNgw4NO+4ZNaXpCxco5OtxALhyWhCM9g9uxk5IdepZVEKV8up/Y=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DB6PR07MB4198.eurprd07.prod.outlook.com (2603:10a6:6:4b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Wed, 11 Nov
 2020 12:46:46 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::4902:5fe2:165e:c51f]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::4902:5fe2:165e:c51f%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 12:46:46 +0000
Subject: Re: [RFC 1/2] submodules: test for fetch of non-init subsub-repo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
References: <1604413399-63090-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-1-git-send-email-peter.kaestle@nokia.com>
 <1604910829-49109-2-git-send-email-peter.kaestle@nokia.com>
 <xmqqk0uuct94.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <c4741382-5662-ac15-24da-218b28ae9dee@nokia.com>
Date:   Wed, 11 Nov 2020 13:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <xmqqk0uuct94.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: CH2PR14CA0005.namprd14.prod.outlook.com
 (2603:10b6:610:60::15) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.7] (131.228.32.167) by CH2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:610:60::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Wed, 11 Nov 2020 12:46:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18ff563e-f83b-44e7-1bb6-08d8863fd953
X-MS-TrafficTypeDiagnostic: DB6PR07MB4198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR07MB4198227D5C938F1298C1942FEEE80@DB6PR07MB4198.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QswaGg2XyTHRiG9edrbukq3CjCGszLhtOyuc9KOleKpNNRIYOcfu4JPzvKEGi4csDFZtYfs6vsf2PvDz8zEbdAplj5mMPqmn7NLPrtVAqrdhB/v4C5P7JYvsLNpl3a2wwdG3Eyi03ZrDLh54YX7zxY4krgyqnyZhy6MDM02ukS9kN4af9LTT4h/1XoZzNDYQHA+iRDNleSyygaltkbr3owt2NHaLre3oyzvPoff2ukT4KQw3Y0DgZ/HQDNDTCCLbaNtnYdt8CYNP4juKkB2wPIMDuSdyIKofLCmi8rU9x5Yp81cUUYVVb07WI1Yn7OaK2/7hvFyS87uwJpdoQTNawgnIv7e8b2YtmjurIHfB3+5jI9EaYHzhdLzq5aHj1DE7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(66556008)(4001150100001)(66476007)(26005)(186003)(8676002)(83380400001)(66946007)(36756003)(16526019)(53546011)(6916009)(31696002)(6486002)(4326008)(30864003)(16576012)(478600001)(316002)(5660300002)(86362001)(956004)(31686004)(2906002)(2616005)(52116002)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: sNipL476WsqWJbGcHtdFM/ge9u4w/HzSh+Z89FidyqRAdlR1TYqK+6AkCPtAAuzj/x24apYU8S49qY3R5y4h4uLZHc22rgUeS5CQE01Qq6ExGMx4EEHrdORDCuVW4SBIomM2VhVrDNV5Sj11jU8rQiICzeX/2xKKF7VyZT0nipfERaR9jRBow7/8lW0zCxzqjB/EmsrRCyLzH+kQqfuULr0rYGTNY0ujIPRgxU8DCnmz2xmLRcj85zZxpDSzrmlY1sBgCC4ROQrHHLeR77eKXDbw0wZAYjBM8N7PTwmvEPZiRIav2i6ebp1PhxoLmUx76lEi9jn2FzQYlCQ2ceULMIH12RxpNoaFkdl9Y0zu//8MYM2evWoT3q6ZtYksNVLsG20voKPzv5KdKtAkhePwJiA71exxkSbGL0ta0Mn0q+5yo3H6b/Lt0wzR1tNZsVrMnSTQ7ipW1PghRz5+BaB5Rl2bVERmDWSg56TzrLcLdwZPX3/kQfNdN6nNGbnI3GUYozXDeF8zlcu5iFe0JS9Lms7693aBR13F3JM4Zlt3A9AOEMiZh5JXJJCNs392gGh9SEsbKsAvzsYtsRnZ9swPMOaVdpmbabke/g8Q1ZcXh4uKCktMYNm7mOxdcFz5Kc7KR870P51O5agVmVVy3I0FMt7dXViZ0nt7rBeEGreSaSrhE+cm+M0brLoAaUwC3NBDVHadainB6YsX5npB6KByJae2235KT9bsjj1isuXQWsSlFVm/m10YxdKnNkTyLdr5lObj/h4Q0pPTcRQthi9mIlVtLg4x0D8WNnzAOsiIuMxBHbqGP2WXYsv4ZMfCSiHJ802VGUYHaT7YoZs+yyEjU8IURT5xpRTeiK9zUMRVxDbzBDl63jJjrELvSrdaZ2eHDJUOTnc14BHgfyZrbEirMA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff563e-f83b-44e7-1bb6-08d8863fd953
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 12:46:46.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYr4BtjcC+bt9h/09Vl+Wqsxmiz10tuW1Yhq4ZA+pOYMVjgMeZvMto5EovOIhjpMfbUdE8PkfI+puoeVsNMSvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB4198
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.11.20 18:52, Junio C Hamano wrote:
> Peter Kaestle <peter.kaestle@nokia.com> writes:
> 
>> This test case triggers a regression, which was introduced by
>> a62387b3fc9f5aeeb04a2db278121d33a9caafa7 in following setup:
> 
> Minor nit.  Please refer to a commit like so:
> 
> a62387b3 (submodule.c: fetch in submodules git directory instead of in worktree, 2018-11-28)
> 
> That is what "git show -s --pretty=reference" gives for the commit.
> 
> If you have older git, "--format='%h (%s, %ad)' --date=short" would
> work.

Thanks for this hint, this is really useful.


> Instead of saying "if you follow this complex thing, it breaks and
> it is a regression at there", please describe it as a regular bugfix
> log message.  Describe the set-up first, explain the operation you'd
> perform under the condition, and tell readers what your expected
> outcome is.  Then tell readers what actually happens, and how that
> is different from your expected outcome.  Additionally, tell readers
> that it used to work before such and such commit broke it and what
> the root cause of the breakage is.

hm... I did do this in the cover letter, maybe you missed it or I was 
not able to express myself good enough there.
Anyhow, I'll add it to the commit messages, which goes into the log.

Here is my proposal for a new commit message of the test case:

----8<----
A regression has been introduced by 'a62387b (submodule.c: fetch in 
submodules git directory instead of in worktree, 2018-11-28)'.

The scenario in which it triggers is when one has a remote repository 
with a subrepository inside a subrepository like this:
superproject/middle_repo/inner_repo

Person A and B have both a clone of it, while Person B is not working
with the inner_repo and thus does not have it initialized in his working
copy.

Now person A introduces a change to the inner_repo and propagates it 
through the middle_repo and the superproject.
Once person A pushed the changes and person B wants to fetch them using 
"git fetch" on superproject level, git will return with error saying:

Could not access submodule 'inner_repo'
Errors during submodule fetch:
         middle_repo

Expectation is that in this case the inner submodule will be recognized 
as uninitialized subrepository and skipped by the git fetch command.

This used to work correctly before 'a62387b (submodule.c: fetch in 
submodules git directory instead of in worktree, 2018-11-28)'.

Starting with a62387b the code wants to evaluate "is_empty_dir()" inside 
.git/modules for a directory only existing in the worktree, delivering 
then of course wrong return value.
---->8----


About the revert of the a62387b commit, which I proposed in the second 
patch, I'm not sure it's the right way.  The revert was simply my quick 
approach to fix it.  As I'm not fully aware of what the idea was behind 
handling the submodules inside .git/modules instead of the worktree, I 
don't know whether this is the best solution.  Maybe rethinking the 
whole get_next_submodule() algorithm or simply fixing the is_empty_dir() 
to use the worktree path will be a better solution.
--> We should discuss about this.


> What commit the set-up was broken is also an interesting piece of
> information, but it is not as important in the overall picture.
> 
> Also, it probably is a better arrangement, after explaining how the
> current system does not work in the log message, to have the code
> fix in the same patch and add test to ensure the bug will stay
> fixed, in a single patch.  That way, you do not have to start with
> expect_failure and then flip the polarity to expect_success, which
> is a horrible style for reviewers to understand the code fix because
> the second "fix" step does not actually show the effect of what got
> fixed in the patch (the test change shows the flip of the polarity
> of the test plus only a few context lines and does not show what
> behaviour change the "fix" causes).

Ok, will deliver the test and the fix proposal in a single patch.


>> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
>> index dd8e423..9fbd481 100755
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -719,4 +719,42 @@ test_expect_success 'fetch new submodule commit intermittently referenced by sup
>>   	)
>>   '
>>   
>> +add_commit_push()
>> +{
> 
> Style.
> 
>      add_commit_push () {

ok.


> cf. Documentation/CodingGuidelines.
> 
>> +	dir="$1"
>> +	msg="$2"
>> +	shift 2
>> +	git -C "$dir" add "$@" &&
>> +	git -C "$dir" commit -a -m "$msg" &&
>> +	git -C "$dir" push
>> +}
>> +
>> +test_expect_failure 'fetching a superproject containing an uninitialized sub/sub project' '
>> +	# does not depend on any previous test setups
>> +
>> +	for repo in outer middle inner
>> +	do
>> +		git init --bare $repo &&
>> +		git clone $repo ${repo}_content &&
>> +		echo $repo > ${repo}_content/file &&
> 
> Style.
> 
>      echo "$repo" >"${repo}_content/file" &&

ok.


> cf. Documentation/CodingGuidelines.
> 
>> +		add_commit_push ${repo}_content "initial" file
> 
> If any of these iterations, except for the last one, fails in the
> loop, you do not notice the breakage and go on to the next
> iteration.  You'd need "|| return 1" at the end, perhaps.

yes, I definitely missed that.


> So far, you created three bare repositories called outer, middle and
> inner, and each of {outer,middle,inner}_content repositories is a
> copy with a working tree of its counterpart.
> 
>> +	done &&
>> +
>> +	git clone outer A &&
>> +	git -C A submodule add "$pwd/middle" &&
>> +	git -C A/middle/ submodule add "$pwd/inner" &&
> 
> Hmph.  Is it essential to name these directories with full pathname
> for the problem to reproduce, or would the issue also appear if
> these repositories refer to each other with relative pathnames?
> Just being curious---if it only breaks with one and succeeds with
> the other, that deserves commenting here.

Haven't tried that as the case was intended to simulate an environment, 
where one has remote repositories.  And with remote repositories, you 
have an url, which is kind of absolute path.  When reading the failing 
code, I doubt that it really matters.


> So far, you created A that is "outer", added "middle" as its
> submodule and then added "inner" as a submodule of "middle".
> 
> Although it is not wrong per-se, it somehow feels a bit unnatural
> that you didn't do all of the above in the working trees you created
> in the previous step---I would have expected that middle_content
> working tree would be used to add "inner" as its submodule, for
> example.

Not sure I got your concern, maybe it helps you to understand when I add 
this scenario description which we want to mimic:
The "bare" repos outer, middle and inner are created by an administrator 
on a remote server.  Person A is preparing the split of the sources for 
all the other users working in the environment by adding the submodules 
the way which is specified by the software architecture we intend to 
develop in.


>> +	add_commit_push A/middle/ "adding inner sub" .gitmodules inner &&
>> +	add_commit_push A/ "adding middle sub" .gitmodules middle &&
> 
> And then you conclude the addition of submodules by recording each
> of these two "submodule add" events in a commit and push it out.
> 
>> +	git clone outer B &&
>> +	git -C B/ submodule update --init middle &&
> 
> And then you clone the outer thing (which does not recursively
> instantiate) from A, and instantiate the middle layer (which does
> not recursively instantiate the bottom later, I presume?)

Yes, Person B is cloning into the outer layer without recursively going 
into all the submodules, just initializing the ones, which he is 
expected to work on.  In the tests scenario he's only working on the 
middle layer, but not on the inner one.


> I _think_ the state here should be minimally validated in this test.

Of course we could do so.  My intention was to keep it focused on the 
one thing which we needed to test.  Namely the fetch of an outer repo 
with an uninitialized sub-sub repo.


> If you expect 'outer' and 'middle' are instantiated, perhaps check
> its contents (e.g. do you have a thing called 'file'?  What does it
> have in it?) and check the commit (e.g. does 'rev-parse HEAD' give
> you the commit you expect?).  If you expect 'inner' is not
> instantiated at this point, that should be vaildated as well.  If
> anything, that would explain what your expectations are better than
> any word in the proposed log message.
> 
> In any case, i presume that up to this point things work as expected
> with or without the "fix" patch?  If so, the usual way we structure
> these tests is to stop here and make that a single "setup" test.
> Start the whole sequence above like so, perhaps.
> 
>      test_expect_success 'setup nested submodule fetch test' '
> 		...

Ok, got it, will refactor.


> And then the "interesting" part of the test.
> 
>> +	echo "change on inner repo of A" > A/middle/inner/file &&
> 
> Style.

ok.


>> +	add_commit_push A/middle/inner "change on inner" file &&
>> +	add_commit_push A/middle "change on inner" inner &&
>> +	add_commit_push A "change on inner" middle &&
> 
> So you create a new commit in the bottom layer, propagate it up to
> the middle layer, and to the outer layer.  Are these steps also what
> you expect to succeed, or does the "regression" break any of these?
> If these are still part of set-up that is expected to work, you
> probably need to roll these up to the 'setup' step (with some
> validation to express what the tests are expecting). From your
> description, which did not say where exactly in this long sequence
> you expect things to break, unfortunately no reader can tell, so
> I'll leave the restructuring up to you.

Yes those steps are also expected to succeed, it's just important that 
the initial clone of B happens before those pushes.  For your proposed 
restructuring this could also go into the setup step.  Leaving only one 
single command for the actual test to fail:


>> +
>> +	git -C B/ fetch
> 
> And from B that was an original copy of A with only the top and
> middle layer instantiated, you run "git fetch".  Are you happy as
> long as "git fetch" does not exit with non-zero status?  That is
> hard to believe---it may be a necessary condition for the command to
> exit with zero status, but you have other expectations, like what
> commit the remote tracking branch refs/remotes/origin/HEAD ought to
> be pointing at.  I think we should check that, too.

Checking for return code is the one thing which catches this regression, 
but checking whether all the repositories are at the correct HEAD is 
another thing which we probably want to have in for testing future 
changes on the respective part of the code.  Will add it.

Thank you very much for all the comments, I learned a lot by processing 
through them.  I'll send a patch v2 soon.

-- 
kind regards,
--peter;
