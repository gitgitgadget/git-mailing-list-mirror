Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129AC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDFE610FC
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 18:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbhDPS11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 14:27:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhDPS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 14:27:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GIFdWJ135599;
        Fri, 16 Apr 2021 18:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=eJSGNn0sVMl9OBF+2T85Hezlqd17n7SJe9S03328S+0=;
 b=HM0nCW/k8Bem7ksCWRINZV9AsElMVONYIFGCuCZidTZbGdM5qB/4YJq0dRcKSxmc4WzD
 +eWDzm0H3vfD4/fGAXrAsXLGaoB2Pi6RDAu4dK7w9zoiF8mU2iBUQYav42z+tjPguvwI
 zZQ+iFvkED7muueKoen7dBoaxniYVmDG/97/sbtGNn128dDcpHn6+ScgHd7A+v9sLR0w
 mX1URsNRMpipua20ouCa/vrCNetF46kPbojnKO/iJP9fg0n5hQwwQYnuQLPRkRo+lGtO
 s7XAcIzlweplTnrSaCA+DgNPnCVT873XFf6feLsV6PA6XfxiY9Uj2IkFy5CWGSJEzvrk Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nnsy5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:26:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GIEZK5067356;
        Fri, 16 Apr 2021 18:26:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3030.oracle.com with ESMTP id 37uny31r6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMfQnBwMuhvdOvE5S92hKefKm0R6o1GZ5tvSdb1R4kZ33/BhTRvFLgeYr+fWsyANijwDsBYS0/Spugrki+Onaxlfqf7AV1cq/nLUF0Xzqr7asvvk4e25aE3NGM7mqU/G+BrKTVpLpmGb3aQj2aBhHs5cQrizlQXnc0bw3fO0tH2lfQ7mNV3tkqh6Xx/78pc70UDB0xw2dplsWXIz4Lv98riBeUbKV+eIowK0A77wPRjcWj4enC0Lq2rJBWbNvtwh/6kFy6ABrvD1dhZjS7GHEVaKQ7JPB0KpNPCZZl9i1/wZkvePeY0V6PcJGa8qfc9c7ON4ybs0oLl+t741YCZ0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJSGNn0sVMl9OBF+2T85Hezlqd17n7SJe9S03328S+0=;
 b=JX2LG44mhfLJYOKK+TZ1PV2aDyWX3i080tQ8hmTmi5rOR4ffWQtSaYjA4UlsdjuuYC0mx8VRKzufZByrFElpoeeLW6gFmyGMeWRvdSokCrmUHlz9KQXKUEtRvZuGag/enBxhn8fgH9M5L3j7vs5B/hOyGIjFqE+0GclQZ/azPOn4gPWKoRgYVaWxI3I+xOefaLE4YYaiBglYbH2HQWvCSGTJhq5Ch/I1jGtH5GEY5RplzHwhMsc4Nj8FXV9JqyxiRO/jGWHK9Y9S5WWOY+vyMK0DyW62pJXivb/wmRixgrwPJB4+CKV1WXB3Vsrl7f4i3GXdj5tV1VBVNHsBwK071w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJSGNn0sVMl9OBF+2T85Hezlqd17n7SJe9S03328S+0=;
 b=xh99cCeGt3gkrWjI8nCqcom5JTvDZetOBM4dWpmas/tYBoYDqMatfvieQonkVHlraUvQDDf2VHcTEyoKNHAN7LTQFuTgdxZTqpwIOSu5IW+Xtq51bdb/mmdlfiLD+AlleuxXHpc4JvqG7BRjDBww+YIGff9cJszUQNPPmljjJpk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB3477.namprd10.prod.outlook.com (2603:10b6:a03:128::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 18:26:42 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 18:26:42 +0000
Date:   Fri, 16 Apr 2021 13:26:35 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/4] fetch: add --prefetch option
Message-ID: <20210416182635.wldgozqybdp7y5hw@tsaeger.oracle.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <73b4e8496746a3d1387e568a5a898c02ec81df76.1618577399.git.gitgitgadget@gmail.com>
 <20210416175214.lysy3amsb7urj3ix@tsaeger.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416175214.lysy3amsb7urj3ix@tsaeger.oracle.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tsaeger.oracle.com (70.114.130.219) by SN6PR08CA0012.namprd08.prod.outlook.com (2603:10b6:805:66::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 18:26:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05984a8f-b869-47c8-0445-08d901052eee
X-MS-TrafficTypeDiagnostic: BYAPR10MB3477:
X-Microsoft-Antispam-PRVS: <BYAPR10MB347728E1EF67CE79789B96AFFC4C9@BYAPR10MB3477.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3PREJmsr7FSG6c9NAIW/s+n2MKceiZqpumVsVOFJhX8/0410fTG3owhXZPic6/3DKcx5+C4hW5/KWZU4ccDGUCuOQaE5ckwYZy9bjkTh0hrtNZFKjMeGaaYE0/iYfJn74gpiyM6xAW0AdPRy6Vkz8fNfvlMLYvIAiY1jmOBfGh4kJd3kz5c32rsZx+l/RP3Hi/Dgdy0xRdRLnJmNulf1p5LUwnW17qXId4KmpQAxAJ1nQnjDB6TAGik6kJKnTCBjuNkY3R6/GAqply+S8/TVK/KP8rtc5oGAUm4i4PUEG/kum67OhS+0b8JnrW8o/akWEtB9LRyRReAT8oBJ4Wk5elz4qpyGnbzQ912nCaVh1EYstsnzM4IsKUBHv9oqdXFiJ95aetY94WDnHO7SgE9xBi9XusLqcoofMxdxlTe9KoIua5goE5+Af+C0KO5zAJ1pwePPNGXnYWFRPvDEuhzGlTJmlDAO3rhYmMqZg7m4Bun3rXbC4cjGL+vOU3eTPyDDRW/r6uE0AcUSntZZxylnSws3qjubGlvY7Exvt+1LqaPzWQ3ryWn7F8mjsYRTHK92n1rThNTGMn1Q08RMcP0SG0Ha6xrLkbic9MySTxOnEUxT1g6qfLHFFCqFAOhJ/TR+3yzGMMS1AFb8HfUV/QVDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(376002)(396003)(136003)(7696005)(186003)(8936002)(1076003)(16526019)(7416002)(508600001)(6916009)(956004)(26005)(55016002)(52116002)(2906002)(6666004)(45080400002)(66556008)(86362001)(83380400001)(66946007)(38350700002)(66476007)(38100700002)(316002)(44832011)(8676002)(5660300002)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MtGPL0WGE+hdOVWKkvJHnPpOES+xjpGR8LCQ9qrHiZwW27PE7TDiqgOBRjta?=
 =?us-ascii?Q?k4MLt5RzsmZKZl67/kotVZL3B6foOG9489G5I12YeGK+qx2UZxa2i+WA/zG5?=
 =?us-ascii?Q?NENw461zUyyF6Wpf/TLIbU+UpZ2vzeJmZC2++uCEBciSYuygW63FHH0tnyXk?=
 =?us-ascii?Q?ndLiZIKFShp+D2xKbaZ1PAfhtnUupJ5ArNHiyMLkGMPACu5vPg534jl6aPfb?=
 =?us-ascii?Q?x8rg9O2oq8Zdkzg1jmicmhlHJ9ibksUtzqLdXffcrcZXuIKz7/1AlkkYyGSb?=
 =?us-ascii?Q?9Chx1FFLqOP1811Ezh5G4P18yAe/zAKgrFrPf2qetuDEP8t7+ZDKeBj8rTK9?=
 =?us-ascii?Q?/+t7iTA2EHG+XJuOVHJTM5ermH7HQHXK+5vXO8T+xVteITqX1GqNcsdxosDV?=
 =?us-ascii?Q?bxCMqFiR3o4rawq7DM3/loBKn8j+sZmib+CJEVyAmLqSpS2CweIZTmik2rhY?=
 =?us-ascii?Q?Y5PbODdKyc2xtiWJlcNMRXfj4+u61KqJaxKzsnybyZJzJPkNi6eo4bfq7+Ow?=
 =?us-ascii?Q?CTbWfW8JGxZBvLE1Ok3+L9HloqfQOwg/toXzGeYVh9375BKrnBRq5rvA5CHA?=
 =?us-ascii?Q?n25NzxduvFrx8l+Vgfy7SOBSFc7wGMG4X5R626ZGfM9IR+496Fx9MV5gT+Rr?=
 =?us-ascii?Q?gaEizq1hk31t0EK9bdKRaAzKETa60KIGuDcSDdp0o6LyunrSjsNNjUce8BBa?=
 =?us-ascii?Q?8Nsf9bn8egjUoRlgzRrWWpYmPwFt2lLvQ357sLyCZpSO2I65gjvPafEmrMdB?=
 =?us-ascii?Q?1DIE3/9lLPTOWipk2N9SBNs2v9oP2SFyszOZlm+6LuW2az5TRInT+b9jd5dH?=
 =?us-ascii?Q?Gzwl9Ov5hav25KArHJHbIyqob1Y8YUvxs3VWNsb5/IE7dNGqaHBxU/janhkD?=
 =?us-ascii?Q?iHkcvrDtVD8CBmmRqbUTxy3sHMweWU51E7S1Nd07SU7eU7gtX5KD173KL9LC?=
 =?us-ascii?Q?APB16SQKukKt8yQEuMFoWEKniAgCSYIl+HtS124jdWkh2oloBBmAhJ4OnIfr?=
 =?us-ascii?Q?UXdJPZEm39UbSELoqFxKi8jiqwZbSv/qK1ZLuHWV4sfTm4oTPGJzdGln3IWJ?=
 =?us-ascii?Q?9GvTQArF5t8xfK9AuM1RbU/xabCwQEBEPcK+MoPWOaokji9ySEdr7K/HzlUI?=
 =?us-ascii?Q?z3pYB0yVGhdg7nBi/EhHdHg65pvkDR0RCT5lzaG1xV/Gd64/WrjVBmtbooCv?=
 =?us-ascii?Q?WYDuKxZJhoo+OAgXhzAdQqD/tW7RZjf20rB2SPauIeH87fOiVjRdOUDObTla?=
 =?us-ascii?Q?78FqktZbBxuFOuZTqwe1XkwNTl1F5poTGZtVwqDLWVZwdvX+ukJUfbg1yEL/?=
 =?us-ascii?Q?waW40xFNpkbswCwfqCad+9MT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05984a8f-b869-47c8-0445-08d901052eee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 18:26:42.5969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jevtZrATsBU79GMqkBdlRPIAXePaUiRqwsPvyn+67xNSA7K1EuQ6Ce2OueKFl0QBHawBFNQQTVlg3Buqw+mSuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3477
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160130
X-Proofpoint-ORIG-GUID: MF5hay7RUnIf1utR_otjdD0wkcOJZwEc
X-Proofpoint-GUID: MF5hay7RUnIf1utR_otjdD0wkcOJZwEc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160130
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 12:52:21PM -0500, Tom Saeger wrote:
> On Fri, Apr 16, 2021 at 12:49:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> > From: Derrick Stolee <dstolee@microsoft.com>
> > 
> > The --prefetch option will be used by the 'prefetch' maintenance task
> > instead of sending refspecs explicitly across the command-line. The
> > intention is to modify the refspec to place all results in
> > refs/prefetch/ instead of anywhere else.
> > 
> > Create helper method filter_prefetch_refspec() to modify a given refspec
> > to fit the rules expected of the prefetch task:
> > 
> >  * Negative refspecs are preserved.
> >  * Refspecs without a destination are removed.
> >  * Refspecs whose source starts with "refs/tags/" are removed.
> >  * Other refspecs are placed within "refs/prefetch/".
> > 
> > Finally, we add the 'force' option to ensure that prefetch refs are
> > replaced as necessary.
> > 
> > There are some interesting cases that are worth testing.
> > 
> > An earlier version of this change dropped the "i--" from the loop that
> > deletes a refspec item and shifts the remaining entries down. This
> > allowed some refspecs to not be modified. The subtle part about the
> > first --prefetch test is that the "refs/tags/*" refspec appears directly
> > before the "refs/heads/bogus/*" refspec. Without that "i--", this
> > ordering would remove the "refs/tags/*" refspec and leave the last one
> > unmodified, placing the result in "refs/heads/*".
> > 
> > It is possible to have an empty refspec. This is typically the case for
> > remotes other than the origin, where users want to fetch a specific tag
> > or branch. To correctly test this case, we need to further remove the
> > upstream remote for the local branch. Thus, we are testing a refspec
> > that will be deleted, leaving nothing to fetch.
> > 
> > Helped-by: Tom Saeger <tom.saeger@oracle.com>
> > Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  Documentation/fetch-options.txt   |  5 +++
> >  builtin/fetch.c                   | 59 ++++++++++++++++++++++++++++++-
> >  t/t5582-fetch-negative-refspec.sh | 43 ++++++++++++++++++++++
> >  3 files changed, 106 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> > index 07783deee309..9e7b4e189ce0 100644
> > --- a/Documentation/fetch-options.txt
> > +++ b/Documentation/fetch-options.txt
> > @@ -110,6 +110,11 @@ ifndef::git-pull[]
> >  	setting `fetch.writeCommitGraph`.
> >  endif::git-pull[]
> >  
> > +--prefetch::
> > +	Modify the configured refspec to place all refs into the
> > +	`refs/prefetch/` namespace. See the `prefetch` task in
> > +	linkgit:git-maintenance[1].
> > +
> >  -p::
> >  --prune::
> >  	Before fetching, remove any remote-tracking references that no
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 0b90de87c7a2..97c4fe6e6d66 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -48,6 +48,7 @@ enum {
> >  static int fetch_prune_config = -1; /* unspecified */
> >  static int fetch_show_forced_updates = 1;
> >  static uint64_t forced_updates_ms = 0;
> > +static int prefetch = 0;
> >  static int prune = -1; /* unspecified */
> >  #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
> >  
> > @@ -158,6 +159,8 @@ static struct option builtin_fetch_options[] = {
> >  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
> >  	OPT_INTEGER('j', "jobs", &max_jobs,
> >  		    N_("number of submodules fetched in parallel")),
> > +	OPT_BOOL(0, "prefetch", &prefetch,
> > +		 N_("modify the refspec to place all refs within refs/prefetch/")),
> >  	OPT_BOOL('p', "prune", &prune,
> >  		 N_("prune remote-tracking branches no longer on remote")),
> >  	OPT_BOOL('P', "prune-tags", &prune_tags,
> > @@ -436,6 +439,56 @@ static void find_non_local_tags(const struct ref *refs,
> >  	oidset_clear(&fetch_oids);
> >  }
> >  
> > +static void filter_prefetch_refspec(struct refspec *rs)
> > +{
> > +	int i;
> > +
> > +	if (!prefetch)
> > +		return;
> > +
> > +	for (i = 0; i < rs->nr; i++) {
> > +		struct strbuf new_dst = STRBUF_INIT;
> > +		char *old_dst;
> > +		const char *sub = NULL;
> > +
> > +		if (rs->items[i].negative)
> > +			continue;
> > +		if (!rs->items[i].dst ||
> > +		    (rs->items[i].src &&
> > +		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
> > +			int j;
> > +
> > +			free(rs->items[i].src);
> > +			free(rs->items[i].dst);
> > +
> > +			for (j = i + 1; j < rs->nr; j++) {
> > +				rs->items[j - 1] = rs->items[j];
> > +				rs->raw[j - 1] = rs->raw[j];
> > +			}
> > +			rs->nr--;
> > +			i--;
> > +			continue;
> > +		}
> > +
> > +		old_dst = rs->items[i].dst;
> > +		strbuf_addstr(&new_dst, "refs/prefetch/");
> > +
> > +		/*
> > +		 * If old_dst starts with "refs/", then place
> > +		 * sub after that prefix. Otherwise, start at
> > +		 * the beginning of the string.
> > +		 */
> > +		if (!skip_prefix(old_dst, "refs/", &sub))
> > +			sub = old_dst;
> > +		strbuf_addstr(&new_dst, sub);
> > +
> > +		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
> > +		rs->items[i].force = 1;
> > +
> > +		free(old_dst);
> > +	}
> > +}
> > +
> >  static struct ref *get_ref_map(struct remote *remote,
> >  			       const struct ref *remote_refs,
> >  			       struct refspec *rs,
> > @@ -452,6 +505,10 @@ static struct ref *get_ref_map(struct remote *remote,
> >  	struct hashmap existing_refs;
> >  	int existing_refs_populated = 0;
> >  
> > +	filter_prefetch_refspec(rs);
> > +	if (remote)
> > +		filter_prefetch_refspec(&remote->fetch);
> > +
> >  	if (rs->nr) {
> >  		struct refspec *fetch_refspec;
> >  
> > @@ -520,7 +577,7 @@ static struct ref *get_ref_map(struct remote *remote,
> >  			if (has_merge &&
> >  			    !strcmp(branch->remote_name, remote->name))
> >  				add_merge_config(&ref_map, remote_refs, branch, &tail);
> > -		} else {
> > +		} else if (!prefetch) {
> 
> That works for me.
> 
> >  			ref_map = get_remote_ref(remote_refs, "HEAD");
> >  			if (!ref_map)
> >  				die(_("Couldn't find remote ref HEAD"));
> > diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> > index f34509727702..e5d2e79ad382 100755
> > --- a/t/t5582-fetch-negative-refspec.sh
> > +++ b/t/t5582-fetch-negative-refspec.sh
> > @@ -240,4 +240,47 @@ test_expect_success "push with matching +: and negative refspec" '
> >  	git -C two push -v one
> >  '
> >  
> > +test_expect_success '--prefetch correctly modifies refspecs' '
> > +	git -C one config --unset-all remote.origin.fetch &&
> > +	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
> > +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> > +	git -C one config --add remote.origin.fetch "refs/heads/bogus/*:bogus/*" &&
> > +
> > +	git tag -a -m never never-fetch-tag HEAD &&
> > +
> > +	git branch bogus/fetched HEAD~1 &&
> > +	git branch bogus/ignore HEAD &&
> > +
> > +	git -C one fetch --prefetch --no-tags &&
> > +	test_must_fail git -C one rev-parse never-fetch-tag &&
> > +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> > +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore &&
> > +
> > +	# correctly handle when refspec set becomes empty
> > +	# after removing the refs/tags/* refspec.
> > +	git -C one config --unset-all remote.origin.fetch &&
> > +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> > +
> > +	git -C one fetch --prefetch --no-tags &&
> > +	test_must_fail git -C one rev-parse never-fetch-tag &&
> > +
> > +	# The refspec for refs that are not fully qualified
> > +	# are filtered multiple times.
> > +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> > +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore
> > +'
> > +
> > +test_expect_success '--prefetch succeeds when refspec becomes empty' '
> 
> technically this will get skipped based only on "skipfetchall" right?
> 
> The remote could have an empty-set of refspecs or multiple
> valid refspecs post filter_prefetch_refspec, but the remote gets skipped altogether.
> 
> perhaps '--prefetch succeeds when remote.skipfetchall is true' '

Forget what I said here.   Now seeing this is using 'git fetch --prefetch'
directly and not using `mainenance --task=prefetch`

> 
> anyway this is looking pretty solid
> 
> Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
> 
> > +	git checkout bogus/fetched &&
> > +	test_commit extra &&
> > +
> > +	git -C one config --unset-all remote.origin.fetch &&
> > +	git -C one config --unset branch.main.remote &&
> > +	git -C one config remote.origin.fetch "+refs/tags/extra" &&
> > +	git -C one config remote.origin.skipfetchall true &&
> > +	git -C one config remote.origin.tagopt "--no-tags" &&
> > +
> > +	git -C one fetch --prefetch
> > +'
> > +
> >  test_done
> > -- 
> > gitgitgadget
> > 
