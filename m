Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A3FC433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiACMbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 07:31:18 -0500
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:45921
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231774AbiACMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 07:31:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewJDsnx0JfV0WDLgdfDfJ3d+darWIELfwtZYONjziWIOr5f+m+0bMqazVquRWYGIcnVDdZjl5cVN1FimFPUZUnVNcx0pxm2GEreOuHQ0IGjt0KpWRZ6XLa4mhEyDkGLnQVMigSQnJcvvEypNiGjNWOd8Z5W2brR8pl1tDCFf3eFYEKJbsURbHGvPkxtzKRVrI1Me4rges013RBG/Lp/SxYF1rcpWU6KOwclmxQ64rdfmNbq/KyVXwuNqj1DahUVawlhsmEh99nNu9+nGyeqZutt/wnmtzpcZKd22P7bSBLuHP/xUCiW/Yp3w5/HHzT2jqdWYcEqVrdwSmqEO+YDLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5OxGy7vBsH1OEZI0qQmjEjca1ABh5lqb9EEDSfLLEk=;
 b=N4fU8IbscBroZI0DhKUUt0Y8qsyRryOiFIktf8iP4Hf2W8Zi9eKn/dkKAY8FdqwO2wQGG8g/MK32IpYpNgt5g4dL6iGPdm2ozV32ThgB3l6JRizyJkrEog/YQnHyCHPvVnDbcfAxGcZ/zHRwqBulUcCy3bkzDcsfJqP+Pb038fHX8mvj+hlNsa6jBR5bas0uOqVtgUCJoTQ/aVxzKcjeYlq7emIkEHbmatABqdMKtoTfcg6Ryw+kKzQ/P2GkQ1ve3DfABqHFKpAGk3tW6mgtrM9sg1HPQAqK+9yHbMIzJ+zHTC5tRtIgVJBZh5u1ae/Pb8jW5tDTu0v0geogp37nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5OxGy7vBsH1OEZI0qQmjEjca1ABh5lqb9EEDSfLLEk=;
 b=eIPOwJXBNZX0pm3q/lIlxcYXaxNcceOd2Rga6GsgBPYVw6xDIwl0bX/r6/+WFq0xWqMPuo3hEYmg9jW1QWVuBGtl9dOa7ihl/d5RkLRX9FBZSLlY3YOKe+UwyEx4XN/irn6YhppUpblc1iQdom53ICbXxgbny6G3+IRmllZz+go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4254.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 12:31:15 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 12:31:15 +0000
Date:   Mon, 3 Jan 2022 13:31:14 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
Message-ID: <20220103123114.uuvpk4nley22gfkg@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
X-ClientProxiedBy: AM6P193CA0073.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::14) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcd66a4-4dc5-4680-cbbb-08d9ceb4ef0e
X-MS-TrafficTypeDiagnostic: PR3PR10MB4254:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4254728FFCFAE6B52758A264B6499@PR3PR10MB4254.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3SXj7ikH8B0cOCAZNBjXx/1RWCXAhz3tM0Eo6OsvwIo0/42Q9bgxZXit7MN2p6tI9RpiifvkA0/oDCFDHOA2wgflMUpchVf7A/pLd/GTsj7aKNlTXF7EBFozku0yxhoIx4ivw/KUZFHMEd/t7FW9Uf33DLaRO5dETzBjjIiQuFW/bqkowsBrtLcbFUGC+FGP3u8iUm8J44SYd5SFGUx6rSCwhVhc9aUvt4gg54c9WqcAaZnR9/u0f4pbeSOt8rJ1a9FlecdO6rgS8D/hynIuZFnzYGqS9+Pu/89+k6oYU/0XGmMKPr0Zm/VR0Ak95sc2c6U9zlar2eUuHpxTd4EZ7zeKvct9KZcCPEuneGuK9QWdopYuCoKA/9NRo8lSETPNAV3Piod3zzLrlIKulBcsPOcy7292h6+aX/mPgpn/8OlAPXtDYTHxR+HRQ/5dysp006RTD6upM62jzhIU60kEaP577kYy2x8aKTblDig7C0QMUSA42Y0sOe54r/khN0e86q6JR7EMEy7eqzUhKLpqNCq+FHIouyL+syaFDOzOuhwRuYQUzOgy48Syr/k0izYymnsCDbFelKIKDV8Sl/63k8ttFMntBp7/PvYRXa1ZUXSGf5Lt6PZWcQ0wm8cc+g38eq+28bIyUgCVjbiBBCdXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(346002)(39830400003)(376002)(396003)(26005)(66476007)(6506007)(83380400001)(66946007)(53546011)(15650500001)(6512007)(2906002)(66556008)(9686003)(6916009)(186003)(6486002)(54906003)(38100700002)(5660300002)(86362001)(33716001)(4326008)(8936002)(1076003)(316002)(508600001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhyVHJmYUNNeGpIS3lIa1JwSTlTK0FxS1c0SXBxbm44YUN2bDhaeFZpNGZh?=
 =?utf-8?B?VVYyL3prejdnRC83aWZLbFc1R0oxc2VVTm13ckh1QWdXVlZiRmdQT3I4T1Zv?=
 =?utf-8?B?RUE1eHNRUGpLWkFnc21pTkxuVEpUaFRtbUgwSGR5WGJXL1NkNmRFT0dHRDFq?=
 =?utf-8?B?MGlCL0EyWkZUMUs2bUZBVGxMSFprTzE0NlBmbHBVcVRubVBZTk5oNDJsMWM3?=
 =?utf-8?B?NkozRk9QVFZnb29pZTBaQmNIc01tWk5ZdUI1ZzJ1Z0dJb0dJd3g2MVpwa3Zm?=
 =?utf-8?B?YVU4MmQ1S09rb1gzVlZ6aS9JRDJYc2wrU25uRGJWV3pDd2oxVWtQYUFjZEhV?=
 =?utf-8?B?ekZzbXFPZlJXWVJLSklCa09PVmNMU0pqOXZkTm8xb3VTbVROMlYrSjE1STFJ?=
 =?utf-8?B?ZVpibmRkVVNLRThEVDR4Y215RHZYRW5kVFJSOFNhTWc5cURwNXg2Ymo0Q1c4?=
 =?utf-8?B?S2NKblFYanYvMDN0QWJSQlhxMDZYR0pnRCt6blM4M2RDTzE3STFydDB4b2Vz?=
 =?utf-8?B?Q1ErZzBpOVlxbTZ6VkxsVXRwMmlmVDFMSDBNVmtYdUcwS3cxKy90cnV0Y1VY?=
 =?utf-8?B?YW1McThpMnRqVGRNR1JwT3ZtTWVxOCs5dmhsVUl0VUhERlAxT1NJb3BoTlJp?=
 =?utf-8?B?L2l4dk52Sjg0UmpaS2JaUVZHQk9sdDloWU1mUVluRHcrMk1NRC9HVEJNMEc4?=
 =?utf-8?B?OVBTaVp2dXNUSGtGUVpwRnhwZ1ZkcHh6UFFXMnFabkxzZUwrdXAySTc1WjM4?=
 =?utf-8?B?c09HeVE2Y3JJVmt6MU9JQlR5WXlFV05rS1puaDNYYzRRL0E4SEdSNUV5dk8x?=
 =?utf-8?B?YTU4RzhacjZhU2lXQTNpVmpIY0NQRjBHQjBTdnJnUU1jL29xUThQNUxhdzVn?=
 =?utf-8?B?aktaTWNJcDR3NmVNNWFjWkQxS1FLWWFrelpFT3hnZFlpWjR3cUk4ckhTWGhm?=
 =?utf-8?B?SkZHRWpkN045dUNlS1djRVoweXByZFhpNWhUTHk1Y3RMM1hjWFl2TzRhNVRP?=
 =?utf-8?B?UVp1UTRlRnVNaWNqSk54SEdXcmduNS9TemFIam0zUE1FZTNwMUFCbXBDOW4r?=
 =?utf-8?B?a3U0S3hTL0JaUDlNT2JDNjdyYVdYRitXcmFvTmpCZXpZUXM0UldBTjNJckFE?=
 =?utf-8?B?RVlhOERuT0Y5NlRhU2tvQVJxSWR0SnA1NmtjRW1JVUNPNnJWbEI3Nkg3MXhI?=
 =?utf-8?B?bE5veHNhM0RWWlJTcWN2WE0xTWFaTEtsZTN6UEJweFpJbldYQlE1TGJCQnBW?=
 =?utf-8?B?UEp6OHR5eUIwOUMwUFR3c0FDUVQ2aTdHREpNTDBEdnkvMW1MWG44STJJM2Ev?=
 =?utf-8?B?dlkrbmF1YlhaSTZKUFBzc0lTRVpKTVEvSkh1c0hVVjNDOHprN3N1UmJOZFl2?=
 =?utf-8?B?VnkwOTZUTWdBMXNlWEtDc01tWmtlNjIzbW5hRTlCU2FROWc2ZERyU0tRVXVS?=
 =?utf-8?B?dmdmMkVZUjFlM3FONE82c05IN0t3OVlOeXhWOEFBQjMxWnYzOEZsQ25SdFBL?=
 =?utf-8?B?MXlRbEE5aG1LVmpRQk9DYzhyU2dXb2dHSkM3U1B6VC9ZMjJjVVVLNEdsSTRp?=
 =?utf-8?B?RHZSWHdOVU95NGhWL2lKZVhvYWdiMEkzOGZxdW1vVFZ0cHVqYVIzWTFXemNh?=
 =?utf-8?B?bWJRR2NhVmFoNjR3YldzbFE2S0xyWWhtNFplaDFrS0UwY3dYS0wxNVl1RWU5?=
 =?utf-8?B?WkxxKzgvMVg3S0k0RENLelJTVWxUR2RPZ3c2THdOQmttREQ3L2dUUklaU1Zt?=
 =?utf-8?B?V3hkRi9jTnpUcTYxNVQ1dzZmZVpkZ2gzUU9zRkhJb3hQRHM1b0FJL2NYOTcz?=
 =?utf-8?B?cEtEQmV3SlQ0N0RwMkcvblgxbEhjY2djMmR1ODR5TExuV1hoOUpjVDY0U2dJ?=
 =?utf-8?B?aEVkem9RMnpUT1ZvQS9OdmdMOExrQjRzZFJ4YithdjdLYnRNK2JTOGdIdk02?=
 =?utf-8?B?VEJJVVB2cWVmeW5NMFBHSlFWMWxNTS9vMXNEb2lwTTJJSm56ZUFDL2Y3YXhh?=
 =?utf-8?B?WmRqdHVRZXlyRjNqLy9oSTVuRXFwc1oxbFoyOTZYUGk5RVVaS0tiUERFZEd4?=
 =?utf-8?B?b1pTbjM1MXF6ZkhQb0pmK0FNK08vZmEvTWdXamhGcnN4RlZBM0VacXlxYllS?=
 =?utf-8?B?cm9hL2VqZkhDOXZrL1VLejJWMTAvcThXQmlYNFB3MUhzK0ErbXZSVUpvd3hR?=
 =?utf-8?B?ZlpFWTRMd1U1WUs0WHRPc2xKTm56U05FNmh4VHhuL2ZkV1h5U1NqT3lIc1o5?=
 =?utf-8?Q?esoeQsKe/18KU1do9t6z6CJvXl/Rl+vwpTCCk8E2jY=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcd66a4-4dc5-4680-cbbb-08d9ceb4ef0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:31:15.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDfml2g6XrsUrILCE+nluITVmA7OmUZIEG9eEHT8JijsFtYiVQ3Ovvx4pDhKbwGxEw5h7wqO+GpihiyoEIrUAulWfVtEfHWX7yNc/ekCqX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4254
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>From: Elijah Newren <newren@gmail.com>
>
>When running `git merge-tree --real`, we previously would only return an
>exit status reflecting the cleanness of a merge, and print out the
>toplevel tree of the resulting merge.  Merges also have informational
>messages, ("Auto-merging <PATH>", "CONFLICT (content): ...", "CONFLICT
>(file/directory)", etc.)  In fact, when non-content conflicts occur
>(such as file/directory, modify/delete, add/add with differing modes,
>rename/rename (1to2), etc.), these informational messages are often the
>only notification since these conflicts are not representable in the
>contents of the file.
>
>Add a --messages option which names a file so that callers can request
>these messages be recorded somewhere.
>
>Signed-off-by: Elijah Newren <newren@gmail.com>
>---
> Documentation/git-merge-tree.txt |  6 ++++--
> builtin/merge-tree.c             | 18 ++++++++++++++++--
> t/t4301-merge-tree-real.sh       | 18 ++++++++++++++++++
> 3 files changed, 38 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
>index 5823938937f..4d5857b390b 100644
>--- a/Documentation/git-merge-tree.txt
>+++ b/Documentation/git-merge-tree.txt
>@@ -9,7 +9,7 @@ git-merge-tree - Perform merge without touching index or working tree
> SYNOPSIS
> --------
> [verse]
>-'git merge-tree' --real <branch1> <branch2>
>+'git merge-tree' --real [--messages=<file>] <branch1> <branch2>
> 'git merge-tree' <base-tree> <branch1> <branch2>
>
> DESCRIPTION
>@@ -21,7 +21,9 @@ The first form will merge the two branches, doing a full recursive
> merge with rename detection.  If the merge is clean, the exit status
> will be `0`, and if the merge has conflicts, the exit status will be
> `1`.  The output will consist solely of the resulting toplevel tree
>-(which may have files including conflict markers).
>+(which may have files including conflict markers).  With `--messages`,
>+it will write any informational messages (such as "Auto-merging
>+<path>" and conflict notices) to the given file.
>
> The second form is meant for backward compatibility and will only do a
> trival merge.  It reads three tree-ish, and outputs trivial merge
>diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
>index c5757bed5bb..47deef0b199 100644
>--- a/builtin/merge-tree.c
>+++ b/builtin/merge-tree.c
>@@ -389,6 +389,7 @@ static int trivial_merge(const char *base,
>
> struct merge_tree_options {
> 	int real;
>+	char *messages_file;
> };
>
> static int real_merge(struct merge_tree_options *o,
>@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
> 	 */
>
> 	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
>+
>+	if (o->messages_file) {
>+		FILE *fp = xfopen(o->messages_file, "w");
>+		merge_display_update_messages(&opt, &result, fp);
>+		fclose(fp);

I don't know enough about how merge-ort works internally, but it looks to me
like at this point the merge already happened and we just didn't clean up 
(finalize) yet. It feels wrong to die() at this point just because we can't 
open messages_file.

>+	}
> 	printf("%s\n", oid_to_hex(&result.tree->object.oid));
>-	merge_switch_to_result(&opt, NULL, &result, 0, 0);
>+
>+	merge_finalize(&opt, &result);
> 	return result.clean ? 0 : 1;
> }
>
>@@ -451,15 +459,18 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> {
> 	struct merge_tree_options o = { 0 };
> 	int expected_remaining_argc;
>+	int original_argc;
>
> 	const char * const merge_tree_usage[] = {
>-		N_("git merge-tree --real <branch1> <branch2>"),
>+		N_("git merge-tree --real [<options>] <branch1> <branch2>"),
> 		N_("git merge-tree <base-tree> <branch1> <branch2>"),
> 		NULL
> 	};
> 	struct option mt_options[] = {
> 		OPT_BOOL(0, "real", &o.real,
> 			 N_("do a real merge instead of a trivial merge")),
>+		OPT_STRING(0, "messages", &o.messages_file, N_("file"),
>+			   N_("filename to write informational/conflict messages to")),
> 		OPT_END()
> 	};
>
>@@ -468,8 +479,11 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
> 		usage_with_options(merge_tree_usage, mt_options);
>
> 	/* Parse arguments */
>+	original_argc = argc;
> 	argc = parse_options(argc, argv, prefix, mt_options,
> 			     merge_tree_usage, 0);
>+	if (!o.real && original_argc < argc)
>+		die(_("--real must be specified if any other options are"));
> 	expected_remaining_argc = (o.real ? 2 : 3);
> 	if (argc != expected_remaining_argc)
> 		usage_with_options(merge_tree_usage, mt_options);
>diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
>index 9fb617ccc7f..42218cdc019 100755
>--- a/t/t4301-merge-tree-real.sh
>+++ b/t/t4301-merge-tree-real.sh
>@@ -78,4 +78,22 @@ test_expect_success 'Barf on too many arguments' '
> 	grep "^usage: git merge-tree" expect
> '
>
>+test_expect_success '--messages gives us the conflict notices and such' '
>+	test_must_fail git merge-tree --real --messages=MSG_FILE side1 side2 &&
>+
>+	# Expected results:
>+	#   "greeting" should merge with conflicts
>+	#   "numbers" should merge cleanly
>+	#   "whatever" has *both* a modify/delete and a file/directory conflict
>+	cat <<-EOF >expect &&
>+	Auto-merging greeting
>+	CONFLICT (content): Merge conflict in greeting
>+	Auto-merging numbers
>+	CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
>+	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
>+	EOF
>+
>+	test_cmp expect MSG_FILE
>+'
>+
> test_done
>-- 
>gitgitgadget
>
