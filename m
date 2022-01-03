Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC442C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiACMfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 07:35:43 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:45376
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229566AbiACMfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 07:35:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXZ3rgFIz/Q4xLLmZihS77V7Wb6JN/s3R46Sa2zLyNUG26bK9CAQea7E0xJ5doOERk2/Iua8tnK3jQKPuFBd/hjF8s13uY5F0XIi0b4gk2mg4AiqIrAf155hJIXqK7o2AXspqVZHoJQVhmJ93wZS423wJ5ZexAwC9rjl50VXRr4yBjBTNMFpf6YH1DY6OLiLpV60ljJByp7O8xbMcr+1GxAke14IiGlxb+ZVAjArP2ASwP1J8vjq2Y3O3g9WnNNkPjOPqPaRu/ZbGMnuyiTtW4FrD9O75GWzy+M7SVvGmaj6jfUerYqiUIdexlewrV7Sd8Od3kBCJuHoDSH1OIDG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BySr4IzQIw+YELeaLuEMdiQZbHibJRXowbTCiNSXTTY=;
 b=LqDFUXSVpwxXBcyHPXcph6PylfnsUcJ23c8mf5i9V4W07e1WWI5hlhDB5A5nFLBPpV+ohSpDLQo6pzNxc1VvuvYPa+Dry0mXJI9G1v/vmnb03eCiJnxnF30dBsJ+txP+P3IM1ZcyOEoUSDODLDXg39huPUu7HfM3V9FoBBsoYYbLBjDtEev3JEN9YNY4URSks2ow+tXqdT9SFOR2nRDYJ7zzzZ+LzEwhn0NMqmM0DU+uXOBve0s5AXEAFLnBeIPAIxUroUCeUYN2DC4wKPCU+2JPZosQ0IfRoD/4nG5kN4e1Nrwu6XgStcY5d9ghQ2KVggBSBLlw13E5gWSsw5pL4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BySr4IzQIw+YELeaLuEMdiQZbHibJRXowbTCiNSXTTY=;
 b=WyJs1hN56Sg75UZNPKur2D6l/PR9QjvbCmuLN5QMh7amdI8ZOf9TocnHyN0XXa2FrXSed3kg+sQdo0aAW3CnK/vccS494XkZAHRP4/bexo99tFk1qzP9CddoWg3FE5+Q8NCGTdMT9iqaNsWzPyuXQ44gUMdtdYg96UuUTl53GCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 12:35:40 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 12:35:40 +0000
Date:   Mon, 3 Jan 2022 13:35:39 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
Message-ID: <20220103123539.kldjq3hrcagqjzwc@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
X-ClientProxiedBy: AS9PR06CA0272.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::10) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d78bd6-367e-43d1-186c-08d9ceb58cf7
X-MS-TrafficTypeDiagnostic: PAXPR10MB4890:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4890357824303BE84FF9FA0CB6499@PAXPR10MB4890.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0GcxciosIVqab+Du0t9MrpS10jnxEsDId/AXlFw5xgRnTIKF/9LMlU1JZo+ZR7T5XXefH1Y2D1RwGIDqIOgEdAhyksdU0X1kZlmuuI5vlIUY3GtE3ZqqZjWnN3D7wm8A8dWkKyuFDDQhLmyGLmrFKuMnkQpwNXvvse9B9TYMDeFGLQLC1BZXW5g06smR6XP6cC6C4+OCEsfbb9Rhabv3rA6rqj1DKLsnjuYkAzdFsEr7sS1PThxfOpCvlT7u4IxrIUZnk66vR9bughkfWtJ0IekY2SHaf2eDl6AewkEcO7Poh3moakWfZEMKPUwpMWFn5j1emMBkr9CZy0w4+a3eW/2Xs3hooE8+aP97rrBoCfap8vu3AwECeSrula292nb+Uws8Uha7fOqlEK49ZYhE+NWX69ypLpZQ2r429Au4p1sQGc6KQd+MABrZttDm0po+QbbV+KuhMDSTELXTlIXhKcnEvf9FyLnqAutTntAM2z6qpc0FPj1V2ieVky1GPUMNHYAfcDeSUgktyOjalSP7XCA7lxjj9/rSGv5ipwx/psPcNlga0wLUuRHfSzpjS8R++UGCUgYcnntYKjvatKMWY1w9dxFnRP9/P9NQvkkM8ON/gA0JgOw48xecVvKDbAc0P88fRPJ95ZDlRliKjbTMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(39840400004)(376002)(136003)(396003)(366004)(508600001)(38100700002)(1076003)(15650500001)(6506007)(53546011)(8676002)(8936002)(316002)(66946007)(66556008)(26005)(83380400001)(86362001)(186003)(5660300002)(6512007)(9686003)(2906002)(6486002)(66476007)(6916009)(54906003)(33716001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtkOGc2Q2pUdFk5djB2S0pJYmdLTHdTd2ZjRUVKOUoyNCtPekwvNytTUkJB?=
 =?utf-8?B?UkFkTjZPQ1piV1o0SUlRSm5QNHlVSlhWQzZSTTAxTGhXNEpVSzcvbUl0cisx?=
 =?utf-8?B?QVhMY05EM2VoUFd2cDdlNTNQREtvcFBuVkhxSGtjUHIvSGpwbTVKaDJxTnJn?=
 =?utf-8?B?eDdzQlBBV3BGWmRrZUtTZmxLME5xZXdoZmRqMXM0dGZJOHpoU1U1d29DZ3hj?=
 =?utf-8?B?OHByRDZucDQvTUVuZzNybWkwdjhVdmE2b3M4OTg0bnNJQUNBTUxCaVN0cUFQ?=
 =?utf-8?B?S245WVRXMlpGciszeUlGelVaQWpWeWtlZGplakxiaUhCZVpkeUE0Qm1uemlE?=
 =?utf-8?B?OGNxWFY3NzdIeDFaRk94OGVGc1JWbzJJbzR5OWE3WFdGMng5YVE1QVdCWGdO?=
 =?utf-8?B?M2lPcndwQVM4ZXJMYmFWRmVreXNvMGNzSnJ2dGVRcjJxZjFNMElLbGRURjN3?=
 =?utf-8?B?Z2JuUWZUNEtRS2RrOXVGTVErOUZOM2Fpcm9iZWhRU21mN2htVEpBOEhoWjhR?=
 =?utf-8?B?cGt6ZUNtSFRNaElDQ0QwQVp5RjdZRGl3SXZIcy9DT1ZPODZ2VkNoOEx4MmU0?=
 =?utf-8?B?YXVLTUwzeE9peUJrQzhrai9XdXltR3UrZFNJZEh1RkkxV1NyaXVOd25NNkoy?=
 =?utf-8?B?Z1IxWkp6eWhyVitCa1FlZkVYanJ2djNzUVFqVnVvUVVscXY0RU5ZL1UraFNL?=
 =?utf-8?B?VTRaRktKZHJPbE9hMnhqa2QxQXNtVDNJT3gzNlBQQmZyYVZSU1JnTjNVN01X?=
 =?utf-8?B?RkhLTXpZb01LVm9JeUo2eUtjZmJZaFBZL3RQSWVXYk05M3NQNUFvYmZ1eVVR?=
 =?utf-8?B?REJ3Q002YmdqVy9NYTF3UmM4NTJuZHhWaTE1cmY4Y0lNN0JybmdRSldBc3dk?=
 =?utf-8?B?amU3WEduSThVNkYvUFQzU0hxL2ZVS2wyQnpBdWpNbkxxUUE0WmZ0M3RIN1Jp?=
 =?utf-8?B?NVYzOHViR2lTTFlxc2crMXEvWHAwZXBTTTdCem1FMGFCaGJvdWtCM05jSzJx?=
 =?utf-8?B?dTFObnBhU3dOcUJLM3hORHJLMi9KSGQzWVFVbmk4eDM3QVloUitOSGx6YkI1?=
 =?utf-8?B?VHI2c0hsbmlHbk00cEhibUtoc1hFVjFwdjJic0s3YXBWcHQwN3l0bXU4SnlT?=
 =?utf-8?B?c1JvRjNvV0w5M09YMXAzaXFvclVPelVLeGRMS0FYYmU4U3AzdjNMejRrMWUr?=
 =?utf-8?B?VndQYTk4M2RuODRVcnR2RWtwQVF5RDN4WmVjdG1Ta2d1VEtxWVZUR0RSV011?=
 =?utf-8?B?VjhvU2tibHJjN2xscTd1Y1JpS0llOEY2MTYzNyt5amc5enp6Rk03L2tITW16?=
 =?utf-8?B?L2YyZktNSGxkS0FHMmlNdmZ0eWlkUVlOUUozYThvZTlIbG5UZnVDaS9pME92?=
 =?utf-8?B?Y3ZjZ0NaVmtlcXRFeDBwdFVKQkpySTNvYmM5SERHODBNNmxKSTRxVVBVQXpl?=
 =?utf-8?B?UldwcERpM0FxMjFaQkpqR0VSSWdoNTZINTdrOU5pcFk4eXVaVWhCOTIyQzFH?=
 =?utf-8?B?V3RnK1dTSEpscEgxRDVoSWFFNEtXQkZ2U0dWdWdCOUtvRE02eVVpMkxjOGEx?=
 =?utf-8?B?VEEyS1pBTWdvR0RHdFkxMTdCY2UyR3Q5RGw1cUExazB3QXJYRktXdHZTQUZU?=
 =?utf-8?B?TUZrOEU3a3ZmQWxLRjlnSGpIK1NYNVRIYnFtc3BkZEMvSW5lVXk0R2hPTW1X?=
 =?utf-8?B?MjBNeE1SVzNtenUrV2ZvQ0RXdXczVEQ3MXp2UDJhSEVkaTBiMmFidjhlVDFO?=
 =?utf-8?B?RklEWWN4cVl6UkVySDVteUM0cjAyTTdtbHhJMnVnaXBPcGtpN3p1dUpwWVU5?=
 =?utf-8?B?YUk0Z1gwYU51L21CR3dxUjAydUpwQWE1UTM5R0h5OVpJZis5WFZ1K0tRTnRN?=
 =?utf-8?B?T1Uwd0w2YVp1MmZjOHJBYmVQZURiQTBGVTliblpYUHhYa1duSG1BQlRJR25v?=
 =?utf-8?B?MlhpWXJEVVpsVjc3dXZZNUM2cTdoZjdid29heFI5bU00TFIyZlpzNHdwQWU4?=
 =?utf-8?B?WXBJN3hpdElTYkhvekRVMnFJaTl4S2laTG9wMDRyaUM1MVlQZGxQQ3c4Mm9k?=
 =?utf-8?B?cS9DNjBTNkNEekNWZERiMng2RlN1dE4ybWdKSjRvRGtFdG9OUmh6Wk5jMGhY?=
 =?utf-8?B?c3VQTDRtSVVkcWdaVkZSQytJUENWMGI4VTVOdEVTOWhucFkwV2NPTUtrUlpC?=
 =?utf-8?B?dytVd3dTenFOWHorMGF4VFpVK3NON0RHaWZaV0daK1RNV0thVGNvTUVrMlZR?=
 =?utf-8?Q?+xEzqjH5O9lld4Yop5ke+zvw2fk3YBPkJstZ1ss/eI=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d78bd6-367e-43d1-186c-08d9ceb58cf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:35:39.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9JyLMAKOejP5IFToQjEfAtYwQ571CWUnBv9lxP281qWfIhlr7d42aYjekB3meTnQTHmg7zYhec4OzfJf1mzHIbBm9h21fcPzV7h5jWxVaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4890
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
>+	}

Something else I just wondered. Can the user differentiate between the die()
in xfopen() and a failed/unclean merge?
Both just exit(1) don't they?

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
