Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F8C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 16:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA3FB61246
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 16:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhDEQ6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 12:58:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhDEQ6G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 12:58:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Gmu1O076912;
        Mon, 5 Apr 2021 16:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=SiBDh+twonEZHusy4/R5ltlwNPEuMaZ4iHRBDpVEP/w=;
 b=b4OnNjMV9dddjxnQ57warg70pEHn7fkMMzwi2rEnhs+e/KjLtM8js9K4ZKzT2dg8Q/H1
 YD0jTu2HNO2FLnxJ9yLziPY1eUTbZUy+zTrXj+ut494RNmwhOxopgCET4UqwcuVXQMfK
 BqY/kmFbQiJUy373aCtkSUlZ9T6bIBkgrrG+3KMEE/HqZtfalhqStCHaagUIQlPu0Gis
 cUPEFE45+3CzIMVYzMSBqFhiEVwSinsySiTNqxUqT1JkdoS5y3XnYgEW+Qi2dogYN4SS
 UuWkPd32w0bLOpgbxDJ6Y6ElQ4/52K1eOJgocpP2RB7HMSlPnxhZUUlbILMbdzOrGZFx 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37q3f2apes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 16:57:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 135Giw8V158819;
        Mon, 5 Apr 2021 16:57:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 37q2pt575x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Apr 2021 16:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwLCSi0NYvJVGojxnkwZqNZB5nap3M7Ee3ZfVnaeaMUcA/cZeueoNzs60JNbyNz7enViQncRMqypNCTlPsWj8naeoDogr32mt/Wc0UrUT5GXrjILg+WgTHT03nlUbxfW3bODUvqpN+820tVKRiOes4cKrQ0UIavAR3dU4nOpZW+I0dO7gTSozYijM7yb+eHT1qZBqfK4aRksjilQcKthwlBObyB4gx/nOjOz8bHRYqZCg9ul2/8k2cDdObMAss67CVPNzKzfWYtIOwHkh9gv59jY4vgF0vyrmHEBlaRQa7lAw+SFVA22Iym1g/UB70m1/U/9LTCn4JP82Pc5OjYE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiBDh+twonEZHusy4/R5ltlwNPEuMaZ4iHRBDpVEP/w=;
 b=oKGZCT0Tz407zXDV+IrTQNDjIQXHUupOYLINc3Gtlqc33qe42OsW++GPVopN2ryjJmU48oOARD+GHgZg+aBgL18acolPpQgle57/+6nm3VoFCtrPuedv2dWwizCeqXJ7BOMq4Z5krJyNoSyUydFPGgmOojKLAOghuCXs/wOJEf/54IMh0ZaRUTp/97buBzuRAX5elOodNAewFHKvvGcYSUkDndG+JcW5K8A7IK2UmIVsHR6NReGCgdBffZXPjyuT+bdH50GAAfHQuvrNLn1Nadwe5aTR9XF1FHnkeZ6GpKPh6pnMVDCueRRS3oJRyW7Lx7cRyXGbrVwF08Pz4FQuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiBDh+twonEZHusy4/R5ltlwNPEuMaZ4iHRBDpVEP/w=;
 b=JilSyaNvSi4V6waIi8gF89bG9RHnHcgvqq9nWvACDN1j2Sm8rIYlCoYaLt5laXrrAtp5LemmsM8LP7y6vYqGpZ8MfVfw0ZzKCKnNKuXmdCDFxPXbCOcr7IK8wtLcKOzhBAvSgIUkfHhiAEHrqs1Ud3A/udC9meY09UwpWbD4J2U=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Mon, 5 Apr
 2021 16:57:43 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::c50b:884f:70dd:c978%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 16:57:43 +0000
Date:   Mon, 5 Apr 2021 10:57:40 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] refspec: output a refspec item
Message-ID: <20210405165740.brevvzc7hiyg2wj4@brm-x62-17.us.oracle.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e10007e1cf8ff0005295f648b9489c11a9427122.1617627856.git.gitgitgadget@gmail.com>
X-Originating-IP: [129.157.69.41]
X-ClientProxiedBy: SA0PR12CA0003.namprd12.prod.outlook.com
 (2603:10b6:806:6f::8) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brm-x62-17.us.oracle.com (129.157.69.41) by SA0PR12CA0003.namprd12.prod.outlook.com (2603:10b6:806:6f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Mon, 5 Apr 2021 16:57:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea5331be-10e2-4ab3-cf7e-08d8f853edfe
X-MS-TrafficTypeDiagnostic: BY5PR10MB4242:
X-Microsoft-Antispam-PRVS: <BY5PR10MB424217DB2A7B3553F0E5F2ECFC779@BY5PR10MB4242.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRod1M/RnYaw4SwFLrpJKHreWUbHBKoCBkrMZhZKYXSMnbd4Ni/2BTODbFMvE3ad0FIZrrxybGKFCYHhtGiGLAvtegoel201SLSnhaEWU5T2Bq1U87u91j9ZCeGqgVMUJjYfF3U0k8SYKxBcL0CmmuDbVigt+ghsm73eE0Mio/VZCVbvkuqWAhxQMDe7r1HOvFJJ0lqS4W6mZET+n/HOHr3xr6hYNKkhtAJKGzk9jExynwRkmod6cRlwfaTUSx1aN5wDOQS7OmwfXOjpFd+OHnjA4wQc8J6uI6PLB2z8sQFkngX8+TEpdrKx53btsO+97sGREfHFwNGAWE0KPSQR2JpElznReoPfa8I94OjRgvHlsY8O+d3rmCMiVq4dnFsjUfXMK/Iz/tcihIHgEar2fluvN6N5E+VYUruig4rhZ/YsqROu4ePbB1QaXNuGH0pdPwjzpmw4fLF+NoOEsTZ328CrLtJxYKhG8BHNUsyqE1lSDUNA66jxFMiKAMPQ5PuGYi72HyBBq5z9XQlgzWqQqPLS7m/JRCI07N2Wntvs1ri4wx9D795SjLUHEQn9xcGIB5XQeN5rljvxvXTB916BN0gF9kjbR0Iw/z53R/KZDSZXt/MpfKnMzcdciDuqQ2DC/D5CZtecZ743TTPtHn1FrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(39860400002)(376002)(136003)(66556008)(66476007)(8936002)(54906003)(66946007)(83380400001)(7696005)(52116002)(5660300002)(316002)(956004)(478600001)(55016002)(86362001)(26005)(45080400002)(44832011)(38100700001)(8676002)(6916009)(4326008)(1076003)(2906002)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y5GlrWabBP8rqryHXWhU/yuGXyTz6b4CVezjCDbwj3/P8fBgqVtQXvWLLkXp?=
 =?us-ascii?Q?IyrOoQXjXgNnjv0RjK0p5G1lsaxK+H37I3LePBIveqxxHNRUOo1IrGXQSj2B?=
 =?us-ascii?Q?qRHmiujgUDj/QTFQ2E+LnE8CPaRZWMYpx9oFDX3vOyOAH60REFPCvP5vrWtf?=
 =?us-ascii?Q?YSfhZWnG8azWtAEdxgSp5WfzreY3WorwWYvI+HZoKUCnQOEALSHWskOc0eZ3?=
 =?us-ascii?Q?2rc8oNUroRsFpzPMk4xvKDKoV8NEC/vunDEsJT0lbyLhGFFUFIccZVpspIQB?=
 =?us-ascii?Q?LR5n8qo70CZyyB/gNXgTx8+aSELesTqDWkRBzix6O8VzeB2eIgUo6CgSVLIH?=
 =?us-ascii?Q?LVrRZLJOdjq5nor3uOVemdhDdMxBqHSS5Wpj/zpIothEpLtHkCHLgsbQYByI?=
 =?us-ascii?Q?JYL71mIzWIj0XqIOPcQok3c36atxzIwU4rUWoDBl+DpdMKeokCp5n/CwS7JD?=
 =?us-ascii?Q?0dZyW71LExSd/0e4m+BFwaXfb1B5XfhKkxHkdrBAjX+rp1k6yt095UneRJhj?=
 =?us-ascii?Q?hkBKJE4RUydd1N5Y0Q0ThsLmrKZf7AxIg09Ncc13NFxRwv/bNncl3VpPuAW5?=
 =?us-ascii?Q?2EW/yB/4/lfKsx6N5M52CTNjILy5W5mA8fwhPswHntPf6Nnk/NMMNEduopQP?=
 =?us-ascii?Q?5T2ZnEgltVDIU8IOIc5lk63tDcSE6bbWqGUP57E7AcNZB3m/wwt5xfXxjoOn?=
 =?us-ascii?Q?4Z49vqPyftIMif7lUE0Th/UxDiP9NnTL2U1hw0c/LIqtOF/6GG5PPFQhdNby?=
 =?us-ascii?Q?BELx0xLPszzWuIpIY+/3KSZSJkQSptcd2BXxhaMJr7b5dxNiT6spBm5jXhJ/?=
 =?us-ascii?Q?Ae6/T7o4cDYDJW7Gj8hw0QvL7NueSoQDft5+Mml59007LLSKjeN38KALzpvr?=
 =?us-ascii?Q?GTs76b9g2jaHSVBllGrqKzs07Y3XX/2G+GaIfvkJxtLJhAHG/uqHpogVGgVd?=
 =?us-ascii?Q?WKWikpds7Vc/FseqMYF4bZ6GtK4/VJuDXgZ418MPs+kPSkyW8555FdW8bvy6?=
 =?us-ascii?Q?C4F2ayErXAqHp87kvrfQMb66PwEgnWmj4X1YzIT8DNgJUmJjChxT1a9fuTtA?=
 =?us-ascii?Q?c/hhIzfVrtUhDHoPOcUhrZBoyc1MtTxmi5QvuXId0zy5nKrB6vYXcDw+IAMH?=
 =?us-ascii?Q?63HUO4oJ6o+JabZ0yJt2fBhvsGap7VhOtBT1a7DajwZq26qHBYhAhsmz7GXo?=
 =?us-ascii?Q?5IcFbgWQezeQKLFkGmohWg7ZEV/xiVUJdF55IA1HBbscbVNRfp/vvNAPNGd4?=
 =?us-ascii?Q?vuvEP9aZ4p2kJOSmNwNEeh4A2f9HZHOjW6wyuA2EVvt8m9HJVURO5GLgbGSJ?=
 =?us-ascii?Q?xttNyEilWDZcOsod3pJA4YDS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5331be-10e2-4ab3-cf7e-08d8f853edfe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 16:57:43.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEqySP98BPgQGMFEF0Xc/FdwfHJuD5OWm4EzlaObsJQaYU0b/GoYHesU86/L2zSBTKxBMz+LoD/ePjMjzdOkhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050110
X-Proofpoint-GUID: jXkMI3AHaHPG_x1NJmjzz4bnrURtHXQ-
X-Proofpoint-ORIG-GUID: jXkMI3AHaHPG_x1NJmjzz4bnrURtHXQ-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9945 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104030000
 definitions=main-2104050110
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 05, 2021 at 01:04:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> Add a new method, refspec_item_format(), that takes a 'struct
> refspec_item' pointer as input and returns a string for how that refspec
> item should be written to Git's config or a subcommand, such as 'git
> fetch'.
> 
> There are several subtleties regarding special-case refspecs that can
> occur and are represented in t5511-refspec.sh. These cases will be
> explored in new tests in the following change. It requires adding a new
> test helper in order to test this format directly, so that is saved for
> a separate change to keep this one focused on the logic of the format
> method.
> 
> A future change will consume this method when translating refspecs in
> the 'prefetch' task of the 'git maintenance' builtin.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  refspec.c | 25 +++++++++++++++++++++++++
>  refspec.h |  5 +++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/refspec.c b/refspec.c
> index e3d852c0bfec..ca65ba01bfe6 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -180,6 +180,31 @@ void refspec_item_clear(struct refspec_item *item)
>  	item->exact_sha1 = 0;
>  }
>  
> +const char *refspec_item_format(const struct refspec_item *rsi)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_reset(&buf);

is this even needed?

> +
> +	if (rsi->matching)
> +		return ":";
> +
> +	if (rsi->negative)
> +		strbuf_addch(&buf, '^');
> +	else if (rsi->force)
> +		strbuf_addch(&buf, '+');
> +
> +	if (rsi->src)
> +		strbuf_addstr(&buf, rsi->src);
> +
> +	if (rsi->dst) {
> +		strbuf_addch(&buf, ':');
> +		strbuf_addstr(&buf, rsi->dst);
> +	}
> +
> +	return buf.buf;

should this be strbuf_detach?

> +}
> +
>  void refspec_init(struct refspec *rs, int fetch)
>  {
>  	memset(rs, 0, sizeof(*rs));
> diff --git a/refspec.h b/refspec.h
> index 8b79891d3218..92a312f5b4e6 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -56,6 +56,11 @@ int refspec_item_init(struct refspec_item *item, const char *refspec,
>  void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
>  			      int fetch);
>  void refspec_item_clear(struct refspec_item *item);
> +/*
> + * Output a given refspec item to a string.
> + */
> +const char *refspec_item_format(const struct refspec_item *rsi);
> +
>  void refspec_init(struct refspec *rs, int fetch);
>  void refspec_append(struct refspec *rs, const char *refspec);
>  __attribute__((format (printf,2,3)))
> -- 
> gitgitgadget
> 
