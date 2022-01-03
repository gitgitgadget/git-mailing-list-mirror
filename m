Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44EEC433FE
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 12:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiACMXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 07:23:51 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:6154
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231509AbiACMXu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 07:23:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK2FAljclrBfO+oDJ2z3odEHnxH8lD8CmB5YtNOYJOKNT5o0bjw18V8dgJY0YgcCalFrGcmtuU6MMo+lPEOCzI075wBbRoV/U63ibnifPYtFwOS4TCnj8yqN4ViFHomLrl2BtGNGvIDLM0J9CGSmHEILiCPMju4+9lqlN2DAlAuijazTvoRbDmu+QgCKTN1uUS64fK+dj21Iem0820je5zGXgJ4Ys09KpR+ICAkbtGGpMztlD8zaOxlGXZ0dmFgiPVxdt6dq2bATV9iby9ObkCzOTDxaqG2qPMPVsppiPYm48LEM8pYgeXmTHEFvQI3jjw4PAlKJdm+VURtgETrYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSns4uJgxknetca8JhuNSJ4Ghj25KQiFu4odPZ/2qP4=;
 b=Rbm6Zj15FjmbnaJ9kp1YUZKF63R478itTp9FN+xyE2MJqvm0tIF26k/SemmkffaA+OJ2RBLTqTqueLp+Ph5RNol2QSzVfzf/yK4JM/U42ALLaHBkydHX70hE/PVTZXhVcbZfqC+TVqVcNYmamgmn602aaC4IhdeisHT8uFTp3DKMnjaqp+dpfFq+ZVCRgYCRopfFovs4939lPYjX5Hdltin2c95zGW4qKTgDP+rDunIyYyo1C8QIvSuCl/0/6k6r0TpjYEvg58EmYyEpe0cFpD6D+I9PE/u64MHk3NN6l9g4I4IQiNFjw4/byq1geRuEAL8VB1vUr6dY/zETn/m/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSns4uJgxknetca8JhuNSJ4Ghj25KQiFu4odPZ/2qP4=;
 b=JGN3OcGPSbAzXrSvNP8Eds+iOMgqFgSOdz+Kuv+sgG/eMTcOMp8wNTdyJ9zVE1t9eaB9WQPVVHlvqB6snzm1ubqflRJngbr7NaYhCPa4wnVhLu4RqDSITb53Vpl1RvyGBFNqjGkLae7KEZ3nW+tCsGAWbb0lsHgq7WvfT1kgbz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 12:23:48 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 12:23:48 +0000
Date:   Mon, 3 Jan 2022 13:23:47 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/8] merge-tree: implement real merges
Message-ID: <20220103122347.uba66kusy3ft7g2h@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <9fc71f4511b163bec53616d82e8fe5214facf060.1640927044.git.gitgitgadget@gmail.com>
X-ClientProxiedBy: AS8P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b607f8-5237-4823-c347-08d9ceb3e497
X-MS-TrafficTypeDiagnostic: PR3PR10MB4126:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4126AD20003E14EFD2E9B052B6499@PR3PR10MB4126.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:194;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cny89B+CcrsNoCLPgYpDM44cFBcv7KKqE6WNaIrM0qcPUVM1v8vJEI41EGYBsoid6Dldcg9NeHhlOpO/4RIelrZKUs0gIv1E5HhnDMziBxJ17qhpxt1vEkyWnzsifuozdQKQ8w3IV3SIon5KbsRP91DkRXDvXxqoo+lxGaFsUUaDAEpr/nvO70tStDmd9TLg6naxK1LZ4mbs455mGPhGSZg/eMej2Y2DCwGNXuHW6B7QcNAHyJ2w63YZj6QkEBg+6UGBPczhvuaa3YdXpDoIUHLxzQmUop1HhDaHk31Gl/Uu7cLzQ/WckYeF5P06BR+mlf3f4u8L+8OArJR3+ay9yRtXr4UrrR9JoeSq8paVTiLbEDud7SP6kKbA8YNBSw25sBIoVcfpenOSqWKZ3hGIHSB+tXjmYpG27GMd+eWln5ySToR0O+02vE0l0UuyXA8ULZCxWsKXb2FkrsgiIHEpcr4FAO9ya9mLYmpakcHtEthz21OQoGFHsmU4uSF6HEDSjnWU4wi9XMtlE+SCa7F+LU06Nr//5FtTEvH0uA+m3KsgZ154rKueruTD/FWIDrUGDE5grV2qcpxQrggUUieGg88AUOxhLmJ3zLEXDeDima1X83jrnCe6NWHHOBZKyLh7NCnDIHxg4695fymuJ+YXaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(136003)(39830400003)(376002)(396003)(346002)(8676002)(66556008)(508600001)(6512007)(5660300002)(53546011)(186003)(6506007)(8936002)(4326008)(66946007)(1076003)(66476007)(9686003)(316002)(86362001)(6916009)(54906003)(6486002)(83380400001)(38100700002)(33716001)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhteFBlSzRWNTkrWXFmSjJLY21uTzZtbU1hYmhlQ05QV3g0SUxZUnA0dTJh?=
 =?utf-8?B?YkM1RlhxdkxBRmwvNXRZT2RDM3dNUHo4WGZuckdIbUJCYXVpODZQMmF1V1dw?=
 =?utf-8?B?QzdzaDZwVDlmMyt4d0tHWW0wWXpNcXJ4UFp5RHZRN01tdmVSb0Y0NU9JYkdy?=
 =?utf-8?B?T3NIaDh5TDJLWDlCaWlHMU11N0E2NEwzem10dTZYU2ducDBURTJuRWphWWlw?=
 =?utf-8?B?OUVtdmN3Sy8wWHYrL0ErYzIxb2Z1VEZBdkJmcUFGcll0WUdEV2FQdWhQa3M5?=
 =?utf-8?B?WFFCRThvSzN5WTM0MnN5eHJMTlJraStUNTA3ZDE2QmJ1Vk1RWHF0K2NDWm8x?=
 =?utf-8?B?UGtZblVqUVA2V1p1K2hnN3BhMjcvMWJFY1VrMVk1NTFzQjlhRTJaamxnSTQv?=
 =?utf-8?B?ajdCaFZsQzYzbEpEYkt4VUhQZldpTEl5VnlGbGpLQmQ2am03L0xLa2RYWlVQ?=
 =?utf-8?B?WlFpb3B4aUxHU1FGaS9qU3ZXNWZWOTNFWW1pWVl6M1h6MndZdzZpT1NOY1FK?=
 =?utf-8?B?S0dqa2pjU3Q3elJzVWxIUUxzeC9sTGx2NzJMYTNJYWRIQkR3TjRQMms4dzY4?=
 =?utf-8?B?SzBCS0RKRUFLcG1MTVhCbnBrY3kzemZxSmZ1SWF3UzcyTDE0ZjlCdDNKbDVp?=
 =?utf-8?B?N3ZiUHJaY1RUb25ZYmFjUjd1QjZIVUpyN1V6RlluWUdOZmVuc0VJNHc3VXdV?=
 =?utf-8?B?MVJsUGZuYkd4RWd6eUFDOWVlZGNMNitMTnAraVI5ZVhHZGpaUG90VWpmdGdY?=
 =?utf-8?B?cDdvWGpCNk1QS1BsUTR4bEJCUXN1QVQwMVp4Mm1ZbWt3U3NNb1VzWEM1b0RZ?=
 =?utf-8?B?ZzVmUnBzeGV3SUMxSU1WS1R3b1RGYk51TTRHVlhPNmJEZkllZnZVSE5iSG9M?=
 =?utf-8?B?T2RSa1loUk40MndVblFGUTkyNGUrSkNzdUE3aFI0TzVzZkNYWUhmRlRabGF1?=
 =?utf-8?B?SE5wS0swY0ZDWnVuM2xrbmJrU09sKytUU2VNMGNKV05KdGlXSXVnYjA3c2wr?=
 =?utf-8?B?Z3A4citKZWxkT0NxSy9wdG5HSjVIYzhEVWVFR0ltTFgrQkZ4Y3ExRVJMdUFO?=
 =?utf-8?B?QW9mUXgyYzhsQ1Y1elpYeVNKcnozQWNvSWdNRlQ5T3htUUxKMk9tT0VZSHlK?=
 =?utf-8?B?N05KVG8wY0J2eXVOeDNYSVR1ZFJGZE5Sc2ZGb0FkNHFuaTI0Y2R1ejE2aEIz?=
 =?utf-8?B?ZFk2L1JaVE5HUWhMeVlUbG9RVWhQVmJVOW82UmJjQVpEa0g3QVpmSG83Rllr?=
 =?utf-8?B?bmJwMjJpTTIxaC9qeGovdzFjN1ZQTWw1MG5lbS9CaVI1SDZkTklzQjRINm1F?=
 =?utf-8?B?Rml5QkUrb25kTGRXNlFaaTBESDBVRXY1RFFMSkZSdFBYTGZlMk5ZTFgzL0dp?=
 =?utf-8?B?a1Uzd2VEOTR2NG5FTlNSYjZXYTRzSXNHVVNRYnlrbU94VUlDNkphcFFvWnFn?=
 =?utf-8?B?TXdIemtQZXlUcWtjV0VmTWsxcUtZdGtIRllpdjFrWXpEcEZZZEVmemlPaEJw?=
 =?utf-8?B?bnU4cGVMTTlLbkpRdnJ5ZVVjd05ZQUV4aVVmOEZOcCtSeFo2U1NpUERpMklV?=
 =?utf-8?B?TDRTZlhUSkdRUVEyRTZ3TmlNZFBWcnNvbTZOOEdSckRDTDZyZ1F2TERNeVhS?=
 =?utf-8?B?T0VMaXZwZDBIL1FpaURHd0hyVGlSM3hudGRKUnpMdjNCcERITE9pUzhKcnF3?=
 =?utf-8?B?S3h2dVArWFFCdG1BNGNXUGUxNzV1TjJhNFkvb2RHQnIyWmhkNGFOYmJHTEJK?=
 =?utf-8?B?V1YrNHZGY2VWR1c3OWtUNzBWbmE3clBTa3VpSVN1M25lL1BDanNJdzQ1Vlhn?=
 =?utf-8?B?VFZDTmUxL2pBMm5DcS9pb1NoYzBvbjZvczBxYzNPUmtCMjkxdGxycWI5OHNp?=
 =?utf-8?B?TFVFeVFlQU90YzVSUWgwSjA1bTJpRm5pY3A2OGZqSDhCMEZnN0NscDRHZXpv?=
 =?utf-8?B?NTZVZ3lFSCt4MmZuRlBBd0JEYWRJNDVmM2tHU05jdE8xelJBZ21pdzdabnY3?=
 =?utf-8?B?UmZLNlBmeXUrSXZRMUZBNHJzclRobUh2QjRxUTlVZ1AyWWhnRGR6VWFtNkI4?=
 =?utf-8?B?L0xMZG85cURyZFZXb3RyUGZKT1NPNFpjWDYxQVlUUHUyYVNxRGR2a3ZXcjJz?=
 =?utf-8?B?SGZJenhpWHUvR2YzL3NodGQxZXNkWEwrQmEvZmkxTG1XOW1xckpTQUZiRnpQ?=
 =?utf-8?B?MGsyT0lMZXdaVXoveWlQaFBIZVNjNGNCZVRSUjVCNzFiWVFqV1IyQ2IwMWtG?=
 =?utf-8?Q?TyWLHCfO2p4dIgd4cN5fssEHkt3Zt44hmBI1+x7prA=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b607f8-5237-4823-c347-08d9ceb3e497
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:23:48.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoUKqLkt6gxuIODovWrFx/9yWeFGb3BAWaPs7NgoyZVm7rqhsvhICJdcQZTGHZmYnmeu4YupDqaIhKP/W/qgPGZAM1GIVo/jmEO9hnFPwfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4126
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>From: Elijah Newren <newren@gmail.com>
>
>This adds the ability to perform real merges rather than just trivial
>merges (meaning handling three way content merges, recursive ancestor
>consolidation, renames, proper directory/file conflict handling, and so
>forth).  However, unlike `git merge`, the working tree and index are
>left alone and no branch is updated.
>
>The only output is:
>  - the toplevel resulting tree printed on stdout
>  - exit status of 0 (clean) or 1 (conflicts present)
>
>This output is mean to be used by some higher level script, perhaps in a
>sequence of steps like this:
>
>   NEWTREE=$(git merge-tree --real $BRANCH1 $BRANCH2)
>   test $? -eq 0 || die "There were conflicts..."
>   NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 $BRANCH2)
>   git update-ref $BRANCH1 $NEWCOMMIT
>
>Note that higher level scripts may also want to access the
>conflict/warning messages normally output during a merge, or have quick
>access to a list of files with conflicts.  That is not available in this
>preliminary implementation, but subsequent commits will add that
>ability.
>
>Signed-off-by: Elijah Newren <newren@gmail.com>
>---
> Documentation/git-merge-tree.txt | 28 +++++++----
> builtin/merge-tree.c             | 55 +++++++++++++++++++++-
> t/t4301-merge-tree-real.sh       | 81 ++++++++++++++++++++++++++++++++
> 3 files changed, 153 insertions(+), 11 deletions(-)
> create mode 100755 t/t4301-merge-tree-real.sh
>
>diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
>index 58731c19422..5823938937f 100644
>--- a/Documentation/git-merge-tree.txt
>+++ b/Documentation/git-merge-tree.txt
>@@ -3,26 +3,34 @@ git-merge-tree(1)
>
> NAME
> ----
>-git-merge-tree - Show three-way merge without touching index
>+git-merge-tree - Perform merge without touching index or working tree
>
>
> SYNOPSIS
> --------
> [verse]
>+'git merge-tree' --real <branch1> <branch2>
> 'git merge-tree' <base-tree> <branch1> <branch2>
>
> DESCRIPTION
> -----------
>-Reads three tree-ish, and output trivial merge results and
>-conflicting stages to the standard output.  This is similar to
>-what three-way 'git read-tree -m' does, but instead of storing the
>-results in the index, the command outputs the entries to the
>-standard output.
>+Performs a merge, but does not make any new commits and does not read
>+from or write to either the working tree or index.
>
>-This is meant to be used by higher level scripts to compute
>-merge results outside of the index, and stuff the results back into the
>-index.  For this reason, the output from the command omits
>-entries that match the <branch1> tree.
>+The first form will merge the two branches, doing a full recursive
>+merge with rename detection.  If the merge is clean, the exit status
>+will be `0`, and if the merge has conflicts, the exit status will be
>+`1`.  The output will consist solely of the resulting toplevel tree
>+(which may have files including conflict markers).
>+
>+The second form is meant for backward compatibility and will only do a
>+trival merge.  It reads three tree-ish, and outputs trivial merge
>+results and conflicting stages to the standard output in a semi-diff
>+format.  Since this was designed for higher level scripts to consume
>+and merge the results back into the index, it omits entries that match
>+<branch1>.  The result of this second form is is similar to what
>+three-way 'git read-tree -m' does, but instead of storing the results
>+in the index, the command outputs the entries to the standard output.
>
> GIT
> ---
>diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>index f04b1eaad0a..c5757bed5bb 100644
>--- a/builtin/merge-tree.c
>+++ b/builtin/merge-tree.c
>@@ -2,6 +2,9 @@
> #include "builtin.h"
> #include "tree-walk.h"
> #include "xdiff-interface.h"
>+#include "help.h"
>+#include "commit-reach.h"
>+#include "merge-ort.h"
> #include "object-store.h"
> #include "parse-options.h"
> #include "repository.h"
>@@ -391,7 +394,57 @@ struct merge_tree_options {
> static int real_merge(struct merge_tree_options *o,
> 		      const char *branch1, const char *branch2)
> {
>-	die(_("real merges are not yet implemented"));
>+	struct commit *parent1, *parent2;
>+	struct commit_list *common;
>+	struct commit_list *merge_bases = NULL;
>+	struct commit_list *j;
>+	struct merge_options opt;
>+	struct merge_result result = { 0 };
>+
>+	parent1 = get_merge_parent(branch1);
>+	if (!parent1)
>+		help_unknown_ref(branch1, "merge",
>+				 _("not something we can merge"));
>+
>+	parent2 = get_merge_parent(branch2);
>+	if (!parent2)
>+		help_unknown_ref(branch2, "merge",
>+				 _("not something we can merge"));
>+
>+	init_merge_options(&opt, the_repository);
>+	/*
>+	 * TODO: Support subtree and other -X options?
>+	if (use_strategies_nr == 1 &&
>+	    !strcmp(use_strategies[0]->name, "subtree"))
>+		opt.subtree_shift = "";
>+	for (x = 0; x < xopts_nr; x++)
>+		if (parse_merge_opt(&opt, xopts[x]))
>+			die(_("Unknown strategy option: -X%s"), xopts[x]);
>+	*/
>+
>+	opt.show_rename_progress = 0;
>+
>+	opt.branch1 = merge_remote_util(parent1)->name; /* or just branch1? */
>+	opt.branch2 = merge_remote_util(parent2)->name; /* or just branch2? */
>+
>+	/*
>+	 * Get the merge bases, in reverse order; see comment above
>+	 * merge_incore_recursive in merge-ort.h
>+	 */
>+	common = get_merge_bases(parent1, parent2);
>+	for (j = common; j; j = j->next)
>+		commit_list_insert(j->item, &merge_bases);
>+
>+	/*
>+	 * TODO: notify if merging unrelated histories?
>+	if (!common)
>+		fprintf(stderr, _("merging unrelated histories"));
>+	 */
>+
>+	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
>+	printf("%s\n", oid_to_hex(&result.tree->object.oid));
>+	merge_switch_to_result(&opt, NULL, &result, 0, 0);
>+	return result.clean ? 0 : 1;
> }
>
> int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
>new file mode 100755
>index 00000000000..9fb617ccc7f
>--- /dev/null
>+++ b/t/t4301-merge-tree-real.sh
>@@ -0,0 +1,81 @@
>+#!/bin/sh
>+
>+test_description='git merge-tree --real'
>+
>+. ./test-lib.sh
>+
>+# This test is ort-specific
>+GIT_TEST_MERGE_ALGORITHM=ort
>+export GIT_TEST_MERGE_ALGORITHM
>+
>+test_expect_success setup '
>+	test_write_lines 1 2 3 4 5 >numbers &&
>+	echo hello >greeting &&
>+	echo foo >whatever &&
>+	git add numbers greeting whatever &&
>+	git commit -m initial &&
>+
>+	git branch side1 &&
>+	git branch side2 &&
>+
>+	git checkout side1 &&
>+	test_write_lines 1 2 3 4 5 6 >numbers &&
>+	echo hi >greeting &&
>+	echo bar >whatever &&
>+	git add numbers greeting whatever &&
>+	git commit -m rename-and-modify &&

The commit implies a rename as well which I think is missing.

>+
>+	git checkout side2 &&
>+	test_write_lines 0 1 2 3 4 5 >numbers &&
>+	echo yo >greeting &&
>+	git rm whatever &&
>+	mkdir whatever &&
>+	>whatever/empty &&
>+	git add numbers greeting whatever/empty &&
>+	git commit -m remove-and-rename

And this looks more like a remove-and-modify. Is it still a rename when we 
empty the files content?

>+'
>+
>+test_expect_success 'Content merge and a few conflicts' '
>+	git checkout side1^0 &&
>+	test_must_fail git merge side2 &&
>+	cp .git/AUTO_MERGE EXPECT &&
>+	E_TREE=$(cat EXPECT) &&
>+
>+	git reset --hard &&
>+	test_must_fail git merge-tree --real side1 side2 >RESULT &&
>+	R_TREE=$(cat RESULT) &&
>+
>+	# Due to differences of e.g. "HEAD" vs "side1", the results will not
>+	# exactly match.  Dig into individual files.
>+
>+	# Numbers should have three-way merged cleanly
>+	test_write_lines 0 1 2 3 4 5 6 >expect &&
>+	git show ${R_TREE}:numbers >actual &&
>+	test_cmp expect actual &&
>+
>+	# whatever and whatever~<branch> should have same HASHES
>+	git rev-parse ${E_TREE}:whatever ${E_TREE}:whatever~HEAD >expect &&
>+	git rev-parse ${R_TREE}:whatever ${R_TREE}:whatever~side1 >actual &&
>+	test_cmp expect actual &&
>+
>+	# greeting should have a merge conflict
>+	git show ${E_TREE}:greeting >tmp &&
>+	cat tmp | sed -e s/HEAD/side1/ >expect &&
>+	git show ${R_TREE}:greeting >actual &&
>+	test_cmp expect actual
>+'
>+
>+test_expect_success 'Barf on misspelled option' '
>+	# Mis-spell with single "s" instead of double "s"
>+	test_expect_code 129 git merge-tree --real --mesages FOOBAR side1 side2 2>expect &&
>+
>+	grep "error: unknown option.*mesages" expect
>+'
>+
>+test_expect_success 'Barf on too many arguments' '
>+	test_expect_code 129 git merge-tree --real side1 side2 side3 2>expect &&
>+
>+	grep "^usage: git merge-tree" expect
>+'
>+
>+test_done
>-- 
>gitgitgadget
>
