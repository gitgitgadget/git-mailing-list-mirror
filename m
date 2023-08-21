Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829BEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 12:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjHUMhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjHUMhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 08:37:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2083.outbound.protection.outlook.com [40.107.6.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C496BE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 05:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEN5smyATi6BMgp+2u8tAtIdfps0T6R1ofQ/MCw4L1LiGnmwj5tweL0VSjeXduPlaqqfuoODhFwRwRPzqn8Qz7zBMe1Kk+fUR6eDJiPJXGKx5b3HlhUJokdjcC99uxhZ+zy/NN1Zm31AJFGROVEDZdPBBHpJOhjhB4bDWhiAuoJx55b6//GP1kbTsd8yGX5r+9S78rMRs1fbAnnpFuswT13txpkTqNBmhuE273yyBS4pjWv/74MQ0d5qPKjRr5FzyO93SRjImxhfFpDLLRqjk4eoSm247fSL8OgUrwBbpEWPCwXeP/FqcjKmP3egplJpgrH9ep5Uz/9eO4zjSMxJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7SFgWMCq6/LuxF0dApFx5bOOUYEWE8D+YElL8psB54=;
 b=SwfWcgMyHhBkQybDZ0M7gjqErbQ7kLkCTBSEKPM9sTcSwfMgnzdPG21H1kXq1fDox/vMa2xqIxgEZYMPM4JzJ6dLJCw+yWcSTiyFv6WS56iM212mgyvXfR/hbCnyrj6u0oMsZ4pMgmp7uOKizbK+8qmxPQHLcg/Q1YoIsaG6Hol7MHwggZqa3zSAxkjldk6rL5SL/2tT/K/iLXRffLOfVF+MzdDGrdBtNHyPJw3dVrJchjiMo2PO8BQ8dJlEcQ6mizmrJ+xE428iyX1jeKXvUVvsjkZaeb246RsUm45DLvNds/WT3/3yy0NmJMiMlqKFP7HbCYfOLdsRJXQ0GSD6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7SFgWMCq6/LuxF0dApFx5bOOUYEWE8D+YElL8psB54=;
 b=q/itahNErmL/t5/oOvxklh+y8w4VcYkUFz0aH5vyCRd7UQs7XBjNI77g+V62dKHqMwj3xwLRbc65X5ZowBJCzzJs5gn29QJhBCR88wYLrCpt792+HikMVOBzQuH9pT0mZX+m5P8Th2QSa4RaQXVYgBFB/+kYHHWHTP0HpebARNUBuHcBohX3h0ySGJ+Q9iPHUYj6+UVPS4b29++uxK/xmexQnzlhcKWdI7rzU1cJNFmCHf7ZieeRXWvae04Uuvp4Grw027ytFiYhFBslmElPFSLSxcotodMqnZVrTTuzlKHI+UIwGxAA80oiMOc9A8ph5lXTfVpkYQQUDRDYr6wc/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::10)
 by PA4PR10MB7938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:37:12 +0000
Received: from PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2dfd:85ea:13f:b6af]) by PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2dfd:85ea:13f:b6af%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 12:37:12 +0000
Message-ID: <627378df-4655-4a8a-abcb-c15ab6602101@siemens.com>
Date:   Mon, 21 Aug 2023 14:37:09 +0200
User-Agent: Thunderbird Daily
Content-Language: en-US
To:     git@vger.kernel.org
From:   "Osipov, Michael (IN IT IN)" <michael.osipov@siemens.com>
Subject: [REGRESSION] cache.h in 2.41.0 uses undefined macros DT_*
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::18) To PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:300::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR10MB7035:EE_|PA4PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 163b13be-51f8-47ed-0750-08dba24357b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhsuVBAZNqDr9FgcDgaMhep6aO6yLa6bW+x4dYZu4qCRiXUsTMFrevDFBvH191tUg8n9MfqHJh55Jkv3X9rURctspJrgbtr4pPLiT9H4x0McTZ3dhgRmLU3NwRbVjOEp9976E5l95VUnm5fp5As6mVJBx6/UZCZkQ6n5tYmJ1UU39dbvz2C1WXWA3mnZb+I2JZCxxfqkM3T6M4Jm8lKTtjKuUX87ZWV06MyLCKaSSc0e8yQEDeim97oY3m6DlpknpLdCnayYxAJreEEMnIQHA1JSnBeYE0uNSs/yef+VMZLPHQ8bsDyN28FOKA2BdV7rPTJYuY2ii8Ac9EgkkAlzdaDcxPne9wMWjmRBOb6DpahR868y+PjBBqaJ84OOSZgntQyOa8Mh6ShJI078fcLQG2f1+e3a1r8WckNLnDYBCmfCUDLPyYUuZzCgqzhMUN+tqf82kqaAvH1VBNR3bw5M+ADu6DfpcYj4EnbWDD/kY2bpVFvQM5SBRRYe5kbCuUegbvUhZeUQwA0XxYPFv/S3p0g9vcXNdRf726jZeBN5PJHGmDVdYbFVZrcHI5W6gzmotuZzcaqpuimZbuVcAa6oIyBDClCNcT8UbdMHohx7imPmR1c5YpApcxxwXnAqDK3IVAAeBOLcRZhR40gSMkLrOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(31686004)(86362001)(82960400001)(31696002)(36756003)(478600001)(66946007)(66556008)(6916009)(66476007)(316002)(966005)(41300700001)(38100700002)(6506007)(6486002)(26005)(6666004)(6512007)(8676002)(2906002)(5660300002)(2616005)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXRNTWlqdHZZZ1dkOW1FbEd0eEthUkc4K1ZqS01HcUlTYlB4VU16NXRKZFpv?=
 =?utf-8?B?UUVjYmppdzlZdSswb25panI5aWNVRm1kREMzZlNvY0dJZlVUMnJKTEltRXpu?=
 =?utf-8?B?MS9ob2Fkek9CNms5MVpHK1FJL3lERExkeG90bGg5Rk4rM2hQQkxReTIvY1ZR?=
 =?utf-8?B?NXpZZmhDcnVPQjJNUFB6U3dQUmtENTdmVVZwRmZwaklLNGQ5UU5DaWN3Nndh?=
 =?utf-8?B?UkhLL3lKcVY0NVZqNVdKYnM1MXhOQVY1ekQxbFk3U0RlR2c3M0NFU0RDKzJM?=
 =?utf-8?B?TFNSOUdDcjhhS0sweHduaEFqNGl2Q1g1aGhwZlMvc3diNm5oUm9WVFlKUFE3?=
 =?utf-8?B?OCsvUytJL3hMZmdKTFdkcEVsb3pJSmFwMlRJY2FDMU44cUNtdWd3c2xoWGt0?=
 =?utf-8?B?TkJQbHBFS29KcWMzZVB0ZW42UTR1REkyaGhJejNPTkp0OGxQcEx1VXF1U1Rh?=
 =?utf-8?B?U21RRUtLSGo1K0cxcWxYdGRJOG9Bd08wVzFveEh2dTVNZ1dXS3dJdmVFaUpI?=
 =?utf-8?B?dDZPMjFQL1U3TzQ2M3JwUWtKTjNZQys2ampGRXhTVktobUNZL2g0Y0pPaEdy?=
 =?utf-8?B?UXFjcllLalJrUEVodXVoYUcyOHZLMjJWOEJSbDBranJzTGVvMmxzcFlvVmho?=
 =?utf-8?B?NFdubUJJZVRRZThZM1JiUHpoakxCeS90SzQ5bllVZXFJWDl4YlpleDU5RGxC?=
 =?utf-8?B?UG96QzBsNmtUV1hVSENiM3h1bUZaMzdnbWFSMjhJVkNHWFhsZHNQNVBXYXlY?=
 =?utf-8?B?MTBZbFk2emhvVkp4eUU2YzU1bk4zYW1aUjg0Y1RJZ2o4bUNManVaS3FwVExz?=
 =?utf-8?B?cVRFaHJmZklYOER0QjJnRjQyQUdBMjNmTkFWOFkzanhxS3lzT3hOMU4wUXps?=
 =?utf-8?B?SUlpY29TQXM3T201eXkrY1FHZ0dZWSs2RjVHM3RxQi9ISWZXTllKeVRNNDJM?=
 =?utf-8?B?QnlKU0thcTJLZUpoNWdLZGYrSGhWRnJLTWR1dytHYVVMTW9pSE8rOHlMcXFR?=
 =?utf-8?B?M0hVaTBJL01LcHNHektMUFRCK1d4M2dSZEhQMHhTUUthRmFiK2o3ZmpUdS8y?=
 =?utf-8?B?anRtS3VCc0IyUHZXM1ZXWXRiMWFoNTVEU2VDSUxTS0ZZNE9ZNi9JS1hRN2ow?=
 =?utf-8?B?dGxDcEpRRFFPN2tLS2xNaUtmZVpGT20xaXhQeHFOa0V4cUl1a0Y3aDRXenZx?=
 =?utf-8?B?Z3VLb2Z1YVMzb3dWVm1QWFpLb281VEpyOS9wVUw0MWtnNDlTVStQalU1Y2pM?=
 =?utf-8?B?ZVlHR3pHVzBXTUowa2ZtOU5wNU91Z1pEckJIU013aWhPYlYrVzdvNnd3OWI1?=
 =?utf-8?B?SStieXM0ckQ3R2pCaVV6dHk2RFJSWkwxaWIvMUsyazIyVEd3VUhFZ0JHUzNy?=
 =?utf-8?B?RjNUU05SdnFaMGx6UjFMVWxqenRyRGk5NGxmeEwwbEpIL1d3Nk1CbU1LNHF3?=
 =?utf-8?B?TjAyeWl0MzFkTU84WUdCaHROK2JJK3BtYTJQaXowOXc1WUlLQWg4ZHpwTWZW?=
 =?utf-8?B?VUVPWi85SlVGVWhjS0h0N0QzaGowWkxrSmZTOWVwckcrV08rSHRPZUpOV1c4?=
 =?utf-8?B?T2JTei9POW9oaUlDOTdYV2MxRnVXOWxZM2pDbTBRUmh4MDg2MStPTFdpVFc5?=
 =?utf-8?B?MGNlMXd3dUF1Y3FFTTFvN05xSmlyaFEvQnhDbm0wWll1VFEzaGVDLy9Sa3pj?=
 =?utf-8?B?Kzkwd3F0bnc1VU1peDIvdGRJNUZUWGF4OGVHSGViaVN3SnE3Yi9mWEZrTFpR?=
 =?utf-8?B?ZUJPMjExUzFhSU84YmNtUnZrbEpIVGNoQlhQUjFiUnhwNitObUNKUi9CQW84?=
 =?utf-8?B?OU12aUE2M0hZNlFtaUZSbVBpaXE0QXFQek40OEFpOUV4UVpER00xL2ZFYnJ4?=
 =?utf-8?B?VXoxTVdHTk9WcDVXa1ExRkV0dEFRV2hJL25rTEZZekM0MjBZYzBUL0w0R2Fy?=
 =?utf-8?B?VEFuczhpKzBVajJWV0YxRTQrUmJKK1R6Z001S0hzV2xFc0h2ZkNWajNINm9X?=
 =?utf-8?B?R2JtOVdsdEVYYjJaYUJHQWorR1Uyc2pWMDRkWUp0a2RTZTdDTmpWQmtmc1Jl?=
 =?utf-8?B?RlN0TTVFWENUQ0UwOXErSWRWOGI4Tk40RzZ4Zm5aV3I2SHk0RDVJc1djV2Y0?=
 =?utf-8?B?ckg3dlBDcDhtS2lxQ3UvV1VvOUw0djR1N04zdm5CRVAzMkFZTGpaTnpkZm9I?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163b13be-51f8-47ed-0750-08dba24357b2
X-MS-Exchange-CrossTenant-AuthSource: PAVPR10MB7035.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:37:12.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiTCjeBFYaLbihJH/UNWQIfGNaYte+bthlzOHTAqSWNEbQTsfENIYrgSYO4OJJaK55DsjeFZKulCKCcyMv0i36IlMo0BmJLWD7J7DbPayfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7938
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Folks,

I am migrating from 2.37.1 to 2.41.0 on HP-UX. My compiler gives me the 
following:
> "cache.h", line 147: error #2020: identifier "DT_REG" is undefined
>                 return DT_REG;
>                        ^
> 
> "cache.h", line 149: error #2020: identifier "DT_DIR" is undefined
>                 return DT_DIR;
>                        ^
> 
> "cache.h", line 151: error #2020: identifier "DT_LNK" is undefined
>                 return DT_LNK;
>                        ^
> 
> "cache.h", line 153: error #2020: identifier "DT_UNKNOWN" is undefined
>                 return DT_UNKNOWN;
>                        ^
> 
> 4 errors detected in the compilation of "add-interactive.c".
> gmake: *** [Makefile:2715: add-interactive.o] Error 2

HP-Ux does not define these non-POSIX [1] macros while dir.h perfectly 
defines them. Tried from 2.40.0 tarball and it works flawlessly. So 
looking at [2] it is an oversight when treewide header cleanups have 
been performed. Including dir.h in cache.h does not work because it will 
cause duplicate definition of struct dir_entry.

For now, I did:
> diff -u -ur cache.h cache.h
> --- cache.h	2023-06-01 09:03:05 +0200
> +++ cache.h	2023-08-21 11:24:07 +0200
> @@ -91,6 +91,20 @@
>  struct pathspec;
>  struct tree;
>  
> +#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
> +#define DTYPE(de)	((de)->d_type)
> +#else
> +#undef DT_UNKNOWN
> +#undef DT_DIR
> +#undef DT_REG
> +#undef DT_LNK
> +#define DT_UNKNOWN	0
> +#define DT_DIR		1
> +#define DT_REG		2
> +#define DT_LNK		3
> +#define DTYPE(de)	DT_UNKNOWN
> +#endif
> +
>  /*
>   * Copy the sha1 and stat state of a cache entry from one to
>   * another. But we never change the name, or the hash state!

which is not a solution because this duplicates this block. Maybe a new 
header file should contain these cross-used macros?

At least git now compiles and works flawlessly for me on HP-UX.

Regards,

Michael

[1] https://stackoverflow.com/a/46694526/696632
[2] https://github.com/git/git/compare/v2.40.0...v2.41.0
