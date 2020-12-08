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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C779C4361B
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F9123AA9
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 15:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgLHPwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 10:52:07 -0500
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:42119
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729558AbgLHPwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 10:52:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQopxTO06VsgmfKwaNy7euPZcaD/LOv2RK8tOcaOB+qzbflMNglfX9hs2W+6VMyMjZ0IZUpoLNNnXe2VD75P7pyc8FG68JJOzSwI13C+cCHsxt6Oe6DVnpo/UkRpBZ7mFhfpBFJYFVcVMrGtYG2i+8IflYMfthGMmALjyewYzmwqAbL927zfP1zz1dECTKC40ktT70h7QFqR0apqO2J/OcXg/sC0gHw+jr67kCS1Gc9+O1+RoKTOaHlKtxjTvuZu9qXuxUPN3H6wICGKff4KOu/Ty2gZ1TMHrGl+iuJD8IwNRWz7ZyTl9jymhhpdgYblu7YrtYgCOKCixkiSUQECjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQJSbPJJKIMrgPKy1ZxAR5xh7uoUPFq+YbhE3/CPvu4=;
 b=IAXdzPkDTsZo+tQf3NE53HXerNilvCy8VFU2Dw5doWCr/s7T0StOHKzU+/PE44ASeZi2YxEYORorluEnZ3F36il136fQO61TJ8uCTHBTxTFPPgsB2VIMuUC7b8ixTr0TuOuvTXyxrkJKFcAuwYYwQqwnH/wxE+FZ6g9Rkwocls+T3/BVmceCCB/ec1morUJoCRYtXNpcaeQ9ESgu3tq2lqVaK/1CwBzV0M7sLEtcPEBq+WfE0qt7QuMXNttUfEKnovgnRAn4oKCvcfUIsOSzI66ZrpJ0JxpquARt8CtTWq+i0B1h51c9HXg162AjE6ZN1xfp6wt1JK45ZIO1JhxE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQJSbPJJKIMrgPKy1ZxAR5xh7uoUPFq+YbhE3/CPvu4=;
 b=slpHI6ZcieYfPVrJfHyCJusta2uoXPRPPbV3+EN3CPDFtNixOSuPar7FF9YZT3yJxP2nxhf2PvDJSaFI/GJnaehxaUqU/xZ37cDaZyG9rr+h7T55K9Nkm1kWX87rpXOj8YILDayaMDHOIKpmvZJWG4p4f9rFaD76urEwz2M2kTc=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com (2603:10a6:10:19e::21)
 by DBAPR07MB6775.eurprd07.prod.outlook.com (2603:10a6:10:17f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 15:51:17 +0000
Received: from DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e]) by DBAPR07MB7030.eurprd07.prod.outlook.com
 ([fe80::fc22:a9ab:215:7d1e%6]) with mapi id 15.20.3654.011; Tue, 8 Dec 2020
 15:51:17 +0000
Subject: Re: [PATCH v3] submodules: fix of regression on fetching of non-init
 subsub-repo
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.us>
Cc:     Ralf Thielow <ralf.thielow@gmail.com>
References: <d52db91d-af6d-c93c-2c4a-e2460905623d@nokia.com>
 <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
From:   =?UTF-8?Q?Peter_K=c3=a4stle?= <peter.kaestle@nokia.com>
Message-ID: <2da143e1-d186-e87d-87e6-134c60f4428b@nokia.com>
Date:   Tue, 8 Dec 2020 16:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <1607442126-34705-1-git-send-email-peter.kaestle@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.168]
X-ClientProxiedBy: HE1PR0701CA0056.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::24) To DBAPR07MB7030.eurprd07.prod.outlook.com
 (2603:10a6:10:19e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.30.9.8] (131.228.32.168) by HE1PR0701CA0056.eurprd07.prod.outlook.com (2603:10a6:3:9e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Tue, 8 Dec 2020 15:51:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 880efa8a-ed1e-4662-88a1-08d89b9119da
X-MS-TrafficTypeDiagnostic: DBAPR07MB6775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR07MB677592A05A95CBDEB2E58FE5EECD0@DBAPR07MB6775.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVUnz6WLjMoc9sHo0uPJbAE5p1CRHnvItsUBTfsvV1Prs/U4/OH8iPjLXdCgqqe9klKafV5kYDyVN4AhvWedxeiJ2wJV3+39+CoksxZEo6mOf91WTTqKyeLDA2PizGJOCbap7ANtnHUv8qucCmVfFv4643+r/WO6EURxIOSYktc5q597ffslzUX3dAKvzB3KzEaXV8WZZSe5uFB7jbvJTt+XYuoY70b//uM8cxbjXKuytm+Pv7Z6/dsDGPLpLnw9CxzvyBcDSU4gzqTqwiguigKNdt6ljWApCZFy+aE57tky4zkBkZbyZh/eFpXmF2BpRuGU5c4KtpDCW/Ze2Yf2FTF1zNJn+iJPAQex/2lY6+QvytkKqRTIMolZAP15wF1A1sdw+3LqTRTSfZlRkGEdgc5tbt67Ok7rMtyhO2hlp/WnkTrsgSdLucioE7fAoItK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR07MB7030.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(52116002)(34490700003)(66946007)(6486002)(4326008)(110136005)(8676002)(2616005)(16526019)(66556008)(956004)(186003)(36756003)(26005)(8936002)(31686004)(5660300002)(83380400001)(508600001)(6666004)(4001150100001)(31696002)(16576012)(53546011)(86362001)(66476007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bG80R2g0bEpZR2NGUFpPOU5Ickw3QmR4cUFjTC9Gb0ZvcCtyTnQvQ0VpcE5X?=
 =?utf-8?B?L3g3T05mdHd5UkdsUk9rUi9KYjhncHRiS1lobkovOFNGankwazRUM3J1OGgw?=
 =?utf-8?B?WDM3Yk16TVlwR2dRV3IxNjM1dmZBNDAwSkZIeDl0Tm5UZGg3L3JYOGZkU3lZ?=
 =?utf-8?B?MFhqdE5VODZteXdMdGZDNHgvY0tIeDJNcVd6U2NhUk1NM3ppQVVGMmRINnBo?=
 =?utf-8?B?MXNoSTVIK1U2R3cwV2tqNWJjTFA3OTZQRlpkTzU2VHh0QTRSOTV4Ym1PY0o5?=
 =?utf-8?B?ZXlRMG1ZQzM5c1JMVWhoUVBkd3ljeGhBSHlDOWF6eG1YeE55Wm1jVWZWbmV5?=
 =?utf-8?B?bUtiLzJiS0l2UjlTblNoaDNyNHFDMFp6UTQzT2lxL1E1eVlEalk1NkRMamFT?=
 =?utf-8?B?Ymh2a3FJRDJXM2J1aUVGenppTzRQUWthYWRsaUZJMjlLREVYUVVpeU9WbFhq?=
 =?utf-8?B?T0gzSzJoK2U5QjBHQ21DWVA4NnVCTGJnRm9TMGFCcW4yYjhHaEN1UFNDSVV3?=
 =?utf-8?B?ZVRJUXhvSWlSVFI4cW1sNmRQeFBSb2NWK2ZleWw5RWo1dnhmZVJYTnJtM1JY?=
 =?utf-8?B?dm9Rc3Q5dnQyV3Mvd3Fwd3A0OHUwZGlXdkpyTGE5Mm5XeEJuZGI4eDJhZndU?=
 =?utf-8?B?VEdHZjhmQzBNWXFJbTBKOWpwSXprTEN0bFRxaElJMXRyS1M5dEQ2TFNrZVRu?=
 =?utf-8?B?RFZXR2NtTEc5V3pYdTNYT1lkdlozd3ZBanBRZU0waDFjelJxbHRtdGZXSGJO?=
 =?utf-8?B?OWNOMUl3MU9SWTA1WHA2RDB2QkJrQ2NWRGx2Ry9DNHFXR1ZtM2taSGxNeWgx?=
 =?utf-8?B?WDFSYitrK0xFcE1XY2d6OGFWUHhveDhVRER1VUlkc3V0MTF1NGR6RW5rKzBK?=
 =?utf-8?B?T2VHTVozMER4L3lkNWY3OGZEeE1xVTcxQzk5TEJVbE9sRkN2QlBDMTd2WmVa?=
 =?utf-8?B?YXlaUVdOTzBobC9OMzlaZVU0OTdGTlN4a29pN0sweTFzaTFoMkZESGVJM3l3?=
 =?utf-8?B?RUlKS0JTdDM2UUNTVVNwVWo4RnoxRkZSZ0J0RWdsNWdPZ2lmclNXQjBEb3Ju?=
 =?utf-8?B?TjBEME9lVVpCMHlwVFVVb0JJWkgvQXVXKzhWSHdEYlR0ZDlVT2tPZE40Smps?=
 =?utf-8?B?YkNCZWpWM0wzbnNoS3oxTDRFZ09vNCtDSnVDakJJdFVyV0grKzNia0gyTFZj?=
 =?utf-8?B?UHk1QVpwcEhRYldYTnZLZVFNL1ByYmpNNWVpUGVsUlM5VzAyL2FlNloyWnhB?=
 =?utf-8?B?QXo2RUo5SGlNKzZrdjVGU0FPV2c1OUFsR0U2QWJPUCtIeDdwbXdXVzFIbisy?=
 =?utf-8?Q?2W0Wpf7+nA+TzAeUU/KLOnXBIhIaO65Oh5?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: DBAPR07MB7030.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 15:51:17.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 880efa8a-ed1e-4662-88a1-08d89b9119da
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrTIPm+lzhshUubS7X85eQV9CbVAi38uU2KdKtuvqlKMLSSHXf/4JMi9y8W5mGIzsUVpZjS23u6PKJOaWLSDaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6775
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.12.20 16:42, Peter Kaestle wrote:
> A regression has been introduced by a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28).
> 
> The scenario in which it triggers is when one has a repository with a
> submodule inside a submodule like this:
> superproject/middle_repo/inner_repo
> 
> Person A and B have both a clone of it, while Person B is not working
> with the inner_repo and thus does not have it initialized in his working
> copy.
> 
> Now person A introduces a change to the inner_repo and propagates it
> through the middle_repo and the superproject.
> 
> Once person A pushed the changes and person B wants to fetch them using
> "git fetch" at the superproject level, B's git call will return with
> error saying:
> 
> Could not access submodule 'inner_repo'
> Errors during submodule fetch:
>           middle_repo
> 
> Expectation is that in this case the inner submodule will be recognized
> as uninitialized submodule and skipped by the git fetch command.
> 
> This used to work correctly before 'a62387b (submodule.c: fetch in
> submodules git directory instead of in worktree, 2018-11-28)'.
> 
> Starting with a62387b the code wants to evaluate "is_empty_dir()" inside
> .git/modules for a directory only existing in the worktree, delivering
> then of course wrong return value.
> 
> This patch ensures is_empty_dir() is getting the correct path of the
> uninitialized submodule by concatenation of the actual worktree and the
> name of the uninitialized submodule.
> 
> Furthermore a regression test case is added, which tests for recursive
> fetches on a superproject with uninitialized sub repositories.  This
> issue was leading to an infinite loop when doing a revert of a62387b.
> 
> The first attempt to fix this regression, in 1b7ac4e6d4 (submodules:
> fix of regression on fetching of non-init subsub-repo, 2020-11-12), by
> simply reverting a62387b, resulted in an infinite loop of submodule
> fetches in the simpler case of a recursive fetch of a superproject with
> uninitialized submodules, and so this commit was reverted in 7091499bc0
> (Revert "submodules: fix of regression on fetching of non-init
> subsub-repo", 2020-12-02).
> To prevent future breakages, also add a regression test for this
> scenario.
> 
> Signed-off-by: Peter Kaestle <peter.kaestle@nokia.com>
> CC: Junio C Hamano <gitster@pobox.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> CC: Ralf Thielow <ralf.thielow@gmail.com>
> CC: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>   submodule.c                 |   7 ++-
>   t/t5526-fetch-submodules.sh | 124 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/submodule.c b/submodule.c
> index b3bb59f..b561445 100644
> --- a/submodule.c
> +++ b/submodule.c

[...]


These are my test run outputs:
final_fix [PATCH v3]
==========
# passed all 41 test(s)


recursion_regression [1b7ac4e6d4]
==========
not ok 41 - recursive fetch after deinit a submodule


no_fix [3a0b884c - origin/master]
==========
not ok 38 - fetching a superproject containing an uninitialized sub/sub 
project


-- 
kind regards
--peter;

