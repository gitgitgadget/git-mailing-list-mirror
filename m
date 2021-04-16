Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC28C433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489D6613B0
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 17:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbhDPRxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 13:53:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPRxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 13:53:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GHoFC0055830;
        Fri, 16 Apr 2021 17:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=f3Hp0gdWTmBu0brTR9wtsJj7fFMnUxNu9P/DgQ/clQw=;
 b=ncbmIkg15eCmMfX2qO8MLEon0qDRzbfoGsKC54S9WDUFWP6mNLCp6qTb79s2/FAASCZ5
 tP4i4zd/xhk0p/LCFC8j+kaZIvdrKOk0MqfXBRMEAxQjgpksHR3mRaP+eDXx6D2I3Cpo
 XLEeQPH1zY7JvESiW+vExDnLskgAN5CYmHgYNGuroTcdxVByo5a4wtG/RMJifaGxwQPA
 Z0t/PrxJFlG1kvLvbh0/FqN9DMU6rrG/d5gZjtyOT+ASWU1NF0BBz+pytg5xRTMU64FC
 xHVsPeWVNypI/fiFu1dq+T35JQF5y4xTF+Rnp6I/cpACiX9dUuB2b9QjEacbM9gMEQ7T wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37u3ersxps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 17:52:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GHoi5Y047962;
        Fri, 16 Apr 2021 17:52:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 37unkugm3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 17:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDisWyfwYOz3TqnhYlVZDybBOP2h4YfI04KNGW48RMnP9tTISlRmuKTOHmwr3EYZhylIdP8nZFjUZuk/XkWScpRFhWFyS/QU0kUc8kaZ6ybIEbznYjgOZHAP2jKcmDDlScmVyIy1+ZISCMXBUoYEqwcFZFt6do/pfmqZyrPr6ZmDj8PwhcRI2K9sblr7GBYYxKynNTrFtbzlOl0Dm00hv22owurajrn2+6nXAAZAuxmaeAIptnigL84mwtc8/GEv//urEHzaSlZjgyefcj5PwQVQ4DGUa2OkBu5iMu0SWxz6x3X12h8BzduZdgRELd682m068wBCwfP15m1EzcjSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Hp0gdWTmBu0brTR9wtsJj7fFMnUxNu9P/DgQ/clQw=;
 b=ZLJijsQRWJPbuF8yJ1lrhBRgpfRVUERhBgU5YUm++Mshhuz/IMMJqp7If58TKjB/PHwBLyfxL3ZasIRJmkToRzcUna08/Ato8qEuN4EbSA3XPTk8K0FLcIXO4f45zJMiUMo3tNt9sHniHYVKUGT1/FqSL25HJRdgCRy9X5pN2bWZbNkB2JB4nRn/7jwuamMQL3NyDcFedzR6MyxjRBwO670J6yGus1nmm9b2nn+bXdFZ6C7H/WeyC1UIcFMHNFKrJKyMLljrQMYyMCZo4asL7zse73c+0AMp5vh49afMAvxLHQpgn0Iz9MdOTG+cY/ZmFPjQWdrOkiQtpEEnqr4tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3Hp0gdWTmBu0brTR9wtsJj7fFMnUxNu9P/DgQ/clQw=;
 b=LbufLdF5XNbye/pvvagJEbN/vEMK1P5TSv6umCK27GMbWErQJNOjIbfGBCzrh5jCLP+GWZ5roJn1aQuliEGun7BTkmppyxlFqdbOvks9Xohnt36SIyYOlyCR/4i1uvMl3FzvzaVZX6y7m3EYQKhISApqS7PuKmW5mcLjOe6Y1A8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2678.namprd10.prod.outlook.com (2603:10b6:a02:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 17:52:21 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 17:52:21 +0000
Date:   Fri, 16 Apr 2021 12:52:14 -0500
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
Message-ID: <20210416175214.lysy3amsb7urj3ix@tsaeger.oracle.com>
References: <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <pull.924.v4.git.1618577399.gitgitgadget@gmail.com>
 <73b4e8496746a3d1387e568a5a898c02ec81df76.1618577399.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b4e8496746a3d1387e568a5a898c02ec81df76.1618577399.git.gitgitgadget@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tsaeger.oracle.com (70.114.130.219) by BYAPR02CA0054.namprd02.prod.outlook.com (2603:10b6:a03:54::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 17:52:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6374f01-c2d6-4718-4184-08d901006249
X-MS-TrafficTypeDiagnostic: BYAPR10MB2678:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2678E18B53B0B4D34F820231FC4C9@BYAPR10MB2678.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WDydzVNwKdzcJZxu6FmwLIg2PlK4OB+h2LS76U9c/id5x/AMMjvz4Pfh0bWSh5MyXkL9qQ2ibkwrGhuakhfAkLRnnfdp1ZvROCm3kQjgzUDu1XM9Xredi/UHt09os1Fk2ii9A8IHFPtuii+PZI0yY77Q/RyGFuTKgiWAindwHdXcc13sMNzuwBvHBEoeWcMpaZ1GTYRECebJZ7fbYBF6zfaCmJwH9kHTjj/633uvAMgITBP6GMUgPBcpXgFUefKQDUMQIz0+5l701JL+iarcMxWPWrJ2hXBgXhmt37X4Tb3AYtddZhm1IofjLCD33CUzDdgyz/YrRVt5Zrqp6sXsIhg7h6Z3bmHd1dWk5DMSm3WEKX8hyE2A61XLBa3Y9wza/wLIwpk4k/Qs4YKjMe7SZ2AMCRo6dHGzXV/9gEmDy9uSuZznJp4g5DeVUU7rjC97weqLVAftwxQOhfkV2Tdon9Ood1zZ7GfT288O/QZQGt7kUWnmUqe0SbgrepCF9pHe9fl6TTWcL8RYWuP4/yJM3EsDAvcLD+nmFae5KI8zoeOso8YycIzP8dZyY29oevNKFEvRAHyFHcdyeEvJZFMc2YqoeEcTpsC73Kbus1/42tL+dF7qDhB2uD35fWIqNiXRvhm05OtYYWfluH6H6lpmbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39860400002)(366004)(8936002)(508600001)(45080400002)(83380400001)(44832011)(16526019)(7416002)(8676002)(38350700002)(6666004)(54906003)(956004)(7696005)(52116002)(4326008)(38100700002)(2906002)(55016002)(1076003)(6916009)(86362001)(186003)(66556008)(66476007)(66946007)(5660300002)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hDabfvQ5WreVs3e9q2Rr0YEZbwHYAdhmqHqhWd2GKLqOLHQ2ePO6OuKMBTQo?=
 =?us-ascii?Q?qXbwKFzOMIF4nPHBMxYArpkZD/cTaklKek3gWxe1P0uMjQowxjEALaPKqDPE?=
 =?us-ascii?Q?K9zon7tcXpxWzxaVZVyI32QYpu+5bqrUclD+M5fQ+5mCdUko7mqJTm1pFXqp?=
 =?us-ascii?Q?SaiG1Dff9pXQ5Q949PQXgOu76pSSVzzz7KgP9APQR02PE0VTt43WKga+6sAz?=
 =?us-ascii?Q?wH1dZA3XV0inj38CHX7pqQdPe43LbTpc/8C7SWp36375khS/2SFSFqUZL9FK?=
 =?us-ascii?Q?38R8keGrkucr1Fx+mz5/5i0rTkTiTiYc1lL4FRgzsab1VsHpQe/uiiJDgKuC?=
 =?us-ascii?Q?p8g8p60QG5TwP7p2ZPyQHNYUUdyW6KTPHW6rnamFFOv44oZVexnHQ8bK9uG2?=
 =?us-ascii?Q?SuQ+cy3diRKScWaaF0qegFvzY8p0F/J13JZgU1iZv09NvJMrli2U0KjhlqT/?=
 =?us-ascii?Q?tuSAYMlOP+RzHIuJ5F4N9eV8TtLawjWwptSLiyol1yL3As0ZO0MA5BUcp4tH?=
 =?us-ascii?Q?LZcesu0+lmrTSb1jBtBAnYgOpBUhC3dKEvGn1H8U9KV1dIwq6wad6kSJczgQ?=
 =?us-ascii?Q?xr5u/s9soZlsDH9ncCd9FxDgCqJt8RzIhbQyxP4/DePePkrpIfUrxhcQ0/W3?=
 =?us-ascii?Q?Zuq3uKJxC+ME1LQToDTrY1waNI4IbrIUcDiAUsY3fAHZPDKv7agK0YnPpRNP?=
 =?us-ascii?Q?9UUgm3P/ft7ZcCpwO5LaJqJel3GKzGCfzvlJj9z5DkA7Ib3m8LJ2YIveqTj+?=
 =?us-ascii?Q?j5L96uM5Nha1rRoyVKyn1pLHGdxNstpQqNqJIBqMjElg/XUjTekoZSQJ8aad?=
 =?us-ascii?Q?juPBb1B0bqDLwjRXskebSMMnyLss857mrdHhr7RzEHSqy/ATjAvqJPAwFcav?=
 =?us-ascii?Q?3nfIVJLuedF1fxtEBPz4VHdpnZQEM0IXLhrDR+mHaokNXGJOZJnvs5qO5oWW?=
 =?us-ascii?Q?7PtcZj2wKPZaSWgn8iA1EO/nOQKYhGLdRHDQTHbTR9UxqD52732lMS/hs6OD?=
 =?us-ascii?Q?9qVEdq2l3qe0HmouMmw2rLqgOjxRmGdTbS1A6/xrd+cII4XqYtxj6qUMg3Pi?=
 =?us-ascii?Q?uMQgHsxROYKDHIAR5+gM9AuZj0YhKnUF9akJmomaf4hHukSzVYQGFloWcsez?=
 =?us-ascii?Q?1QsWJ7yTvTQs3WTJyqMmeXvvz/FLhW6V0ZGJHk3xUqo+J1dm0oJQWtlAmEBY?=
 =?us-ascii?Q?/02MD79zsKO4iRi5fenUz8y5zT5MHaXGMdyVnm61g5KVbe4yLn0mHgM8ULMo?=
 =?us-ascii?Q?1eAbzYB5J6uGnAqfQ7wrSW4ez4LxtFBNsqn7m0j4audc776nqPIkHayCIrPk?=
 =?us-ascii?Q?AbcwTw7kiAjLaQdqu1ZsCtSf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6374f01-c2d6-4718-4184-08d901006249
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 17:52:21.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIc33pwCEIlCbuNIUmSVT7XPeuWaxagbToYGtO/4aEcIePubt1VUfQl6ytmmFIB+9/zj+nlxUQ0vFQ2EWbGdmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2678
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160127
X-Proofpoint-ORIG-GUID: U4bu4TuK1ZmkA_P5lhiidqQAIWjcmZoD
X-Proofpoint-GUID: U4bu4TuK1ZmkA_P5lhiidqQAIWjcmZoD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160127
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 16, 2021 at 12:49:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The --prefetch option will be used by the 'prefetch' maintenance task
> instead of sending refspecs explicitly across the command-line. The
> intention is to modify the refspec to place all results in
> refs/prefetch/ instead of anywhere else.
> 
> Create helper method filter_prefetch_refspec() to modify a given refspec
> to fit the rules expected of the prefetch task:
> 
>  * Negative refspecs are preserved.
>  * Refspecs without a destination are removed.
>  * Refspecs whose source starts with "refs/tags/" are removed.
>  * Other refspecs are placed within "refs/prefetch/".
> 
> Finally, we add the 'force' option to ensure that prefetch refs are
> replaced as necessary.
> 
> There are some interesting cases that are worth testing.
> 
> An earlier version of this change dropped the "i--" from the loop that
> deletes a refspec item and shifts the remaining entries down. This
> allowed some refspecs to not be modified. The subtle part about the
> first --prefetch test is that the "refs/tags/*" refspec appears directly
> before the "refs/heads/bogus/*" refspec. Without that "i--", this
> ordering would remove the "refs/tags/*" refspec and leave the last one
> unmodified, placing the result in "refs/heads/*".
> 
> It is possible to have an empty refspec. This is typically the case for
> remotes other than the origin, where users want to fetch a specific tag
> or branch. To correctly test this case, we need to further remove the
> upstream remote for the local branch. Thus, we are testing a refspec
> that will be deleted, leaving nothing to fetch.
> 
> Helped-by: Tom Saeger <tom.saeger@oracle.com>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/fetch-options.txt   |  5 +++
>  builtin/fetch.c                   | 59 ++++++++++++++++++++++++++++++-
>  t/t5582-fetch-negative-refspec.sh | 43 ++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 07783deee309..9e7b4e189ce0 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -110,6 +110,11 @@ ifndef::git-pull[]
>  	setting `fetch.writeCommitGraph`.
>  endif::git-pull[]
>  
> +--prefetch::
> +	Modify the configured refspec to place all refs into the
> +	`refs/prefetch/` namespace. See the `prefetch` task in
> +	linkgit:git-maintenance[1].
> +
>  -p::
>  --prune::
>  	Before fetching, remove any remote-tracking references that no
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0b90de87c7a2..97c4fe6e6d66 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -48,6 +48,7 @@ enum {
>  static int fetch_prune_config = -1; /* unspecified */
>  static int fetch_show_forced_updates = 1;
>  static uint64_t forced_updates_ms = 0;
> +static int prefetch = 0;
>  static int prune = -1; /* unspecified */
>  #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
>  
> @@ -158,6 +159,8 @@ static struct option builtin_fetch_options[] = {
>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
>  	OPT_INTEGER('j', "jobs", &max_jobs,
>  		    N_("number of submodules fetched in parallel")),
> +	OPT_BOOL(0, "prefetch", &prefetch,
> +		 N_("modify the refspec to place all refs within refs/prefetch/")),
>  	OPT_BOOL('p', "prune", &prune,
>  		 N_("prune remote-tracking branches no longer on remote")),
>  	OPT_BOOL('P', "prune-tags", &prune_tags,
> @@ -436,6 +439,56 @@ static void find_non_local_tags(const struct ref *refs,
>  	oidset_clear(&fetch_oids);
>  }
>  
> +static void filter_prefetch_refspec(struct refspec *rs)
> +{
> +	int i;
> +
> +	if (!prefetch)
> +		return;
> +
> +	for (i = 0; i < rs->nr; i++) {
> +		struct strbuf new_dst = STRBUF_INIT;
> +		char *old_dst;
> +		const char *sub = NULL;
> +
> +		if (rs->items[i].negative)
> +			continue;
> +		if (!rs->items[i].dst ||
> +		    (rs->items[i].src &&
> +		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
> +			int j;
> +
> +			free(rs->items[i].src);
> +			free(rs->items[i].dst);
> +
> +			for (j = i + 1; j < rs->nr; j++) {
> +				rs->items[j - 1] = rs->items[j];
> +				rs->raw[j - 1] = rs->raw[j];
> +			}
> +			rs->nr--;
> +			i--;
> +			continue;
> +		}
> +
> +		old_dst = rs->items[i].dst;
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +
> +		/*
> +		 * If old_dst starts with "refs/", then place
> +		 * sub after that prefix. Otherwise, start at
> +		 * the beginning of the string.
> +		 */
> +		if (!skip_prefix(old_dst, "refs/", &sub))
> +			sub = old_dst;
> +		strbuf_addstr(&new_dst, sub);
> +
> +		rs->items[i].dst = strbuf_detach(&new_dst, NULL);
> +		rs->items[i].force = 1;
> +
> +		free(old_dst);
> +	}
> +}
> +
>  static struct ref *get_ref_map(struct remote *remote,
>  			       const struct ref *remote_refs,
>  			       struct refspec *rs,
> @@ -452,6 +505,10 @@ static struct ref *get_ref_map(struct remote *remote,
>  	struct hashmap existing_refs;
>  	int existing_refs_populated = 0;
>  
> +	filter_prefetch_refspec(rs);
> +	if (remote)
> +		filter_prefetch_refspec(&remote->fetch);
> +
>  	if (rs->nr) {
>  		struct refspec *fetch_refspec;
>  
> @@ -520,7 +577,7 @@ static struct ref *get_ref_map(struct remote *remote,
>  			if (has_merge &&
>  			    !strcmp(branch->remote_name, remote->name))
>  				add_merge_config(&ref_map, remote_refs, branch, &tail);
> -		} else {
> +		} else if (!prefetch) {

That works for me.

>  			ref_map = get_remote_ref(remote_refs, "HEAD");
>  			if (!ref_map)
>  				die(_("Couldn't find remote ref HEAD"));
> diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
> index f34509727702..e5d2e79ad382 100755
> --- a/t/t5582-fetch-negative-refspec.sh
> +++ b/t/t5582-fetch-negative-refspec.sh
> @@ -240,4 +240,47 @@ test_expect_success "push with matching +: and negative refspec" '
>  	git -C two push -v one
>  '
>  
> +test_expect_success '--prefetch correctly modifies refspecs' '
> +	git -C one config --unset-all remote.origin.fetch &&
> +	git -C one config --add remote.origin.fetch ^refs/heads/bogus/ignore &&
> +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> +	git -C one config --add remote.origin.fetch "refs/heads/bogus/*:bogus/*" &&
> +
> +	git tag -a -m never never-fetch-tag HEAD &&
> +
> +	git branch bogus/fetched HEAD~1 &&
> +	git branch bogus/ignore HEAD &&
> +
> +	git -C one fetch --prefetch --no-tags &&
> +	test_must_fail git -C one rev-parse never-fetch-tag &&
> +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore &&
> +
> +	# correctly handle when refspec set becomes empty
> +	# after removing the refs/tags/* refspec.
> +	git -C one config --unset-all remote.origin.fetch &&
> +	git -C one config --add remote.origin.fetch "refs/tags/*:refs/tags/*" &&
> +
> +	git -C one fetch --prefetch --no-tags &&
> +	test_must_fail git -C one rev-parse never-fetch-tag &&
> +
> +	# The refspec for refs that are not fully qualified
> +	# are filtered multiple times.
> +	git -C one rev-parse refs/prefetch/bogus/fetched &&
> +	test_must_fail git -C one rev-parse refs/prefetch/bogus/ignore
> +'
> +
> +test_expect_success '--prefetch succeeds when refspec becomes empty' '

technically this will get skipped based only on "skipfetchall" right?

The remote could have an empty-set of refspecs or multiple
valid refspecs post filter_prefetch_refspec, but the remote gets skipped altogether.

perhaps '--prefetch succeeds when remote.skipfetchall is true' '

anyway this is looking pretty solid

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>

> +	git checkout bogus/fetched &&
> +	test_commit extra &&
> +
> +	git -C one config --unset-all remote.origin.fetch &&
> +	git -C one config --unset branch.main.remote &&
> +	git -C one config remote.origin.fetch "+refs/tags/extra" &&
> +	git -C one config remote.origin.skipfetchall true &&
> +	git -C one config remote.origin.tagopt "--no-tags" &&
> +
> +	git -C one fetch --prefetch
> +'
> +
>  test_done
> -- 
> gitgitgadget
> 
