Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C484AC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0A5613B2
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhDERRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:17:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbhDERRO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:17:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135HDMM4126429;
        Mon, 5 Apr 2021 17:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=F+1V9G9PGTeXAdxqnR4VsnWGyMZXuGz0mENePXdv8Ck=;
 b=MuVy+jE0ljs3eTRmJs/QgplDsesvJPrzDI86CrqJH4/tDlVfr4n4pLTGwCqIFjO5oauu
 qX7evAkOYaHs3UHuE2W7lZ6TjO77pKFJBbxtORtY5D6csQd3BFUUSZCIbNnhTWPThKa5
 5UFG1dBwa8keSUMquZiGYSaG45ycloJGpRKg8ABNg9g0MJfnA+8idi1g7l8+UNoCSf8t
 4JUmmTLWSLGyJy3pvVA3+38GNxAL23dOc/acjOdeTclhW7VDSYJcdCbjqojAOxNzaybj
 pcHbA9Z7OhK0htDouXSosPBgaBcyOablNoPO+LC52FUEkKVYgsSbcIgIdUL+7+G5Dmq1 Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37qfuxa2nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 17:16:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135HFpZ0150665;
        Mon, 5 Apr 2021 17:16:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 37qa3hcb9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 17:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLYz9jXUETsMGgxbFfXJombMr5PhtXXcDVROWPPIs3DfcFyuVZ1s7Iwxoqm0x7w4Tu0QqhBmsS5zztReeLvgIDHS6W4F8PDwbQOx7pP0afQo0+8bM1XYMIj4N/UngCymoV8jV3Hmourf5Y8llzR4tUi2uM1yyGN3rkJuF8NC35gCXs2yK+XGwPTR+Zht55nz8HOyz+RZW1jgSHJHN/3+IeUs8SMh7rVPm9eu3/g1PMPlKWu/lPJhv2aDQKj8H6qCsXM3CUWD0i72CHKs8ZEAR+qCbbo1TlwDE/w8l1zH0dsWIErdWbQp6jc5zFynrdEOsZBJIeSoeeGl+CjU2giaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+1V9G9PGTeXAdxqnR4VsnWGyMZXuGz0mENePXdv8Ck=;
 b=OYI9TdtJow/AW0obr7nETjQwAEL/fsyUkracObR4Q2C79sTBJT7+m3vcPhGsm6SHYRnxl5iwTfCKcbtPgzymDyqpYpjJ9vfJppcegQMuraIMwxqUZCnVr7apdSLI5DlxOS/pq/ogvbQ/KAzdn4QRfb/fUhm0VoxifBmYmmI4wTykrCRZtnKOgdgtJA85OowC+myWAdix7/i8lFJ6+2IbTjF3l4XGSB+U2By7GMQhq+iSZv2zXyyORPab68sqgoLD+TRDTpb1ZrlSNZc22stKsEoIizb/t60KqlV4rARNwtb0jUdfoapj9T1swmPz9gRo5UC7Zm2vxECqgQTvNAjVWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+1V9G9PGTeXAdxqnR4VsnWGyMZXuGz0mENePXdv8Ck=;
 b=YnKYdoa+jiGokydAqQx99v89w8yTG2Y4ScYkz7+hfZU7Gae7P9IokVpkVshMd4O4XQS7TYD5dHZt57zxCK3XYLg53P9VHcSbZFkQBSfnd3vLjaR1GouxupbE0VswZKOLjraoXRjGNo5yk2lkCYLSI2bcLZmw8BVnDkpCZK44gTY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Mon, 5 Apr
 2021 17:16:54 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 17:16:54 +0000
Date:   Mon, 5 Apr 2021 11:16:52 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/5] maintenance: allow custom refspecs during prefetch
Message-ID: <20210405171652.xp63czmtsswqor2m@brm-x62-17.us.oracle.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6c127dac48409ddc8d30ad236182bee21c1957.1617627856.git.gitgitgadget@gmail.com>
X-Originating-IP: [129.157.69.41]
X-ClientProxiedBy: SN4PR0401CA0047.namprd04.prod.outlook.com
 (2603:10b6:803:2a::33) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.41) by SN4PR0401CA0047.namprd04.prod.outlook.com (2603:10b6:803:2a::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend Transport; Mon, 5 Apr 2021 17:16:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ae60236-5a13-4c89-afcd-08d8f8569c21
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4734:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4734F3A08C5622B79BE1A433FC779@SJ0PR10MB4734.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7qyfMNJjjY9wfRQIPm0Jq79L8rdV63SH/0Z0+2AMFcWbahNpZMsajE5Q+8KNZ69ES1cFXI1msZqpu4HFmcTUvj8+thQHAvv/rfyodbr+F/4rqtsmm+YtpAOylc0lDmX/i69RDVOX75/1LJIey/CTMAZTYdDSn3nN4jFmn0i58K91SDvcew3XZKBL+MjiePcpgTkfRX+tIkqRB9YyCCFhXbg1EUObj0KWRtmjztro8D9lr89XXEutEP2uwYdTMt9Vj3FYGjTxYaHyZjmrVW6Y338EPqRG02irhSmwlA9K35SFkufiRA0BUqC+TRCXYex2/uMbHF4zTjgLKFIkCFt3tWAHEW9TL0yW1Pm41OzFesv6PxIKXyxwslnGt+duQJUGkSTiVHtC5gn/IY6P4DG1WOSxl2jEz4tRvPs3sRPDvxImdlT/CbAXbPAuz3P4Wx023jkRVmlzEcbyWd+dFhHCEBKmI1lF450hcFSGSX82F3W85wc606AEJHDoJN+jnBQ2LH82GO1RIxO3X36W/YpGBdAfArpwJqBurLYKOoIEoaQ4/QuuS9b2FlTfwLRU5rNiddAezE0pkSV71TQ8EQL0uYoO9zM1ZLnZ/pgm5uoNk/6uDZQAE6I6hC6PZeSZYbu92Sc3VIGz9g4TgOQYcEzQ4tv7UaNoJJpDy5NyXcTnFf9mkVVRJlG1ijjtL97e0i5YP+G6BzhTF6dK1IrUbja5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(1076003)(55016002)(186003)(8676002)(26005)(45080400002)(8936002)(66946007)(478600001)(86362001)(4326008)(52116002)(6916009)(7696005)(316002)(38350700001)(83380400001)(38100700001)(44832011)(5660300002)(66476007)(66556008)(2906002)(54906003)(956004)(16526019)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r0xEd1ccaGi6O/mDMdOGM/6+yLtepX+PCa0VMP1txLmrjk8oMm1AtHGgs76B?=
 =?us-ascii?Q?K++JxxobPOEkV8mTqMiXqymnCufvhG7TTT9sTpBNRAJjJhKZ39Zyp1GMP/eO?=
 =?us-ascii?Q?r32/6J4908RMjgAEQ8IWs+pyYjrBkuYEqZthcc5TCb90WrSbTozkB5NZq4nR?=
 =?us-ascii?Q?kFDdjU0MnIJYxpnbV1OVsL0jQzWWl7h47HWKkoPMeobhvTAl7RyXOoGBJbDW?=
 =?us-ascii?Q?rLM/bjR5Wu1CudoI9oyljiHa1ljQmJUM6lxfLoF0rx24X3FAZEJpUuSbriWz?=
 =?us-ascii?Q?PBFI/iM0yOB4sBqKBcaTJSyIVQsx4LS/u4mAOo29lBgghRTGZoc+sst8uMX8?=
 =?us-ascii?Q?D+G9JAqzpKkKCXS5y7kIjp2TXEOD0Vj96AVTVR7VAbaAoHVFB2RVA/g0uWcK?=
 =?us-ascii?Q?+kqXI88USTEZYEP5CuQfHyQl0i5KmPRK7VeYNmIZZtN3P+LirtUsROic7XGI?=
 =?us-ascii?Q?wOlKq5CsoTEoY1OSSgT/KAF6aNqT4Ps/KqqfbjPexsFP0VCBEVeG8SatkIep?=
 =?us-ascii?Q?YYPHrXBeGSOfEAbXffZLyHs59eT6w2Z60ZU0jw2OSzwY2cwthSc7adMPDpx2?=
 =?us-ascii?Q?6q5Aow6z8H4+z5EJByxHNMy0BA+zc+oR+t0b3h/ntqJ9BneTv0x1Igobc1Ra?=
 =?us-ascii?Q?NqnQdD/QyRSeKq3q7wsRiWHAnhxjKqXsXUkBOvfUuFJN9lLlh5g8RFsC8NHQ?=
 =?us-ascii?Q?BT2iRNk/LNHrK3hoXDGaqp3pIOVdYjqeL2IbmhwbgL+WNU5229ycC9qDVmxx?=
 =?us-ascii?Q?fXENgTdCH6Rm4erAFx51aC4q5O9XRJG/LswuETnVaQL/Pb/6xL0tNRNoiAb6?=
 =?us-ascii?Q?jZo0xGheyrIxyVQFesuiigNRjmfopRG2q4xL+geXqI+uMVNN9Cecsa0spNQM?=
 =?us-ascii?Q?i3otdKBdq/36HzUdAqizXyiC8gl8vsXdPxwKUFqReixQj/YrgGyEqveawqlp?=
 =?us-ascii?Q?AJq+onkPRxTE92xi7srxKJ4Ae5I8oL/kvWUfmbpvhw8ljnRpZpc7KORbS1rY?=
 =?us-ascii?Q?ZOZudfEQIJUpHH1xMsZQy9NNQ2Yv2g5llbiE+9KrcEGjBTLY1CAdVtRqoQ0v?=
 =?us-ascii?Q?UGv6uD6X6m5btC9JpXknVjKhwB959P+OwKOSgLLgAJpWmri6ONX2GWsU85Y9?=
 =?us-ascii?Q?aKp/gICgdnll98mDTPVJw0Mq7FYkvZC/idxwrSZCEZjN7LLNRn6tQLNqq+nP?=
 =?us-ascii?Q?v+1pmGOX+D5EArrBDMTnfJPIWgb/TAl2fJP0XOsZmwEDGfjNXrJBdQsKHI5J?=
 =?us-ascii?Q?YvrFHSdtaND3PA76X0NKLqu0Xqeg5GqkS000IbDJl1NlBCaBZt26FKEm6R08?=
 =?us-ascii?Q?0NDhoA5GCgweAuUvsV5KTCQ1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae60236-5a13-4c89-afcd-08d8f8569c21
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 17:16:54.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KC0/M8FgYNi7RJERoFPVLGcVAe2Oz5KFmSUILyo1+c23UV7/1paZCQaUzKvyDRMwF+I4ocVcs/ehIbAyE7epeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050112
X-Proofpoint-GUID: 8_AL9Z95hC-1gTqYOVWc8gO53IzNO21R
X-Proofpoint-ORIG-GUID: 8_AL9Z95hC-1gTqYOVWc8gO53IzNO21R
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050112
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 01:04:15PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The prefetch task previously used the default refspec source plus a
> custom refspec destination to avoid colliding with remote refs:
> 
> 	+refs/heads/*:refs/prefetch/<remote>/*
> 
> However, some users customize their refspec to reduce how much data they
> download from specific remotes. This can involve restrictive patterns
> for fetching or negative patterns to avoid downloading some refs.
> 
> Modify fetch_remote() to iterate over the remote's refspec list and
> translate that into the appropriate prefetch scenario. Specifically,
> re-parse the raw form of the refspec into a new 'struct refspec' and
> modify the 'dst' member to replace a leading "refs/" substring with
> "refs/prefetch/", or prepend "refs/prefetch/" to 'dst' otherwise.
> Negative refspecs do not have a 'dst' so they can be transferred to the
> 'git fetch' command unmodified.
> 
> This prefix change provides the benefit of keeping whatever collisions
> may exist in the custom refspecs, if that is a desirable outcome.
> 
> This changes the names of the refs that would be fetched by the default
> refspec. Instead of "refs/prefetch/<remote>/<branch>" they will now go
> to "refs/prefetch/remotes/<remote>/<branch>". While this is a change, it
> is not a seriously breaking one: these refs are intended to be hidden
> and not used.
> 
> Update the documentation to be more generic about the destination refs.
> Do not mention custom refpecs explicitly, as that does not need to be
> highlighted in this documentation. The important part of placing refs in
> refs/prefetch remains.
> 
> Reported-by: Tom Saeger <tom.saeger@oracle.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-maintenance.txt |  3 +--
>  builtin/gc.c                      | 34 +++++++++++++++++++++++-
>  t/t7900-maintenance.sh            | 43 ++++++++++++++++++++++++++-----
>  3 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceba0..95a24264eb10 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -94,8 +94,7 @@ prefetch::
>  	objects from all registered remotes. For each remote, a `git fetch`
>  	command is run. The refmap is custom to avoid updating local or remote
>  	branches (those in `refs/heads` or `refs/remotes`). Instead, the
> -	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
> -	not updated.
> +	refs are stored in `refs/prefetch/`. Also, tags are not updated.
>  +
>  This is done to avoid disrupting the remote-tracking branches. The end users
>  expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
> diff --git a/builtin/gc.c b/builtin/gc.c
> index fa8128de9ae1..92cb8b4e0bfa 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -32,6 +32,7 @@
>  #include "remote.h"
>  #include "object-store.h"
>  #include "exec-cmd.h"
> +#include "refspec.h"
>  
>  #define FAILED_RUN "failed to run %s"
>  
> @@ -877,6 +878,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  {
>  	struct maintenance_run_opts *opts = cbdata;
>  	struct child_process child = CHILD_PROCESS_INIT;
> +	int i;
>  
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
> @@ -886,7 +888,37 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	if (opts->quiet)
>  		strvec_push(&child.args, "--quiet");
>  
> -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
> +	for (i = 0; i < remote->fetch.nr; i++) {
> +		struct refspec_item replace;
> +		struct refspec_item *rsi = &remote->fetch.items[i];
> +		struct strbuf new_dst = STRBUF_INIT;
> +		size_t ignore_len = 0;
> +
> +		if (rsi->negative) {
> +			strvec_push(&child.args, remote->fetch.raw[i]);
> +			continue;
> +		}
> +
> +		refspec_item_init(&replace, remote->fetch.raw[i], 1);
> +
> +		/*
> +		 * If a refspec dst starts with "refs/" at the start,
> +		 * then we will replace "refs/" with "refs/prefetch/".
> +		 * Otherwise, we will prepend the dst string with
> +		 * "refs/prefetch/".
> +		 */
> +		if (!strncmp(replace.dst, "refs/", 5))
> +			ignore_len = 5;
> +
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +		strbuf_addstr(&new_dst, replace.dst + ignore_len);
> +		free(replace.dst);
> +		replace.dst = strbuf_detach(&new_dst, NULL);
> +
> +		strvec_push(&child.args, refspec_item_format(&replace));

see comment on 3/5, think refspec_item_format is leaking here.
this code looks fine though.

> +
> +		refspec_item_clear(&replace);
> +	}
>  
>  	return !!run_command(&child);
>  }
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index fc2315edec11..3366ea188782 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -142,20 +142,51 @@ test_expect_success 'prefetch multiple remotes' '
>  	test_commit -C clone2 two &&
>  	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
>  	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> -	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remote1/* <run-prefetch.txt &&
> -	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remote2/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote1 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote1/* <run-prefetch.txt &&
> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <run-prefetch.txt &&
>  	test_path_is_missing .git/refs/remotes &&
> -	git log prefetch/remote1/one &&
> -	git log prefetch/remote2/two &&
> +	git log prefetch/remotes/remote1/one &&
> +	git log prefetch/remotes/remote2/two &&
>  	git fetch --all &&
> -	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
> -	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two &&
> +	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remotes/remote1/one &&
> +	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remotes/remote2/two &&
>  
>  	test_cmp_config refs/prefetch/ log.excludedecoration &&
>  	git log --oneline --decorate --all >log &&
>  	! grep "prefetch" log
>  '
>  
> +test_expect_success 'prefetch custom refspecs' '
> +	git -C clone1 branch -f special/fetched HEAD &&
> +	git -C clone1 branch -f special/secret/not-fetched HEAD &&
> +
> +	# create multiple refspecs for remote1
> +	git config --add remote.remote1.fetch +refs/heads/special/fetched:refs/heads/fetched &&
> +	git config --add remote.remote1.fetch ^refs/heads/special/secret/not-fetched &&
> +
> +	GIT_TRACE2_EVENT="$(pwd)/prefetch-refspec.txt" git maintenance run --task=prefetch 2>/dev/null &&
> +
> +	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
> +
> +	# skips second refspec because it is not a pattern type
> +	rs1="+refs/heads/*:refs/prefetch/remotes/remote1/*" &&
> +	rs2="+refs/heads/special/fetched:refs/prefetch/heads/fetched" &&
> +	rs3="^refs/heads/special/secret/not-fetched" &&
> +
> +	test_subcommand git fetch remote1 $fetchargs $rs1 $rs2 $rs3 <prefetch-refspec.txt &&
> +	test_subcommand git fetch remote2 $fetchargs +refs/heads/*:refs/prefetch/remotes/remote2/* <prefetch-refspec.txt &&
> +
> +	# first refspec is overridden by second
> +	test_must_fail git rev-parse refs/prefetch/special/fetched &&
> +	git rev-parse refs/prefetch/heads/fetched &&
> +
> +	# possible incorrect places for the non-fetched ref
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/prefetch/remotes/remote1/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/secret/not-fetched &&
> +	test_must_fail git rev-parse refs/heads/not-fetched
> +'
> +
>  test_expect_success 'prefetch and existing log.excludeDecoration values' '
>  	git config --unset-all log.excludeDecoration &&
>  	git config log.excludeDecoration refs/remotes/remote1/ &&
> -- 
> gitgitgadget
