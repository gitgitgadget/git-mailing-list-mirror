Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51704C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1407C613D8
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 19:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241688AbhDFThE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 15:37:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbhDFThD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 15:37:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JSxX3130145;
        Tue, 6 Apr 2021 19:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=UgCh64ua0Ps0wicCOPfpl0sufiSlQVIT0Lyg0ur2APs=;
 b=aAMvwkOhWwQlAH/nZO9BRgLMyIcxwFtX+C9LrMQkc+RmpPl2lDol9vSTmwPD8qzY/U/A
 TvwzfhfpKEXR9gYth4oSBxSPWMJ3iv6cX0YeknDiBQIwbj09Endsxegx6ooxZZloPP9k
 iFm4QH0DuySKJYh7BzabSYG49HKkc+el5L+3IcFAgxIY49To+5S+RhIxm68QcJrCUlRD
 YSKzufotdAQdl9idpiiamE7CyXwO5G//3M5O7sBDdbrtVHgDjRTMmdp0th5Vi1ldBIZA
 IH659Lfk7xtEDxPwG6Rjq9ZLhHGYcRjS6pAynWCGLDiMJ3LxQCbdpe3d77kqvnj5qKIQ MA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37rvas0a8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:36:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136JZubj090870;
        Tue, 6 Apr 2021 19:36:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by userp3030.oracle.com with ESMTP id 37rvbd47f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 19:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aby6pe5qPyCYKxBNzufeiX+TYtZi7D3Rx2jhEWsNhwTJIxgDITVXIEN4GYW+DStiLJ1rUT2qVrT+mXCZMuCBN2M39JjHwIHz2ywUOtVmm6vYI5F9xKrfdM2D9IIfncv65akVPHRJnzhHXxkXZv3Ggl4MNb2AF+mXvM2zKbLTlHiGOaW1aRanNo6/040mdb6XEUVMALmsM4yMU+bQqKIJF0Fc4c6HJCLRYNUTlEbxamS+NasRXNWRWrWnILSWPZbqllaKjAUyJSZaH6UeSuiAQwb43pTZQEEoyJ0MDq5QfbM2im9C3ju6P6V2U+BLtHOPtqLJxchdyhcM/MX0yNjTpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgCh64ua0Ps0wicCOPfpl0sufiSlQVIT0Lyg0ur2APs=;
 b=oF4AZRq336kSz1UuFXqzYlNyTYSQvcwy1O3RFrfa/0x/LHkO5FNsuS53btqv7gLnhZgxczbzl4KsqFbCYLH4/hsKON4R0EgkxRP0L3OEtrCP8eJ847RhogVPkv8mDFSMzt3iRC/sq0bxITdiMdfdystA5AM8EhEOS/UmZ94rAHtugzUjVvOQWM+lQGPzUulkCzNKHnOu1NE8wkpCn87qiN/K/3yOz2Xvw1qc9dk+AzimzKIBXNZTXd371oGGXD/JYWIRXv6b7e4HKGXYs8a0ZYwwPe/9+eZ6BtfuxJmBhO7GKAHQHcgDsmVAIssVQOX3kF51c7Hxtg4Q3k8zenh/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgCh64ua0Ps0wicCOPfpl0sufiSlQVIT0Lyg0ur2APs=;
 b=Tu29jk61vdks1BZpOZ8EmVuBFPhbfo9HlKjN73oe7aWDI1rCvhzo6AuY+Hu4GSeZtyYy2c44jL+FLXp/ULSW/KoxmBP5oe1LnS5/54nJWZW8dczF3GURshVYYZBvlmYYjFgp1M6vKm0K6RBr4HAk8wxLehzG5mgwMUBwLYF/4sA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB3747.namprd10.prod.outlook.com (2603:10b6:a03:1f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 19:36:42 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 19:36:41 +0000
Date:   Tue, 6 Apr 2021 14:36:37 -0500
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
Message-ID: <20210406193637.x2xqkkyqbjabgzge@dhcp-10-154-113-61.vpn.oracle.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
X-Originating-IP: [70.114.130.219]
X-ClientProxiedBy: SJ0PR05CA0128.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::13) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-154-113-61.vpn.oracle.com (70.114.130.219) by SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 19:36:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0189301d-4903-4bb2-b278-08d8f9334d46
X-MS-TrafficTypeDiagnostic: BY5PR10MB3747:
X-Microsoft-Antispam-PRVS: <BY5PR10MB374742310E0B0E438760DD72FC769@BY5PR10MB3747.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79atGHiPQD+ytr+UXvlJGTzj0v7QkdZg71mR3A9F1SPMbvaf1rm0x2KrtVViHI8PxH1EuvBiQaG3jRmusB1+Mv5JFbYC+3vpHQkBxQhGuyFVWXLE+hijL6YZwyKtG5VURD7xj1uuwRVv5yZzn/kOrX4JXev1LaqjOAlEp0xbE0nS8ho+8J6V4uuGZ/NoFYU79JEzuxLwe4tTiG+N8zsvcUNyIdTp+lctVP7SVxusOuB40D9VhayeMMOLMeJt3rRC1aNZSAar9JEuHaWtjRgX6+vUhc5rj8HCjFCn1obZ/tOTyyD8Ayjn5PbNrJsad+tqH7k+oPiyFm3NQqhO5lnihIy3FUWGkFs6NCCI+DkQn5SmHMwmwsy/TOB0ck7c19PKnAjcx4BuIzkuEmfu+g2nkhtG1kTG+Lf3PhmZ6xAtYKq/RPDWYuqsiv2sgAPOBweGqvipwB/5196X/JZQNTpwaOMiRzje2L+KdDwqxXdomFQgUcAOudf7JP78pqCEz6e5tfqFnOCK0lzshgZkere1ZiZ2sSQAkCyp8CFcFP0OMG5gMTAtaQq5k1goyat3wuaLw79N/xq6Isbbp4+M+inyg0Nlc2OdlqPYp0O/QCOu5lDuTLzZGT6B/hiXrv1NFhMah9U9HPFQLE2Q+rT3Z7u+4dPROgEMD4LuWQVdgLqPUZaIXlBWGRCM2HZ+iSpYAMpHl4j4JADw49vS4RrxNR6cVBx2TE0sXOyjW9AxBc2+zHnBQfu7n9/1xtnh7jQFXAEYUuVL1i63LZCjNKAnoJ0qCCIQCUxOl8FxxO0DRxVGBUBXTO6GsVg5nnfG3jpYfpgT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(346002)(376002)(396003)(4326008)(44832011)(66476007)(6916009)(5660300002)(45080400002)(66946007)(38100700001)(38350700001)(2906002)(86362001)(26005)(1076003)(316002)(478600001)(956004)(66556008)(54906003)(8676002)(8936002)(7696005)(52116002)(55016002)(16526019)(966005)(83380400001)(186003)(102196002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x3A9cXo5+o5psLTNn8L1JTirJkwA7Djn9z9A1phAIZ4Usvk+cWtHSosB74ye?=
 =?us-ascii?Q?9uWV5lka+Mn+E0pfcSPG5N6wHxDt6n+hnqcouDTKtKn7GPLNRMm73SDLu3+F?=
 =?us-ascii?Q?DrHQPjGMdVch+XUSTAAqg0YBcQBOLZUS97eJnZ+tZ1FmH0e3e6Jhro3xCHWm?=
 =?us-ascii?Q?uOKz2XuZFVM9QEHDyE0K0wHefBi0dd3ZTqjBg/whdlbeueVSaWJVb3SUHn2i?=
 =?us-ascii?Q?LUr3DLXlKowe4lwwan4LgDUIM4YxWLgII3TgfXvSlzLaSYmXviWdWt6pmDlc?=
 =?us-ascii?Q?H8XGX3bIgV0hKspaXexqSA4rUBopeXXSqYl2v5iEjZSqs2B9E6BIYucGPakg?=
 =?us-ascii?Q?pZC7T8Wxof/Fv8FlPE9QuvsmYVI3t3KFZWXU/Mx6ABMLHKJvMqYOx0sxl7WT?=
 =?us-ascii?Q?Mj9IF0emDUx1ymkdaMxMnPGjoyjJgJZB6lmGlVpcapauuCNgLE8I2tq/DX+t?=
 =?us-ascii?Q?3wM52tbcyrU23glECJGDsyvrEXwsYCJmH8ZklRSPa4kg1B0J8NVAtHrLRMuS?=
 =?us-ascii?Q?y6XGMCW4g/cqp3mQcHFw1hPwrVgF25kWEarHKLVnkktNScVggN3thpuwZ0nc?=
 =?us-ascii?Q?uA/kit2U6nSJURSnw6aQn2efyIvMHNTKb7au05/1yuKp1OalFVgHcMfty5yt?=
 =?us-ascii?Q?+BuwOUaYhWghjOM3Pz8HLBh0oaHPXu/zK0tnch6c9DQxU8qu/EXsiqthK0Nk?=
 =?us-ascii?Q?70BH9fznhZ5kozOzW6wEiz/TTPjiY5bobNToA3WnyVT5OQSYfqgoPHh/JeZf?=
 =?us-ascii?Q?cw/y5VqIPxL8JOCQTL1vhVbIAUTrdQ7vrCNLT2m/WepijlHSFvrfYqEqCLjM?=
 =?us-ascii?Q?FSb9zCnQzeLVjmmbhoX8NNsqI7OPB+oMN9n4nco25/M8QwhFnhxwmdkGmdmP?=
 =?us-ascii?Q?wCmEWpZ1jYqHlCEk48HSVRiHIKAzyx27ScQt3CvmvEh60bww7WWrqHuTzvhn?=
 =?us-ascii?Q?3n57EEbb7RArIHS7IO8N8VOPiZATVZbRDeYiyyQFWDI7XRXVZULMZpX5IKcF?=
 =?us-ascii?Q?I1sQwdUGsZlWXNp/y2q/3uRZWSuzVSI398D6GVox1nIc8QvV9KagDqjTzdEa?=
 =?us-ascii?Q?VEOfwBiPib8eBq8WBvqnRJzV0wPsulc8sG3uWUzSjqqFpFAUEwc2KG9RyAgI?=
 =?us-ascii?Q?X42Nu32ocBjFysdWRZABxeuWAOIkAlck6jK/6Y3DeO64y6sZON2KDgTPLExF?=
 =?us-ascii?Q?qGIWCd90RZMWdtk6omrQPUB49fd/BVZVIyOho/KOkSvw8ZuJDyZI4ZL59kwU?=
 =?us-ascii?Q?RGS276qN1rIeik0b1ch1LR1vMxYbK5nySsCvqE2mxRQQKJz/tbwDWV8MV4jn?=
 =?us-ascii?Q?gMBdpijAreT/igT/xjjmofHK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0189301d-4903-4bb2-b278-08d8f9334d46
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 19:36:41.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKPnxNSS1ht0KSQGKOiCCzTfoNtvCys4x0E3seCYD27tlllr7ONqRtFt7Lyf53LAnLbuhtRIEspcXzjEUlzxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3747
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060132
X-Proofpoint-GUID: TF0gyrpJjEq1_ahJ0nmUsAXBMDixChCP
X-Proofpoint-ORIG-GUID: TF0gyrpJjEq1_ahJ0nmUsAXBMDixChCP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104060131
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 06:47:50PM +0000, Derrick Stolee via GitGitGadget wrote:
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
>  builtin/gc.c                      | 37 +++++++++++++++++++++++++-
>  t/t7900-maintenance.sh            | 43 ++++++++++++++++++++++++++-----
>  3 files changed, 74 insertions(+), 9 deletions(-)
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
> index fa8128de9ae1..76f347dd6b11 100644
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
> @@ -886,7 +888,40 @@ static int fetch_remote(struct remote *remote, void *cbdata)
>  	if (opts->quiet)
>  		strvec_push(&child.args, "--quiet");
>  
> -	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote->name);
> +	for (i = 0; i < remote->fetch.nr; i++) {
> +		struct refspec_item replace;
> +		struct refspec_item *rsi = &remote->fetch.items[i];
> +		struct strbuf new_dst = STRBUF_INIT;
> +		size_t ignore_len = 0;
> +		char *replace_string;
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
> +		replace_string = refspec_item_format(&replace);
> +		strvec_push(&child.args, replace_string);
> +		free(replace_string);
> +
> +		refspec_item_clear(&replace);
> +	}
>  
>  	return !!run_command(&child);
>  }

Junio brought up the point about configs which 'fetch' have no dst
https://lore.kernel.org/git/c06a198a-2043-27a2-cab3-3471190754cc@gmail.com/

    [remote "submaintainer1"]
        url = ... repository of submaintainer #1 ...
        fetch = master
        tagopt = --no-tags


This patch fixes segfault for config like above.
You might have ideas on a cleaner way to do this.
I did add `child_process_clear`.


--Tom

diff --git a/builtin/gc.c b/builtin/gc.c
index 76f347dd6b11..921266ee30a5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -879,6 +879,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
        struct maintenance_run_opts *opts = cbdata;
        struct child_process child = CHILD_PROCESS_INIT;
        int i;
+       int nargs;

        child.git_cmd = 1;
        strvec_pushl(&child.args, "fetch", remote->name, "--prune", "--no-tags",
@@ -888,6 +889,8 @@ static int fetch_remote(struct remote *remote, void *cbdata)
        if (opts->quiet)
                strvec_push(&child.args, "--quiet");

+       nargs = child.args.nr;
+
        for (i = 0; i < remote->fetch.nr; i++) {
                struct refspec_item replace;
                struct refspec_item *rsi = &remote->fetch.items[i];
@@ -900,6 +903,10 @@ static int fetch_remote(struct remote *remote, void *cbdata)
                        continue;
                }

+               if (!rsi->dst) {
+                       continue;
+               }
+
                refspec_item_init(&replace, remote->fetch.raw[i], 1);

                /*
@@ -923,6 +930,12 @@ static int fetch_remote(struct remote *remote, void *cbdata)
                refspec_item_clear(&replace);
        }

+       /* skip remote if no refspecs to fetch */
+       if (child.args.nr - nargs <= 0) {
+               child_process_clear(&child);
+               return 0;
+       }
