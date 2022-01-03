Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBFC433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 12:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiACMPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 07:15:32 -0500
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:61977
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229590AbiACMPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 07:15:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS/VKgrXkcnLwQjz/OQlqOXtrqO9QTLsfhFyqSstmLIIG50Ch69KESvuIlCYn1kZnbwG50pFrBOiNkIdox1WILX4xahtqeMc37JSs5TVgo+rhXKJs3K/hAoQgY3RMs6tXgIBrDrDxP/rL3WLCCza/qaDZ4kPifH7LI06ym2ay3yJ4lSRibsA7Si5sxPOgvdwd6n7CUHDN2GSE+2ogjOXCtn2uDODPQCsJisRna9DlP2cXV8EOWFuL59xtsI/V5CThO54MyVFiztcS5x0JCGYs2RTO5UyfTLsLZ3D+fmQb7gWotpp+cJYwaaJyxTbLoANyP+l2f7JR2/eKRKvhpaLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fRVQQ1v8G6c9pjpzX1q+m5knFqNWEUDPXUit6wwHf8=;
 b=DvUI0YIm7dcB/x2e7sx5Z4rok2UEGaM5ENqiZm86aVGAq5LmUv2dZyVuLeZQUmlRRfybQoHcq7O3WCftGJTGxUEe0vaAHbKIKzxN5l4jOJFctbiP8tUVrI3/h9Qe7DHW3qjIZ89EnGhvY3io0zB4MERzVPyKc/wzuZwSBXrt23DDURU/sU+DghyJ9l4eWQ2tET/zjSALq7GfjS9RMobP2sWIpr1IHtonkSaGTlo1/ytFNQzgERHTERxvIUt3liVf8Jj1dewlrFdNL2T22BHR24fYRCBK4A2SZsOv+tHDya56N9ls9VYRO2DHnrN32nVBF95wAGKCk3CnowN+YV1Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fRVQQ1v8G6c9pjpzX1q+m5knFqNWEUDPXUit6wwHf8=;
 b=asriSkvc101CimMqOjBxsp5OYJHmMStufZ+aCrAsjakbDTLO2yebairIWiqFuh1BzXl/CCnAn1fZGU7S67yPQ9+SRi3cSV7aeAdYDZFJCRj3m242FlymIlaj3FVyDDFobyXPuRx8Hdy01zk1xi0TNnOv4dOrqnGtahBfv6cbUas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3801.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:49::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 12:15:28 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 12:15:28 +0000
Date:   Mon, 3 Jan 2022 13:15:27 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/8] merge-ort: split out a separate
 display_update_messages() function
Message-ID: <20220103121527.rhgteepqvx2may2f@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <aa816e766e9eb747be466bba3b74439aadc3332b.1640927044.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <aa816e766e9eb747be466bba3b74439aadc3332b.1640927044.git.gitgitgadget@gmail.com>
X-ClientProxiedBy: AM6PR02CA0014.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::27) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b2f9b5-a17c-4680-0078-08d9ceb2bacc
X-MS-TrafficTypeDiagnostic: PR3PR10MB3801:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3801585BBF918C87298409D2B6499@PR3PR10MB3801.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:77;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Na1aG7eUZHSRLIjbuQQ6JiVgp5L5fAFO7r0PYjEyi/uBIaEEGBSXQlcTu76VBInb5NxOpQXqjWLMTKB0fOm7Q2K7SvUnosilJdEmFytSrE2twwJEgNlhi3ys1gbBAhaZzrJMSoZpEGxrCqA1ryMlYUHkWwJK0Q9reU0diVh6kolijMrg6rCGT43BE2A1LMxglgMdz1ZpOPoNXXDVarxzfQUGsKDdvi+U6FO7tjRpa6KtGUaz4l7cbyrpsbrJn6zDHQ5mi1rxCXdMX2FwhK73hQLBN+39JqghBIunwCsPOoxnbeWQWbXVnzr3mUVAHWkdei0MNaTbjSnceRAaoNjHr1uK45aBXbhUsmuGCt4RcftOAamuGs1AANHYq1IU5H8W/SptNDVWamV+uuBnCxyAqlkIhJ30ujTAAaW7V+RIO4lT7yf8rO3ghS1fu9hVp4u943IB88iuhz7gEGAniYQvMSNwuVJ1PthwJrm5I+rwXz8hJEkb2MGc3TI85jGV3TNVFYaB0s6gTEimiE0AN3P4ruo0lBMq4wJwSa9x0kah9CNmdx7FdjgL/eXm5wL6fTHGNdcPpqIvpTajkuDWbX6D4+4/ooZDX9bMXeduZCIWytK5nAHqFHIU4VqwBvfyywhPTQJxG7YOG5pnr89e75Zrjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39830400003)(366004)(376002)(396003)(346002)(136003)(66476007)(86362001)(5660300002)(8676002)(8936002)(6916009)(26005)(2906002)(54906003)(53546011)(6506007)(6486002)(66556008)(316002)(9686003)(66946007)(1076003)(4326008)(508600001)(83380400001)(33716001)(6512007)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZpRC82OXE4WFFRbmRZRXhEZ1k3c200K0N5Tm9JN04wcU8yQW9vWHJWVzNo?=
 =?utf-8?B?UHpkY1ZwQ09rLzJvYTY3Nnk2d3RBWitSRTVseml3MGc2dFViRVNnNFpRZnBJ?=
 =?utf-8?B?UGcrQ1pHZG5sTnYwRjFYUGV0TjN0d0J3UklkblNISk9nbVNtNTJaeHozWWNU?=
 =?utf-8?B?Qm5mdmhhS2pXaEd3QUlIdDlmTGJwd0thWjVxUGtPRDkzWDI3c2YvOWp3SFQ1?=
 =?utf-8?B?akxGWXBGcG4xZFR3OVZhWU1PWHpENTljNTdSeWdUellxVjFkQUp5bjZzZ1ly?=
 =?utf-8?B?N3Y4R0pUUlMwZFJJMVV4UWVFN1JlQ3NKSXMzN3VNYzJMYnVjRjV1TVlldExo?=
 =?utf-8?B?UDZ6Tlo3cnN4UUxDMzYrTEptaHVGNVBPMnFZTFB4eUo1c3NFSWplbGlkLzky?=
 =?utf-8?B?M0pXbml4UkFzaVVka2V6ck9MQmdvR1V2S0FJZzU2UTZIeEF4WC9vV3VzaEJi?=
 =?utf-8?B?RGp3U05tV001VGwvRUFQRlZoZG9kbEN1bFVFVmJxTGFkbzFIT2RiVmY4VTZs?=
 =?utf-8?B?WlRpOG9kUXdFNjJpWjAyNHI1QWduSE81RmQ4eG9MN2N3RTlPWWp4TEhxa0Ju?=
 =?utf-8?B?Sko0NGRTTTkxOC90cXMwajdxdFppNmIwbGhhaVFpcFhFeHRFWjkxV3Rtc1p6?=
 =?utf-8?B?NUQ5N0pHNVd2ZlZ0aVI4Tm9yeXBiU1U1aURJNnBpS0U4MEhYQXgzRkxGZW5X?=
 =?utf-8?B?d1d2alNOTmtpQjByVmRoWDgvNU5xQ1JvdS9pclAweTRad0JWbmkySVBiYlpG?=
 =?utf-8?B?S21IS1BYdmJCSUcrbWl2NHQ1eTFlSnk5cnZNSzJoUElYaXkvbm9MUzQxdnFs?=
 =?utf-8?B?bjN0bitZdXFma1htVU10c1M2R3hNU2pzNE1YOVAzR01CU2k0Kzh1UmJMaFY5?=
 =?utf-8?B?NEdmcWlUUG9JdnJ5MW5UYlBQRXlNdW82WVBsTjNHWlo2dXFxRWl1UHRDYWha?=
 =?utf-8?B?amIrbWppOHl3UCsrT25zdk1aUWFwblpld1pHcXhzZzRXWTNPSTZnYTY3SFVr?=
 =?utf-8?B?bk8xZkIwNW9Belh3VDEySnRZT2xlMys0WWZuL0RYQ3pBLzdjblhRLytqbmNy?=
 =?utf-8?B?RFU0clNDYU9xSHJkV2NpVWp4Y09OZWN1RmNZV1lmNE1lRzNVZ3JqNTZua3Rr?=
 =?utf-8?B?MERIRGdWUU16ZlRIWlVWYUlXc0dRczZ4aFQ5OE0ydFV3S1lXWGxTTWZ6WnlZ?=
 =?utf-8?B?NklHSHlqTnA0QVU1a3ZBUFE4MjZjQmtKRytJTzUxcnErWE9NcTFZclNjQXhh?=
 =?utf-8?B?NjZPbkRLR00xS1lza1dobzVzMUx1eHZENnRBcngwRzFXb1UwMjk3SXVnU3FV?=
 =?utf-8?B?UHJjaWZOSVFUTWdsaWZBbm02azJXbzBrRVdwZWIzUHUyNzhOYWh0clM2eitj?=
 =?utf-8?B?emhxaThuU2hrMktLMklnbFh6Wm9YSnFSZURFbjM4UkJXR3Iwa1lsdlNUSC93?=
 =?utf-8?B?WTRYdW5nb1h0YlJJeEZHYVpPOW5xT09WRTU1ZFRCVkNham05RmNSM1ZaUm5C?=
 =?utf-8?B?UEVFWXloMWRiWGh6UUIwamMzNVloa2FRZkR5YU1BTk9WQmNEY2d2QkdhNTFT?=
 =?utf-8?B?NWZoOHVtdEVkQ0tZWkd3RHNEbW50SGRlaG51N2NDM1NqWWIvb1dxZytOcGRW?=
 =?utf-8?B?Z083TVQ4TER0NWxpZlA4VlM2SUtMWlI5VnNYenFoRGI4SVk0SWtFejlJdWdm?=
 =?utf-8?B?eEVwNjBJOGViTHZUSVIwOWFyc3FDMWJxbVQ1MWJ2RkFLZHlBeGNwTzNDS1Ev?=
 =?utf-8?B?QlBxUTIvRERJbGFKRUZFUE5kUkhIRUhuemQxUjNFblEweGJGRDdqdGZVSEY0?=
 =?utf-8?B?NVZIUHZGK25vbWl6a1JHSVMzbVprVmg5QVFYdnNjWHpiQWxYdVV4Z1VmZDFL?=
 =?utf-8?B?UzFSSjNGTnVya3dRSHczT0dqbkl1clRvQ05EcmxzU0RaZE56eTM3VU1oWlZD?=
 =?utf-8?B?Q3F3ZWdzcWlPS3ppM2hSaU1nTmZpaUNzdUVqQXhiUG1JMEFtWlVFYmdoU2xt?=
 =?utf-8?B?TFQ5YVVsVG1sTGRQeFRxeEVLUDJiWVcxWnBUY1hXVFJIV2xwRjhrVzFTRWVS?=
 =?utf-8?B?bkZjbGdDUFZzeC9HVVNzZnlUMG9pc1I2WkFWdUh4RDhkai9IRDBmK0xjQVJz?=
 =?utf-8?B?WS9UQUNrQkFwV3loN0NGRUQ0aVlUeEY5aEVpVlRnZHhKcDRYNWdrN0hiZUc3?=
 =?utf-8?B?VzBCQytmUHg0UEdOV29ZOWhCanNDQSt3SzRrKzQ0anpqWFNLVkw5SkZSOTI4?=
 =?utf-8?Q?2aqSV3gBHnJeATP7ZC5XCVeXqsMaIOWd48Zv+83d2E=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2f9b5-a17c-4680-0078-08d9ceb2bacc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:15:28.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJPPHDOe9bj00LIaD/0X2v6gmrSMkvSHyQNzOLKs/1F3j2zK0cryCe0lEl685koyyJ2DOrJ6NRFZSSzwz54bHu1t7umUK9mgUkSFDFgsgFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3801
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>From: Elijah Newren <newren@gmail.com>
>
>No functional changes included in this patch; it's just a preparatory
>step in anticipation of wanting to handle the printed messages
>differently in `git merge-tree --real`.

Not quite. You are missing:
  +       if (display_update_msgs)
  +               merge_display_update_messages(opt, result, stdout);

in merge_switch_to_result(), which you added in the next commit. Not really 
relevant for the series as a whole but this commit alone breaks some 
functionality.

>
>Signed-off-by: Elijah Newren <newren@gmail.com>
>---
> merge-ort.c | 69 ++++++++++++++++++++++++++++-------------------------
> merge-ort.h |  8 +++++++
> 2 files changed, 44 insertions(+), 33 deletions(-)
>
>diff --git a/merge-ort.c b/merge-ort.c
>index 0342f104836..6237e2fb7fe 100644
>--- a/merge-ort.c
>+++ b/merge-ort.c
>@@ -4197,6 +4197,42 @@ static int record_conflicted_index_entries(struct merge_options *opt)
> 	return errs;
> }
>
>+void merge_display_update_messages(struct merge_options *opt,
>+				   struct merge_result *result)
>+{
>+	struct merge_options_internal *opti = result->priv;
>+	struct hashmap_iter iter;
>+	struct strmap_entry *e;
>+	struct string_list olist = STRING_LIST_INIT_NODUP;
>+	int i;
>+
>+	trace2_region_enter("merge", "display messages", opt->repo);
>+
>+	/* Hack to pre-allocate olist to the desired size */
>+	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
>+		   olist.alloc);
>+
>+	/* Put every entry from output into olist, then sort */
>+	strmap_for_each_entry(&opti->output, &iter, e) {
>+		string_list_append(&olist, e->key)->util = e->value;
>+	}
>+	string_list_sort(&olist);
>+
>+	/* Iterate over the items, printing them */
>+	for (i = 0; i < olist.nr; ++i) {
>+		struct strbuf *sb = olist.items[i].util;
>+
>+		printf("%s", sb->buf);
>+	}
>+	string_list_clear(&olist, 0);
>+
>+	/* Also include needed rename limit adjustment now */
>+	diff_warn_rename_limit("merge.renamelimit",
>+			       opti->renames.needed_limit, 0);
>+
>+	trace2_region_leave("merge", "display messages", opt->repo);
>+}
>+
> void merge_switch_to_result(struct merge_options *opt,
> 			    struct tree *head,
> 			    struct merge_result *result,
>@@ -4235,39 +4271,6 @@ void merge_switch_to_result(struct merge_options *opt,
> 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
> 	}
>
>-	if (display_update_msgs) {
>-		struct merge_options_internal *opti = result->priv;
>-		struct hashmap_iter iter;
>-		struct strmap_entry *e;
>-		struct string_list olist = STRING_LIST_INIT_NODUP;
>-		int i;
>-
>-		trace2_region_enter("merge", "display messages", opt->repo);
>-
>-		/* Hack to pre-allocate olist to the desired size */
>-		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
>-			   olist.alloc);
>-
>-		/* Put every entry from output into olist, then sort */
>-		strmap_for_each_entry(&opti->output, &iter, e) {
>-			string_list_append(&olist, e->key)->util = e->value;
>-		}
>-		string_list_sort(&olist);
>-
>-		/* Iterate over the items, printing them */
>-		for (i = 0; i < olist.nr; ++i) {
>-			struct strbuf *sb = olist.items[i].util;
>-
>-			printf("%s", sb->buf);
>-		}
>-		string_list_clear(&olist, 0);
>-
>-		/* Also include needed rename limit adjustment now */
>-		diff_warn_rename_limit("merge.renamelimit",
>-				       opti->renames.needed_limit, 0);
>-
>-		trace2_region_leave("merge", "display messages", opt->repo);
>-	}
>
> 	merge_finalize(opt, result);
> }
>diff --git a/merge-ort.h b/merge-ort.h
>index c011864ffeb..1b93555a60b 100644
>--- a/merge-ort.h
>+++ b/merge-ort.h
>@@ -70,6 +70,14 @@ void merge_switch_to_result(struct merge_options *opt,
> 			    int update_worktree_and_index,
> 			    int display_update_msgs);
>
>+/*
>+ * Display messages about conflicts and which files were 3-way merged.
>+ * Automatically called by merge_switch_to_result() with stream == stdout,
>+ * so only call this when bypassing merge_switch_to_result().
>+ */
>+void merge_display_update_messages(struct merge_options *opt,
>+				   struct merge_result *result);
>+
> /* Do needed cleanup when not calling merge_switch_to_result() */
> void merge_finalize(struct merge_options *opt,
> 		    struct merge_result *result);
>-- 
>gitgitgadget
>
