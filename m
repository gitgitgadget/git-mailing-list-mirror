Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA7C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C1A8611C9
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 16:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhDLQxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:53:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36188 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244376AbhDLQsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 12:48:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CGiPne026589;
        Mon, 12 Apr 2021 16:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=tygsB+iHH0vkkPp8aazkgDkC0oY/PbrFAPzAr4WsK8A=;
 b=sHaPcWD0UWUbQy43/b1z6mTbSWSWZIx2hNL8LrWLTc17ym0Ab8DP1xvtnuK95EhAmhr7
 Azu3C/YJyXkF25+pu02wQGDHYrsMKGi2DBloE9WkZGnGgufCR81h7YCo008j8uvR+PfD
 4Wt9GWtKTlPPfqNyvckVPj+K+Nq6mzGPArZIq05dFCikCHy5uG2DjjwsacAb8XUYyVOp
 WtciGmifRJfHycJ14SpmnAxKGilHSedTM/3A8mY7BdgD5gcGni+MOeHu94CUdQE1LMko
 z4FYHwp11xpwoj21WhLCMrILvkQmBcCEunztpPPcVdZNwBciTldzd3UEI3y4n/UUKHli 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37u3ymcc44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 16:48:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CGfPca017803;
        Mon, 12 Apr 2021 16:48:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3020.oracle.com with ESMTP id 37unsr5jmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 16:48:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ2zCDNuBeI3In2z3TkG/jFWA51MHpdmwW/SVLqeF+W8qCqcZ6qa/yDeUugF+8AJQ1FG71+4ikwVlEZ7EU1clk+9o0oIesc+JWp4+o90M8wWsDOGXZeqUHhpTgGr6iYrXuU8c1AYDbcTur4PVygNBKyVLdPEQ6xMDGuQASRQIs1yudxpAI9MXqMZTFfIGWjN0yF6MtZ/IpBtv387EAogerY5oQjaYwhJCY0/yUhcuA4Nqe5qOX2GIyjUwVTRyHGcJOhDaGKzEfmtK2zkjR6uQ/EhpkHBDnLJ0SNRstMqXntCip38aqo5AxlFhD/ARjWjHuMKGZ4Y0YxojWmxuQIbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tygsB+iHH0vkkPp8aazkgDkC0oY/PbrFAPzAr4WsK8A=;
 b=LU7I5ZSHMo25O8wnvIuCqPn+GpxUdXsI1t2FzwkfmjuZEvsdoMYNg6hsJDtK/5kkhB2/ZQI4XgSs71BdbPkQIG991t6LXCjBfisY+4jbbGUi9z5RcoWDIx4nZZUmlGxiWiuq0iZjrZdNq285HGsniF8+1oiEVjXgr15A1jbn+89eLPy+WzcZUqiSYrzc8l/4q+JZVWDLGyEinnaSliqTsDtixhExqbCH/s25kHrvcwryYng71Yzx+lGxVw7uv4AXyxCSZXgOgqxu1ANkZ+qUkk+X2OdhNSe4HMFUG2bmiwdMmIEvZgf6t58NR9auX/mbYZmtadR1ZdEHuBxq2CyINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tygsB+iHH0vkkPp8aazkgDkC0oY/PbrFAPzAr4WsK8A=;
 b=g1AbLUsYzEkTnw0TEjyVHyMLjLA3EyDhjtV9kMgBcIKZldaXl3zPyH6LoINpCUCops1MdpGGXJQub7uzjYlhbqzVfKaWzeOP4znFApKm71ZDxpoCUIazKZV8HAW4P7O2+8GaSOXU9/QE/VOxwVazCfpQv6XakXxaVKzcD0O6XSw=
Authentication-Results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4292.namprd10.prod.outlook.com (2603:10b6:a03:20d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 16:48:09 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 16:48:09 +0000
Date:   Mon, 12 Apr 2021 11:48:05 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/3] Maintenance: adapt custom refspecs
Message-ID: <20210412164805.pxq7acln43gbggkl@dhcp-10-154-186-72.vpn.oracle.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <xmqqtuodiowj.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtuodiowj.fsf@gitster.g>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR03CA0239.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::34) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-186-72.vpn.oracle.com (70.114.130.219) by SJ0PR03CA0239.namprd03.prod.outlook.com (2603:10b6:a03:39f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 16:48:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31ed9d2f-0381-4fb5-0afe-08d8fdd2c07d
X-MS-TrafficTypeDiagnostic: BY5PR10MB4292:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4292B0D0A3C1A4BF15A8C0FBFC709@BY5PR10MB4292.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfdCKGPNkHIzogKw7qz4caIcOnvNs1LAZWa2JoAe2wfpphJwE/vkQuwv4lygZuoKI+HN3rLdTTxiYYSOgQVntC/CREy/x5wmOGKsFjZvmd0U0/bDMOYH8Fg3tDqJWXdW8P0S8/h8D3eYViJSE2EcuanJlYkuQONO60RfaghUJ2NWTuFBpxxY6Naa3/MNSsOPdHQ/qsa8ZAfXVzTm3vk6+jv1I0ws+iGWW9bRljuSXZx2w3bxtKjyDP9D3Ho4O2sJYkqgioGtl0hHvyQTBj2l1AToc1Mbf0yHF3uyfr8byQIHUAkwmLk/yrXMaboZwfEEzzuXmtdV1yRTlXjgxnYjkaz5nI2JWWoaspOCXatj8vlkewvVImiyEC+AfEP1QTPS7cXh9kuoYkzfoVQJbPzcYBn0PF5vLVYA/So4QGjgfT9Zn4ZSkFYTWYe9pW3NvzCx959dTC1M9wBojmz7TFdrv5wmhULv+iJDRnf8laq8Bp/twvuzoDtHt4bJfcmWEw5vV+qURVfYwQ38/IhxOgYDXIzvpHZMHJBYPMiefacjyRNA+oWJwzUzBw4+lWAl4nRWoIC2Xf8Lv71qvw2RwwYpPb4XTwWI0gVwnulquDk8+9Dp1SJnmAhPwofw/arZ7ElRoPACgeoeLxt8PDDjmB0Y6nMSQWy4qjxHDkTVVlugZnS0EcAa7v860ouGo8fAhNwm0omcWgxVPCwkXgfXVfXEHahbIJkSqPFSAbCbRNTjjmX61YPrA4Pe+azIU9mX9DMI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(366004)(346002)(136003)(6916009)(956004)(66946007)(66476007)(186003)(55016002)(6666004)(8676002)(66556008)(38350700002)(8936002)(966005)(5660300002)(83380400001)(4326008)(26005)(1076003)(2906002)(7696005)(52116002)(44832011)(16526019)(86362001)(38100700002)(478600001)(316002)(54906003)(102196002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4mddnKYQkMTWyl8L/pCdGUpV14vYg/xQ+C+HKZehzzPUgUYEMFx13CBFU9f8?=
 =?us-ascii?Q?Rh+1X/aKH6WW2tDEJWktjgzKjb06lSah6i+08G45RjIjjspv4xCNsHW0UiS0?=
 =?us-ascii?Q?jQGhOyRp8tYU94+d7kynT63zdrSpvO8voGZ8ZoOcezQnMNQbgah2+cwJKyjV?=
 =?us-ascii?Q?b/3yMctyAKp/0MO45DarKtNoDczKtA+BVGmtVtyW9ieUuoXdH7gSJ2qOT2bs?=
 =?us-ascii?Q?59Oz3/kp7SKuMzLMH6m3XlwqOO5XcFb+cUX3+xRZewGJheFbQze1QuUEgu3I?=
 =?us-ascii?Q?EcAGxpLAFTNnyfE+GiqytSVVMmk1OvwzdMrR2+7R7Uy2SZsGG2yVstSI408F?=
 =?us-ascii?Q?a2I/jS5n0/wraRx2BdRONzKzkZAMeYxyUJJzHU10AHPfwXVlpDJEaNwI9SgW?=
 =?us-ascii?Q?rDY1FixlwlW5H9zQ9v/I6UCqsJwp+oJtlVPwTD9jqNxQcfVtXFxPKJprQWoy?=
 =?us-ascii?Q?vfCvqT1jHNHR1/SmmX3Gbdj9LqMkWvMxrdyas8kkcXBCXiecX2bCcBCxCds+?=
 =?us-ascii?Q?rEdNcS3Kxk2ZxoCOBK//35N+PLZVVOjwxB9+oUMiB5AIzERp2FM17DEmrqvc?=
 =?us-ascii?Q?KRbgpW+XDm2RlFPLzx2HSpEQ4r41Fve6epH7mcyfg8oTiBQQiQNh+ZnBMEBp?=
 =?us-ascii?Q?MAmNEYLcfMcmUztwuXaWFMLe7d1fS0H40iE81yLBvAdlU3Tvdvqar+W84y7f?=
 =?us-ascii?Q?Xxg49S8Hyj7TJMRt2lZ0yT9QmhIuDcEhv6x7LKyXmFH1fhpPF4BcV624DIwP?=
 =?us-ascii?Q?81pRtMQhClugTuDbnyQnwzBe1mWQQjDxR/DduqmGU2NeIOfdzwqWH4nM513r?=
 =?us-ascii?Q?MGqc5y7mi9W5B2ZXyt8dobSgQ2y5JkU+I7MAZtvn5NRfbW3KyFSYiJJeL19M?=
 =?us-ascii?Q?SThsm5MMA9DibEWFh37REBnaPOgfUKaBmZKCDzCxD3OChBO/uX9kM0QBm7+u?=
 =?us-ascii?Q?wvGVJEBj4HHnsYKVrsCyY8ny5Z+JWj1AQa3kU5c2hI0BVAmmiwxfxwXZWd0L?=
 =?us-ascii?Q?mcjcIOmlyq5HTtBi2fbSHP4pD0KzXlF1fhzFQtG+hEH1gSGILP8KvuPDKy+l?=
 =?us-ascii?Q?KouPe/XEj6lNTWekFl+7QaiXatDA0v/rnkHp0j4g1c+hdJtLMRxRrAutbiE1?=
 =?us-ascii?Q?z8TrL4ovNH41IP13lla72I4SzuebbbD0RSAzqb9lxPaccI/GPSPuqcovzdL2?=
 =?us-ascii?Q?FO2pRrhisGyQtGpwO8RB+S6gUeYqSN+SRgQGBQsJYSeNYtw2KIG3AAIk83t4?=
 =?us-ascii?Q?NM3xQhCZPpe11lN6XwjCu+UdaMFCzQTQw/PwiqsnPR9VdMn/5+53ouhmDbt0?=
 =?us-ascii?Q?CaK4NnkOlUywS94OzGsntq9K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ed9d2f-0381-4fb5-0afe-08d8fdd2c07d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 16:48:09.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7x2x/EPAl+B9A5VJXwQLL23OkBTpxldNuW9tFbeZnlRWYEdWowtArSKE/1RgH5eyBdbxDen5IqLGKg7BC/7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4292
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120107
X-Proofpoint-GUID: gGvc7nF9nuY25QtckEZFD0fw9USHfvVM
X-Proofpoint-ORIG-GUID: gGvc7nF9nuY25QtckEZFD0fw9USHfvVM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120107
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 10, 2021 at 06:35:40PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >  * The fix is almost completely rewritten as an update to 'git fetch'. See
> >    the new PATCH 2 for this update.
> 
> I do agree that it gives us the most flexibility there with nice
> encapsulation.  Nobody other than "git fetch" needs to know how it
> computes which remote refs are fetched given the real pathspec, and
> the only thing the caller with "--prefetch" is interested in is that
> the prefetch operation would not contaminate the remote-tracking
> refs.
> 
> Great idea.  I wish I were the one who thought of it first ;-)

Yes - this simplifies things greatly!

I do have one case that fails prefetch though.
It's a case where all the remote's fetch configs are filtered out.

Example:

	[remote "pr-924"]
	    url = https://github.com/gitgitgadget/git
	    fetch = +refs/tags/pr-924/derrickstolee/maintenance/refspec-v3
	    skipfetchall = true
	    tagopt = --no-tags


In this case, running `git fetch pr-924` will fetch and update
FETCH_HEAD, but running with maintenance prefetch task results in:

fatal: Couldn't find remote ref HEAD
error: failed to prefetch remotes
error: task 'prefetch' failed

I tracked this down a bit, but don't have a suggestion how to fix it.

builtin/fetch.c `get_ref_map` makes two calls to `filter_prefetch_refspec`,
one for 'rs' and another for 'remote->fetch'.

`filter_prefetch_refspec` works and filters out the above fetch config.
This correctly yields condition
`rs->nr == 0` and `remote->fetch.nr == 0`

Later a call is made to `get_remote_ref(remote_refs, "HEAD")` which
fails, leading to `fatal: Couldn't find remote ref HEAD`

Should this be expected, or should this now be special-cased for 'prefetch'
somehow?

Regards,

--Tom
