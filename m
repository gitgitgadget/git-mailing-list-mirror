Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96338C433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 12:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiACMZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 07:25:09 -0500
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:19218
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbiACMZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 07:25:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV4Yi7klXIf8HCzc5vALONbDAoKb6v3VmZ6nQ1Fj43eivrKrG+03UvcbqW881M0bHQnaTKAkLVR4AMTEks6MUwM0dosmAzjcV6sF5phuIvIXFd8NF0Sg4H/DlIzVU8tLkxy2p2g9IoP82b3z+zBJa8Bliax7hN3d5FmH9EZ38Evz4/OFkjzQLBAg5U9qWBjND3DfzdBqf3Du2M+VxTmU9rJiFtLeZkHkM9bO0cqhyShAeDmKGe+S6aOY13xDg/prIMgO5BJDjMilBr99dx0r17EAxSnkT45rtP1EptfDyaRyyUNZ85crAmGEggrh0RmTVbzIgvuyXZSIO34I55CkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wums0TOKvekq8cG7fsHYPhy8I+ifUqcwecCNSod33jk=;
 b=WlKOO+pfTMF3yKo3P9og1NSk9N407xqcUkiTXj6M7ubyzAdI0MjH9N7MvlDQe8WeQ7+A8WVKfrD+zr3XHO2j+fumb67610F3r/C403Unr12c9iYo4mulvJLTUSq8PaU2Z+39j05NjZcSY8e1ii3CtaIT2N7w8Bv0VaruiuQ7VhxrEQYy30vKFLGXrwuep2gSsLlspT2MI33T1Grxcgar1v5ScNGOhsUjnMbHSnAkek8DV1QHoaQURH4H8xEgHAH4/AxfSb17emS3PuD//mxjuGhf1Rc7JoJdKqq0UE1f+WTYpad7rnZGINWvx+/uvUcRO8st/1RQWZQfGSDKO5btqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wums0TOKvekq8cG7fsHYPhy8I+ifUqcwecCNSod33jk=;
 b=YSdLcJ0622j6bh5EZIyW0MgVzMNsCXnjnf3qyzURAGq4N/8adM2cQeT3avI6+G02Uif+Mb/UK9976G0BTKPawcSe9JV7JX2fkNpQC9R22O9twlJ8UfL/MiSv7lJ9y0SeaZHY24gA1fR0SpXOtydaGJ62psk+rJbGmv4RVhfScu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 12:25:06 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 12:25:06 +0000
Date:   Mon, 3 Jan 2022 13:25:05 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/8] merge-ort: split out a separate
 display_update_messages() function
Message-ID: <20220103122505.q2unvqsdjomkkurn@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <aa816e766e9eb747be466bba3b74439aadc3332b.1640927044.git.gitgitgadget@gmail.com>
 <20220103121527.rhgteepqvx2may2f@fs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220103121527.rhgteepqvx2may2f@fs>
X-ClientProxiedBy: AS9PR06CA0020.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::24) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c10b9611-90f4-4c7c-aa94-08d9ceb4135e
X-MS-TrafficTypeDiagnostic: PAXPR10MB4815:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB48159A105C63C3A79E3BD19EB6499@PAXPR10MB4815.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keBG43Tp6wF9DfVf0kee5FTN0OYkq+KLGEIQ6krb52dreoknRR9Vd8X7xc2XXsJD8se80TJWrc4/1si9Zxdc6w1skG92OigpGyRdRMAmLtkh0eXxUPU95fu3PRjrg4IrZ/qDRanIoR/Pz/Orx70k3Vp3y2U2NPZGipU2fFcy7QROO5Nhi3Q0JU0VNRvvaBkGrsdoqzx2gjqRCwtOlrtU4wVFgt9MleBFPyYaHz7D90lALkHi+HwEcLTTYp3osbeol4zFVKm6Vbrhd75csbWAS3rSUz4a+ujqucXZmNESqXDmGsQTWtTFa49R+UjAxHR3yOe3loRDvRuw1yo0K52nkjnXN7MiDbZvRS+rh4cPbXNz3LvFwA8XiaLIBtouH/fJwblcfD1d8HiWAWwxCawN/zjK7caHN8o/Xc4tqjDn9HKYAHtrM1PkUl3he7zptswMfp0y5QIpocNEF68TP/s9qsgQwbjG0G6c+X/sTQvlnNzfleeK2CcmFkndw+q2O4IifT/WiL4LrZioa0bIW94LxFidh6ypSQA0A4I9GtRAMhL/HfA0eEaaQrVHH4asH4v6DXZWJa2HNVcqkLtV3HvKXrkKKcvxUwZCNxbU93/8iCPy2WIljg9rmSTgYF1unHdmI0NNCb4CI4bIwR5bhb2fQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(376002)(136003)(39830400003)(366004)(396003)(26005)(6512007)(6916009)(9686003)(186003)(83380400001)(86362001)(5660300002)(6486002)(6506007)(8936002)(1076003)(53546011)(66556008)(66476007)(8676002)(33716001)(66946007)(38100700002)(316002)(4326008)(54906003)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVFLNFVwNDJhYmJDdHd3bzZ5Y1dQaXVpTUJTRWw2cHFCZWt6Zmt4NlJqQ3ox?=
 =?utf-8?B?OXFGY0RYY24yR1FLTW56RzQrRnc1a3dNdlRqaldkYktPSktOSllHc1RScmta?=
 =?utf-8?B?R0pWMGV0Q0MwL05CdjlPcXFEak4zQitwUW1nUGlPV2lGdi9SUTNmWGZsQkl3?=
 =?utf-8?B?eWRIVE5RVXFXV01MM2xneE9uS0Y0T3MwNUhtemlCQS9PWE9IOCtrRG9FclBt?=
 =?utf-8?B?YUlMKzRjZGd6Si9CNjJRQUpqY25ieDhob01PZ1M5OWl2aHRUM1lrSEljQkhF?=
 =?utf-8?B?ZFhMcmZNME95dGEvZjBUZXpHelp6R3VTSWdWaURnL2dRVUVFKzdXSk5VNEZL?=
 =?utf-8?B?dTRsMlI0L0JRZGpkUzNZbU9jY2dPTklFVFB3blcyQjJaUVVVOU5malowbFJx?=
 =?utf-8?B?c0tPL0F5bjV4Mmw2bVFHYVZZT29LZmNUVDRESjRUcWwxbHRRSGI4ai9taTE4?=
 =?utf-8?B?dDkwRkdqYlJUQzZJdU1GNnBBMjd3RWRRNGJySUx4RnNGZFRnUUlsSkdyV1Ex?=
 =?utf-8?B?cGZXd0pjamNNVWxjUDhpR0QrNUpIUXZpcE1iMTJGT1F3OHhCNnE2cUZuVW9z?=
 =?utf-8?B?dG8wM3pNakFqbkNnZTlSdDJsOHNTdEpSNEd6RGgzZFJybUk4QmN5c1Rvaklv?=
 =?utf-8?B?UlQ1ZlhSZ0ZqeGo0MWhZYkRhT3RwdW5oZW5Ia3hhT1N3dXZFZVZKNVZLNllF?=
 =?utf-8?B?OWpVZDE1M1k2cERVZDlxZ0RzWmlnQklNMDZ0RVpUbXNqOVpWekttaVZqL0Js?=
 =?utf-8?B?OWphTWdnRTk5amZEVkQ3djJFcjJKaWVnMTN1TExEUGpRUlJoTUJHWVc4WjdZ?=
 =?utf-8?B?SGVzbUEvV3NieUFFMlZSOUlFbGVFMzhLYU1GekdRc0JteUxuemIycUlCK2FC?=
 =?utf-8?B?K1UzYkZHRTN0aUFHeFovbmgyaVJPZ0lWV1cwUGRVaU93bnpMRzZRWjR3eWRQ?=
 =?utf-8?B?WVBObngvK2VmenBwMEhDUXN5bVF6Vmt4Zks4dHkzK2FLb2xSTDZ2eWNkd2hQ?=
 =?utf-8?B?d2JsOFR1MnJUSEdKMHRnRFBORjdFR3RkcUY4RnFSaGlZQzBYekI1QUdnWGk2?=
 =?utf-8?B?WWZxc3JnY2liZEdnT1I2K1NldndDVWJnL1N1REJ4VDBhLzdITmhmVWRCa05u?=
 =?utf-8?B?ZTcxdXNDenU3a2MwMlpRQXppamNmQVFEb09aczVJVkpQc1A4ZXhpZ3lPaVdz?=
 =?utf-8?B?N0NkSDZqVnIya0hSblVHdnU3dnFqM2VSUVpJMHNkU0cyTU0wMFJ4d3VSdW5Y?=
 =?utf-8?B?ZHFGbnZ3d3FkYzdKbS8rdFhwZHR5VmRXSmVpaFllREJCeDNNRjJwMEhEdU50?=
 =?utf-8?B?NGpZVUxrRm1NRXNmRlpSeEpBK093Y09PTjdWVGovK2xZaVNjREd0bDBCSnVi?=
 =?utf-8?B?NmhMRmQwa2Q5aTd5LzY2N1l6WTVEeFhDRkZFbWwvMHJSUmxReEMzWnRrM3dJ?=
 =?utf-8?B?VTA2ZVg3V0ZzTkZRbmJiMG1ZNTA4UTcxbTJyVlNmK0hTZE01K3ppMTdYUUxl?=
 =?utf-8?B?Uy8xak90L2hYZm5TN2RDT2xZUXdoaVpMZlgwdGVDc012ZTMzUWJVNFpubENs?=
 =?utf-8?B?c2VUNFU0TEpENUZSOXU3TjlHemMyZ0E4YUlQelFaaUdrV3g1RkhjV3B6QWpT?=
 =?utf-8?B?ajkrNy82WFQzOGpSNjloTldWZFlMVFA2WVptQTZ0eFp1dnBoZGFKN1l6eGtk?=
 =?utf-8?B?VGJnbjFUak84bFZmaDE2TFRiRjRvNElDNlpKZWduZjY4NDY5VzFaRlU0bWJj?=
 =?utf-8?B?K09iU1RnRU9NMUY5Vkk3eFB4bGhKWm1IS2IwK21ZOHdRUmRrbE9PMngrR2g4?=
 =?utf-8?B?TDBZbkN1MFVJTEFvSFY1R0FNTGhaZTl1ZzVaNjZPY1BBdndLSnZ0SSs3S05S?=
 =?utf-8?B?U3hnVDB0NmpYYkFwd2p6NHRrNFB0WnVVK0NEUnBERFZBS0pUUTJxdWpQTXJZ?=
 =?utf-8?B?N3I1cGhqYTFaUFZiL0ZqSjJDbGNlOVFGc0RtVnBGMDVZbVFweERtZklSMlVC?=
 =?utf-8?B?N2hzTEF1eWEwcXhqWm42VWxBN2hqMWc1OUg1ZXE0aEZ4eHFxY0crclF4OE5r?=
 =?utf-8?B?UnNJVVlDQ0QvQXV1RWNGV3BpOFhxdWQrQjRpZ2dhdWw2ekF0eXdhNStFYU1F?=
 =?utf-8?B?bU16MU1XMzdBMjBBL2NwN2NtNlFablhXWUNpUm1lbThvOWhxZWpOZkRQRjQ2?=
 =?utf-8?B?d0JOenFnZExWTkU4alRNOVBxNXhWVHNIY3ZTYk9vNjZuVTU0MjFGd1d4d2hO?=
 =?utf-8?Q?9F3gkhm1PP9nxbvEjkXyh+YFRRm+cBqixSgI3OuW3U=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c10b9611-90f4-4c7c-aa94-08d9ceb4135e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 12:25:06.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX4f+52eEcy5b80XLHfZDj1IRNXRX+DbpIiUt7cghkP6l85JEfjSNfF+BnUY/+WtKlKuCggFVkthJLN3jS8k9xW1wR2+3TvrajVQgoUy6lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4815
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.01.2022 13:15, Fabian Stelzer wrote:
>On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>>From: Elijah Newren <newren@gmail.com>
>>
>>No functional changes included in this patch; it's just a preparatory
>>step in anticipation of wanting to handle the printed messages
>>differently in `git merge-tree --real`.
>
>Not quite. You are missing:
> +       if (display_update_msgs)
> +               merge_display_update_messages(opt, result, stdout);
>
>in merge_switch_to_result(), which you added in the next commit. Not 
>really relevant for the series as a whole but this commit alone breaks 
>some functionality.

Sorry, just saw this was already noted on the next patch.

>
>>
>>Signed-off-by: Elijah Newren <newren@gmail.com>
>>---
>>merge-ort.c | 69 ++++++++++++++++++++++++++++-------------------------
>>merge-ort.h |  8 +++++++
>>2 files changed, 44 insertions(+), 33 deletions(-)
>>
>>diff --git a/merge-ort.c b/merge-ort.c
>>index 0342f104836..6237e2fb7fe 100644
>>--- a/merge-ort.c
>>+++ b/merge-ort.c
>>@@ -4197,6 +4197,42 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>>	return errs;
>>}
>>
>>+void merge_display_update_messages(struct merge_options *opt,
>>+				   struct merge_result *result)
>>+{
>>+	struct merge_options_internal *opti = result->priv;
>>+	struct hashmap_iter iter;
>>+	struct strmap_entry *e;
>>+	struct string_list olist = STRING_LIST_INIT_NODUP;
>>+	int i;
>>+
>>+	trace2_region_enter("merge", "display messages", opt->repo);
>>+
>>+	/* Hack to pre-allocate olist to the desired size */
>>+	ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
>>+		   olist.alloc);
>>+
>>+	/* Put every entry from output into olist, then sort */
>>+	strmap_for_each_entry(&opti->output, &iter, e) {
>>+		string_list_append(&olist, e->key)->util = e->value;
>>+	}
>>+	string_list_sort(&olist);
>>+
>>+	/* Iterate over the items, printing them */
>>+	for (i = 0; i < olist.nr; ++i) {
>>+		struct strbuf *sb = olist.items[i].util;
>>+
>>+		printf("%s", sb->buf);
>>+	}
>>+	string_list_clear(&olist, 0);
>>+
>>+	/* Also include needed rename limit adjustment now */
>>+	diff_warn_rename_limit("merge.renamelimit",
>>+			       opti->renames.needed_limit, 0);
>>+
>>+	trace2_region_leave("merge", "display messages", opt->repo);
>>+}
>>+
>>void merge_switch_to_result(struct merge_options *opt,
>>			    struct tree *head,
>>			    struct merge_result *result,
>>@@ -4235,39 +4271,6 @@ void merge_switch_to_result(struct merge_options *opt,
>>		trace2_region_leave("merge", "write_auto_merge", opt->repo);
>>	}
>>
>>-	if (display_update_msgs) {
>>-		struct merge_options_internal *opti = result->priv;
>>-		struct hashmap_iter iter;
>>-		struct strmap_entry *e;
>>-		struct string_list olist = STRING_LIST_INIT_NODUP;
>>-		int i;
>>-
>>-		trace2_region_enter("merge", "display messages", opt->repo);
>>-
>>-		/* Hack to pre-allocate olist to the desired size */
>>-		ALLOC_GROW(olist.items, strmap_get_size(&opti->output),
>>-			   olist.alloc);
>>-
>>-		/* Put every entry from output into olist, then sort */
>>-		strmap_for_each_entry(&opti->output, &iter, e) {
>>-			string_list_append(&olist, e->key)->util = e->value;
>>-		}
>>-		string_list_sort(&olist);
>>-
>>-		/* Iterate over the items, printing them */
>>-		for (i = 0; i < olist.nr; ++i) {
>>-			struct strbuf *sb = olist.items[i].util;
>>-
>>-			printf("%s", sb->buf);
>>-		}
>>-		string_list_clear(&olist, 0);
>>-
>>-		/* Also include needed rename limit adjustment now */
>>-		diff_warn_rename_limit("merge.renamelimit",
>>-				       opti->renames.needed_limit, 0);
>>-
>>-		trace2_region_leave("merge", "display messages", opt->repo);
>>-	}
>>
>>	merge_finalize(opt, result);
>>}
>>diff --git a/merge-ort.h b/merge-ort.h
>>index c011864ffeb..1b93555a60b 100644
>>--- a/merge-ort.h
>>+++ b/merge-ort.h
>>@@ -70,6 +70,14 @@ void merge_switch_to_result(struct merge_options *opt,
>>			    int update_worktree_and_index,
>>			    int display_update_msgs);
>>
>>+/*
>>+ * Display messages about conflicts and which files were 3-way merged.
>>+ * Automatically called by merge_switch_to_result() with stream == stdout,
>>+ * so only call this when bypassing merge_switch_to_result().
>>+ */
>>+void merge_display_update_messages(struct merge_options *opt,
>>+				   struct merge_result *result);
>>+
>>/* Do needed cleanup when not calling merge_switch_to_result() */
>>void merge_finalize(struct merge_options *opt,
>>		    struct merge_result *result);
>>-- 
>>gitgitgadget
>>
